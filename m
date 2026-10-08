Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0731A6807
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457496; cv=pass; b=HTsNPtx8KfrddoJvZWZP0k2IDUpVzjWDKrarp2Uu316YrK405z54mU0S9v091Fmw0rhyF2Gy2STWoP30OuE70LVJXD60dsjPvCRYkyW0APVorrZHPPL9mZ0KCL4uy11ajedJRErShwbUiOvstCZA6XR9WSrFzgzV6xa7P1l9xfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457496; c=relaxed/simple;
	bh=RLIGvvX/O6DWb0/MvfXlelkAYEWJ0MDsulwHdTk0atc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8zKRCr1BMkxI+SMF+VLXzl7DsD4zqs+xGWTJNevQQTK9DEmIOXm4eiGKtxoZ3UnLDB6jEjsUeamkMjcBMYSv6qNrWgVgK9Iw6e9/mQUQIfDbJuyrI7nbtDH9L8gsXgP7mZKUh1qQfhKsvXdl7GFVygNd0bWx+4DaDXEzb8w9zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXUd8M17; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXUd8M17"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-677cc343120so5021336d50.0
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 04:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791457493; cv=none;
        d=google.com; s=arc-20260327;
        b=XFN1QwvKkQN8YbsejQqM9KEjVabKwgdZd5jR1DRZbHwq9ayfH5sSocmNJ28c0kBXkF
         gAbmZxzf7wwJ8rbGfKsX+KuITwRZTEzjWYKrruf2GWkaIeIek3Vt/5LNHJAHKbcCSKhM
         YmQyXKASrVRN/7CfVohl6iyCxL8hFDusS95vb8mpBhfchTV6R995HkBmozx1XiHyrHjt
         +AO5pVkFxjSmSpA70FJjLK/sr6rLDw3b03jRfsK6eRxLpHjUpccL02atUplwN92Lp5qi
         g4gL/0DTO49Dzdwyf5W4lWAKlEI8hPqe8id98DyFhQ2LuNDzBhv3wYahArqT6VvQ7REX
         9/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=47GJUdOpTDvnrmPAnVoQ8dCLEg1gEaIf0wyqZeZeyrA=;
        fh=YcWUHK2zjzpbMLjDikzRiaYOsLDmZW1zM/OlrTRHVSA=;
        b=nCBrFKWdgrkNUNwXXubbx5o67V+JxjM14+RjUkp3rOXbLPGNbA8JL7P8z3mOxubuy4
         eT5hdv4PjwEMPKNztvMtV/cYleBlxGh3C7BB6Mc3y52lEvRAN9x7zyvaBHpR5ZfHdBln
         byTihvyxfH9jEDtvNsex/v4ata5hfbS8ln4BqEf5hyDUPTKN18bXNiZiMiBtRZ7fvYfA
         yvjIx9wjY9wxEv5JyYCLBwkFSlEIV/kHd9KsH/8I7hGybqdG4mioxEj9rmVFfuMSJ156
         oi6npX4cA/84CFKQfaz4ViXOY24JTK8YXn7i3WIipB6zuvEV4TVFSb+tmFyPGFL6jViG
         6L7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457493; x=1792062293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=47GJUdOpTDvnrmPAnVoQ8dCLEg1gEaIf0wyqZeZeyrA=;
        b=fXUd8M17O6WfRZDvaApK/IxXmGUKivTWxnTQtk5DrfJo2NkIaQ0ClBf6miHYUD8GlX
         wW3wjDHlgmDeaF7PSSI0cF9fc4yJHEoIJQyqYbqEvMz+G7grjJZD6ItdG6scTG8AXOO1
         42OMGEH7ZBp0dRV/JNnCrEaA+8sqGb5fD05FtJ3bwyputL6ylUVkDs98MERAPeHGdSLY
         d4FFmc1lOMpjXUNR2VJP23g8/6S4WsKzcZ6riESSs90YhNe0iGfK/wwavdY2gVuHxEwp
         qZL/z0hjnwSKCcECwqQc14XEfHwuy73C0jURi8EN3Wv57ATjvk4wRjuoioTKO0nkgHaL
         LTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457493; x=1792062293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47GJUdOpTDvnrmPAnVoQ8dCLEg1gEaIf0wyqZeZeyrA=;
        b=M//EHAboTGSo4/29pXrTc3JGjGdB0MfxoOrRo/RF9ceFjWf6bPfSFtCSnFcwnRAl7s
         PfN5mXwWICCvmJzFM0ggvrKxwlkVnVWSBPy74D466kxgNBNlqMgH685aX6a2uWz6oLC0
         o6gKH8aJFnVjr0yppOn/xLBBpRECFo3dYA4jk8TsGUenj7Va1J952KPmOswU0DPg7dAc
         LCoQB76TPAR6MFrXThWKzJtfvlQmxjYCwqKF9V0eAR0d/QHXu2rB4lcxQCAry0hENIw8
         hDQDdrNHjg93GAS+7ye27JEBNRTvT8LPxeJfcpN3wOWbdJfJ/GdJg7ajWPNoitKEdYR4
         s7UA==
