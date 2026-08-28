Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35521767D
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787883926; cv=pass; b=lAFOJWYcES39MJizd/9Yl/qqE8TEqZdItc0qd7cxkby2gQ2OZODjplMa8BQhXAVHm5oTyUnGlRitahy7YRvjH/GVstLaSCIgbe+GOM2vdKPdO8Gp5+CZMUhUFhXZ5chGMYJj8IvO2FxH5fTRduqQ2mMQOS5A8eywvag1INWyNYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787883926; c=relaxed/simple;
	bh=2/oNZ0EyToDwOZQb7Euwr9uv4SuFP1+61J4MRCzOoBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilhXHc3M45kofomV/b27KA7vIAPeOWQyPXXIOgrolKxsOyoKJFUFk6zzI/g45bhumc4eJ9wRzje8PyDbWLzURCp/nGYpuEmDIosH7Btc8vso7kiVJPOJzByBwKiq/tPZF2sPgjwZAm8SZLr0VR83xxOXrqH8lHgyEe/IKYp7EBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpgvl98u; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpgvl98u"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f64e8dfbcso5347987b3.2
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 19:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787883924; cv=none;
        d=google.com; s=arc-20260327;
        b=Sm/RXV7d8g36IHEnMvAKPNM2qT1i/tTaS1lIK4idK2UGiDsYnytkCbXUHeG/ALwhPN
         4VuVAJCshMzH+5cdq0RgDpQ4V9UBYsbfWSudICmWwlSSGtd9O+4CW+Zfrdp7TARQfmTy
         GLfpMF+SE9uUoHHzoRr1GYIfDPI/zeJXa6w4TqYqm4WyZZ4Oj/YKgxpefzEvLYOhGHb/
         A7Uw/IzEgJ9Sk+SCiJU4UD0MjfnO8BnGbDQLMMWUwge2Kf8eMffI2t1jWSJKdYsv7b9c
         gM7eCFKIxbeEvkGKVQEtSubiIKAWD9Wq72lB7MW+2urcHdx9DKT6vnHDDeImjfyCvF8K
         hmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BRTa0hkiuF+0aXK9Kdj186+ZekAbQuurKqHabqx6tAk=;
        fh=4dr5x0ZnQxK4SjxTQVf8WwtusfYMqCjZQjsfo+dMafk=;
        b=oeatzDmxoAzrHcHDBhcdSlq1cmI4aG11a1dCjakrqDzB72MBxOzepj3EQqirfwBv3R
         qra9TroScTrEeZMt5ibwdBRvwBX/B9xmWEGE6JekvpFhW9sxsFjXu0hxKoVzTdCkTafI
         0gZGEN2iR/fJsb5mpolY+HcbX3tQ/4nI9+X+ULcFZCkCKt/BHikWFgU874+TOa/tXNb6
         cNSXn92hLWiwTTkZBEwUacBhERjr6wC/3KU+ROfytqYcNJ8Zioicjr5pwZMTSh/g0D2t
         k5Z+oDP1Os8WRlxtYawrK6yJ7C2aBMZrQ+0wd8oMpWje/YmLpkU5uqTyx7ZGsklo0qUH
         +lLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787883924; x=1788488724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRTa0hkiuF+0aXK9Kdj186+ZekAbQuurKqHabqx6tAk=;
        b=Fpgvl98uEBo6kizbs4Sy6dj7kdTbRALJfBRj3m77rkCPsh13WKD2wWCb7pxWnCDtRc
         /Hdhh1ef7IL8aGiaTAWCBoZQ9C26pW3wusu4V5PQEKvfLYwhOkmBBtjmugEjKWkUnqX8
         VdDyQ/gmVB9GuPoolq+FenBAaNITk2Oh6VTXayw3hzpnSl7kwjlvXJaR16q1t1E14ynb
         q36XocvVBB2za4RBDPujHuSsqCwp7fIDQRUvKayhYOVliw8/KZp6qbjNEsy3LQnIIVvK
         4lP3+4wp+k9WXbW3ba72anin+vUGksgXggDbBGGJDqRuyiqlaAJ+byorubfkpWhilGtR
         SGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787883924; x=1788488724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRTa0hkiuF+0aXK9Kdj186+ZekAbQuurKqHabqx6tAk=;
        b=VTCZu9anQTQBsYkqdhnlp+41T1hptsVD3PlVniDf19LlMdvMNAz01iv/Kw9jDwUy58
         NK+PmVv7iR5SsgDG5fgOCXhricIRxje33+sU2sUVZStXklJY7Ho5vexjr6wBlF3FXvgM
         qjqlGkRQEY0UOlVJf7iBzYuzn+Syb5qnvPMQT2gBaZeYrqfYLiJxLIa4IJcgGvvF4DN7
         YQBv1VV/BWzukq7jsCS2o6ty2jjcKJPKYElN1hsSh+7kJZNZ6UpWF5H3cK4JlEhqVtsX
         Rc5Ng3q8QHt3pPkz5YbI+DORCSaFLUzwF8N8w2Vjq7qrqaFSgXXV7ge6znJ02IlhCZRs
         RC9w==
