Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792916362;
	b=cu1bLZ3e37toCcg+hAkgxrLCZSxWkFTpBKFjx3ayAzGRoRbIYPACEbIFtwNDToQItYSu
	 j+t6aaMkGlOwpg59ffcKPOXVAHWp8ONiUZ+DTP4PDC4lAHN4t50JhXRWco7s6s4Fvpfxw
	 CYC0R00DUSQOV6yeWjNcnbTOtb/y79CEq6SnByi8TaIHG0WYHUGQ5sTy2kqTP9oqDyDf/
	 2sepzyyUbWoAkCxi6CYdteP5pMRKTbSYdVrNn7llYpw1N418wRubwQgGP17qy0N5PGFBc
	 7Pf8O0Rm5ufybl+UXwXjPzfJ948zIpKWez3Abf1s7lTcwl77ttBRofP48jHooPZNq6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792916362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Hvx7tSU2aY9nqJ+J+NknEbQ2eLT5v85kXfK3znPPUp0=;
	b=EL6QfXbd6jjKx8nPSV5jAD4vt42SXngVZZHzu0QCo8U8YRd2vcTB0sx0vn/KWLyNhrEZ
	 nbxQ0+LfUruAcQJ1YE54FFgfwmIqrSHjTaAQPu0iQRE5nB89CipJUvv0YwM6r8TMc5c99
	 k+Wh94vlsabIgo+zY7OM2GjgRm56WVNnjY/0QTvZ93jPRHLV7f2ZIWxBjfBZS6FDHMGaX
	 Pf0BkVGN5Rqt2cqCzEzbumk1RlO4yBrfVAEpe55eJs1dpyUdPCWOPIo/gjFSIxbR78HQh
	 kR4dvRcibfji/RA7i9GofzZImHaex0AiasXuaUVknRzrCHIdGuk34f/ZgAJvqDIu/UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Eb4eeDOI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D8606A31A
	for <live-patching@vger.kernel.org>; Sun, 25 Oct 2026 08:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 293D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Eb4eeDOI
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6768403e9bbso2094501d50.1
        for <live-patching@vger.kernel.org>; Sun, 25 Oct 2026 01:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792916361; cv=none;
        d=google.com; s=arc-20260327;
        b=m1pkyFO2WDgApDB22j+9YPpsqPJJo5FIXjmhp51Y0HxYRbDwcRL5l93VVfXVLisQgV
         VuTvdIFIaq3kdPJsrVJQF9eZnElfnwm87uklpHT+gOrEv4uvLDHo2xuSU5dwrzQ/c7vN
         ZII/f9MkmJ0XKK9GqGed9+fLqBoe5zhzclYSz+870vVHyFSDzguCQ31fHULNZvic8gXy
         yTUpsdy7PH4ENusZnbkKCuztGqyVyUSZO1UnzMMfZNA4SiwzRHsWjGas+PVv+fv3DS4O
         Nz6JgzdupSjqEkvkXa6Lf+19RkmHn8j2bd7hDGDM7BabE/eqhhYc0i8GPYZ2Zkvs8xmZ
         eW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hvx7tSU2aY9nqJ+J+NknEbQ2eLT5v85kXfK3znPPUp0=;
        fh=R/kgiOxHIE/+fxI+APLKc6uZl2mRh16+HUC1CoTidwc=;
        b=IeJi8lG62lLJBUVXbFzhPXjz3sgUtIZctupCVf69CJ3otRGfoE89n/gxWmqjL65rKi
         A9aIu0PcmEw1C7QkGwY+wRu99SIRuJQvpk+LSPY+saqy6fyxPiEABBndMwQgFtQLTrH6
         QToAlchusLLWeV3EMAdYksL+TXLmuWROpONA6LtdStGxKgpIUmi4JA+PiIeKOgRXCcnt
         wXGpFVQGD7jYJnwdzxPG5rxqjLibXCsAC+Q7X+yjrqmXyfYLoCmhe1s1njBoZMAu3u0H
         eXHm/WfFKDsa3O5Qd3nJyd8yai6GHCffRbtwbMCe0sdR/Bhw+P19dMx5UImH8NXOuIvx
         dscw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792916361; x=1793521161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hvx7tSU2aY9nqJ+J+NknEbQ2eLT5v85kXfK3znPPUp0=;
        b=Eb4eeDOIokvtcvQfnF5EgPpwBE1GoOgzjmm4Zljj1PYUvAqQIR6KMRE8Ox36tuUzoG
         Q89qA541ydquDw7HHeqTbLjnvm3YwHh1IngDSRNy2xSUvvrX5JH0KFBmfiJi0bMNHU+X
         fLhUdinfB4QLjUWo0MzjVB9L2tuUv+3yhNEauBrXsS9vui0TAGpz4PcmQ5weEATwu+yd
         oYfexycrRJIFFyk4RaRky+Dcr4Xe0YguHkpf8U6wJpsII9ilIDlomGU1i3ZEH7dIgcRq
         KmR4UHaBS5jZKF399g6LnbdpxFM8SEn//dtCqA2/ZjFOW4lznibheXnqZakLG7VJPcmG
         pR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792916361; x=1793521161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hvx7tSU2aY9nqJ+J+NknEbQ2eLT5v85kXfK3znPPUp0=;
        b=uNKPGNGSf0S9ZNenboJ0A5/YSU1HmBwVhzLRTDh1SOw3wfYAX/dGa5EvXoaC9TBAFg
         Azevwu9stBLgEuCUN17a6qkn3iNFXBDk/T/BAqodvTqP2kvlUXvZITRejfM6OfNjCjP0
         bLPdjMX/4dPFGHNfiHGoZ3x/QV/BNgVFMlH8OGDjpmMc3cWmq7OJp9VzbN/EnyQMedbG
         49iji996SCnAW8BsusfBikXgl0EC0izK/NqoFTcSPum7x/fekZWg0JUcM65Dti/qkbyn
         yi9bCEvEw/GlQiHRqJ6JljcmCy0sf8Ybry0zFmVH25vQYTOVq0mCbq1yX91OZYMAQSBI
         MziA==
