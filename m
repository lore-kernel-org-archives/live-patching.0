Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24636392C2F
	for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640928; cv=none; b=LQVdk0gS/RGxQTU4FtH0tnHSluTbJ0HnPIqrMTbv7EzTntXoCINk3ssN/Umv6tRqLl0JANs16/v+3coXCrjsQrrH//DqSo10WNUN8DwSxYel6pa9m7L4HPNe4+qgOD/pHByiJjgndS4E//C3LDJkBwma8xCr/hWCaIrnH+j9VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640928; c=relaxed/simple;
	bh=K7FMN+81DmmD0SCBZb5sDUoEAcX7AC7Ou1/7eGx6XTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB0cCkP9yV/eEj7drS8dl9+RlLaRE0d8XCYA3hVi1wm/NecQWjQ5kZf9LWQpdJpG8T6kyxvo/o/YAknYXEIN7QuxuPde1Y3T1iV09uNNlIgvbwVF2KwcMHPlbLLPCrcbv1uAQVewKvNmcwUoUtp0AOAGo7tKGWpxwEG4oNuUcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnyjN74i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnyjN74i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781640925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqK6BD4BvNm0ClhyYGkpBIIqIX9jlc9yj7oVMRPWjZI=;
	b=dnyjN74isqEDYsMhhcLuoTSQc0VbmFnxfXw8dTrgu3zuAc/bkdDdQQxUix1Mg0cP0BxrNf
	l/Wvu9Wx9xiJuOlAUtFtF+DgKjfdOUYN34m5CrjOFWUdFD76+b8V0wR5O0MLMEw6Px0uIc
	z3xueFW8lK7RZTVXKjWDZCWGJ4MtGbA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60--N_VJJXePrGCtowck--RmQ-1; Tue,
 16 Jun 2026 16:15:23 -0400
X-MC-Unique: -N_VJJXePrGCtowck--RmQ-1
X-Mimecast-MFC-AGG-ID: -N_VJJXePrGCtowck--RmQ_1781640922
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7A0119560AD;
	Tue, 16 Jun 2026 20:15:21 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.115])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 587833008B3C;
	Tue, 16 Jun 2026 20:15:20 +0000 (UTC)
Date: Tue, 16 Jun 2026 16:15:17 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajGu1cP2znjHmN2H@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <aiqw_74v-1_2D9rJ@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiqw_74v-1_2D9rJ@pathway.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > I would write something like:
> > 
> > <proposal>
> > The practice shows that the current semantic of the patch.replace flag is
> > not ideal.
> > 
> > The atomic replace is disabled by default. And the no-replace mode allows
> > wild installation of many livepatches in parallel. The author and
> > administrator are fully responsible for preventing problems caused
> > by producing and installing incompatible livepatches.
> > 
> > The most safe atomic replace mode must be explicitly enabled by
> > setting "patch.replace = true". It is all or nothing. The livepatch
> > with enabled .replace will always replace all already installed
> > livepatches. It makes it very safe but it might be too harsh.
> > 
> > Improve the situation by switching "bool .replace" flag to
> > "u32 .replace_set" and and updating its semantic.
> > 
> > Any .replace_set value might be associated with a set of livepatched
> > symbols, callbacks, shadow variable and state IDs.
> > 
> > A livepatch with a particular .replace_set number will atomically
> > rreplace any already installed livepatch with the same .replace_set
> > number. By definition, there can only ever be one active livepatch
> > for a given replace_set number.
> > 
> > On the contrary, livepatches with a different .replace_set number
> > must not modify the same function, or use the state with the same
> > ID [*]. Any attempt to load an incompatible livepatch will be
> > rejected.
> > 
> > Summary:
> > 
> > The most safe mode when any livepatch replaces any other livepatch
> > will be the default. Note that all livepatches must keep
> > .replace_set = 0.
> > 
> > It will be possible to install more livepatches in parallel by
> > using different .replace_set numbers. The livepatches might be
> > updated independently using the atomic replace feature as long
> > as the new version does not break compatibility. The kernel will
> > reject a livepatch from a different replace set when it would
> > want to modify the same function or livepatch state from
> > another replace set.
> > 
> > [*] The compatibility check of callbacks and shadow variables will
> >     be improved later by reworking their semantic. There is a work
> >     in progress, see [0]
> > </proposal>
> > 
> > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]
> > 
> > I have realized that I actually sent "v1-iter12" to the public
> > mailing list as the official v1. So we could use:
> > 
> > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/ [0]
> > 
> > 
> > New idea:
> > 
> > I have briefly discussed the new semantic with Miroslav when I met
> > him in person. And he was a bit concerned. We as an OS distributor
> > might want to be sure that our livepatches can be installed the most
> > safe way. So, we still might want to preserve the "replace all"
> > semantic to make sure that our livepatches will not break anything.
> 
> I thought more about it and we would need some solution to preserve
> the replace_all functionality.
> 
> There were recently reported few serious 0-day vulnerabilities.
> We discussed a possibility to ship a quick fix with a livepatch.
> Or that customers might want to fix it themself by a livepatch.
> Such a livepatch would need to be installed in parallel to
> the official livepatch fixing older bugs. But the next official
> cumulative livepatch would need to replace it.
> 
> The above scenario will not longer work with the current
> "replace_set" handling. The hotfix would need to use another
> "replace_set" so that it can be installed in parallel.
> But the next cumulative livepatch won't be able to replace
> it because it would need to modify the same function.
> 
> I consulted this with AI (claude-sonet-4.6) and it gave the following
> feedback/ideas ;-)
> 
> > I though about 4 approaches approaches:
> > 
> > 1. Make .replace_set=0 special so that it will always replace
> >    everything. Similar to the current .replace=true mode.
> > 
> >    Customers will still be able to install custom livepatches
> >    later with .replace_set != 0. But the "0" livepatch will
> >    always wipe them out.
> 
> This is not ideal because it is asymetric. Why is "0" special?
> 

