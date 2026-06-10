Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F5213E9C
	for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084916; cv=none; b=TBWuDJ5tIgkPAVNcum6BluQ2seggoZQNbP8p5GcgNtYTG2XNWfrvgoCQy3k4V3+M+KI3LxV+dsqw2z9mQoGIJG5oYiCewLo5YPQtF3U3W8pk+/VFp4IV34sCOJeQQugOyyrmUA/46Xx7amackBD/BKoFUkQpj8U2+SycDLbILic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084916; c=relaxed/simple;
	bh=mrCLavbcP4zrCm/TIteekEKuQQwu5Ipifc1P02lKRtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9KgNiycwu2o6deMCRELr/jXwEaWsC4q8R1ImKve+hzaV/DIGiJhf0pb11IynBR0AJgiWi7DiQzeyhaqq0vtL1vLBWWUaP2Y4jgJztyKj4V3GVFdMccdDCizdbPQLQ6wyqyQ8E1iZYzeKbIiKvw3eL4i8ZbD8sR9uTGEKtOrWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HSarlvng; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HSarlvng"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3e03939so54268435e9.1
        for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781084913; x=1781689713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbBJ7ojX9MkMvjxjM9nogrPygkN1/pc8YU00thrQ4sk=;
        b=HSarlvngfx0Po4nrqQxMswWXrJgAz5zme+QZVgpZ3LWy1BxYQbniK/g/CFt5ZmtmHr
         3BUay4rFxc4H3ZA6s4qktlcVf0RwUy5eJInKqyhbFV92D9QuTisPPKv3T7+YYQ1nMKH6
         kSPaZ9xdRivn6krqOhQ2kcPeC70Hmv1hemHKzRXl7h4KLL/vaPOkTzSyVe0nlrh6dopy
         zmxBc/aZTU/Y3lWRIlQgXa6kdTYXyBeY2nDRRjFuv2RyZrHE/nHOMvEYQzBJae8adSDH
         knCMWIgHp/YYeRBSIPMGWn34thNkpHjlPZDJaR/hfXoFTZl5tIuZlSMz1mO7a5HLz1Ds
         c0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084913; x=1781689713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbBJ7ojX9MkMvjxjM9nogrPygkN1/pc8YU00thrQ4sk=;
        b=OBlIeah+XVVPkCvyeT/wS2MC289OkcNvb2lML3+y7wznitCzrRsoTWNDhjWIrHZcVf
         qE6jwM/cvn8YMo0D0OcLheKxkQeIARFlgaamfkxTP19844sFa4sodTOUSDE3c+ox9HCI
         l0HV8BXx09/6melArVjbTDeU2goHICAuCvIT8crN2i6hcWCz6oJgai7QBie9a+e1nro1
         N1Gws5pNne5J9EwyKmJ/tmoN3cmL7oIydyolWPiw6t7GmwO1phzv2pyTFnDExDhw4hb8
         1LlIGGhJsoskKkgz3EEY6Mra4hvGgHx4iPYtEKvIeo4ScOpbpoDbMmBCiCWYmtPzw7B5
         e3Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+w+kZ+JREMCk8UptoEcsyS6SHEs5JCkvpyBqdHFp/qz7wo/5dGGU/I4VUq9iQcQrwbKnHkUk0ErTUCTz5w@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4/RfHLqDUjosnTluK3Y0wNlLCJfLT3QLXmD+MLfSj6X+Y0rn
	3EjuQDmPylnu5mIyXVaB+AVbaGuDlb2bFtMD2AJZ8J4HNiHGB766AkE80+nX+CXlmlM=
X-Gm-Gg: Acq92OE8vDB1z6C0llVF5tp2yaIHIzo1d6o/gJ58ekQs+G+ycMd7su8yLOTzVb069I3
	9Do2LZC46yNbN81uWzeBUpe/f6E8HMthjvcfa7/8MLUZKUOuPGmfWnHgTt9R2edyO6j03h9G42G
	jTYuhDvjZ8Hb7qW+Cd5Kt+f0bJY6om7lk4s0gox5WxXF7xuGDivjBH7yz1T4OmHP0EVBnJLLokY
	cIjT6RsWxKUveoa/FQpDT2H/t8y+3AnsEy3jt2f8IWyWrrysK9aVh6VVpDmDjyu9Vp84Qja0G4C
	7vW8FNT6fyIiYJgi0cDJWLHuwJ/OdesEBUUjeb7hA4d/oSvGtN5U4ARI7A4dz6eZxnS/HHFYXbZ
	rixImDA0p3chRGmy6E7xWMg7ilUY5x29ZdZWJ6+cpnGh43HrfGFo4YmdX0DhmrF9n/gmG9cFs68
	IIHXty9ChjbK2tw1Ia+zGuGC700NHCbfHFlWH4
