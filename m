Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A06FC5
	for <live-patching@vger.kernel.org>; Thu, 18 Jun 2026 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750135; cv=pass; b=ou5KkUVMNV+vsM4J8zQey6GAngnNNyHOwSqXm1sqj5ppdO8e3INb3n7ariphw5bfJ3xKZgSVkgGzO+Iabpz2ff0OlUb8YFjmmOy9gjVJa+CpYZOxP90VF1aRRpFWQMvgKIqpp3v0Pwt++hh9Xo9hwolS99MsyIP4ENN5D8cS+ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750135; c=relaxed/simple;
	bh=zkDtBhvBpZVd2sIGm4Z96/QKSJ0CY+5haiEQAF9nt98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ9Yef5Xddep0nR6e0/BTkR5mOnA3vXRmNtSwKzH/r6R44i0Zks1PJloCawtPtHpAdXO3OcCO1E6JlStSQOuh0tmhYqq6eczaacTm/ZB9vDYvwmua23cYuW6LCKmYnGT6sd8QhOfsFnZX0wMeW187u3lTk1nHo/05sNNH82OxpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxbBzTcU; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxbBzTcU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7fffb090ddfso1804747b3.1
        for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 19:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781750133; cv=none;
        d=google.com; s=arc-20240605;
        b=d00Iktyf2wEXCIz4r4GY+VNXk1f506jZvIwgz4I2mXR2T0/w/DM7de/28D+mnqYpUj
         LUAA+3qXu772vHHCWNR1vLv2JxE+MmhH2kjkG5LZS1HIE8pttK9CfpuOo3wbyiXVOct+
         mdawCBz/Ct0qvj+rPhiyz2ZRGN27z/1xK/iwOg5daklBIrKj1IKnZMRgw4hlbUbnWKdR
         Z4rEP6yyQaIg6Svuzq4UaDP2lNGpxWCjhtA8T4grH3ysEQiDqvr0379DHRdNdRq7w8iJ
         qD34ZcigO6LYM8S8hh3arWKyIG8Dohp1vMkCB4fEc5xLJBtRBtAXOleL0Jw5FKx4dxq5
         eTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W7jH/qGVqej8M9Hl9mI5H2NT4u/9LT9Sm9wQOuA14vI=;
        fh=YrOpBD/9mcD97AgXX9bToKVhugVPwkOZcNq+IcU5wDk=;
        b=W9QftX+l2PV67vZ85xOfjWbA65BpIadOJ3v2kUBSSA7ZU4AayChfO7vJkboEtSMrst
         muc1saZMVyajd4QWpLuQpVaCyQ8JdiCuPphPdHw1PFpU93fF1gL1KeQNRwH1Xn4PJ961
         uP+VveZapNdeqBMqSx0sHpH1uhR/xt/yW5P64yt16R0np/QpKJypcdi2WAeZHjzO0TW/
         +4FIwlHfa4un3007n8y3xmTy5ky7ElBrFGQyqRJMZvZ6Fa6EVhbvA35u56rMeNmQXnFs
         Jq3zJdcmw1EyVZUfgswVuuRDMjI/bZ+ipQbpdykBXLt1sTbSy/EZ3PTe/NmPgayr7ScZ
         9qdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781750133; x=1782354933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7jH/qGVqej8M9Hl9mI5H2NT4u/9LT9Sm9wQOuA14vI=;
        b=cxbBzTcU0uNkuuuKbs4Yx5/bSr7UM8ntmViJeYqDQgc3sYi7xbo7KfLYfZntYOq5/x
         TXsPcZfnyjklg0ck9vU4net0opl5PZvmBYodx0MVKGc7uwNejfwxF2aNa4vZzOX72PY7
         el86PCJQxQLHi4MI/lPnXQBC386VXy/pZQA7S8+iRIx4y1REXZtb/Ak4SLDc3mZuZjAk
         Z/kZHH9wnMPZ2CZ79QhzNg+2U4p2vglad9aDhCuNeMz8U1LnHKH4pxxKLoJLmS2utNtD
         mwe0VWBNGJ7Oa8wNDKF9YitEyQaGHlCqN6YvrCyfEklaFJzhdVEbWlIwxvXeEzqkZJsF
         5DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781750133; x=1782354933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7jH/qGVqej8M9Hl9mI5H2NT4u/9LT9Sm9wQOuA14vI=;
        b=Uk8moe6IbRylIfy/VuYNdw8ZWdBBFQ7bS9L/xZGFsjLLgNDusC9tjF6iW5hMKC2Be0
         7a/y4b8upQHIy+8k01vVnIdOPn8/s4QJ6p7XlhJSJZERaK9iV/0wbemYnSvoDLSaTeiJ
         q3cZy3BxVsRvr8yUn0k/bWSOTGOITJ8/oOjKestmgXJpmgCFi0x0/5ecLDDWdjknSYPj
         iNJ4hOklj1sPdeZ22WTXgqF7NDMliIG3BrzxohzzePQyM71pMF5OYbrB6MT19g7eUziy
         /vuBXZbBONVHTdzZrtR3lraQhZFX1Vp+zIXxpm5Kg/3JaKRN5HDz2nHgbfU5TOVadkwP
         wkSA==
