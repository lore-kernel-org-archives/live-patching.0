Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A63644C9
	for <live-patching@vger.kernel.org>; Mon, 28 Sep 2026 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790564159; cv=pass; b=mU7/IQtTQkJHj4jjt33X1WBvCDWZqHzAjbBs9LJ6D0JgEhnPVe372GgyFBSuvmPdhtN3Dmqn90QkDYd9wCAGlijl2P6Tfi5kYm54j65HZLhKYRnVcDxwXMThZkjDvItnpLxjX3DvfRUhLhR2U4+sl7D1pEP2vwLDwBj3sxyRbz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790564159; c=relaxed/simple;
	bh=WDYixOLKJDvGhp7fs3eVzsuzc1nV+xdH1uT9V8fYxtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skl2wKnEMdEpVq/P6E0CCh7GiOa4JtnmdvbCOTHVjvzIoYPHqpud7s+i/rUvzTMbnwkIhGSch1HYY9Kq6jYkxSgPQu6hr0kDoE5vGBSmCJVQFbi/sFrWDZvZx0e84AHOUD50Br2h9KrVhhKjc0yyJ1a3tshYIKMcjtIHgEr6M2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmQ5/Fpa; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmQ5/Fpa"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so18044367b3.0
        for <live-patching@vger.kernel.org>; Sun, 27 Sep 2026 19:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790564157; cv=none;
        d=google.com; s=arc-20260327;
        b=fuL89bP5DAsInUlvx36EZG79PTLib0P4mWo0umnbPcmhZTIywsY6TjMr3NO1Nt/jJi
         6p9VbDdk/kH6YFqAROKzZl9R3xcgjYXVr0nMjWunfWkgJaQ3bW29fiydMVyEkVZmr40M
         3z/X0Zftk4goj9KZ7oTGZe1QZCm/Zfigg29lO1HzTDsEfiBuUf6mAOTA0dKgsS5n4M68
         j8fHan+itxy7TxRc3fAV3EyJWcw4QF4aFmXziVzip9NkIcDVVKqoQHZZ16o/932ySfMy
         0FX10APcF2E/LGRacMpijRzQUA2ZIsbVdTl3UVZ4nyKmXC8erkmLWGxGp7RnPG10A2nG
         UaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8y8ZYrH+QOha841zZZGFE5+FYGnI5MiUMT7InmFG8qo=;
        fh=Wu1qWahXYSbuXDtBQ7fSRnJW0AfT/UN8M+sdN2qOdmY=;
        b=cCQ22G322Z2KPXHy7PkPn4gNOw8D7GA/18TcVKLTJfDKN75pTafU3vC5d3IOjC8uN+
         R5pIUXQHRL3U7kRL4nNh4wGqqYY5YSai7VQaIUcX9ZOK95N/8gU1VTtEXu1gYRmcoQ6+
         PK0lv8LCND6gY+o2Emzob5RghXseVi3cXwXFyCjaE+noFkLtQOT6edcQ90gz4AL4lcZX
         YnpaAARk80Qvw3GueWenOCUQ1l3+KomnV+sPLn0NKIiLEDU2+FvJS7Sa8CW09YCfBZkZ
         6bhfmt2bQD9sBSnME5JKZpYa4SBC7tTjtyVVnkMluuFzvnWwIJFtMkWWlXqwlJKMJVWn
         mK/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790564157; x=1791168957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8y8ZYrH+QOha841zZZGFE5+FYGnI5MiUMT7InmFG8qo=;
        b=bmQ5/Fpawpd7jSHEfDCzAiKajvkSw6xhcPWsqKgtwpt6j39b1NabVYKzTVNBrhKOmS
         t69ax1qZk78Xz3VrIbNt3tKxpoD6rNkP+GFp4+fRKI9qE6WT4Xi6Ky8ZCwl8yIvYExnA
         rH6it4aWh1eDIeFm7rKgRsjYz/zOeHxJEZZKSstpa8ZTK72Lz20N2kEn8klGRhhSIHqZ
         KrlBzryhD728xrQeiYj7dkpEfeZY314OcGVCXAyuLCF9wZW+CeHGFz1Y16SgSfcwOfJa
         DFj5TZNRLJ3jXo0Lv82ZxOKcc5FFQsRRonMCN02reDxAmlM0XVNyJzJ0Feh0fgiV9oJa
         DS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790564157; x=1791168957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8y8ZYrH+QOha841zZZGFE5+FYGnI5MiUMT7InmFG8qo=;
        b=gK+W0fY91sxkU0opc57X7DEEVaerVOqy8VHq5Vjri1nWt9me1SLrCEB3Sz3aaRpoJU
         YHxyym1ONiuTSJXbpjbPSBw8Npy3Mx8yNg7O/cVW7hERLRWQ262Qn1P4jOTN8CpOpfKV
         EEWUMKbZNys4uiG4ibc1u2WN6UBQVgJqT1N6qvG4iLtQTPIP8D91C+ttDWdoQXU9++QD
         qKb+qY56JPqULvjMa71LdHANGfyhqX5gZ2iS+BJCFMl9lDZ25ycLL4oChwbELSMAw1C1
         g5AySU3RFsAEKfItH8eagIUrFS6q5cjLBGwSHcs2sOHyDPpmW+qUV1Bie3Hy+kiMsKpc
         2pjg==
