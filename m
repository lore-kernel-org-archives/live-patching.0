Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08CE1A38F9
	for <live-patching@vger.kernel.org>; Mon, 10 Aug 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786333580; cv=pass; b=bYfmSL7VMucw65aZqh16Suz9nqs38Oro4KTN/5tCGoTNtfyIOz37rJpEF8AKlU+H39KNWLQk8qJMf7TK6TR4b/nLuhV+y6sLQZW4ke7jB1Kcq2MkxGhDGAmsS1rYU/y4KtDYxHmX+CIRDnDjMbJ6moyB6YqZkcREQuJ+3V0M31M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786333580; c=relaxed/simple;
	bh=rZfUDpZmDTdfQ8C0qGITZ8ADGX7cKm4jcQbwyknvyAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yhw8Cz8gadPbYcX0wBsfJBjSKnF/U7PoYiwH7eg3jW0GY/naamrOTKbro0UguqcmpOyZPg5ihzLTDm8DoQe2HYSBZCKIXYxS+g+VB9ekmsHFsKFfmr15vD4pWsbOTOrk9NvH8f6+3PSN6LZ2/mWiHrz8qJ7aeTNDhyNAiI10cBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbiLArIY; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbiLArIY"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-821106b5b64so25111407b3.1
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 20:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786333577; cv=none;
        d=google.com; s=arc-20260327;
        b=ZQXJg5nac5+HJjqCYTSDAboi4UXZOXErh6oDHd6skVLGCGHy+KKJ55EKMothATY45V
         rj6VVSYkKKgsqTi9z5o1PqdX6aaRGFzgqRPotZsyh3wWv4uQlGgvzTqXEp9BXxOYy57I
         o3dOC43ek5vwkK2TqXregXzChl5PhQ1gB+Q2i681oGXlqR0wvMF58mgRyWwk4nT6lQhM
         owrSe+rfYKRCQSbhRBKBQDWpFuHv8gjZUa+Uzt3+DtBdGkCnA4KWm6EujsXlF9cKBtkU
         05S4uh5TrA6bb3VT/XCrJPJGE1eZYHI0KufKQTGY6Ufzuo5V6LyWzERlx3D5ZbR980e1
         oZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LJHX3RK2PWO6lQmLZCg4va5QtN/LZmpUOcgWZduGKqw=;
        fh=i3sc+cod2VhRbAKCPBbdSzsvSYTF2wbqMz+5q3G/AJo=;
        b=cBzW1egmSjb2a1OBiHqSr2LD0pvm/8GEHwpW95tv6fXLxQG8svENZtontGw7gVCZ+9
         VZr7AqqHv6NlXa9+qjgDZ3ql/QWyvOkvVwhsp6or9cEoJoQn/GUwdDXwsafPEqybjaq0
         4ZDlfF8OiFI8ctiYDpenRXHheRR0wd7g2Fbb3h3r7nkINX2wY/DJ+NoYf2Z9PitDl2Ei
         aMVIoGfRqCPnUMDp27Wo8s+AD8ZTPpqig3Q5vADmqNEayUsVznMMoJwpoky1LzhOiyNa
         jbsHYEoaIo5fPlZ+2TzskFZ4g15iCT6OZtgZqQqOWOYBEZX2v9XUViimsd8zkIxIiQKa
         lDMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786333577; x=1786938377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LJHX3RK2PWO6lQmLZCg4va5QtN/LZmpUOcgWZduGKqw=;
        b=WbiLArIYu+DkOYTLVM5dt9NcGjRa83211RxYQ7OrWK5GTF1lPlQ0ltzqARTG8avQsS
         HKNT393wVdiWTZB43dRw28xk/uTQD597KTNCr35Jm91xXcZ31eS+i7FJ4TVV9X5eqZNP
         AmmYQptI3vJY2BL0gBKfs1D4UlJUwf1JOcH1MIAG3z68Sbom4BzTGCy1BPzWg+ROkp5p
         jSCeofjnGLnVUg3+CBDHTV3war2LAjGPf8QybClOCr5Cpf4eqgxG8idd6EZxFrjj4Pm0
         flfm1rUr+CAZBw/yqarIQ5vYT1SOfEHP9YTiWj4yl4XmcuAaqI3Aj9Qx13dxMghfxlmg
         ApwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786333577; x=1786938377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LJHX3RK2PWO6lQmLZCg4va5QtN/LZmpUOcgWZduGKqw=;
        b=ZNq2mKtmEBqJX8dXyXSg4H6mfTJKDrWdJ7NtztwUYd4xYwgc6J/qqE5buEWM59HQNl
         fR5z4Rl+973j/I8C9JiSdQp4exQ9yomM0pREQ7mHf4mjsOcUd/aLJUf9J1axiFCZ2qQJ
         CAVNjGhrnaxF6Ny8+zhFzXkA1xot4DRc9nMR6ux+7IroeZgRpvmW+wk5Du3eMnUD6yI1
         WlCietbmy5MhPOb/zZ6s2NM2st5ymPm1kez/mFhlngcoO57uXU6HszSecddccLGf5riL
         HSSz+iJk0q1Fr/qfdlL1KOFog3/hluDeUbRWCBAHzbbpvAzd8USbNW+yj9QbnRTVIAs+
         jgoQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+G8kBS7aOoCDz33I+qQMZnfy+PTq9y2rD/Ctw4QPXbsSZKo9VbAj4BPVXFisigEYswDVGitAgsUwMccSo@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIOMaMUhe8/orRbidP5Jhqz36Icc/U//vtaCsHBghdH1ccQmH
	GWhv98P931zJTgBV6RkYwfobI+Kkfj8wqge8OHZ2PWzZgBaZ8H41ebplm6N8dJ7t6jScmToKkMP
	VAvoI+kSziW5tPFqlzwQcgykEQybVP3Q=
