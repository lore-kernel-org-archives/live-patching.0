Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F629B799
	for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786848378; cv=pass; b=PM/deD56Y+jdtji4ueoKdC95LAlRShcNJLYiV1JR7pwTztGLrRvzjck2aVlMpFEasyMgBCbp1cC9sF/DmRzXiy2b24RZSG7V8oEREmXrBr1cEKaoDjB9elvw+SdBW4QoDe/TTs2rHU6nIXvy4GNkp3vwV8Ibg8oTFBs9npfEPfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786848378; c=relaxed/simple;
	bh=qRzl7e7/Kscd9msmiif2Sjjs6Y4/s3shUmUxevBbxd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEdAkbz+iVdL8LO7lR/W7KVgTlOC3cboHjiQ90EO5+JxYU7M6DlYeTUNsjvDMIgYb476nw+WvNlxT8ru2CTkEgV2fQwhggytle7U8aqVhCcVJNHL6puymXnFhpt+/SNcJurCw0415FrSxw0K6St+VVkJiHMFhwzsiU8OqeinKkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9v9mceM; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9v9mceM"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836eac5682bso35724187b3.0
        for <live-patching@vger.kernel.org>; Sat, 15 Aug 2026 19:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786848376; cv=none;
        d=google.com; s=arc-20260327;
        b=HPT5YXtQePVfnfc+jgHuEZDvSaKiAJOkbjp8bQ3DpUeO2r82SbU09uRvjaoLxslfU7
         OtGXOSuCHhvpovlHs5ENRyI3cY5UwXSiXTMPMPDj+XDdhUUOZhTisifBVOmlJ2rdoP3j
         Zjrc9jigkUAvtF3essEanDoTzmqH88zziWYTJmeNIRkClkleFuCcpcDVwTMMg0IpNKJd
         J6eFxBEsupLiKEGPa+14afXx4YlkhzOlrVgOhe61Q6Zt992GyMonVEPkPitp0O8YGfvX
         99dLJM+WX5JGkLTcNmAUNeAe8NSCYPCYye+pJX2cuamoHHge1ez/40hzKzxZIcQw7nwd
         Avwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGRs1d627zC31/3t3AcK+srZLfs7p1AirlV0chn57GE=;
        fh=vBOYFZXY60OWSClxHhk/pS6LiEncAHiJPct2sWacmFU=;
        b=eZg1Bm3p3sAdwR2RJnZCfRZaLEuGkK/A1/u8KRe5UHI3lKYfRVWPv676ep+6G8i8g6
         0GbA9soRyvWioyqXhBLvY4DjSI0HiZ7GrM9uHH6Bj0M7oTzrL9NELnNOwnu3lXSgroTF
         +ahaNdvMfUpDMV2YGVaNG5kGiP6A3XqGwvNIauj57bQgRmfpFQ8qJbgs6/qxrRDA+kYJ
         Abb7nb/uab20GVTpzjSpcVB+vPjrPfZMQL6GqJd39CdIFfqHndpM+VOB6NKx8XkIEKr9
         np10Y7jIKB7XQckpQI/qv4QfGe5NbvW4VZwBjx8/fl2FTCcdPdQA6Xh74rAw1DoeWJNC
         mYEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786848376; x=1787453176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGRs1d627zC31/3t3AcK+srZLfs7p1AirlV0chn57GE=;
        b=L9v9mceM0ATJRr1Ky7Tk9u834KxmjElb499AeQF2KKXHbNuigbKavvhJvj+ONYkF6e
         Upfgj2yfDEcKngrVmwQ7xtVIVHa+lDO9j4k83PEqwIFED6EmrJgd+lmuCg9vwoo7MxUT
         vziTIgdXT00AzDPAV/cs+U/bfiJahvx6TbKEwJMt22fQO0Gp1xHRGP0NN4fIhZlZPswT
         yi3v4FDFYpjtAfBt+V1WjKmQC1ySKjlXU6BQ/N5GmXHs2OLYGXly/wa6K5/gCniUy9Bm
         Z6kHmkhdVzGaYEvwzWKemYXj3kCD4JsFx0x0ypyXqMNh4CpigClHMupA2WPX6YRks89g
         fe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786848376; x=1787453176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGRs1d627zC31/3t3AcK+srZLfs7p1AirlV0chn57GE=;
        b=niheSHXS965SH0ERafpdLdoJDs9WBv6VNIdQih2w20mnfAHoVH4CzBjyc04P94xkrJ
         EQaGmLKb26vVQfFdX9eNTinEqUnKsBYRFuv7x4zuiTTeQy0rChiJlh5xG8OI8p8eU4x+
         pJoPBt3yvV/EwvlG0EIA6F1SssrMnUetzgVbL80RNhugmHFTCViQwu8fGAqVX9yhx//i
         34E4l+aa1nud8DSAvxLwrp4vpdAR0sl8VI+7QlGv18mO1DkP9QhbcSHhbYesGqRh5UGj
         qC+/glPiMrFMKgbBXYNorZJeCHfo3Lj04lMHU+MM+5VCMmHzAweCdAJIFvpcv6Z1vqcg
         VgCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+fMS6lvh5pDuVFXtGN7bIdH61me2sRLMG14xejVaK6VWEN2lUUszGLzZCYhXY0KGIlKpEdfXsRVXHkpJU@vger.kernel.org
