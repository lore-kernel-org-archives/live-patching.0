Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB7418A4F
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387968; cv=pass; b=Xb6zpqnAKo4s+sE/d0rko+e4f3MK5PxBU8lh7whAzTuLNevdrkdIyZZ9PxierTew1PVRmOP/xczZzG/2PtJl8mtl6MpDzAQX6Gs4Okg4XgOxNAXhwc+RrpeKx8d5Yuyxj/AQ1/KFeIa92BVNu7fikEkEEjRMQGWGS4mrqATW6qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387968; c=relaxed/simple;
	bh=ryQcQuPS+2XmD1NaNExEeSnELndx+edUOJaGhyzXc1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsOwgAj/DUZAdKsbnSkfZF6e25vscbh8slorGgGcvVJ6FPtChKnKheauV95W+KH3ot4zzkaasXd9UtMpIh0QmcgaHIRtDE1QInPA7302k7PCfaJrwAIXFJJLNU92fkxJzFmYoLZehI7w4fikLYA/CIKTsCopQPH/bVCdPWUrYHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcgrXCvz; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcgrXCvz"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac6072so13823707b3.0
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 05:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789387966; cv=none;
        d=google.com; s=arc-20260327;
        b=iMKInIphcuCourhx3+K9Fv1K3EOwUWvA9ENu0P2nRZYeS5rhSrdblSjDdzcqfO9ggl
         c3i78wQFiCx6BhUn7DBSQowFzLWzGPFycEPPdrE2ZtaRMaVhcKvhLOgfKihSEUkhY2iD
         PbszwgwmCJ6cvowhQScfUBMepYvl/dmJ7WUVk0Pt23ncHimoHfEJp9vW3sx/8vAEU91z
         EvLD3RKTq92KAHdDJRZR/gyWhPRY+J1RUVjUlJaW0qvM8zqFIaAXqK6Y0KvBFO13ybI/
         ul91F5rIlF1dqXoPbegnzgAhCYX+gze9JdIff9TIDHeaarNagnZfl/hMAAa+FqVbp3rK
         VfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7BIAvMWopcvY6eMkSv6Lr9DtxhYMnsNqKS0qpVHpq28=;
        fh=UrllmnkA2iDUetd5NSrpOZYnxiQmox6gxzBybfdv1HU=;
        b=V9r1v5dxN8P4nycXXBigS+h7DnMVNblDt3zCle6E9cgwwnGv09JgbnGeqYZEk4LtEv
         YHr4dsXxI0/3RpnFZJWhjHVQYI5ow2RmiPWL7xC1az4Pur8u2D5UBcQQu3QYScSCDHQy
         e+QitGrPmS5v16w47jgWlw7cGz+zeaG8Q2oXbi0wJBPLaRqih5TnINKQpE2iKL0kbi0R
         KzzMc5N0R+CIzfEUlLxALly2fUdD1XBugOj+EdwuZfM42o2bHcQ/9MYCer0ZwAHUaD97
         pD/b8y0K1OuTVom007tfVIBXfdhOvwz8QhtyyIfJz/rXqg/FjcK6M6pFz4u1es1/dJPu
         Sq1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789387966; x=1789992766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7BIAvMWopcvY6eMkSv6Lr9DtxhYMnsNqKS0qpVHpq28=;
        b=HcgrXCvzff51S3oR1UKMRiO0OUdUV9ohfusNKbHe+TpLybMoNc6CrvbJ8wYVxUg/iO
         y5RjR7puUk/c0ZmY5jK+BQqVrf9MfZty8WiF632l0omdiqEaQvQUqHuSA3vqubmBHwf0
         Ygf2xQxNOaTfSDBsZ8lvYZW0Ssrh9iv2D42ZBzO/5cajhbOQUHaaOWy0gxWdCzd6Ymem
         ZCEPlGYfonAykDPI1r+/mVSwlWT4TAOZElcVldPik6vfffaOAA3ryW/WcTaOZKhjOFLi
         ENI62LnLcEBh8lWPrM+fI8NKTS7tKBRrugguplIJID6iUQx1k/wQgarazj1Ibutl9POf
         uJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387966; x=1789992766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7BIAvMWopcvY6eMkSv6Lr9DtxhYMnsNqKS0qpVHpq28=;
        b=ceNaUDCI/Khun1lUkrMZqD4fUvMo1NMsjeRohm+3QycERzIn1M4k6w3VCJPUpTAl9c
         V564zqKHOCQ4YS5oQIbtV4DKtLa65bFil41W2Vwg5BXBIJEG0RKFHMTODLdOomX6GK4f
         PBbCC/N5MZhdY8yXsdV23mHm1YG9GXS3VOXKDnAzrZFXe3zIUmqk48gBEN5vSbaKF88P
         lRm4LhzZYL2rzrrFWrNztaeoU5M49P2P4pnXT/fQpSnga3tx6E8IOkPDxxqGjNnVfUnA
         Vs+ZpRsT5NeYNoluvPC6X3pSxtJQ7hNMz7/yBLEiFscgRm2r/0PKz7qWuRk0WZqL4Q7h
         8a6A==
