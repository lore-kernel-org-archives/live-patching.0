Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792648069;
	b=HmvjY7xZWMrmtvIlZanqD/zHDo1rspbRQLmwt2Jv3vlyp3rekJeAA1QOBSsddvwFJNDG
	 Yjaq5bvh4MT2PJAtstnsoezwbh1KHCuE3qaPFWl0FAw7LTUFCk1rt9xk7sfTz84V8Xa65
	 re0rdoyIpkMerWHgrRj4l/6u3wBCuqAwBiAhYhOK/5PW1Xa9JUcUd1dXLEtdHeVG1z/Bd
	 Gxc4tzi1iGSmSJ5lpTamJan1eXrDpHOQzvoNeVd0Ag4HfrrlMRAb4LUk/CKnagrC54A6d
	 7gdyM9Sd9JpJn8mNQmMw34vmrM7uZqNq5r0ZxOWBsrDZimePKmogrv8R9HNr353Kwjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=X5pXj4eRir2CjK6OhvR45YFhB3gNNXH7ANQQF/7yCpU=;
	b=sciC4a+9SzooFGBYWO18aPkb8sWX8PcvmNEF9TBpK2sPWTRISbhWuEEuSwbJcPZXQ+ML
	 GK/Dvoecad9bbAKU6X5i8CmkcZLTOSynlumMfS/HU1QzqXVBqOgd9vD89H9lirk+tiH02
	 Fd+qRHQBu2nAnuwZk2iAlEMG24MLzRhKYUrOyAMuDoONavYLka/SlejOWd7eB1/UKbCdw
	 QupSCzkcaxjFW51sAbSbA8QCh23LEFgmfWe+vEuA83T9iMF6t9YpQCVsUBCngq9ypudN9
	 tiyqv2CdSNm4HKiIWg9v5A1MzueqSqK+6kJrEKMc62ojuTLG99aL5VZQ+7XmSEVxaaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PjOlT7Kv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD4606A319
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 05:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94DD4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PjOlT7Kv
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1445338d50.1
        for <live-patching@vger.kernel.org>; Wed, 21 Oct 2026 22:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792648067; cv=none;
        d=google.com; s=arc-20260327;
        b=ehGTTQdz1aagD964PrtScIv9SodLD1V4dX/ZMZjgdqAwnJMGp2LRiYxKF8qX+iJLjR
         Vc4iXPPYTV1dtn3dMRwQcuqCmyiQgV/SkdSKz9FDvCVVGSf9VkK7IDD/gzd1z77T8nYE
         LIswY0wtbdXsQzyhYdmsOD3bS7YcCKNoaFY/Fal014SNAgRIDyKTiL3OSe0ZduBixuyk
         2jOnAN3TTsYflQC8Y3AHBqrgYt6qYsMBUqoFWRH/poLXhNxXjZ99erkgJSIK1KqwuRwB
         j3byBSJA3iWrCqkPhn+pYA+ayyXQo1jBQTqcrTVbvJ1rrpR7/2E6MnVBzD4b70OIxavY
         xaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X5pXj4eRir2CjK6OhvR45YFhB3gNNXH7ANQQF/7yCpU=;
        fh=rSA7YJqZsq79tO/+4Io6nHxiM6oNj+Zgra6A3Ob6xCM=;
        b=g/MCbAQqWxaI6sUzds/q8+vIOmUCXWXsdWAqrSVVWCi+j33vFV4NIrswtBbkYxLw1e
         YRsm8KEdPVjX5bgJaKADo7OWIlRc4Sq40Cg1aKLUQN0AI7y1Cibhu2K9VhAwD8VL3rtu
         hgiD9HfGzVoNJgAsVijN8Bn20nmvqVQQup3TELm4ccLfLgsUGdNMaeLzXd+LtED1S+Bt
         yUIPBBwri/a70ro+DWdOOtd+XypR8F4vaWlG2guSJowaxMVRXjX80Vu9ewKJ3sEZqgNW
         IhdJMUMddkH/nlEjmSZelDp7xhMNIF+i84Yctrdp/pKPwIqcfh8tyEAngsSRn7K66ivQ
         tDpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792648067; x=1793252867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X5pXj4eRir2CjK6OhvR45YFhB3gNNXH7ANQQF/7yCpU=;
        b=PjOlT7KvqA7Xszt7487FxiePoVcFgJfWK6Y1ALU+Bu1c3lAk/7uOkV9TTpiItCEFuI
         O2pD2KK5QWyfGZsx+CxiMl2o+A3+XzDynLK+j8Zy9wkasoHvmTAehfhIO6cIb5FMsn65
         EXcp2uvwtwXQSMrs16l9eRLDP/vKbH41qFN3P+ZWg01Wdr8Izb+ORqRlW/3RFidoQ5fY
         TuNBumaopsZHMAH18hbZMyAM8dp8Czj5X0srHIiBS6eq2QUZuP2//or6xiZXjxwOOjfo
         X46XX6f56FbjHH/tm6DmJrdRLipaphPJKhxZMrzEYP0o2Q1KaxoqdKGeN95LuauUKbxr
         lk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792648067; x=1793252867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5pXj4eRir2CjK6OhvR45YFhB3gNNXH7ANQQF/7yCpU=;
        b=qZFUfnEUYkHvjAdDqBZjjzRL7/YZKRRPy+QG54+rxP6XzfD+K+2f3rzOGR5vqxgSZe
         3ZfRqnRTgxyVsncMRT+ramxc2STRdrpGbWaTSr5dP8+4QoMWkbt++KGalgi9xwvD7tZ9
         MrYIVQWOQA4t4+iDGibBA9OV+MHkdrmmyos12G4fV91PBVbNEJ30Lm9xz+A5ezHPyyx5
         aKXnWGxk3pTYkCVyxtc7JFe0meb9feP/vBXvJDRGSFiM6PSjRCQWeshivKW0CwRfSf1f
         xwwRY6eU+BdntO2M5Unk6EfilHk1YBT72ZK++rsa19AdtKI3K9yg5whIRW8Fq6V10kEw
         x1ng==
