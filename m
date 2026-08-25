Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93F3290C2
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625011; cv=pass; b=mG6Yaht60gUPF2vFs1SXQoBz8M8rBNBYdJkVp3k/gFuInpEF90gXa0IXrIQGL9GxGkqry/vuUWkU/TiQEfIbhKA5u31deX4osWRykR5SXMOMx+dsQIKjbaOqkIfm6wJxHHb3tyQXM0iP1p/YM5q5QqvSj1MpL9hSsgDFpdA1raI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625011; c=relaxed/simple;
	bh=Ra2434n7uG73L2kkMtzuxvfBFxZ6vSWdU7qb7FSt9dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoKhA4BdJg68IBnzr1qJ7gTDgpUnQqIlS7wztd/iIz28IT4IE3SHIGr3IM82++0tgZ32aPrDIlyn/Nl8Mxd0qWAjjTVUbNYozJ69IhXOMNsSnLsJeejviBV/aehmtmiXjaO5ni2kGW2stpjsQR/ND+ZPGwcqU8tF/HRV+EGJ6Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyA0qguS; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyA0qguS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81f64e8dfbcso61505357b3.2
        for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 19:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787625009; cv=none;
        d=google.com; s=arc-20260327;
        b=aLJXmaw80bai8LOMeIlmtg27lX8srnyqu+8B2BObH40c4qLXvzvWIgCfhjLG9szcCI
         yW7aGivygf+q4iZ9ZDyn/j9rVOsNni2EbP6kVC8QbiobQdIChYJiLK7KmP8m8uoYqdNV
         UJ7042z2gAVbn0Kq9QGl9HBDV3FtRuekzgzGPlDesWOcFaQIfYaCDs1N02jnQ4yIUTFi
         io7qYuEwRAJxtClhqWSVEMDTe81KvI9LsJcMNAuAsH7zzD0Z5dYuLX4YLoOa77C3eHxE
         XOcwkqHhkTkrI9tBopdIqtfreHnvt55YCYCLRMG5B4l0QFVyHE+hwWYHxcD/MokW6z6A
         WjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WelbdyAh8SaOWCDmnyLkr1EWZ/p6x8s5/jMIZXhWWas=;
        fh=86NY2zGOcmycJWHPV90CvtGCpyiTo8mk/evCu7lVBXY=;
        b=C1Ltq9w7WGEeDaT5M9Qq48yX02zRjoCFGkqo178qF6Pi2bXXRcLEipUz6RQaFvTG33
         AybMN1ft3GI6Vp87SsxxMFCLfaMNMucFxKUwy8xumpnB9GY6NJxkidSk+GpV95oSpVob
         Ew6pYTKV1Ky9L0hV0ElLADzjAA92eohnPhYBkEt7IpI1cVxWgkRMrO6zHMlWe30gJQTr
         qoxlPhxRDHbQax/XdFxu8DOjqVCh0ZQGRQ7UBm0E7XFpncTG+7yIIf1xUuEpwb2Gx3G7
         x1aY58o+fW9nG34dSTT6h4uDZLRbUibiQ4ZnioB2aLgnSKqZSKrgQvXfOEPWuMW4GyIQ
         IuqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787625009; x=1788229809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WelbdyAh8SaOWCDmnyLkr1EWZ/p6x8s5/jMIZXhWWas=;
        b=kyA0qguSpOoQ/XNndTVZBOaEc+ez/97GwlstwnNz5fjshiR48UIW/EsVSlhdbFA0f3
         elJBfCoVQOLpXPmAJSM2mMHkyu6NCwLLjDLfYZ3f7tYzJhy4by4TjF49GC8dDzHyWHaj
         U7iY0pcL7qMX/sJ56qwZ8nZY9rImS2JrNKsrwO9v0EZR8wFn44V2Q/WvwXmNZM3SCkfD
         z+1YxQkEHjFcR/Hfsc5yqPtXixwtuZeXqKt/pTMWcTBA8oZrKc7R2+GlrqyXBHDalK1g
         QbNAAcBqVHv7rozMpNJkXrnJRNZKIK2QjZFoFkF4fFWK+tox/c7T5NA2dsagoh/7zGBy
         HHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787625009; x=1788229809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WelbdyAh8SaOWCDmnyLkr1EWZ/p6x8s5/jMIZXhWWas=;
        b=phtrPJ0cif2huwrWU768bTKD+7yBE14ZOsZqAwozimgNeC9wq8oTMpm5hdRdFa/pLL
         avdjhF9bg8b+M2Xq0B8VCKdlCDMtHQn8g/jztiR2d4MEGFpD5PPD6vp1R6qRqaH0NR47
         FQCHddH+JAT9VO+jl2FwVCh21kDreNJXTpYE/OJ6tj7fqXL3HLCeFLfdZWyI/aVOt5EA
         tkYedaVhDrbt4odtk9upy+eolTCbnAW8MaxgM0VLP4tdMYupNaA1zsPti+eQum1671Po
         GNdmByW8zTwiavkTDavZakhZe2pdQCIRE4WOM8TwHYd93CRSk/lfxnoFU6W1K/xcAxkY
         poew==