X-Forwarded-Encrypted: i=1; AKwUvBwI+cI58KwMZUM4mUMOlQ6OHNP4N5V5jjVVY+FqGDBM37qL3aQEiDFsfOpdlfQl6PUdfmVHQnGmmxtnnuSR@vger.kernel.org
X-Gm-Message-State: AFq9FYLps5vKlt8PAkd/R58imgvj7HicFJFy9MyEIwU5NCB0rf1EV2NC
	nVALVf8gVG4Z/is92SaHXDc/JUmh7EOQrft6wtd4NSQ4dCy/zHr3nfrAx+Qq/wHMUbA9yCy//3C
	KE4UujuRDf0tVCT6JDct8PxjiArUU8B8=
X-Gm-Gg: AYBFou1QTugVu3dcYt8hKy17VbNQ2KDMardEYZ9STIboz26J6PXxU5gDFpnNWNw1s+b
	7oystwFYqtj+aBZuVIRD29cDrw3sqtP4sLux5sIdh1H2uCDOH07JOVVwoT9ozBQ6wjfH/l3qNSs
	nHwBmZaYhUYgX2zybZ4T+z6pa8x/L5waDVuEf+bvkO7HqEf1AYnYZMXG31cY/DRYd3FVsUyHAgB
	B5bhs8W51Fqv+MwHN8jHcNr8YGiKHocbTNg5d/31alE8zpqSySTnunL/jwDn0IEXVffymy/CJAP
	12dHjJF70hq/Otd9PotLFOWt//h/edXnNd6bQkQBE5+lIz7kJulg8PvS8eodQ7c7VPXt8E14pPe
	PZVt+FeU/yGcuzjiRWrXl
X-Received: by 2002:a05:690e:134f:b0:677:cff5:52ac with SMTP id
 956f58d0204a3-6790a49a41amr3133024d50.73.1791457491970; Thu, 08 Oct 2026
 04:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930030323.14396-1-laoar.shao@gmail.com> <20260930030323.14396-6-laoar.shao@gmail.com>
 <ar_kouwlAGcnnUYQ@pathway.suse.cz> <CALOAHbCHwJ2htPOoako_EqNg-bQF=4NLNqVGAnzsAi2uitMdeQ@mail.gmail.com>
 <asdwx-BENZy6dajG@pathway.suse.cz>
