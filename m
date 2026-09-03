Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CD38E5E9
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414246; cv=pass; b=k6fBZ5oWMWhwU1zUrrii8SZc/LnpG1Zjqx8JBiHTgoVpJsuEftDYXLmMouG1zEzdziJ82SvXwGWLwiJ9I8S5n0fyPBoXEovQUlVPOEHK424lVo+GBMj4NxgMqX3lWdQCiaUXpXNgz1KFIKhZ5o9N+oZo/PdUChWZBX1MS6zmCPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414246; c=relaxed/simple;
	bh=onqioroSGnwD6GIOMGmLcowu/9ufEUQ8S0hQ2QHmvs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDuhDbhpkuAU9647FEsmcDmysW0KBJY2ww9cU7A9KDAFmQ9bS1OQFJD/wS18oQ7jl+9pK3gbg0kH0XQF9kuRGT5LsVp/aRvzg4t0sbBx/M3+VujvogFHDrv1/VWlMt7BrffIeZvenA+HnPF5W604DoApIw0ouLQe875JxE4qxCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHc79FxX; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHc79FxX"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8200b55dc47so24812097b3.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 22:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788414243; cv=none;
        d=google.com; s=arc-20260327;
        b=aHAZ325uFTAPVh2rs1whlKcwc5rfM4oK3HcVFtbPG7nUcUqWbB86aLahA5pSmjRfjJ
         ladKxl//fdqV7+kE/zui5bNtZD2fzVk2SBioat65++RzxNsWk1UGbep/eoK3b8peoIQV
         d5R++Xa4RvQITYOK9v8LXX4ujfqUc7UVGV+GprbKFTBTgz3bY8MR7+a9s7lcAatoHxxJ
         3kNgtfrJP/Uow0NL+OKO6H4f2y3HA3xyTqgGzOFpzma6Xc2+QgNsEO+w1qF2Swl9RIwt
         QmOerNp8Hytx3wPgHn3a8zTfieSTG6Tt8nBAzyxjAGDNnw7IYZ4ToH4y/6S18OwNZDKa
         xqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNPz/7Sx11qaH7foimqw8S/MRgHEXrzirea8xpKVOOg=;
        fh=uEeaCVGRWjdnDLzKRulrSqgRN8dCxnQJxUNAGb7X8jA=;
        b=dSpe+baCFhJaLo4O2gzU+FKN/je8Uknx3PmsP9NuyAy1w5l5sbgVv19dX39Z/DVJeC
         VKovXj2bTlmbGW8m6aphNIhKRNzXo9zUjLgzfGEQQAO5ylzxp9AmtdK8wh8V1CLR5w0q
         4TpO2bYBjwyeExIcoyZwZNhSNH9YoyPphgP4DPBehEjSNBwr+Cw4XLAEvrO3iq13YLMK
         8kB5IfWMsGdSp7tED9hebe7A6i5iBSMmXi5KiyWyxXRCC4IMNWI18GfULAyKGG8+Khya
         zjYjOxwij1dDolXdwYn6D9746yOt0BZmc608/Uzr6pOtRtnMeVzJnLB0wTRvpV/CVHCQ
         +Zpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788414243; x=1789019043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNPz/7Sx11qaH7foimqw8S/MRgHEXrzirea8xpKVOOg=;
        b=SHc79FxXWo4Zc/M45mJp0OzeD7V2d/5XivQSNLeaQfojA8LSUTb5PeGjBw44hoY3kd
         8HdPx9CrO9GKkmJihfv1DyzyRFw5M9a8C+tSkuYYBZxl1cHZpxE9ox40mqNvY3twrAtk
         Rl80Hj+NnnlI8k/uPbLFbKzbChijDA8SmbyLHTbYarQ0Ge6+QHuI+ca2aCiy6PbsYI59
         +gLqMEj0qfMXR0DF8Dg6ylZ9B3XcD4Iks2vJ7JnYqLcEhKc+lZjwpm7OVSO8YJgRUUMj
         r6f8ttICSqPD5JfMNxuXnyuwAmsh08asff6gLHffEq06rwJ/hsc2zTYdLJkODovETORL
         HBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788414243; x=1789019043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNPz/7Sx11qaH7foimqw8S/MRgHEXrzirea8xpKVOOg=;
        b=WWqvJOguB5U60/85RFT6Y0DLUdYyaMaL+r7d1rktnCahA53js1E9qGFHoAYRrLzhg7
         vXhgltryaDHjcY6tnQobc2EQtUo0h5eIVafKuTNgAQWf8TyBLJujEStBaGsmiSbaNfOK
         8J0wZySf9aUsd6mqHlmXLSURSOJSqfu/k/S2+ZbfDBOksV9hPozEVioKIqjzppKgtZrV
         +/nyMDT++3hQFjCetdXUUS56DeOZaXDMRDD4ufbv+vXrRRfDI0qB2FRsBzwoyFEXEyeA
         /CaujBi1jkk2K+1McA3R+8Rh74TMW94BbLXSzu2F5GmcraXQm+AVoFMj4UIcbiM7IwHe
         DGOA==
