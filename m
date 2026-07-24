Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31016DC28
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893453; cv=none; b=EdHaic6OGqSDtUPB0mAY3KTJ9rzd6C7xlGJ05j3LKnUjm2WwI4eJLhpY//0aaxuUCAhsTA9EamkMnwVffI/fm1ydSi6gLw2/eBMCNay87HD0XsogLJIHmH2a4fTV2Fkv8Qq7Bz18qnWeTcE4D5XupuFrWDFGCsbLJjvJL2MvsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893453; c=relaxed/simple;
	bh=slM7L03r6D2OjaW+kBk0O9AeKJGNMLiGB01zwBQGGbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK5gPd6CjSs6jtyI1DOt0JRtYbxo6qwtOzaPDXse91aE6GQrETgRLkXrN/k4+vslZSZ5utzmBRKRPqavY+cEGcwm2XngnBWR2bZTWZ1zkR7i0aBf7jU/L5KlC3YFPFGZrzHmS7oT4M2xEerb4QTLv4Adzokj1avs5FPc+XPnptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8O8t7cH; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8O8t7cH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6K7yvO3rVvrbt7FhGRcAwJSEYj6FUU71+bm2uI+UzLw=;
	b=o8O8t7cHGKxUHuoLeHx6f4lX3uv1xEOGhdDQjMdKfnZcSHPNQQJO75g/KfFNt3YIh4PVZ2
	BcjVIXQZa+K3qhM8tu5c5q3OSLpTLDzpjDMLse7wpDss+cXzglYk2TPgRHbO/qIvSXXcfI
	SrZn3ABwq4/RjtohaA3Yg0QZA0ibHPg=
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
Subject: [PATCH v4 08/14] LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date: Fri, 24 Jul 2026 19:41:21 +0800
Message-ID: <20260724114128.31451-9-dongtai.guo@linux.dev>
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

arch/loongarch/Makefile uses -fpatchable-function-entry=2 when
CONFIG_DYNAMIC_FTRACE is set, but nothing selects
FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY, so kbuild falls back to
FTRACE_MCOUNT_USE_RECORDMCOUNT and runs recordmcount on every object.
The pass is useless here: there are no _mcount calls to find, and the
real ftrace sites come from the __patchable_function_entries section
anyway.

It is not just wasted time.  recordmcount needs a non-weak symbol in
each text section, to use as the base of the __mcount_loc relocations
it writes (see find_secsym_ndx()).  GAS emits a section symbol for
every section, so GCC objects always have one.  Clang's integrated
assembler drops unreferenced section symbols, so a clang object must
use the function's own symbol -- but find_secsym_ndx() skips weak
symbols.  So with -ffunction-sections (which klp-build uses), a __weak
function like sched_clock is alone in its section with no usable
symbol, and recordmcount fails:

  Cannot find symbol for section 5: .text.sched_clock.
  kernel/sched/build_utility.o: failed

Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY like arm64 and riscv
do, which disables the recordmcount pass altogether.

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1dbf51ba9d6a..a1549003c871 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -88,6 +88,7 @@ config LOONGARCH
 	select CPU_PM
 	select EDAC_SUPPORT
 	select EFI
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ATOMIC64 if 32BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
-- 
2.53.0

