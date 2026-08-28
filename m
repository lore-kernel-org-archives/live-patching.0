Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAA286AC
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886221; cv=pass; b=D5pN8lnwG30/GvgZ40eQQYhqr9nF8nCQ2ZILMjmVO4L9tz3BenPffCDkkccgaU8yxX3n242uk9blU2fUoWdYsWsVADzFe/Ub/rK+JuuBbxDNCqyTdWYC9w7IpwF8EKxDvtZMzYY4PPFCXEboSeHcKWAUzVEkWhoz1U+DiKLetNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886221; c=relaxed/simple;
	bh=JCKPGuLyVOdgMlha3aNQq+yK7PlwXPrLRQUx3DosHF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dru8YMqbEsKkczoEiCtIZt6l+zV4lgtH3x4zNBH0mwBafapk9GFzxZGtJJyM0a1JAMXkSHsXoagnIFsc2fe1Hrq/9347DJEFW3j63ChnPVZkeHvivnkTeADCTVGSwzj8ddhFwe6MjSrn/y3KJ/u45B4gt49nOosgOjjSoGzr22Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTTLGnjk; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTTLGnjk"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d14734b9fso2738432d50.0
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 20:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787886219; cv=none;
        d=google.com; s=arc-20260327;
        b=n20wPg7YS6EiUzYLlYlx2Upbo93iNWXwGDJmNwH4KDH2XtvbIis5WBic3akBLyoxiS
         dsO+teZIvZ+g9KF0Bdh8kKiDeQxYZ/T9qIiyuvuPgF/4EejbHvocMYZuMXyhcSgfC032
         8QH2dcm9JEn0LxHBvC1lNdEQfFxSsggvDYh5JANeJCR+lTb9GjuYZd5eVnLpaJCePtcb
         SKUfMvjZbIrcVOBzu5Rxh2hxPhz6O32JEE/gTMV9ol6p9VXOR9/VUgxrCs6iTUJdzNsL
         y+PNCyvXQfPKeGCHENWleIg9QTs9sj/y6ClwC9CQ1wDHfa54jyenGKwhmmNzFF0zdMFs
         0N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zDI7r5LYWm0/1srkWAsUBepauilad8VCUeeUxC+kGhk=;
        fh=YWnKpaTM09WTacXbq9J1jhlj1MI2rM6ppDKHsySg+CU=;
        b=J25GH8sCat9BxAs9SzEq0jpUZ2f3v/3ATfCcZl71dMhn9vM90GyM6fftgR0kT/SPnZ
         fC2DfybVzOVDqmkxmbAaORLOFXTL17ykeE7zZ+Vy8F1ajuchGlA9RIe6dIuXeCKIGum1
         9twzHkIpkiERlQZAP3I5NmJ3IqeNk9mS72zZyoFuN+YgO/wEPPZRlFQ0xCXBdTHOnF0v
         Ofvwm9+pCk3pC7hETNvjmW65+XqAg2C0XRoBNf/QAIV3sUlzLGSgf2VeQir+fgDC9d/Q
         lF/04tP1DNALfdyaE89nTGhMjU7xDFTen7ltCu19ZVOsno7QBONT1urfblJn3auSlPnF
         74tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787886219; x=1788491019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zDI7r5LYWm0/1srkWAsUBepauilad8VCUeeUxC+kGhk=;
        b=ZTTLGnjkXwRKJj7cU/westabgiOrsjVn4fTrC7g2SyF83gpAz7Py2HllZ3GcRpdTvT
         Pjcq+todKDoy8RUks7BTRJvbUaJhw0NLXDIVlXCjdF6GRqiPLm7m0eiyi7H7/TS1ZcpG
         E2wya1f/dEtCXpzLrlZtkjNdrm/RravQRbkrXswRbkJ8WJcW9G8A6KLqPfNDElLz+Cq7
         7lL5LXliqyTBdXyN8/DAdNf21dyflD3VMjpCJur8/tehtMPJaF6BSu66ud19/KdEePtB
         M2hVqhlGPoJu8CqmDXocHn6IY6A1iGyBnGWZSaCR2JFm8554Hq2jkL2zF8z7UV2UHQkp
         RcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886219; x=1788491019;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDI7r5LYWm0/1srkWAsUBepauilad8VCUeeUxC+kGhk=;
        b=rbJu8SEND0qdU0wk45vducoGsNOXq/kYiD8Cn0axMGsRNEvkjrRuHBvJsBJWd+Lnsx
         RezPjyULyxMYUfF0wJnfhNs7ruAMwUPru2wvapUQzWwH+1SB6Wp1EbIvNQiAKnRpCuuV
         uR5311wDyO+qEDVQnuIsOOHqFHbSETtiYdNPqvaiUGBxoy61wgXTnpc+SvVBZ+Z2ERrj
         I8ri1YkAoqcdM4uCvOxMkzn2FM7MBgLo0JKJ1AmPSmNwIgCqq6At60L/3YgTRD5IaoJI
         dr6O2xyMTfp3Y616AV5Ydw4flNEoPF7vZpnzm5lngCKDtOH7J5YPujEadfLb/No2EBSV
         WnPA==
