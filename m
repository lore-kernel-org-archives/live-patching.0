Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039BE42E439
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136833; cv=pass; b=aSJvRH7gmazee9D67Ew3CnoWZh+tvtuvoGyuP+L2z+u8CHz4EIgdxmY+J4MAut1fZ7UNX78qPG7uJpQ3sIqaxuE+1C1cTeuOiScoXXKdPWtlxITYG1UCIjpPqnsgfW0EJe9d/gRF5Nhzwflrdvqu6W2OLUy9jOtvXnXxu4bt58s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136833; c=relaxed/simple;
	bh=iz50SIIYgNXhoBf+ZNtcTDDxG1l5WEOIvp9iGxEjNrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch3YUr7gPGERJy5I21cv7wm6f7+q723CGvE2kImMfcv2tASFKqOQF4/piBq/zYxuzVfcpDVgqEVojQmWKMH21MHk24sJ9oyWKkR+L90CWabwHTKBHU+evt6ChFCscmUSNa3KsC8z39obkSvnWxz4FvtuCXXgKkOiMYY+OMS/BsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLrhJfpq; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLrhJfpq"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6798c43a3d6so2069973d50.1
        for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 00:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792136830; cv=none;
        d=google.com; s=arc-20260327;
        b=cNq3kqnuzEVbA6spvCI2WyW6n/KyZ1O9Ad1XBuZUrSDvmmnc1rxFLHIXKpxkCVCKPX
         kgh0gDn5Ev9LBnGUN2/QMnATG0OPgV0jZuW1ZDM/XWFr8PNNgQ/34DFJ1xHowKENfJaU
         ruALaGAqG87rZyCVLLPageHVoii+XssIr/b21BqUY5m8dSKh2NAJjXrI0Q+S5XjnBVfJ
         iP4LmGZ4GLLmoV9+gc+JD9/ZiUcj3TGIjNZCmWMfD3pYI9a37ibCf1xlNteu6mC5RYsm
         3tI/K7SwuV6nstr62jg6ZSgwzQzFWTN/CAoe/Q1RJo3FlfR91gvSF2CqzVN0e/AGLVWt
         uWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YjWAKtNOnITlaXHSksc6OaQBOzDeD+AdLblBRpND2cY=;
        fh=lqzA+EuE7YKyLc9CeAIUd2qPM/N5asn01r6hXF/6gqw=;
        b=Yeus6b3Kh5a8cGYxDeD1E0YkLO7BvA+KFiSskLFbwibPm6nE/CqK6Jf143DLEACX8j
         aV/W3yutBfPBy81+nHDAAchLonr6rV1FbCJ3ITpiOisi4ZwUZFQpaWP3Ht2mIXUL45RE
         7YTsdEnOH4a/dg7rqpTiZFX15Isizk57zQeTb+mf2FmI3Hu/Iuu3R5lmCqp+iASEsBCp
         eKcbH+ciVGcZZv27wgQBgU4k+0rtN5L2LXS0m4Jpacira1OInS7IhwNl4anBJGv9iiZr
         A61j6YDGs7Mde2keSkc1fWATobUWqJq++DwRDoAOk+AF7LlTDqazVUx4W+zVV5BV4TXb
         hgQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792136830; x=1792741630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YjWAKtNOnITlaXHSksc6OaQBOzDeD+AdLblBRpND2cY=;
        b=nLrhJfpqSOtdwfwH1NlZNc9I74u4Pf0Kn1I4OjXsSMwkhQXBDxGkMdwgqvvB4fqQE7
         vcnNjiQFlKQJdStViDrsZFi435LKLDj7jZ3UV6AIa3pcwWmG9Om4WHch+iXmEBMZIUtM
         suT9zlLeFQYrabpbBKLMXniaFwJo1PFnWA9p3cDsviTZYeXtOqgrRWENv5MuWMQa5X6m
         jtelN7IER1hP8ufCf+e+oNLIldqPPnBsZGj3sOGa3XmPnWT9+cT+8ZcfBdGlbqL5n6zh
         MfqWQM9SBdGS7cYN0EGq4e9/06CG4xT6YixESHspEnQPmY+MI8Aq2dtMO3JR2YQ401Wv
         WPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136830; x=1792741630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjWAKtNOnITlaXHSksc6OaQBOzDeD+AdLblBRpND2cY=;
        b=ffXQ0d0wUL/Q1YN1staEHNmCb5i7er8K/nlOgUVj8SJKI1avIbrXlQhGidpKzlPgrX
         yr9SsmJ+deRXa1M+RHVDNYAMwYNOTt7v0/xzodJQnAdI6zOFX/oKDT+RHqyc6c56tikn
         MLAArUMblFY+c1FYf7EfgNfQBge4z2SUnSPnTPg6ZBmVFFp1BmmFTNamPNc52nZawcK8
         DP6J69W89kGwEGLZJAUDisKH6JcAiRFlIYCS3hD0RHKAUVaraqbnPHyyy4+iHcHAOBsq
         XJaKtfWUliZA/4laV5dV9U+UYdy1z54powOHnPuYXDvmf0lGiAdAfO+RdKQCCSnmi/kG
         XceQ==
