Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF63DA7FC
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556187; cv=none; b=ZRD2LqgyFpz9yCWfmPCCCi3kZ7TqysGCZrbfp0P6ZSt9MSKQ85alLYK1TNH2h2vbBHnczHsSfiU5SVdeni4fkAblO1pfucnQmCgpf2nsN++xD5Q6PCaf8ocBGaEKdyl/ogKQIBqr/2pNcBCsmkQtGWTKne24SC0GmDaPtesr3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556187; c=relaxed/simple;
	bh=OvI7222dt3pd1EshIbEJENw5/OnwTK2o+TJyWMgUtYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wn6D/XpbKx6FSt6iNfa2qi4bc1vE/fj2eBbMFjIrQIdoAh3u2DTg4NpCnuPtXSaebVTWUrklSHdXTBfWKx1eRxaO+6S7tuVLBx6Z5B2QsEpZQl8lA17Sf0eBHldx8i5D+r1nz2gTuh2fWZx2N2bYv2Xipl2cvn7ySAVgc0vlNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KP/JsfvE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KP/JsfvE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3PtV/wdUNwaqt62doo9rdFl9ViQ6FDPrsmGB6jLREY=;
	b=KP/JsfvErPsC/GaQoq0oBJFFlGFUsWlRzRKkTnmuR5hV7TVEGWr9uupbl3Ijm9Z7MnHOMq
	3RK3uEGRtQ2GzNdA2qpeicDfI7WYXz5sGh6ouPY912yH/VCBtl/+LB3LtcbCi4S1O/nCth
	9XegMIDH9VYUsecTA7sRf+/gRqrvQEE=
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
Subject: [PATCH 6/8] LoongArch: Fix EFI linking with -fdata-sections
Date: Thu,  4 Jun 2026 14:53:15 +0800
Message-Id: <20260604065317.219777-7-dongtai.guo@linux.dev>
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

