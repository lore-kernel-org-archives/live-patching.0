Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB43DC4DD
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556074; cv=none; b=U44QEh9EpZmvWpydpdQZxEvW8ner83kwT9bwFc5bzi1A0wiHtRu9tAuabZ5L4q9gHtlHpzcak7jrzQz/Fij4QiSrPKKt2RuVR1j6QjgcRJC9+E12R4YMJAf5Vsx8avlrAtTduJEgZou/THuVLTOcmTlWtA/8y8varJ9xK2hf8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556074; c=relaxed/simple;
	bh=CEIAnlvL0rhnO6ZzKUdVEs7J/+earQCHbO4otn4jgzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8MWkp/ZyM9V1Iybfa2123LK3d3e9DSE4Lm4PrL46+F1Acbgd8W0wzff6eNLu1GgTa+dEvd4VVuweeP9jONm02tjlC5YVDhNeDtf3KxFreT0juwPCgTAadey9SfY+gjcdIE4hR/cxTd5iTFHVVUvWohLtXZaLqBpBCEqtKqjofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i0TTT6EX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i0TTT6EX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZal1eUFT5zCvAjnUL3zj5MffVR6wFyaxSxRBYF+dwo=;
	b=i0TTT6EXqtPFUHsFVCn/SBtfpu0yFK3pTonWomD5VpGQSe8iUE8ITtZJkePGIHI8w3YgCh
	O+I2moKQ1Ma9gBTfgpLg1jMZj0LFm/AOGLY+dNi6et8p2zC0dDZSzcEpAN+4amxlghO1I9
	SRezudzNIz6C3Cu85aPphlOVWAgHUDU=
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
	xry111@xry111.site,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 1/8] LoongArch: Add livepatch build (KLP) support
Date: Thu,  4 Jun 2026 14:53:10 +0800
Message-Id: <20260604065317.219777-2-dongtai.guo@linux.dev>
In-Reply-To: <20260604065317.219777-1-dongtai.guo@linux.dev>
References: <20260604065317.219777-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

This allows automated livepatch module generation using objtool.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/Kconfig | 1 +
 tools/objtool/Makefile | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3b042dbb2c41..1dbf51ba9d6a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -159,6 +159,7 @@ config LOONGARCH
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KLP_BUILD
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 94aabeee9736..83d645675ed9 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -8,7 +8,8 @@ ifeq ($(SRCARCH),x86)
 endif
 
 ifeq ($(SRCARCH),loongarch)
-	BUILD_ORC	   := y
+	BUILD_ORC    := y
+	ARCH_HAS_KLP := y
 endif
 
 ifeq ($(SRCARCH),arm64)
-- 
2.25.1

