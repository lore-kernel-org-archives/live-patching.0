Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A5392C39
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414303; cv=pass; b=AL+WFljlEg88XzvZwzY7CgfystiRXtwSPk35kHU3Lkp/3XlkkKW3X32wBIheNvffYmkNovmv1dS3/OozFljaH0DYrbQXZRU6PF7nznyYYuM0FeLsgh9EEAxPr6+rHg99h3oM41+5LN2SCARQ3J99iAVNVMRQZ0aWwqhmtiXp34o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414303; c=relaxed/simple;
	bh=JRv44yZS6TOdVsYL6aujlshIw0O5RRQ3A6sGzpvBLmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCgAvnTqc1VAKJQ81XnbOvu+kF79hoaQZNX3UtcZq2Spliq92RpfWVVTzBwyTgRfGup1Q61C0tUSOl+YAHxdfTr1JcE+XoBYAsTX67yd7s5W6E+6c0AnPZctHGut1XMjLva1eciWJwyBVuFVoPKZW0CQjnxstvdhUn6S43as0EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOGu/uuf; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOGu/uuf"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-86d43cdee51so17042307b3.2
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 22:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788414300; cv=none;
        d=google.com; s=arc-20260327;
        b=ogn1uIHEqrmsK+6FCrQbAerAHwcdntNpcHIMCJXjynpgRblsvfe3hIs17LESUdRZTF
         rJMoV48Ny3ny9rt3l/1fJxkn09vZQmLqZH7Ud41dm5trGt0zkHbbywkOL/1Wq4NFPAqR
         H9IaT0NaCtDojaYUbGBsy0PINncxEdUFpfAl+uWViCHTNnnptWpY1hVsjejwC8qQlhA6
         GXjCMd+GJIJyh4omyIsaO7uMX1mUnMtjSAkwqHq1bnBNdISGRPjCpqws0VP0wwu4fP2E
         nyNd140bZ0a9Jk2He6YAz4N0CnY2vUYInS1Dqe+qweawHr51N2KbzJ9gkiIl2i93l4F0
         849g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rs1GsUG2y0Py+N3to2ZLYFaN+nlXAvezgWONgJQViK0=;
        fh=0lmjpVTI7srXw/lG6O079retmJai8JZfiniJqiiGQFQ=;
        b=DZDWTUMbksnkUpe6KqJv5PQUaaaLWLx3XHY/Tyjb/WMIHWyz8fUHyyDh+00ocD+DB3
         xUXkWdKpWl5NtndfZuCaoCah6BqOvBgvUAiAkYrk3Wo6Nz1YfC6P2q4BAYgjjHxgdr00
         tpbq8Zy0gvQl6w00GEFTX/sjEt9JpDr7Q4928lzfxxL4JeEY6EX4O+QquEThiNHN+dBb
         es4Wo5GKo+EcUWogHtV6ZpO1aKWD5ay92GDnyn9uCqNMTQlJfC2MGgtsCskhX2A751pu
         YOYqZYOvhwGPP4KPb6aCS+lfk6lbvkqI/tUrzyQU7s8C2E95OppIaamwG2U8ZnlznMJq
         IuOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788414300; x=1789019100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rs1GsUG2y0Py+N3to2ZLYFaN+nlXAvezgWONgJQViK0=;
        b=EOGu/uuf1NBsiMhzkssuROsgXOU4yy49CaCjuS82vsYmgE8RtnMvudpsHulGL06h3C
         2SAAJ2weUc891sw22BEF0lughtC9hMa+MJtKVGy6Qq07qZakkB7In4tRfylPjI/D/G25
         OAgAnD3P48Wksqtw38MdwVLOgfPwp2CL/kOlJi4xsG6KbHooGxBKHWDeqR2x01J3kI1A
         48wOv3xTyr6wDwRzlSneGFm71QTW3v72pgRmoONFn9DbEwN2jh8Ud3E09Esz5X/nwjXr
         xAdgK3vBa57KHVUpxYVijloE0QfvSDraZnRBAfWv5Hak8ZfPs/LPnkY5hnCVCbtWiNjt
         ZJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788414300; x=1789019100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rs1GsUG2y0Py+N3to2ZLYFaN+nlXAvezgWONgJQViK0=;
        b=USdOBqF72HqWD+Le+sgN0mlDkUZ+4N+jervkhX9OPM95JrBEc+Bohw+BSbRgftLhEq
         DTUYxlIR/dfPuEkVX8ncd3i5PtD5JRdm3oPu5eRXbyxQ6bDjh332sQB3V2T87eQUMM5e
         KJPLvtnprti7KTgOmNT4TEg8E6QZQpOH+75vdCCWIQFIG+cYCbnlU1Jr3qyioF+rgrml
         gsb/DPFstIB7PKERz4gVrXLpjqmoNVR7xhaOiGkK1Nv11zM7GfAvUj8zgklv9OuRnB65
         RmgieKT/xEX8xPBfLtAyn8GjB+veYyerBaUacj79FzorIjPEw6I/cPZBzLhL7GQjKakO
         LbUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzim21fnZLEd4Xv9qML9MPvfDQuAZHa4pt7+HF+USr/ESBJOBGB3x5eZ0b1ej62RzsTaYIHdUng3WCoDUV9@vger.kernel.org
