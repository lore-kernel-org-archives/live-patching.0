Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62236492C
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405862; cv=pass; b=gWXu+mfMfsQo9bj5I858JgvA1UwzPFTPM3FipQnUIahMROEfC2/gpHXQ8l/pLp+ZwaxlGvoblTKfbVn4vDJ0CvB3SMvCNNqksJPUAR7qUcsKbt1sjS/edD2vJySZXP0OoAoEQWHJNeP4iiPqnhFkPnUKEPbEm1IWW+plpUhoP4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405862; c=relaxed/simple;
	bh=wz+oOb1LlFxSkRfUs3cHm8CO0as5uT7npr+aPXZHvPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc4sKFA3tK6lIoMPyARr6F3CqVSeFkIkcOtfsrTetVO354DVtvjLp8Nsj7UfKZ8M0oScZ3+AuIteOy4pTfxJ3Ptz81K4LL8v33nwlYHj/EG0jDZ4Fm5uQIzxQhGkPAtHS0jEhjErHlvmMV+EFzqhM/Cy/+P2t95SV4qI7TLd868=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK5aC1hm; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK5aC1hm"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66f8908a887so1290418d50.1
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 20:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788405859; cv=none;
        d=google.com; s=arc-20260327;
        b=TyNQGq/zuEEr+0FEpw5HIWnLJliwNci0x4EyLhiXZBNA/TJYFwPy12k3eYKjdQ/qm3
         32ywwlbdT2vrEsl4jS0ZkNgSZzhb6X2uRxCwXwijYDZDKvfN0m/Pp6jPFA+PSmFRwdd1
         sdB030+bg4x2MfkslQxzTxUXaYNYt8glxkj15ZTyNJmvGNcYrjEncmIzGLVEFAdDl4cr
         zzkhVJhh5+YfHmeZc2vOMVxrGlyKv4KydGppJF8598dPXqtBRmKsoWKgzwxP4YFJypDr
         Q/Z+7aqhArtccBXpPEhbfSA1AtojUxzpNEffB2Wq4hOUiKEuXpTiU9YIWgskPYjzl1Ii
         RV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLA5DjP8tz+6KqNce9Cjbv50r1btr40RRCEJb/6sFL8=;
        fh=5SjYDm+pt/6QU2ZwRONTPq+GaGGrtQxbV9FNpBRpOCs=;
        b=SGQASx3kYYuGFCyJxyjN7IcExTgGY9Xt3cXlRezhnbwf/rsWdWXyxKAc4vv2kdijzF
         2bi4whE1ZsGO9HNle3VLcV2IUICLEKWzK/25r7dBca2PHmpQoXmalJ7m5Laotapxo2VD
         PswZA7HglMRHcnMZz80h6UvNiWPAb3BzwI8a0wICT+obn5J6H0hNUGAADC2ZHaSyxLbm
         0d1nHTMqRAKRDoM+MidBUOKqh6N/j8Qm/EfmfFb25xFCQj4JX7g36CAhMcqSYbV+11y1
         0FYeLxQV/aixu/Se2PMwi0VllH4hlBlFu0meop/STGeUk9DCwc0JldrP65ZOrn8va4aD
         0WsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788405859; x=1789010659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLA5DjP8tz+6KqNce9Cjbv50r1btr40RRCEJb/6sFL8=;
        b=gK5aC1hmlmOqhIEEe7aOrdV/ldQUaQsDcMrOBmJL6OGHghdCprJIKkP7ZT2LNpP+Yv
         0Kvvr5XvIFuqjjQ2lWMnOhv7Ag5Wa1g2lhxbjt6/WbfflXVnEgVJaPy2wl9D3CALG8lZ
         +fN3sY8aYZYH0iid2AFlrVGqFYzS87XMhiP5eQtJsn7e/APIuyWss9TpjwE/KE2QvlPn
         wQYMmTLNNQpygH6kRcz5DqqCL1X3c7QFEVj9vbD5FkGx3gsLzr71lDmudM5zjfTRHwFC
         TGJtxrioDz0X1y+yYvt7EpDcL6HEFmX1G2mBSAj/gIzDPi/2/QwdIUk22ZS9+D/ZfOgG
         mYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788405859; x=1789010659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLA5DjP8tz+6KqNce9Cjbv50r1btr40RRCEJb/6sFL8=;
        b=Sg/UvBSO29ilEndQdOVpztt4mWB55QxGsTyoW8XrLdXvzDfNpRdR6gopgLrDPTuNnj
         OEa1WBfFwl9NE2G81Do4hITeH0TKG6tJA0B720ZDJq/PCuod8GABpIVmPmNWyQOM2rlh
         5qBHI2wyXiEdD6sEwuX6iz6n/NGGEEbzDI3dtUep25YVf8Hx3rwM3CVxnuTa/JlqAhll
         kKstk+sUBb2H6QCQv/5sgmyOE166+Kbaj9IJ8jQzg7rDUcjtwczVQbsFWyUkOUSayQvi
         yYJ/PS+/PgMr4RCAPLQBPxa/fBTHYc9fc7ILBg3T6fgIactdbNTVJy0DgcmiztCY1FIR
         2Hag==
