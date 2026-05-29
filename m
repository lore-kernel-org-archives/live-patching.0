Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E938C2DE
	for <live-patching@vger.kernel.org>; Fri, 29 May 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046049; cv=pass; b=E9bRb+CAURtqwafPTWAFzjorecznoTgbNRbQQcKlSi/ISudaw9Tw3bEbtiir2XZmIvjbgeurid9dVIvvhYGHHEJbsEWbuRlbYSjg8qkrglhHofkdCTEjbT7BoOcHLIrLgpo/Dl1rH9HQ00ys7tpPUBKx5tcD+qfvJQPiljdqT2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046049; c=relaxed/simple;
	bh=UkkTEUlMTHOynzs2J8K6m027MEI5I4/ej3CDloGm6K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZmc68cR/QLKWPsm5VYjajRTn9h4BJNdwU9AV96vgSEaqVmOdMzr2mrzKxNYOAnp0hv6CeEr4S4WO3YYiL5N+omWQsBSBrzhyzm8MRaWA4On+IDF1q6TFzlzuAoi6awz64lXYHN1Kuf+2XFbz1NFcVBZYk9Z3ArONa4j7wCxdMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKu6xnA1; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKu6xnA1"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so141561477b3.2
        for <live-patching@vger.kernel.org>; Fri, 29 May 2026 02:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780046047; cv=none;
        d=google.com; s=arc-20240605;
        b=VNF56Z3+y/iB/dgDrfGqdjfjyCLmVU1cRQMh/AZ8DMNWdlD77SEYbXrYC4UE4cSD7+
         Dsl7vTiy7M4ckMoDfYoQNd02DOkoF28Wb6KLtMwxefFYEzKn3Apilk7FA5EKaWySabTi
         DgGOUyGB9xesyPQEakjBGRvduOdiLBGETxfoYEgSdF8rEjaHCLuB7CUYrN/prWQFVmKK
         JGL4aphIG438XJAomYCZh+lc/OIxOGf/CxAC24mKs7o66qFfgnAOWhylVuZu+za0bvr0
         gEiD3w4tcJlIJlC9zxjB4wG9CZWAr4JlJivK5R4+ZSXmlubvxoIZbEVq3QvjCne4hT5b
         f8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KgioJfiSLQsHNHryEgZJ3KiprT6RmzRs4G29o8NwBLM=;
        fh=tmm/IJeWZ4WvxMb33Oc3lnjh8pltnumjem5Y3W/psOU=;
        b=fblAWpGSnTYkWkwZ3Cqztg0lmDS9/1G19hiEA4wKUe3U+xymvdikq8yRY18aMwtsdG
         qtP469eBc5Srd6S0OGWvnjg+2PdisReYYL14GLoOijEPrYbH3HaAInptpj4DfMJ2mBpZ
         SKb28gAJ8l9UzMsZDoCRJot9P2VyRvSitx6dAxe4qMZyvKtBlFWmZIEm2JwnckwnEFcH
         VUcSL03FoSxCifW5cpjbKny+lQEh40qIygW4y/6gcAmM75+qafJEmjvepq9KHNOkgWxA
         3e6FWYhIIt1eTZN7YFEAgKotPNl1bS0jd+k764nI/a50s/wHU6C5WuW349KsY1kM2ll+
         BOdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780046047; x=1780650847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgioJfiSLQsHNHryEgZJ3KiprT6RmzRs4G29o8NwBLM=;
        b=EKu6xnA19R0Fa5neB0yL+SvOYWntki8Q5TR+rtnFIQRuu9ku2+yxDvGKf+Rh8Mj7ol
         MbZgMzgDOT0gK/URRv9QCXvvE16NbWwT0IvN2yqDXiQBWhhdoiSnQ/1TWkncqD3ZKw3+
         9gGIdT+HYSE+DD6Psm7I9VM14RR2oCJ4ONHhH0Y9a5oFgKp2SykNXaYe6f8AaolMZ/Oe
         RVQXM1iVxc7EyNx0IZWlPLE7hWEFjx/m9XxX/OyeMALYWzyX+Fox03rTp+9ko2MSF9A/
         C97xaIisDm/JA1RsDcmEblmTds1RZDn+eYE3SbP27CVKzdYS1kLNVv8FrIA2FmG3+GQc
         Brww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780046047; x=1780650847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgioJfiSLQsHNHryEgZJ3KiprT6RmzRs4G29o8NwBLM=;
        b=jSdNyGd12bJn57qgaLUMDX1+5Wc7AwOZ5FaXp9wG4VYWpo1ardnbfdthwJAyXbxy+C
         jH/KO3WBEJ+ny+joG+iyUo1yi6LKkdeL7LFEglKmaKE1p9G3djlJMHPbv9GY3LQU/piH
         HnsFyhMg3zwu3xQ1O1ZYsz70mhvKjNeoIFI+DqGMA4WOGCPidJ+l1oIXoKzxPiVRvGnT
         3Cwwfp1X1Ja79nF8r/H+In8CC0kfpzhZMHeec19zIfwoUTX00jDkdrhsMFmdcIiu2N0/
         qGdSjBsVxE3j4M8Sda8txAPUpJFzECgL+nivDqJjvTuxC+cVlliNDyXxr9oMpuJatBlQ
         bARg==
