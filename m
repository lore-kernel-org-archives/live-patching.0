Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00E2BEC27
	for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662904; cv=pass; b=WJRUQmjikhidWtnChxY6uChsEdEQuCXz+kDXMkGMiiKJB8bLa9rWBi/KOGUHTCeB8TYLkXnaKPe8Nv2oX8yWiz+d2ukZe3iQnIODVmKEkLlNvbT//gCp5P3VXQQobx3RVSHyOXvRHnY5BEvJpijlzJ/tzdlpbdGBFKVwE2P9F3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662904; c=relaxed/simple;
	bh=yZNnouq9PweYsYHaa+x9wfdn3tmrQYzalfFqEhVBQqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTcctFrMbGGVOum/jPnnUIPQ1JnFWGE9bRifwGtg9BE6KQuOd0UjLj+/bB3IdnV47+LENGf5vJrWR+FEh7aw1lUXobnkGBSyymV8EU+W6NBs56plYzbwBgYwk4zdeFDzkDDblVJA7vYzKju9pChIP/ffAf+HQsb6a6MmYxGRwW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn4tOckY; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn4tOckY"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e266714bd3so61416507b3.2
        for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 19:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781662901; cv=none;
        d=google.com; s=arc-20240605;
        b=MnZbhxMRyiY5w2CjCkSKAhku2QsQ2gU6MMFW2upj4InQDZC7qp7ftlLREKFAuBHlde
         4M5JkjLiB2BilJRhwe8CSA2OujU9PIabZ0QxxSr68huhQ4AQnIW3q3FlAYZ9udy3/8nK
         HY1tYqQZR2nBC07cv8NMZt+oLIm4UonRH+iH0357QSJEb2UawwGHxi/I1xBFJ//gPFa2
         BmA2X+8iSXfxA1zZKcP9T4E9LH+6OwazM4tQBb8QKI1LJd1CNkNDYVs9narn3CbFIXBX
         hKQYkv7cVHLrSunVpuZ61TX/akeObLIE/sIZNADA457aGFULz8biIyADwNDalMQkvOZw
         SDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wOCxzw35k5RPZHcUd1ER0XSk/ATuJDA4BuQEaDIG+uE=;
        fh=7wNc9oYZAuPv9jNu4zplewKJJdiwXbhj7NYXGb3wjgo=;
        b=NY8ECpMv1dX3EGFkWfd8hH//4tnTmtjJUDlCP2YX7F6vqBa+7lCtPsmlmzpMhzElK8
         WXIyrudRR4Xa/Igoyp4nZAftcheJOD8PAJamHNctfPX/3gYB7vCq1uKZrnlWimnRMZqj
         4yDqHnda+C8TwuqMmwHH6VXFGZSGx/eFTLPZ30INt6IJqeheHR5wr0or8bKVI7136aBC
         /7nLs8uRL/Lb5fU38vwVl257yBLQVLwit5SB135Yk2KX889uisb6QE99DWjnk8coEUKW
         duZ3tnKBdH+KMS+2SqdttMw5E1FhjEQ+YacaenyxOBvCIVvqhG/2avKhKYUvJVjbOJSC
         bSEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781662901; x=1782267701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOCxzw35k5RPZHcUd1ER0XSk/ATuJDA4BuQEaDIG+uE=;
        b=nn4tOckYFFhz3QQUf3EaYzT2EvgK7bdISErqxSuLntymMA4cPMGfNOSCWD9QgbvUA4
         6bKPxK23fXrNVxa/Px+v0IgrZILql6oomS+Co+Luy09mXW+wN/r6pRYvKOhkfYXuZSF2
         BYvr1IbPgLnrdsvVvib4mKIUQ2BfeVtq0un9kJ0aCYkoMn/uV5FXl2AgnCGerfQn+3+v
         568k8mQO8988mVmX2GY8gYBIA8RGe1DuJb3Yo20Dj49rEJQ85hrg0h6qGbMaYKao9iAE
         6DXW0sXGJDqJCKRcFPwmVhrgwFsJnD+QqvAn+Fbg2enzDsos66GlY3GBTuj3Bz26KlcZ
         K/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781662901; x=1782267701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wOCxzw35k5RPZHcUd1ER0XSk/ATuJDA4BuQEaDIG+uE=;
        b=HsL6v11Z8NSeZWLfcqD2YZfbqozkTrkdrfqjCAV77/3gmN7RQcfF6ayuZ85/auTrFu
         ABNC8g1DiM20DlPzWf+w+SfRldrETAQH8XM+Mvo/QevRE4SJLLVOHpe43o+WK7T//RjI
         6IfKp/J1FAT2ogRdorHYTqCJ4Q+redfFRLRNhqkQUhGb0jQzQomP7Nrwr0mw+8ry906Q
         3y2vz9QwojV84CQXCljgyxaWrzD+L44F5Cpy762X3y5E7yDmkbbluroRPRGQZqaGpaMx
         cTZKY8+y1qyLDQ3dpVN0O0JS/oheVDX99/ovRUN17jhtCnCMLBM5MntuUz+BtMyFV1+A
         WQyg==
