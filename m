Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E827B343;
	Thu,  5 Mar 2026 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681522; cv=none; b=Zm/T4MqCx++HkuYOdSOp5DEYbGPUAK+NWaRlt13QRFFQU+KkPiwkyDRoHs43SrXcoAjVH9c/mgMs/0yV0WSCgc16CTVjsJrxuCy7hQ9eqWwJnhCcLw6xeKZmeyJqdwKHKsBcZKOOT5I2zG34qxcoqxdv+0BHAiC27ex6AOJpPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681522; c=relaxed/simple;
	bh=y7mJtqRMIyYxCk1D8Nsk0D/Rqo0GqzF9Z7aw/XJAZkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7gHFNt6fYcV73ZDSFLKmok/ZmBoOmw4C/H8JixhqOLGxZ7pGi2s3NUSrkDQfXaxvm9sXr/J7rosNTKcVCgiVvX1QDihHhQRs3rOSDIfPwaUPMRoVLv7Pn/4+HO7OrvoywVvM5BlGOfT7rg/pVOQs/RI7tzbYGMag20MCkajlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO4MLE0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO4MLE0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478DC2BCB6;
	Thu,  5 Mar 2026 03:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681521;
	bh=y7mJtqRMIyYxCk1D8Nsk0D/Rqo0GqzF9Z7aw/XJAZkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jO4MLE0y+XVePdzaVdE68vXz7JQqqVf+lnn4o0UVyNFosJKc2k1E4UVnCsvXs66zB
	 wB93vgw9EBaAV/YKdnEy0WtFqGkZ9EBI6gK1E5y1rJFWjh+hYJnlPVG+BdrPBPZLO6
	 6wBwyP8bbFS5AwN2jW081RF1t3neD09RgxFj/RFw8WhQFBnUpNQEOR3B+h7jUULLFN
	 jAERCQrP4fzL7B/Ll5Vkn0x8FZlJCYUpjmayqA3H1Oqh1swc/t5o523KgVUaeCAZFk
	 0hvvCMiCSGhNGQAJ6lJ39yJynMCREPTg4ce3MEX2/a6+asVgOsq0HaqBPpeJ9quA2P
	 CjcsAQuwx7pLQ==
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
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 14/14] klp-build: Support cross-compilation
Date: Wed,  4 Mar 2026 19:31:33 -0800
Message-ID: <697c09ca0a8ffd545aa875e507502f62ad983419.1772681234.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772681234.git.jpoimboe@kernel.org>
References: <cover.1772681234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for cross-compilation.  The user must export ARCH, and
either CROSS_COMPILE or LLVM.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 809e198a561d..b6c057e2120f 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -404,6 +404,14 @@ validate_patches() {
 	revert_patches
 }
 
+cross_compile_init() {
+	if [[ -v LLVM ]]; then
+		OBJCOPY=llvm-objcopy
+	else
+		OBJCOPY="${CROSS_COMPILE:-}objcopy"
+	fi
+}
+
 do_init() {
 	# We're not yet smart enough to handle anything other than in-tree
 	# builds in pwd.
@@ -420,6 +428,7 @@ do_init() {
 	validate_config
 	set_module_name
 	set_kernelversion
+	cross_compile_init
 }
 
 # Refresh the patch hunk headers, specifically the line numbers and counts.
@@ -783,7 +792,7 @@ build_patch_module() {
 	cp -f "$kmod_file" "$kmod_file.orig"
 
 	# Work around issue where slight .config change makes corrupt BTF
-	objcopy --remove-section=.BTF "$kmod_file"
+	"$OBJCOPY" --remove-section=.BTF "$kmod_file"
 
 	# Fix (and work around) linker wreckage for klp syms / relocs
 	"$SRC/tools/objtool/objtool" klp post-link "$kmod_file" || die "objtool klp post-link failed"
-- 
2.53.0

