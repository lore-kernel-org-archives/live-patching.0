Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2D3E5A0B
	for <live-patching@vger.kernel.org>; Mon, 15 Jun 2026 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524806; cv=pass; b=OxV2Vsn26hDRH+jGuQBBoAAjr4ITd1+KWNM+edpQSyoFbv6mxGl0zhrwtHrb08iiWbr0qiPGi2+RUw38HqBDMjHn3mLr6l1Pt0Xr09wHSgURlJW7qiLB+XwTqTEruyCGFnrK003HTLh8pc3JKvVyLZkgrqyOzn7pXghykWTV3d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524806; c=relaxed/simple;
	bh=IPEKk5aSDKXbPfvzqBlQxKm0RWh/NsR1HTMt0r5AOXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihdbltoHbW5p24oHDYFfocen7Lz/absKoIFcfMIdcIxq1crvytiHdlxOGc4PKSPxGcQH5ve3qKccjvENfINTEqIOVSEYHQE4eiXClMGgBVjQ5Rlb2aGbnFSE/kcx41nLo8Od67XxyHo5L3uHg22Fpm5vkOoNPNCav5kXhhoKbdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYpvHcsq; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYpvHcsq"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7de68222e96so22741987b3.2
        for <live-patching@vger.kernel.org>; Mon, 15 Jun 2026 05:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781524804; cv=none;
        d=google.com; s=arc-20240605;
        b=DG4Y59d3y/3VURjXFfrpR3NU/gMARkbcMbn2VZCSByhr7hxgBA/JYUMPu9ZG/kggHx
         ARU+k4d8lXNLCIDoWbOVdM089LasaIXkgmTf8EhqxHFw50jmUO1I6gFaXb0AGFhvfTC1
         cmbzl9jkV9uV7kq+KEQIAx2qbU9hi/C/2n8oRWriMYTHUonsMGcQMkyHysNyknDx2s9T
         5lWic4a5jKUeSMQJQCpPROVrJ3B9jUBQBbNVqcYu+xZfODGq5TsLNsIzTmiXv+D572pw
         hAFG1WxxlOd9Y/oRtrmZEcIksv1WjP6I3Cfurv4kLJ+EP6bTy+EwXK+d3ar1QRexJfJo
         uwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujhhsscyGO6rrWaPkovyIrvaV77/P8c+K2Wk84pgg20=;
        fh=hYh6QmPIDVf4QRtL6DIKaJPBX5Sa3pXrgnkf+O2XivQ=;
        b=fLH/MwUqM3+zLek4Wu4x38xzPwuA1mlNXAw0auDCV+RVtQhSTBNRbz7/bhO+vNvALS
         M+k6eudAz2AOSFPUGlrtqNRNBV6mKt2x9rmIuRRvXh9nZkR6qh/RnuVxkXDrkb0TFDXw
         eVWjcDZQQYnT2Nf3n+3zP48tP8g159d24v+KOnhH2113efXB3R2YOU2JFyp8tlQm2dYG
         2dChHG7QFxDUbr4L6dkxZaq0Kr6bQXkeYJ0iuRqcbUEGGE4uRFyoG7ati+tjMyUqUKjQ
         6hn/SPCXtY9RMYwHCIqzACBfbZVv0WqehjQS9IYORSCjje91WnQq7V8uzmVQJEnPNdUT
         w62g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524804; x=1782129604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujhhsscyGO6rrWaPkovyIrvaV77/P8c+K2Wk84pgg20=;
        b=QYpvHcsqhw1KK4PQpVM5S6PZV2WVH8m3T4sihgd78+DzxumI93l59wQ0M9t3ikzH6x
         CmjZDSCdd/v0JOKLyBFu6wv9grDoZNIf8eoDorZwWNN/Ix5lo6m1nUXtH7eeTld714YR
         6rhA40GtH7w/GJ4XDZbUmp8O4exn91InW7J0hFaJLfTyq8yY3OaB7Dv0+ACTac1DCE4q
         Teoj6K+Ak64MiCPmMsKIcbBPZ2R3Tc3x8wkVlnsHMQVxh2i/wxplJTn7cYYPROyWG72X
         mo1QpWntZE8ZYbaLUYI7SqiDWusafTFtI4bvT+Imqg2vCKJTULyH2CU+JZ5Dvkg6rC2K
         43ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524804; x=1782129604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujhhsscyGO6rrWaPkovyIrvaV77/P8c+K2Wk84pgg20=;
        b=SfCi974rovVhJwYeimxqBms6jSv1JPTLC9PJJwKvkTOyywah581wPhnWaxPA5LF/ZL
         vgwOuDSlS0IzpgtP/p2MfNWGTpP4olINP61jhbo8h/UUmXpwCZU0zAJiUnKEP2Iy32sw
         gL8qCnNQybX4gjhimw06K7q/WNeLwfYLhclXNiMc7X3sr3Nm2BLi3higvwx9RUWbWRTC
         hKNhgUTpMN7nb8jFEa01Dr+c7I1CcBtVGS10ULDIYjf33tUwWbRpfnqEL4u2UoYFDVB4
         HKLdcrxmsxgLiTthuRPWZhGdOO63HtPSvMnY+jaiP9Lehp5s5/2rBOxHKwKCfzmHWt2S
         tsvA==
