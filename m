Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792687429;
	b=tjzjri6wCPinruN3F5RoTHdFdGB+0pJ36TvSpfxEI2WXkflmPAfjFzbOSbaAs40hY7uZ
	 R6JG1oOqecQCAWggUXmagPGI05eZSMlB69EfF32cngmU3J3wH5znaf8Vq7oHUedm786Oq
	 eT4g1mvrrj41yXxluGjQGuV/KHjpGhavAfErEvIjmrVCFbW1ep8cQP5oXADoLpfh+FQ2B
	 L4of82/cEn2rJTHol0uafyZZ2RtprRv5mDuP8Le5UKYusyT/ZEEFgxwey5WaOJKK0zUD9
	 QoO4yNs+C5cpA0WW9xL2fS5EqffpmQF0j7x00hiD5yh92g3b/Yv1POSrmLivNawRwWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RWBu0L6GyctEcrndh+pLitaGf6a9PmIPUhVcaX/zx+4=;
	b=CKJtNVWrJhVCqyZ4ywo6HIOswmuzhJZDiqJ2lR8nZZat/CuXd/W5MK3pvv8ubKCG3b/A
	 9bqwwMSx7ZLYAu8jA2mQZErxYsNUE0YJXM6b/5XsOmon3SVsLN8YTb73ar3ZpiVaEPj5L
	 iDkvJiQlWRDkqxLcT7Dsw8uMLeUh85n00OFL0EcHWKiT97qTx75k5wslHGCS9R1pKL/IY
	 HUvlGNjFMZPlLMEzKkVUiyRYOf0ej6QJHvmueGaeBiD9WiaTvdy9QQK1swXdUsGRGgE51
	 fTRUV/xcmII0zMNcW8X/5Pff+gNccITUqOEDUuacvaHNScaexyR0fyWVSCayBKeqFTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pr8s+SsI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0844606A31F
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 16:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0844606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pr8s+SsI
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso17057a12.0
        for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 09:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792687428; cv=none;
        d=google.com; s=arc-20260327;
        b=H6yYUSuGXOYVGta/MUtbDP90UfDDDFvhEXPLejxeLTYs3lUYBxXV55O44UGgIwqKn7
         bvtGW9QzKLSGVxi97yUaXxnnT0lYavYAPwtTD2V5RYS3mFl9e2ZBV1KVB24CckZgHrgn
         Uzx+o7sharrMzzEY16SKnpwhvG9ck5DXK5cx9UH/8hQpXZjSQ6IItaNrJZUY9YEvlNac
         DXAezdEcUFP/SVNU6oqdY0lvrNPir3rTR8T9e/frThrROt0QycdV3GiAqOHSbVNq4IS+
         81SIsy7El8ig5CqeS9uW5tNr3KtibZ4+486LZDO/VQGj2cUaT6Z+w+6dillEsEt5vg2v
         /aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RWBu0L6GyctEcrndh+pLitaGf6a9PmIPUhVcaX/zx+4=;
        fh=fsdO717A9olY9f8OWeEBVjc2BaVWCecerOVNqww9UJ8=;
        b=ajaIfnOy2zM/w7sp1zSX0ooPnv8lI9wY3M+V6Mu9w9f7FE7b2hFCHQTKA9Q3DWiTtu
         YGQgZJkrlS81lxsjQNLnvkaLuomkuxodahQVe/UGzqGzGpYBWUA1CDqd0TljVY0IIwuz
         /sQGmXzAb4HPWBDNvSkDZO3rmrigfPHuREQmKUNIvfYqJYTV4Oj2je6CrL8iUfcefABP
         eeBIDhI0enwWWX9+ckAytgQtN2yC9WLOn9rcP2CO6ZJvUyOBWQ4VVfCoI24Qwxq9HYBt
         XJLzpxclrZ/lMcvmR9t7KwDy5I8KuIM36VcuimLvlk3a7V++EQw0/hyojmLTzasg0Koc
         2BqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687428; x=1793292228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RWBu0L6GyctEcrndh+pLitaGf6a9PmIPUhVcaX/zx+4=;
        b=Pr8s+SsIz/WyPSMsb9Qv0E55MYc1auMO7G+N+ASZdqRqU6pbiCNzZbDw2LyshBTYCy
         uaWadL1xuRAzqgxEBUIbNO1j09dgNFP8ZcEuuwSr4VaFdMGkL5Uq/Dih+8c8wgCtARw8
         IYB/ZQRnp8rWBQDJ0lQSaLcKtdara6jP5p6xgkInPehSY7qvJ+kj2E5DiIr+4piXvL+N
         WLfIteoNXS5sCH+oS3MsYY0IUC42875ehLuIrWxkhA1qieWhsINbtlUqduzsqA/Posou
         CCk3Sj9eI8sp+Ox/515VP9JvdeweVmLm0sh5aXIY51Jdq6Ptsq/gxlL/1DYE7MUF1f/7
         0xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687428; x=1793292228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RWBu0L6GyctEcrndh+pLitaGf6a9PmIPUhVcaX/zx+4=;
        b=bzOonF32E9eP9ceHwQLAEbo6d4cjBXCctRdV+wEa3TS2gz4VJhVs66KzpyHY4kIM/Z
         PNzPwsGaez2I+JYR0W+9h822hfg5nzH37ydykTjL2ihOhkUQOaB/1TyI0B8JPCn97dEb
         qn2EyP7DJvgUktICPPYabDz+kg35PVS672ya7E0UbzQId/+WV1T1w3qVP/OkmnJpcsCr
         DPY7PTd5VxStyuQVnYR4u/JcBQkHyh5JW9L+ja68Pcc1Ly2WF1oZtzlDDGw5ZLCRou9a
         Aq6zIl1FPuEun8+LlGz9FO8RIIImbqtY6al1LiAko8MIH/qoNe4lKfZZezzxYu+QC+1Z
         8DFA==