X-Gm-Message-State: AFuF++mY3FjzzoR9uGTQJ062OYHV0IbADwSEcKPtGlKLQFqUzseATwn6
	ZgatyJhMejNyAaxYbznqvcW/+NK4DOJcpGF7WtjbXO3YafnFF11qogtjEFq6VNAhwZ7WYTPnTlL
	cQbqD70tx4zLEx+gF/zJesr8TPWGk0WM=
X-Gm-Gg: AYBFou3MxmtizenQnjECdWtmNKtC83wXUcsPcPcyyEJl6IiBlkOROz61PhZN7cLy3uz
	s6NYcXvkqot/I4q6//3nLywL1F4p3I2SjFDeerieZrFKpSLXRgjSnwCxHZuPiXheAYrHgY54ehe
	2DYyP6qclPrxFZRW7B8r0upyhJLOYitoJXMgDvlXKEhi7Rs2GiHKqf3G3sUXVO2b75uFZBJ1sM1
	If4YyXSLsmLSgm0M5eIvYv2QzdZ3r08aPrR4FSQf8T08FjKrVor4rTYk7NlIkGIFtEa+qheLY/n
	pYJArnL3GJpwmRVjy11wjpCZBhaPeLmgjFmgx0pi0sjCiW1mqgsfM5De+uc8L/qiMrdFzM7Gr9b
	k5w==
X-Received: by 2002:a05:690c:580a:b0:864:7ad7:a2f9 with SMTP id
 00721157ae682-86c5454e9a4mr41867897b3.28.1788414300478; Wed, 02 Sep 2026
 22:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-8-laoar.shao@gmail.com>
 <apg_3dLUGBeCjKoM@pathway.suse.cz>
