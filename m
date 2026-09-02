Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEF438FED
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342669; cv=pass; b=LdVgFnPClpJJdB1m+j71LONxzXuoSiRTjT3XqWLtfvHepr4NvQiuJJIhjU5vSXEkU+8reQsKOkq5xT54GOabkqt0NfiXnPCS3vbxQyLJpdHqUfmLs3ofdweIElgm6SVXkDjwemebv3TYq7FLjc/XQ23kXlJx8lFn3rRi9681iZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342669; c=relaxed/simple;
	bh=UYL+BwQfQ2q/Uvkjrjd3lb5wdSZA0tXGP7VKAQJQQL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDUcJZggaGtn09IKLmxTbtRiNyWZhUJGQNZtpHxfLnCBelpOrVXiYYbPaZh0w9AT88wY35DRV0RB370tATpbqTDfRXai91ddoJ9SdJaf939/oC6jGxZZnlyF+9kZXNI+wtkVv5WiLxBDkEnTHAWXrG2Xn48Cebx4XL8I474XYHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Jw7wtO; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Jw7wtO"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66ce4a63e17so895914d50.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 02:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342665; cv=none;
        d=google.com; s=arc-20260327;
        b=abVZ8E5LA+uPD2tXKpoYb1EI2nLWmyvj4eNVvv1EZXjmt7fz63VGGdqi4IpY5xRb44
         V6fSrorY5bMc7SlSqSe8mJsuCbRsLa/k23RyyNHzqL2abenzxCddKB47T6m5MZLCrSs8
         ZO++xqjGyiYm8ojeBd3ITcMqtuT2asQk47aqvzKBhlrKXaVeaX3kLsWk0rhghkaXYPIx
         220ty09lAFfdCKxbv0KodXzgXwDI9lZLDLi7iqYA+5rD9Y7Xj6WJzIRY50J0gSntsO3Z
         nSh91K45EOhpzPUEpGfS59Jaaz7Vp270OGBf2HmVKWwx30/axam5oNW+93wwmYPt6Wvp
         3nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z++hCQ0r1doDkqaeN4mPlOKvlJt1l+p37VJSSzMUlfk=;
        fh=5EFTP6dDHlFQQnec2j69Rsu6TvTViYMk5krXV1lLQVg=;
        b=UH0N5hpoKZM87gluLoUGVLYX5ikGEcx5yyOk7wCTM3mdfIjaT9IbTnbw2XHehWx+hS
         n3/HzGBRZ4AVzEO/flqUMFjwrNfD8BN3zgKg+hl4WLziRRrXjJcP6zAwzuU+gjHT3Etd
         HXRCB1E/Q95D7K8gRpJPLoxBKLdcWXRC3uNhXEhHDXUpuEi4thQ2/v5zh7150W7wpMYm
         +Ri79ol0APwp5aqpeKgAlron+7vl9tqzEMte3inPUR2Ye0KBvpbVrGarejqv3OvLZhGm
         MKzs10+4WXmgn6jckDMdGZOFO0Su9c1ZbrkZrrZdDE5C28wnsHRraUiejqonCX0pcKef
         UeNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342665; x=1788947465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z++hCQ0r1doDkqaeN4mPlOKvlJt1l+p37VJSSzMUlfk=;
        b=K4Jw7wtOMyY6PgfxaTrXPXV13Ya/65xtO9enVrmiCZZl1QqEDgLsd4nCwxJsXU+iyT
         EkR2dVaISAfJpK+OwFnejEWct6GmJCUs+JduYNLUaFSBl4D29O6whBz+o68r4z2qhT+S
         /430GJXFgDF1bpAOPvAI2tUlvh6kng0AJyNt+5M7XXWZITUhYawGjEEtAF5nSa0MoPw0
         Urvj5UOYfqQf6v6LhlP0Y1hUPxh2pVAlMtpDB/BiRdM3MrVBIRPi/oD7RaYghzGNibqA
         d1Z7KOQcX2OauDgarAGO25JQhO2HEzC/F9X5O08Oo0/5UhPDIdUFg6ejI0d+orPldXEc
         ovOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342665; x=1788947465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z++hCQ0r1doDkqaeN4mPlOKvlJt1l+p37VJSSzMUlfk=;
        b=fX8DpklC2S+bpADmVeqLQ7RQj8VJYx5mgU4zpTN+N4gkWmEqyZ7Qaey/hLe3S4QX+5
         SUc/Dd06n0zknJhtl3qXXyNQQwgkjxrGgH+IrAczPbJ/OXah0lj5GSKD0BI3yQ1RW9Rt
         nTZZq64lCjpfIyvjqom2uvzINKpkGaZQ8aXYsdj5BSH6LSTsBqYYR/s/d7WqBR0KTL0e
         vBM68klK4dHq0OqSAx+Qf777ISrHcNynbj7Accft80Ll45UHuTaPgTs8nXEqGNOqzHQR
         61OqZ4FWLQSe43e5t3gmmzT5gAD5puglRLRn8Rm1AZPYeSNaMZxdMKc6J/9xiY6r+yOJ
         HIyA==