In-Reply-To: <asdwx-BENZy6dajG@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 8 Oct 2026 19:04:15 +0800
X-Gm-Features: AclHuK_mUG6NrIGmcaoKDsjmRN3oWtTglg6FkbrhnC7fP6lNcu-kIXjY8xD6ro8
Message-ID: <CALOAHbC3p30s8sQwd5OO6DLqQ+5qvpFyyRWb2p05mmMabO7E6g@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 6:30=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Sun 2026-10-04 23:46:29, Yafang Shao wrote:
> > On Sat, Oct 3, 2026 at 1:06=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > >
> > > On Wed 2026-09-30 11:03:19, Yafang Shao wrote:
> > > > The current bool replace flag is too coarse: it is either all or
> > > > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > > > livepatches, which is safe but inflexible. There is no way to have
> > > > multiple independent livepatch sets coexist on the same system.
> > > >
> > > > Replace it with a more flexible model using two new fields in
> > > > struct klp_patch:
> > > >
> > > > - provides: an unsigned int id identifying the changes made by
> > > >   the related livepatch. Where the changes are a set
> > > >   of modified objects, functions, and used callbacks,
> > > >   shadow variable ids, and state ids.
> > > >
> > > > - obsoletes: an optional array of unsigned int ids specifying
> > > >   additional provides ids to be replaced. This allows a new patch
> > > >   to explicitly obsolete patches from different scopes.
> > > >
> > > > A new livepatch atomically replaces any existing livepatch that
> > > > meets any of the following conditions:
> > > > 1. It has the same provides id as the new patch,
> > > > 2. Its provides id is listed in the new patch's obsoletes list, or
> > > > 3. The new patch's provides id is listed in its obsoletes list
> > > >    (the obsoletes relationship is symmetric).
> > > >
> > > > The obsoletes relationship is symmetric: two livepatches that
> > > > obsolete each other are mutually exclusive. Loading either one
> > > > atomically removes the other, so they can never be enabled at the
> > > > same time. This allows swapping between two independently prepared
> > > > livepatches that cover the same scope, in either direction.
> > >
> > > Honestly, I am confused by the 3rd rule and by the last paragraph.
> > > It is not compatible with my understanding of the provides/obsoletes
> > > semantic.
> >
> > Correct. In package management semantics, Obsoletes is not a symmetric
> > relationship.
> >
> > >
> > > In my mental model, the provides and obsoletes define which
> > > way is supported. Let me show an example, let's have:
> > >
> > >  Livepatch A:
> > >    + provides: 1
> > >    + obsoletes:
> > >
> > >  Livepatch B:
> > >    + provides: 2
> > >    + obsoletes: 1
> > >
> > >  Livepatch C:
> > >    + provides: 3
> > >    + obsoletes: 1,2
> > >
> > >  Livepatch D:
> > >    + provides: 2
> > >    + obsoletes: 1,3
> > >
> > > How is this supposed to work, please?
> > >
> > > In my mental model:
> > >
> > >   Livepatch A:
> > >      + can be replaced by B, C, or D because they all obsolete 1
> > >      + can _not_ replace B, C, D because A does not obsolete 2 and/or=
 3.
> > >
> > >   Livepatch B:
> > >     + can be replaced by C because C obsoletes both 1 and 2
> > >     + can be replaced by D beause D provides 2 and obsoletes 1
> > >     + can't replace C or D because B neither provides not obsoletes 3=
.
> > >
> > >   Livepatch C:
> > >     + can be replaced by D because D provides and obsoletes
> > >        all ids which are proviced and obsoleted by D
> > >
> > >     + can replace D from the same reasons.
> > >
> > >
> > > OK, I understand that it might be practical to allow replacing
> > > the patches just because they are "conflicting". As a kind
> > > of revert/downgrade.
> >
> > Right. This will let us easily roll back the buggy livepatch and
> > reinstall the old one as part of the rollout.
> >
> > >
> > > It might help to rename "obsoletes" to "conflicts". And just
> > > say that the livepatch replaces livepatch with the same id
> > > in provides and also all conflicting patches.
> > >
> > > But then I see another problem. We have three types of conflicts:
> > >
> > >   1. same id in provides/obsoletes/conflicts
> > >   2. same livepatches function
> > >   3. same livepatch state id
> > >
> > > It is weird that we would silently replace livepatches with 1st
> > > type conflict. But we would refuse to load the livepatch with
> > > the 2nd and/or 3rd type conflict.
> > >
> > > Note that the inconsistent handling of conflicts exists in
> > > this patch even when the array is called "obsoletes". My proposal
> > > to rename it to "conflicts" just helped me to see this
> > > inconsistence.
> > >
> > > Any option/idea? Yet another naming?
> >
> > Perhaps it could use a better name, but I'm not good at naming things ;=
)
> >
> > >
> > > One more thing, the commit message does not describe that
> > > the livepatches might conflict when livepatching the same
> > > function or using the same state id. It is important part
> > > of the semantic and must be documented.
> >
> > Sure. I will update it.
> >
> > >
> > > Best Regards,
> > > Petr
> > >
> > > PS: I am sorry but I won't be able to finish the review before
> > >     the Plumbers conference. But I am happy that I have found
> > >     the above problem. We could discuss it at the conference
> > >     and come up with some sane naming and semantic.
> >
> > I can't be there in person, but I believe we'll come up with a
> > sensible name or semantic. I'll hold off until we reach a final
> > conclusion.
>
> I am not sure if you saw the video from the the conference.

