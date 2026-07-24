Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDA42AFA0
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893392; cv=none; b=AdTFMy3qrkB+14DqXELHGFrJnMsD/QjBuQHTIhIV8ecdnS1rOIHJFvUzSQXG/ea/ZKwjobGqqCdU1UlgTNKA7/fnv1KlR/TZZnCM1p6x7NvaHNAnn6dKwqbk269iIgPNacmSDIj2nEKF+yHliJSeUa2DVbu9gq6ff2otUj8GCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893392; c=relaxed/simple;
	bh=Bb78+cO275HEQbSq6ijCG4Le87X/mYGTAx1uSh3BzgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJPqCDGBDJwLgvtJE2UK7ngPYPx+NSscu4JA7j8FOa2p9U6kTmMOzGQ602mKr9ubJiyMvKDWI9t9OZnynz3M+xpmFP5mM2C/b/IdSpGCUPOZUUY7NX2bIWL/4mhCppHyNz6j717IkHj5OQrIvskh7neN4VZn1fQVWPxmMmzk438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yuy2Gvuh; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yuy2Gvuh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOw/Zcv6a4N4ORviF7azimVASXV/RZlA1Vn92xRQ/yk=;
	b=Yuy2GvuhW6oJDgSuWJcmZomaFQ/EBi5Lhovflvk4eSVRFchbZuOE9s4JaP6WtHf1o7we9b
	A3xNOqDUUDZX6hFBlBO/08wpKcz9Y1Fq4Ivctwpu7rlmRTa48lFXgbRu9ZIHdnVDP0yQZZ
	ex5Tq/dr2bTz2aw3eLxj9as1fQnkMwo=
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
Subject: [PATCH v4 04/14] LoongArch: Fix EFI linking with -fdata-sections
Date: Fri, 24 Jul 2026 19:41:17 +0800
Message-ID: <20260724114128.31451-5-dongtai.guo@linux.dev>
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

When building with -fdata-sections, the .init.bss section gets split
up into a bunch of .init.bss.<var> sections.  Make sure they get linked
into .init.bss.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 840d944c2f73..570f936df34e 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -96,7 +96,7 @@ SECTIONS
 #endif
 
 	.init.bss : {
-		*(.init.bss)
+		*(.init.bss .init.bss.*)	/* from the EFI stub */
 	}
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__initdata_end = .;
-- 
2.53.0