X-Forwarded-Encrypted: i=1; AKwUvBwtP/CDbw6tam5DvWnjB2jvCPOxFY8o3OdyOnlVhlBIGhQQ6/+UMomfZHws+Ub1SgA9Enyd2SfeORCbQ/Yn@vger.kernel.org
X-Gm-Message-State: AFuF++lTcQjuchf0fjAe375ugCN5PEtL9CmYjFT+LZakzLpKoZm6FWHh
	jkRbwMx7U8i4/lDlLP+hNHTevJsnysO5WKh/KXqztrIs3LwFKx0ZLVh5CUgkdrvyaIMw967l2G4
	3ZIZ5PSY7hgcrZ0nRUdQq5G7zR8CJzTM=
X-Gm-Gg: AYBFou3XFI7oDs3dQ/C1RYqQ5S1XC145gOdq0+z6Subu0/xlRfuH2quKuBR/MEPeQMi
	csLrR5N3z7ai+8usxmZ78UJtOeBIPe5yhqaiSZ/eBYeamG5E9B3CAz1yd2HkZlnFL6T5n6uFeCm
	0xemOZi3a6jMqCh1bwTkkwBjEyDWd8WogtWbnMrJQ057RLsIfA2TpyFsI6UfsNgYWTVSN6B0xVG
	7GzLs8ncYx1RPa1p3kVJXnJB8jOL2vW9RWxAnwZFYM+b2sZ21qiIer8fSLEYmc4wCoof58Rb9ny
	qIBISnGQIsSEXyu9b62wPrtapAdFSJPXQrQFqJffWTOpNyqqH+Yr2Gqg0lNNOgVXABVAFTio2bV
	h8g==
X-Received: by 2002:a05:690e:418c:b0:66e:5748:e048 with SMTP id
 956f58d0204a3-66f9bbb00a3mr916334d50.27.1788342664948; Wed, 02 Sep 2026
 02:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfRgPN7FWsgYSOn@pathway.suse.cz>
In-Reply-To: <apfRgPN7FWsgYSOn@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Sep 2026 17:50:28 +0800
X-Gm-Features: AcwNN1WDbmfXgAFrSk4N7IkEO_89MYU7h0CFyL-9dwszw8xDMOMFGibH877Hwv0
Message-ID: <CALOAHbCh1R0_zxZztvhYgUhtQswi7dzR-jw6AeA0MqF=BThdAQ@mail.gmail.com>
Subject: Re: documentation: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:34=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > The current bool replace flag is too coarse: it is either all or
> > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > livepatches, which is safe but inflexible. There is no way to have
> > multiple independent livepatch sets coexist on the same system.
> >
> > Replace it with a more flexible model using two new fields in
> > struct klp_patch:
> >
> > - provides: an unsigned int id identifying the patch replace set.
> >   By default (provides=3D0), any livepatch replaces any other livepatch=
.
>
> What is the "replace set"? The term is used few times in
> the commit message, documentation, comments but it is not
> defined anywhere.
>
> IMHO, the term is a bit misleding, both "replace" and "set" parts.
>
> 1. My understanding is that "provides" is an "id" which is connected
>    by a set of objects, and functions which are modified (replaced?)
>    by the livepatch? Here the "replace" would mean "replaced
>    functionality".
>
>    But the provides id also covers the related callbacks, shadow
>    variables and livepatch states. Here the word "replace" does
>    not fit.
>
>
> 2. We are talking about "atomic replace". Here one livepatch replaces
>    one or more other livepatches. Here the word "replace" would mean
>    "replace livepatch(es)". But does the livepach replace one or more
>    livepatch sets?
>
> Do we need this term at all?
>
> IMHO, we could live better without it, for example:
>
> <proposal>
> Subject: livepatch: Implement provides and obsoletes for scoped atomic
> replace
>
> - provides: an usinged int id identifying the changes made by
>   the related livepatch. Where the changes are a set
>   of modified objects, functions, and used callbacks,
>   shadow variable ids, and state ids.
> </proposal>

Thanks for your suggestion.
I will update it.

