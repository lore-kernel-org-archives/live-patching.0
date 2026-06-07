Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC8380FF4
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840897; cv=pass; b=AFMWnrp7gCnBVyCwnLVMR9pqZQq6abNCy4xtlxw65Z1CKLaLYJcDDVq+f6zclKpmxHb+ezI/eHxvvO6aJPsG2ljLMW6m6/OxOLHjfG5TiplyeeBdgGWPKy5xmX8yDhGa1mDiQYnCbHTpOllZ7Yex9DH/RX0XAGEIPrwLbM75sxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840897; c=relaxed/simple;
	bh=qrLeuvCFzR2hQ3pzCF50zMqJUsKk3LsT/QApP1Cp3uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO+Ntm+Dbi+fXR/ShQUwuN5uQmJban6uVpeeZPq/nYgafd2xtm3IJ3rTyH3MamtVfkrZrdwxKnDb9AHOK64x46SGg1THSPiXnEiUHNWVmabcjkjS1H61KjDo8D/bZGeFvOk5Tseq+8oo198QZZgLkcGAjsTkfbVPwUiAcmaXA5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFxBXJ2h; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFxBXJ2h"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e2fd65f968so29980147b3.3
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 07:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780840896; cv=none;
        d=google.com; s=arc-20240605;
        b=XWV9u3Ajcyvl5GdeYA6ggLeWBH87cV4V+1gEqCJcp3Pd1tuzIX8VKj0swOXlwbzc8g
         R5I+MRWxBaxeu5zASiuHFxl6hgmq4ddURrKcWmXBri2GkDZ1OgOlSjb25130Hxohzi45
         gjchECQvnjj/YThNajhLAwbor8FgzgtQOi7WODgYSgGOWvX/cWr5JHczNDHhteXMrd9j
         HGer49HmhgCgi2eEo2vg55UZJugEWVY4sggqCzsgJUCG/NYtQxjRleqz/RprExGKc1Ox
         739gzyiOGDzdHJhc8172gQ5phKOkQdxcsGkSldLIrI+r3OKwxIVnwT4Imnj6h7IkJ+LY
         M/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4pYahT0z4LacNeBL11VjXkln5kCP+7BgtEQcumXBxMc=;
        fh=89/V92+xw+yxnTZGl9bM2c1R4KKxDC9vXkyuATYEU1k=;
        b=e07UqUFy+P7QGi/E1qiS+3T8/4D3QR4Bx+MOD6QDrijbRVMWKww0U5Sk+E/fCJ6JAl
         P6/P5SYia82zJunyyi5VOBEMnv/f8rR0UHoxdyt2LIgBgJB1uvCCoGr2RtjfVQSgVBJ7
         72RxEUi0oQdoZkMKuKM9aodWv/n7QQvfrI+0Z2jrWJm6dKlBuUnT3by8GHX7qLnupSK3
         J69O02KB+D9ZnSAP6HozVgo3dBr2qoKPT55e50OqEMv2keHNtGvwPA3lW7lQBhpISmbg
         Yq2iiaYDDME1p6dWln22UXk0lRW0KA8ghtPYytVNJpzrDoVvbI+itWFz/1ckWmjtUJCP
         1TJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780840896; x=1781445696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pYahT0z4LacNeBL11VjXkln5kCP+7BgtEQcumXBxMc=;
        b=gFxBXJ2hJzlNBlAaPkE/2P403HP/pTC1JApBFivr4vCDWvTtME5E/PoNyZLUEIGOPY
         r8XL0YSdEjMsp1Vbsnlsa0jYj9yGlj+RiyvRBtZmIkvuKjzaIkBOL1oHsIjnL2XoCziP
         E+92CIlxeAHzVrXqWfAT/E1Ncm4A3W+WYQjveYV6y9xao9ksD0TaPobuwBpvjgCKbZZ/
         e4btrvZYxvudDI24fYUQZJcuBpwXCtvqVjv7fmy4U4Pi1o0wshtypi9qqoedMSWG/G3Y
         Pho3hFy6+yOmPXP6XLQ8xcWKsnX/Kvwi27zuwX7IGBDVpMzJHDcJIS0ITutc7gyzZZFD
         8yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780840896; x=1781445696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pYahT0z4LacNeBL11VjXkln5kCP+7BgtEQcumXBxMc=;
        b=Sf7sxQOiiMXel055u+XYg0aNYgtfRXmdLAyhJfEg9fSHKFqJ7GHpYI5OyHGXgvnZt0
         /dai4o89R523PSB+zjtMkNXhwqogfFmVzZRpGQAEP0IkBntAqh/dmflE5RwHQzjBPoZ/
         H++3vXoan7HMMC6jGHiRmSqeGOOYY4AIFhScK5ikwIUPMRSgpycLlxr6YlsZlYhV0vV1
         54GWxw/6E/NZJu+MVDxsOt/JMFeY5ghS5oeTIGAKCJLlMGxyPbD/y2W30WWo1XU3v/2c
         cRsCbHJVYwMIZ6jWducxeE5LeSVjZyYsYoJBmuK8x69lob8p72uyyWRK4vpeBhxyrOGH
         vtCw==
