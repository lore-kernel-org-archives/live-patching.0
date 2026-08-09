Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867823644A6
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268219; cv=pass; b=LjmSK44MUvwWjGEf7JuyV2YjIs2SQRqVy/DSzL/yp7serEcOTVOf0Z9x7oTuqm8sZiSuDfPNOPJvN0mraXxxH/EXKosW18l8icUKUKWeMWdNYta6gUs4CHJKGU2481dq5GuJOb7VgkR7hIf8Ky4YlzGA0giXQjglTOS5ZJgfbnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268219; c=relaxed/simple;
	bh=ndT2fmu22V7/A5Rw92m9ugx35X0wxzO6htHWnyL2S4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6gh6qomHT4fszMN/gpVYLo1M6fVmaK1UhvymIY93VtW/2BuNxnckbdf0bUubAzmDEsrFDNWXukCshIhvJCUnmrUPRIbP+AINj0LOqwJmcpv3EkwhqiVyChQQmbkECaSYlF+aAwQrAf+2gPYhJnDWmEO/I2G46SUXCs0UKZTL84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfG/5F7o; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfG/5F7o"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ff017d420so46919117b3.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786268217; cv=none;
        d=google.com; s=arc-20260327;
        b=M62Ypcj0v1ULlYxbI+0tuVI+mzjcxq4EoDlT5EfUq/nZV3e01FrkgCfCYByugPPIYR
         DJgvgY8yxbRiU3QiAD5VdkxeDqD6Hj4yNBt/CduKWMnZab89aW9YbeH5LBpLZE/JSCX+
         qfLFovmYvXjRZ1dZh2d0cgOzNrB3UhnMIOWbJsm+hHTQuHTItvRnAWwrqJTqUvflcK31
         VW13mTeXDtBlxVyo6HDjqwROkd8OXMbd5mRBESXjnBhTecdv+/SPZVdU3tFvuShhN5pA
         2Oxz71xdHRnUD6P3WfyHp6PwoBp1Xq86tokz8o2KJrSE/aMmLBjDXtffcD/lHMDYMsWV
         d2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nilV0Pn73Zsexcu5tZDlRh2Fi/j891cZt5rBBZe+zkM=;
        fh=VS6fnLDrrrlB+i28NVWooOokwQgQxWRJ8+PD8g2EMrY=;
        b=KmDQviJeDIzSTNw2+U/qhg8e6JsiyQX/rvzanrXgvoG4Cow9/Yj6QA6XDSE9s1Pfow
         9pRc78jsXnjPFtz5EpoQHPG4wjrqVIuRrP28OORYBxF6SLyGtmr7h7TwAr+7A3sH8HGT
         Ebnf7ywhWWH+H6WecVXwSkPv5BnRfI0mqv/p3aq32SXZI5iWllinmDdkDmi8AwYs8jyZ
         Xk/BP9+7TrmRmQZ0nfFGMTN2QQM3/B+0zq5cXWUm/sscD3NKLfWqdbaiRrSt3RrjQ8eC
         FXfSOHnSe0r+6SE+ozJrM5JM95xI7gRdc4avMrDmn1V6QfTHDHYUVVMMtbW/XyZomsX1
         M+Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268217; x=1786873017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nilV0Pn73Zsexcu5tZDlRh2Fi/j891cZt5rBBZe+zkM=;
        b=NfG/5F7oLlT1lBQyIEAam6SvEk+j+pkmD7E4OegpFrFn4AawuQmVk/6TDABcDa2+vW
         CtW1zepRplhNcriwGpakPFkzhTkBdKJOUTaKWHRoYRUWgo/yrF4q+zK5eBhwr4jnYuIA
         qk81Uszl/2ZwGvIf4SXT5U4DXSd/oFcHw+P1FeQTSGoL1ppZdhljibOs8SARNq2+yGCa
         ARcL/NN6nz4wfsRgQfkvle62pirgl+JMov44cVwZw3bUkzywv0PFZRU/uayfMl5KXFB8
         R8h+0hbjEtRQiyXhNVHyzQ4upTNWdRKoD08wihcI0ci9mJeLvcz8PYF6/ykSyxcVUAY0
         zFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268217; x=1786873017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nilV0Pn73Zsexcu5tZDlRh2Fi/j891cZt5rBBZe+zkM=;
        b=n+FwLNSN9ekB0x4TlmoC08oDLQRFE4A3JhKywVE9mT/J9ROW8owzztMoTdTowxlPLJ
         VOAbCFyelY6AsJU/JIBOvAmTAfez4x995uGuOwaMx2EiuxDcDbj7IWKy0UTXZjh98KRN
         x14Y/BaAoOfslrL/oHDgwE9INmZul283D+KqwX3VySB66e3veLrqFLNnR1o1WioyrA4M
         zpCc/h77MmPMEMCyShpLC8J8Xt8stK0p5EVYzQD8D6TO6/gMAi7c+Y/fNRVIW0+ESuHU
         VqJukZpLUy6POn+pRMRnwFaz7DN6j2l4jmZYYVnxmbuyGi/hadVES9hz1sPFWrsONKh8
         l6Kg==