X-Forwarded-Encrypted: i=1; AKwUvByICczsDX2/xy2qtQv+Z4pOcYLlBmx+njVxmzt13RxfREIDNsbGhC7juHZL2dFctT7ybeI7DLt+pgRZ0ELq@vger.kernel.org
X-Gm-Message-State: AFq9FYKg95tEI0Zd3nvV8bVmteayMJ7MRLFpiq9c9wQNgr4ZwAPk9zk+
	t499qDI2jgOwPzHtMsD4nnNRltquvzqYIS2itJn1xfgCGzHwRft8x552FBR3HSdm0GOHZjIu/w/
	e+CbdGj4bd8TXkz3yemgzcUVwbGADbxI=
X-Gm-Gg: AYBFou3NR62hNmC0msLBLhf4xk0Bn7533YqgpuGf7y/C9e+5sseT4mheHy6ilPkddCL
	v5X8/rq2P7PSIMCPSmeUWcZsFi2g0gZKLxnzM/YDFYNMpHl1v9wOusubvlhFq2trUYkdQr74bcC
	3O9dbjey0g4aU/cJmlueUljAU7axPiqnBGh2B/XYp1our5dwezjAK+7Yx4Zkx6ToAWByM/vAg6X
	sv/EaivTtP3M9xharUGBZtEHoDdiDBf/eaC/IQ+lPNc95vY2PHj+2+w8tsnTo3Z89LzhkjDNems
	U4xtmutHT92tWACnKUb4iwAmsH+YtEzvjJqbNPvRgYsnRnXrEgzjIdTNF2cmQlpLswWtRXAbShM
	par2Z0E0ad2EOiFsPm6Bc0mnDok8Ua6VJNbIx2tvEB29dE6NsxGKbkxPpsrBRdw0FohU=
X-Received: by 2002:a05:690e:d88:b0:679:bf7c:a796 with SMTP id
 956f58d0204a3-67a0e45bf39mr1930543d50.30.1792648067479; Wed, 21 Oct 2026
 22:47:47 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016053708.47089-1-laoar.shao@gmail.com> <20261016053708.47089-6-laoar.shao@gmail.com>
 <atjZjZrMKv5koK53@pathway.suse.cz>