X-Forwarded-Encrypted: i=1; AFNElJ/YeySfo5RVJiMOzWKx64beGskoIKIQEoDkaTq2csIQvqcYxd04xD4gyVq9alesBR+laP+TXIM6AeM/e2g7@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmnQCwrQCJymJwuCdSKweSMWIL4nsec9Nns3T8Rpp4WNFhGvU
	TZXbMiqF2QxVrCQIejS9bBh1MDRD5RricsBW6rMas61AUtFCU7+GKnSMuokq+JKRQyqV4bIlRml
	joK6CMjGdNPaSX4i9o0snGO76uDqqG923zLXI
X-Gm-Gg: AfdE7ckc7CpkuV3hewIFpsaXQ8ATuNdINt9pUwbJiP+OAXDPeKA+j8PqMoHTq1QkZr6
	JlhlciXnpxvTWCsyiSPT/PezEuv9suWL2VHuJ/7WrY2ybgjAx9dRKV+lN/GNdQGdwew4cWdpfNL
	3sLA8FAOdc+g9vxeOHdSn2gV9ye5F1+/SAAG1kJAxwbxWCIy8CzuvYZhWSO5sAPIc5FW1Q+HvQL
	Hen/PHvUGlBAhK0xZkUNut+PgAVmOlVmKjZfQ3izWp1J1QqJJxuhx+vx57g310n8xvHpdx7X+0t
	h/vUxVsZLmwE3L6ClUryqq8c151+0y1Vf0w959io
X-Received: by 2002:a05:690c:4806:b0:7f8:7e02:248 with SMTP id
 00721157ae682-7fe5ed8a181mr16043937b3.48.1781662901520; Tue, 16 Jun 2026
 19:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <ajGxOwpnyjBrRQzP@redhat.com>
