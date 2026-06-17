Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BBE23394B
	for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704354; cv=none; b=qfKJ7Oo1AzZLNiibbVvAXkHNDquVvZak1ACs9lP1TwxvvQ5k+F0kGKb7kkFJZC0ZCv6/ihGIu4mlVnHypUapv5XV1y6CZd9niLyEcfmT4ENJ5//Y8ec/t3DeC2IJItPjXwphmNSQhhIvKdAROgC8R5twx47unHNgFTAdBPSJSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704354; c=relaxed/simple;
	bh=kIwqc1sxrrgMmnPMlejIwmbLlpVQ2H80LC8aW7p+Y60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/yFd2UwsZGJ/hv9L677kGEresmlk6Tn5WQ37DqNqVSSJHZKNqL7dpHEXd3JymVOp7UVZAwk3XWFaYJXvLflmwTfep2wxYIM8ZjvFTlk7P7Fp8U9CyHZnYfC/0qcRdOX591jg+JkezI+q0dffKXieE33XaEq0y/VivSFKZ1VQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hq3VI2o8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hq3VI2o8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so40481525e9.1
        for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781704350; x=1782309150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUGmZnVwRsbGxAsHFcdGZt3pdCpwiT3njzwkhyNcXzs=;
        b=Hq3VI2o8W+MUuOyCFiR/XWkLihJEq5c0avbnKbWOT2HwhVqBfP9ysadxLMBHwVx1Pt
         AZ6PJ5GcCywvD7BverWtXM39a6lzcWm+Y1uuUN8BVZLWz7lpr2LSTnoUl3ZpqTkwhbh/
         u3iPEJ0KStEebX6iKqo3f1SPsySjtSE52zpnkBoL00ngtIAVXutUCaulEm5KD/G6tcI/
         bpDerSOJ2KRwlWQUv2mlajouwuh2Psg5aRANA5wF9sIkNMVCOJD0atigUB/0vLfTlOyx
         7hBKjHN1eVyILYrK3mE8fCzNlp0cibu1OBPqVyFzOukjOY4AOjgdsEgzfFL1kdu8VP8Z
         sfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781704350; x=1782309150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUGmZnVwRsbGxAsHFcdGZt3pdCpwiT3njzwkhyNcXzs=;
        b=Ks8YjXSyc2nrDI4/RhDFD6/gO8NL0FJdGpVbPQtQCSJw/YAJGGafsM9zg5GFZSRM1s
         LEguTgySjrogP8lD6WfIPvMflAB4kDELGMq9pneoy8LXRClbxZZntZ2AABwEQYPpBf3X
         fp8KkOItpgzTP7vsyzj0yZAwnWq3NIaRk01qwbNWoo7TwLvRsmJkPO+4gdiksxlAqiRr
         kartzdhd1LKy8GexQq0xXkZWLhf84QbrV3GZRoZu4yjo9CO3KrXhth6M2PpkPThJxJ2s
         xDY7LzLr9BaAZmTnDIXK3SVwt4MKKyg8YG7QSjq7I85Iqw90bf97Cl/oLZDZ7BJWAHCD
         oLUA==
X-Forwarded-Encrypted: i=1; AFNElJ8H97UVF/PPb7fqRNzc2eTcOW2JLYA70Ngkeix5R/A/EM4IHaKN5BBnVXDp8ZeHyWCssbOgGivrtfLIxsLl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlppo6jTKsPLqoxUhZzClVZvM3UCMtiCW33FXGu96v6emkssHp
	gTNJNhSvBMPGOiHzCx0VAwdqXRl71Q0KYzRiuwg7aKWwhkeNOzBtbpu6nXK0J4apqec=
X-Gm-Gg: Acq92OH1+CYZvEuIoJr1Xa20oc/sx9VNbQkV1Lv45rF5p+FW/Ub/+DiF7MoKpQ43KMz
	gEPeJdwy3BYf2qxrqKRJt/hx+Oqvn2KUTBG7HGiSVbksGlUf7szm5l7ti0wjy5iW/Rm4xOsfSFu
	QMm/M7Xqph5ksHgWqD1ki+wGdLTQmEzVU6XbbsnV1elGyHsj3u370nAMuLUhMeo0S73Zz1A4qNg
	ex0VnW+GznRXThWp8ARmRxs+BCmR+OB0pOqaCvpjl2ArdIr71Uy7VDiNKPjj9tFlbDZD2awdAkf
	dAtQdHdVXgPmA3YOWSWeD7QmeA3bpqiWt7M8bd4FEuBImsDF+p7hasOcu4jGoRViHmBuKMh7gxD
	pSYW+E0MHkMuPHimSAyBBqeLOfBb3WDQuVKgStBviZF9Rdp0/XheboHRvTP5HfVg/61gOp0B7rA
	3jblhHE8CKSkhcEIPseQ1WQD3DZg==
X-Received: by 2002:a05:600c:8189:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-492333a1971mr65496885e9.7.1781704349768;
        Wed, 17 Jun 2026 06:52:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa9f2c0sm198119315e9.15.2026.06.17.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:52:29 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:52:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajGu1cP2znjHmN2H@redhat.com>

