Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D73AC0CD
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029093; cv=none; b=HQD9nOVLP9TfGHZWMrL9qDAT/QkHwujVHz9UgHyckB93DeoweIqspmw/nBhvutkQbBC4bID8KduZt41JxxsVwem64x54m6tRQC3Uj8ieFaseHDfW0Z+cqVMhLjGBsv0663gRujmRbYDCD6GUCAUACkK6QteCNOItiqfJhb+2h8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029093; c=relaxed/simple;
	bh=02P+Nto+8FWZEXgUD3DRmTvIK9sX1/Ts21EYtwsObwI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pQCZlGJkL0fHeklSbn2uZwPcANgTqSSIM8wuaQIEEBQ1nQIn5iqEJzFqNN+H7xPSfwzQZFdNdvsTjn89uH+BT4hLuWnBBfnrXGy0eDIA5HOHpLIRZ/Y0aSs9oFIp6R0owuJS6XiNmvNaSFfGSJXT+BR25a6JARZdus7WABq8hYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6+9qZnx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KLdVFVLx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uxZAO0kv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HgDliL2Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6+9qZnx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KLdVFVLx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uxZAO0kv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HgDliL2Q"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33C0921C49;
	Thu, 10 Sep 2026 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789029086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37IEAbIWrUNJnl9LHFJqNm2NXYX/0Jnvv4R+pvrVzB8=;
	b=y6+9qZnxF/q3zBA58AvQZpGuTuRXCPqNal9z3QRZiHjMLhy24ClzBfFFDtvKgb361BU2Um
	l2lUN6ubcLs7cXRiB+c3D4MQHZlLmKZbVmYSEctMbWS2ai5Fr5mjkkuws6orAhjx/JQ727
	1rW7Wd1nNP57jU3B6USJqv5UnIlG3Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789029086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37IEAbIWrUNJnl9LHFJqNm2NXYX/0Jnvv4R+pvrVzB8=;
	b=KLdVFVLxopp/6ekLY9vyd05WDXEURbhAkRzC1ETdJN7nxDUpe3j2unFNkV+P59sMFqLrkc
	KnqN3BrJ3fYjykAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789029082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37IEAbIWrUNJnl9LHFJqNm2NXYX/0Jnvv4R+pvrVzB8=;
	b=uxZAO0kv1HQ8OgAiBxWpSqMMJsZjzxMKh3RADKSLSUsmJRzJwwH4oAyz0Z5aaeJF+/qVUF
	FGfy+GOmV47mMFK1eYh2Zdg4fvoe+ReKNsN3FHA5tVaNrdcX5PnIULxKhJY5IYQLAMBb3N
	CRe/8JU6ZdMaInhfz4Ce6EJ+kEfvNio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789029082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37IEAbIWrUNJnl9LHFJqNm2NXYX/0Jnvv4R+pvrVzB8=;
	b=HgDliL2Qb8VtXUkZy9n/v3WQH24nsW507Y4Tt//hxsD5fxyIdgfOVb2e5H10/80NUzE9Af
	QNsVP4ZrtLbPIdCA==
Date: Thu, 10 Sep 2026 10:31:22 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Song Liu <song@kernel.org>
cc: Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>, 
    jpoimboe@kernel.org, jikos@kernel.org, joe.lawrence@redhat.com, 
    live-patching@vger.kernel.org
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
In-Reply-To: <CAPhsuW6OVt8oYr3YW9MbapXi6Z97CF-7J0fHXakKYkvvOp6A_Q@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2609101029080.608@pobox.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com> <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com> <apk9f_LsGRYHzN0Z@pathway.suse.cz>
 <alpine.LSU.2.21.2609091424420.10918@pobox.suse.cz> <CAPhsuW6OVt8oYr3YW9MbapXi6Z97CF-7J0fHXakKYkvvOp6A_Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-2146828000-790178653-1789029082=:608"
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	CTYPE_MIXED_BOGUS(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,kernel.org,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2146828000-790178653-1789029082=:608
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Sep 2026, Song Liu wrote:

> On Wed, Sep 9, 2026 at 5:32 AM Miroslav Benes <mbenes@suse.cz> wrote:
> [...]
> > >
> > > It might be useful for OS providers who want to make sure that their
> > > kernel critical fixes can be installed on the user system. Otherwise,
> > > customers might complain that some update failed, ...
> > >
> > > Of course, it has a drawback that any livepatch with ``prov ides= 0``
> > > would wipe any 3rd party livepatches, even when they are against 3rd
> > > party modules.
> >
> > My intention was not to regress and disallow a use case which is currently
> > supported. That is to replace everything applied no matter what.
> 
> I am curious about this use case. Do we really have users who:
>   - Load patch A, with replace=false;
>   - Load patch B, with replace=false;
>   - Load patch C, with replace=true, replacing both A and B?
> 
> I think this is not good practice anyway. Instead, users would either use
> a bunch of patches with replace=false; or only load one patch at a time,
> and keep replace=true for all of them.
> 
> Did I miss any reasonable users or use cases here?

I am not aware of anyone specific but the scenario above does not look too 
crazy to me. And the experience taught me that if something is possible, 
there is definitely someone out there doing it. However, as I said, I 
think the current implementation of the scoped replace should be enough 
for everybody. If not, we will learn about the use case in a couple of 
years.

Miroslav
---2146828000-790178653-1789029082=:608--
