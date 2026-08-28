Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1632C942
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895812; cv=pass; b=QsUy36uiAS1ez+mVHrMmmGYB+oi/UyeewBeodSDwKHze8IVd2ZUakudmR3h3bW9eWandIwMDO66NliFRljVik8ckQRGEI7Fh721NxwPQ00DQnUAdWlsTfc/xQDeqj/4esiUJG1/kaYD1EKigRMcnZCZPdQXyOcHcsM/RShNE3QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895812; c=relaxed/simple;
	bh=qEqxc/gIEwDwTcM1VIfJcPz8UBeNTrSORI5MoiHlBjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOpC8jOxmsG5yW5a0pW+2vgwPvbrF24jOdNCs7ZbHpK4fe2MoBq79lBAzODfYUynWqfoFEoqDHdK6wpcXhHTEV/xh1nCi4fDDVTmO+9UblSm+KsnvbZZx2wTGQUIAlbR9pDAFFjb1njYo9XZuqpWC6S00VSZPbHYmK8QtNcPMng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycs6ZH3w; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycs6ZH3w"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66ce5312ca6so526552d50.0
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 22:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895810; cv=none;
        d=google.com; s=arc-20260327;
        b=DKQOHF1eVH1Ov6DnUBuncG7yRPk502WMAKSWARA38LqT/nip+YDM8D6liQUK1Y2fPJ
         gqbD+SScIuopsi/9ZWHt1SmccWtM2P4QoVxAqltGe6G4RbeNlQ9VXXgYS7CcKFJBQ5I2
         YXO0UAmgSPjo9BMiq1wwaiRsWUQH7roMJWQQ8Cy5VcfHzbY5PtLfdEnz5Y+vnUO1jaLI
         kUH+RmyWjLr28jz2+gyehmfkueOsUSbNL64TBDflbQ8P3o6QfXS0Hun1UJbufk6cHazj
         +lBwAy/AX9eTnNAaPisLgUBe4KSXuoCzfFC++XLUm0OWWx36gbvL1RMURYBLHB1aRYkp
         9FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ysmOXvkZgKvcDqfFjsdKF5kztg4joXXGkZ/HG5pN0k=;
        fh=/VtVBi/UAnNE9boeih/ebq0xgD67eHqmJ5VGDzMVfhc=;
        b=lFXLATzcoQVW1zy9z6TEA2xyG/Fsk9qGcYx0FuA4FOOUhL2QvmrSAZK4n4ZA73NgzG
         3ga7ycPXda1Wm/epJCheS3ElkD1hhVIuCxJu+X0WRPnjofu89lAH70bVmEP5Eh5/vUBT
         ZA0zIkKvsWZ0CkxHhK3LAEQs9KyjFBBnFBNOt3sY5rKrndg4As0zrop0EN1wi6k28RUu
         5iyXDgbCBaqMB0MZAZMpT92VPWHH8xYrTm85Ee1tX+1ZHy9n9X3qKXniJCePStxCI++E
         gSfGgPvnNPbgtLjZi7Kcu0an1eddF6jZFNN7azs1hHAnRToYHUmWHiJNNxT66zFHiLsK
         AdOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787895810; x=1788500610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ysmOXvkZgKvcDqfFjsdKF5kztg4joXXGkZ/HG5pN0k=;
        b=Ycs6ZH3wcTNZRbGXa6co45aSfR1Rn0JAB8KrrMHlKADkXEqZbbzBPLOGpnpAvDn1e1
         icaGpJND1oQ7C2hwbbERe1DO65zOJt7BOJoV8HJlPCHdD2q6LWKbzP4mwg8rycIROjFV
         jAOxXnJYkuQWSR+Mld7NZ5FcBPp78xA+3o9rsUn6NNFCtRufpOPEJapg7g4XleRNawb/
         MUlwKuOFunmbOA17JelNVwUB1hp+Gte+kVyb+5avbhdpvMDiLZDWXIoB5RsYvK7cZBKT
         sQaOdDoSsguC/UJnYzPGtiX+PJDIgQBGybdj4bcoIuQn+x39uABh4lxmcfyh+oxWRe9u
         0+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895810; x=1788500610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ysmOXvkZgKvcDqfFjsdKF5kztg4joXXGkZ/HG5pN0k=;
        b=gA/MEiXzPbaHMJk5ZuApGHdwNx07dcyv+OLvQkUErRNPWwEKt6XlGJl40H9nG2tk2r
         5v3NeRko91GUS7LLEASGOlxkKVTsXVplF46ww5RJiuo77Uqvs3S5HLvPxH73CVvqh7oi
         R22Jskxk4YnRCrL+rarsDgcjsscKTkt66N+dN91tZEPO2W0oKS1KFWDrY1lmXPAGr15C
         ZTq1VXsbG/Kjj+tE4KXlOlDwtOzSQmUI0J0Wnk3e8nGoSexvKlr6nTbP0ag3P5Ltc45I
         UE+rWkxnav4W3N6+kY/F8p3HHZr8zlf9oGFin3BQl2RsiHW779t87cXQbWfU09wFF40H
         hbnA==
X-Forwarded-Encrypted: i=1; AHgh+Rqt7tAMpyvuJ8hK+zZygSfGVK/CJfT/Qj7Bf8/l3m5RyL+wAUzaWSvUyqJsle0Fh77i7h7MuE6eQs9kPCcK@vger.kernel.org
X-Gm-Message-State: AFuF++mg+iLMDV3qgLbFxtSsI45qkA/QTrHMKb9jOUEXBtJcGRTOXeHB
	DW485xksXUEpqMJtIqWdPecUKp6A4uDoYHMtmsrLH8s1tcCJ3L6dNluf24otjzUba6xLSf+z7to
	H1u7c83hzG9qMpyXdAfm6AoiRu5i6C3o+HA==