X-Gm-Message-State: AFq9FYLHAWZgE5DC6UMmmDJJFk2bREG+d9601GotRISxuuxvpzeJGqoE
	sv/LNoZPUTMe/ZFe6rIbUh9+g08gowtzNxyoRcpmm7WhUteBgfQjbt2E10Ud0VSaF5wMRNCtC8e
	n2YZXq9SkCRWN8xX/fuoJEjPznXgaFd0=
X-Gm-Gg: AYBFou3w+AtJXhzpNjdnJbnTCVctshhndSJnB+663xsrfm6ITprwJo1Dg94tfXCD9CC
	EYo0hOCAvf121KwZCHmWHxe0N1EPKUw3qWTcv83DSxU4rS9w0iQlVM9V6PCExUKsRALVWPTRDUv
	JOA0GkxMDeOKM2lMbMZBBzdY+BHBGi3DgGSpRR1FWrKshst+0Ji4uZ00FPoOeKPUzcSWjJjFSe7
	suQYPINvxsR0WCqq/XTzFEeNuc2L/WfLcLFjCG+kN4qMnAirFDD5r4vRzvXceAcz0jVpJQmXmuw
	ptq3Jr9fkTP3fcnDrmGXstmbWTcUbUTWEdy7/y0iUsiMSklOZqi/ovEL0lEzy/f68rvmrqmR8C7
	tktlxoER9QkkzNuFl1dgtTpWOXGfl70uXTLMrRLOdLl+RP/qicppxpzjuHhw/MsWaFK4BCOUN/w
	==
X-Received: by 2002:a17:90b:2f8b:b0:3ad:6781:da66 with SMTP id
 98e67ed59e1d1-3ad86c79915mr4455542a91.23.1792687427977; Thu, 22 Oct 2026
 09:43:47 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022122544.125305-1-puranjay@kernel.org> <20261022122544.125305-2-puranjay@kernel.org>
 <atohxvOb9MAxkhsg@redhat.com>
