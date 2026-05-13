Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2793A6B9E;
	Wed, 13 May 2026 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643283; cv=none; b=UEEZh7cGN6TzQp8oIurG+RVOz8KGxB7WVQ+UIl8y0oB64Jkns6DP5ayoqfghu/c5MwdyS1yjLg8TS8tVEIengSXYNKswLsPSqQOXnsN0o1CPuo2ZPEyOa26c0gf0JMlfL3fA3aIxV4zOud+bZhFQudYBFCwZx/oB4IZD+NODwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643283; c=relaxed/simple;
	bh=Qd0dO/5tgykNYwWLyXzlbqJjDPv/OlwKa96fpijusbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNivtRML98UaqjFOwG+1OgiXVD15PNYP+jjGMS7J4uGU5T52n47mQP9a/6aFjRcnOPesJwCNQ653D4yalTm6O7rVMd7ovXLIIL1l7WpGoScJThIO7g79/avosDFI9RaFr/Iz4Fnvd96a5oCU0iKGEORRWgU1McJwm1j9bP16tFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp/iheme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp/iheme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45683C4AF0C;
	Wed, 13 May 2026 03:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643282;
	bh=Qd0dO/5tgykNYwWLyXzlbqJjDPv/OlwKa96fpijusbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp/ihemeQ8TZAxY5dw84LiD9cr2PtFWg5Rcr9iavzkvOqCBc714dKpVMwHhNS5vlW
	 lSM5ujFvNy0R+cskXbXRJ/gLb7wmUBKKMht09Z4yalPLjagDAdFMe8/irAr/qaSy5T
	 qgIUdo2ApVlQURKtMEBLhrYy9zdudF1xxsMBzWwA1KcBFsu6c/dvr2xQZ34yJ86q2j
	 slvJuzLp51QRDMQscoPYiW3LZ4baX+5hmA+rlxihk56rrPu3ErPSeD0izn/0Pj2t24
	 nhscVW1V3ud8iavRQn1IQ+9LQrdTg0dwH9PYjIT2MlmachYfLVpvLtAgOvuPyO4jI9
	 4AlWfytK+Nhzg==
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
Date: Tue, 12 May 2026 20:33:54 -0700
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