X-Forwarded-Encrypted: i=1; AKwUvBw9rtusA1+I0frYRVW5Dw1vbyq+A2BdDJSS11cG8Kb/2GaBKaC12ez+ec5q1DIJwxb30QmrhafIcQF0rk1i@vger.kernel.org
X-Gm-Message-State: AFq9FYKZEfDuV9xcT6nDFpcnebHupBFHco/YUOHYNf8JYsa/mzTtT8rJ
	28KQ9f5MupCGWY/Z3aOSOBqLgAsIjNm1TKlKbobGjWcFvMvpJyJuKmzW8zkZE7Vpy/2lvAC7a75
	RQtB/OViDigXjwazBK0f0R80TETTGjCY=
X-Gm-Gg: AYBFou1bNguGX5hfpe9zmyHGaM37srxjxvIYb1WUCZtJtqLkeUxeQ/D3T7uKNAA6zxz
	OwbbMZIkPYsxytFQKJu3to8hflViBlpkIphNW2XbHZdai3pmEjVr0se4RobeH9vunBGS0xsaCgJ
	bxPWUF8FXWBllSfHoqvtv8XnGbRi5ZYf69Zm/+DqcpQdN/D+v2+BnKOw+1H79AOD4ZqBCqxALQD
	EUE4Af/X13/ZNzDGyDL59YSoH62eAEeOleU/cOJ4xVZhLEjXPu1AgRqtTwMRVm+iNrkJQMsHjGO
	eAEGVsPjxkTu3qqlKAH1BDYUy9hdNsynqraNSjpb+gt4O6QQfaIPxWlkDVKnVj2BDHG4naaDhAe
	nbyRXMM23eA==
X-Received: by 2002:a05:690c:680d:b0:873:5c0f:293 with SMTP id
 00721157ae682-8a64c3421e5mr56116867b3.61.1790564156617; Sun, 27 Sep 2026
 19:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-3-laoar.shao@gmail.com>
 <179032647206.68715.855492643431181079.b4-review@b4>