In-Reply-To: <ajGxOwpnyjBrRQzP@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 17 Jun 2026 10:21:05 +0800
X-Gm-Features: AVVi8Ce5SELbASe-33w9uPEmzmzD7nX5Fecg9Zekq8qWm5uNnUi8mca9pkNKxBE
Message-ID: <CALOAHbAGKpgGFE4CQ+Q+ncEzvsaczE=soYzSR8fY=S_AcMWLEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] livepatch: Introduce replace set support
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:25=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Sun, Jun 07, 2026 at 09:16:52PM +0800, Yafang Shao wrote:
> > We previously proposed a BPF+livepatch method to enable rapid
> > experimentation with new kernel features without interrupting productio=
n
> > workloads:
> >
> >   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.sh=
ao@gmail.com/
> >
> > In the resulting discussion, Song and Petr suggested adding a "replace =
set"
> > to support scenarios where specific livepatches can be selectively repl=
aced
> > or skipped.
> >
> > This patch introduces 'replace_set' to provide finer-grained control ov=
er
> > livepatch management. The core rules and behaviors of a replace_set are
> > defined as follows:
> > - Livepatches sharing the same replace_set can mutually replace each
> >   other.
> > - Only one livepatch within a given replace_set can be active at a time=
.
> > - Livepatches belonging to different replace_sets can coexist on the
> >   system.
> > - Livepatches in different replace_sets are prohibited from modifying t=
he
> >   same function.
> > - Livepatches in different replace_sets cannot use the same state ID.
> >
> > Additionally, this design deprecates the traditional non-atomic-replace
> > model. Previously, setting 'replace' to 0 was the only way to keep
> > certain livepatches persistent on the system, forcing developers to
> > disable atomic replacement entirely. With the introduction of replace_s=
et,
> > developers now have a selective option to keep specific livepatches
> > persistent while maintaining atomic replacement capabilities elsewhere.
> >
> > At present, KLP state, shadow variables, and callbacks are not integrat=
ed
> > with the new replace_set mechanism in this patchset. Support for these
> > features is deferred until Petr's klp-state-transfer infrastructure is
> > completed and merged:
> >
> >   https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12
> >
> > v2->v3:
> > - Address the feedback from Sachiko AI
> >  - Fix the pre-existing NULL pointer dereference issue
> >  - Move klp_find_func into core.h
> >  - Don't deprecate stack_order completely
> >
> > v2: https://lore.kernel.org/live-patching/20260529034542.68766-1-laoar.=
shao@gmail.com/
> >
> > v1->v2:
> > - Incorporate feedback from Petr:
> >   - Initialize replace_set to 0 by default
> >   - Improve documentation
> >   - Enforce that livepatches in different replace_sets cannot use the s=
ame
> >     state->id.
> >   - Enforce that livepatches in different replace_sets cannot modify th=
e
> >     same function.
> >   - Ensure consistent capitalization and naming usage of KLP_REPLACE_SE=
T.
> > - Incorporate feedback from Sachiko AI:
> >   - Skip the klp_transition patch during klp_force_transition().
> >
> > v1 (RFC): https://lore.kernel.org/live-patching/20260513143321.26185-1-=
laoar.shao@gmail.com/
> >
> > Yafang Shao (7):
> >   livepatch: Fix NULL pointer dereference in klp_find_func()
> >   livepatch: Move klp_find_func() into core.h
> >   livepatch: Support scoped atomic replace using replace_set
> >   livepatch: Deprecate stack_order
> >   selftests/livepatch: Update tests for replace_set
> >   selftests/livepatch: Add test for state ID conflict across
> >     replace_sets
> >   selftests/livepatch: Add test for function conflict across
> >     replace_sets
> >
> >  .../ABI/removed/sysfs-kernel-livepatch        |   9 +
> >  .../ABI/testing/sysfs-kernel-livepatch        |  14 +-
> >  .../livepatch/cumulative-patches.rst          |  23 ++-
> >  Documentation/livepatch/livepatch.rst         |  21 ++-
> >  include/linux/livepatch.h                     |   5 +-
> >  kernel/livepatch/core.c                       |  65 ++-----
> >  kernel/livepatch/core.h                       |  21 +++
> >  kernel/livepatch/state.c                      |  51 ++++--
> >  kernel/livepatch/transition.c                 |  11 +-
> >  scripts/livepatch/init.c                      |   6 +-
> >  scripts/livepatch/klp-build                   |  16 +-
> >  .../selftests/livepatch/test-callbacks.sh     |  33 ++--
> >  .../selftests/livepatch/test-livepatch.sh     | 159 +++++++----------
> >  .../testing/selftests/livepatch/test-state.sh |  34 ++++
> >  .../testing/selftests/livepatch/test-sysfs.sh |  91 ++--------
> >  .../selftests/livepatch/test_modules/Makefile |   2 +
> >  .../test_modules/test_klp_atomic_replace.c    |  10 +-
> >  .../test_modules/test_klp_atomic_replace2.c   |  55 ++++++
> >  .../test_modules/test_klp_callbacks_demo.c    |   6 +
> >  .../test_modules/test_klp_callbacks_demo2.c   |  10 +-
> >  .../test_modules/test_klp_livepatch.c         |   6 +
> >  .../livepatch/test_modules/test_klp_state.c   |   4 +-
> >  .../livepatch/test_modules/test_klp_state2.c  |   4 +-
> >  .../livepatch/test_modules/test_klp_state4.c  | 163 ++++++++++++++++++
> >  24 files changed, 507 insertions(+), 312 deletions(-)
> >  create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
> >  create mode 100644 tools/testing/selftests/livepatch/test_modules/test=
_klp_atomic_replace2.c
> >  create mode 100644 tools/testing/selftests/livepatch/test_modules/test=
_klp_state4.c
> >
> > --
> > 2.52.0
> >
>
> Hi Yafang,
>
> Thanks for implementing this.  Supporting both replace and non-replace
> style patches has always been a headache for me when reading through the
> code, or worse, actual end user cases.  A few minor nitpicks:
>
> After applying the series, Documentation/livepatch/system-state.rst
> still references the old non-replace model.  Section 2 states that
> "Non-cumulative livepatches are allowed to touch already modified
> system states," which is no longer true.  The introductions in both
> system-state.rst and cumulative-patches.rst also frame atomic replace
> as opt-in.  Petr's proposed documentation rewrites cover some of
> this, but system-state.rst section 2 needs updating as well.

Thanks for your suggestion. I will rewrite it to adapt to this new replace_=
set.

>
> See also my replies to specific patches/replies, mainly around the
> supercedes feature discussion.

Thanks for your review!

--=20
Regards
Yafang