X-Forwarded-Encrypted: i=1; AFNElJ8KktLfiQuMPmXEHmFNXeonSGU7lJkq+CksjCgL5OBM17scaa4l5EGB5nHmIO9KVea3b8RmgKv3TqqoO6SU@vger.kernel.org
X-Gm-Message-State: AOJu0YzppmPCXCNLPGnEZGBw3lt/WHbpaHw2ohKq1gRDilfnhCXPr9F7
	15oT3aIu9Oc6f90oMD+NU34MoEEZx+EbxFw1qp+j/Y8cxYEXCwHq5wcnDgoOHGs9bFekcktNsmz
	Pv6pPbQV0R8EzKNPsT3bXvV7fy4N4qWk=
X-Gm-Gg: Acq92OFJUxuKCZ/YnK/MUkBl8s/SYdLGFWuO5n08lcRrdk1IZkbyMLefbCBGkWSHrQX
	YWjpzxmkdyPr0mvsqzyeLgrSvzk1dzs91PMZXQV5qTZlRzgKnlrGtk27kvC7AwnMPG3EC3kitng
	gv8bM67slS3Q03+k2NRxmOvli0rEjeDGwZluBXnZAx6YZHDZPxbofDsQHrz/S9czjkE27dKpUiw
	W6c5ox1yQUP0xa1KXeC3Q+nI8SAJLLyzmdvyYrGrof014pDTE8uJTl8GC+g04Kolb9xl8qDcBJt
	xY9u8t04DRwZAnYUyFYuPoFKXHrTu/aPZtt7qsdUSyhPAaWyfLEPZHY2r2jO
X-Received: by 2002:a05:690c:e361:b0:7d4:3090:f0b with SMTP id
 00721157ae682-7de4de08415mr14916817b3.49.1780046047004; Fri, 29 May 2026
 02:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529034542.68766-4-laoar.shao@gmail.com> <20260529045446.B22791F00893@smtp.kernel.org>
In-Reply-To: <20260529045446.B22791F00893@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 May 2026 17:13:30 +0800
X-Gm-Features: AVHnY4LCHaX_DNeP5KxXiVz7TX4bzbxuMHGIc8uMzprngzO3bgJFK_d57-n2_DE
Message-ID: <CALOAHbBGUkK+LnVy8236kje275LD43qoMRAKBgevzUnBGByiHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] livepatch: deprecate stack_order
To: sashiko-reviews@lists.linux.dev
Cc: song@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The commit entirely removes the `stack_order` sysfs attribut=
e while only marking it as `<deprecated>` in the ABI documentation, causing=
 immediate backwards compatibility breakage and contradicting documentation=
 guidelines.
> --
>
> commit 041b2dbba1a7397626104dd773fc1f37228d382c
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: deprecate stack_order
>
> This commit deprecates the stack_order sysfs attribute for atomic-replace
> livepatches, since a single function can only be modified by a unique
> replace_set.
>
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documen=
tation/ABI/testing/sysfs-kernel-livepatch
> > index 6d75235a6a2e4..fddad93dba797 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> > +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> > @@ -62,6 +62,7 @@ Description:
> >               are applied to the system. If multiple live patches modif=
y the same
> >               function, the implementation with the biggest 'stack_orde=
r' number
> >               is used, unless a transition is currently in progress.
> > +             <deprecated>
>
> [ ... ]
>
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 969fea2a92631..6d65f839f4420 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> [ ... ]
> > @@ -457,38 +456,15 @@ static ssize_t replace_set_show(struct kobject *k=
obj,
> >       return sysfs_emit(buf, "%u\n", patch->replace_set);
> >  }
> >
> > -static ssize_t stack_order_show(struct kobject *kobj,
> > -                             struct kobj_attribute *attr, char *buf)
> > -{
> > -     struct klp_patch *patch, *this_patch;
> > -     int stack_order =3D 0;
> > -
> > -     this_patch =3D container_of(kobj, struct klp_patch, kobj);
> > -
> > -     mutex_lock(&klp_mutex);
> > -
> > -     klp_for_each_patch(patch) {
> > -             stack_order++;
> > -             if (patch =3D=3D this_patch)
> > -                     break;
> > -     }
> > -
> > -     mutex_unlock(&klp_mutex);
> > -
> > -     return sysfs_emit(buf, "%d\n", stack_order);
> > -}
> > -
> >  static struct kobj_attribute enabled_kobj_attr =3D __ATTR_RW(enabled);
> >  static struct kobj_attribute transition_kobj_attr =3D __ATTR_RO(transi=
tion);
> >  static struct kobj_attribute force_kobj_attr =3D __ATTR_WO(force);
> >  static struct kobj_attribute replace_set_kobj_attr =3D __ATTR_RO(repla=
ce_set);
> > -static struct kobj_attribute stack_order_kobj_attr =3D __ATTR_RO(stack=
_order);
> >  static struct attribute *klp_patch_attrs[] =3D {
> >       &enabled_kobj_attr.attr,
> >       &transition_kobj_attr.attr,
> >       &force_kobj_attr.attr,
> >       &replace_set_kobj_attr.attr,
> > -     &stack_order_kobj_attr.attr,
> >       NULL
> >  };
>
> [Severity: Critical]
> The commit message and documentation state that the stack_order attribute
> is being deprecated, but this code completely removes the attribute. Does
> this abruptly break ABI compatibility for userspace tools that expect thi=
s
> sysfs file to exist?
>
> Normally, deprecating an interface requires keeping it around for a
> transition period (perhaps returning a dummy value) rather than deleting
> it immediately. Also, if it were actually removed, shouldn't the ABI
> documentation be moved to the removed/ directory instead of just appendin=
g
> <deprecated> to the existing entry?

I will wait for the feedback from the maintainers.

--=20
Regards
Yafang
