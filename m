Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A53939B5
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197466; cv=pass; b=jeQtXlUP2cnOGD1ePtNpwG9K0f+2PdsLC5eIRp3zZFt12IaWtdwlUPqhjIZ0C61pQSJ8yuKXTPHh7855RRi49rJTBhez5f6NckIszlZ08glkmt/9fqchJAVQzQDOoRq/vFkgd2P/04+RxClB6zLL44Ttxh1+diomICDiVZ+QCsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197466; c=relaxed/simple;
	bh=LCNmfIsgVZY8PMqwXyI593C1PsnOWpF4v7dYL4uPHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH9iavkRc8bIU9+2mObvFpWu3pGAuonpqWNBh65HwU8ywjDwA5x12lO8wNCW2w8jKtJqB9Ba1aG5TcfAxpAKmCyHeP+ps7POTlMENTLDF2BJH6FGiNTH+sParCZUg8QE0RRf3yQWmcARwnweOOcobcXzs0uxShkTUKkx1Yq2guk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+bKTiFu; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+bKTiFu"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8041a8fd711so8750337b3.1
        for <live-patching@vger.kernel.org>; Mon, 22 Jun 2026 23:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782197464; cv=none;
        d=google.com; s=arc-20260327;
        b=Dn6i84Qk3BqW7wH2cLOwlnsXtb242f+diMzliBt4KgeEku2SPKCqjNmeRKce3Ab5mw
         +8AniG1wdbi2xEJkXsHEBz42tVJOPqpsi+xc4n+/T+XIAt4lXu1AW6vZdjAdR+A2OD5S
         uoNioehHgudf0++kUhCocv/U7Wl6CuZpRuALoYRUpKf/nLRRuQz7ZVySjUoyVC8s04mF
         uftE0a88lhmpcA93HTrW2+5KlaXaXww6XEOOXIDbjB71ikxJ1WPY9RuZw87jSHBY+9wY
         sLRAH1O0nMjTIc9ss34KoS/aZ0Q1AXE/DdAvYutR6oUQ8/xxFGeFWWnS+OmhmU0GeWKX
         BEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxgzI7nPM4nGOmRX3r88FHPBgyo4U59f5DqDXZyfMLg=;
        fh=7GCLtG7WWja+bUBrrAcP8FTk7GjYVEmvaxQfwAM6yKQ=;
        b=ASgwdMVopcL5j47ZlgZku81FTHrckgcUy3RdsbBmug52B1x3+Hv9mG3uQMYeqUXoLr
         DmwsMb9g2QJjb6EsFZTqtLFQ8aEi/QblpRMtKMwrJtLhnCAt6qX9XWVPlvdSw7pGO8mu
         OEZtZ97Wxa+sYZm9OXsBjdNhYKyE/i+P3EsyUgLZvosBcWGGWmt/ITjJRtNMMNB1hQdX
         89KQyuukOeff6ou3CUPkHupBdgoEyIxjE6Q/wXoJBVnZOy2CfzWwZP+1UPw7Qh/D9LXj
         gmJ+W6mtKFc4tu41uw+UuYiSQU/mrc+J6l1ADtA/aIZmonsVYOb10cHpOslNc7Fyx0nd
         /9bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782197464; x=1782802264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxgzI7nPM4nGOmRX3r88FHPBgyo4U59f5DqDXZyfMLg=;
        b=O+bKTiFu6IHwYTPULdUrtVV4jzMXCbi6tpAYFXFSFSCgwOMPGlr6YXCimM/+UmcdGF
         4tRxON+HYlOQx4NkGVShp29sfYecdcpBupGNhrt6MdwnamKdGoD2EUd8VwOYLeIsHw4J
         7dFlvDR1rAGJ01glQVNUzOhA4p4k4WmEwosowCSizlyRsqzGmnJ/gLjXVJNiX0KmcSHX
         /kfBaBJX3Kr4VqADETUtSGWvanfoiQT+tfkTWcEEBSBzjtc8TKkfHITOGi5cahjLDKAt
         JM7Wl7/bSXn4/kZYSmQTl3Cl23/c0DxvXAXkOytpOO+JN++ZDrzIKiXm6fAR09/ptyeb
         NERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782197464; x=1782802264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxgzI7nPM4nGOmRX3r88FHPBgyo4U59f5DqDXZyfMLg=;
        b=kghKmCub8lMlOiPulJj5C8FJYJf/Mlziu9JZYBSDRM3Jr9TggC8G/rr9yemh4AMY+b
         bMiCVxx3rAYxjkfV1RkY3R8wtjZwYmM8vCtzctXW7Z329y4Vvdjn+9hVqjNX/ewZ4dj6
         aWy2Sv+asG8jDzVi9egKX/hPLP3y4Tn7nwGiSXoXKdDeFdk6TpCzf9r30V++A4IRzoxJ
         9qz7+O1EUa6RO5fcNy1rF/HCmXW/0LY9I2DBSwdw0teHClVZQEoYx0bdRgtVKAPDrQbW
         q8l2HXHDuLD/OZ6Ue6uOhaIDiulz4/qmXioKomUxd8gQtjQAqL52ds/xpthtbMwl3qSo
         INMw==
