Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA33BBFDF
	for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309970; cv=pass; b=hDz9fG6mek+edXVXGmIYOrpzhla4rARq/lTIAefJNzy+WvTR/w+5wWHPjHYtveHqYurxgghZPM6iJKlfUEzON07l/ZeejnzQrwM5VhhZd4+BvtOuMdzIePuom33ziNrR7UnPPrIEfLceNe+H/wGsje3FxumxRcJwLvq1KRt+W60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309970; c=relaxed/simple;
	bh=Qtimn50r7yShXmmTz1nXwJpYsvPQoL+MvMBGFP1BgNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdWagjsd4vx7NRSidjWdeGKQXqxDDKyIB7NNyFiS6i4pEWHK0UUJWmGo9gpMBKwliH7tNffZ+2UY91Qtm8sRsCisnQrJ3I+lDHz//te1YPzLL6Uns6W/T8i8HwRGcB2dRtyH/HnwSwiheaAPJLYdWWml5ukc6UM6ZWllbv1mY5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfa02l0P; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfa02l0P"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8041a8fd711so30244777b3.1
        for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 07:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309965; cv=none;
        d=google.com; s=arc-20240605;
        b=N6+RZcGknsSuBaJOZBmxh0OccyXTRA7j74wAIh7bkQM+orJGdIK6crrv4+S5V3M/QS
         d+BSZWGCp5xy1PD70Uu8XSUh8OR0JMtobMOBrKv7upusUYiHTuzjJkXKqOn/qGOaQKmG
         wWZ+hv210WGhH5Iid3MMvpd0l7XGi1Szpr12zEUHlSWnx78Cb7iqvSMNMOapTyhC+/zW
         OB/YH4jKvcw01uFzdocxuWFdDpVflgfjA5BWZvgudlbg5jP/nKUpDIof7asTzBPXXH17
         w3p4U44qXn35ZpfNPGTGrTO7GKGRvlTOtMpAjXg35RbHgyeCmL33qS1jlIv4CIlwpThv
         zyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g2rEiIIFhz1SFej44pFwGaAb33bon/raOGd5YWlBZ+I=;
        fh=KcFlSezYn2xzm5l/3PLAU+xnqyBYnlC5mirTiyJZsSk=;
        b=KjYmBM4mH+2TnO/8boiXNQruZfazg+4e+5ZZ29geaTfbPOc/VByxNK8rjUlz5+Koy7
         VAoQhMe/b0fKdqzy4BPNBi2XsAq90+Arvwisz89pRNz9coBmg6h8QsNSXP6XwuYDrKZY
         7BtibuQyMCRZ6oqPXg7M9utd2gI1xcgqduYq+eoKosmIHXq6kTSIbzAuxXLKh6DvmZmk
         JOzvpFYumc8LF1KKKBKT2ugu5U6V8Ki44PyCEJ8fQSK+RtQCwGbWWAbz6kt6oCgT8uyl
         iZQ4UwzkYHqHDsM+uHpA62wnes4HsAOr3RmBu4XWFQbZsW4ep+fq1RqLV6eO8rSlWEA3
         3JiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309965; x=1782914765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2rEiIIFhz1SFej44pFwGaAb33bon/raOGd5YWlBZ+I=;
        b=Yfa02l0P8AaJjR8h6rcLe/CoZazO/oOwL4UPP62wq4Xo/vuV9INbtMEE8sfxyrIBYH
         RTcXHZa5bmoBejvBCnbei6TeB4vVgKiLipUhb7VuWFqzk8veX5OTAA5KAoysQ7Civlbk
         yA/FQFuJ6ql9AXWpYnZNBp1/bnjpOoc3AjzQr4Ybmrvo7aan2Ahsg415974INvGFwaw0
         oXowUcocbaxbLpnW/wp3+FIV+3JJ4EmHI2xeJe/fgg9naFNpPEMeN1Pap0vSp2zTc3yJ
         qlDMf32rKu9AquvHcSS8QdwSbRgSDCy/aLiNouOOkdKMghvCo9pRRlrdLHIEEyz5bYut
         Ju9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309965; x=1782914765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2rEiIIFhz1SFej44pFwGaAb33bon/raOGd5YWlBZ+I=;
        b=U5ASjhm06pIxhhcdm+eMILl9qXrr0EvGdchZtDZYN3ChyYWK1+sU8jN9qNpAPE2/+l
         BWRCYZkZ1bUxVSu2P55iJmEOpKPsG9W8WRc6hfQyRrCu/K+0qfR+IaZbw4SucISnCklV
         InqlV+jwVOnJVvvmw9vBaGInD5AGDvtkbi5hzmoZnTRvF19ZaD2KpHafXdhrGdH9TtWU
         wHHFEjiFSFO3IJtAoQaH7hPlmlGuF1jABOVpoxKBZOrujRs2rr9WETBfuw4tfpIg7+u7
         NINfj/QHxfWPMzqXX0yRTw333uk9QNA2SnTpKpH6oUuwvw48XCixMfxedDhOnYQqLl2p
         6wUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrtojw8nm2p23OjWoTYMHAPiERsn47s+b3teOaycfqMA9jP+mCi5+5D0ofGXUdREBMVwOXYsOeu2eYKvi0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+BYvnAQIN2P3nWNLT0ZP+KUUNuDFBNkW3UOCMF52NwTb09Oh
	Lvvq9QDSgj7NzFrkhakp8W2nRMY+VWx2ErVX7GAdoFaRIFNgAUj4iud5r5FWbcJAQIak21Sz4F/
	+jiccbOZIrrs19V/U1IfmFbVKxnHO2wY=