>
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different replace sets.
>
> We should mention here the special meanting of the "0" id.
> It enforces the most secure mode when only one livepatch
> can be enabled at any time.
>
> Also it is important to explain here also the compatibility
> rules. They are important part of the design.

Ah, if you prefer to make '0' a special case, I will implement it that way.
This brings up the question you mentioned in another email: should we
allow loading another ID when livepatch ID 0 is already enabled? It
seems the answer is to reject the other ID.

>
> This approach allows to have more livepatches installed in parallel
> but only when they are not conflicting. They would conflict if
> they attempt to livepatch the same function or use livepatch states
> with the same ID.
>
> > A new livepatch atomically replaces any existing livepatch whose
> > provides id matches either:
> >   1. The new patch provides id (same replace set), or
> >   2. Any id in the new patch obsoletes list
> >
> > The klp-build script is updated with -p/--provides and -r/--obsoletes
> > options. The obsoletes list automatically includes the provides id
> > and deduplicates entries. Input validation rejects malformed values
> > at build time.
> >
> > Two helper functions are introduced:
> > - klp_patch_replaceable(): checks if an new patch will replace the old
> >   patch
> > - klp_has_function_conflict(): rejects loading a livepatch that would
> >   modify a function already patched by a livepatch with a different
> >   provides id.
>
> I agree with Josh. There is no need to mention these two new
> functions in the commit message.

I will update it.

>
> > Suggested-by: Song Liu <song@kernel.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Co-developed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  .../ABI/testing/sysfs-kernel-livepatch        | 22 ++++-
> >  .../livepatch/cumulative-patches.rst          | 93 +++++++++++++------
> >  Documentation/livepatch/livepatch.rst         | 23 +++--
> >  include/linux/livepatch.h                     |  7 +-
> >  kernel/livepatch/core.c                       | 69 ++++++++++++--
> >  kernel/livepatch/core.h                       |  1 +
> >  kernel/livepatch/state.c                      | 57 ++++++++++--
> >  kernel/livepatch/transition.c                 | 11 ++-
> >  scripts/livepatch/init.c                      | 71 +++++++++++++-
> >  scripts/livepatch/klp-build                   | 78 ++++++++++++++--
> >  10 files changed, 351 insertions(+), 81 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documen=
tation/ABI/testing/sysfs-kernel-livepatch
> > index 3c3f36b32b57..2588f676deb1 100644
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
> > +             Only one active livepatch per provides id is allowed.
>
> This sounds like you could not load another livepatch with the same
> id. But you actually could. We should make it clear that it would
> replace the existing one. I suggest something like:
>
> <proposal>
>                 An attribute to show the provides id of this livepatch.
>                 Livepatches with the same provides id replace each other.
> </proposal

Thanks for your suggestion.
I will update it.

>
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
> >
> >  What:                /sys/kernel/livepatch/<patch>/stack_order
> >  Date:                Jan 2025
> > diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documenta=
tion/livepatch/cumulative-patches.rst
> > index 1931f318976a..04352ae3f0d0 100644
> > --- a/Documentation/livepatch/cumulative-patches.rst
> > +++ b/Documentation/livepatch/cumulative-patches.rst
> > @@ -2,33 +2,66 @@
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
> > +The second part of the solution is the newly introduced ``provides`` a=
nd
>
> s/is the newly introduced/are/
>
> "the newly introduced" would fit into the commit message but not into
> the documentation. The fields are new _now_. But the documentation
> should make sense as long as the feature is there.

I will update it.

>
> > +``obsoletes`` fields in ``struct klp_patch``, which allow the installa=
tion of
> > +multiple livepatches in parallel. A livepatch will atomically replace =
any
> > +already installed livepatch whose ``provides`` id matches either the n=
ew
> > +patch's ``provides`` id or any id in the new patch's ``obsoletes`` lis=
t.
> > +This might be used to fix independent problems separately, for example=
, the
> > +livepatches might be prepared by separate teams focusing on particular
> > +functionality or a subsystem.
> > +
> > +It should be emphasized that the preferred and most secure way is to a=
lways use
> > +the default ``provides =3D 0``. In this mode, any livepatch replaces a=
ny other
> > +livepatch, preventing any unexpected interactions between incompatible
> > +livepatches.
>
> We should make it clear here that '0' is really special. It basically
> provides and obsoletes livepatches with any other IDs.
>
> > +Provides and Obsoletes
> > +-----------------------
> > +
> > +The ``provides`` field in ``struct klp_patch`` is an unsigned integer =
that
> > +identifies the livepatch's replace set. By default, it is 0.
>
> I would get rid of the "replace set" term.

I will update it.