X-Forwarded-Encrypted: i=1; AKwUvBw4WV0ZbxSnSaLPM6Z3HUZgjncXmRWwfkT3Jly34bOYazpCt+WKUedqDffClWKPYazteaJswWMUCxMylgtU@vger.kernel.org
X-Gm-Message-State: AFuF++mpZ9gXp4eTrDWsniShwmLz45iaCg11+yQ0TvvpLNtimsLhcpLH
	NSpDbsq8ztzJFoC5MkBKmfC50FkWyYOcu7itES6iFMPGXDnSjtxtgvQx2uAj4vhKdyCIbRjeFV2
	g4bfGoVw1ARzbqUNl0F7TtFNUsLPkAoE=
X-Gm-Gg: AYBFou0vGNbhE+Y3g6lgqKya3NN7XE1lGmogSVg9fWGhZ2sglLkNcyPTxBNkEjUZn7o
	H857FluYOTo/IAvzGL3wnDeVqaLQ2hMHMb1aCnOSplJgKKiV2o7zKXb6kEJ8InEOoPnseInX2Ly
	dUC5DWkSbgpNzMcvdq7gKcXDMr8IqKAnOPbA60wHjlPc/VGWIcTBVB4Es98k+wJ4XJIWOZ5jiBF
	lg4zxEXBzFoCVV3awc4XQYGv2lMsPir+7nfvBtU0gSmbfTU8fQejXHySWQf9927mtVb241P6x9a
	JOemcxBkgMBkzhYcC9B2WE1rG+x4E5Kvp12vI6CZouUX/KTURcGXA60nMmWt5wvgq/PBmBcaqvX
	ND1MpfIssdZhf
X-Received: by 2002:a05:690e:4401:b0:66d:1f6b:3a84 with SMTP id
 956f58d0204a3-66f9bd40f44mr2479295d50.36.1788405854607; Wed, 02 Sep 2026
 20:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-6-laoar.shao@gmail.com>
 <apgojIqhOoxYOXuK@pathway.suse.cz>
