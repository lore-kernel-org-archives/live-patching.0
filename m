Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA33D4130
	for <live-patching@vger.kernel.org>; Mon,  8 Jun 2026 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913403; cv=none; b=Rdv+nCGAzdU+ei+tjCdFRafVte73g/fyNOdH7bPq7dP6h1UCfYiojz5M+9inkdvHP103LNpTVM8q1r/l4ucKAlHkLyEa9M/hv0g15tgScT7/lHbizX0p0fnQQsocw3EUxYM/eu8eXGWZh2BK1cWMXXNk96PPKJ9Nb6gYZL3NE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913403; c=relaxed/simple;
	bh=IHLYESyNMmGxuJYeJijedDOoRnGzEZCb+5sp2A7HReM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyngnTqfEem9lfQt0vRbknY2PYRs/ywHHIF9dc8HtJyoXyIOPa0S55sqsJgyI2hmmQmbxg/kYPfOyhEbS0T0wpbP6aFkAK/QrLxYG26PwB4GSvIcLLzYd7T8MIzl+dEz05u0ww+ADzzW3QQxlod+istW2x99M3lcQ9/iIg8xjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GbE2hpO5; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GbE2hpO5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780913398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/A5BoghaajR9Ddy9nspxCIBWrNoZbyGWfMB/YfIBjk=;
	b=GbE2hpO5uBjb++K8/ncNakP3P7uHBQppQ6AoXxbRG0MFBqUGfqgc83HyeCfWQ/R0He9kaQ
	/az8mV7t/QdckMY92NqRzCZkCKhZkPMFiedXi8aCptFMcGA1aXGx/kbZbo9J0+HaAldxEJ
	VHVzL0wkxVwqsjvHK2nbCqtzaa7bgNw=
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
Subject: [PATCH v2 4/8] livepatch/klp-build: build LoongArch with -fPIC to keep GOT-indirect symbol references
Date: Mon,  8 Jun 2026 18:08:48 +0800
Message-Id: <20260608100852.325413-5-dongtai.guo@linux.dev>
In-Reply-To: <20260608100852.325413-1-dongtai.guo@linux.dev>
References: <20260608100852.325413-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

On LoongArch, klp-build livepatch modules panic when a patched function
references a global defined in the same compilation unit (e.g.
SYSCALL_DEFINE1(newuname) -> 'uts_sem' in kernel/sys.c).

With CONFIG_RELOCATABLE=y the kernel is already -fPIE, so this is not
absolute addressing; the problem is GOT indirection. For a same-unit
global, -fPIE emits a direct PC-relative reference (R_LARCH_PCALA_*) and
skips the GOT, while -fPIC routes it through the GOT (R_LARCH_GOT_PC_*).
klp-build extracts the patched function into a separate module while
'uts_sem' stays in the core kernel, and the klp relocation machinery can
only redirect such a cross-object reference through a GOT entry. The
direct -fPIE reference has no GOT slot to fix up, so once the function is
relocated its target is wrong and it faults.

Force -fPIC for LoongArch KLP builds; -fPIE is not enough, as it
optimizes away the very GOT indirection KLP relies on.

This depends on the preceding patch: -fPIC is passed via KCFLAGS, but the
arch adds -fPIE via KBUILD_CFLAGS_KERNEL, which kbuild applies after
KCFLAGS (so -fPIE would win). That patch's command-line
KBUILD_CFLAGS_KERNEL= assignment replaces the arch value and drops -fPIE,
letting -fPIC take effect. The two patches must stay together.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 scripts/livepatch/klp-build | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 27fe8824ef12..42cd58aff3d8 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -557,8 +557,15 @@ build_kernel() {
 	local cmd=()
 
 	local ARCH_KBUILD_CFLAGS_KERNEL=""
+	local ARCH_KCFLAGS=""
 
 	if [[ -v CONFIG_LOONGARCH && "$CONFIG_LOONGARCH" == "y" ]]; then
+		# -fPIC replaces the kernel's -fPIE (added under CONFIG_RELOCATABLE);
+		# without that config there is no -fPIE to replace.
+		[[ "${CONFIG_RELOCATABLE:-}" == "y" ]] || \
+			die "LoongArch klp-build requires CONFIG_RELOCATABLE=y"
+		ARCH_KCFLAGS="-fPIC"
+
 		# -mdirect-extern-access only exists under explicit relocs, and this
 		# function replaces KBUILD_CFLAGS_KERNEL wholesale (safe only then;
 		# the non-explicit build puts -Wa,-mla-global-with-pcrel there).
@@ -599,8 +606,16 @@ build_kernel() {
 		cmd+=("-s")
 	fi
 	cmd+=("-j$JOBS")
-	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
-	cmd+=("KBUILD_CFLAGS_KERNEL=$ARCH_KBUILD_CFLAGS_KERNEL")
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
2.25.1

