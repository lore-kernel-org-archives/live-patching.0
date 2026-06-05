Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768453D1CA8;
	Fri,  5 Jun 2026 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648744; cv=none; b=oGC+MMbc22vk797xiXMOuxji/KsSZaBjYRJFOQGWYiQ06RZ5VkmBgLBfAZUjLw3U/mLEYuaI9RUNqiheq35Fw7Od97WizHGnisSUvORUlqkvJdRHfhqolXRYwfMRPdvECJK052MNps+TgFn1TpwutW2k+agtZBLrJf+eABTRfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648744; c=relaxed/simple;
	bh=HMZAFegtlDqpXJRbOJmUO8rEfB438lhD1TGdmzE5mSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVM9XFrRa6QTxFr42A8gDf4oHAGFXGh3E2SUqpqDfXQVHVReVKaBxFi7vTp5SS+MGDjreup/5h7xcyi/Yc80gP/5zc5JBUMPsUbUML2MuiO10FgDBkQoIWP3pfr1qbKtKci4b/NrlojkGCmJMtNCLXQ3d/TzXj14vQExoF/Tlkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=CoR/k9kj; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="CoR/k9kj"
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D2B09200C2;
	Fri,  5 Jun 2026 08:39:00 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id AB8D420012;
	Fri,  5 Jun 2026 08:38:52 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 728D4400D5;
	Fri,  5 Jun 2026 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1780648732; bh=HMZAFegtlDqpXJRbOJmUO8rEfB438lhD1TGdmzE5mSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoR/k9kjPZDRYxqRu31UuugAQKDasD7nrfo6zx4woNry7eltJxLRqiGK11+OSMmW+
	 Lz66x09r3vU3UufGwNHxpt2Ic7bLXTMbunEggaCK0IyWMWoehePCxTRxPCyRWVP0ET
	 Og1FQFsA/sh7GTNst3TF0+7OFTTz5qQlEtTCsZrE=
Received: from avenger-XINGYAO-Series.tail8e8410.ts.net (unknown [114.246.239.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8B995406E1;
	Fri,  5 Jun 2026 08:38:43 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: dongtai.guo@linux.dev
Cc: ardb@kernel.org,
	chenhuacai@kernel.org,
	guodongtai@kylinos.cn,
	jiaxun.yang@flygoat.com,
	jikos@kernel.org,
	joe.lawrence@redhat.com,
	jpoimboe@kernel.org,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	liukexin@kylinos.cn,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	loongarch@lists.linux.dev,
	mbenes@suse.cz,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	xry111@xry111.site,
	yangtiezhu@loongson.cn
Subject: Re: [PATCH 3/8] LoongArch: Add special section entry sizes for KLP support
Date: Fri,  5 Jun 2026 16:38:39 +0800
Message-ID: <20260605083839.67474-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604065317.219777-4-dongtai.guo@linux.dev>
References: <20260604065317.219777-4-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 728D4400D5
X-Spamd-Result: default: False [2.70 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.10)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kylinos.cn,flygoat.com,redhat.com,xen0n.name,vger.kernel.org,lists.linux.dev,suse.cz,gmail.com,infradead.org,suse.com,goodmis.org,xry111.site,loongson.cn];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Hi Dongtai,

Have you actually tested your changes with LLVM?

For example:

    asm volatile(
        ".pushsection .altinstructions, \"aM\", @progbits, "
        __stringify(ALT_INSTR_SIZE) "\n\t"
        ".long 0\n\t"
        ".popsection\n\t"
    );


BTW, "awM" is dangerous, pls see how did x86 do.

And head.S doesn't need to include asm-offsets.h, it seems
stackframe.h has included it.

Thanks,
---
WangYuli