X-Forwarded-Encrypted: i=1; AFNElJ/Afr3z/bZvMNKtcOcqjd7ZbmrRz331iUnTLBJAlqwDqEFD1RqdBKJ2edTkWHnnqlKbgxb7tl/LKhECFx7L@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKpYIR2YodDgaXBbWJcOuMVyh98v8BmEnGj81bzzcvFkmaQZf
	Rno2G9RW6LsMmARMqrmikeKi0QN6TPniraqbsghIqkDctp6yy/b92T5PvZgwUeWegCo8/b6JYpJ
	hXGl3cvb2CZh307rmygRF3ktQCWnXSR0=
X-Gm-Gg: Acq92OHkqqkcChG/RO8iU1MpMb+nghJq8lkY6V8CcB/Qa6nnef8CFSsEtnKhsIuohr1
	094dKhDMeJ4teY/EwshY4EWrJKY9d7S2wPZa5OVs0KpotawHAD3AoxbbkSCNPKS3KnTH65nN0dK
	ciTKvxFb3OJObLy4+IWwOLt5ug72CG0/BGDlwc1ksN2SaNSqYxt+GPkpUv+zsCponkiYB30NMZd
	g6J4sg0be8Ost8ZZ+ZvnQUQH4SGjfvnO0mTX7ffwTwJVKcvrWu30TIl4s/t/PCficekfJyd7nWq
	lUNi2ve8lycJ6Pbi7o9NvVH495wM2KPqbZtks75ppO3aekybC7U=
X-Received: by 2002:a05:690c:680d:b0:7db:ba77:899e with SMTP id
 00721157ae682-7ed073f1754mr108786337b3.0.1780840895541; Sun, 07 Jun 2026
 07:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-4-laoar.shao@gmail.com> <20260607133313.EE8A21F00893@smtp.kernel.org>
