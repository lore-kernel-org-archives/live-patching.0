Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86B3BD22E
	for <live-patching@vger.kernel.org>; Sun,  4 Oct 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128830; cv=pass; b=L1EGAIzEsgr27erq4Ssol+yAM6ELNc85jw6h0W8PKWyLbNwnZFaILfxAow5EnEcX9Dz8PpXn8O1zM95Q40os9pjzabaWqV3gbkWoS2VV6bQVX9JhOpYd2qqlQAjlMogjlwFnI/ZLTrSYKd/2GOKMEyTaVAh6SVzAg38NpiCRbH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128830; c=relaxed/simple;
	bh=JNlEqjhxDsXWcHoR5Q8vdud4pkFeeOU23CXWBtyaiDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3GBySeMtMhbPmn1/HLFzrriorRw+Ao6PCD7ujkwXEwijOxGLXyB5q68ukpeYSisvnifdT4DbbRWEYenZo6gwU32FJ4/j7U1dybr7iYRCIvUYPdzcKK3PJ7o4XlcX7FRsOVDN9fy1y6Uky2xc0dVtcCTF6A+e7spCOyHsavG02k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/OaD8Eu; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/OaD8Eu"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67583c777abso508195d50.1
        for <live-patching@vger.kernel.org>; Sun, 04 Oct 2026 08:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791128825; cv=none;
        d=google.com; s=arc-20260327;
        b=NkVKqYdsuFmju5bTZ6jf81x2LeUNDYORib+dAuyln2TbJlnLXrblZpwsl9hunkgLOw
         k5ouC2rT3EY7NHgjq2QdRyYjNnCmuqFFQcw9HzM4exj0NS4ZjK99B1gTX8e3PZLnPLQ/
         9+d6Bu8Y+WDa0omgHgB4Y5YxN/kE46nCy/Ig74xIe2uW9jn4cUQmcHuxt9clamm2wVZ9
         Vaj5aJfJ+70jDJmBfUct6uP3qWredft0Pz84x0C9EA9LRJ6/XjsTb8Aoi5np4iFn0Psm
         6fO2tfohJdUAtMVqlvlA9mOrSy4eyDfmRU/OKBiomyDZsiy6qBBshr0tTjEVXxxo1tlo
         OXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gP2+RRsLUnvdjs7OeYNNKND2sG4XSdNxOWydZ8R2nOk=;
        fh=vJHyv6u9+l3m2IPETee9hmxIE0SCdplUYdNYOGAP8cY=;
        b=D5mNLeISZFDiF6+iwwXGFQnHtBN6fIqBHAqmLUk3BIJS3yKdIhRbL00h611LImypvW
         JKkZzLDm0ggiaxk1Tu+1cEZ+WeoVQR4e2gs0bk9MMNSvQM4tGPX1yHx65dIkAOP/e/43
         Sl0TH1n/38iLlWAQevwwZYtLgOj/5NIWdIPu/w6RnGr7rfFNqPLPVNlQp5uIM7wItsSI
         yoDQFCzSUFFJ7soD9RVeQG0ITDbrzfNCFlNxco2zwuY8P+ejox4C3LJwdMY7s3Gl06Yy
         62mTLhQ0DFTTJwx3zype9ZKc00PQClCH2pFgw1/ebzGMu5MlgR54HWFfeTyg7IJQqM9S
         tQsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791128825; x=1791733625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gP2+RRsLUnvdjs7OeYNNKND2sG4XSdNxOWydZ8R2nOk=;
        b=K/OaD8EuO7sjq4uyOPYnXQMI1demoQRBRzkXKJhYh8w92uqySXZjIRrMVcajJQrk8+
         d85ui4jn2BFsv+pZPxVUcbLmsZnz/0pjrAC3qMcQbGiv03lgOSH3IkQLfRtYSsRdYok2
         Rvjt75MF2ounrSKomD5YiBv9jL9xzgrTjn6vz9D3dnv0SbdX0CjAeFmQmKUGn5CH7VYR
         RpEJCWX/ncIghQTjLdZgR/LdVukLg2v/YvB9b/ZIcKDWJ++UKdxtVg8bms7Oo3R02IYO
         1KqUsswjQ2jb6guVzeRP6CqxYB74MoiGyYrrxdA4AALNJ5Gs8Qn67oYJXHOFMg/ffAEX
         pu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791128825; x=1791733625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gP2+RRsLUnvdjs7OeYNNKND2sG4XSdNxOWydZ8R2nOk=;
        b=eWSFpX1oEAODg6j/81NRuUH8aimHW3Okf9tCqusy12NM3AFSHM8dAQL3LzwasY9SBr
         RgWDExTJ5fRObOHNu5ZRrZ2h7fcuJVhH80TdKYOAlxRo4Noa+dKQzE0M6jZ0Zypau67x
         cVZMriM5SZE9GQaOhKW+6VBORLE6bB+ydChZxxQRFnewchQRVmB5aacdVYy/pkNSQWDG
         kY8Gd/xZUHEU5AxMIgXnjb90YtMYcIzN83dERAaBnVaKKj1HHsyfhjhdLx65cXDCAI5B
         rtutIKQlSqTPb5pdWAC3oVAGX0ZfR18OzpYII4b1Vc6ox+sachFDifbkIIY4OiBM2X8h
         4AdQ==