X-Forwarded-Encrypted: i=1; AKwUvBzVYeI342qcAdnbM4crfhwBJIrDSDpMqs5JCKmL9TV2UcyaWfkKBG+RnMf0TPXtyXfT01EskWfdwyw2FQnq@vger.kernel.org
X-Gm-Message-State: AFuF++mtQmp6yp3MVDS5YGL1EDOsuShYp9SdrAyRZGUTjZwAv5YHiBNk
	w23oSqR+LAasMM6wE2HLKhnX/K0oN8FyxEgzSHfynNfCSGbdXv+xS7pr54TPE5PM8Drms+aX6vV
	bYRh+m5RqTRyJMX3m/w53l/ZGOhbsWP3RjwSy
X-Gm-Gg: AYBFou1cUMOPeErag15RqMf7MhU7etl7EhDoOmnWM4HO5bh+/waJf6IaTeoXmDEk0Ug
	K9f9aesah7nFK+CHD1I5ujb6Mi9hU7aJAoWrMG4OW6SCTgGYwU5+02O8m8B3HpuxR3Zz3CJ9yxR
	QdlT1uFeKPLXbQG4djQ382Uxsh+SCqeKRdDVK00GKN9PimQOM1pnoXoQMr8UFs/Akj74h6E1P9a
	4h75z4dOmC5w0EQLhRXgTeI1O/OCB6yDhC+psuvm+R8875DVbtZmyYeG9lqEAw/oIoSBAyC8CYS
	/FhhsQPPh7Yfw79cg3ygDTdBuBaQFwE86Y8OI7br0GzmSYO4N+RuTQr8V/feeC2pQA7SOqPcLrl
	DHg==
X-Received: by 2002:a05:690c:3482:b0:854:4ed4:c1b4 with SMTP id
 00721157ae682-86c51d423d0mr46661837b3.18.1788414243447; Wed, 02 Sep 2026
 22:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-7-laoar.shao@gmail.com>
 <apg9qFCgDaXbUT6J@pathway.suse.cz>