X-Forwarded-Encrypted: i=1; AFNElJ9WBEf+BH3URGmRs6WN0gjdIpPqxF4FlQlljOkWwWWBXjDQb30nrPGZ9LI0PGbZpgZe2k5Mcc0gXJ02pykz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FdDOzjrJuEc10eQ5SaHEKSJhwVCqrkrO2G2ufSuJZzNQvHBO
	NzMbx8REKuBRy3COuzW3kMT8OBrTcnRMNMqCSkTyX5Mug1QZgJi7EXJ7F3/xrgh8DZjc7zYjCwi
	NNKyv+FO/pAZKHYUo4ZIkOKbPGvL3NL0=
X-Gm-Gg: AfdE7cnXK6woQC+51PznUOTQNJ+lOtwBMzVQI1ko/dc4dPFguqBf6dZ4b0ns3rZGlHa
	yfsNHW7joKupg2JvXpDzuhZWs2TuTtPyLHcOvqGVHOYVFF/8i1Gzfc2N3IDdpH7Zd8EHlchJ30r
	uVSsyrRCanggt6DRE8/W0r+rtWfgzkR2rsWZ08vUfApRP8Hq2aJZYXUiKeNMu3YZZmUx4baG+RS
	DfxpZ6Ln9gobgmj7ZuPyF1JgjZgFJNnhBd5MD65WvqYz30gqNKbclaRiQ7TlHpQeAFagM8g5wGp
	iTA+KXNSeRd+su2qiTK9rOZBi15a9w==
X-Received: by 2002:a05:690c:f14:b0:7b1:d1af:4b93 with SMTP id
 00721157ae682-7ffa2c68012mr19415617b3.23.1781750132600; Wed, 17 Jun 2026
 19:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com> <ajKmm5GIkvRUlJ2c@pathway.suse.cz> <ajL-Y3dapC1FiAwx@redhat.com>
