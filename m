Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEF1D5ADE
	for <live-patching@vger.kernel.org>; Mon, 28 Sep 2026 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562796; cv=pass; b=ALurxLA4ysJqbr55zuO6h/3KuZkMJVDB3tBUi9u+rhTyoqQ60033uTXmqjGl8oNEcCxD+omGrfguabuftw25kbA1FBZoV74uDteV+HRzCHwzIuFvzevxtXHkFUOxD3bdGEye/U4vCPXOd548wfR5wciOmE4TITyyAD/RNv0MkV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562796; c=relaxed/simple;
	bh=4tvb+Cw4cp5bbZg22/RwYkAzNNUJvF/1gXuGs2vogUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtMEMFDp42fNvlq56yaz402OXfGekffnhSNWG6/Sv/rRwwfmuU7c5MqnOChdjcPL5anMoNvdEORrmfgBRN9g70zg7x9Dc7OqzklhFhzpPHwhjZSHpBfKyBkIK8HBaMdJGEXXmBNCrx68SqIM9Tz7+fzbugM9hzLdB9CatNz8+Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew9RSRPP; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew9RSRPP"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a88d23a5a4so21010707b3.1
        for <live-patching@vger.kernel.org>; Sun, 27 Sep 2026 19:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790562794; cv=none;
        d=google.com; s=arc-20260327;
        b=NPXQMbM6TkY3jOop48ZYhEtjeLuQyvF+uFac5Pa9cQ5XBtExeEjVxjiOaOExQx80dB
         vBq+eFZRutRXUyDz50qfhY8NdGBlIi+7aNcclqrIVp4Q0KdeN1BS7kd7S1YiH+sDGYcx
         Mk4AfV8DMbXP9siKZe0ILJ+gV/R1CtOKgl13WiKwuevjPTCqEvxxFxKPtEqq/dZlAXy3
         cL5ZCCxBuIZHmNoYBSgp+oHrRQH+MhD/w9KodKTCPPGi6wRgzRjxZN1fosixwWWuFJ42
         8QV3wvxTnMPajBadUx7ZBKwfAo7Bdvlw1594VYWqftdyL9KzLqLbtR+nNohPByFYbEaa
         BJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4tvb+Cw4cp5bbZg22/RwYkAzNNUJvF/1gXuGs2vogUg=;
        fh=O5pl1a+kZxoSw+FtEmGkRnmb4knFSNfm0FHUanAnMSk=;
        b=n73Q79RKNOb5vU/qm35sBdLE+u137im3HlQTfJtATK+/k9PW0FLGK5Zi0JY+p9YcwB
         F3o5SebGBibEg5z47GVLbKFV5QTGpcbo/zN1rEW03i8E6m8hRut8c6P48zfCRUKLEPKz
         axbnk2u0Mtw236Yns8mUVz4/u4vxFH1HzmuQuFE/lqmAZl2A4cTfkygxz1s+4gU2UfVH
         Au+0FxuC+M8lIs0acg09/EzHBXSHw8DGeRlKVC3whUBDY+LfatfmyZUiBRctPMX5EHRL
         SduM1+3LgY2+tGEN6ak6LOEgZltCD15+CO1egDbrhJTWiLTH1rlr433d2Vz0Rrpbf2za
         2ZFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790562794; x=1791167594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4tvb+Cw4cp5bbZg22/RwYkAzNNUJvF/1gXuGs2vogUg=;
        b=Ew9RSRPPh5iim7BrGDZguVqmcXNTsN/vkaT4PgrT8aOXkv/lNGClpIRbi9aTmCtyOM
         vGLtxziGWr5syV0eHYMRsmBGjDJmPnSM/L32Z1ESweo8wSKXKo1YvLs01rNM00WYImKU
         4WM7RxCzaySMT1RR9+c1HyBbnsyiwDp1bfjNNxaNGU6MvmjM95uZJRDmaN1asUHuwJzF
         9+sPVTucwoK5RBW6PgzjqR3Uxesljni7tZIrE6BCiF4xgOnyFNve1R9y0N+BxbTTDe2q
         wENByvZGnZsf7kxFumYE1YRpUv0ubjhqsDx2VgVtCaeDFvwynyrSYhTiTebv5t0/z+Qu
         +EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790562794; x=1791167594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tvb+Cw4cp5bbZg22/RwYkAzNNUJvF/1gXuGs2vogUg=;
        b=gG5R90Qf+dZaS+6IVqGMgqfeGZcrxkFrjvdcmOxnJNmj2kQ7SRdz8Jr7zEOPpf4Zc/
         h12KdTqoO9ahk8FKcsRfcB3sklloC2R5VgnG4pcFAw9sKZtBhKO3SsmppFX4/JaooMGC
         CVqaav8Wbj3Ce6OLVGSMZP5NdytYl4TYWYlWLC1ao0QbacyvOzq5GMnyJvoQEMYy+EhH
         ygZCyHL+gRB6NpJBRbwR+j+2P5OTRIaPL/hxvxrgLbBdprGhQQBAqC3z6ldXE95qqED6
         httE2cpQvmtTPty8cR5sLAdZ06mMo0jEsafQObLcPMh3WeIGpcxjUsgwJh+PsVCoY/Dy
         A47g==