On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
> On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > I would write something like:
> > > 
> > > <proposal>
> > > The practice shows that the current semantic of the patch.replace flag is
> > > not ideal.
> > > 
> > > The atomic replace is disabled by default. And the no-replace mode allows
> > > wild installation of many livepatches in parallel. The author and
> > > administrator are fully responsible for preventing problems caused
> > > by producing and installing incompatible livepatches.
> > > 
> > > The most safe atomic replace mode must be explicitly enabled by
> > > setting "patch.replace = true". It is all or nothing. The livepatch
> > > with enabled .replace will always replace all already installed
> > > livepatches. It makes it very safe but it might be too harsh.
> > > 
> > > Improve the situation by switching "bool .replace" flag to
> > > "u32 .replace_set" and and updating its semantic.
> > > 
> > > Any .replace_set value might be associated with a set of livepatched
> > > symbols, callbacks, shadow variable and state IDs.
> > > 
> > > A livepatch with a particular .replace_set number will atomically
> > > rreplace any already installed livepatch with the same .replace_set
> > > number. By definition, there can only ever be one active livepatch
> > > for a given replace_set number.
> > > 
> > > On the contrary, livepatches with a different .replace_set number
> > > must not modify the same function, or use the state with the same
> > > ID [*]. Any attempt to load an incompatible livepatch will be
> > > rejected.
> > > 
> > > Summary:
> > > 
> > > The most safe mode when any livepatch replaces any other livepatch
> > > will be the default. Note that all livepatches must keep
> > > .replace_set = 0.
> > > 
> > > It will be possible to install more livepatches in parallel by
> > > using different .replace_set numbers. The livepatches might be
> > > updated independently using the atomic replace feature as long
> > > as the new version does not break compatibility. The kernel will
> > > reject a livepatch from a different replace set when it would
> > > want to modify the same function or livepatch state from
> > > another replace set.
> > > 
> > > [*] The compatibility check of callbacks and shadow variables will
> > >     be improved later by reworking their semantic. There is a work
> > >     in progress, see [0]
> > > </proposal>
> > > 
> > > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]
> > > 
> > > I have realized that I actually sent "v1-iter12" to the public
> > > mailing list as the official v1. So we could use:
> > > 
> > > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/ [0]
> > > 
> > > 
> > > New idea:
> > > 
> > > I have briefly discussed the new semantic with Miroslav when I met
> > > him in person. And he was a bit concerned. We as an OS distributor
> > > might want to be sure that our livepatches can be installed the most
> > > safe way. So, we still might want to preserve the "replace all"
> > > semantic to make sure that our livepatches will not break anything.
> > 
> > I thought more about it and we would need some solution to preserve
> > the replace_all functionality.
> > 
> > There were recently reported few serious 0-day vulnerabilities.
> > We discussed a possibility to ship a quick fix with a livepatch.
> > Or that customers might want to fix it themself by a livepatch.
> > Such a livepatch would need to be installed in parallel to
> > the official livepatch fixing older bugs. But the next official
> > cumulative livepatch would need to replace it.
> > 
> > The above scenario will not longer work with the current
> > "replace_set" handling. The hotfix would need to use another
> > "replace_set" so that it can be installed in parallel.
> > But the next cumulative livepatch won't be able to replace
> > it because it would need to modify the same function.
> > 
> > I consulted this with AI (claude-sonet-4.6) and it gave the following
> > feedback/ideas ;-)
> > 
> > > I though about 4 approaches approaches:
> > > 
> > > 1. Make .replace_set=0 special so that it will always replace
> > >    everything. Similar to the current .replace=true mode.
> > > 
> > >    Customers will still be able to install custom livepatches
> > >    later with .replace_set != 0. But the "0" livepatch will
> > >    always wipe them out.
> > 
> > This is not ideal because it is asymetric. Why is "0" special?
> > 
> 
> Hah, why is zero special?  Because we said so and the asymmetry is the
> point. :)  On my first pass through this patchset and reply chain, I'd
> say I lean toward approach (1) as it's dead simple and means not
> participating in replace_set values = no functional changes for the
> former atomic-replace user ...
> 
> > 
> > > 2. Use two flags in the livepatch, for example
> > > 
> > >      a. Rename .replace to .replace_all. The livepatch with this
> > > 	flag set will always wipe all other livepatches.
> > > 
> > >      b. Add .replace_set which will allow to install more livepatches
> > > 	in parallel, replace the livepatches with the same .replace_set
> > > 	atomically, and check the compatibility. As described above.
> > > 
> > >     It is a bit more complicated. But it is more compatible with
> > >     the current state. And it removes the special meaning of
> > >     .replace_set == 0.
> > 
> > This looks more straightforward. But the fact that "replace_all"
> > replaces everything brings back the problem with the original
> > "replace" flag. So, it makes this whole exercise more or less
> > pointless.
> > 
> > I had another idea with storing list of fixed bugs/CVEs in each
> > livepatch. Independent fixes might be fixed by independent
> > livepatches. Then a cumulative livepatch would replace only
> > the livepatches which fixed the same bugs before.
> > 
> > And (claude-sonnet-4.6) came with an interesting simplification.
> > 
> > We could add:
> > 
> > struct klp_patch {
> > [...]
> >       unsigned int replace_set;
> >       const unsigned int *supersedes;   /* Zero terminated array of replace_set IDs */
> > [...]
> > }
> > 
> > So that the cumulative livepatch might optionally define
> > another "replace_set"s which would be replaced.
> > 
> > This would work well when both cumulative livepatches and the hotfix
> > are provided by the same vendor or group.
> > 
> > We could also allow to change it dynamically by adding an module
> > option to the cumulative livepatch, .e.g supersedes=id[,id]*
> > We could add some support into the kernel for handling the module
> > parameter a standard way.
> > 
> > It is not trivial. But it is also not horribly complex.
> > It looks like a good compromise between the requirements and
> > code complexity.
> > 
> > We really need input from others here.
> >
> 
> I'm not against supercedes functionality, but continuing the
> brainstorming: what about solution 1 (.replace_set=0 special) with a
> special zero-day overlay?

