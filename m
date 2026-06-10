Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157520299B
	for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060462; cv=pass; b=XnYQ15vmEab6vc2qGS+cmnZBhDvvmxJJXSgvdtBONdQUQO8iHeDuJyXaE3786F81YDnvGIgVqtNYAUahGo/ZiGkJGcjlR3hhrF7EPz9U79eCo1Y049XhQ8r1lXmwntCAMt88sUfgmVNOB+DBcKclpnBCT54bsa/U254wRx3TQFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060462; c=relaxed/simple;
	bh=bgckQTROcwD9V2QqZPSB3/tf0IB0s9RV6Ey9k1Nt78E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSN/nVbKfnm72qpsxVQ92tTj3rpJE4nv4DG9nbc0hm4UZqkkKFaP8kbAqWzRb4WDaQ49W+Q2WSUpNA2VuPNMFbIol7/g0bgCevULMImnZgmtzPwcEGhwTvTjinaXQIF9kwowlQ+DwA0LV64WXE1JyRtMH8RSjizFOxMajAvTAg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsYn57rt; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsYn57rt"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dc93d02916so66167577b3.3
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 20:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781060460; cv=none;
        d=google.com; s=arc-20240605;
        b=Sw8oppbpusAKQh2gt4X0mSoZ5103AcZ8zvMFFShQF5icTIuYd4zDm1pZ/LDJcubDAb
         sqGw7DM8l0x6SrFywk2minLfbGsYG71GDnHTOTQoX6Cx7felT5wDObJCDeM+pUfoepkt
         tcKft9Z/i8fUunq7QI2q2hojRMzbyV9s4G61INa1zVNnQIOwhaxRK93WW4+XLQM3VRNq
         oh78UB44updf0981rNuAp0OdnV0fJLmQ5BKd2wFwafViOygoQ0kVrJNA86Ddlr3tB3EO
         W3hwSDYQYxImU0rGOe75LRJDC3LzkwHG0SQDPqmbLGiS8C90AXlC30A9YAF/jncGSDob
         GMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zSb0jAS+XPfPMrvuXvTwOsCbWo4fk1oWdvgomhn5gpw=;
        fh=GiuAK77Z/omq1+h624Bfy6GlahaMXv/hCL6HtlmZ6sE=;
        b=USh3vleedDCm6wQH2wYYvF9tHyblS9jqDFn2mOv/4ddpeXBDQtwkwa3n5lU83pjafg
         QvgMDB/d4nknqGgleJhqYNJ1txOXXiSvCaUmPTVAB76sfvRIu8BAJdU+inf+2KFjHpdx
         F2IkHoi4TFtiO3V0CGr0dGYZJhIxzxagKPzl5rrh13tLJw26rtrc2CfA6wml2+eKgUNt
         Qnf4SZw6okXy8OY84LrgGzvxFSb0QhQd4vNAnj5wq4jlpciHkxDzSrcSoDSyX8QrM/71
         TgYKWS09WzPgQUGxhYAdCFycbiI7ELUyYVb5VZnOPhafz8u5JD274vh6eYE/jMwAl5Z8
         d2Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781060460; x=1781665260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSb0jAS+XPfPMrvuXvTwOsCbWo4fk1oWdvgomhn5gpw=;
        b=FsYn57rtScWzK7VyemOb5sZiA7TIz7oE3GKCy0d8K6XYcf8ERtaKevl0TtDWBJLGQ9
         0sTSWY128Vrd3ItUx78Y8oQhCXCx1siSy8GSlU6duu5fNmeZbT0Kj6e5/CFIuqPd3u2U
         SQcL4y/BkhlHp9oMgcSGyPTVTW9bC2mcM20n+bDUUMHfKU6mVExDaWos73Y/jVDyPZjF
         0ZTTav61wxAHfES5KV2SNzBbszWaiJDwRT3//cnpB7sTjSTve2W7JQvIuDNCKLxREVDh
         gNyzKO9tSPOrpQBldSPxJx0WrGE++cx11WBYlP9xmFAgLIdT3lP/BbF6tzsQ+ZYPc0ev
         9RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781060460; x=1781665260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSb0jAS+XPfPMrvuXvTwOsCbWo4fk1oWdvgomhn5gpw=;
        b=hAbw94jAVInsMkTRODEfZi5hIWvoA+t28Uaqg3rLmPFUAJGNW9kauqgKC1Gr2Qo56L
         iQ/DglvTc4B2KgQQpDQfUNLA0twCLBHj7RNxeHGc54cJSBxDBihVXo6LGXb1ezj6ARgI
         HNkbS60tHZ3APLB+2kv4bk7Z7Ybj5KxS6IfidhAjXFnmc32FkZ4UryGmuR0UWWVF3LCs
         3EyhbDCNR+PyVnNs0g5gwqhis7ISJdD6HYXHiGrkVy9lllu40jE/N5N/N0KLoJuDpw+E
         Cm7ltZel2is8re8TmpyNwOeaV+z0jYoHUhPxcLNK03N47ujFRt0xGBwNFeG10Npvve1u
         L4AQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yewDqSxeC4Wf0keh+1KgqADEt5lZYh1gKbmpy0RF2xPrtopwSWFFRqCUnAP/xhjn41IfXPS5+z3sKKUn9@vger.kernel.org