In-Reply-To: <atohxvOb9MAxkhsg@redhat.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 22 Oct 2026 17:43:32 +0100
X-Gm-Features: AclHuK84Na-Urki1keM56qgRX3JZRZfnEF1nOb135WyNCcOP-tNmRJn1LvQ1GVU
Message-ID: <CANk7y0jZ-zJ=+ryOtCG6RCVEDbKFeAZ_zkL-yj1BO6ZTcER=CQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] objtool/klp: Build test fixtures with ftrace
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:46=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Thu, Oct 22, 2026 at 05:25:36AM -0700, Puranjay Mohan wrote:
> > Livepatch depends on ftrace, so the kernel klp-build operates on always
> > has __mcount_loc, but the test fixtures are built without it.
> >
> > On x86, build them with -pg -mfentry and generate __mcount_loc like the
> > kernel does: with -mrecord-mcount -mnop-mcount if the compiler supports
> > it (FTRACE_MCOUNT_USE_CC), otherwise with objtool --mcount --mnop
> > (FTRACE_MCOUNT_USE_OBJTOOL).
> >
> > test-checksum-alt ran objtool --mcount only to get insn->alts, which
> > "klp checksum" builds by itself, and that now warns about the existing
> > __mcount_loc.  Remove it.
> >
> > test-special-sections can now check the real __mcount_loc instead of a
> > hand-written one.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  .../objtool/Documentation/klp-write-tests.txt |  9 ++--
> >  .../tests/generic/test-thinlto-ambiguity.sh   |  3 +-
> >  .../tests/generic/test-thinlto-local.sh       |  5 ++-
> >  tools/objtool/tests/lib.sh                    | 42 +++++++++++++++++--
> >  tools/objtool/tests/x86/test-checksum-alt.sh  |  4 --
> >  .../tests/x86/test-special-sections.sh        | 23 ++++++----
> >  6 files changed, 64 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/objtool/Documentation/klp-write-tests.txt b/tools/ob=
jtool/Documentation/klp-write-tests.txt
> > index eb2cacaf57207..7cc2148083cc2 100644
> > --- a/tools/objtool/Documentation/klp-write-tests.txt
> > +++ b/tools/objtool/Documentation/klp-write-tests.txt
> > @@ -116,9 +116,12 @@ Traps that have bitten before
> >    section entsize or annotations".  Their targets need real (global) s=
ymbols,
> >    or it reports "failed to convert reloc sym".
> >  * **Prefer letting objtool generate what objtool generates.**
> > -  ``.static_call_sites``, ``.mcount_loc``, ``.ibt_endbr_seal`` and ORC=
 come
> > -  from its check pass.  Call ``run_objtool_check --mcount`` and let it=
 build
> > -  them; a hand-written copy tests your reading of the format, not the =
format.
> > +  ``.static_call_sites``, ``.ibt_endbr_seal`` and ORC come from its ch=
eck
> > +  pass.  Call ``run_objtool_check`` with the option for what you need =
and let
> > +  it build them; a hand-written copy tests your reading of the format,=
 not the