Hah, why is zero special?  Because we said so and the asymmetry is the
point. :)  On my first pass through this patchset and reply chain, I'd
say I lean toward approach (1) as it's dead simple and means not
participating in replace_set values = no functional changes for the
former atomic-replace user ...

> 
> > 2. Use two flags in the livepatch, for example
> > 
> >      a. Rename .replace to .replace_all. The livepatch with this
> > 	flag set will always wipe all other livepatches.
> > 
> >      b. Add .replace_set which will allow to install more livepatches
> > 	in parallel, replace the livepatches with the same .replace_set
> > 	atomically, and check the compatibility. As described above.
> > 
> >     It is a bit more complicated. But it is more compatible with
> >     the current state. And it removes the special meaning of
> >     .replace_set == 0.
> 
> This looks more straightforward. But the fact that "replace_all"
> replaces everything brings back the problem with the original
> "replace" flag. So, it makes this whole exercise more or less
> pointless.
> 
> I had another idea with storing list of fixed bugs/CVEs in each
> livepatch. Independent fixes might be fixed by independent
> livepatches. Then a cumulative livepatch would replace only
> the livepatches which fixed the same bugs before.
> 
> And (claude-sonnet-4.6) came with an interesting simplification.
> 
> We could add:
> 
> struct klp_patch {
> [...]
>       unsigned int replace_set;
>       const unsigned int *supersedes;   /* Zero terminated array of replace_set IDs */
> [...]
> }
> 
> So that the cumulative livepatch might optionally define
> another "replace_set"s which would be replaced.
> 
> This would work well when both cumulative livepatches and the hotfix
> are provided by the same vendor or group.
> 
> We could also allow to change it dynamically by adding an module
> option to the cumulative livepatch, .e.g supersedes=id[,id]*
> We could add some support into the kernel for handling the module
> parameter a standard way.
> 
> It is not trivial. But it is also not horribly complex.
> It looks like a good compromise between the requirements and
> code complexity.
> 
> We really need input from others here.
>

I'm not against supercedes functionality, but continuing the
brainstorming: what about solution 1 (.replace_set=0 special) with a
special zero-day overlay?

The model becomes:

- replace_set: isolation sets (as Yafang has implemented)
- overlay (bool): "I'm a partial addition to my set, not a full replacement"

and then the vendor zero-day scenario looks like:

  Mon: cumulative patch (set 0, overlay=false)
  Tue: hotfix (set 0, overlay=true) stacks on top, overrides one function
  Wed: new cumulative (set 0, overlay=false) replaces both

If overlay patches are cumulative, then it should support iterating on
zero-day fixes like:

  Mon: cumulative base patch
  Tue: hotfix v1 disable vulnerable code
  Wed: hotfix v2 vendor-specific attempt to solve
  Thu: cumulative patch with final CVE fix

So I think either the supercedes or overlay feature handle vendor-only
scenarios well.

The big difference overlay has from supercede is that it intentionally
only plays within the vendor replace-set space.  So if a (customer)
feature replace-set was off touching function_foo() and a CVE landed
there, the overlay feature would remain blocked from patching it.
Supercede provides a big hammer here.

That said, blind eviction via supersede assumes the customer's
replace-set patches are actually safe to bounce.  The customer's patch
may have allocated shadow variables, modified system state via
callbacks, or changed data structure semantics, all designed to be
unwound by the next customer version of that patch, not by an unrelated
vendor patch.  The vendor can't know what semantic landmines the
customer's patch left behind, and the kernel can't validate that at load
time.

So maybe it boils down to: is the supercedes big hammer desired and safe
enough to deploy?  Is overlay useful enough to be worth implementing?

--
Joe

