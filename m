Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F062EDD40
	for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781664090; cv=pass; b=HElqNrOJ9A/dHgzcgKUdOQr8jJhw7rWOT+O/rdFV2fdC3/qgLkaP+d/Mfqgumxq9cUyfampG/+nRacK3tEl9Rjog3uSFkGeL7p0pzpG9ENQhc0n11Fu5Q6xz9e9bWL40SughnvjHdujD5wCrm2I0YnrYEzl7anu3PZQt1Jk+LTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781664090; c=relaxed/simple;
	bh=AHe2fFLdeCnTCWTiBxpZPtqz4WPJbjzj45HpVZyRRPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f32pDfF0SRzZZ4Aqxa1f0Br7BBzzZPl911r7QsXZNpemgS15Wdk7slROGy5j6hg/pbEyK/c30CAvqfQa1m1apXX+BaUD5cuZQdmzZ53/gJNCJcvNb1J+jcFhaIU5Y+QNdLEjHv2P+O1O2XbbT+GkV0L4tLYbN1fPA3VTzMzXYSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ1c9Ep3; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ1c9Ep3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7defee656dcso32771247b3.0
        for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 19:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781664088; cv=none;
        d=google.com; s=arc-20240605;
        b=bLnUxQgtbMK/r0t6MnuEKiCd9NUEpFIdurNbYAVpalow/TNPgZsxNzvTtJS6fvv6Y6
         BUqrUFvhx+7bE3nI/kpdt2MsRMHjAWpwz+Ykg1X1CYkSHhcVAgWxKF1yBJWQ99qsDVly
         NsRPOnETxlVy+VIwEf6Qnn310XNGbAJLuBJiSqEIMOYZlJBzy38mj5XdUM2Ct8UEbFvq
         v5j3WgFOiy+bkL/N2D44rT5pfCzT/jUetEu1bXm4noHBswUUVjeo8IzHIoVZZZTHBkMw
         +5dWNXXLqVyl7CzBJCUkcbbdwLp+15oOm6sSZz/tTEodc0c4iUxGxCuRCWDNo5lNjIqA
         iINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53qLaF+MIwPmKvE1CF2flDMIbHq65/mAJwN5K3X2Ufo=;
        fh=Z+1/chVZ+ZgLWyDhwHX60Lo8E8ac53czJ+WABpJ+EYc=;
        b=ZB/DVXFFXF68TLpnP9LSdTfbInHvMkfHKW//Ky2rhUnPVRNCVrCtJ4x0ofUdj6KpvN
         c62csrEgNiGjuqBeZjfeLmWBWenzUR0Hu9CzPHR+23+dvh7WPSlOBJw6QiHCk7HkR1xf
         5zriBUBLjFo5SZ7U/uE0VFxzQikP2BOXm+lmCzcxUA/z73/rW6TgzjKrsODAmxki1vPB
         40cyv/ZBt8AUwD9ifOyaQX3e3RxCHaWu4MXuDwm/T32gWGquG+caIpHHuELbUC3tKrPe
         qthGt/xXLXKp6jT3jWeaEKAibC2noCi30+9r32Jo7HDWwHqua0AwKdS6iSuz3dACwjOz
         J5GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781664088; x=1782268888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53qLaF+MIwPmKvE1CF2flDMIbHq65/mAJwN5K3X2Ufo=;
        b=YJ1c9Ep3RxIDypSZHQNLi1f14cWX0DPwRMCA5u6553v1bU1XRMh3/aMEcGJYvq4BtV
         OyXH6lTHr//RXhK8UD6mLoBB6/SGDvoERjGf0ocmNXZXW6pLw0CaE05TInP7CJ16uNEX
         IehrJswbyMVVvVt+hgVd/cE+EzWpcCZs6XlZTzdt6yWP17EtFzfNdogtXeUyWmDFuBlh
         BHmJ/9tn0G88RzYquGHtTpxo1fwVTZGj6a//Nh6zG+7YEjoT9zlP14BF1OsCy7AfMOJZ
         9KEOj4eCt6O8q4vSpBjfQW5+8wj7yhj64PEDdnm5KtHtQIxWPJRUCSIEjpKPvJdYbC2N
         txyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781664088; x=1782268888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53qLaF+MIwPmKvE1CF2flDMIbHq65/mAJwN5K3X2Ufo=;
        b=SzRAqnR2N2cf9135hJnnU7ESq71+fe2rGloNv9hVCt1L/2P76aoJKuNuTtHfMTpETY
         Nv8RFf5RQR6boeulGtUO1gfGlK/NoztxAaaQ/xcaVpyhvenFd0hfvAO1KMcfgEXJgkCV
         aApe6KiN8geos2jSNEpCjqM7VApK/hDXnP3stMyLSoQsSbjD61LHsdUTaoyOaRoaXERS
         59QyTzgWDXTDBWTXZKdRNa6kHaBffqgMOE0sLMwrr8xZO+Y4idjvdo1Dc40oUKtg5ney
         +xN8ROAj8oQpf/+s1m+qFhVhyayW/UEbBZtR48hq3+ozI7sc60l56SMzpbYcrem7+zjU
         wXgg==