In-Reply-To: <apg_3dLUGBeCjKoM@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Sep 2026 13:44:24 +0800
X-Gm-Features: AcwNN1WWYu-kqnWMHTsDXpE09m3DOQ_ZmDncypAtHOMYtOJo35E1UEl2ApfJNyA
Message-ID: <CALOAHbB84_EzuP4W=rOsd15WjAAj=jdk1prs=iuDunUkJdcZkw@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 7/8] selftests/livepatch: Add test for state
 ID conflict across provides
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:25=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-08-25 19:46:40, Yafang Shao wrote:
> > Livepatches with different provides ids must not share the same state
> > id. If a second livepatch attempts to reuse a state id already
> > registered by a livepatch with a different provides id, the loading
> > will fail. However, if the second livepatch's obsoletes list includes
> > the first livepatch's provides id, the second livepatch replaces the
> > first one and may reuse the same state id.
> >
> > Add provides and obsoletes module parameters to test_klp_state.c and
> > test_klp_state2.c (guarded by #ifndef KLP_HAS_REPLACE) so that they
> > can be loaded with different provides ids and obsoletes ids.
> >
> > Add a "state id conflict across provides" test scenario to
> > test-provides.sh:
> >
> >   - Load test_klp_state with provides=3D1, which registers state ID 1.
> >   - Attempt to load test_klp_state2 with provides=3D2, which reuses the
> >     same state ID 1. The second livepatch is rejected because
> >     livepatches with different provides ids must not share the same
> >     state id.
> >   - Disable and unload the remaining livepatch.
> >
> > Add a "taking over system state via obsoletes" test scenario to
> > test-state.sh:
> >
> >   - Load test_klp_state with provides=3D10, which registers state ID 1.
> >   - Load test_klp_state2 with provides=3D20 obsoletes=3D10, which reuse=
s the
> >     same state ID 1. Although the provides ids differ, the second livep=
atch
> >     replaces the first one because its obsoletes list includes the firs=
t
> >     livepatch's provides id (10). The state is taken over successfully.
> >   - Unload the replaced livepatch, then disable and unload the second
> >     livepatch.
> >
> > Assisted-by: Comagic:DeepSeek-V4-Flash
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../livepatch/test-provides-obsoletes.sh      | 86 +++++++++++++++++++
> >  .../livepatch/test_modules/test_klp_state.c   |  9 ++
> >  .../livepatch/test_modules/test_klp_state2.c  | 19 ++++
> >  3 files changed, 114 insertions(+)
> >
> > diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.=
sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > index 2707457b9133..f9a9f9b28490 100755
> > --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> > @@ -6,6 +6,8 @@
> >
> >  MOD_ATOMIC=3Dtest_klp_atomic_replace
> >  MOD_LIVEPATCH=3Dtest_klp_livepatch
> > +MOD_STATE=3Dtest_klp_state
> > +MOD_STATE2=3Dtest_klp_state2
> >
> >  setup_config
> >
> > @@ -171,4 +173,88 @@ livepatch: '$MOD_ATOMIC': completing unpatching tr=
ansition
> >  livepatch: '$MOD_ATOMIC': unpatching complete
> >  % rmmod $MOD_ATOMIC"
> >
> > +# - load a livepatch with provides=3D1 that registers state ID 1
> > +# - try to load another livepatch with provides=3D2 that reuses the sa=
me
> > +#   state ID. The second one must be rejected because livepatches with
> > +#   different provides ids must not share the same state id.
> > +# - disable and unload the remaining livepatch
> > +
> > +start_test "state id conflict across provides"
> > +
> > +load_lp $MOD_STATE provides=3D1
> > +load_failing_mod $MOD_STATE2 provides=3D2
>
> It is not obvious why it should fail because we do not know the used
> state id. It might be better to define it via a parameter. It would
> even allow to test more variants:
>
> # same state, same provides
> load_lp $MOD_STATE_LP1 state=3D1 provides=3D1
> load_lp $MOD_STATE_LP2 state=3D1 provides=3D1
>
> # same state, misc provides
> load_lp $MOD_STATE_LP1 state=3D1 provides=3D1
> load_failing_mod $MOD_STATE_LP2 state=3D1 provides=3D2
>
> # same states, replaced by obsoletes
> load_lp $MOD_STATE_LP1 state=3D1 provides=3D1
> load_lp $MOD_STATE_LP2 state=3D1 provides=3D2 obsoletes=3D1
>
> # misc states, same provides
> load_lp $MOD_STATE_LP1 state=3D1 provides=3D1
> load_failing_mod $MOD_STATE_LP2 state=3D2 provides=3D1
>
> # misc states, misc provides
> load_lp $MOD_STATE_LP1 state=3D1 provides=3D1
> load_lp $MOD_STATE_LP2 state=3D2 provides=3D2

Makes sense.
I will update it.

--=20
Regards
Yafang
