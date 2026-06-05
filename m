Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B662F8BC0;
	Fri,  5 Jun 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649624; cv=none; b=Ijjs6A6sBDEcj3rY1VbrQyPyJV7pTC8N7x2AcdaFQ+6mYedKrHxP3cywZ2KoHbzam7WmknayHPIghvzvTB6sbNj4hP0Fg9uuMCay74+P+MXYQR3ZozsrSmfcuJd4mE1bVGnxrvCFKLz4W5FbVHows1/dqFvNvXT9+nOaSgxdl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649624; c=relaxed/simple;
	bh=NQdjqUEAflzDQ8J4WhjZ+I5NZDgNzi//G5hMzGnubSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXXmm3lDezOxOA1Ljqp0f88cF2QLLJwkJgyOml8bv6QsBBdqroMk7XxI13VQygKrWx8YjAzcgfTs/irfWz8bVKv3SCYcqha0BG4Uyrjp2/bSVuHYNDLaydM+N7K73zj7d0XTkJc5wdR+Zd4jxmRcm1u5HzN+ik+2jlQ1M6k2MTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=bc3V/hce; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="bc3V/hce"
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id BFD6F20097;
	Fri,  5 Jun 2026 08:53:41 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 2CB813E904;
	Fri,  5 Jun 2026 08:53:34 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id D6B2D400D5;
	Fri,  5 Jun 2026 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1780649613; bh=NQdjqUEAflzDQ8J4WhjZ+I5NZDgNzi//G5hMzGnubSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc3V/hceJIXnqDFCkGDpiiwZvpZ1qDfDNeejFaqTOeAUAYOipZPqqSEefaGP4yYkK
	 QuvrRK5e0vlr90+o0Fl/e7ucpAiNBb8zNd2qNsXonODJUyrgx//9w9E164Qep82EhM
	 lFWflbEI4wZc5mgxYr1eAA4INlLRglgsIxv0uMMY=
Received: from avenger-XINGYAO-Series.tail8e8410.ts.net (unknown [114.246.239.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id C51FE406E1;
	Fri,  5 Jun 2026 08:53:23 +0000 (UTC)
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
Subject: Re: [PATCH 4/8] livepatch/klp-build: disable direct-extern-access for LoongArch to fix kernel panic
Date: Fri,  5 Jun 2026 16:53:09 +0800
Message-ID: <20260605085319.73984-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604065317.219777-5-dongtai.guo@linux.dev>
References: <20260604065317.219777-5-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: D6B2D400D5
X-Spamd-Result: default: False [2.20 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[lkml];
	FREEMAIL_CC(0.00)[kernel.org,kylinos.cn,flygoat.com,redhat.com,xen0n.name,vger.kernel.org,lists.linux.dev,suse.cz,gmail.com,infradead.org,suse.com,goodmis.org,xry111.site,loongson.cn];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Action: no action

Hi Dongtai,

Just set other issues aside for a moment — you define a variable inside one
function and only use it in another function?...

Thanks,
---
WangYuli