X-Forwarded-Encrypted: i=1; AKwUvByLCqbTfmIAOJe4XVvV0eKPAOJ7NyQAseL9POS5uAvi6Hi5ShYq2NI0NIbKA4d0jozPQD0VgASXQoxV/4qj@vger.kernel.org
X-Gm-Message-State: AFq9FYKmtyTXpxNBUmV49iJIOa2WRFSBLfSHLn+HOzFOvHCegx94H/UF
	vj0zb0Iqkf+IIo0HNXBlgwqx0sKWy7sTeaJs39dHOa4FH/KmDjlh7U5cIsxkaRjFCVThbLmezQW
	FEtQlTlzj27RWvDW4msCSSrEwoOF5etvpMHU2
X-Gm-Gg: AYBFou3nr7/JIlxSwK3VuHVi4xPr1uyUik2CPW0dWBBAsvz4ClBEjuR3dHd2k2S6NdX
	aP8bJPIuZ/QBXOdE1/z26DRS3evYHF26b/TLWMcxiyibRaAGHmz4eLgR69PY23AgWN2J3z7m02Y
	YeFeas5u0qeN2Yv2gMznZCUsEb5oWTfMivbruVtJW7wFepT7QJ+fdUb/46H8c7FvfOshT85D0JQ
	IgKQuorlLItxQOz/n4ERQSPG4qV9HONuQ45HHReMnR4t+XNtfQvd7U60hBhZggIjHu8owKu2TCW
	2EZuCGiCUiWRj3jHUqp4EnDBUi+WZEgdsiWgPQE3Po55KMwj+jQsVHIovUusA3spCi20GO9Crpn
	dOzO+52ZDKXfkp0ZPOxa9Z2/laIprSOCOaqrsex66NZHRMD1rSu9dSkpjxAGGIwlBb1k=
X-Received: by 2002:a53:c04b:0:20b0:677:ce61:dcf with SMTP id
 956f58d0204a3-67a4547c9f1mr2376483d50.77.1792916361168; Sun, 25 Oct 2026
 01:19:21 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016053708.47089-1-laoar.shao@gmail.com> <20261016053708.47089-9-laoar.shao@gmail.com>
 <atsv3jxebDGoP0hw@pathway.suse.cz>
In-Reply-To: <atsv3jxebDGoP0hw@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Oct 2026 16:18:44 +0800
X-Gm-Features: AclHuK-cGGirNXsQ_9cVQCC5lkuBrDW7hwF3W9gOC9CjfTz3e4vMTauUhgJoxHQ
Message-ID: <CALOAHbCE-TYvCs_Afe42PhQqjRG9Fq2_k+04Tk_pYHK6rMuzug@mail.gmail.com>
Subject: Re: [PATCH v12 8/9] selftests/livepatch: Add state test for provides/obsoletes
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:58=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2026-10-16 13:37:07, Yafang Shao wrote:
> > Livepatches with different provides ids must not share the same state
> > id, unless the second livepatch replaces the first one via obsoletes.
> >
> > Add provides/obsoletes module parameters to test_klp_state and
> > test_klp_state2, and cover both cases: reusing a state id across
> > different provides ids is rejected, while it is allowed when the new
> > livepatch obsoletes the old one.
> >
> > --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> > @@ -151,6 +165,16 @@ static struct klp_patch patch =3D {
> >
> >  static int test_klp_callbacks_demo_init(void)
> >  {
> > +#ifdef CONFIG_KLP_HAS_PROVIDES
> > +     patch.provides =3D provides;
> > +     if (nr_obsoletes > 0) {
> > +             patch.obsoletes =3D obsoletes;
> > +             patch.nr_obsoletes =3D nr_obsoletes;
> > +     }
> > +#else
> > +     patch.replace =3D true;
>
> This changes the behavior. The original patch did not replace
> others.
>
> I believe that it would break the last test in test-sysfs.sh.
> It passes with this patchset because the problematic test
> is skipped. But it would break the test when it is used
> for older kernels.
>
> I guess that it is a cut-&-paste mistake ;-)

Ah, my bad. I will update it.

>
> > +#endif
> > +     states[0].id =3D state;
> >       return klp_enable_patch(&patch);
> >  }
> >
> > diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_st=
ate2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> > index 5f07fe1be2b9..aeb911b87d37 100644
> > --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> > @@ -180,6 +194,16 @@ static struct klp_patch patch =3D {
> >
> >  static int test_klp_callbacks_demo_init(void)
> >  {
> > +#ifdef CONFIG_KLP_HAS_PROVIDES
> > +     patch.provides =3D provides;
> > +     if (nr_obsoletes > 0) {
> > +             patch.obsoletes =3D obsoletes;
> > +             patch.nr_obsoletes =3D nr_obsoletes;
> > +     }
> > +#else
> > +     patch.replace =3D true;
>
> Same here:
>
> > +#endif
> > +     states[0].id =3D state;
> >       return klp_enable_patch(&patch);
> >  }
>
> Otherwise, it looks good to me and passes the test.
>
> With the "patch.replace =3D true;" lines removed:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
>

Thanks so much for taking the time to review this series.

--=20
Regards
Yafang