X-Forwarded-Encrypted: i=1; AKwUvBx/QMI73DZWQtry+zFnVDat582PxtyE6uNuujchFkQJxj13r674stBWoijF36ISr1W4jra8PWnyexq9mgGE@vger.kernel.org
X-Gm-Message-State: AFuF++lnblHP6nPdCiRJmv9ZS+BHPZtB4zTMnq34MIpEuT4V48eA6HNX
	LKfg3sPSS25lw80peUqlLQ+k7e8ghVBdvIjmnEcXjfXMix/iJWpjDCvcOpMSd5zlzP3LzmL+N4c
	8V8rXCrmspwhGZOhn75e67ApEIyaEnD0=
X-Gm-Gg: AYBFou0PR4KGamoUBnH4xWocYiC9x3ngH86LHDQWpdX5roCxicwWUHLPg6u57YiTT4K
	+j5FQmoICrZIII8qCfBN2UCdm4QGWpaDCXubjOgM7j1/BZ3HtPsFoikxRFWxoSXRRg52XZXCiEv
	J2plDabKTahR3fjfSNjLKtvXqOVzkIjDFr/shoTD61GumSYS5r4jX5C5m5m9ghsguV/+E2llYr1
	xKdhwp3FbJDgdHA3v3V3+RpR4Z0OYVPVp5EKqEN8eoOmW9oC8TR62bg2W1LP30/K/pwZQPfqbhq
	7alSDxPh4uH8IuPUT1dZI2grHzU3HQGhx3hPNU9DLH+nRd/zoq7nldvZsw==
X-Received: by 2002:a05:690c:a706:b0:884:b55c:312 with SMTP id
 00721157ae682-88d1ed2be81mr5233187b3.16.1789387965963; Mon, 14 Sep 2026
 05:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910085218.66565-1-luolongjuna@gmail.com> <aqc5Q4_9bHpAI4jh@jpoimboe>
In-Reply-To: <aqc5Q4_9bHpAI4jh@jpoimboe>
From: Longjun Luo <luolongjuna@gmail.com>
Date: Mon, 14 Sep 2026 20:12:33 +0800
X-Gm-Features: AcwNN1VWIDE0Lm0zG9p9IKWDNgAy2X1r_VfEjrf_Hkil4vrEE1LkGs-9AP2sQ-Q
Message-ID: <CAKL4jwV8ZxAzkZ-0LWP9jzWvfw5-EKFS7LPKiibp5McY4Yubng@mail.gmail.com>
Subject: Re: [PATCH] objtool/klp: Fix missed changes to same-named symbol references
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, song@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

> These seem like unusual edge cases, is this problem theoretical or was
> it a real-world bug?

These are constructed reproducers, not production failures. We have
been working on userspace livepatching, including symbol correlation
under LTO. I built and tested these cases while comparing klp-build
and kpatch-build.

> If the .patch upgrades a function from static to global then the
> function no longer has a FILE associated with it.  Then with the above,
> all callers to that function would be marked as changed.  And note that
> LTO does a lot of that, so static-to-global and global-to-static changes
> are common between orig and patched objects.

I confirmed locally that kernel LTO can change a function's binding
without changing its name.

For context, in our userspace ThinLTO tests, promoted locals usually
acquired a .llvm.<hash> suffix. The kernel's ThinLTO build uses
-always-rename-promoted-locals=3Dfalse when supported by the toolchain,
so promotion need not add that suffix.

I agree that this FILE-based checksum change is too restrictive.
Please drop this patch.

You are right that patch authors need to verify the changed-function
list. However, in these cases the current checksums do not distinguish
the old and new targets, and no diagnostic points to the missed change.
That could make a resulting problem difficult and time-consuming to
diagnose. Would it be useful to document these cases as a known
limitation?

Thanks,
Longjun

Josh Poimboeuf <jpoimboe@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 08:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 10, 2026 at 04:52:18PM +0800, Longjun Luo wrote:
> > Hashing symbol references by demangled_name alone can miss target
> > changes while the instruction or data bytes and normalized relocation
> > offsets remain unchanged. This occurs when:
> >
> >   - A global function moves between files and calls a same-named static
> >     function with a different implementation.
> >   - A function's call target changes from a global function to a
> >     same-named static function, without moving the caller.
> >   - A data object, such as an ops structure, changes its function point=
er
> >     from a global function to a same-named static function.
>
> These seem like unusual edge cases, is this problem theoretical or was
> it a real-world bug?
>
> > +/* Include FILE identity to distinguish same-named local targets. */
> > +static inline void __checksum_update_symbol_identity(struct symbol *sy=
m,
> > +                                                  struct symbol *targe=
t)
> > +{
> > +     const char *file_name =3D target->file ? target->file->name : "";
> > +
> > +     __checksum_update(sym, file_name, strlen(file_name) + 1);
> > +     __checksum_update(sym, target->demangled_name, strlen(target->dem=
angled_name) + 1);
> > +}
>
> If the .patch upgrades a function from static to global then the
> function no longer has a FILE associated with it.  Then with the above,
> all callers to that function would be marked as changed.  And note that
> LTO does a lot of that, so static-to-global and global-to-static changes
> are common between orig and patched objects.
>
> Note that function change detection isn't intended to be 100% perfect
> for all edge cases.  The patch author needs to verify the changed
> function list matches what they expect.
>
> --
> Josh
