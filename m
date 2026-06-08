Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6D3BA241
	for <live-patching@vger.kernel.org>; Mon,  8 Jun 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913417; cv=none; b=FO5tVdvf4LyIAHATqqO9RH9TrduZmmZlGsG5xi1wwL2a5Nulctx8FOTrrrMlUrUukQk2rqRZsm4OIMAWOPoC6je2PYV6Qfd0PQ3w/xHthNQkPBVgtAebEqix0yx1bLcPzfsQunKuEaEpvN5+BTIJ2zSHmVZGJZBS5lUuMiba/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913417; c=relaxed/simple;
	bh=OvI7222dt3pd1EshIbEJENw5/OnwTK2o+TJyWMgUtYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcfN2UaozUyyxszWW2Yi1THAZJ9BgwAFE9kRfWbsFh3Hmzm/l52qe5OdDRX8Qo2ujU1brEOXpAqaCGSO+VIhWLVuFc90zBXC5pSaSKWkDdUciE9x/zHCPMJ+zuw4TZs6HwTQiAeSkuqQ686Ojv8XhHHcmpQxQHk3mfG8EvuBlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFFQXpI8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFFQXpI8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780913413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3PtV/wdUNwaqt62doo9rdFl9ViQ6FDPrsmGB6jLREY=;
	b=iFFQXpI80zutvKOr8UB1QRRFFgkv4WNFT61UJjQQt3cU8KSKsqN9VvqMckySJUS5hAsrxf
	uluOIBm93l1waP99t5BE/SnmJKo9/OfA3ebspeJ2pgrhXJaxXE4THwb0PJ6+VeezKTI0Uh
	0KpvctnrIKgI58InM+TC4Q6EcXp40t0=
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
Subject: [PATCH v2 5/8] LoongArch: Fix EFI linking with -fdata-sections
Date: Mon,  8 Jun 2026 18:08:49 +0800
Message-Id: <20260608100852.325413-6-dongtai.guo@linux.dev>
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