X-Forwarded-Encrypted: i=1; AFNElJ/gNyRyVO/3wkO6iQXo0vUJcb2ALlqxCR6TWdBGUYk+aY4sBEHDaqxv1XjE8aqotsiYOoFJYjnuOxOA/2E2@vger.kernel.org
X-Gm-Message-State: AOJu0YzS04b24NbPXqje/lUrVVg7fuqSAYAX7LjXswd+OBngOuE1sVRf
	1cHXYZ3b20DtPH1lTpK9+xappGeA3ON/f0HbdmLdsE4l5eke5S1Je1SXt6Yh/11uJU7iOSk+7kZ
	7Ch1Br2tIN16JJFG9z8KfSY5GW8cqRV4=
X-Gm-Gg: Acq92OEq11qzdT50IXAdaO45e739GvG8LpWmqrzE14LpiBTmw+QKwXOqz682vghfWCW
	+JT2rZzpL10WYMfx4V/YORGUKfb8SKcY4zGvhxu5nQ1UPdV7j8/MlM24c2GYCKxfpWnw0N24Ohw
	ieWNVtLIegsIGYWjv/tFqRrCgzyWTxFNl5S1FHZyqz1HSofrmIyOxJjDRyxZHpVUtUY782Ndcxh
	7y40Nu9kDbvOM2ZypLSQvA9mJWP998ni6jIalyxhiRWKuuPJXXzqImPYGYjv/uK4HPsG5iMUFhO
	iQ7Ly4BbfYKIBD9uDyOIUrMAzTXYw4KEapj5ldkOO8DnbseTgSc=
X-Received: by 2002:a05:690c:4b89:b0:7d1:cd93:c8e9 with SMTP id
 00721157ae682-7f7bb3fd1aemr133739857b3.13.1781524804111; Mon, 15 Jun 2026
 05:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-7-laoar.shao@gmail.com>
 <aivJmcLWkpdWGkzO@pathway.suse.cz>
In-Reply-To: <aivJmcLWkpdWGkzO@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 15 Jun 2026 19:59:27 +0800
X-Gm-Features: AVVi8CfNIcKRRC7oI-AJWnNSCpkhAWi2do_EIHItBRbQuLIBBOuXA3wu3j-oOnk
Message-ID: <CALOAHbCDuSqHj-iabAkSB+8U9LW4x42aBeYRmp+6mLtoS84OCQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] selftests/livepatch: Add test for state ID
 conflict across replace_sets
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:55=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Hi,
>
> I am sorry I am getting busy with some other tasks so I won't review
> the new selftests carefully. They might change in v4 anyway.
> Just one note, see below.
>
> On Sun 2026-06-07 21:16:58, Yafang Shao wrote:
> > Livepatches with different replace_sets must not share the same state
> > ID. If a second livepatch attempts to reuse a state ID already
> > registered by a livepatch with a different replace_set, the loading
> > will fail.
> >
> > Add a test case to verify this behavior. The test result is as follows:
> >
> > $ ./test-state.sh
> > TEST: system state modification ... ok
> > TEST: taking over system state modification ... ok
> > TEST: compatible cumulative livepatches ... ok
> > TEST: incompatible cumulative livepatches ... ok
> > TEST: livepatches state compatibility  ... ok    <<<< This case
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../testing/selftests/livepatch/test-state.sh |  34 ++++
> >  .../selftests/livepatch/test_modules/Makefile |   1 +
> >  .../livepatch/test_modules/test_klp_state.c   |   2 +-
> >  .../livepatch/test_modules/test_klp_state2.c  |   2 +-
> >  .../livepatch/test_modules/test_klp_state4.c  | 163 ++++++++++++++++++
> >  5 files changed, 200 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/livepatch/test_modules/test=
_klp_state4.c
> >
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state4.c
> > @@ -0,0 +1,163 @@
>           ^^^^^^^^^
>
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This test is identical to test_klp_state4.c, except that replace_se=
t is
> > + * set to 4 instead of 0.
> > + */
>
> This seems to be copy&paste of another test module. I suggest to solve
> this by defining a variable in using #include, for example,
> look for tools/testing/selftests/livepatch/test_modules/test_klp_speaker2=
.c
> at
> https://lore.kernel.org/all/20250115082431.5550-10-pmladek@suse.com/

I will update it.
Thanks for your suggestion.

--=20
Regards
Yafang
