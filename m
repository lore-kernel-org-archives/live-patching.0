Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110863;
	b=yM8ISeC2XHEzPMvD55IlY33iRWvQRUsuyjwuRIOW+8flK2e4skgksOJ973j/I0jTp6/l
	 y6DxgUWchsnyfWdScSQHofcSxGQSCSLsj2oxHLrBV7/si1aJabnrg7b4cKbIeskuYSohj
	 dMq7Mg58Ubt5u1Pr9AIdcsaHhU45wCaP/lwBQnmIGxtTpWe0C1nKv5ieeqieox23EWx4U
	 12u6Z21BNEN5vlKx5VO1RClvLRaJpf7r3aO3EeyBlOSNJu2WKjvMpGcEBTUMTv/J66UDJ
	 QIjCXbUTzuSEWBa59fjpPcQfy6hUD0zk2eYiItw2+GiwMg4E7WMroK4ipX7prAaQs/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110863;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=7MRFlfglY18Sfq4QDfCp6xCGJ/z2x+F9BdM4vLB1Vfg=;
	b=DNY3SJi9KZSx2GwOhtCn+S3zlbbC812yABzPG5vAqjY61VFl48xR5rZzab08dYDQaIWJ
	 GsdqIVb8iYhenLYvZx3Lk/23+x9pPC1aMpV7B8kYB+rqEdcp67+iYSSfSOROUmphgZPdx
	 g5KJuNvnESrdvcJ8fg8r2CojWMTYPv5T/TQMw8YnZ3mxYZPOIN9gkEYal6/QeXOMeuiEl
	 u1a0iynXwXYJ+Bih7r8wfdQxlGHoZSOBgIFX9ttIN0i9TEkfLjGvf5zRtlCdNWqTh9oNg
	 9LN0JZUvg7+D5ALncFA12/1JZ37VHxdMvyly4wP5w+w7pxJy1PSEJhTzFuUhzY/Pijw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=R83fktgJ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="SgQ9/m9J";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=R83fktgJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="SgQ9/m9J";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34958606A31B;
	Tue, 27 Oct 2026 14:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34958606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=R83fktgJ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SgQ9/m9J;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=R83fktgJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SgQ9/m9J
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 570DD21FB9;
	Tue, 27 Oct 2026 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793110861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MRFlfglY18Sfq4QDfCp6xCGJ/z2x+F9BdM4vLB1Vfg=;
	b=R83fktgJ6X7S11Vzj7rk2vi4bi8CoRT3qP8iPs0v3ApzEWSnhFbM7Bfeh7bzZjfT23ZIvr
	VProb1JxcHzVjy7cwRoRL3c2VDMnK4NmOZYWFSJ6+JhecLxsMfgDuaRsQg1mbKDhRgx639
	hRVFY7tU1cfdrwuT3GQGvLe5srEAm88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793110861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MRFlfglY18Sfq4QDfCp6xCGJ/z2x+F9BdM4vLB1Vfg=;
	b=SgQ9/m9JXSPi+iOKG4I+msyN7dBt+dikpHz9nNcAZRddfEVKB9mbfp84NZ1SyuaFN+eSEF
	vF0Abct5NLCx3eCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793110861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MRFlfglY18Sfq4QDfCp6xCGJ/z2x+F9BdM4vLB1Vfg=;
	b=R83fktgJ6X7S11Vzj7rk2vi4bi8CoRT3qP8iPs0v3ApzEWSnhFbM7Bfeh7bzZjfT23ZIvr
	VProb1JxcHzVjy7cwRoRL3c2VDMnK4NmOZYWFSJ6+JhecLxsMfgDuaRsQg1mbKDhRgx639
	hRVFY7tU1cfdrwuT3GQGvLe5srEAm88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793110861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MRFlfglY18Sfq4QDfCp6xCGJ/z2x+F9BdM4vLB1Vfg=;
	b=SgQ9/m9JXSPi+iOKG4I+msyN7dBt+dikpHz9nNcAZRddfEVKB9mbfp84NZ1SyuaFN+eSEF
	vF0Abct5NLCx3eCw==
Date: Tue, 27 Oct 2026 15:21:01 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, joe.lawrence@redhat.com, 
    jikos@kernel.org, live-patching@vger.kernel.org, shuah@kernel.org, 
    song@kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] livepatch: Clear relocations when klp_apply_object_relocs()
 fails
In-Reply-To: <att3oHvCpVDjDt-h@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.2610271520030.28401@pobox.suse.cz>
References: <20260908120325.299649-1-pmladek@suse.com> <20260908120325.299649-5-pmladek@suse.com> <alpine.LSU.2.21.2609181554590.21788@pobox.suse.cz> <att3oHvCpVDjDt-h@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -13.30

On Fri, 23 Oct 2026, Petr Mladek wrote:

> On Fri 2026-09-18 15:59:59, Miroslav Benes wrote:
> > On Tue, 8 Sep 2026, Petr Mladek wrote:
> > 
> > > When a module is loaded, klp_module_coming() updates all enabled
> > > livepatches. If an error occurs, it delegates cleanup to
> > > klp_cleanup_module_patches_limited(). However, this cleanup loop skips
> > > the partially updated patch, leaving any changes made prior to failure
> > > unreverted.
> > > 
> > > One unhandled failure path occurs inside klp_apply_object_relocs(). On
> > > architectures like x86_64, apply_relocate_add() performs a verification
> > > step using memcmp() to check that memory contains the expected relocated
> > > or zeroed value. If relocations left behind by a failed patch are not
> > > cleared, subsequent patch operations or reloads can fail this validation.
> > > 
> > > Introduce klp_write_object_relocs_limited() to unwind and clear only the
> > > relocations that were successfully applied before klp_write_object_relocs()
> > > encountered an error.
> > > 
> > > There is no need to clear relocations for other objects in the failing
> > > patch because klp_module_coming() operates strictly on the specific
> > > module being loaded.
> > 
> > Hm, I spent some quite time on that and I am not sure if I deciphered 
> > everything correctly.
> > 
> > It seems to me that all error handling in those paths you are mentioning 
> > above is correct and the only problematic thing is that 
> > klp_apply_object_relocs() in klp_init_object_loaded() returns ret 
> > immediately which leaves partially applied relocations in case of an 
> > error. Following calls in klp_init_object_loaded() go through err: label 
> > where klp_free_object_loaded() is called which should be fine.
> > 
> > Is it correct?
> > 
> > Wouldn't be better to be somehow consistent and clean up right in the 
> > error path of klp_apply_object_relocs() call in klp_init_object_loaded() 
> > similarly to what is already there. After all we want to clean the object.
> 
> In fact, this is exactly what klp_write_object_relocs_limited() does.
> The new _limited() variant of the function is used just in two
> locations:
> 
>    1. It implements the original klp_write_object_relocs() where
>       it is called "unlimited".
> 
>    2. It is used recursively in its own error path.
> 
> I did this trick to avoid code duplication in the error path.
> 
> I agree that is is not obvious. I should mention it in the commit
> message. And probably even add a comment into the code.
> 
> Or would you prefer another solution, please?

I will admit that I do not understand what I meant back then. Your 
solution seems correct to me now.

Miroslav