X-Forwarded-Encrypted: i=1; AHgh+RqB0ebTqZ6dU+1FqU3X1heJ74rPVpMyvj0g4MTQ0kEyZDlkPl0dwNrlK6AVJuZL3FxziIiM1LIv6ZyBZSyj@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQvNyCPwUOSTywEFiOsnOJWJzI4yD+LITDpLj8OQ86jCFLv1/
	y18RMZO/WC8Zrbzbh79g8So4X8qSkQLYqM52VCJMxja0nI/p25ncSL5yX2JSRneVf6ggGvwr3Ay
	c/qs4z9xonl7QWtWiHOy3Pktfv0zon2U=
X-Gm-Gg: AR+sD12LC2dZZEgsAWNbEAp+66paQyll15dwv5my6xAm0uio0qdyAeDsiCzv6KjsbDn
	HQNoxtebxlrujIa9U2eZdpLEDiYg5grmgrp2OS08terYzORVtIZxSa0mR+mtPZM8WettMOnmA8J
	aN5hOFzC9TaVKMpJ9fdInfmjgrzYFHkRo+fSGX+8wG+et7B9RNDrQn+royTvacdKV90+OmSBx0m
	UwqEexxjTSCLVQs9V/Y9+ZAXv0V9bC7dYnphvVKg+0P8laZ3L0Zp9tznHzx+5AWCrjoJx/OdvfS
	HGobFTBeXd5+cCKunkkRHvQx34Z98mg9hMHfzHFHkDN5cEiqDUW5AEDXmBXEA7x7lGPGR2afEzX
	k5Q==
X-Received: by 2002:a05:690c:c149:b0:81e:a373:47ad with SMTP id
 00721157ae682-825eab48d46mr58166357b3.2.1786268217502; Sun, 09 Aug 2026
 02:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091954.22930-1-laoar.shao@gmail.com> <20260809091954.22930-2-laoar.shao@gmail.com>
 <20260809092850.28E6B1F000E9@smtp.kernel.org>
In-Reply-To: <20260809092850.28E6B1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Aug 2026 17:36:21 +0800
X-Gm-Features: AUfX_mzIf3R94gtGbxg0spoCg4Bd58KzxwELBsN6ZKEoNRF178Rwy36LlmKMp5g
Message-ID: <CALOAHbD48m1VTLirFrKXgsDs+SAaaU3_PG21NQWbkt5SfH3E+Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] livepatch: Fix wrong index in funcs cleanup error path
To: sashiko-reviews@lists.linux.dev
Cc: mbenes@suse.cz, jikos@kernel.org, song@kernel.org, joe.lawrence@redhat.com, 
	pmladek@suse.com, jpoimboe@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The patch introduces a double free vulnerability on the `funcs` =
allocation error path.
> --
>
> --- Patch [1]: [PATCH v5 1/9] livepatch: Fix wrong index in funcs cleanup=
 error path ---
> commit c03811c85b7c79e0d681d9978c346e4424c48a99
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Fix wrong index in funcs cleanup error path
>
> This commit modifies the cleanup loop in livepatch_mod_init() to use the
> index j instead of i when kzalloc() fails for a function array. This
> attempts to prevent leaking previously allocated function arrays.
>
> > diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> > index f14d8c8fb35fa..16aff8f736eb6 100644
> > --- a/scripts/livepatch/init.c
> > +++ b/scripts/livepatch/init.c
> > @@ -51,7 +51,7 @@ static int __init livepatch_mod_init(void)
> >               if (!funcs) {
> >                       ret =3D -ENOMEM;
> >                       for (int j =3D 0; j < i; j++)
> > -                             kfree(objs[i].funcs);
> > +                             kfree(objs[j].funcs);
>
> [Severity: High]
> Does this introduce a double free in livepatch_mod_init()?
>
> When the inner loop here frees objs[j].funcs, it leaves the dangling poin=
ter
> in the objs array. The code then jumps to err_free_objs, which iterates o=
ver
> all objects and frees the arrays again:
>
> err_free_objs:
>         for (int i =3D 0; i < nr_objs; i++)
>                 kfree(objs[i].funcs);
>
> Since the pointers weren't set to NULL in the inner loop, won't the
> err_free_objs cleanup loop free the identical memory allocations a
> second time?

This is an invalid review issue. Since kfree(objs[i].funcs) is not
added to err_free_objs in the current state, and it is moved from its
current place to err_free_objs in patch #4.

--=20
Regards
Yafang
