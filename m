Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D63BA222
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906893; cv=none; b=LyQgnimAtBcqhyuuYVSaHdtam8y/+HqRcryQ72RO9qpzV0X/R9eAJ5PVMLQaG+0fl+3LJo//zE5cBr3ZQzxwGyE/4emuo6nwiGj7ZqugEArQem8bL2NYEgr5m89oHY4C1UECVgQaVd2yRJwwfPaa/I7ICX/8UxVLD2v7xdrSasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906893; c=relaxed/simple;
	bh=oj2FAOWXmH78DzWdpY7oGUb2l7fWvFJUutUiG2lXiH8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tiiOUksytGGPhAFpfBVMMux0xcRulYY+7YtaXFnu5g/fED4k3AjQV9PbuxoKf6oz0cjlwZjm3JNaSKjfJOgUIDuUC5xrrmGEgvbHdtCTv1QcbrGPLs7hi/E8w/lXbFJk1w2TLkOdcw8WuujcdeFDpWYEMmDi7jQ4bc6O4nhyl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNqiGZrA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dOxuWTKA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgvbsoZ9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ps24t3FQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNqiGZrA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dOxuWTKA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgvbsoZ9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ps24t3FQ"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id E0A7175AA5;
	Wed,  1 Jul 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782906885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg26ZNQWMEyEItXVQvx5FtMQXYGgbQx4HQqdkjS20g=;
	b=XNqiGZrAyQALvIs4HWSqHlRvX7jPfd0oBs/tO1bN/QDEKXsEXTKNYDBZogaIW49OATNP3s
	Zqsom2VheqJ3m8CKA/IlXeQk3pS0CT4UwnnnNGCUreqw3BAZ5qinsLwnjn2wF7//NYfWpd
	WcOKTAlK883bwcvhah0p6ZKib4vWVn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782906885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg26ZNQWMEyEItXVQvx5FtMQXYGgbQx4HQqdkjS20g=;
	b=dOxuWTKAQ9r9zceJNCCT3EsS75QAN6CVEdpTcMpsLIwPQ1a42w13zdNAXTBEuFECUYWOcA
	jgVj1F/BMtP0JJAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zgvbsoZ9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ps24t3FQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782906884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg26ZNQWMEyEItXVQvx5FtMQXYGgbQx4HQqdkjS20g=;
	b=zgvbsoZ9VP2TWD85ywtDzpVVLLZXTl7a7GmhaUaTgP8rfC7bafu9ESU9Sf6C0lfAzEBUgj
	23CsveQGBlbhik8TCq+1288T6+Xmn21dzW0GgEe0t+cNQS3ZvFP15WIYtpYQLc3jQkt2bo
	ntW3jevZPoQ8NOvmVUkLmvQo4nosTKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782906884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg26ZNQWMEyEItXVQvx5FtMQXYGgbQx4HQqdkjS20g=;
	b=Ps24t3FQfHe6UTzyoUOfHZW26Mf7d82U5zWaX8FKiFB/S8nm6EfUQu/0j1LNzIybQm8uje
	WxDx8IaGzpiuptAw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 04/21] arm64: Rename TRAMP_VALIAS ->
 TRAMP_VALIAS_ASM in asm-offsets
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <74623fad8c45d26a3da6c5420b00156d8f7c2150.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <74623fad8c45d26a3da6c5420b00156d8f7c2150.1778642120.git.jpoimboe@kernel.org>
Date: Wed, 01 Jul 2026 13:54:41 +0200
Message-Id: <178290688141.34581.8116654132662243314.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=566; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=oj2FAOWXmH78DzWdpY7oGUb2l7fWvFJUutUiG2lXiH8=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhixXBpZeA7eToT3+1nMaA06ZLbo1a+uaDZ0un/nEjh26G
 CSd+HtnJ6M/CwMjB4OlmCLL673OcoZTcg00q9/dhRnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmGr/s+z/g0z4t29Ym/Ms5tK6M4lZsYtC3C02xAa1bE7bstH9nynHqgl7dh2fbcR
 wXMIzxs1/mwxT8K+DB87/k7HpaVvxq14paWnD5/r2rUs2HzPQcbWb7hx8Q0/RtMvJT+zsORfnC4
 9OLLeObZ38xZg93PjeZwvTX0lTpZk60hVXbloZ3R4XYctU/DJ059VTM9W+7dV/N0NPY/mTIy4u/
 vfNFJs9vSWzbqUuu5/VbaKe6jSp8Jmui8LMxtQKhcfhQes2Ln4dNEPHwe2OTvdHi/ogFs1plUvj
 Tl8VDp0W9mOX1cxNy77eXj/xTq2txwm2dNlFR6Z+mpkun+h19trx7TP+XHJ5v13lSu/57yunLVP
 a2aq7GQA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: *****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.39 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:2b::1244:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLy6ogssk6jotd4tofw6wwi5bg)];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: E0A7175AA5
X-Spam-Score: 17.39
X-Spam: Yes

On Tue, 12 May 2026 20:34:00 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Rename the asm-offsets TRAMP_VALIAS macro to TRAMP_VALIAS_ASM, following
> the naming convention already used by PIE_E0_ASM and PIE_E1_ASM.  This
> disambiguates the asm-offsets-generated constant from the C macro of the
> same name defined in fixmap.h and vectors.h.
> 
> This is needed by a later patch which adds new includes to asm-offsets.c
> that would otherwise conflict with the C version.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

