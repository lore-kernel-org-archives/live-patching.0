Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE03C062C
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031862; cv=pass; b=jGFVyNMarCDZW9ef6f1LFXQZu21gnsD1LmYiFYUke6P97EHU5WMItV2TslJyNeKBvSa91UyJgumnH0zq3ekH2VYC0unIPYU3fnHMr1UWG6MgV4pWOSPz7383frd1gRdX3CnnmfgXUygjP1AbemEius3ZpqgudRA6YCjCZkt+3bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031862; c=relaxed/simple;
	bh=cEFjcFqC5S/zajVcil7vcAgZk+als7z7HLLOjKMSO98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5seeLTmfjEM3h7/9FzyB+b65F/wbSLyG3kcLGMpfCw3oQTNny7PkqZ9HLYvVPj/4oL3yvav14LxRmEw5jVuFKHn5UZy/SgsQgU8o9IpJ7m+7I9bLke8JD6quueG6Dn07KUZVJBH0Dl8LfRpPeI2z0VP/DgiDJqylpKFQV6lLHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJdV6sXO; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJdV6sXO"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so1060077d50.2
        for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 02:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789031858; cv=none;
        d=google.com; s=arc-20260327;
        b=E01X29MWzFZkkR0NahegUI5kAKL4ZD8JB1ydDv6uVU3x4H3MVurUfvOKTvTJNjatLV
         1oy4ESROPHKpAozrfLfbvhmj3ccbHV6U0mzgVdzboFxZghAgLQxudfkmFZPnKbV0JA+/
         16vvORB+gLu26dfLcS7adDb3eNRNW9ln6lJhcKFJiGq4khkcOGVOcpEVbWPtTJrVY2VL
         t1izkcfgnvZS2RScvqElrj8OChQsDtRfR1NVbNkF0xsG71PEo9KsSUJ/9O7lx0nmnWLX
         kM8HixuI/POpbMbC5UFdiARFWMJAl2TOIURd4K2naS1HwZQbYifI5Y/I/U/oj3IaxCau
         eVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wY9Ygr9KkRTr3el2WAm7THBV29038CRKSF8V0YKSqc=;
        fh=1O6itot3EX3+0ibWSTptH37HvPmekLBQ18g3uJZ2o8M=;
        b=eIYYbZZWCjDyYeJ/fMkbJ/4lfrm3aTm62yZJS5mloSB439rKuMB+bF4aXvYhuZUWez
         lboYIfA1/j4/P3jYNJI04USk+PT1nbZFqAIUYqxNZTvvdqsw3Ie1IBoxb0vYxXBUxdES
         6kRVK1h9YzOZgbH7S78x3/S3FStRcWO046jY6SnKhW1dr5FnOq7ogyQHFE50yN2lAiP5
         9/h8J4/qex7DRaEItJyx3GSoNH5V1xHovYezYwvh6Ld055p7oLYtv9irplIgCnDONDHt
         ZQZNBK0Jv03gSwFsVfYhIjcmyNkN4jT4Jfi25B4crML9xkzIs2OOzkzKLpPYsNr6uMud
         Imvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789031858; x=1789636658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wY9Ygr9KkRTr3el2WAm7THBV29038CRKSF8V0YKSqc=;
        b=EJdV6sXO8aDTtsno6QbjZIBzaAzTtZvhDMVGd933/bl1vtrBG9toUYE+W6AeOM/y7B
         LLttKrk9HzEi8OimNjmHsDnGB/bzMZe/Ey1ExvFjsPxBwyuRimM61J1MhBUijRWbe1o2
         iyNxrrykBuFTFNqUdCtMdtnI6NnPnFOOrQ498Q418W7qzitcGnvBJyGxUttVCDIKLHwq
         0S3boCbny94XsotlXVvQqTxnT+LJ23Q0PV5Rh/i3MxjQq4lyXVu7bobbJTrULG67thce
         TqeFIJtWbVBXV/FMGXA4/2KJTXghhy/ZauOgLp48FsFpKiZ2FlSzMuHbv/PQFF+lqWls
         A72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789031858; x=1789636658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wY9Ygr9KkRTr3el2WAm7THBV29038CRKSF8V0YKSqc=;
        b=E3zGkTsxHuY1U4762/WeJnGnDfLnvJ2F/J9naPBy2jm1PFIijJUcNmBUtsakfSjVrH
         NfErg596c98D8RwXjcQg0qcd8PdfMpYjTl9boDqiNlXtl5YqwICLkWWNnw4HzEvqN2jz
         WhD4F6+U4QIgE9sGCxrPHgV/HeNF+TFBketPl/Kex6hPf7jgYnuUra4SPmEK4vxH9XZv
         lJFO0SHp34gAvMiMbJafB9URwFWeE9cdjD+8UklxHm+a/fUKWyKbuYglumJThKqxgf3Y
         RoDa1a6FrUtfpR8anhXpcmOizsUQ9itzFvpL5xkNX+xd9N97GFV+FqcH4CTnw3arynAb
         3MXA==