X-Gm-Gg: AR+sD13kIGavgDEoVXIJ4fs4XuFOgjLaVsD3aGcSu7Je/wWBzRCrNdDhk7EbLIwI/aJ
	Wsdnn4rJMjyp7iyRwz4tueZUdlBWdHMnzcOZ3xX0o0jJPqmUk8alEW117Xa99KxNOs336W/QZIj
	foSPIS0eEeDG6FlzSLg2mHG+v214uVAYkm5XInoo3Sltic9UtSIhhvi+rjAnOwmozJenGNjTDCw
	qNZAIInNEA+kM0Kavi32J17kbY71UQvv7C8/X5GcXrU//huEKzRPXF+94auJlQHwhG5x0IdVZ/h
	3zMWadsCOWDg10axXFvTvE3aop78lhwsmgK9tuD4YPXh3mpDAMi6nl9qj8WPu4rk35O9XC+oQof
	/fAqRTdqU6Acl
X-Received: by 2002:a05:690e:1a9a:b0:66e:3f30:4515 with SMTP id
 956f58d0204a3-66e4c793f86mr1138513d50.44.1787895810406; Thu, 27 Aug 2026
 22:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apDO-a2n9UlrO_FA@jpoimboe> <CALOAHbAoJf-brcQW-QtXZzR+8xi2ZCAJNwyHBQguXJCr+5+5xg@mail.gmail.com>
 <apD937ehtQ3CUPBY@jpoimboe>
In-Reply-To: <apD937ehtQ3CUPBY@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Aug 2026 13:42:53 +0800
X-Gm-Features: AcwNN1WA7Cvy_oQqMWWNnAjmtGr8bY4KuZ8zPgJqKeW8XfS6M2ZYZKes1GkK20I
Message-ID: <CALOAHbCrD9UzQZP3wNmYz5NWzsn1=cRcEWceBZSjoYfCm6E9SQ@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 3/8] livepatch: Implement replace set for
 scoped atomic replace
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 11:39=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Fri, Aug 28, 2026 at 11:03:02AM +0800, Yafang Shao wrote:
> > On Fri, Aug 28, 2026 at 8:26=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > > > +     # Remove duplicates from obsoletes (if specified)
> > > > +     # Note: provides ID is not added here; the kernel will replac=
e
> > > > +     # livepatch with the same provides ID.
> > > > +     if [[ -n "$OBSOLETES" ]]; then
> > > > +             local obsoletes_clean=3D"${OBSOLETES//[ ]/}"
> > > > +             local IFS=3D','
> > > > +             local -a obs_array=3D()
> > > > +             local obs_id
> > > > +             local already_exists
> > > > +
> > > > +             for obs_id in $obsoletes_clean; do
> > > > +                     if [[ -n "$obs_id" ]]; then
> > > > +                             already_exists=3D0
> > > > +                             for existing in "${obs_array[@]}"; do
> > > > +                                     if [[ "$existing" -eq "$obs_i=
d" ]]; then
> > > > +                                             already_exists=3D1
> > > > +                                             break
> > > > +                                     fi
> > > > +                             done
> > > > +
> > > > +                             if [[ "$already_exists" -eq 0 ]]; the=
n
> > > > +                                     obs_array+=3D("$obs_id")
> > > > +                             fi
> > > > +                     fi
> > > > +             done
> > > > +
> > > > +             local IFS=3D','
> > > > +             OBSOLETES=3D"${obs_array[*]}"
> > > > +             unset IFS
> > > > +     fi
> > > > +
> > >
> > > What's the point of this?   Do we expect duplicates,
> >
> > Duplicated ids are indeed a user input error (e.g. -r "1,1,2,3") and
> > should not be expected.
> >
> > > and if so, wouldn't
> > > it be the kernel's job to handle that?
> >
> > On the kernel side the duplicates are safe:
> > klp_patch_replaces() iterates over the obsoletes array and compares
> > each entry against the other patches' provides, so a duplicated id is
> > simply idempotent - the only side effect is duplicated ids shown in
> > the /sys/kernel/livepatch/<patch>/obsoletes attribute.
> >
> > Silently deduplicating in klp-build was masking the input mistake.
> > Agreed on the fail-fast approach: klp-build will now error out with a
> > clear message when duplicate obsoletes ids are detected.  The list
> > passed to the kernel is then guaranteed clean, and the sysfs side
> > effect cannot happen.
>
> There are other ways of building livepatches beyond klp-build, and this
> wouldn't prevent those other patch generation methods from making the
> same mistake.
>
> But since it doesn't actually break anything, and the user is not likely
> to be setting multiple obsoletes, much less introducing duplicates, I
> would say just remove the check altogether.  It's not really a bug and I
> doubt that somebody who is careless enough to have duplicate obsoletes
> would notice or care that sysfs also has duplicates... and if they do
> care, they should fix their patch :-)
>
> For similar reasons I think some of the other error checking isn't
> really needed (invalid comma usage, negative number check) as those will
> either fail the build or will give the user what they asked for, not
> dissimilar from providing a buggy patch.
>
> Then I think the majority of those klp-build changes aren't needed, and
> it can be a simple passthrough of the user cmdline:
>
>   cflags+=3D("-DKLP_OBSOLETES=3D$OBSOLETES")

Thanks for your suggestion.
I will update it.

--=20
Regards
Yafang