X-Gm-Message-State: AOJu0YwUj04zEWjKfYs1FlYB7pVodzUD3Ge5C/PpQe33wtceHxi1jFgI
	TDClhxATnnxR4PFb2cm4QrF9BbxwRHPvCnrASAra2B7H/+A0h7UZ7W+PplGJQSMhlJ2gZDAN1FW
	1yBX7q/73TQaUT6zZir4zl6Z6psAmeIc=
X-Gm-Gg: Acq92OGVgTzoBy4d7MLrX/aG5TxrUl3n8vWwnrryr+8HAFPTSev3Yae4SQni45ZFH1M
	AvhJEkPi9SDly7KNHTMtlLSpEiT641OrfExTkITVMcZtGGo0KGVd3+Cmq5qdWt2ExykAvw/3jCK
	0jxK1T4V50O/1bdieWZ7fc/yE1hzX390h0UWa0RefhuwwCVQhJWbVwKP1kx3/mFS40D2w0IqcM/
	DeBxIWH00Gpz4lTS4nqgvTgyp7Q3R1Ol4p/GdLy5O8AQ6BBewXaV3UlH17VoO5YabWjnqSP6lxk
	9I+sXIvH2mUsFnyaGmzYxzbKB+YA5IrrGGyzUw0eMdihUkzTvdc=
X-Received: by 2002:a05:690c:3682:b0:7dc:e96a:26ed with SMTP id
 00721157ae682-7ed0a2012a2mr236718307b3.9.1781060459689; Tue, 09 Jun 2026
 20:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-2-laoar.shao@gmail.com>
 <aigUttsudeR9ps0p@pathway.suse.cz>
In-Reply-To: <aigUttsudeR9ps0p@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 11:00:23 +0800
X-Gm-Features: AVVi8CdlTnslKLQo2aMXn2qxQEZddo6UlQMMdB8LcLx83sk_CbxMjBvXu9wN-NY
Message-ID: <CALOAHbAmVR4qyQyXAZq+uto+Q4QfVonnh98AUJLRzTgsvZSUpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in klp_find_func()
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 9:27=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Sun 2026-06-07 21:16:53, Yafang Shao wrote:
> > If a newly loaded livepatch provides a function entry with a NULL old_n=
ame,
> > func->old_name will be NULL when evaluated in strcmp():
> >
> > klp_init_patch()
> >     klp_add_nops()
> >         klp_find_func()
> >             strcmp(old_func->old_name, func->old_name)
> >
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -92,7 +92,7 @@ static struct klp_func *klp_find_func(struct klp_obje=
ct *obj,
> >                * Besides identical old_sympos, also consider old_sympos
> >                * of 0 and 1 are identical.
> >                */
> > -             if ((strcmp(old_func->old_name, func->old_name) =3D=3D 0)=
 &&
> > +             if ((func->old_name && strcmp(old_func->old_name, func->o=
ld_name) =3D=3D 0) &&
>
> I do not have a good feeling about this solution because it quietly
> ignores a problem. As a result, klp_add_object_nops() would
> call klp_alloc_func_nop() even though it does not make much sense.
>
> A livepatch where any func->oldname is not defined should get
> rejected. It will actually happen but _later_ in:
>
>   + klp_init_patch()
>     + klp_init_object()
>       + klp_init_func()
>
> I see three better possibilities.
>
> 1. We could move/add the sanity checks into klp_init_patch_early()
>    and return broken livepatches earlier.
>
> 2. We could move/add the sanity check into a new klp_check_patch()
>    which will be called even before klp_init_patch_early().
>
> 3. We could allow klp_find_func() to return ERR_PTR(-EINVAL).
>    klp_add_object_nops() should then return the error as well.
>
> My preference:
>
> I would do the 3rd variant because it is much easier than
> adding/moving all consistency checks between klp_init_*() and
> klp_init_*_early() or klp_check_*() functions.

Thanks for the suggestion. I will update it.

--=20
Regards
Yafang