In-Reply-To: <atjZjZrMKv5koK53@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 Oct 2026 13:47:10 +0800
X-Gm-Features: AclHuK-ptbPeN1dzmsLVmx7NhOuIc3BLbaAfTQbW46KhhSIGV8LdRInIOQGoIvs
Message-ID: <CALOAHbD56YOrk8XvoP0HwmQF6HcTojXBqib-4qc+2A1WATyikw@mail.gmail.com>
Subject: Re: [PATCH v12 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:26=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
>
> On Fri 2026-10-16 13:37:04, Yafang Shao wrote:
> > The current bool replace flag is too coarse: it is either all or
> > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > livepatches, which is safe but inflexible. There is no way to have
> > multiple independent livepatch sets coexist on the same system.
> >
> > Replace it with a more flexible model using two new fields in
> > struct klp_patch:
> >
> > - provides: an unsigned int id identifying the changes made by
> >   the related livepatch. Where the changes are a set
> >   of modified objects, functions, and used callbacks,
> >   shadow variable ids, and state ids.
> >
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different scopes.
> >
> > A new livepatch atomically replaces any existing livepatch that
> > meets either of the following conditions:
> >
> > 1. It has the same provides id as the new patch,
> > 2. Its provides id is listed in the new patch's obsoletes list.
> >
> > A new livepatch that does not replace an existing one can coexist
> > with it. In this case, the two livepatches must not modify the same
> > function, or use the state with the same id. Any attempt to load an
> > incompatible livepatch will be rejected by the kernel.
> >
> > klp-build gains -p/--provides and -r/--obsoletes options.  The two
> > parameters are not validated in klp-build, since the compiler and the
> > kernel handle invalid values.
> >
> > Enable the CONFIG_KLP_HAS_PROVIDES compile-time marker now that the
> > provides/obsoletes interface is implemented.
> >
> > --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> > +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> > @@ -47,13 +47,25 @@ Description:
> >               disabled when the feature is used. See
> >               Documentation/livepatch/livepatch.rst for more informatio=
n.
> >
> > -What:                /sys/kernel/livepatch/<patch>/replace
> > -Date:                Jun 2024
> > -KernelVersion:       6.11.0
> > +What:                /sys/kernel/livepatch/<patch>/provides
> > +Date:                Jun 2026
> > +KernelVersion:       7.4.0
> >  Contact:     live-patching@vger.kernel.org
> >  Description:
> > -             An attribute which indicates whether the patch supports
> > -             atomic-replace.
> > +             An attribute to show the provides id of this livepatch.
> > +             Livepatches with the same provides id replace each other.
> > +
> > +What:                /sys/kernel/livepatch/<patch>/obsoletes
> > +Date:                Jun 2026
> > +KernelVersion:       7.4.0
> > +Contact:     live-patching@vger.kernel.org
> > +Description:
> > +             An attribute to show the obsoletes ids of this livepatch.
> > +             The obsoletes ids are a comma-separated list of provides
> > +             ids that this patch obsoletes. When this livepatch is
> > +             loaded, any existing livepatch whose provides id matches
> > +             either this patch's provides id or any id in the obsolete=
s
> > +             list will be atomically replaced.
>
> This still describes the behavior in v10 where the obsoletes were
> handled symetrically. It should remove patches only with the matching
> provides.

I will update it.

>
> >
> >  What:                /sys/kernel/livepatch/<patch>/stack_order
> >  Date:                Jan 2025
> > diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documenta=
tion/livepatch/cumulative-patches.rst
> > index 1931f318976a..5ce04424e09d 100644
> > --- a/Documentation/livepatch/cumulative-patches.rst
> > +++ b/Documentation/livepatch/cumulative-patches.rst
> > @@ -2,33 +2,71 @@
> >  Atomic Replace & Cumulative Patches
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -There might be dependencies between livepatches. If multiple patches n=
eed
> > -to do different changes to the same function(s) then we need to define
> > -an order in which the patches will be installed. And function implemen=
tations
> > -from any newer livepatch must be done on top of the older ones.
> > -
> > -This might become a maintenance nightmare. Especially when more patche=
s
> > -modified the same function in different ways.
> > -
> > -An elegant solution comes with the feature called "Atomic Replace". It=
 allows
> > -creation of so called "Cumulative Patches". They include all wanted ch=
anges
> > -from all older livepatches and completely replace them in one transiti=
on.
> > -
> > -Usage
> > ------
> > -
> > -The atomic replace can be enabled by setting "replace" flag in struct =
klp_patch,
> > -for example::
> > -
> > -     static struct klp_patch patch =3D {
> > -             .mod =3D THIS_MODULE,
> > -             .objs =3D objs,
> > -             .replace =3D true,
> > -     };
> > -
> > -All processes are then migrated to use the code only from the new patc=
h.
> > -Once the transition is finished, all older patches are automatically
> > -disabled.
> > +Livepatches are used to fix kernel bugs. New fixes need to be added ov=
er time.
> > +The fixes might be independent, but they might also depend on each oth=
er. This
> > +brings a challenge of how to keep the livepatched system safe and cons=
istent.
> > +
> > +Part of the solution is the "Atomic Replace" feature, which allows the=
 kernel to
> > +atomically replace an existing livepatch with another one. These newer
> > +livepatches are designed as "Cumulative Patches". They include all wan=
ted
> > +changes from all older livepatches and completely replace them in one
> > +transition.
> > +
> > +The second part of the solution are ``provides`` and ``obsoletes`` fie=
lds in
> > +``struct klp_patch``, which allow the installation of multiple livepat=
ches in
> > +parallel. A livepatch will atomically replace any already installed li=
vepatch
> > +whose ``provides`` id matches either the new patch's ``provides`` id o=
r any id
> > +in the new patch's ``obsoletes`` list.
>
> Same here.

will update it.

>
> > This might be used to fix independent
> > +problems separately, for example, the livepatches might be prepared by=
 separate
> > +teams focusing on particular functionality or a subsystem.
>
> Otherwise, I like the patch. The code and documentation is nice a clean.
>
> Note: We repeate some things several times in the documentation. It makes
>       it harder to keep it consistent. But it is an existing problem.
>       I think that we could do better but it is beyond the scope of
>       this patchset.

Agreed. Some rules are described several times in different files. I
will  try to clean up the documentation once this series is merged.

>
>
> With fixing the two outdated pieces of documentation:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr
>
> PS: I have to leave now. I hope that I'll be able to finish the review
>     by the end of the week. I think that we are getting close to
>     get it into linux-next. Well, I would like to put it there
>     on top of the merge commit for-7.4. I still have to send
>     the pull request...

Thank you for the review!  It is great to hear that the series is
getting close to linux-next.

--=20
Regards
Yafang