X-Forwarded-Encrypted: i=1; AHgh+RpfXuAnx1Nrw9R7rGl6thDPx+1YT8fYQCD+omVfLrly8OuGPRwxMZE1DJtDoUcNTuSDtZYYRJZI95b2uHkS@vger.kernel.org
X-Gm-Message-State: AFuF++lgx9YftyeBH+VZQW7uCfMzPUp2kq3cMF+shx8Kepxd+Rw4NbI6
	3TcYfnxyA9uJOOSktXLZ+KfGH4WIxpv16FcKonY8yZqBJGC9ZaYx3UOVgJWe/srS4YacWCdsZlY
	f9d1oOp0FWiJFsmma5USOR6EiC+iTklw=
X-Gm-Gg: AR+sD11FbcyBOzreyEPad9ZHRAM/0GqoP3eLI150CrMOMMoNDYN2Am2++Cr4NkO8gKz
	tFTwNefCnmSjQoD2RTNprdV1sp5Oz4sjhD2+3dBh+0Sx8+VuJIVuHQZ0lF2DhMXp7ukJbyy+NEw
	BycIiF4g+RD4FefwnpyMsE/kgWAuZHtcKjG46Dame3LLgbiqJfqlSczex5YdesSmqJ4ZZo9BNGS
	1NId9AliyAyk0etlym60f0sYqES9dN8/yHZ3E/gf2AKzYrlV2VnpkTMIFIK1kPVlrgA1p5kDOhF
	U59f0TnvPjKhOLUeD97tfL2+G1qa7tfn1ORgMIEVPi42tbQln5UfZ9sJZXfC4GeDlTgk9HhVXQj
	cwMfdqoEv6/5T
X-Received: by 2002:a05:690e:16a0:b0:667:d5f3:764d with SMTP id
 956f58d0204a3-66e4b89ec62mr1235723d50.14.1787886219017; Thu, 27 Aug 2026
 20:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apDO-a2n9UlrO_FA@jpoimboe>
In-Reply-To: <apDO-a2n9UlrO_FA@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Aug 2026 11:03:02 +0800
X-Gm-Features: AcwNN1Uc4OqMevY_QTBD0HgnYjJ1YyuE4aHABHt9r6yvH3Dl9qFXh0JcyFGEnck
Message-ID: <CALOAHbAoJf-brcQW-QtXZzR+8xi2ZCAJNwyHBQguXJCr+5+5xg@mail.gmail.com>
Subject: Re: [PATCH v7 for-next 3/8] livepatch: Implement replace set for
 scoped atomic replace
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:26=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Aug 25, 2026 at 07:46:36PM +0800, Yafang Shao wrote:
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
> >
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different replace sets.
> >
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
>
> Should be klp_patch_replaces()?

right.