X-Forwarded-Encrypted: i=1; AKwUvByJKEmPip/VqP5lZn0oDdYXk1YeoPljoaNuyLtwiogGEhMrS9gZ6ql+Soif8uFwVSy/RxFcuz8Ye5XPKZ1n@vger.kernel.org
X-Gm-Message-State: AFq9FYIXI9ytPAUOzSGLS2pgWUF2DBY2Y+UEe14ROAVp/P2lJDq8jjOL
	dAcQn9gYHp+C2AlVn2ZnPncPlir/lD5PAu0gTXtCsHAFqUt0nhSzOQYlyknOLcGVIrJs/SJHKKz
	BGXZlmp1lgOuQS0ESn+GNbtNH3Gw8PKw=
X-Gm-Gg: AYBFou0lVkp5LOqec2RqPE0wbAqFKQOP6KNSGm5rmMVAVNNBNkyEAJjcjlcyvUvr3P1
	AFKXh+6UR6luLFW6YvIOg/CSqKTN4cpheU/OX5OSBmQA++/GqUpycUIYhZrpC23uhFiE7UBtH1J
	3BATwA2suMc8nVdypSYxDyhojjJ13SwDt4LskfrEEkusDbRRvnOqVxneakbAkx6LAzvrdvHZLlK
	bUeMlDN7ZlG/dD1s6gRQZg7VZOReLUxUfPrj52OanO3UvF1WvbvC+0icI2DWQzlHw9xVhnRH/EF
	JhyQJnApE/1OELC8lQ7oAJz91FtkmlLE4X7vK7rARZGF8AauIt2TS5sZLq/rCKaK5kn7w7VhMzz
	At7brbrbAm0U=
X-Received: by 2002:a05:690e:418e:b0:677:bacc:ef24 with SMTP id
 956f58d0204a3-677baccf67amr1652890d50.18.1791128825512; Sun, 04 Oct 2026
 08:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930030323.14396-1-laoar.shao@gmail.com> <20260930030323.14396-6-laoar.shao@gmail.com>
 <ar_kouwlAGcnnUYQ@pathway.suse.cz>