>
> > +The ``obsoletes`` field is an optional array of unsigned integers that
> > +specifies additional ``provides`` ids to be replaced when this patch i=
s
> > +loaded.
>
> The above part is good.
>
> > By default, it includes the patch's own ``provides`` id, ensuring
> > +that a new patch always replaces any existing patch with the same
> > +``provides`` id.
>
> This sentence is confusing. My undestanding is that we do not need
> to mention patch's own provides id in the obsoletes array. I would
> just omit this sentence.

I will update it.

>
> > +
> > +For example::
> > +
> > +        static struct klp_patch patch =3D {
> > +                .mod =3D THIS_MODULE,
> > +                .objs =3D objs,
> > +                .provides =3D 0,
> > +        };
> > +
> > +Any ``provides`` value might be associated with a set of livepatched s=
ymbols,
> > +callbacks, shadow variables, and state IDs. By definition, there can o=
nly ever
> > +be one active livepatch for a given ``provides`` id.
> > +
> > +On the contrary, livepatches with a different ``provides`` id must not
> > +modify the same function, or use the state with the same ID. Any attem=
pt to
> > +load an incompatible livepatch will be rejected by the kernel.
> > +
> > +Atomic Replace
> > +--------------
> > +
> > +A livepatch with a given ``provides`` id is replaced by another livepa=
tch
> > +with the same ``provides`` id, or whose ``obsoletes`` list includes th=
at id.
> > +All processes are migrated to use the code only from the new patch. On=
ce
> > +the transition is finished, the older patch is disabled. Patches with =
a
> > +different ``provides`` id are not affected and remain active.
> >
> >  Ftrace handlers are transparently removed from functions that are no
> >  longer modified by the new cumulative patch.
> > @@ -64,7 +97,11 @@ Limitations:
> >    - Once the operation finishes, there is no straightforward way
> >      to reverse it and restore the replaced patches atomically.
> >
> > -    A good practice is to set .replace flag in any released livepatch.
> > +    A good practice is to use only one (default) ``provides`` id. It
> > +    makes sure that there always will be only one enabled livepatch
> > +    on the system. The consistency model will ensure a safe update
> > +    between two versions. It prevents potential problems with installi=
ng
> > +    two livepatches doing incompatible functional changes.
> >      Then re-adding an older livepatch is equivalent to downgrading
> >      to that patch. This is safe as long as the livepatches do _not_ do
> >      extra modifications in (un)patching callbacks or in the module_ini=
t()
> > diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/live=
patch/livepatch.rst
> > index acb90164929e..73635f9ddd91 100644
> > --- a/Documentation/livepatch/livepatch.rst
> > +++ b/Documentation/livepatch/livepatch.rst
> > @@ -347,15 +347,20 @@ to '0'.
> >  5.3. Replacing
> >  --------------
> >
> > -All enabled patches might get replaced by a cumulative patch that
> > -has the .replace flag set.
> > -
> > -Once the new patch is enabled and the 'transition' finishes then
> > -all the functions (struct klp_func) associated with the replaced
> > -patches are removed from the corresponding struct klp_ops. Also
> > -the ftrace handler is unregistered and the struct klp_ops is
> > -freed when the related function is not modified by the new patch
> > -and func_stack list becomes empty.
> > +There can be only one active livepatch for a given ``provides`` id.
> > +A new livepatch atomically replaces any existing livepatch whose
> > +``provides`` id matches either the new patch's ``provides`` id or
> > +any id in the new patch's ``obsoletes`` list.
> > +
> > +Once the transition is complete, all functions (``struct klp_func``)
> > +associated with the matching replaced patches are removed from the
> > +corresponding ``struct klp_ops``. If a function is no longer modified =
by
> > +the new patch and its ``func_stack`` list becomes empty, the ftrace
> > +handler is unregistered and the ``struct klp_ops`` is freed.
> > +
> > +Patches with a different ``provides`` id are not affected by this
> > +process and remain active. This allows for the independent management
> > +and stacking of multiple, non-conflicting livepatch sets.
>
> I would avoid the word "stacking". The livepatch code has this term
> connected with func->stack_node and ops->func_stack. It allows to
> associate more struct klp_func entries with the same ftrace handler.
> The last or the last-but-one entry is then used depending on
> the state of the transition.
>
> By other words, the stacking is used in the livepatching code when
> two livepatches modify the same function. But such livepatches are
> _conflicting_.
>
> By other words, the  sentence: "allows independent.*stacking of multiple,
> non-conflicting livepatch sets" does not make sense.

Thanks for your detailed explanation. I will update it.

--=20
Regards
Yafang
