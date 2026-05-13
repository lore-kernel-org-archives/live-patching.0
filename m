Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960E390209;
	Wed, 13 May 2026 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643298; cv=none; b=DMRnQFL0UtYYcMaZq/W9UowDmu0JSb0Dz+DbXAhVL/0P1Z+A8dRtZcLJbowy4kAShMNhYTglwIkqrtBokcpsk+MBFVnhYY5RfC5X2dIhc1p+T5GUA8HdbHSdc/8V5Qg7CndbVSGYqwIfQYqzy1IbCCKa8o7j9d1uq5MN5m8LN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643298; c=relaxed/simple;
	bh=Qd0dO/5tgykNYwWLyXzlbqJjDPv/OlwKa96fpijusbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASC0bNGEPet5D1Q74oS3CRLTWZIzlKEmC1lU4NtpGD68DA2JYlG21fBcAOH/oEczYu4Q9pTlpzIoXaZv/VN+FSo7CR3pvYN1pcFCV/U29GxsvDfX9vTyHYw8Kc/AqTAjwjolWsGxUmak5YikHa6VGpZUaB9N7tUoo5blmb0v9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezRwnLFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezRwnLFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BBDC2BCC7;
	Wed, 13 May 2026 03:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643298;
	bh=Qd0dO/5tgykNYwWLyXzlbqJjDPv/OlwKa96fpijusbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezRwnLFhhW/r1qzWrMNMdxEu2H/DqfXiJ2o4GqbWf+0lMYBwxuOqxduhE5ZEUvVoV
	 cJxTTo+ZYLnCujf7pblg6hk4GFibLqRnpO87CQm8asIkk8EAc6HQhDpewVA9Q8F2Db
	 SM/Exd57jrsCYYHoYwtyvp2Snn8PqfrdMGh9jj+DneVXyHg8hwONsjcZe4ooN+2xRZ
	 y7qeOwVxCOyLeyuyeaRIGiDz9NkSVMQPlrN7HrKnMsQdEauN4So5GSCviuU68oblCn
	 d7t9lqGJlGLg1Km+1zpF0utVYxKUZK4nYJHfx9ZSFOdLO/jVE1lcs7wwFQbGEUpzOb
	 M5KYm1BhNvC5A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 20/21] klp-build: Support cross-compilation
Date: Tue, 12 May 2026 20:34:16 -0700
Message-ID: <8e19a330a899520434cc83f7ccc434c83101ac3c.1778642121.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260513033416.tSvLgHwdPEP2FbPQu2HvVgZHLNSP8rx0GwGxB_6AzPo@z>

Add support for cross-compilation.  The user must export ARCH, and
either CROSS_COMPILE or LLVM as needed.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 911ada05673c2..e83973567c878 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -432,6 +432,25 @@ validate_patches() {
 	revert_patches
 }
 
+cross_compile_init() {
+	if [[ -v LLVM && -n "$LLVM" ]]; then
+		local prefix=""
+		local suffix=""
+
+		if [[ "$LLVM" == */ ]]; then
+			# LLVM=/path/to/bin/
+			prefix="$LLVM"
+		elif [[ "$LLVM" == -* ]]; then
+			# LLVM=-14
+			suffix="$LLVM"
+		fi
+
+		OBJCOPY="${prefix}llvm-objcopy${suffix}"
+	else
+		OBJCOPY="${CROSS_COMPILE:-}objcopy"
+	fi
+}
+
 do_init() {
 	# We're not yet smart enough to handle anything other than in-tree
 	# builds in pwd.
@@ -462,6 +481,7 @@ do_init() {
 	validate_config
 	set_module_name
 	set_kernelversion
+	cross_compile_init
 }
 
 # Refresh the patch hunk headers, specifically the line numbers and counts.
@@ -871,7 +891,7 @@ build_patch_module() {
 	cp -f "$kmod_file" "$kmod_file.orig"
 
 	# Work around issue where slight .config change makes corrupt BTF
-	objcopy --remove-section=.BTF "$kmod_file"
+	"$OBJCOPY" --remove-section=.BTF "$kmod_file"
 
 	# Fix (and work around) linker wreckage for klp syms / relocs
 	"$OBJTOOL" klp post-link "$kmod_file" || die "objtool klp post-link failed"
-- 
2.53.0