X-Forwarded-Encrypted: i=1; AHgh+RpwX1zC5erTSnVbtG1ClkeKJtIfaaGOo0HseCqQeuoERk+CsUIwLuqYU5vYaIJjkGqO7aX6U23d1NM4GK7D@vger.kernel.org
X-Gm-Message-State: AFuF++kOB+bFHArM6RXRVuZiomn6mZ96Ng1GJlXcEqRkABGJGo5DSIzs
	sfe4Bvyz0XId0Q4gXeMDp4Zx60BLgryRNO/SHfuau+1rsWGBNP5Na6v9qvHf0eYqrv/cWMpTJ8C
	7Xy1zJ4fx3diKlbWaDk67RTXKxgYG58GnXA==
X-Gm-Gg: AR+sD12iTtoPG3x+aN65FWI35WBB8v0L+c5vX/a+S06k1qiTvYAIIehHvW2PmYuvDvM
	RTtGehSV0vGnDw0mOKTveT8QOw3UNKGimsrnj/pvrBc2Y6TfMTxocD+s/0iRmTry1VDnm0f/2/m
	76gadvlNOYX/54Me9O8Q9iigCW34VvyD5goerLw/eJ+HmoavmVng9931e3ZEIRsOZ5WU48JYrM0
	5QJ01PtZBGJUamy+YGQQ3kZmOUWcpGScHEj6pJ5o2UBepWDsjRD5Zj5u+5XjKtGlDbsainDxILl
	XCuwWXdcVL4lbp0/ywHa84fGDz2WuqFDkGu1BJE4nrE60STDy+0+H6VzdIrB6+yDN8YARDIhscn
	PwR4tA4dW3zm/
X-Received: by 2002:a05:690c:6611:b0:858:1661:a43e with SMTP id
 00721157ae682-85d5fcdaacfmr17228997b3.0.1787883923722; Thu, 27 Aug 2026
 19:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-3-laoar.shao@gmail.com>
 <apDOvYOV0DtouAVF@jpoimboe>
In-Reply-To: <apDOvYOV0DtouAVF@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Aug 2026 10:24:47 +0800
X-Gm-Features: AcwNN1U2AoJyYAOBOxbLNNxlU1QvdRzg2YXXxO4-w07aJtJljDsu6nJqcfzrzls
Message-ID: <CALOAHbCs=zkDnoQ1NWa5iNzAKMuE+zCh0GnRR8ba+XGnt0tDpg@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early() earlier
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 7:57=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Aug 25, 2026 at 07:46:35PM +0800, Yafang Shao wrote:
> > Invoke klp_init_patch_early() during early initialization to avoid
> > mixing for_each_() and for_each_*_static() variants later in the code.
> >
> > No functional change. This prepares the code for an upcoming patch.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  kernel/livepatch/core.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index c34306ecfb0b..3de3940d34b2 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -1145,13 +1145,6 @@ int klp_enable_patch(struct klp_patch *patch)
> >
> >       mutex_lock(&klp_mutex);
> >
> > -     if (!klp_is_patch_compatible(patch)) {
> > -             pr_err("Livepatch patch (%s) is not compatible with the a=
lready installed livepatches.\n",
> > -                     patch->mod->name);
> > -             mutex_unlock(&klp_mutex);
> > -             return -EINVAL;
> > -     }
> > -
> >       if (!try_module_get(patch->mod)) {
> >               mutex_unlock(&klp_mutex);
> >               return -ENODEV;
> > @@ -1159,6 +1152,14 @@ int klp_enable_patch(struct klp_patch *patch)
> >
> >       klp_init_patch_early(patch);
> >
> > +     if (!klp_is_patch_compatible(patch)) {
> > +             pr_err("Livepatch patch (%s) is not compatible with the a=
lready installed livepatches.\n",
> > +                     patch->mod->name);
> > +             ret =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +
> >       ret =3D klp_init_patch(patch);
> >       if (ret)
> >               goto err;
>
> Stray newline.

I will update it.

--=20
Regards
Yafang
