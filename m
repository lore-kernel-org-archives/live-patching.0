Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85679388E4B;
	Sat,  8 Aug 2026 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231124; cv=none; b=MIYrZL6QNPK04Kt0xZolNV9ePdGncIP/estcxrzwOuzTFUTaZCdHxluSTBP4ETV4jNJfE9fgfoRGv9Ph/SE8NBBv5g6yuVw9ooDuAPWblU1yiT7DHFEFP4H4Rw8S7xIMkiu3kpKHKvWmznfP1npTHExd/UBXRH771db4wIiq5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231124; c=relaxed/simple;
	bh=nhW1F5H9nmricWa4c2xy/pUK/i+6+4LecwZeRNFyQYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr+DRjsuWzEQy66ohjt9PVO8Mov+1OgVfpPYRg1lreDkO/AICXcAHQhd079ZOOLMSwBCDbj80aH9BXgJCmkdSnkUhe+S4d7LkjKyAANaV8AnNIExKMLzPCWWZXkAIlAsoiCU3zcH4j37PjrT8ESrFR8V+1M2e1WPWlX6IxlndIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/x0qMtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/x0qMtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53E91F00ACF;
	Sat,  8 Aug 2026 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231122;
	bh=cv5F15Pf+qaCXWqln8rlxWjdcGBGLL2eqdPm1KQd9iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/x0qMtRPMmE+LspRqkDVg22LrWNQ0X6pZ06IMnxqn9ytImbQtHmrN2XSbqRme0Vd
	 KubFXJWbajU1AKWP4ahphXcE8ZFa50zdbnGynsGb9WIV3h2PeyRAVb6h+Px9AQlTxs
	 aJjB/0iMfBmVAmHmeR5jGxaFjTYwZo7BF5bIp3kx4brZ6MCtP1xrL4F/lL5FByJ3/U
	 bH3znu9zPPifY2Wu377Z3D/x46BoYsLnm4WdN/kPfi2cPn7bxDEZw2OCM6lvpd3MzG
	 evxJ5wkullG+h+29Ek74nzDKRcyBrfI4DeYuPPYcbFsmFzoLvh81mtHVRvsOR+e03c
	 X78LIGV7nG+fg==
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
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 21/22] klp-build: Support cross-compilation
Date: Sat,  8 Aug 2026 16:17:25 -0700
Message-ID: <afba3774f6a8a818f899e3d04a22ac55e9cca0e2.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
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
index b311f290b1406..42fb671f1863d 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -435,6 +435,25 @@ validate_patches() {
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
@@ -465,6 +484,7 @@ do_init() {
 	validate_config
 	set_module_name
 	set_kernelversion
+	cross_compile_init
 }
 
 # Refresh the patch hunk headers, specifically the line numbers and counts.
@@ -881,7 +901,7 @@ build_patch_module() {
 	cp -f "$kmod_file" "$kmod_file.orig"
 
 	# Work around issue where slight .config change makes corrupt BTF
-	objcopy --remove-section=.BTF "$kmod_file"
+	"$OBJCOPY" --remove-section=.BTF "$kmod_file"
 
 	# Fix (and work around) linker wreckage for klp syms / relocs
 	"$OBJTOOL" klp post-link "$kmod_file" || die "objtool klp post-link failed"
-- 
2.54.0