In-Reply-To: <apgojIqhOoxYOXuK@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Sep 2026 11:23:38 +0800
X-Gm-Features: AcwNN1VjzIvgO3xFMEtCGL9xg34VIGduXQ2Re1Y7sjpySfSpK0RnKWSolqwIf9g
Message-ID: <CALOAHbBJs=e-HfCjLGHotaksFgQ92AnKi=UejVeFx+AfYrU2Pw@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 5/8] selftests/livepatch: Adapt atomic replace
 tests to provides/obsoletes
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:45=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2026-08-25 19:46:38, Yafang Shao wrote:
> > The legacy "replace" field in struct klp_patch was replaced by the
> > provides/obsoletes mechanism. As a result, the atomic replace
> > selftests fail to build against kernels that only support
> > provides/obsoletes.
> >
> > Adapt the selftests so that they build and run on both old and new
> > kernels:
> >
> > - test_modules/Makefile detects whether the kernel header still
> >   declares the "replace" field. If so, it passes KLP_HAS_REPLACE to
> >   the modules via ccflags-y.
> >
> > - test_klp_atomic_replace.c and other source files using .replace guard
> >   their replace module parameter and .replace assignment with
> >   #ifdef KLP_HAS_REPLACE. The #else branches are left as TODO
> >   placeholders for the upcoming provides/obsoletes based tests.
> >
> > - functions.sh adds detect_replace_attr(), which loads a temporary
> >   livepatch and checks for the /sys/kernel/livepatch/<patch>/replace
> >   attribute, setting HAS_REPLACE_ATTR accordingly.
> >
> > - test-livepatch.sh and test-callbacks.sh run the tests that depend
> >   on multiple livepatches coexisting or on the atomic replace
> >   behavior ("multiple livepatches" and "atomic replace") only when
> >   HAS_REPLACE_ATTR is set. These scenarios do not apply to the new
> >   kernel, where provides=3D0 replaces any other livepatch by default.
> >
> > The provides/obsoletes based selftests will be added later.
> >
> > Assisted-by: Comagic:DeepSeek-V4-Flash
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/livepatch/functions.sh   | 15 +++++++++++++++
> >  .../selftests/livepatch/test-callbacks.sh        |  6 ++++++
> >  .../selftests/livepatch/test-livepatch.sh        |  6 ++++++
> >  .../selftests/livepatch/test_modules/Makefile    | 14 ++++++++++++++
> >  .../test_modules/test_klp_atomic_replace.c       | 16 ++++++++++++++++
> >  .../test_modules/test_klp_callbacks_demo2.c      | 16 ++++++++++++++++
> >  .../livepatch/test_modules/test_klp_state.c      |  7 +++++++
> >  .../livepatch/test_modules/test_klp_state2.c     |  7 +++++++
> >  8 files changed, 87 insertions(+)
> >
> > diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/tes=
ting/selftests/livepatch/functions.sh
> > index 30dc677b2f45..17810521d069 100644
> > --- a/tools/testing/selftests/livepatch/functions.sh
> > +++ b/tools/testing/selftests/livepatch/functions.sh
> > @@ -351,6 +351,21 @@ function does_sysfs_exist() {
> >       [[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
> >  }
> >
> > +# detect_replace_attr() - detect whether the running kernel still expo=
ses
> > +# the legacy "replace" sysfs attribute and set HAS_REPLACE_ATTR
> > +# accordingly. The atomic replace tests are only run when the attribut=
e
> > +# is present. The provides/obsoletes based tests will be added later.
> > +function detect_replace_attr() {
> > +     HAS_REPLACE_ATTR=3D0
> > +
> > +     load_lp test_klp_livepatch
> > +     if does_sysfs_exist test_klp_livepatch "replace"; then
> > +             HAS_REPLACE_ATTR=3D1
> > +     fi
> > +     disable_lp test_klp_livepatch
> > +     unload_lp test_klp_livepatch
> > +}
> > +
> >  # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
> >  # path permissions
> >  #    modname - livepatch module creating the sysfs interface
> > --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> > +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> > @@ -16,6 +16,20 @@ obj-m +=3D test_klp_atomic_replace.o \
> >       test_klp_state3.o \
> >       test_klp_syscall.o
> >
> > +# The legacy "replace" field was replaced by provides/obsoletes. When =
the
> > +# kernel (KDIR) still supports "replace", pass KLP_HAS_REPLACE to the
> > +# modules so that they can #ifdef the legacy "replace" code. Otherwise
> > +# the modules are built with the provides/obsoletes based code (to be
> > +# added later).
> > +KLP_SRC :=3D $(if $(wildcard $(srctree)/include/linux/livepatch.h), \
> > +              $(srctree), $(KDIR))
> > +KLP_HAS_REPLACE :=3D $(shell grep -q 'bool replace' \
> > +              $(KLP_SRC)/include/linux/livepatch.h 2>/dev/null \
> > +              && echo y)
> > +ifeq ($(KLP_HAS_REPLACE),y)
> > +ccflags-y +=3D -DKLP_HAS_REPLACE
> > +endif
> > +
> >  # Ensure that KDIR exists, otherwise skip the compilation
> >  modules:
> >  ifneq ("$(wildcard $(KDIR))", "")
>
> These two ways to detect the feature are dirty hacks. It might be
> acceptable in selftests. But I wonder if we could do better.
>
> Alternative solution might be to define:
>
>         HAVE_KLP_PROVIDES as true in kernel/livepatch/Kconfig
>
> We could then use in the Makefile:
>
>         ifeq ($(HAVE_KLP_PROVIDES),y)
>         ccflags-y +=3D -DHAVE_KLP_PROVIDES
>         endif
>
> And we could zgrep /proc/config.gz in the shell scripts.
> For example, see kconfig_has() in
> tools/testing/selftests/firmware/fw_lib.sh
>
> Note 1: It will work only when we change the state of HAVE_KLP_PROVIDES
>       in the patch when the provides/obsoletes are substituted.
>
> Note 2: We should update the selftests before we change the behavior.
>         Otherwise, we would break bisection.

Good point.
I will update it.

>
>
> > diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tool=
s/testing/selftests/livepatch/test-callbacks.sh
> > index 2a03deb26a12..e9b2dc6ea099 100755
> > --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> > +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> > @@ -451,6 +453,7 @@ $MOD_TARGET_BUSY: busymod_work_func exit
> >  $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
> >
> >
> > +if [[ "$HAS_REPLACE_ATTR" =3D=3D "1" ]]; then
> >  # Test loading multiple livepatches.  This test-case is mainly for com=
paring
> >  # with the next test-case.
> >  #
>
> Nit: Marcos made several tests conditional and he updated indentation
>         after adding the if/fi.
>
>      I could live with both approaches. It just would be nice to be
>      consistent.

I will update it

>
> And I like the idea to explicitly mention that a test has been
> skipped because a feature is not available.
>
> Best Regards,
> Petr


--=20
Regards
Yafang