In-Reply-To: <ar_kouwlAGcnnUYQ@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Oct 2026 23:46:29 +0800
X-Gm-Features: AclHuK8BrHZ8dfs7OY4W3hWHFFcoc5L4q7wuPW3bqlyONlnqHuIzG9ULvjC783Y
Message-ID: <CALOAHbCHwJ2htPOoako_EqNg-bQF=4NLNqVGAnzsAi2uitMdeQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 1:06=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2026-09-30 11:03:19, Yafang Shao wrote:
> > The current bool replace flag is too coarse: it is either all or
> > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > livepatches, which is safe but inflexible. There is no way to have
> > multiple independent livepatch sets coexist on the same system.
> >
> > Replace it with a more flexible model using two new fields in
> > struct klp_patch:
> >
> > - provides: an unsigned int id identifying the changes made by
> >   the related livepatch. Where the changes are a set
> >   of modified objects, functions, and used callbacks,
> >   shadow variable ids, and state ids.
> >
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different scopes.
> >
> > A new livepatch atomically replaces any existing livepatch that
> > meets any of the following conditions:
> > 1. It has the same provides id as the new patch,
> > 2. Its provides id is listed in the new patch's obsoletes list, or
> > 3. The new patch's provides id is listed in its obsoletes list
> >    (the obsoletes relationship is symmetric).
> >
> > The obsoletes relationship is symmetric: two livepatches that
> > obsolete each other are mutually exclusive. Loading either one
> > atomically removes the other, so they can never be enabled at the
> > same time. This allows swapping between two independently prepared
> > livepatches that cover the same scope, in either direction.
>
> Honestly, I am confused by the 3rd rule and by the last paragraph.
> It is not compatible with my understanding of the provides/obsoletes
> semantic.

Correct. In package management semantics, Obsoletes is not a symmetric
relationship.

>
> In my mental model, the provides and obsoletes define which
> way is supported. Let me show an example, let's have:
>
>  Livepatch A:
>    + provides: 1
>    + obsoletes:
>
>  Livepatch B:
>    + provides: 2
>    + obsoletes: 1
>
>  Livepatch C:
>    + provides: 3
>    + obsoletes: 1,2
>
>  Livepatch D:
>    + provides: 2
>    + obsoletes: 1,3
>
> How is this supposed to work, please?
>
> In my mental model:
>
>   Livepatch A:
>      + can be replaced by B, C, or D because they all obsolete 1
>      + can _not_ replace B, C, D because A does not obsolete 2 and/or 3.
>
>   Livepatch B:
>     + can be replaced by C because C obsoletes both 1 and 2
>     + can be replaced by D beause D provides 2 and obsoletes 1
>     + can't replace C or D because B neither provides not obsoletes 3.
>
>   Livepatch C:
>     + can be replaced by D because D provides and obsoletes
>        all ids which are proviced and obsoleted by D
>
>     + can replace D from the same reasons.
>
>
> OK, I understand that it might be practical to allow replacing
> the patches just because they are "conflicting". As a kind
> of revert/downgrade.

Right. This will let us easily roll back the buggy livepatch and
reinstall the old one as part of the rollout.

>
> It might help to rename "obsoletes" to "conflicts". And just
> say that the livepatch replaces livepatch with the same id
> in provides and also all conflicting patches.
>
> But then I see another problem. We have three types of conflicts:
>
>   1. same id in provides/obsoletes/conflicts
>   2. same livepatches function
>   3. same livepatch state id
>
> It is weird that we would silently replace livepatches with 1st
> type conflict. But we would refuse to load the livepatch with
> the 2nd and/or 3rd type conflict.
>
> Note that the inconsistent handling of conflicts exists in
> this patch even when the array is called "obsoletes". My proposal
> to rename it to "conflicts" just helped me to see this
> inconsistence.
>
> Any option/idea? Yet another naming?

Perhaps it could use a better name, but I'm not good at naming things ;)

>
> One more thing, the commit message does not describe that
> the livepatches might conflict when livepatching the same
> function or using the same state id. It is important part
> of the semantic and must be documented.

Sure. I will update it.

>
> Best Regards,
> Petr
>
> PS: I am sorry but I won't be able to finish the review before
>     the Plumbers conference. But I am happy that I have found
>     the above problem. We could discuss it at the conference
>     and come up with some sane naming and semantic.

I can't be there in person, but I believe we'll come up with a
sensible name or semantic. I'll hold off until we reach a final
conclusion.

--=20
Regards
Yafang