X-Gm-Message-State: AOJu0YxwEghbbUor62lnjLGryAxim9SqOSyf7naGWq7OfpYwEIYZFY6/
	WdB8jrksYGY4PeWvSVEnJKmslH/qsZ4R3a6y2Jybuw0lGrI3M1ggBTZXyybMzFEQFylB96+YA/Q
	FtLcVoCZEHyZwnnDt/VJ2i4vaBDfYW6Fz8SFq
X-Gm-Gg: AR+sD103SkZ5D1I2+mP5tj4QvygjROXYxR2OB9aDsgWVJ91fJFX9qmcMcxvjlpbi99j
	0zcJ0VB5QAUWeNm1SWOFfbEpaBfQBSyLtwFgesJNq6mkuqpO+GSrsoGGeJiWRP+5XqdH/YIXZxX
	7r17yu49Q2nPW/xANO8CIx208ezo4U2PmieDl4OINgTn7weolXUz+HyxYLUbadEdKevnQZeDhrQ
	+fqTfRAN7JKvYc7vn2Ctu3la7XnhED4W8ibWyXuP8jw9795eCuJxqrq8Xq7Jo+fLmX51hndVlnL
	tifWAugoH6F8xloPcZ1W3EyIuSHSG8pkSYzt1HMHtfvhj23ZXwEAhwBhrJhDPozXfikW01vJa77
	Ccw==
X-Received: by 2002:a05:690c:23c3:b0:81f:2abd:4c0 with SMTP id
 00721157ae682-8370d7e5fa5mr70930207b3.4.1786848376095; Sat, 15 Aug 2026
 19:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813030408.9761-1-laoar.shao@gmail.com> <20260813030408.9761-2-laoar.shao@gmail.com>
 <CAPhsuW6G+8TAb72vT3yubH2Rk4DdUbPpnL1jmvCnbYNx4UVfjQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6G+8TAb72vT3yubH2Rk4DdUbPpnL1jmvCnbYNx4UVfjQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 16 Aug 2026 10:45:39 +0800
X-Gm-Features: AcwNN1UaDA4Bt_XqmIXg5q8PzdXbteMybNsLxTFIyX7TnJvIbQOrXrmmKhyhCPQ
Message-ID: <CALOAHbBcQpEcy364KBjZ-MUr_Ry8y=Nn8_jnPYxgGXFmcADAdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] livepatch: Fix wrong index in funcs cleanup error path
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 4:36=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Wed, Aug 12, 2026 at 8:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > In the object allocation loop, when kzalloc() for funcs fails, the
> > cleanup loop uses `objs[i].funcs` instead of `objs[j].funcs`. Since
> > `objs[i].funcs` is still NULL at that point, it repeatedly calls
> > kfree(NULL) and leaks all previously allocated funcs arrays.
> >
> > Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livep=
atch modules")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Acked-by: Song Liu <song@kernel.org>
>
> With a nitpick/comment below:
>
> > ---
> >  scripts/livepatch/init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> > index f14d8c8fb35f..77746984aa57 100644
> > --- a/scripts/livepatch/init.c
> > +++ b/scripts/livepatch/init.c
> > @@ -50,8 +50,6 @@ static int __init livepatch_mod_init(void)
> >                 funcs =3D kzalloc(sizeof(struct klp_func) * (nr_funcs +=
 1), GFP_KERNEL);
> >                 if (!funcs) {
> >                         ret =3D -ENOMEM;
> > -                       for (int j =3D 0; j < i; j++)
> > -                               kfree(objs[i].funcs);
>
> We really just need to replace objs[i] with obj[j] here, right?

right

> I personally feel it is actually cleaner to keep the kfree() loop here.

Sure, I will keep the loop here in the next version.

> Current patch is correct as-is though, so this is really a nitpick.
>

--=20
Regards
Yafang