I continue with the brainstorming ;-)

> The model becomes:
> 
> - replace_set: isolation sets (as Yafang has implemented)
> - overlay (bool): "I'm a partial addition to my set, not a full replacement"
> 
> and then the vendor zero-day scenario looks like:
> 
>   Mon: cumulative patch (set 0, overlay=false)
>   Tue: hotfix (set 0, overlay=true) stacks on top, overrides one function
>   Wed: new cumulative (set 0, overlay=false) replaces both

First, I am not much happy with the "overlay" terminology.
In the filesystem world an overlay allows to have the same file
in more layers and usually only the highest one is visible.

But this whole exercise with "replace_set" was motivated by adding
some safety when installing more livepatches in parallel.
And the most obvious danger is when two livepatches modify the same
function. So I wanted to prevent this.

It is also related to the commit 3dae09de406167 ("livepatch:
Add stack_order sysfs attribute") which helped to debug
such problems.

> If overlay patches are cumulative, then it should support iterating on
> zero-day fixes like:
> 
>   Mon: cumulative base patch
>   Tue: hotfix v1 disable vulnerable code
>   Wed: hotfix v2 vendor-specific attempt to solve
>   Thu: cumulative patch with final CVE fix
> 
> So I think either the supercedes or overlay feature handle vendor-only
> scenarios well.

Second, this would kind of solve the OS vendor problems.
But the customer might want the same flexibility.


> The big difference overlay has from supercede is that it intentionally
> only plays within the vendor replace-set space.  So if a (customer)
> feature replace-set was off touching function_foo() and a CVE landed
> there, the overlay feature would remain blocked from patching it.
> Supercede provides a big hammer here.
> 
> That said, blind eviction via supersede assumes the customer's
> replace-set patches are actually safe to bounce.  The customer's patch
> may have allocated shadow variables, modified system state via
> callbacks, or changed data structure semantics, all designed to be
> unwound by the next customer version of that patch, not by an unrelated
> vendor patch.  The vendor can't know what semantic landmines the
> customer's patch left behind, and the kernel can't validate that at load
> time.

Good point. The dependecies and conflicts between shadow variables
and callbacks should have been solved by the livepatch state.
IMHO, we should never allow to replace livepatches with incompatible
livepatch states.

Unfortunately, the states are not well connected with the shadow
variables and callbacks at the moment. But there is a patchset improving this,
see https://lore.kernel.org/r/20250115082431.5550-1-pmladek@suse.com


> So maybe it boils down to: is the supercedes big hammer desired and safe
> enough to deploy?  Is overlay useful enough to be worth implementing?

I personally like the solution with a zero-terminated array of
replace_sets:

	struct patch {
	       [...]
	       unsigned int *replace_sets;
	       [...],
	};

, which would allow to build a cumulative livepatch which replaces
known hotfixes out of box.

Note that the hotfix should not be allowed to modify a function or
livepatch state which is modified by another livepatch. It would
be dangerous. We should allow to solve this only by a cumulative
livepatch.

IMHO, the OS vendor should not touch customer specific livepatches
by default. The customer installed them for a reason. We should
just refuse to install two conflicting livepatches. Where
we could reliably compare only the livepatched functions.
But it still is good because most livepatches only modify
functions.

Plus, I would still allow to resolve the possible conflict by using
the atomic replace. It could be done by a module-specific parameter.
I would call it: override_replace_sets=X[,Y]... or so.

Finally, I assume that most users will keep using only the default
replace_sets=0 [*]. They will never have to deal with another sets.

The non-default replace sets will be only for adventurous users
who want to deal with the complexity and accept the risks.

[*] It we allow the zero-terminated array of replace_sets then
    zero should not be the default. Or it could be but it would
    be a special set which could never be replaced by anything
    else than another zero replace set.

    The zero replace set might be for users who do not want to
    deal with the complexity at all. For example, for an os-vendor
    who does not want to release separate hotfixes.

Best Regards,
Petr