Song has shared the results with me offline. Thank you all so much!

> It looked like we were going to nack this feature because
> installing more livepatches on the system was considered
> too dangerous.
>
> In particular, it allows using livepatches provided by different
> teams/vendors. It is almost impossible to prevent incompatible
> changes and breaking the system. The check preventing livepatching
> the same function or using the same state IDs is just the best
> effort but it still allows many hidden incompatibilities.
>
> We should rather discourage people installing more livepatches
> in parallel.
>
> Anyway, we had a follow-up discussion and agreed to accept this
> feature in the end. We already allow to install more livepatches
> in parallel. So this patchset is not adding any new danger.
> Instead, it reduces the danger a bit without complicating the
> code too much.
>
> Also we understand that there might be some use cases for this
> feature. And it might be safe when used carefully.
>
>
> We also discussed the semantic of the obsolete field and we
> would like to it simple. The livepatch with a provides ID should
> replace a livepatch with another provides ID _only_ when the other
> ID is mentioned in obsoletes.
>
> By other words, please remove the symmetry and "support" for
> a rollback. The symmetry causes some confusion as explained
> before. I would summarize it by two reasons:
>
>    + In the packaging world, the "obsoletes" behavior is not
>      symmetric.
>
>    + The symmetric behavior adds a "conflict" semantic. But
>      this particular conflict is handled another way than
>      the other conflicts (livepatches functions, state IDs).
>      I mean replacing an already enabled livepatch vs.
>      rejecting the new one.
>
> In addition, we do not support the rollback in all situations,
> for example, let's have:
>
> Livepatch A:
>   + provides: 1
>   + obsoletes:
>
> Livepatch B:
>   + provides: 2
>   + obsoletes:
>
> Livepatch C:
>   + provides: 3
>   + obsoletes: 1,2
>
> The meaning is:
>
>   + A and B are independent livepatches.
>   + C adds some dependency and has to replace both A and B.
>
> Here a proper rollback from C to A+B would require loading both
> A and B livepatches synchronously. It would require adding
> special support into the module loader and the livepatch core code.
> We do not want to add this complexity. Especially, because
> the parallel installation of livepatches is considered a bad
> practice.
>
> A partial workaround might be to allow changing "obsoletes" via
> a livepatch module parameter. It would allow to do the
> rollback in 2 steps:
>
>    modprobe obsoletes=3D3 livepatch_A
>    modprobe livepatch_B
>
> It is still not an atomic rollback. But it is better than
> without the parameter which would require 3 steps:
>
>    echo 0 > /sys/kernel/livepatch/livepatch_C/enabled
>    modprobe livepatch_A
>    modprobe livepatch_B
>
>

Thank you for the review! I had actually sent v11 before your email
arrived =E2=80=94 you can find it here:

https://lore.kernel.org/live-patching/20261008095830.26308-1-laoar.shao@gma=
il.com/

Regarding your summary:

>
> Summary:
>
> We are open to accept this feature but please:
>
>     + Remove the symmetric handling of obsolete flag.

Done in v11.

>
>     + Properly document, in both the commit message and
>       documentation, when the livepatches will be replaced
>       and when they will conflict.

Done in v11.

>
>     + Document the pitfalls with the rollback.

Not yet addressed =E2=80=94 I'll cover this in the next revision.

>
>     + Add a warning that installing more livepatches in parallel
>       is dangerous, especially when they are provided by different
>       teams or vendors. The built-in checks of possible conflicts
>       do not prevent potential incompatibilities and breakages.

Not yet addressed =E2=80=94 planned for the next revision as well.

>
>
> Heh, I hope that I got it right.

If you have a chance, could you take a look at v11 and let me know if
there's anything else I should address?
Thanks again for your time and guidance!

--=20
Regards
Yafang