In-Reply-To: <20260607133313.EE8A21F00893@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 7 Jun 2026 22:00:58 +0800
X-Gm-Features: AVVi8Cc1Jb25xR84tgMeD3ll20m9cTzarLFALGHcOZ6Z6rB1gi3jfSeZRfbeJl0
Message-ID: <CALOAHbDBVtkTfoK8Sv5mYj-Kq2e9QVe3uKAB-_pjYqb=8HH3Rg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: sashiko-reviews@lists.linux.dev
Cc: joe.lawrence@redhat.com, mbenes@suse.cz, jikos@kernel.org, song@kernel.org, 
	jpoimboe@kernel.org, pmladek@suse.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 9:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The newly introduced check in `klp_is_patch_compatible` causes a=
 kernel panic if a livepatch module contains a `klp_func` entry with `old_n=
ame =3D=3D NULL`.
> --
>
> commit ed678e88294b650a730cda1a47351fce99677c1e
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Support scoped atomic replace using replace_set
>
> Convert the replace attribute from a boolean to a u32 to function as a
> "replace set." A newly loaded livepatch will now atomically replace any
> existing patch belonging to the same set.
>
> Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 =
[0]
>
> [ ... ]
> > --- a/kernel/livepatch/state.c
> > +++ b/kernel/livepatch/state.c
> [ ... ]
> > +             /*
> > +              * Refuse loading a livepatch which would want to modify =
a
> > +              * function which is already livepatched with the livepat=
ch
> > +              * with another "replace_set".
> > +              */
> > +             klp_for_each_object_static(patch, obj) {
> > +                     klp_for_each_object(old_patch, old_obj) {
> > +                             if (!!obj->name !=3D !!old_obj->name)
> > +                                     continue;
> > +                             if (obj->name && strcmp(obj->name, old_ob=
j->name))
> > +                                     continue;
> > +                             klp_for_each_func_static(obj, func) {
> > +                                     if (klp_find_func(old_obj, func))
> > +                                             return false;
> > +                             }
> > +                     }
> > +             }
> >       }
>
> [Severity: High]
> Can passing an unvalidated function to klp_find_func() cause a NULL point=
er
> dereference here?
>
> If a new livepatch module is loaded with an improperly initialized klp_fu=
nc
> array (e.g., accidentally missing old_name but providing new_func),
> klp_for_each_func_static() will still process it because structural
> validation in klp_init_patch() hasn't occurred yet at this point in the
> loading process.
>
> When this unvalidated func is passed as the second argument to
> klp_find_func(old_obj, func), the roles inside klp_find_func() are revers=
ed
> from its usual context. The old_func parameter represents the new patch's
> unvalidated function, while the local func iterator represents the
> already-installed patch.
>
> Inside klp_find_func(), the check evaluates:
>
>     if ((func->old_name && strcmp(old_func->old_name, func->old_name) =3D=
=3D 0)
>
> Since the installed patch's func->old_name is guaranteed to be non-NULL,
> strcmp() will be called with old_func->old_name. If old_func->old_name is
> NULL, does this turn what would normally be a graceful -EINVAL module
> rejection into a system crash?

Oops, I missed that. It seems we should better check both func->name
and old_func->name in patch #1.

--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -82,20 +82,22 @@ static bool klp_initialized(void)
        return !!klp_root_kobj;
 }

+/* Check if @func is present in @obj */
 static struct klp_func *klp_find_func(struct klp_object *obj,
-                                     struct klp_func *old_func)
+                                     struct klp_func *func)
 {
-       struct klp_func *func;
+       struct klp_func *obj_func;

-       klp_for_each_func(obj, func) {
+       klp_for_each_func(obj, obj_func) {
                /*
                 * Besides identical old_sympos, also consider old_sympos
                 * of 0 and 1 are identical.
                 */
-               if ((strcmp(old_func->old_name, func->old_name) =3D=3D 0) &=
&
-                   ((old_func->old_sympos =3D=3D func->old_sympos) ||
-                    (old_func->old_sympos =3D=3D 0 && func->old_sympos =3D=
=3D 1) ||
-                    (old_func->old_sympos =3D=3D 1 && func->old_sympos =3D=
=3D 0))) {
+               if ((obj_func->old_name && func->old_name &&
+                    strcmp(obj_func->old_name, func->old_name) =3D=3D 0) &=
&
+                   ((obj_func->old_sympos =3D=3D func->old_sympos) ||
+                    (obj_func->old_sympos =3D=3D 0 && func->old_sympos =3D=
=3D 1) ||
+                    (obj_func->old_sympos =3D=3D 1 && func->old_sympos =3D=
=3D 0))) {
                        return func;
                }
        }

--=20
Regards
Yafang