X-Forwarded-Encrypted: i=1; AHgh+RoesOisK0jdIPFqx+8FI0vYxZYQGBRD3m8BQx8FaEI8u2ND/nYL+pgfh0WlxYM1sPbLHH7jMf/T7NLbGMbt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52fSLWmhPz8RyFAnjfsMNzPPXDupHPSw6sOOZtctBO/ZX+vPs
	fBZvE4b2Y0sMCie9YG8xT4zEnoiGATkXZXTKXSWiGVuvDYvTgpxyqljB8PVclEFKZA/KiOztBWq
	OY10e3KrCYfs8aFHGRFnD8BnyJNVH84Y=
X-Gm-Gg: AfdE7cmENHdgylQ2wKqw34QTZ1dtrchzRCDX/gRMdx2Dgob4aTd4BkZL/4VG+DDVZIR
	EK1RUgBGBzx8jqXbUl/bRJphcicVhnN5X2P+jVRXPsZxRjbgOOeIIotKD5DNzyKeeBaPbD3RzyE
	BsbuOyLezrAOicvPDO+/vLxbmuDWmvPcwEOPOqkABRIoqRGvQXh7jF1A/znB6w66glrVHuC2V0J
	TnDv1MHTQM+ttUVDwioSbbmmemkxa53XUEdfHjPWZ47gZUpbjPltcb0Oy9U883E7Mlf8aPE9o6j
	PSp6jeT/af6cdpkLlI0N7KbYEm8fkg==
X-Received: by 2002:a05:690c:ec2:b0:7b6:7df9:33f6 with SMTP id
 00721157ae682-80670e47f1dmr30232327b3.2.1782197464354; Mon, 22 Jun 2026
 23:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-2-laoar.shao@gmail.com>
 <aigUttsudeR9ps0p@pathway.suse.cz> <178213807628.22518.1917005991720893454.b4-reply@b4>