> > +  format.
> > +* **Fixtures are built with ftrace.**  Objects not built with ``build_=
one``
> > +  need ``$FTRACE_CFLAGS`` and ``record_mcount`` too.
> >
> >    Write one by hand only when the test needs a shape objtool will not =
produce,
> >    and say so in the fixture.  generic/fixtures/static_call.c does: obj=
tool
> > diff --git a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh b/to=
ols/objtool/tests/generic/test-thinlto-ambiguity.sh
> > index 34f4f3a58e201..73740c804d54f 100755
> > --- a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> > +++ b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> > @@ -38,12 +38,13 @@ build_thinlto()           # $1 output object, $2 ex=
tra flags
> >  {
> >       local t
> >       for t in "" -DTU_B -DTU_C; do
> > -             $THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sect=
ions \
> > +             $THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sect=
ions $FTRACE_CFLAGS \
> >                       $2 $t -c "$FIXTURES_DIR/thinlto_ambiguity.c" \
> >                       -o "$workdir/tu$t.o" 2>/dev/null || return 1
> >       done
> >       "$THIN_LD" -r "$workdir/tu.o" "$workdir/tu-DTU_B.o" "$workdir/tu-=
DTU_C.o" \
> >               -o "$1" 2>/dev/null || return 1
> > +     record_mcount "$1"
> >  }
> >
> >  build_thinlto "$workdir/orig.o" "" ||
> > diff --git a/tools/objtool/tests/generic/test-thinlto-local.sh b/tools/=
objtool/tests/generic/test-thinlto-local.sh
> > index a266263676ed5..090c6df75ad64 100755
> > --- a/tools/objtool/tests/generic/test-thinlto-local.sh
> > +++ b/tools/objtool/tests/generic/test-thinlto-local.sh
> > @@ -15,11 +15,12 @@ find_thinlto_toolchain ||
> >
> >  build_thinlto()              # $1 output object, $2 extra flags
> >  {
> > -     $THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sections $2 =
\
> > +     $THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sections $FT=
RACE_CFLAGS $2 \
> >               -c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_a.o" 2=
>/dev/null || return 1
> > -     $THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sections $2 =
-DTU_B \
> > +     $THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sections $FT=
RACE_CFLAGS $2 -DTU_B \
> >               -c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_b.o" 2=
>/dev/null || return 1
> >       "$THIN_LD" -r "$workdir/tu_a.o" "$workdir/tu_b.o" -o "$1" 2>/dev/=
null || return 1
> > +     record_mcount "$1"
> >  }
> >
> >  build_thinlto "$workdir/orig.o" "" ||
> > diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> > index 4da168d0ddca3..d07eb07d15611 100644
> > --- a/tools/objtool/tests/lib.sh
> > +++ b/tools/objtool/tests/lib.sh
> > @@ -41,7 +41,7 @@ OBJTOOL=3D"${OBJTOOL:-$TESTS_DIR/../objtool}"
> >  #
> >  klp_preflight()
> >  {
> > -     local tmp tool cc_version arch host cc_arch
> > +     local tmp tool cc_version arch host cc_arch mcount=3D
> >
> >       bail() { echo "Bail out! $*" >&2; exit 1; }
> >
> > @@ -99,6 +99,16 @@ klp_preflight()
> >       *AArch64*)              cc_arch=3Darm64 ;;
> >       *)                      cc_arch=3D ;;
> >       esac
> > +
> > +     # Same test as FTRACE_MCOUNT_USE_CC.
> > +     if [ "$cc_arch" =3D x86 ]; then
> > +             if $CC -pg -mfentry -mrecord-mcount -mnop-mcount -c \
> > +                     -o "$tmp/probe.o" "$tmp/probe.c" 2>/dev/null; the=
n
> > +                     mcount=3Dcc
> > +             else
> > +                     mcount=3Dobjtool
> > +             fi
> > +     fi
> >       rm -rf "$tmp"
> >
> >       # Normalize to the kernel's SRCARCH.
> > @@ -119,8 +129,9 @@ klp_preflight()
> >                    "the $arch tests would run against the wrong archite=
cture"
> >
> >       KLP_TEST_ARCH=3D"$arch"
> > +     KLP_TEST_MCOUNT=3D"$mcount"
> >       KLP_TEST_PREFLIGHT=3Ddone
> > -     export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_PREFLIGHT
> > +     export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_MCOUNT KLP_TEST_PREFLIGH=
T
> >
> >       cc_version=3D"$($CC --version 2>/dev/null | head -1)"
> >       cat <<EOF
> > @@ -128,6 +139,7 @@ klp_preflight()
> >  #   objtool   $OBJTOOL (klp: yes)
> >  #   compiler  $cc_version
> >  #   arch      $KLP_TEST_ARCH$([ "$arch" =3D "$host" ] || echo "  (host=
 $host, cross)")
> > +#   mcount    ${KLP_TEST_MCOUNT:-n/a}
> >  #   tmpdir    ${TMPDIR:-/tmp}  (each test builds in a fresh directory =
here)
> >  EOF
> >  }
> > @@ -153,6 +165,16 @@ EOF
> >  FIXTURE_CFLAGS=3D"-O2 -ffunction-sections -fdata-sections -fno-common =
\
> >               -fno-asynchronous-unwind-tables"
> >
> > +# Build with ftrace, which livepatch depends on.  Objects not built wi=
th
> > +# build_one() need FTRACE_CFLAGS and record_mcount() too.
> > +FTRACE_CFLAGS=3D
> > +if [ "$KLP_TEST_ARCH" =3D x86 ]; then
> > +     FTRACE_CFLAGS=3D"-pg -mfentry"
> > +     [ "$KLP_TEST_MCOUNT" =3D cc ] &&
> > +             FTRACE_CFLAGS=3D"$FTRACE_CFLAGS -mrecord-mcount -mnop-mco=
unt"
> > +fi
> > +FIXTURE_CFLAGS=3D"$FIXTURE_CFLAGS $FTRACE_CFLAGS"
> > +
> >  test_name=3D"$(basename "$0" .sh)"
> >  workdir=3D
> >
> > @@ -343,6 +365,20 @@ build_one()
> >
> >       $CC -c $FIXTURE_CFLAGS "$@" -o "$out" "$fixture" 2>"$workdir/cc.l=
og" ||
> >               fail "$(basename "$fixture") does not build: $(tail -1 "$=
workdir/cc.log")"
> > +
> > +     record_mcount "$out"
> > +}
> > +
> > +# record_mcount <object>
> > +#
> > +# FTRACE_MCOUNT_USE_OBJTOOL.  CONFIG_KLP_BUILD always runs objtool wit=
h --link.
> > +record_mcount()
> > +{
> > +     [ "$KLP_TEST_MCOUNT" =3D objtool ] || return 0
> > +
> > +     "$OBJTOOL" --mcount --mnop --link "$1" 2>"$workdir/objtool.log" |=
|
> > +             fail "objtool --mcount failed on $(basename "$1"):" \
> > +                  "$(tail -1 "$workdir/objtool.log")"
> >  }
> >
> >  # build_pair <fixture.c> [cflags...]
> > @@ -365,7 +401,7 @@ build_pair()
> >  # Run objtool's ordinary check pass over the pair, as the kernel build=
 does.