In-Reply-To: <apg9qFCgDaXbUT6J@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Sep 2026 13:43:27 +0800
X-Gm-Features: AcwNN1Wa3k1nOV8Tg03V8AN5ZnQgUkXSCH5AOU4-b9iq2JupCsPRfkpUG7Eyoss
Message-ID: <CALOAHbB4-iLD_v6GuXcCbh7uzparh4zhDhPdvdRuonwO6WAqvA@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 6/8] selftests/livepatch: Add
 provides/obsoletes test scenarios
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:15=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-08-25 19:46:39, Yafang Shao wrote:
> > Now that the legacy "replace" field has been replaced by the
> > provides/obsoletes mechanism, add test scenarios to verify the new
> > behavior.
> >
> > Fill in the #else branches of the test modules that were left as
> > TODO placeholders in the previous patch:
> >
> > - test_klp_atomic_replace.c gains provides and obsoletes module
> >   parameters for the provides/obsoletes based tests.
> >
> > - test_klp_callbacks_demo2.c gains a provides module parameter.
> >
> > - test_klp_livepatch.c gains a provides module parameter so that it
> >   can be loaded with a specific provides id for coexistence tests.
> >
> > - test_klp_state.c and test_klp_state2.c add a comment in the #else
> >   branch noting that provides=3D0 (the default) is equivalent to the
> >   previous .replace=3Dtrue behavior.
> >
> > Add test-provides.sh with four test scenarios:
> >
> > 1. provides=3D0 replaces provides=3D0: two livepatches with provides=3D=
0
> >    that modify different functions; the second replaces the first.
> >
> > 2. Same provides replaces: two livepatches with provides=3D1 that
> >    modify different functions; the second replaces the first.
> >
> > 3. Obsoletes replaces: a livepatch with provides=3D2 and obsoletes=3D[1=
]
> >    replaces a livepatch with provides=3D1. The provides/obsoletes sysfs
> >    values are verified.
> >
> > 4. provides=3D0 coexists with provides=3D1: two livepatches with
> >    different provides ids that modify different functions coexist,
> >    verifying that provides=3D0 does not replace a patch with a
> >    different provides id.
> >
> > The provides/obsoletes based tests only run on kernels that no longer
> > support the legacy "replace" attribute.
> >
> > Assisted-by: Comagic:DeepSeek-V4-Flash
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/livepatch/Makefile    |   3 +-
> >  .../livepatch/test-provides-obsoletes.sh      | 174 ++++++++++++++++++
> >  .../test_modules/test_klp_atomic_replace.c    |  22 ++-
> >  .../test_modules/test_klp_callbacks_demo2.c   |  12 +-
> >  .../test_modules/test_klp_livepatch.c         |   9 +
> >  .../livepatch/test_modules/test_klp_state.c   |   5 +-
> >  .../livepatch/test_modules/test_klp_state2.c  |   5 +-
> >  7 files changed, 205 insertions(+), 25 deletions(-)
> >  create mode 100755 tools/testing/selftests/livepatch/test-provides-obs=
oletes.sh
> >
> > diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing=
/selftests/livepatch/Makefile
> > index a080eb54a215..38f98594d883 100644
> > --- a/tools/testing/selftests/livepatch/Makefile
> > +++ b/tools/testing/selftests/livepatch/Makefile
> > @@ -11,7 +11,8 @@ TEST_PROGS :=3D \
> >       test-ftrace.sh \
> >       test-sysfs.sh \
> >       test-syscall.sh \
> > -     test-kprobe.sh
> > +     test-kprobe.sh \
> > +     test-provides-obsoletes.sh
> >
> >  TEST_FILES :=3D settings
> >
> > diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.=
sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > new file mode 100755
> > index 000000000000..2707457b9133
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > @@ -0,0 +1,174 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2026 Yafang Shao <laoar.shao@gmail.com>
> > +
> > +. $(dirname $0)/functions.sh
> > +
> > +MOD_ATOMIC=3Dtest_klp_atomic_replace
> > +MOD_LIVEPATCH=3Dtest_klp_livepatch
>
> I always get lost in the various test modules and have to look
> what is inside. It might help me if the name better describes
> the content, for example, rename:
>
>  + test_klp_atomic_replace -> test_klp_proc_memset_livepatch
>  + test_klp_livepatch -> test_klp_proc_cmdline_livepatch
>
> So, it is clear that they "livepatch" a given "proc" interface.
> And it is rather clear that they livepatch different functions.
>
> The names are long. The following might still be better than
> the current state:
>
>    + test_klp_memset_lp
>    + test_klp_cmdline_lp

Makes sense
I will do it.

--=20
Regards
Yafang
