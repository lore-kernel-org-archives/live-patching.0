Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E089429036
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893375; cv=none; b=Fxs57xZ5wB/MtJGO33C8L/QUfTEqQdcDcI9E8zcmnyM7CfU9Lm3lph8vnJJrhDPq+lYih/Kl1HLuZWU1MI5gc6j8Ct8qwPe+U8gFz/KxSPYb+sBvXn7dEyJH8We8phRYkoFt6do1mM6ABuBVE1ogu/Df2o1T9WM1PydAZi4pr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893375; c=relaxed/simple;
	bh=Gv4lC9BvcinQAa/Ch0YFAmnZsxbAsTD/Je/O7YwLvcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3mypOguKh4RAYfLviXIiMCLId9dY8+9mbkplSznxyopja9bvzbdz67fa96YcUHSPSxGb95E85Jk88Yz5EYlvF1wDb/X05nNU6XFMxeB/o82OfAUzDqXrrP3o2i3VwXEjY0GEwQDF4uaCWIndsF6MU9IlCkCD5WK7PO/bPKGs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tb9Yg+Ft; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tb9Yg+Ft"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dg8mnRfhKOXtjhnJODwnJEoqXKaAueIbRF1/0IO5Wm4=;
	b=Tb9Yg+Ftj7cpUt+/LJTOq4vkeyVaDsyy39Td8jYEqol4PGaNk+9u4G8yrB0+YgTROOWeET
	5ctg1fwY4lYaj4N2CWiqAMW1wPClBvgqpWzHvIGw1btjCPI8BORwmsaHG62VvyLyHq/5NP
	sfkabW+6WZbkBkNwbLRkOsUh5AZp/ZY=
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
	wangrui@loongson.cn,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/14] livepatch/klp-build: use -fPIC and drop direct-extern-access on LoongArch
Date: Fri, 24 Jul 2026 19:41:16 +0800
Message-ID: <20260724114128.31451-4-dongtai.guo@linux.dev>
In-Reply-To: <20260724114128.31451-1-dongtai.guo@linux.dev>
References: <20260724114128.31451-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

On LoongArch, the klp relocation machinery redirects a livepatch's
reference to a core-kernel symbol through a GOT entry. klp-build extracts
the patched function into a separate module while the referenced symbol
stays in the core kernel, so the reference must be GOT-indirect for that
redirect to work. Two default compiler behaviours defeat this and make a
loaded livepatch module fault.

The first is a same-unit global (the syscall test patches sys_newuname()
in kernel/sys.c, which reads 'uts_sem', a rw_semaphore defined in the
same file). With CONFIG_RELOCATABLE=y the kernel is built -fPIE. For
a global defined in the same unit, -fPIE emits a direct PC-relative
reference (R_LARCH_PCALA_*) and skips the GOT, while -fPIC routes it
through the GOT (R_LARCH_GOT_PC_*). Once klp-build moves the patched
function into the livepatch module, the direct reference has no GOT
slot to redirect and faults.

The second is an extern global. -mdirect-extern-access replaces GOT-based
external symbol access with direct addressing. A livepatch reference to
such a symbol then has no GOT slot to fix up, and the wrong address faults
the kernel. This optimization was added by commit 38b10b269d04
("LoongArch: Tweak CFLAGS for Clang compatibility") as a nice-to-have that
reduces GOT accesses.

For LoongArch KLP builds, keep both forms GOT-indirect:

 - Add -fPIC via KCFLAGS. -fPIE is not enough; it optimizes away the very
   GOT indirection KLP relies on.
 - Disable direct-extern-access: -mno-direct-extern-access for GCC,
   -fno-direct-access-external-data for Clang.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 scripts/livepatch/klp-build | 43 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index e83973567c87..27463def08f8 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -278,6 +278,13 @@ validate_config() {
 	[[ -x "$OBJTOOL" ]] && "$OBJTOOL" klp 2>&1 | command grep -q "not implemented" && \
 		die "objtool not built with KLP support; install xxhash-devel/libxxhash-dev (version >= 0.8) and recompile"
 
+	if [[ -v CONFIG_LOONGARCH ]]; then
+		[[ -v CONFIG_AS_HAS_EXPLICIT_RELOCS ]] ||	\
+			die "LoongArch klp-build requires CONFIG_AS_HAS_EXPLICIT_RELOCS=y"
+		[[ -v CONFIG_RELOCATABLE ]] ||			\
+			die "LoongArch klp-build requires CONFIG_RELOCATABLE=y"
+	fi
+
 	return 0
 }
 
@@ -556,6 +563,31 @@ build_kernel() {
 	local log="$TMP_DIR/build.log"
 	local cmd=()
 
+	local ARCH_KBUILD_CFLAGS_KERNEL=""
+	local ARCH_KCFLAGS=""
+
+	# For KLP, LoongArch symbol references must stay GOT-indirect so the klp
+	# relocation machinery can redirect a cross-object reference through a
+	# GOT entry.  Two default behaviours defeat that (CONFIG_RELOCATABLE and
+	# CONFIG_AS_HAS_EXPLICIT_RELOCS are checked in validate_config()):
+	#
+	#  - -fPIE (added under CONFIG_RELOCATABLE) emits a direct PC-relative
+	#    reference for a same-unit global and skips the GOT; -fPIC routes it
+	#    through the GOT.  Add -fPIC via KCFLAGS.
+	#  - -mdirect-extern-access replaces GOT access for an extern global with
+	#    direct addressing.  Disable it.
+	if [[ -v CONFIG_LOONGARCH ]]; then
+		ARCH_KCFLAGS="-fPIC"
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
@@ -581,7 +613,16 @@ build_kernel() {
 		cmd+=("-s")
 	fi
 	cmd+=("-j$JOBS")
-	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
+	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections${ARCH_KCFLAGS:+ $ARCH_KCFLAGS}")
+	# -fPIC is added for KLP via KCFLAGS above; the arch adds -fPIE via
+	# KBUILD_CFLAGS_KERNEL, which kbuild places after KCFLAGS on the
+	# built-in compile line.  -fPIC/-fPIE is last-one-wins, so -fPIE would
+	# win.  Setting KBUILD_CFLAGS_KERNEL on the command line replaces the
+	# arch value (not append), which drops -fPIE and lets -fPIC win.  Only
+	# do this when an arch needs it (LoongArch).
+	if [[ -n "$ARCH_KBUILD_CFLAGS_KERNEL" ]]; then
+		cmd+=("KBUILD_CFLAGS_KERNEL=$ARCH_KBUILD_CFLAGS_KERNEL")
+	fi
 	cmd+=("vmlinux")
 	cmd+=("modules")
 
-- 
2.53.0