In-Reply-To: <178213807628.22518.1917005991720893454.b4-reply@b4>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 23 Jun 2026 14:50:26 +0800
X-Gm-Features: AVVi8CeiiKJncI8YouriHFHQ5XX-pJ0ZHLNdzkzSmv4AOKpwHHfEAd5Z50mtyhs
Message-ID: <CALOAHbAVZtmqHUpixhBx2295+cQUFGjW3cD_2o4H4eAvYpdOOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in klp_find_func()
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:21=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wr=
ote:
>
> On 2026-06-09 15:27:18+02:00, Petr Mladek wrote:
> > On Sun 2026-06-07 21:16:53, Yafang Shao wrote:
> >
> > > If a newly loaded livepatch provides a function entry with a NULL old=
_name,
> > > func->old_name will be NULL when evaluated in strcmp():
> > >
> > > klp_init_patch()
> > >     klp_add_nops()
> > >         klp_find_func()
> > >             strcmp(old_func->old_name, func->old_name)
> > >
> > > --- a/kernel/livepatch/core.c
> > > +++ b/kernel/livepatch/core.c
> > > @@ -92,7 +92,7 @@ static struct klp_func *klp_find_func(struct klp_ob=
ject *obj,
> > >              * Besides identical old_sympos, also consider old_sympos
> > >              * of 0 and 1 are identical.
> > >              */
> > > -           if ((strcmp(old_func->old_name, func->old_name) =3D=3D 0)=
 &&
> > > +           if ((func->old_name && strcmp(old_func->old_name, func->o=
ld_name) =3D=3D 0) &&
> >
> > I do not have a good feeling about this solution because it quietly
> > ignores a problem. As a result, klp_add_object_nops() would
> > call klp_alloc_func_nop() even though it does not make much sense.
> >
> > A livepatch where any func->oldname is not defined should get
> > rejected. It will actually happen but _later_ in:
> >
> >   + klp_init_patch()
> >     + klp_init_object()
> >       + klp_init_func()
> >
> > I see three better possibilities.
> >
> > 1. We could move/add the sanity checks into klp_init_patch_early()
> >    and return broken livepatches earlier.
> >
> > 2. We could move/add the sanity check into a new klp_check_patch()
> >    which will be called even before klp_init_patch_early().
> >
> > 3. We could allow klp_find_func() to return ERR_PTR(-EINVAL).
> >    klp_add_object_nops() should then return the error as well.
>
> If you change it to do so.
>
> > My preference:
> >
> > I would do the 3rd variant because it is much easier than
> > adding/moving all consistency checks between klp_init_*() and
> > klp_init_*_early() or klp_check_*() functions.
>
> Interesting issue. If I remember correctly, klp_init_*() path is meant
> for the initial checking originally (among others). That is why
> klp_init_func() has it right at the beginning. It got a lot complicated
> later. We introduced atomic replace feature which added klp_add_nops()
> and is called earlier. Then there was the kobject issue which introduced
> early init path. Both forgot about the check and that is what we have
> now. I would prefer it to fix cleanly. klp_init_patch_early() is not
> enough because klp_is_patch_compatible() is called even earlier. So your
> option 2 sounds best to me. On the other hand, it might be difficult to
> disentangle it all.
>
> Anyway, could you send the fix separately since it is an existing issue,
> please?

Does the following change look good to you ?

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..317a3c866c76 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -799,9 +799,6 @@ void klp_free_replaced_patches_async(struct
klp_patch *new_patch)

 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
-       if (!func->old_name)
-               return -EINVAL;
-
        /*
         * NOPs get the address later. The patched module must be loaded,
         * see klp_init_object_loaded().
@@ -1107,8 +1104,9 @@ static int __klp_enable_patch(struct klp_patch *patch=
)
  */
 int klp_enable_patch(struct klp_patch *patch)
 {
-       int ret;
        struct klp_object *obj;
+       struct klp_func *func;
+       int ret;

        if (!patch || !patch->mod || !patch->objs)
                return -EINVAL;
@@ -1116,9 +1114,12 @@ int klp_enable_patch(struct klp_patch *patch)
        klp_for_each_object_static(patch, obj) {
                if (!obj->funcs)
                        return -EINVAL;
+               klp_for_each_func_static(obj, func) {
+                       if (!func->old_name)
+                               return -EINVAL;
+               }
        }

-
        if (!is_livepatch_module(patch->mod)) {
                pr_err("module %s is not marked as a livepatch module\n",
                       patch->mod->name);

--=20
Regards
Yafang
