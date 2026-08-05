Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BE35DA64
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898522; cv=pass; b=MTpTmPyEPIn0v1HjQFOIvEWQwsQkjRVNvAdo5iQ8VV3KKUf5KsqCYXJ1vJVyyy3PULiMp9rsJmh49COCeQYyrwnTDQwmRGpve9L2GxwAAxNH0UCzShM02VDPesF+lg86z7BR3szp7gaK10f+QJ74pxtj7ND1CDn5irpBZTLpNF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898522; c=relaxed/simple;
	bh=g3pTiM2T2EWufrqQ0UDBFtxjSv4c1Y0WiAK7+B8+2Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHypf5dlzBhB15AObyefqh2g8izkhNMtCS5nmxn65D/qaLqe1zYaXsvLLIG7c+zl2LKbbfLk11BqsCXd6HEs0l3pbcacKbrVqmsqOOyo7PF8CrXU4HjzHU6EfA6NyveUQT6RhaECijyIElmfJVpdwezRxog1hzrmmlYlfnnivsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4T2sA5S; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4T2sA5S"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ff017d420so26637207b3.0
        for <live-patching@vger.kernel.org>; Tue, 04 Aug 2026 19:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785898520; cv=none;
        d=google.com; s=arc-20260327;
        b=peprTBVJmO+07kE+4K8RIySPGhoddCUQRUA+6OH8XVZ7bEZ2qMbHciW6t4e1srsEcm
         9to0489jST6Uz0FbPXaorPIME3z7AYWflG35qv6KQ5iNTE0ktwxoCW8YVM3Scx0NTZRH
         Im3EbWUMIg6owkrtSgfyCL+JBq5odo8FQ9hJIluwxuxpyms4b/mziEFXvKtX1qmJ1RH1
         /4GBXozLv5l60FNrghZSzFiaRZtrPifVpy0CViTfA6yl/mtJIhOsLHDIjAcnV5pPf9F9
         K905TJVBYKOtJOvgVyjOB18a2PAPFEpyuJEgJ8DaRsrDOr55mF6IjZ/hD0FX+M4Dx8yQ
         Q//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pbd91duPCkIY3jXwN+cxmh+vwiqE0231wNQ8kEGX634=;
        fh=QScTrPNdhJ3wVtxRErWh83fLumYZB82jY08sSB49QUQ=;
        b=J/BffysjvPmbYjvY8rfAV0tNbojR3LUa8NsjoLISBhhMcBEKuEr5fEMfMcuDtrdByl
         xdcRrihObNyY4YmtejzX/VwjFu7K0WPAPL1+CiAgeJ2mGvGhAqUpde+n6u3zbHSmPr7B
         OIg2irUmOW7l4hApVCb+7TJ6sTBxs+5GnrUzKOu2LmNaqpYXLu4NKFaqlk0ldZ38oSyy
         1XrErUEbV6vdFA6Rl8ZVX//pBRkJ42FrPBOhUYGFyZAClGgH1supjY8v63sDdMslov8g
         s+A5grv1eRTHm1H7I7dPBdhnhODHHMeOM7FvK7aPLxIxE3CSsUgUFSc+7VXTdhYI7uaS
         sNJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785898520; x=1786503320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pbd91duPCkIY3jXwN+cxmh+vwiqE0231wNQ8kEGX634=;
        b=j4T2sA5ShxirJaBklnV0Nl0gzKyedoWuXgcQbv7xo2Je4M/nA7Cm9vih68ahfXMeKG
         Xcl7BPGLbfSZMficqmyFWfJQJHwuGqh5EuH16EWqqjs5y+50nEVtHlP+nXjYYlZe9Yex
         n8k2ksGHortLuNDNI2JPrYJ8sesEYjZxg/XKWd9B57QR/pR7yrTYt4chaQn3qIuxhl9b
         C7rOxxvAtqe2Z6lt6GENtuFejPSwoLFU4wukSPL0D42N1Bnfah31motaCqy2kc62irlw
         6FINjZDkdw5Zd7oS8TYYGhBIe79hjFl9JK+eHrHavtUQ3HZ0s9HULowZmzG6Y5obk7qX
         IDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785898520; x=1786503320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pbd91duPCkIY3jXwN+cxmh+vwiqE0231wNQ8kEGX634=;
        b=sNdi0FZ/W9f56woH5CBZSYC+TjLZAKIK7pbULnzg3bKfE03+LHJl/kVisMo3K2HyiF
         d0SHR5NDAvDnnIzL0EPY/ZxDpnTF1P5o6edB3Zk/k2YcuR5IBxPMJck8j9+LItzw/4Ye
         8jI7FDyLVtFYkXnvafGdSY7zFuVDRv+jbVKxFy4YickNvoXNdUei6wCXBfpHY+GySPA3
         ImoMsOv36PI2aOe0fo1UAEK5GJtzLcU3o/ngGWiseGs5V3qHnyBBL8Xo76D4aEHXY7Fc
         BYGdV777JCVrWZqHIFY4JfyWvK0YHle3yJze4Bw/Gszi3L7Xy/26U7PmbzDVvU0m9h/j
         w2AA==