X-Forwarded-Encrypted: i=1; AKwUvBwJeW2Id3DiNy8EJo4qnFj88hpT2H/2QtWoYbw0KtwHDZADT+v+zIdMBT+TS0bLZgnCixWHi9OhUUYxU5JU@vger.kernel.org
X-Gm-Message-State: AFq9FYJJfhJ65f1C/giQjoyLIZhesfoZh6MPhf4L0Ke5SKovTOjecehK
	PCoxclN810YUAPo6NYVBVtmTdGrTM8klEIxkXNxaznDtGprzL/ea5xBchemdIwbHPLW5sZOYgU0
	rUXa5WtG2ceDgwaEMNCcmDDK/KjLBy1M=
X-Gm-Gg: AYBFou1cprjsQAuEglR14YRoTqKOxBvRuaD5Kb5W31ujoZ7HVhLnXZp4F5PGcUMm7Sa
	s0d8+r1sX/c65mJXIs5ZE2W1BmzukHK83AdYHNQI6nNy1m2IffPgbKAHyrEYU+00nLU+HXd5qer
	f+h2OaISKqnNQczRd9/9QkkTC0ilLQXDKsazeWZfoGVUimaj0T04YCh4B7et3K+hr3BEaGsph8y
	qV55l/ABN9ClzIGokFRibiWY/jB2EClCVrIUFKfCc1wfrjNyQ2d4voJaJOwq6IJYhTVsNNyqNTU
	41zGGhrq7tgx2I/N9pdYQ+fYKZAwbhPhKChcQHowhMLb55FZN/YsodkCKfKkgHfWbBoSmGH6Su1
	WhQoqapGXTdxA1b/X2QjU
X-Received: by 2002:a05:690c:60c1:b0:89e:c085:f7ff with SMTP id
 00721157ae682-8a646e85c15mr50980587b3.47.1790562793938; Sun, 27 Sep 2026
 19:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <CAPhsuW5+j8ff0h1ty-vOiAWUnUOcJ0UQhUqvJRVSMrVH9WqbZA@mail.gmail.com>
 <arYnjJxU_JecIrZq@pathway.suse.cz>
In-Reply-To: <arYnjJxU_JecIrZq@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 28 Sep 2026 10:32:34 +0800
X-Gm-Features: AclHuK9uAfqtETpi5TgA78MZstHyLgE5hcSewHw5NdZ_KPi-esJFcyHPuwVSh98
Message-ID: <CALOAHbCA7DooLubXV1QE9+Uwk0RhF89bv0yNm=HTSvCsZg2Q=g@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] livepatch: Add support for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: Song Liu <song@kernel.org>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:49=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2026-09-24 13:56:32, Song Liu wrote:
> > Hi folks,
> >
> > Do we have pending comments/changes for this set? If not, can we land t=
his
> > soon, so that it can go upstream in the upcoming merge window?
>
> I still have to review this last version. It is getting on top
> of my TODO list but...
>
> Anyway, my main concern is breaking the backward compatibility.
> I assumed that we would discuss this during the micro conference
> at Plumbers first.

Hello Petr,

Unfortunately, I won't be able to fly to Prague to join the discussion
on this topic. Please keep me posted on the conclusions reached there
=E2=80=94 I'll make the corresponding changes if needed.

--=20
Regards
Yafang