X-Received: by 2002:a05:600c:4689:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-490c2c63f53mr290384655e9.0.1781084913240;
        Wed, 10 Jun 2026 02:48:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm638046805e9.1.2026.06.10.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:48:32 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:48:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <aiky7hr6sFMjXD-P@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <CALOAHbD6q0By=NZ2Lk0SAFjzpJ_=AKPLdVqd5T09PiKsppiwOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD6q0By=NZ2Lk0SAFjzpJ_=AKPLdVqd5T09PiKsppiwOA@mail.gmail.com>

On Wed 2026-06-10 11:24:57, Yafang Shao wrote:
> On Wed, Jun 10, 2026 at 12:00 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > Convert the replace attribute from a boolean to a u32 to function as a
> > > "replace set." A newly loaded livepatch will now atomically replace any
> > > existing patch belonging to the same set. There can only ever be one active
> > > livepatch for a given replace_set number.
> > >
> > > This change currently supports function replacement only. Livepatches that
> > > belong to different replace sets cannot modify the same function. If a new
> > > livepatch attempts to modify a function already modified by an older
> > > livepatch from a different replace_set, the loading of the new livepatch
> > > will be refused.
> > >
> > > Similarly, for the KLP state, livepatches belonging to different replace
> > > sets cannot use the same state ID. The system will refuse to load a new
> > > livepatch if it uses a state ID already in use by an older livepatch from
> > > a different replace_set.
> > >
> > > For the KLP shadow variable mechanism, developers must assign unique shadow
> > > IDs to livepatches that belong to different replace sets.
> > >
> > > Support for replace_set compatibility with KLP state and shadow variables
> > > will be implemented after Petr's KLP state transfer work is completed [0].
> > >
> > > Other user-visible changes include:
> > > - The non-replace model is now deprecated
> > > - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
> > >   /sys/kernel/livepatch/livepatch_XXX/replace_set

> > New idea:
> >
> > I have briefly discussed the new semantic with Miroslav when I met
> > him in person. And he was a bit concerned. We as an OS distributor
> > might want to be sure that our livepatches can be installed the most
> > safe way. So, we still might want to preserve the "replace all"
> > semantic to make sure that our livepatches will not break anything.
> >
> > I though about 4 approaches approaches:
> >
> > 1. Make .replace_set=0 special so that it will always replace
> >    everything. Similar to the current .replace=true mode.
> >
> >    Customers will still be able to install custom livepatches
> >    later with .replace_set != 0. But the "0" livepatch will
> >    always wipe them out.
> >
> >
> > 2. Use two flags in the livepatch, for example
> >
> >      a. Rename .replace to .replace_all. The livepatch with this
> >         flag set will always wipe all other livepatches.
> >
> >      b. Add .replace_set which will allow to install more livepatches
> >         in parallel, replace the livepatches with the same .replace_set
> >         atomically, and check the compatibility. As described above.
> >
> >     It is a bit more complicated. But it is more compatible with
> >     the current state. And it removes the special meaning of
> >     .replace_set == 0.
> >
> >
> > 3. Introduce a system wide flag, sysctl livepatch_replace_all
> >    which would allow to enable/disable the replace_all feature
> >    of either .replace_set == 0 or per-patch.replace_all flag.
> >
> >    It would allow the customer to preserve their custom livepatches
> >    when they know what they do. For example, when they use the livepatch
> >    to modify a 3rd party module or tune some functionality.
> >
> >
> > 4. Just taint the kernel when a livepatch with .replace_set != 0
> >    is installed. Then the OS provider could say that a tainted kernel
> >    is not longer officially supported.
> 
> Since the kernel is already tainted with TAINT_LIVEPATCH upon loading
> a livepatch, are you recommending the addition of a distinct flag,
> such as TAINT_LIVEPATCH_REPLACE_SET?

Yeah, I would call it TAINT_PARALLEL_LIVEPATCH or
TAINT_MORE_LIVEPATCHES.

But maybe, it is not necessary. We have a tool which allows to get
info about the running system, including the loaded modules and
livepatches. It might be enough.

Let's see what others think about this. Note that Miroslav has
vacation this week.

Best Regards,
Petr
