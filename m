Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CA37AA7E
	for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739787; cv=none; b=DjKqOGvoiPyQRpD1eQlQnrchWDyWGnV9bE6y355PidbzbrsXZ4DuTbInybawkdLmEJeFBFW01aIsY/zWuVMB5WIFqbsk3rbNwjIvVIFfjmrEUu71LUj10UkgQPLmkGZTXrUIj5K+Ls4N8sMZOpkz9g2+RoEkR8Fk5FNsB2QvPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739787; c=relaxed/simple;
	bh=mamIKYH7gP4rOIcbI17zAjWJp0aTbihBFeEqdQiOaCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzY3ZSKg31dldpW+qTbkxZ1vR0mFAHZzaY3D6ABL7SicnriaQ2WSxbC0KOSFDSoX/DP/yNOynMUrn0b1XHunz+3CfeJ7LyRjMkjFlzn0laDApWBRDjth3OquXcah08/5clV80Px98kO33o2+8ySBrEAQwpWGjcDKinxzmqy4Rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/YX+k+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/YX+k+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7951F00A3F
	for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786739786;
	bh=XmXvPLiuTqiZ3znxBgMbjsLRBWY9P3/LfSfngOEUXX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N/YX+k+oepmZSgWTt/f+GsMI2Zi0a3VQxhYV5jkpQ55lvexfRr4imyjIbzOO/3ClW
	 8OkySIqdCVY0kWO1uKzQ7lX/KKR66snzARD0omSTyK/JLxZ96hvifzm5H75F0EvmWn
	 Mkoa7P6UhJQiB7K4WU/5f2JhAyt8rhPUduMCA5cAz0S10XeLs9xYbRJT52iENtJrOd
	 /7bvYac6nQJETfV66sX0w7XVsfY3J7jB8OzTlCMBbAc0AuYd/x1y7E9WiQGlBnrBCr
	 72C9O093fOjj0FcSO99hpaAunbE72rtPT+9uQzviqWgpmQuw6+FRTa2Hfg6JkTj5sq
	 grTxN1axnVRvw==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e7632b193so97029585a.2
        for <live-patching@vger.kernel.org>; Fri, 14 Aug 2026 13:36:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq9CM/o7gs2pfqDuJlSBbtfVdzUz2Drr4omLVNBVmnCFIzC5LmIY+TD7VVOBTXENf00QnAK6G/BsVbNqgo/@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGVmlIwvnUOEATAN/VGdy0wYwECObLaZqnbufUkSVHRfX1Gnv
	2/8K+qh1fiHe1qNSmc6RVgDtJvBnpokXRBXHlFiiFQmsOQ5Pwdt1q46kj40HewLJfNjShcmelGs
	1dkvJlT2Nm+a0LtFMZSdJj42KuAOXlwo=
X-Received: by 2002:a05:620a:6018:b0:936:576e:227b with SMTP id
 af79cd13be357-936d234d896mr979119685a.24.1786739785291; Fri, 14 Aug 2026
 13:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813030408.9761-1-laoar.shao@gmail.com> <20260813030408.9761-2-laoar.shao@gmail.com>
In-Reply-To: <20260813030408.9761-2-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 14 Aug 2026 13:36:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6G+8TAb72vT3yubH2Rk4DdUbPpnL1jmvCnbYNx4UVfjQ@mail.gmail.com>
X-Gm-Features: AUfX_mzu-DMUTSZe17rSNaN66GwtPpeLWm1bDW01pXsCaCo0I8iVbMBkiZz1VrM
Message-ID: <CAPhsuW6G+8TAb72vT3yubH2Rk4DdUbPpnL1jmvCnbYNx4UVfjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] livepatch: Fix wrong index in funcs cleanup error path
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> In the object allocation loop, when kzalloc() for funcs fails, the
> cleanup loop uses `objs[i].funcs` instead of `objs[j].funcs`. Since
> `objs[i].funcs` is still NULL at that point, it repeatedly calls
> kfree(NULL) and leaks all previously allocated funcs arrays.
>
> Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepat=
ch modules")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Song Liu <song@kernel.org>

With a nitpick/comment below:

> ---
>  scripts/livepatch/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> index f14d8c8fb35f..77746984aa57 100644
> --- a/scripts/livepatch/init.c
> +++ b/scripts/livepatch/init.c
> @@ -50,8 +50,6 @@ static int __init livepatch_mod_init(void)
>                 funcs =3D kzalloc(sizeof(struct klp_func) * (nr_funcs + 1=
), GFP_KERNEL);
>                 if (!funcs) {
>                         ret =3D -ENOMEM;
> -                       for (int j =3D 0; j < i; j++)
> -                               kfree(objs[i].funcs);

We really just need to replace objs[i] with obj[j] here, right?
I personally feel it is actually cleaner to keep the kfree() loop here.
Current patch is correct as-is though, so this is really a nitpick.

>                         goto err_free_objs;
>                 }
>
> @@ -81,6 +79,8 @@ static int __init livepatch_mod_init(void)
>         return klp_enable_patch(patch);
>
>  err_free_objs:
> +       for (int i =3D 0; i < nr_objs; i++)
> +               kfree(objs[i].funcs);
>         kfree(objs);
>  err_free_patch:
>         kfree(patch);
> --
> 2.52.0
>
