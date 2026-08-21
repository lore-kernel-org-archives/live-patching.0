Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727B367F21
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282129; cv=pass; b=fwk+xT0mtg4q3axRGQnT8JQ0SQk4pIgB2Pf88hPfzLvjmMZVXJ1RyH8UIUvYZ0A3MCBdy6YwdHJk87dnsdxmxBdAhQXwGQBbBli4dnPCvJleY3whb/zonom+QIJpIXiAZUeufUnrvegPcG0LGbsB0aj7LT3L3Nux+wpA9EjYlXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282129; c=relaxed/simple;
	bh=/FPTVIppAfTPDE0h/OjnQk2c1BLBYv9APnV+Sj6s+d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l07JITDc7pT5mYsfgyB8ObUGWZRiHiQYZa7b/BhQy+Um9nfSixEpaVyQdxeAUl88ZiqNwnVB5JXxzVqHXaGdXDKVNGrR/6Z6hJ5K/l/SwLKsT/Z+9iBgSxKIDg62rkyhKWmwTqns8P9kJdLX4BSYz72pbV5ID9UalbQkKfNkB/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADxi2J9B; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADxi2J9B"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81f36179d72so9937477b3.2
        for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 20:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787282125; cv=none;
        d=google.com; s=arc-20260327;
        b=fiu9wCZ/F2h3TG26Hde6Hin8z+e6TnrdDSPInjdw5BzC8CUIpAOGefLIiV2bMF8xW5
         WTVtb/xwBVD6lR1CA+Bm1di/hxWUwhNI0elmmC+y4MgytPeBgNT0splD8Mj+FukwH5Nm
         jW1QLQTe5fvKeDJzlQm+uCnYcepH2XP5pmX1GShk88k6FdTscSsjQHWBAPsFyfBa40K3
         +ZVK8gQP0ZhSgs3EX4taBfWjxUm/mjF8dYPkXxUwC/+sTnmoOV4dnE6A/qFM3e5FlfBn
         0Soatn8dGYfaRCjz5WgG7XgQrp5qcEhe5kjWoY2+2U2c2cPM12nmnPpteck75blafB7y
         69tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Wqkj50xDCLBlQS2sVxD5JqRiNcQiD/QAzj9cqbP0K4=;
        fh=HZSCo8fGGb5vJV9IWB0PmlK+WQqrA8/7ZGzwKHYrtVI=;
        b=qv6N0lTr7TZzHBFq+FLTotroYGMkLPWL/vGUjo0ye77uqAHIFo8mL13gAEVzReY5/w
         O/rBU3ZLXCcR19kiaLqSEIB2Pv2TXgv6o74EwIB3RGo6fB+WVlUa0pqJU+gQhl1eFuvd
         9fd7noJotOkEzC8k9XtIawNviNFR4vn21HFl0v3iCZhlBwkk45zCQovhe4YrHw3Cn8bv
         Z9AKJjInYy6Qf85Valrgqn0sfYhq0iG8bsQYFoeCrhO1O3Bl/lVF5KT/XgQw7RPMwaNt
         T5He9TG76kiGNhIrwKm9h9NEaG2fbJ53Va/cv/ohCns9aq7Y6SYR2WQDSzIzQVi6wXIw
         /cyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282125; x=1787886925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Wqkj50xDCLBlQS2sVxD5JqRiNcQiD/QAzj9cqbP0K4=;
        b=ADxi2J9BUQU2QhFI0hYkV8lEt/PSNj07c+wpNBaEp0om7W96mbQ55YuZG5jq0ohHoO
         IHJVsdMCBmNTk49o8sMojm8cAA4+Napy4Tp/6QU4o78J8kai3CWLD9xzcu0KbjM8RVlb
         VjuQ9cZWeNsebFbagJZPZOK1svPZ16utcVffgVZR91xXvnO8MDoqVEknJcludHxER1W7
         mCOHeP4U3QTurUN01LIIxUG9UD4PowLcGCfOvsKlj5D//I/3dM3Ak9yTLbug0h03lto4
         riQusZ4s+pK7m0XPgLnVqZaqvEKDRl4GyWuI1lP/Oo2z7KDAury9HoEoTdoTMLUTK8tJ
         dhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282125; x=1787886925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Wqkj50xDCLBlQS2sVxD5JqRiNcQiD/QAzj9cqbP0K4=;
        b=i95zislERuHIgx+AcAifK+piK7NPy6Q6K5Dnp2XU4ebqg/GKpAWsPgxfBUuWnWWeTD
         MxT2S0oPyLOlvdnS0BWPp9i3c6yaBRQSyfB5kh18Gr4AlCzpMdpwZEzeAcVlJd1qUZJK
         j20OE1SNdcSxsPoVcDSebVeQsCWWWWAxVQK0KEaSBwVIjtD2n4ger9xlEGFya3h7aaiE
         AheEwhDmazK93ig7jmsGApQaznzMROAKr3jOx+MBGYjkAgJL4UCa43wWk9HqFmKppljr
         A640Eud8mSS9uJgdPAJvDpTW+wopPtji5QtazM1yBK/d6EHR9dEFF84I87y0fuHTFRd3
         Ic3g==
