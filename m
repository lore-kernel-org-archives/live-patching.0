Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E73C2775
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408974; cv=none; b=dgwg3CIGLfGp4j2Ibrg4i2m8jh4ONZMMkr5X8k0s9eVE9Id4wDYUBNa0AwFBuF67MtO+kblxUpYnb2CwWB/gmo4vzCdyEvSUFmN027CUnZsXO/p5vhySkhbg209U3nLUejflc2WspCBhAE9cxGCT4qrsRmwWTWtNqbq8VxPkL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408974; c=relaxed/simple;
	bh=OvI7222dt3pd1EshIbEJENw5/OnwTK2o+TJyWMgUtYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awSpndmIFsc5g5U6bFb+qqQMtTdw5N/lN065M/DLpdU9PgzADVWOHcJgLURFLHPQGKwObLFic/fy4QVT0BFt3hfU8X+DRfk/XbM4Jk055C79Ijk24jxN5xfw7hnSQFFzCigf0JxYgQBcx/g5/nN4htkuei1aj8cVc+mz6aC58Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lyZghniN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lyZghniN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783408964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3PtV/wdUNwaqt62doo9rdFl9ViQ6FDPrsmGB6jLREY=;
	b=lyZghniNuv5oKni/+djF6R42b4KpSDFfaqiqzfVVx4qx2Ys1ReRT8GirINeedr+xn9EYWh
	QTJlmJcT8zanvI4ffBY3sD6r5MxLIIgivY9xVkknTK8w8tVbeRTyvi19/qrrKJljAfv5kS
	dOF8nx8//K/WdDh2HRmsx4cxhpsJfRc=
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
Subject: [PATCH v3 05/12] LoongArch: Fix EFI linking with -fdata-sections
Date: Tue,  7 Jul 2026 15:20:24 +0800
Message-Id: <20260707072031.231066-6-dongtai.guo@linux.dev>
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

When building with func-fdata-sections, the .init.bss section gets split
up into a bunch of .init.bss.<var> sections.  Make sure they get linked
into .init.data.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 840d944c2f73..dc5fa017db94 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -96,7 +96,7 @@ SECTIONS
 #endif
 
 	.init.bss : {
-		*(.init.bss)
+		*(.init.bss .init.bss.*)
 	}
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__initdata_end = .;
-- 
2.25.1

