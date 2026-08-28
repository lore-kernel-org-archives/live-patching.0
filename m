Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD639658D
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886934; cv=pass; b=IDJkrD9mQADZcbKcrb3Yet7APU1Am2lwgKiLQtnnTZmAurWxUp/7XYcS+YKD1CFQ7wjspb8YFFKusqPANXpl38lH7++pgTz4/K5WJ0o8OhS+DqCQ+49ViIlepmWLw4m/dtEG8T5xPqGnBzFu5wjfN1HQAeyWT2fiYD65kpjfYls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886934; c=relaxed/simple;
	bh=OG+PBNvVZhGSP0WlyMvBnBDvFju7IU75cpaSz6aK79A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmqyngOPHYa3MZ79xwZu5VIHdSEhLTHCot16jE4E6Fka3hUNPf0Yuydn39mI74kEgpS/ZPpzo1P+pFkW0lHYnq3um8vZD1MJq5LkltX4ebJRH3bjF+WXU3vUXmEdD2jJG5NNXqRUwlLPd9Ly+51TucGLlmA7qLOo+giiOBpk8c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA3xVzQ1; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA3xVzQ1"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-856114a8247so8388677b3.2
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 20:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787886921; cv=none;
        d=google.com; s=arc-20260327;
        b=T0DRFbQz1ZxQ6z3eQ5PnddAjoJUtUc6eYOZMBC5VcOvY5bDunw1r98tymy53ezHdAf
         RMfONmSLDQyeY1WgO8wkkJnUsZGX1AfU/zmPG7EeHQo91C3+LsXHx+Wtkq9xa3G61LFL
         3sXN3dq65lgbEvhcLMM3aDawrYAd+Y+w01H9rZGnF0LTHKZ7IPH4eXXfBhWAWegDbmSD
         4gqGafWxaHRhVZX62qwzwgKsFJhbqRZmxOFPs+YAtQrYOMjqfrf37Y5MZcM02ppb7ZLT
         CC//Bju/OO5URO4d7flPFiXYjm+2dzGbVJ/eJaxcw7jU3OJIyasQI2USXPOu6LHQeKGe
         VTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=869sMHV2MfE5lc59AB49S1TwZZ+jZTVaWKDI4R3PFAA=;
        fh=9RBjEHKIrawuVT3Cm0EQgGtTLKQ0EWToUWfG8CT5Fjc=;
        b=AWSwtMEERGTdgS7VrUHfHwc6kXlQRZKtLY1xrAmP2xF481K8EmzIFPncE++/oDKuoU
         qbqLMFwKaYTcyTgxvO+BFjVg/RZBR1Gy7mhQ9waVERSDKdejvc3nAdEeq8S5TP2mzrOw
         ELvhC4IGkNEaqrJ9I+kcRVe5vFFg4sxCtj00oh9Lyl4PssmG5GLVsWj0HLWkq5lLVL7Q
         Cm3Nltlu0umkZTNajLWCGCShxP3vsSTo9X2rYGSdtSlDKyyTq7Ug8kA9wGCT3GuJHxzs
         tBefNS3LFJ3RUaFqJ3s7TXmp/7T4Jo3moLEimp76ZzOh5k3IU5bjoAgDP4+CN2bGtH0D
         v8TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787886921; x=1788491721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=869sMHV2MfE5lc59AB49S1TwZZ+jZTVaWKDI4R3PFAA=;
        b=QA3xVzQ1io/FLNROsjgJ+XpKZdfSoBviDLmtUUB0LwHP/XgIoUxurN/Y7uypZZsN+o
         hKmKLtLOgpt2HCzI+gC2dKeUirrO9iBarEbTPBAqEIYWI0aZ4m0FLPGJxAPvMzq5Aer0
         RJydhi/PivgWeF0vGUx9peBbZRaFt6t7vzB/9313IgRTxPxa9RoDql/bm7VxKC/PjFfa
         YEHLkbT/7U2qRGZ3t0ltG+q5YvQ8ULaFCaYDVNxN0q+NJQoIIsSJYNpM8spIoR9YROow
         DtFfngYw//t3T7OkPaEMHXqfCIyHP6Pyf7v835noUcoBCQ2DiO8HpV5h66LCMKy9HPwi
         Ca7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886921; x=1788491721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=869sMHV2MfE5lc59AB49S1TwZZ+jZTVaWKDI4R3PFAA=;
        b=c4fh0IqNHKn7lXOxPF9UGvEHFL/LARUtPTtvsmfx/MA9HXY4alzgyWWIUIz44lX/KC
         JbtJyAuJEMptPMSiYqga+USHI0lZgB93faYwjhREj9TdtQMxwW0Q1iRDPmMbTJ8ySrvV
         zcMSuVXGwMxdHFIQUJbCQtTXYy3vk/QXuXzgXbHYc2e20Dc324tYCIDJbKVBQl9jDPd2
         0gf9IjMKSXkA1qoIcOUttUOZHYG7cHHjFRxV6gL6C8KegYgkfte2q9MjGk6Oixd7pQXe
         NzB129clcshS5SBK88eiJvItqVQ+N0WWZQdkr/pDhAPSH47fnfAKh/LuONh9p3wMkdmF
         i3yg==