X-Gm-Gg: AR+sD10r/Sn5XJpVOMcZPSoa8M9gZae1HIFYlRFczTtap7BQJgVb7LRuREnJgEeFXQq
	s9NOKZDinOxdW2rhN7LbXKkTcITeWEDGGRz7tZey/vqdbBpQXXV70gwV20NWoaeKjmHTewCFN9e
	ITAxjZ7/NM0WEjt0bPPpZm3C/A89t66/DiaWSDNTRIY64Jtq/dFKFmKJpT5EZup+BIvB4hdo/GI
	LuCx4qntWaX1/v7oj5k4CKJ1CZiGO6VKKKngzEeA/Z5GvvNqsEPzvq64Z+zCiJp0+WFUvWSpp7l
	LAIyh9IU5gTCmg220DwB2CkJvFzhQvH4MZGUZXcyfbGE9Yt3ublStdtO7UnV7denARY9n/jjps2
	o
X-Received: by 2002:a05:690c:601:b0:823:3c47:ed67 with SMTP id
 00721157ae682-825ec574f21mr99592437b3.6.1786333576898; Sun, 09 Aug 2026
 20:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091954.22930-1-laoar.shao@gmail.com> <20260809091954.22930-5-laoar.shao@gmail.com>
 <20260809093315.930A41F000E9@smtp.kernel.org>
In-Reply-To: <20260809093315.930A41F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 10 Aug 2026 11:45:38 +0800
X-Gm-Features: AUfX_mysx4P7TAvUfSk2bVe8dMwxjc75u2pCRBB8RPPbG3tf99X5Elc_uSCXP2E
Message-ID: <CALOAHbCfosBwSfv4Bq9itng7WcCtLpm8fnVgJSZdKpHzUi2dGg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] livepatch: Implement replace set for scoped atomic replace
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
	song@kernel.org, mbenes@suse.cz, jikos@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `--provides` argument in `klp-build` lacks input validatio=
n, allowing shell command injection during the kernel module build process.
> --
>
> --- Patch [4]: [PATCH v5 4/9] livepatch: Implement replace set for scoped=
 atomic replace ---
> commit 1fb78be5e32d18ecfd4bbeb7fa484d70bf6b9401
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Implement replace set for scoped atomic replace
>
> This commit introduces a more flexible model for livepatch replacement by
> adding provides and obsoletes fields, allowing multiple independent
> livepatch sets to coexist on the same system.
>
> > diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> > index c4a7acf8edc3f..3600f93d9c1c3 100755
> > --- a/scripts/livepatch/klp-build
> > +++ b/scripts/livepatch/klp-build
>
> [ ... ]
>
> > @@ -189,9 +190,26 @@ process_args() {
> >                               NAME=3D"$(module_name_string "$NAME")"
> >                               shift 2
> >                               ;;
> > -                     --no-replace)
> > -                             REPLACE=3D0
> > -                             shift
> > +                     -p | --provides)
> > +                             PROVIDES=3D"$2"
>
> [Severity: Medium]
> Is there a missing validation check for the provides argument here?
>
> The obsoletes argument below checks for valid integers, but it appears th=
is
> assignment accepts any unvalidated string.

Makes sense
I will update it in the next version.

--=20
Regards
Yafang