> >  #
> >  # Some of what klp diff consumes is produced by this pass rather than =
by the
> > -# compiler: .static_call_sites, .mcount_loc, .ibt_endbr_seal, ORC.
> > +# compiler: .static_call_sites, .ibt_endbr_seal, ORC.
> >  #
> >  # Only module objects see it before klp-build -- with CONFIG_KLP_BUILD=
 the
> >  # per-object pass is deferred, so built-in objects reach klp diff exac=
tly as
> > diff --git a/tools/objtool/tests/x86/test-checksum-alt.sh b/tools/objto=
ol/tests/x86/test-checksum-alt.sh
> > index 74ebfca2b3ff3..eb9864c4bf825 100755
> > --- a/tools/objtool/tests/x86/test-checksum-alt.sh
> > +++ b/tools/objtool/tests/x86/test-checksum-alt.sh
> > @@ -16,9 +16,6 @@
> >  # the feature bit, so the failure looks like a machine-specific bug ra=
ther than
> >  # a missing patch.
> >  #
> > -# insn->alts exists only after objtool's check pass, so the pair goes =
through
> > -# that first -- the compiler emits none of this structure itself.
> > -#
> >  # Covers the same ground as corpus/x86_64/checksum-alt-group,
> >  # checksum-alt-no-group and checksum-alt-recursion-guard in Joe Lawren=
ce's
> >  # klp-build unit test corpus.
> > @@ -31,7 +28,6 @@ check()
> >  {
> >       build_pair checksum_alt.c "-D$1"
> >       assert_input_section .altinstructions
> > -     run_objtool_check --mcount
> >       run_checksum
> >
> >       assert_checksum_differs target
> > diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/o=
bjtool/tests/x86/test-special-sections.sh
> > index 8dfaa4fc9a360..b05d43cdc8aa4 100755
> > --- a/tools/objtool/tests/x86/test-special-sections.sh
> > +++ b/tools/objtool/tests/x86/test-special-sections.sh
> > @@ -15,26 +15,31 @@
> >
> >
> >  # section, entry size, relocations per entry
> > -for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; d=
o
> > +for spec in "__bug_table 12 1" "__ex_table 12 2"; do
> >       set -- $spec
> > -     sec=3D$1
> >
> >       # A fresh workdir per section: run_diff caches its checksums.
> >       setup
> >       build_pair special_sections.c \
> >               -DSPECIAL_SEC=3D"\"$1\"" -DSPECIAL_ENTSIZE=3D"$2" -DSPECI=
AL_RELOCS=3D"$3"
> >
> > -     assert_input_section "$sec"
> > +     # __mcount_loc comes from FTRACE_CFLAGS, not from the fixture.
> > +     for sec in "$1" __mcount_loc; do
> > +             assert_input_section "$sec"
> > +     done
> >       run_diff
> >
> > -     # Extracted, and pointing at the function that was patched.
> > -     assert_section "$sec"
> > -     assert_reloc_sym "$sec" target
> >       assert_patched target
> > -
> > -     # Nothing belonging to the function that was not.
> >       assert_not_patched other
> > -     assert_no_reloc_sym "$sec" other
> > +
> > +     for sec in "$1" __mcount_loc; do
> > +             # Extracted, and pointing at the function that was patche=
d.
> > +             assert_section "$sec"
> > +             assert_reloc_sym "$sec" target
> > +
> > +             # Nothing belonging to the function that was not.
> > +             assert_no_reloc_sym "$sec" other
> > +     done
>
> Nitpick: it looks a little odd that the __mcount_loc special case was
> pushed inside the greater section loop (bug-tables, ex-table) so it runs
> twice AFAICT.  Would it be clearer to just pull this out as its own
> block?


Thanks for the review on these patches. I will put the __mcount_loc in
own block and send next version.