X-Forwarded-Encrypted: i=1; AHgh+RpXUw5RjrBcL3wT3Tj5Ue9JwGSgUMSiKCLbMTsUSghh2t8dDnhIu81Nn/FxcAWroXUHrYxk6IETQktnf1a3@vger.kernel.org
X-Gm-Message-State: AFuF++miG0ZHoryVMTC5YeXuEMTqS1U3i3aUp99h/TlIPNJ+tpa4HQS8
	+quQ4PFfm6ydYzYZM2Jolg600CtMgLS7IVNpWwvIba3eaChctUzkVsE+RThS1Xg+8TYm8adgNz/
	y6LAVNp5yQUKMRYz+ohqo30u/Qj5wgGvOSA==
X-Gm-Gg: AR+sD10mGebROJWsvF7bR1r/VsHbXFTYTecpaRd5InBzqTgk6DXB9JuQzRnH6zvDCz5
	IFxHLu9hH+22ukGSQ0qvxZ30j4SZaWqE+CWSlt1OPOeQmrZyv/MoL4l9TSkgeVj4HbDPl1NmrV8
	GxDJysKcx716yfXe6Tj/hgzQo1viFTyRwaBZh81XLMMcF57WcBxo8p4ha20lrvRGeLobuaxgigh
	NuxeqwFEl+Rsc/DJg3OE6KnH2tVQgUl51WJ2hScoboaAyOa5ZaInBVmjRz3u9aJGcDnygcgmu+H
	9fHXoqJjk7/I3zXehMF1B7F99+tekLqmx5ePpAw8vspsAO308x6oXmpUqVeInZZOLt9BaOBL4Mf
	oKw==
X-Received: by 2002:a05:690c:e00b:10b0:7fe:4069:d3fe with SMTP id
 00721157ae682-849f6c8bfcfmr113946787b3.30.1787625008964; Mon, 24 Aug 2026
 19:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824032732.56686-1-laoar.shao@gmail.com> <CALOAHbCBJObMPf-vQ4ZtdCCNwFNhGnfR9jP9Yeiu27D+yWPErg@mail.gmail.com>
 <CAPhsuW7Y42JG5ADTa=KmyC3ojO5HF_D5W6Eb0B1oAjzY_7VouA@mail.gmail.com>
In-Reply-To: <CAPhsuW7Y42JG5ADTa=KmyC3ojO5HF_D5W6Eb0B1oAjzY_7VouA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 25 Aug 2026 10:29:32 +0800
X-Gm-Features: AcwNN1WxDdz81k9AuPNgZ61X21jZ83kVgg8dbbfywnwNGPPnW54mGlFdqLI7k8I
Message-ID: <CALOAHbDfQ7yLShSwUVbAbUmh0DkNj0df+ooJ8Gy5zK8e5geQPA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] livepatch: Introduce replace set support
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 1:09=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Aug 23, 2026 at 8:41=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> [...]
> > >
> > >   This is addressed by the patch posted at
> > >   https://lore.kernel.org/live-patching/20260821031648.48195-1-laoar.=
shao@gmail.com/
> > >
> > > - Other review issues are addressed in this version; details in the c=
hanges
> > >   section.
> >
> > Oops.
> >
> > It seems the sashiko-bot failed to apply the patch because of this chan=
ge:
> >
> >   https://lore.kernel.org/live-patching/20260816090442.18128-2-laoar.sh=
ao@gmail.com/
> >
> > I based this series on that change.
> > I'll wait for others' reviews and then rebase it onto the livepatch
> > tree's for-next branch.
>
> Please go ahead and send v7. Full review from sashiko-bot can help human
> reviewers.

I will send v7 shortly.

--=20
Regards
Yafang
