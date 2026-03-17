Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4793F7AB6;
	Tue, 17 Mar 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787899; cv=none; b=P435hkDywTR92GgTogDSHPBz5IwX8bqnMU72OA2T8Vk+DtNFQxbqh7TqvVYffzw+bPbGGMw76zcRgg66MpPouX/+kF219UGV7x7CJibjZee5PxX3IBzr+ffRvEr9gj8CVWyhPwvOYG0Pdt2UtAl3laH/aheFcLrQne8AZJCgepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787899; c=relaxed/simple;
	bh=zRKnFKqm2URNigcW6ZVhyMqoLzUjkp7pt41hjdX3o4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqhMOMcq6bYtPkYvHFsa1rjK/kdsqHuRQL28PRF+xHzxpdk4a1JmIZRnvvAXSHRtXgyahhmvDced9o03hKxINRnT0Uz1cBjnouX7oD0lRLftMrqcfNHKefhFfrRmUslmhXaGayxsHhISPX1gJS0TOH8z6tZOXJfNLqxUt7cwL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln2wjhQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln2wjhQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FA1C4CEF7;
	Tue, 17 Mar 2026 22:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773787899;
	bh=zRKnFKqm2URNigcW6ZVhyMqoLzUjkp7pt41hjdX3o4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ln2wjhQfxqa28dJgKDCHPfGBxeRw7EOtChpVpakFKvHrihIK+pCHDpeOJJCU3Kwg0
	 iusyhDjRSNHcR7Ruj3FDLqNg8bW2Bz6THfXuMVdfhzXG/USsY2TYeZ+0wm4caGad3i
	 KEy2cP9mhX6AtCDN/nDxitjMbMeqXEDP9vcYFiPzoZNEdfuk8Wu/FrJr1NKMTQpaIp
	 1liSaWzZ0kB1BeZgvx/+j10icge2OrRrJ6W5Qu/VcihAoZ7W1yRHoDFTNdXtcIYPv1
	 bp1t3fegO5isq2rinS8dwud8ggyGncjLw3D9Br1YVS9kkgqze48aMbZOmcQfAWSSRW
	 j3dtfKuJcutPw==
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
Subject: [PATCH v2 12/12] klp-build: Support cross-compilation
Date: Tue, 17 Mar 2026 15:51:12 -0700
Message-ID: <51f026e3ee15e2dc343f890c0dc1b926ad3d1c17.1773787568.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773787568.git.jpoimboe@kernel.org>
References: <cover.1773787568.git.jpoimboe@kernel.org>
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

