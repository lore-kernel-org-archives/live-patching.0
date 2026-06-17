Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A17328B5E
	for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726833; cv=none; b=Ti3cF/hEdMnLYpn9CZyrAXmkOdLS2PWWrgyhtz3cng4SeA+ZMe3+/Wfu3oQk8Q8TL8E5JYxD6g1lX64PPayvkvDbxOZqG+FqoMHOzTIWbao73qBMealdczG43OlptXyO5acD2ElmCeh4Pw8qtDBH1mz3zRb+i8thL3uk2lBgX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726833; c=relaxed/simple;
	bh=mvmAb5nYMyDSXZCQa7qRygsDKi/ZWgSemEKraSue2jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPeqi3G+5Z2JKkYPiVACXIQ9KOcu1GdzAv/VOnAvN8TVoZhd3Fi3PeXPE7/O2MSTUJOWbn6U4lPYCbTGa8mA/LJxuTeW4InAPA/GTkQEWWmI7cSVE/S1P56U5sZiKb7psPuyi8+rFgOcmu6hrzi1DRbCtbmiV8KZZU+6epaPBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXV1ijCo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXV1ijCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781726831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Il6OFETPy6d38hkrVUmjFl+KJZhP7O2qXVu3mvZRFhk=;
	b=WXV1ijCoUOmGXbGcl6wqbaPuNuahS8qMPZoSWbUojL+Hy2pXSWKGEgjYxsWECWMmkcPTIM
	yOzdcoToVFKsZqDQFJbQ4ce3+diw5vKRzusP1JYSGzkanbvJjoD3RPTGyWtVHnY0+FnKR9
	y8gxNQqOvV5LQzs0437kPl5OCtgYTIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-qJC7PDwbOOWaATAulJE1XA-1; Wed,
 17 Jun 2026 16:07:06 -0400
X-MC-Unique: qJC7PDwbOOWaATAulJE1XA-1
X-Mimecast-MFC-AGG-ID: qJC7PDwbOOWaATAulJE1XA_1781726823
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69E9619539B5;
	Wed, 17 Jun 2026 20:07:03 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FFDA1800652;
	Wed, 17 Jun 2026 20:07:01 +0000 (UTC)
Date: Wed, 17 Jun 2026 16:06:59 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajL-Y3dapC1FiAwx@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com>
 <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jun 17, 2026 at 03:52:27PM +0200, Petr Mladek wrote:
> On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
> > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> [ ... snip ... ]
> > I'm not against supercedes functionality, but continuing the
> > brainstorming: what about solution 1 (.replace_set=0 special) with a
> > special zero-day overlay?
> 
> I continue with the brainstorming ;-)
> 

Thanks for walking through it with me.  Your reply crossed with my note
to Yafang at nearly the same time.

> [ ... snip ... ]
> > So maybe it boils down to: is the supercedes big hammer desired and safe
> > enough to deploy?
> 
> I personally like the solution with a zero-terminated array of
> replace_sets:
> 
> 	struct patch {
> 	       [...]
> 	       unsigned int *replace_sets;
> 	       [...],
> 	};
> 
> , which would allow to build a cumulative livepatch which replaces
> known hotfixes out of box.
> 

Question on this at the bottom ...

> Note that the hotfix should not be allowed to modify a function or
> livepatch state which is modified by another livepatch. It would
> be dangerous. We should allow to solve this only by a cumulative
> livepatch.
> 

Agreed.

> IMHO, the OS vendor should not touch customer specific livepatches
> by default. The customer installed them for a reason. We should
> just refuse to install two conflicting livepatches. Where
> we could reliably compare only the livepatched functions.
> But it still is good because most livepatches only modify
> functions.
> 
> Plus, I would still allow to resolve the possible conflict by using
> the atomic replace. It could be done by a module-specific parameter.
> I would call it: override_replace_sets=X[,Y]... or so.
> 

Naming nitpick: "override_replace_sets" sounds like it may override the
"replace_sets" value and not supplement it.  But that's just an
implementation detail to bikeshed later :D 

> Finally, I assume that most users will keep using only the default
> replace_sets=0 [*]. They will never have to deal with another sets.
> 
> The non-default replace sets will be only for adventurous users
> who want to deal with the complexity and accept the risks.
> 
> [*] It we allow the zero-terminated array of replace_sets then
>     zero should not be the default. Or it could be but it would
>     be a special set which could never be replaced by anything
>     else than another zero replace set.
> 
>     The zero replace set might be for users who do not want to
>     deal with the complexity at all. For example, for an os-vendor
>     who does not want to release separate hotfixes.
> 

Hmm, I do like the default replace_sets=0 not dealing with the
complication of the replace sets.

But first, back to the larger question I mentioned at the beginning.

Originally there was:

  unsigned int replace_set;            /* the set I belong to */
  const unsigned int *supersedes;      /* other sets I also replace */

and now it's just:

  unsigned int *replace_sets;          /* sets I belong to AND replace? */

Could you trace through a few cycles of cumulative + hotfix releases with
this approach?  For example:

  Wed: klp-1a: cumulative    (replace_sets={1})
  Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
  Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b (same set)
  Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a AND wipes klp-1c *
  Tue: klp-2b: hotfix        (replace_sets={2})     <- coexists with klp-2a

[*] After klp-2a loads with {1, 2}, is it permanently in both sets?  Or
    does it just evict set 2 and then only occupy set 1 going forward?  The
    latter makes klp-2b's load straightforward.

I can read replace_sets two ways:

  1. Positional: { set [, eviction_set ...] } where the first element is
     the patch's own set and the rest are evicted on load.

  2. Flat: the patch belongs to every listed set equally.  But then how
     could klp-2b load into set 2 without replacing the entire
     cumulative klp-2a that also occupies it?

Thanks,
--
Joe