X-Forwarded-Encrypted: i=1; AFNElJ8XRInM626cA7VzXs1pVTFYZZsQXpHzvIiKKrRon5cCP1jA0y6Fg/oiX2Th/OB4p580Z6TEltxsOCAkC3GQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzYt2uqZ3mRc4LLaVJJPpjnTj/g+HbCLuoGkj7LoDz2GCw938
	4eTef0i1ux/ikvigc6IbWMQZA5nXdZ7CZxKQws0+62iCS1B5GvgLbkQdB1973AkUINQ1EKf0h6X
	mDaUhzf0wPE5vWS/ATTxiTndlXlaw6Jw=
X-Gm-Gg: AfdE7clA43RUXkGGToYmPK8YLujknU9F2ESRdzPDD+yOKlNJ66sZFCUp/p+OWdB5Jpx
	N/NB0UM950gcsRR7jsjBwXtIzrIyoBrWxuuabK2gx74nSXiQRsWR2ISxf0B12iKwPmvkgIcVOg/
	uUIQ6UG0QvEhjdwW+PerMHKvDuC4AYtG46a03MxgFpfRUeWTIIQYMtfd11oS3hbWjQhNUxSuFLS
	t+XwI8Oc7gR9KJIy9rTzzdp7b0rVmYOPKBJ1S5pE1Whym9xNIuVWXIjq02w2nNVWkcdsG6od/3Z
	HSTmn89QjeZHp9FkqDYi+0NS0IVmkQ==
X-Received: by 2002:a05:690c:d20:b0:7bd:7d69:764b with SMTP id
 00721157ae682-7fe5e799bd9mr16871887b3.39.1781664087616; Tue, 16 Jun 2026
 19:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz> <ajGu1cP2znjHmN2H@redhat.com>
In-Reply-To: <ajGu1cP2znjHmN2H@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 17 Jun 2026 10:40:50 +0800
X-Gm-Features: AVVi8Ce2ojKQ5l3wOVmcVPuEPhqrSEuqgIesiVKMetykYFfn6yr7M2D-uBTxQDc
Message-ID: <CALOAHbCSwj9EtYjNA_zoAj_+2PYb9i+U9hLJeHd78S8HBkOdQA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:15=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > I would write something like:
> > >
> > > <proposal>
> > > The practice shows that the current semantic of the patch.replace fla=
g is
> > > not ideal.
> > >
> > > The atomic replace is disabled by default. And the no-replace mode al=
lows
> > > wild installation of many livepatches in parallel. The author and
> > > administrator are fully responsible for preventing problems caused
> > > by producing and installing incompatible livepatches.
> > >
> > > The most safe atomic replace mode must be explicitly enabled by
> > > setting "patch.replace =3D true". It is all or nothing. The livepatch
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
> > > .replace_set =3D 0.
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
> > > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-i=
ter12 [0]
> > >
> > > I have realized that I actually sent "v1-iter12" to the public
> > > mailing list as the official v1. So we could use:
> > >
> > > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.=
com/ [0]
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
> > > 1. Make .replace_set=3D0 special so that it will always replace
> > >    everything. Similar to the current .replace=3Dtrue mode.
> > >
> > >    Customers will still be able to install custom livepatches
> > >    later with .replace_set !=3D 0. But the "0" livepatch will
> > >    always wipe them out.
> >
> > This is not ideal because it is asymetric. Why is "0" special?
> >
>
> Hah, why is zero special?  Because we said so and the asymmetry is the
> point. :)  On my first pass through this patchset and reply chain, I'd
> say I lean toward approach (1) as it's dead simple and means not
> participating in replace_set values =3D no functional changes for the
> former atomic-replace user ...

Making zero a special case might reintroduce the issues with
cumulative and non-cumulative patches. See the detailed example below.

>
> >
> > > 2. Use two flags in the livepatch, for example
> > >
> > >      a. Rename .replace to .replace_all. The livepatch with this
> > >     flag set will always wipe all other livepatches.
> > >
> > >      b. Add .replace_set which will allow to install more livepatches
> > >     in parallel, replace the livepatches with the same .replace_set
> > >     atomically, and check the compatibility. As described above.
> > >
> > >     It is a bit more complicated. But it is more compatible with
> > >     the current state. And it removes the special meaning of
> > >     .replace_set =3D=3D 0.
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
> >       const unsigned int *supersedes;   /* Zero terminated array of rep=
lace_set IDs */
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
> > option to the cumulative livepatch, .e.g supersedes=3Did[,id]*
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
> brainstorming: what about solution 1 (.replace_set=3D0 special) with a
> special zero-day overlay?
>
> The model becomes:
>
> - replace_set: isolation sets (as Yafang has implemented)
> - overlay (bool): "I'm a partial addition to my set, not a full replaceme=
nt"
>
> and then the vendor zero-day scenario looks like:
>
>   Mon: cumulative patch (set 0, overlay=3Dfalse)
>   Tue: hotfix (set 0, overlay=3Dtrue) stacks on top, overrides one functi=
on

At this point, if the user reboots the machine, the loading order of
these livepatches becomes undetermined. If the hotfix is loaded first,
the cumulative patch loaded next will replace it. As a result, the
user must maintain the load order of these livepatches, which can be
quite painful.

>   Wed: new cumulative (set 0, overlay=3Dfalse) replaces both
>
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
>
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
>
> So maybe it boils down to: is the supersedes big hammer desired and safe
> enough to deploy?  Is overlay useful enough to be worth implementing?

--=20
Regards
Yafang