X-Forwarded-Encrypted: i=1; AHgh+RqSl1HAS7EQYleV4BExujhrQ4OT+zYJcPiyk4AwqRrToJP2J2XsMUpLzq0xVxyvnzPLkEna1qsj5GHRE7/Y@vger.kernel.org
X-Gm-Message-State: AFuF++kbJdZzheDFZB4/HwBnY5nF8pT/mPqR2iXsjOteY6JA5zAbuoPi
	kGwRHfM+TxHtwdfLQ+ipoIJLHmvDMv7CeE8ZFwGEXGF5xmlP9M8fipcljBMlGbF7eGzCONrVM1f
	JacHmUf3rRU0c/NwmNxyy26v5F2DtxpQIvw==
X-Gm-Gg: AR+sD13cjHVdlbito3niIwKL7QXtSMG1mfm8QvHGZykfCOqnBwilXpxjk3puGJvIfNI
	hpEl4MfnI1a9JLIfMnFFtT3VZx8gXPBHeJ1ioYCCBwlYrcUIy4085TWd+mGIp9dSwE564v5bQAj
	gsC6G0aNBLaD02MlkkrX21+n056KAtZfwZ74AnG8hd+casMBvQhla0WikJoQF7jKbzYSH/UyTx9
	4TClcswqbZUgWmVvZpULa00Sqic5IBnUGZ2BqYAIST/UvV+N2SIdaK/a1yQwECQTA0GskGOoC7V
	HMWN1hYFXI9sNzS2kmRFxcTR90+8Rv5ZZvk1EMthMofAQvKNup9TwP6okVtC5GbZq2eTGigxcUU
	B0g==
X-Received: by 2002:a05:690c:4981:b0:80c:f6bb:565d with SMTP id
 00721157ae682-85d6cdc686amr19298547b3.19.1787886920841; Thu, 27 Aug 2026
 20:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-5-laoar.shao@gmail.com>
 <apDWJIGt7utIr2oA@jpoimboe>
In-Reply-To: <apDWJIGt7utIr2oA@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Aug 2026 11:14:44 +0800
X-Gm-Features: AcwNN1XE_y_H_OYUMr_ba5LGkXU6i7zgOJgr2V3u-rUj09pIwzdFTZmDemR6bOk
Message-ID: <CALOAHbDf6-sLRbxRwGro+v7McVvkwF5a69dKkzaJpXyJL-6QXg@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 4/8] livepatch: Deprecate stack_order
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	Wardenjohn <zhangwarden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:29=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Aug 25, 2026 at 07:46:37PM +0800, Yafang Shao wrote:
> > stack_order is no longer needed for atomic-replace livepatches, as a
> > single function can only be modified by a unique replace_set.
> > Since this livepatch sysfs interface is mainly intended for kernel
> > developers, backward compatibility does not need to be maintained.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Wardenjohn <zhangwarden@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  .../ABI/removed/sysfs-kernel-livepatch        | 16 +++++++++++++
> >  .../ABI/testing/sysfs-kernel-livepatch        |  9 -------
> >  kernel/livepatch/core.c                       | 24 -------------------
> >  3 files changed, 16 insertions(+), 33 deletions(-)
> >  create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
> >
> > diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documen=
tation/ABI/removed/sysfs-kernel-livepatch
> > new file mode 100644
> > index 000000000000..fb6ff9c3b43e
> > --- /dev/null
> > +++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
> > @@ -0,0 +1,16 @@
> > +What:                /sys/kernel/livepatch/<patch>/replace
> > +Date:                Jun 2024
> > +KernelVersion:       6.11.0
> > +Contact:     live-patching@vger.kernel.org
> > +Description:
> > +             An attribute which indicates whether the patch supports
> > +             atomic-replace.
>
> This part belongs in that other patch which removed it?

My bad.
I will update it.

--=20
Regards
Yafang
