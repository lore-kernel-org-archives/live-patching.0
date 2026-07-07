Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBA3CB2D5
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408916; cv=none; b=u4uvIvJk/vKngtlh6HsEM1cC+VwBADYYESES4RtuLuR0qTbNkkxrKxc6dFQQjar5Qwu2GtEUQ+QV+pS3TK+jCrdSauSmAQGhGBT7Y0RawdBhvQtcnZC9QuKd7pjfW814/PsBOdx1RmNefAhyEmnkse7euSuufNd34zy0yQ+Tl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408916; c=relaxed/simple;
	bh=I7wweGcB5CSARlxeVtkmSl/MUltTaT5P5Y3tKLtR6cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0HVL+ts+XrS/Em167VKmAVS0XmTFo/9BIkRco/6RZAoG8KO7HqE29pusN4aBBIS07dAttS5aFiChsNZkoHEBfN0UTJqbXIVVdF05s99aZ533jmmL0DUTaVmMDyBArSZN0u+TLfeiZcuCO8ciuyjS5Ku8KfJnpj3CZVlYylyL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxPb0Myl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxPb0Myl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783408908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL2hSHrCK9ZvwVgc2b99wa/vjNMaGo0mhEfojEB8a7U=;
	b=PxPb0Myl/tpIpLQwEgsNEPx3T/mx5Huq9aJmMK9nU+nN3+gDo0rYkIOc8bMVhVHM9ME8tU
	kUvvc161xee1ZZ4zsgyRL/uYErIjLb7VqvoSc9r8wO4bFeTfl3XH11KdRopZ8txWP4AWJx
	kXCyK/bkCF9SkrC3CpP+EfSf7pWjvfA=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] livepatch/klp-build: disable direct-extern-access for LoongArch to fix kernel panic
Date: Tue,  7 Jul 2026 15:20:22 +0800
Message-Id: <20260707072031.231066-4-dongtai.guo@linux.dev>
In-Reply-To: <20260707072031.231066-1-dongtai.guo@linux.dev>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

On LoongArch systems, livepatch modules containing references to
EXTERNAL global variables trigger kernel panics when the core kernel is
built with the -mdirect-extern-access optimization.

Root cause:
The -mdirect-extern-access optimization replaces GOT-based external
symbol access with direct addressing for improved performance. However,
this breaks the kernel module loading mechanism, which relies on GOT
entries for proper relocation of EXTERNAL symbol references. Direct
access to global variables from livepatch modules causes invalid memory
accesses and kernel panics.

Solution:
For LoongArch klp builds, conditionally disable direct-extern-access by
adding:
- -mno-direct-extern-access for GCC builds
- -fno-direct-access-external-data for Clang builds

See also commit 38b10b269d04 ("LoongArch: Tweak CFLAGS for Clang
compatibility"), which added -mdirect-extern-access to the kernel as a
nice-to-have optimization that reduces GOT accesses.

Note this is passed as a command-line KBUILD_CFLAGS_KERNEL= assignment,
which replaces arch/loongarch/Makefile's KBUILD_CFLAGS_KERNEL wholesale
rather than appending to it. As a side effect it also drops the -fPIE
that the arch adds under CONFIG_RELOCATABLE. That is intentional and
relied upon by the next patch ("LoongArch: ... -fPIC ..."), which adds
-fPIC via KCFLAGS: kbuild applies KBUILD_CFLAGS_KERNEL after KCFLAGS for
built-in objects (see modkern_cflags in scripts/Makefile.lib), so a
retained -fPIE would otherwise win over that -fPIC. The two patches must
stay together.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 scripts/livepatch/klp-build | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index e83973567c87..27fe8824ef12 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -556,6 +556,24 @@ build_kernel() {
 	local log="$TMP_DIR/build.log"
 	local cmd=()
 
+	local ARCH_KBUILD_CFLAGS_KERNEL=""
+
+	if [[ -v CONFIG_LOONGARCH && "$CONFIG_LOONGARCH" == "y" ]]; then
+		# -mdirect-extern-access only exists under explicit relocs, and this
+		# function replaces KBUILD_CFLAGS_KERNEL wholesale (safe only then;
+		# the non-explicit build puts -Wa,-mla-global-with-pcrel there).
+		[[ "${CONFIG_AS_HAS_EXPLICIT_RELOCS:-}" == "y" ]] || \
+			die "LoongArch klp-build requires CONFIG_AS_HAS_EXPLICIT_RELOCS=y"
+
+		if [[ "${CONFIG_CC_IS_CLANG:-}" == "y" ]]; then
+			ARCH_KBUILD_CFLAGS_KERNEL="-fno-direct-access-external-data"
+		else
+			ARCH_KBUILD_CFLAGS_KERNEL="-mno-direct-extern-access"
+		fi
+
+		status "LoongArch detected: adding $ARCH_KBUILD_CFLAGS_KERNEL to KBUILD_CFLAGS_KERNEL"
+	fi
+
 	cmd=("make")
 
 	# When a patch to a kernel module references a newly created unexported
@@ -582,6 +600,7 @@ build_kernel() {
 	fi
 	cmd+=("-j$JOBS")
 	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
+	cmd+=("KBUILD_CFLAGS_KERNEL=$ARCH_KBUILD_CFLAGS_KERNEL")
 	cmd+=("vmlinux")
 	cmd+=("modules")
 
-- 
2.25.1