>
> > - klp_has_function_conflict(): rejects loading a livepatch that would
> >   modify a function already patched by a livepatch with a different
> >   provides id.
>
> I'm not sure the commit log really needs to list some functions it adds,
> that's already evident in the patch.

I will remove them from the commit log.

>
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index ba9e3988c07c..854ed6230b96 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -123,7 +123,8 @@ struct klp_state {
> >   * @mod:     reference to the live patch module
> >   * @objs:    object entries for kernel objects to be patched
> >   * @states:  system states that can get modified
> > - * @replace: replace all actively used patches
> > + * @provides:        only one active livepatch per id
> > + * @obsoletes:       replace given livepatch id(s)
> >   * @list:    list node for global list of actively used patches
> >   * @kobj:    kobject for sysfs resources
> >   * @obj_list:        dynamic list of the object entries
> > @@ -137,7 +138,9 @@ struct klp_patch {
> >       struct module *mod;
> >       struct klp_object *objs;
> >       struct klp_state *states;
> > -     bool replace;
> > +     unsigned int provides;
> > +     unsigned int *obsoletes;
> > +     unsigned int nr_obsoletes;
>
> nr_obsoletes is missing from the kernel-doc above.

will add it

>
> > @@ -72,15 +71,76 @@ static int __init livepatch_mod_init(void)
> >
> >       /* TODO patch->states */
> >
> > -#ifdef KLP_NO_REPLACE
> > -     patch->replace =3D false;
> > +#ifdef KLP_PROVIDES
> > +     patch->provides =3D KLP_PROVIDES;
> >  #else
> > -     patch->replace =3D true;
> > +     patch->provides =3D 0;
> > +#endif
>
> 'patch' is already zeroed, so the #else isn't needed.

will remove it.

>
> > +#ifdef KLP_OBSOLETES
> > +     /*
> > +      * Parse KLP_OBSOLETES string (format: "1,2,3") and convert to
> > +      * unsigned int array for patch->obsoletes.
> > +      *
> > +      * Note: The provides ID is not included here; the kernel will
> > +      * replace livepatch with the same provides ID.
> > +      */
> > +     {
> > +             unsigned int *obs_array;
> > +             unsigned int count =3D 1;
> > +             char *obsoletes_str;
> > +             char *token, *str;
> > +             int i =3D 0;
> > +
> > +             for (str =3D (char *)KLP_OBSOLETES; *str; str++) {
> > +                     if (*str =3D=3D ',')
> > +                             count++;
> > +             }
> > +
> > +             obsoletes_str =3D kstrdup(KLP_OBSOLETES, GFP_KERNEL);
> > +             if (!obsoletes_str) {
> > +                     ret =3D -ENOMEM;
> > +                     goto err_free_objs;
> > +             }
> > +
> > +             obs_array =3D kmalloc_array(count, sizeof(unsigned int), =
GFP_KERNEL);
> > +             if (!obs_array) {
> > +                     kfree(obsoletes_str);
> > +                     ret =3D -ENOMEM;
> > +                     goto err_free_objs;
> > +             }
> > +
> > +             str =3D obsoletes_str;
> > +             while ((token =3D strsep(&str, ",")) !=3D NULL) {
> > +                     unsigned int val;
> > +
> > +                     ret =3D kstrtouint(token, 10, &val);
> > +                     if (ret) {
> > +                             kfree(obsoletes_str);
> > +                             kfree(obs_array);
> > +                             goto err_free_objs;
> > +                     }
> > +                     obs_array[i++] =3D val;
> > +             }
> > +
> > +             patch->obsoletes =3D obs_array;
> > +             patch->nr_obsoletes =3D i;
> > +
> > +             if (i > 0)
> > +                     pr_info("obsoletes patch ids: %s\n", KLP_OBSOLETE=
S);
> > +
> > +             kfree(obsoletes_str);
> > +     }
>
> Can we do something simpler like this?
>
> #ifdef KLP_OBSOLETES
> static unsigned int klp_obsoletes[] =3D { KLP_OBSOLETES };
> #endif
>
> And in livepatch_mod_init():
>
> #ifdef KLP_PROVIDES
>         patch->provides =3D KLP_PROVIDES;
> #endif
> #ifdef KLP_OBSOLETES
>         patch->obsoletes =3D klp_obsoletes;
>         patch->nr_obsoletes =3D ARRAY_SIZE(klp_obsoletes);
> #endif

good point.
I will update it.

>
>
> > +++ b/scripts/livepatch/klp-build
> > @@ -21,7 +21,8 @@ shopt -s lastpipe
> >
> >  unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
> >
> > -REPLACE=3D1
> > +PROVIDES=3D0
> > +OBSOLETES=3D""
> >  SHORT_CIRCUIT=3D0
> >  JOBS=3D"$(getconf _NPROCESSORS_ONLN)"
> >  shopt -o xtrace | grep -q 'on' && XTRACE=3D1
> > @@ -132,7 +133,8 @@ Options:
> >     -f, --show-first-changed  Show address of first changed instruction
> >     -j, --jobs=3D<jobs>         Build jobs to run simultaneously [defau=
lt: $JOBS]
> >     -o, --output=3D<file.ko>    Output file [default: livepatch-<patch-=
name>.ko]
> > -       --no-replace          Disable livepatch atomic replace
> > +   -p, --provides=3D<id>               Set the provides id for this li=
vepatch
> > +   -r, --obsoletes=3D<ids>     Set the obsoletes ids array (e.g., "0,1=
,2")
> >     -v, --verbose             Pass V=3D1 to kernel/module builds
> >
> >  Advanced Options:
> > @@ -147,7 +149,6 @@ Advanced Options:
> >
> >  EOF
> >  }
> > -
> >  usage() {
>
> Unnecessary whitespace change

will update it.

>
> > @@ -235,6 +254,37 @@ process_args() {
> >               exit 1
> >       fi
> >
> > +     # Remove duplicates from obsoletes (if specified)
> > +     # Note: provides ID is not added here; the kernel will replace
> > +     # livepatch with the same provides ID.
> > +     if [[ -n "$OBSOLETES" ]]; then
> > +             local obsoletes_clean=3D"${OBSOLETES//[ ]/}"
> > +             local IFS=3D','
> > +             local -a obs_array=3D()
> > +             local obs_id
> > +             local already_exists
> > +
> > +             for obs_id in $obsoletes_clean; do
> > +                     if [[ -n "$obs_id" ]]; then
> > +                             already_exists=3D0
> > +                             for existing in "${obs_array[@]}"; do
> > +                                     if [[ "$existing" -eq "$obs_id" ]=
]; then
> > +                                             already_exists=3D1
> > +                                             break
> > +                                     fi
> > +                             done
> > +
> > +                             if [[ "$already_exists" -eq 0 ]]; then
> > +                                     obs_array+=3D("$obs_id")
> > +                             fi
> > +                     fi
> > +             done
> > +
> > +             local IFS=3D','
> > +             OBSOLETES=3D"${obs_array[*]}"
> > +             unset IFS
> > +     fi
> > +
>
> What's the point of this?   Do we expect duplicates,

Duplicated ids are indeed a user input error (e.g. -r "1,1,2,3") and
should not be expected.

> and if so, wouldn't
> it be the kernel's job to handle that?

On the kernel side the duplicates are safe:
klp_patch_replaces() iterates over the obsoletes array and compares
each entry against the other patches' provides, so a duplicated id is
simply idempotent - the only side effect is duplicated ids shown in
the /sys/kernel/livepatch/<patch>/obsoletes attribute.

Silently deduplicating in klp-build was masking the input mistake.
Agreed on the fail-fast approach: klp-build will now error out with a
clear message when duplicate obsoletes ids are detected.  The list
passed to the kernel is then guaranteed clean, and the sysfs side
effect cannot happen.

--=20
Regards
Yafang