X-Forwarded-Encrypted: i=1; AKwUvBwVif4VNM4o7k4qWZXv8ELRbe4XZMLNElBuwnZw3HMymq/MdbHmiql75zyJmO7q2CVL4IoHzBSTcN/d2Xap@vger.kernel.org
X-Gm-Message-State: AFuF++lRHbzHmJeJ+GTpefqA392OleSBRDWXFeIHte6CNPauCV1PVmTl
	yN5dY9e1Q9rBEfmGt+s6Axyytl0GNs0rG2R22z6Ol73JrYXmOhpdKAdoUG9X/+zFqJEyedUwIjF
	7rD0WHnP8kdVwJqCJmuvwxXoQADwRwtg=
X-Gm-Gg: AYBFou3jGxnlh3aYSEBLKi+rWScFcjclAXdwcbmHkoIdYFaWtn2w4/0isVmTaaspHZ2
	AgzSmYQ4kzkB1zAUyCkmSCJdLlzIVz9dkA+2liRUIcnqBvSkMKgpmSDaTGSDuVevBNkiYIUaOEo
	L0a1mctQmSp7L7Amyu7xn+m3diqfn4ROv47wPOBLBHJEP5odoBebOol2A+m2XF8QvP3WRB0Euvc
	NbLJ52Nn7vMTkJBYUYWEaD5W7zkqUJWD1hj9Vyr3y7Atg1Cco69aKYcv+s4STObFLuuNRyg4+n4
	uPQAe0iuvCFOcedVjYFgsmZIO3r81oR5BD1TDemq9HoUzGyOJTRaeM15BlBe9i5uG2y95tLLVQk
	ET9UOSXhOJRtY
X-Received: by 2002:a05:690e:438b:b0:66f:b528:cc51 with SMTP id
 956f58d0204a3-6710ff9f016mr1776703d50.21.1789031857967; Thu, 10 Sep 2026
 02:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <apk9f_LsGRYHzN0Z@pathway.suse.cz> <alpine.LSU.2.21.2609091424420.10918@pobox.suse.cz>
 <CAPhsuW6OVt8oYr3YW9MbapXi6Z97CF-7J0fHXakKYkvvOp6A_Q@mail.gmail.com> <alpine.LSU.2.21.2609101029080.608@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2609101029080.608@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 10 Sep 2026 17:17:01 +0800
X-Gm-Features: AcwNN1Xv5nNfFXHdk3PU4FQ7hpmdhmuV0scoYuXPnVRGUuD6zmll0gzsLOxx7_I
Message-ID: <CALOAHbD79KF4s7M672rBUe3rwAHPkQUE5_SZLa_8O0gN9nEkkg@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Miroslav Benes <mbenes@suse.cz>
Cc: Song Liu <song@kernel.org>, Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, 
	jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:31=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> On Wed, 9 Sep 2026, Song Liu wrote:
>
> > On Wed, Sep 9, 2026 at 5:32=E2=80=AFAM Miroslav Benes <mbenes@suse.cz> =
wrote:
> > [...]
> > > >
> > > > It might be useful for OS providers who want to make sure that thei=
r
> > > > kernel critical fixes can be installed on the user system. Otherwis=
e,
> > > > customers might complain that some update failed, ...
> > > >
> > > > Of course, it has a drawback that any livepatch with ``prov ides=3D=
 0``
> > > > would wipe any 3rd party livepatches, even when they are against 3r=
d
> > > > party modules.
> > >
> > > My intention was not to regress and disallow a use case which is curr=
ently
> > > supported. That is to replace everything applied no matter what.
> >
> > I am curious about this use case. Do we really have users who:
> >   - Load patch A, with replace=3Dfalse;
> >   - Load patch B, with replace=3Dfalse;
> >   - Load patch C, with replace=3Dtrue, replacing both A and B?
> >
> > I think this is not good practice anyway. Instead, users would either u=
se
> > a bunch of patches with replace=3Dfalse; or only load one patch at a ti=
me,
> > and keep replace=3Dtrue for all of them.
> >
> > Did I miss any reasonable users or use cases here?
>
> I am not aware of anyone specific but the scenario above does not look to=
o
> crazy to me. And the experience taught me that if something is possible,
> there is definitely someone out there doing it. However, as I said, I
> think the current implementation of the scoped replace should be enough
> for everybody.

Right. With the current implementation, a user can still replace all
existing livepatches, for example by listing all of their provides IDs
in the new livepatch's obsoletes. So the legacy "replace everything"
behavior can be emulated without any kernel changes.
I will keep it as is.

> If not, we will learn about the use case in a couple of
> years.

Agreed, let's see the feedback from the end users of this new mechanism.

--=20
Regards
Yafang