X-Gm-Gg: AfdE7cmz5Ow43sMFFhko+6VJuVttGpsJvVaq8udU6tASnt84gpgEU9pqysPOzpVIQau
	vqadWzMCvZ4kkr1mL95HlYlcPDQT6SuYZtsFp2RA41E98pvIilSDebky9tN4XOEmYKKM3OQw3NY
	S+nPdbJFUjfygmLMhyoyEgbTuweSvirYSGgUiEQB1pSDTIDSGftxu3E4Y/Q8gLn+xO7An62TEUb
	1lSbRw2LDRgZHps0CLywoIk3sdaDXi5bGV2WhyWsMWgwX6fj1e8kvnmCXdMLtONL0AspmpIosXI
	WwdYWN5KyTFV3QOAmep+jJdqrol+Rg==
X-Received: by 2002:a05:690c:e3f2:b0:7ff:5a5:9b60 with SMTP id
 00721157ae682-809d4258e55mr6114077b3.22.1782309964778; Wed, 24 Jun 2026
 07:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <alpine.LSU.2.21.2606231124200.1711@pobox.suse.cz> <ajvh-mMT2blBXJ3x@pathway.suse.cz>
In-Reply-To: <ajvh-mMT2blBXJ3x@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 24 Jun 2026 22:05:28 +0800
X-Gm-Features: AVVi8Cf3Afwyd1nAPHxsOJvwyJ24FUvmQiNPjjsP2tc55s2F8UDhgkHDySb4UdY
Message-ID: <CALOAHbC==TXeHdz1jYGMFaycv0eCdJ+Wy7_Xkx5EQBCb0HFibw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, jpoimboe@kernel.org, jikos@kernel.org, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 9:56=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-06-23 11:40:31, Miroslav Benes wrote:
> > Hi,
> >
> > On Sun, 7 Jun 2026, Yafang Shao wrote:
> >
> > > Convert the replace attribute from a boolean to a u32 to function as =
a
> > > "replace set." A newly loaded livepatch will now atomically replace a=
ny
> > > existing patch belonging to the same set. There can only ever be one =
active
> > > livepatch for a given replace_set number.
> > >
> > > This change currently supports function replacement only. Livepatches=
 that
> > > belong to different replace sets cannot modify the same function. If =
a new
> > > livepatch attempts to modify a function already modified by an older
> > > livepatch from a different replace_set, the loading of the new livepa=
tch
> > > will be refused.
> > >
> > > Similarly, for the KLP state, livepatches belonging to different repl=
ace
> > > sets cannot use the same state ID. The system will refuse to load a n=
ew
> > > livepatch if it uses a state ID already in use by an older livepatch =
from
> > > a different replace_set.
> > >
> > > For the KLP shadow variable mechanism, developers must assign unique =
shadow
> > > IDs to livepatches that belong to different replace sets.
> > >
> > > Support for replace_set compatibility with KLP state and shadow varia=
bles
> > > will be implemented after Petr's KLP state transfer work is completed=
 [0].
> > >
> > > Other user-visible changes include:
> > > - The non-replace model is now deprecated
> > > - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced b=
y
> > >   /sys/kernel/livepatch/livepatch_XXX/replace_set
> >
> > I will add my feedback here because the thread where it would belong to=
 is
> > more about details now. I am sorry that I got to it later than I wanted
> > to.
> >
> > What I like about the current state (non-replace and replace_all patche=
s)
> > is that it is simple when it comes to the code and it is agnostic to
> > different use cases as we know them. Yes, it can lead to really
> > problematic scenarios on users' side but the kernel code is
> > relatively simple and flexible to allow that. As a distributor we chose
> > something that suits our needs and what we think suits our customers as
> > well. However, it is a downstream choice and implementation.
> >
> > Now we learnt that some users would welcome a specific use case of keep=
ing
> > parallel live patches applied on their system and they lack the kernel
> > support for that. That is ok and we should do something about that. The=
re
> > are two things which I am concerned about though.
> >
> > 1. I think that we should not leave our existing users (which we do not
> > know much about) behind and regress. I mean we should still allow the s=
ame
> > level of flexibility. If not possible, it should be seriously thought
> > through. I am talking about non-replace patches here.
>
> Good point! We do not know about all existing users.
>
> We have already changed the behavior in the past but it has been
> relatively long time ago. And it was related to introducing
> the "atomic replace":
>
>   + commit 0b3d52790e1cfd6b ("livepatch: Remove signal sysfs attribute
>         [Jan 2019]
>   + commit d67a53720966f2ef ("livepatch: Remove ordering (stacking)
>         of the livepatches")  [Jan 2019]
>   + commit e1452b607c48c642c ("livepatch: Add atomic replace")
>         [Jan 2019]
>   + commit 958ef1e39d24d6cb8 ("livepatch: Simplify API by removing
>         registration step") [Jan 2019]
>
> IMHO, we hoped that people would start using the concept of
> "cumulative livepatches" and stop using the no-replace mode at all.
>
> Obviously, some users keep using the no-replace mode. And it causes
> problems. I am pretty sure that it motivated the following changes:
>
>   + commit 3dae09de4061671 ("livepatch: Add stack_order sysfs
>         attribute") [Oct 2024. Wardenjohn <zhangwarden@gmail.com>]
>   + commit adb68ed26a3e922 ("livepatch: Add "replace" sysfs
>         attribute") [Jun 2024, Yafang Shao <laoar.shao@gmail.com>]
>
> I am not sure if Wardenjohn and Yafang made the changes for the same
> user or they were independent.

We have migrated all non-replace livepatches to the cumulative
livepatch model. I find the atomic-replace mode particularly
beneficial, as it significantly simplifies kernel development. This
motivates me to continue enhancing the atomic-replace mode to ensure
it covers all use cases.

[...]

--=20
Regards
Yafang