In-Reply-To: <179032647206.68715.855492643431181079.b4-review@b4>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 28 Sep 2026 10:55:19 +0800
X-Gm-Features: AclHuK-srQHSszc_YUM4wmOG3_zgQXfTXdgBfbXT7wVnk5ofbcSTg2UF9ZvFZ_g
Message-ID: <CALOAHbBQyCNyvWtv3r+7mgScGuiZunfDq-+CJgKYGVyZDxcB3g@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
To: Miroslav Benes <mbenes@suse.cz>, Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:54=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> > The legacy "replace" field in struct klp_patch will be replaced by the
> > provides/obsoletes mechanism. As a result, the atomic replace
> > selftests fail to build against kernels that only support
> > provides/obsoletes.
> >
> > Adapt the selftests so that they build and run on both old and new
> > kernels.  On kernels without the legacy "replace" support, the
> > replace-related test cases are skipped with a SKIP message instead
> > of being run.
> >
> > The provides/obsoletes based selftests will be added later after the
> > provides/obsoletes are substituted.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  .../testing/selftests/livepatch/functions.sh  |  30 ++++++
> >  .../selftests/livepatch/test-callbacks.sh     |  43 +++++---
> >  .../selftests/livepatch/test-livepatch.sh     | 102 ++++++++++--------
> >  .../test_modules/test_klp_callbacks_demo2.c   |  16 +++
> >  .../test_modules/test_klp_meminfo_lp.c        |  16 +++
> >  .../livepatch/test_modules/test_klp_state.c   |   7 ++
> >  .../livepatch/test_modules/test_klp_state2.c  |   7 ++
> >  7 files changed, 162 insertions(+), 59 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/tes=
ting/selftests/livepatch/functions.sh
> > index a65b7b1ac8ad..1d5d8ee890a6 100644
> > --- a/tools/testing/selftests/livepatch/functions.sh
> > +++ b/tools/testing/selftests/livepatch/functions.sh
> > @@ -328,6 +328,15 @@ function start_test {
> >       log "=3D=3D=3D=3D=3D TEST: $test =3D=3D=3D=3D=3D"
> >  }
> >
> > +function skip_test {
> > +     local test=3D"$1"
> > +     local reason=3D"$2"
> > +
> > +     echo -n "TEST: $test ... "
> > +     echo "SKIP ($reason)"
> > +     log "=3D=3D=3D=3D=3D TEST: $test SKIPPED: $reason =3D=3D=3D=3D=3D=
"
> > +}
>
> We also have skip() in functions.sh which exits a test script
> immediately (and is used for detecting necessary prerequisites for
> testing). skip_test() is used in conditionals and just prints useful
> output. I think that we need a better naming which would distinguish
> between the two. I would not mind renaming skip() to skip_exit() and
> using skip() for the above but I am not good in naming.

Makes sense to me.
I will update it.