X-Forwarded-Encrypted: i=1; AHgh+RqdKQhn+JI+3RgwSCvefle5zKR6rgaqHHMNHFjX0eiBdnNXa1lpMoZAenJdTfWMk6ctkn2VTDzFfD6beUtA@vger.kernel.org
X-Gm-Message-State: AFuF++m/yaF6clymGrWnDWXiIRwusYWO1KSG+THZU/ERoQCkFtW66RnU
	24hKzIX5K4FVQn2+SAqnEsZ3cZgJA9vZKJqknGT0RZQdAwODgK5NzL9tKqi4PJxi4iEI9TzvsHz
	JoJpr1yKF7z+4YCiF9r7Rf+08sdztROECxpRW
X-Gm-Gg: AR+sD10lUNpKya0jR6OxPFKFLcYRh3lQmtQ5pCE+glyH2sJBaH2YfZ4X77ruFu8vq6q
	/NfG44OmJ394DDBrfHx0Q08x+sKC/uUVsSUUd00DOXUdnvxxmcs48wIoUHWu80zINHCwbttJOao
	X4g9P089OHFQL5asRdPlsxaGAD1XEeYNdxZrUylu+7d5O0okz8UQZ3rn/nB1cA+3DV2HLgCe8tu
	9QRJVOus4gMH35WAN5vSbRWwhgs3oFxBhofOy7mIciJxFFwmpiCCeJdF3EuVRzyRGqM2sXVjvY8
	lMl2pCERtimPjAKdrXy3MP7pQ3y/k/gDIknxJfh6q0rOOkQ4hbNe/HDFQicgGmc6y5lK2sNeXsZ
	M/Q==
X-Received: by 2002:a05:690c:e28a:20b0:81f:64e8:9362 with SMTP id
 00721157ae682-849f2e1bf55mr10993187b3.16.1787282124704; Thu, 20 Aug 2026
 20:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816090442.18128-1-laoar.shao@gmail.com> <aoWEX89bxOpo4873@pathway.suse.cz>
 <aocdq0hr_iQTimG0@jpoimboe>
In-Reply-To: <aocdq0hr_iQTimG0@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 21 Aug 2026 11:14:48 +0800
X-Gm-Features: AcwNN1X-E5iTijJXN2v0ohJ4JaXWkd3Ru830Ba7RT9gywIA2D_fixn2kDasl1vc
Message-ID: <CALOAHbDRckHX+Ha4=jOZKWkvQAyWdxDL2qAeD6-KDkJZMM2Jtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ivepatch: Fix several bugs found during replace
 set implementation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:40=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 12:24:31PM +0200, Petr Mladek wrote:
> > On Sun 2026-08-16 17:04:40, Yafang Shao wrote:
> > > These fixes were found while implementing the replace set series [0].
> > > They are independent of that series and can be applied separately.
> > >
> > > Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-la=
oar.shao@gmail.com [0]
> > >
> > > Changes:
> > > v1->v2:
> > > - minor improvements and acked-by (Song)
> > > - fix issues reported by sashiko
> > >
> > > v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar=
.shao@gmail.com/
> > >
> > > Yafang Shao (2):
> > >   livepatch: Fix wrong index in funcs cleanup error path
> >
> > This patch is against scripts/livepatch/init.c which is part of
> > klp-build framework. The klp-build-related changes usually
> > go via the "tip" tree by Josh.
> >
> > >   livepatch: Fix UAF of unregistered patch kobjects
> >
> > This patch is against the kernel/livepatch/* code. These changes
> > usually go via the "livepatching" tree by me.
> >
> > Honestly, I am not sure how to handle this situation.
> > Josh?
>
> The scripts/livepatch changes have tended to be tied to objtool, which
> is why they have gone through the tip tree.
>
> I'm open to suggestions or ideas.  We could possibly rename or move that
> scripts/livepatch directory (scripts/klp-build/?  tools/objtool/klp-build=
/?)
> if that makes the boundary less confusing.
>
> Or might there be some other maintainership model or way of splitting up
> the files?

My replace set series [0] touches both kernel/livepatch and
scripts/livepatch; I'm not sure whether that would cause conflicts.

Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.sh=
ao@gmail.com/
[0]

>
> In any case, I'll go ahead and queue up patch 1 for tip for now.

Thanks. I will send a new version excluding patch 1.

--=20
Regards
Yafang