X-Forwarded-Encrypted: i=1; AHgh+Rpl++KhflVfxdeKe6PP5FsvzpVcakVTAeOIOg6OtwOejylzy9bk7BsK5aeRxK5AemB6J6FIUgsRXFwp5cUG@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFLZgltAFScbP7r2mDviQAbp4bmDpz1K2nzdmObFLZnTc9V8/
	RqVi+4/lTkg1p7wtibtqhcrsCylw2yVIbY7GBsslqXldyvkd2f44QMGFX3LiXa4mEhxGMteDD91
	sUUUGMkxKRuhI9rUVF4XS+5sIMMyCEsNvmoEoKNQ=
X-Gm-Gg: AR+sD12RZyDWbv/O5iIdARF3w9pOtXcdCsKJsWHsZfwxLbUwN/FezInKdTiiRnY9A5G
	rzhpM/WHKkgJU34ZLY10go0gigANVQFT51hyUWjwgoPHSKrSarbZ1/NNjKtfaKVZaHFpcjZxvSd
	nHQYJbOxi/ILbYvSFgiDRXbW+N8hSq5czcGoOvLtqnwlFC1PM6rBeydG0YoUpZfAqU9SbDBZW5w
	WXkvbmbEseI+Aw6kvas1w0tgwYAtWIS2wnFJ8LvNAiQdWtul++rRh3m6QCWU89875Dzvqw5aK8t
	D+UentuJLCZVLivTrdjDiwxMi8jGGAsLjFCZc0NPA9BwqYeW0ckd3UTJ7qXusY0MmEhK4sYZ6qg
	b8A==
X-Received: by 2002:a05:690c:9990:b0:80e:c332:1796 with SMTP id
 00721157ae682-8200951c64amr61371057b3.10.1785898519969; Tue, 04 Aug 2026
 19:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065010.44922-1-laoar.shao@gmail.com> <20260804065010.44922-4-laoar.shao@gmail.com>
 <CAPhsuW4ge+nbXvqZO4FhQFhUbn7Lqt3Uvn0KTC-dYr=wL73FQA@mail.gmail.com>
In-Reply-To: <CAPhsuW4ge+nbXvqZO4FhQFhUbn7Lqt3Uvn0KTC-dYr=wL73FQA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Aug 2026 10:54:42 +0800
X-Gm-Features: AUfX_my_PiUt3LnOtj6vfPSW7NNjDLxAeorfApSSg7EgM5LyIwrR8SVTpROvbec
Message-ID: <CALOAHbBVgoKR-tUHndGUUCjF2uDSPa0yEG=u8GK_=-BTnbkxxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/4] livepatch: Implement replace set for scoped
 atomic replace
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:06=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Aug 3, 2026 at 11:50=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> [...]
> >  /*
> > - * Check that the new livepatch will not break the existing system sta=
tes.
> > - * Cumulative patches must handle all already modified states.
> > - * Non-cumulative patches can touch already modified states.
> > + * Refuse loading a livepatch which would want to modify a
> > + * function which is already livepatched with the livepatch
> > + * with another "provides".
> >   */
>
> The comment above is not really accurate. This function doesn't
> really check "provides" or "obsoletes". Also, as long as the old
> patch's "provides" is in the new patches "obsoletes" or "provides",
> this replace is allowed (the comment doesn't mention "obsoletes". )

This is already handled by klp_patch_replaceable() in
klp_is_patch_compatible(). However, it would be clearer to move the
klp_patch_replaceable() check into klp_has_function_conflict() and
update the comments accordingly.

>
> > +static bool klp_has_function_conflict(struct klp_patch *patch,
> > +                                     struct klp_patch *old_patch)
> > +{
> > +       struct klp_object *obj, *old_obj;
> > +       struct klp_func *func;
> [...]
> >
> > +       # Always add provides ID to obsoletes (even if provides=3D0)
> > +       # This ensures the new patch replaces old patches with the same=
 provides ID
>
> Do we really need th toolchain to enforce this? AFAICT, the kernel alread=
y
> guranteed "provides" means "obsoletes".

Dropping this enforcement simplifies the code logic. I will remove it
in the next version.

>
> Also, it will be great if we can add some basic tests for this. We are
> working on some new test framework for klp-build toolchain. But we
> don't have to wait for that. It is always good to add some tests for
> a major feature change.

Sure. I will add self tests in the next version.

--=20
Regards
Yafang
