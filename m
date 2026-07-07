Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5C41D4DA
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408996; cv=none; b=CV1B6tfsNeNybviBPf+UCcBGeeATZOQoHFEx0iSF2ZZ5gvLj+Q5xqML3eq72gr4y6xD5dmH2DLLDr/UgmR8QL+elg2MjuNC1/6raVudtEQFDU75bzL4K3WlDtpZo6TaTELx9n4p3huZzvhAQb4kN0oJgC/zm/M4vDJkFndWTYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408996; c=relaxed/simple;
	bh=S9ZliVa47d0SGAYCUBwLf9Gw+JpT5whQngWervdzPRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BG47WAlPt60OiobDvjuAcCQNNy0O5qZhCrl+6rqTPTVstT0VYsYlLm4XS0sSsaGcMAN4KQUBqZ+KLN8D+Du8pSQtFZgtO74Qf36a1BtHIqWwPNcTe51b1EuHe4aDv6azeYm178i6gilYUUReB0Wd8TkFKFJh9DY7YBHU73owOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCdO3UCz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCdO3UCz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783408985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMbW/H+GCbToYAqi5eBrRRT1/+wIz2K7Jphm3eDdq44=;
	b=qCdO3UCz4GmzV+ybQHMh34RtDao+acNknbhNe6WrfnoHKap1oFi/RwNZxD+zsPISUILVK9
	P4BcsrMqYnbvVvhEl9qsSVdPuMoVAQNbDk80PwG9MO2RYKo150tfRhwVM2Kj329Q2TNd7Z
	khORXEcewUuAZZhO9JyXz4m0y4fm9Hk=
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
Subject: [PATCH v3 09/12] LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date: Tue,  7 Jul 2026 15:20:28 +0800
Message-Id: <20260707072031.231066-10-dongtai.guo@linux.dev>
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
2.25.1