>
> >  # check_result() - verify dmesg output
> >  #    TODO - better filter, out of order msgs, etc?
> >  function check_result {
> > @@ -365,6 +374,27 @@ function does_sysfs_exist() {
> >       [[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
> >  }
> >
> > +# detect_provides_attr() - detect whether the running kernel supports =
the
> > +# livepatch "provides" attribute and set HAS_PROVIDES_ATTR accordingly=
.
> > +# The provides/obsoletes based tests are only run when HAS_PROVIDES_AT=
TR
> > +# is set.
> > +function detect_provides_attr() {
> > +     HAS_PROVIDES_ATTR=3D0
> > +
> > +     if [[ -r /proc/config.gz ]] &&
> > +        zgrep -q "CONFIG_KLP_HAS_PROVIDES=3Dy" /proc/config.gz 2>/dev/=
null; then
> > +             HAS_PROVIDES_ATTR=3D1
> > +             return 0
> > +     fi
> > +
> > +     load_lp test_klp_cmdline_lp
> > +     if does_sysfs_exist test_klp_cmdline_lp "provides"; then
> > +             HAS_PROVIDES_ATTR=3D1
> > +     fi
> > +     disable_lp test_klp_cmdline_lp
> > +     unload_lp test_klp_cmdline_lp
> > +}
>
> Why is there does_sysfs_exist() fallback? I mean, we use that currently
> for exactly this purpose. My understanding is that
> CONFIG_KLP_HAS_PROVIDES is also used elsewhere in the code so using it
> here makes some sense, but do we need both?

CONFIG_IKCONFIG_PROC may not be enabled, so if /proc/config.gz doesn't
exist, we must fall back to an alternative one.

>
> Also, would it be a good idea to move CONFIG_KLP_HAS_PROVIDES definition
> to this patch with "def_bool n" and just change it later when it is
> actually implemented? It might make the whole thing more consistent.

Sure, I will update it.

>
> >  # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
> >  # path permissions
> >  #    modname - livepatch module creating the sysfs interface
> > diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tool=
s/testing/selftests/livepatch/test-callbacks.sh
> > index 2a03deb26a12..346248f3488b 100755
> > --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> > +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> > @@ -10,6 +10,7 @@ MOD_TARGET=3Dtest_klp_callbacks_mod
> >  MOD_TARGET_BUSY=3Dtest_klp_callbacks_busy
> >
> >  setup_config
> > +detect_provides_attr
> >
> >
> >  # Test a combination of loading a kernel module and a livepatch that
> > @@ -458,16 +459,17 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
> >  #   execute as each patch progresses through its (un)patching
> >  #   transition.
> >
> > -start_test "multiple livepatches"
> > +function test_multiple_livepatches() {
> > +     start_test "multiple livepatches"
> >
> > -load_lp $MOD_LIVEPATCH
> > -load_lp $MOD_LIVEPATCH2
> > -disable_lp $MOD_LIVEPATCH2
> > -disable_lp $MOD_LIVEPATCH
> > -unload_lp $MOD_LIVEPATCH2
> > -unload_lp $MOD_LIVEPATCH
> > +     load_lp $MOD_LIVEPATCH
> > +     load_lp $MOD_LIVEPATCH2
> > +     disable_lp $MOD_LIVEPATCH2
> > +     disable_lp $MOD_LIVEPATCH
> > +     unload_lp $MOD_LIVEPATCH2
> > +     unload_lp $MOD_LIVEPATCH
> >
> > -check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> > +     check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> >  livepatch: enabling patch '$MOD_LIVEPATCH'
> >  livepatch: '$MOD_LIVEPATCH': initializing patching transition
> >  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> > @@ -499,6 +501,7 @@ $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
> >  livepatch: '$MOD_LIVEPATCH': unpatching complete
> >  % rmmod $MOD_LIVEPATCH2
> >  % rmmod $MOD_LIVEPATCH"
> > +}
> >
> >
> >  # Load multiple livepatches, but the second as an 'atomic-replace'
> > @@ -515,15 +518,16 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
> >  # - Once the atomic replace module is loaded, only its pre and post
> >  #   unpatch callbacks are executed.
> >
> > -start_test "atomic replace"
> > +function test_atomic_replace() {
> > +     start_test "atomic replace"
> >
> > -load_lp $MOD_LIVEPATCH
> > -load_lp $MOD_LIVEPATCH2 replace=3D1
> > -disable_lp $MOD_LIVEPATCH2
> > -unload_lp $MOD_LIVEPATCH2
> > -unload_lp $MOD_LIVEPATCH
> > +     load_lp $MOD_LIVEPATCH
> > +     load_lp $MOD_LIVEPATCH2 replace=3D1
> > +     disable_lp $MOD_LIVEPATCH2
> > +     unload_lp $MOD_LIVEPATCH2
> > +     unload_lp $MOD_LIVEPATCH
> >
> > -check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> > +     check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> >  livepatch: enabling patch '$MOD_LIVEPATCH'
> >  livepatch: '$MOD_LIVEPATCH': initializing patching transition
> >  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> > @@ -548,6 +552,15 @@ $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
> >  livepatch: '$MOD_LIVEPATCH2': unpatching complete
> >  % rmmod $MOD_LIVEPATCH2
> >  % rmmod $MOD_LIVEPATCH"
> > +}
> >
> >
> > +if [[ "$HAS_PROVIDES_ATTR" !=3D "1" ]]; then
> > +     test_multiple_livepatches
> > +     test_atomic_replace
> > +else
> > +     skip_test "multiple livepatches" "legacy replace attribute not pr=
esent"
> > +     skip_test "atomic replace" "legacy replace attribute not present"
> > +fi
>
> Wrapping into functions is not used later anywhere if I am not missing
> something. Nothing really important but my preference would be to just
> wrap the existing test code with HAS_PROVIDES_ATTR if where appropriate
> and be done with it.
>
> if [[ "$HAS_PROVIDES_ATTR" !=3D "1" ]]; then
>         start_test "multiple livepatches"
>         load_lp $MOD_LIVEPATCH
>         load_lp $MOD_LIVEPATCH2
>         ...
> else
>         skip_test "multiple livepatches" "legacy replace attribute not pr=
esent"
> fi
>
> and similarly for "atomic replace" test.
>
> What do you think?

In the previous version, Song suggested wrapping them into a helper
function [0]. I don't have a strong preference either way.
Song, what do you think?

[0] https://lore.kernel.org/all/CAPhsuW7iK5QeOGdbNr=3D0ygch=3DySNbUuVPdvy2B=
WFieFAb14u4Q@mail.gmail.com/

>
> [...]
>
> > +if [[ "$HAS_PROVIDES_ATTR" !=3D "1" ]]; then
> > +     test_multiple_livepatches
> > +     test_atomic_replace_livepatch
> > +else
> > +     skip_test "multiple livepatches" "legacy replace attribute not pr=
esent"
> > +     skip_test "atomic replace livepatch" "legacy replace attribute no=
t present"
> > +fi
>
> Same here.
>
> >  # - load a target module that provides /proc/test_klp_mod_target with
> > diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_ca=
llbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_c=
allbacks_demo2.c
> > index 5417573e80af..de4eabd4b924 100644
> > --- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks=
_demo2.c
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks=
_demo2.c
> > @@ -7,9 +7,16 @@
> >  #include <linux/kernel.h>
> >  #include <linux/livepatch.h>
> >
> > +#ifndef CONFIG_KLP_HAS_PROVIDES
> >  static int replace;
> >  module_param(replace, int, 0644);
> >  MODULE_PARM_DESC(replace, "replace (default=3D0)");
> > +#else
> > +/*
> > + * TODO: Add provides/obsoletes module parameters for the
> > + * provides/obsoletes based tests (to be added later).
> > + */
> > +#endif
> >
> >  static const char *const module_state[] =3D {
> >       [MODULE_STATE_LIVE]     =3D "[MODULE_STATE_LIVE] Normal state",
> > @@ -72,12 +79,21 @@ static struct klp_object objs[] =3D {
> >  static struct klp_patch patch =3D {
> >       .mod =3D THIS_MODULE,
> >       .objs =3D objs,
> > +#ifndef CONFIG_KLP_HAS_PROVIDES
> >       /* set .replace in the init function below for demo purposes */
> > +#endif
> >  };
> >
> >  static int test_klp_callbacks_demo2_init(void)
> >  {
> > +#ifndef CONFIG_KLP_HAS_PROVIDES
> >       patch.replace =3D replace;
> > +#else
> > +     /*
> > +      * TODO: Set provides/obsoletes from the module parameters
> > +      * for the provides/obsoletes based tests (to be added later).
> > +      */
> > +#endif
> >       return klp_enable_patch(&patch);
> >  }
>
> A nit, but since you change #ifndef to #ifdef later, my preference would
> be to use #ifdef here right away.
>
> #ifdef CONFIG_KLP_HAS_PROVIDES
>         /*
>          * TODO: Set provides/obsoletes from the module parameters
>          * for the provides/obsoletes based tests (to be added later).
>          */
> #else
>         patch.replace =3D replace;
> #endif
>
> After all you prepare the code for a new feature. What do you think?
>
> Similarly elsewhere.

I will update them.

--=20
Regards
Yafang