In-Reply-To: <ajL-Y3dapC1FiAwx@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 18 Jun 2026 10:34:56 +0800
X-Gm-Features: AVVi8CfX3Q6CL7B95GE8-wGwBsJNqEXgz5ldkm4oI-VeYrHiCaOaQoOiG4VTvjY
Message-ID: <CALOAHbB+NZgwTpnBjdXhPLuTN0HOeiCRw7VqMV_B_WqmNEAQuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 4:07=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Wed, Jun 17, 2026 at 03:52:27PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
> > > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > [ ... snip ... ]
> > > I'm not against supercedes functionality, but continuing the
> > > brainstorming: what about solution 1 (.replace_set=3D0 special) with =
a
> > > special zero-day overlay?
> >
> > I continue with the brainstorming ;-)
> >
>
> Thanks for walking through it with me.  Your reply crossed with my note
> to Yafang at nearly the same time.
>
> > [ ... snip ... ]
> > > So maybe it boils down to: is the supercedes big hammer desired and s=
afe
> > > enough to deploy?
> >
> > I personally like the solution with a zero-terminated array of
> > replace_sets:
> >
> >       struct patch {
> >              [...]
> >              unsigned int *replace_sets;
> >              [...],
> >       };
> >
> > , which would allow to build a cumulative livepatch which replaces
> > known hotfixes out of box.
> >
>
> Question on this at the bottom ...
>
> > Note that the hotfix should not be allowed to modify a function or
> > livepatch state which is modified by another livepatch. It would
> > be dangerous. We should allow to solve this only by a cumulative
> > livepatch.
> >
>
> Agreed.
>
> > IMHO, the OS vendor should not touch customer specific livepatches
> > by default. The customer installed them for a reason. We should
> > just refuse to install two conflicting livepatches. Where
> > we could reliably compare only the livepatched functions.
> > But it still is good because most livepatches only modify
> > functions.
> >
> > Plus, I would still allow to resolve the possible conflict by using
> > the atomic replace. It could be done by a module-specific parameter.
> > I would call it: override_replace_sets=3DX[,Y]... or so.
> >
>
> Naming nitpick: "override_replace_sets" sounds like it may override the
> "replace_sets" value and not supplement it.  But that's just an
> implementation detail to bikeshed later :D
>
> > Finally, I assume that most users will keep using only the default
> > replace_sets=3D0 [*]. They will never have to deal with another sets.
> >
> > The non-default replace sets will be only for adventurous users
> > who want to deal with the complexity and accept the risks.
> >
> > [*] It we allow the zero-terminated array of replace_sets then
> >     zero should not be the default. Or it could be but it would
> >     be a special set which could never be replaced by anything
> >     else than another zero replace set.
> >
> >     The zero replace set might be for users who do not want to
> >     deal with the complexity at all. For example, for an os-vendor
> >     who does not want to release separate hotfixes.
> >
>
> Hmm, I do like the default replace_sets=3D0 not dealing with the
> complication of the replace sets.
>
> But first, back to the larger question I mentioned at the beginning.
>
> Originally there was:
>
>   unsigned int replace_set;            /* the set I belong to */
>   const unsigned int *supersedes;      /* other sets I also replace */
>
> and now it's just:
>
>   unsigned int *replace_sets;          /* sets I belong to AND replace? *=
/
>
> Could you trace through a few cycles of cumulative + hotfix releases with
> this approach?  For example:
>
>   Wed: klp-1a: cumulative    (replace_sets=3D{1})
>   Thu: klp-1b: hotfix        (replace_sets=3D{2})     <- coexists with kl=
p-1a
>   Fri: klp-1c: hotfix v2     (replace_sets=3D{2})     <- replaces klp-1b =
(same set)
>   Mon: klp-2a: cumulative    (replace_sets=3D{1,2})   <- replaces klp-1a =
AND wipes klp-1c *
>   Tue: klp-2b: hotfix        (replace_sets=3D{2})     <- coexists with kl=
p-2a
>
> [*] After klp-2a loads with {1, 2}, is it permanently in both sets?  Or
>     does it just evict set 2 and then only occupy set 1 going forward?  T=
he
>     latter makes klp-2b's load straightforward.
>
> I can read replace_sets two ways:
>
>   1. Positional: { set [, eviction_set ...] } where the first element is
>      the patch's own set and the rest are evicted on load.
>
>   2. Flat: the patch belongs to every listed set equally.  But then how
>      could klp-2b load into set 2 without replacing the entire
>      cumulative klp-2a that also occupies it?

I support the flat mode approach. The hotfix should be assigned to a
set that is not currently in use =E2=80=94 for example, klp-2a should selec=
t a
new set like set 3. The core design idea is to set replace_set
dynamically. To determine which sets are already occupied, a
user-space script can inspect /sys/kernel/livepatch/*/replace_set.

--=20
Regards
Yafang