X-Forwarded-Encrypted: i=1; AKwUvByK1e2rJb7B7ToQfrtbRir96zTf9/hhJTDU7oggILxR9rmgl2/FbVEm6oLEDiltk6ybiGo+wlD4e0kcHekn@vger.kernel.org
X-Gm-Message-State: AFq9FYKCJvdc0Cm9yOAhhCyegaRkgEdjssp54QmAjhmd8gC4bojENYMr
	w62N3Bv7R7NppcvqWr7vgTN1aU1FzAT3PggbX23DQk+vDkeQpkr8WSOdHH5A+alvdsn/Fw4Tn0g
	CKqyvUOOc7zurTjvq9Gb4D/YFg+LjY3U=
X-Gm-Gg: AYBFou1AG5HfSczsYw/ZqP6/cdl/7+mL5+SdoMTY8+vDKGkdCluCpp3yj6RqxPC1zit
	gzs1GTxYR5Pn7Nq0lpYTFeJdFR/ZjhggD//TNgW+6oyWqDGg/s3Q5SgBXlot12P0RPl3qcWvWy6
	QzGESuZ4FzdzE9Bl2ZOY/tnTKwtEU/k6PMFHkRubIBpTbBznQWRX2iJPlkm2ER/ZaV9KXpSInKJ
	l1b0x+8YwUirIDeR95Kpcbz8v7LV+HOx/pqXJ7LAcQ8wKemKkgV0HOQSpIcIfkzSS6BV27UwlIs
	X8thuhQo19JYloQzEJkek9xbO1vzF5typ9gMaNXu69DREBGcD8nFNEiMxBzTrzG7DjVSjLrEsbX
	tPdZPBhGLyT60H2qj5hWO
X-Received: by 2002:a05:690e:168b:b0:679:5b51:339f with SMTP id
 956f58d0204a3-6795b513803mr4554881d50.132.1792136829876; Fri, 16 Oct 2026
 00:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016053708.47089-1-laoar.shao@gmail.com> <20261016053708.47089-6-laoar.shao@gmail.com>
 <sashiko-outbox-173837@kernel.org>
In-Reply-To: <sashiko-outbox-173837@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 16 Oct 2026 15:46:33 +0800
X-Gm-Features: AclHuK_T9y1mVOiQaEvA1Ds2-qibg0REEpTSP5r7q1epESdWgUdYroFJnwfhLw4
Message-ID: <CALOAHbCeKtedvb=D=QdQiAXouJ4_dCVsgCP5t_OpA3QG=7xn1w@mail.gmail.com>
Subject: Re: [PATCH v12 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] livepatch: memory leak of dynamically allocated patch structur=
es on klp_enable_patch failure
> --
>
> commit 160ccf1ed36fde593c80db0147adb4d9a0aa689f
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Implement provides and obsoletes for scoped atomic replace
>
> This commit replaces the boolean replace flag in klp_patch with provides
> and obsoletes fields. It introduces a new flexible model to allow multipl=
e
> independent livepatch sets to coexist safely on the same system.
>
> > diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> > index f14d8c8fb35fa..1eb124191cf22 100644
> > --- a/scripts/livepatch/init.c
> > +++ b/scripts/livepatch/init.c
>
> [ ... ]
>
> > @@ -72,15 +75,19 @@ static int __init livepatch_mod_init(void)
> >
> >       /* TODO patch->states */
> >
> > -#ifdef KLP_NO_REPLACE
> > -     patch->replace =3D false;
> > -#else
> > -     patch->replace =3D true;
> > +#ifdef KLP_PROVIDES
> > +     patch->provides =3D KLP_PROVIDES;
> > +#endif
> > +#ifdef KLP_OBSOLETES
> > +     patch->obsoletes =3D klp_obsoletes;
> > +     patch->nr_obsoletes =3D ARRAY_SIZE(klp_obsoletes);
> >  #endif
> >
> >       return klp_enable_patch(patch);
>
> [Severity: Medium]
> If klp_enable_patch() fails (e.g., due to patch incompatibility or early
> -ENODEV) and returns an error code, does this direct return bypass the
> err_free_objs cleanup path below?
>
> The primary structures (patch, objs, and funcs) are allocated with kzallo=
c()
> earlier in livepatch_mod_init(). Because the core livepatch error path in=
side
> klp_enable_patch() treats these structures as statically provided by the =
module,
> it will not kfree() them upon failure.
>
> Does this code permanently leak the patch, objs, and funcs structures? Wo=
uld it
> be better to save the return status and goto err_free_objs on failure?

Good catch.
It seems to be a pre-existing bug, not introduced by this series.
It could be fixed by the following change:

- return klp_enable_patch(patch);
+ ret =3D klp_enable_patch(patch);
+ if (ret)
+     goto err_free_objs;
+
+ return 0;

--=20
Regards
Yafang
