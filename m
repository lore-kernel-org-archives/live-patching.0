Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0267282F14
	for <live-patching@vger.kernel.org>; Thu, 11 Jun 2026 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148108; cv=pass; b=oX6WYoh8mec8KwfsMZAvgaYYkudFxlc3HtLHL58cjvLEYllRhCVw5Ycm4a8b4OwgjIXyK1vOtngtL5fIK27+GJRFROLPz9RLU7GMH11zonwkkMqPX6z6u9Ft5m4RR5X7q/z/JaOgT2akZIXwkja1CrX34Qwejv96zFlgRJvJS2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148108; c=relaxed/simple;
	bh=z8G9dLyul6y07UYZP4YcTQA8CqfU0jdM0jdxp8Ud6mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuFSA2O3NkiZBBntZ6g/2usdxiDzCMVSUHARtdejtUGv2wbpagusyF1fl36xWYTEke8XNa38g6CAwYlaB+wF9vxZIt5I7W+vMQa+yeVauraoE9AAu2Y3G96/NvKVKZHSQo8GqsrC8w/jGDr/Qw+rA9NEZcyBOaZtr1c714+RQ8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZRcgsE4; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZRcgsE4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e8833c99fcso83952377b3.3
        for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 20:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781148106; cv=none;
        d=google.com; s=arc-20240605;
        b=kWfnr/qOmqfq5wkc7AOTY+TG/EZwu2j43Pgby2dGb8+A3IvYkwzKK5GUhbK8TRVTK5
         m/wPfsft75BzT7zaAmp9mLM4h/x7v1fLwqrFX5LPvhvzLeUAf0thVzVxMuuzpJFalE3t
         0OVYxIJ917nCm+F1SrP7nnE1wm3J+gogEO0JJ5uiRbc7Ax4rXgr2qFCyjPLAvLGOZmQr
         M7MrAeENqVAQv97U5UfBYgIEEqOe55THu3cwuiKKOCySagdJrL8+PgOsqh8mtaO8hoY+
         LPGjHuXrTGcDPS8SC6WyYu2C+drKQNqWjnFxZFwTsuAbapBB3EFdHz43ue2xJHoCPTWt
         UU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEWBE+UEG5PjyAd8Uj+y4ssjNzb0y9lPyLT5O97AFaE=;
        fh=EAtCLp8Wq7zBaGUyQN8imw5h8Sd0gSzW5Z+0iJvw4ns=;
        b=YIavJh0XLfcU9DC2pRBDH1M7BEJh6IArwu0E1WJcJLoxH3z/c5+/6UTYUiAu4vUgFZ
         lPAenjpRUwQ0ccvuR1UapE91l4eEJ9hjRcU+Vo/ZwFcOG9a0PUjwkqqYEx4il5GzK/jd
         dIxkUvlCOBTLEzBDkxAU8BSElWtH7gFsXCEDK69C9BhsJHfksGtW+wAcYTGFfxk66BRV
         Pw4vCtz9oz8NLSGBt+WbhM7NcijBtWn4JwtMBeBDKnETtlyqopuFcd2NWE/FyslXjJCl
         eo1ttig1NbeOVv31kujRs8vnKXsLRFnVzNXqSWEpJ9Wd4x8frPXGv2/XRm+cjjs8U7n3
         07Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781148106; x=1781752906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEWBE+UEG5PjyAd8Uj+y4ssjNzb0y9lPyLT5O97AFaE=;
        b=gZRcgsE4ev5FeVqAzOO6wlQe0nPI0C3Nx7DFVC4tE1L+L6JUZxdfjukFtfc0EIo3O+
         MuaJA6++u6u4Y1r5WTT3AUsF0I0qDXnGEBv4wTcgD+01QBpZ+iMHyqk77uTe8U33ab08
         z84voCYCnOzhe4EcwP76ivmky2cYRVp645JSuyMfudQmiLAtefZCDNoXZbVryHP22U1X
         FFYMVfTa4dET+TWzdtzKKYDx0/OkIG5SEt/mKnzUBcJ7dOoHeCw+hKhmIe/3n/OR4Sl+
         zyWcPN/VZInz28a+hN4E5v9qh1SfJUTEqDRWIH/eUbSCJleS1tXJwxuzxbTi40U5lp2L
         DDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781148106; x=1781752906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEWBE+UEG5PjyAd8Uj+y4ssjNzb0y9lPyLT5O97AFaE=;
        b=Vd1z/Sq9w/daqE73ROwCLG0zbEGl7qnYtvG/+hBAaz7jYh8BOKsc3SFx/k0R4jceR7
         wXIjNAQiGw52Q9hlVz+kuzX1JQbNXWDG5IQ1j2Q9pPek+iWIMjFD26s0X34rS1A9ubtR
         UWXkV4dbzdBmnqSrJVqqyhsxspAbHw3PvSSlslyoAp48ayA/htSmqHfANN7ftgE6zwIz
         FTHWZ72chVhoJRHsi90UzRTveb/FU+ZLB3PDbabjlIb+R9qR0ukP+t+ogec/ev9XZ0Im
         3bSmilUcQ4FGXGwZGDiBpNy+r3ND+/+hsjU6WjmReIewifR4FfaOFBn1hknAJcO+FtuM
         DCpA==
X-Forwarded-Encrypted: i=1; AFNElJ9D4OiktGFt9KpUnCtEmIprqvLlLSzEBBOq02qFjZq8abkuPzDOefw22k9iPk+4jWZ9nfW9Rzqllmse8mhq@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYuM59KVC56IK1Jop775ocDFqodo0hfWCi1IPpIAMiaiCdssX
	VHaAwEqip55PNgy7fekfKElM8wJUXSZ0YgQH0dJ4IRkYNObrEA/sc/50EHJz4pqWW+y9DwJq+dd
	HW5JwOq/birsj0Jt+tv5fSoEDWIE8KkA=
X-Gm-Gg: Acq92OEvPGWMKoz/ftz51CEoV1SF7sBi6sEIMqPIbg0LAi8DG4Qs2FnJeZ5y7p3BCX3
	tZFWHJCB7Uzykw/67VLz+y9HpWZbxFgNqKk/ab63kFvSm58ntmeND4qXbCIYoSkhba1mPhgyVJB
	2KppIJUbk8XfMTqrv2rj3qhSOfOaNuPJf/hkhTaiWPyBfkxDEMdzaABjFaTk5pe+BfP0xTnVqKS
	y4OrFfpwUMOm3pz4lex9V3+n7LkHCHgQMerROABoK5vao32I6XmSvNhAH6j3il4mUUNwHzKlZgl
	as1A5RBRaEMQut+FWkPs2CyjUyOvW+biMys/HVr6E3gD5k7/P9Q=
X-Received: by 2002:a05:690c:9b05:b0:7db:a5e5:366e with SMTP id
 00721157ae682-7f658028ba3mr11368407b3.46.1781148105803; Wed, 10 Jun 2026
 20:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-5-laoar.shao@gmail.com>
 <ail-mQ77SQR7WkiM@pathway.suse.cz>
In-Reply-To: <ail-mQ77SQR7WkiM@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Jun 2026 11:21:09 +0800
X-Gm-Features: AVVi8CfBLY6GK6kthzDBCEDYw95XWq4auyzGCZOjpahUp1v2LxB0iQOoUkwWbLg
Message-ID: <CALOAHbDgW_4fPktGHNnY-eqYRqg+d76EPTLgH-=twYOtwqA0vQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] livepatch: Deprecate stack_order
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	Wardenjohn <zhangwarden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:11=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
>
> On Sun 2026-06-07 21:16:56, Yafang Shao wrote:
> > stack_order is no longer needed for atomic-replace livepatches, as a
> > single function can only be modified by a unique replace_set.
> > To maintain backward compatibility, print a dummy value, as suggested b=
y
> > sashiko-bot.
>
> I would personally remove it completely. I believe that there are
> only few users around the world. And they will need to update
> the tooling/strategy for the new "replace_set" anyway.

I will remove it completely in the next version.

>
> > --- /dev/null
> > +++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
> > @@ -0,0 +1,9 @@
> > +What:                /sys/kernel/livepatch/<patch>/stack_order
> > +Date:                Jan 2025
> > +KernelVersion:       6.14.0
> > +Description:
> > +             This attribute specifies the sequence in which live patch=
 modules
> > +             are applied to the system. If multiple live patches modif=
y the same
> > +             function, the implementation with the biggest 'stack_orde=
r' number
> > +             is used, unless a transition is currently in progress.
>
> I was not aware of this ABI/removed part. We should put here also
> the livepatch/replace interface which was removed in the 3rd patch.

sure

>
> > --- a/tools/testing/selftests/livepatch/test-sysfs.sh
> > +++ b/tools/testing/selftests/livepatch/test-sysfs.sh
> > @@ -21,8 +21,6 @@ check_sysfs_rights "$MOD_LIVEPATCH" "enabled" "-rw-r-=
-r--"
> >  check_sysfs_value  "$MOD_LIVEPATCH" "enabled" "1"
> >  check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
> >  check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
> > -check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
> > -check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
> >  check_sysfs_rights "$MOD_LIVEPATCH" "transition" "-r--r--r--"
> >  check_sysfs_value  "$MOD_LIVEPATCH" "transition" "0"
> >  check_sysfs_rights "$MOD_LIVEPATCH" "vmlinux/patched" "-r--r--r--"
> > @@ -135,71 +133,4 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching=
 transition
> >  livepatch: '$MOD_LIVEPATCH': unpatching complete
> >  % rmmod $MOD_LIVEPATCH"
> >
> > -start_test "sysfs test stack_order value"
> > -
>
> This is not longer needed in linux-next. Marcos made the test optional,
> see
> https://lore.kernel.org/all/20260504-lp-tests-old-fixes-v5-6-0be26d94ab9a=
@suse.com/

Thanks for sharing.

>
> The changes are queued for 7.2 merge window which will likely start
> next week.
>
> I suggest to wait with v4 until the change is merged. We should wait
> for opinion from others (Miroslav, Josh, Joe, Song) anyway. We
> need to be sure that the change of the semantic is acceptable
> in general.

Understood. I'll wait for further feedback.

>
>
> > -load_lp $MOD_LIVEPATCH
> > -
> > -check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
> > -
> > -load_lp $MOD_LIVEPATCH2
> > -
> > -check_sysfs_value  "$MOD_LIVEPATCH2" "stack_order" "2"
> > -
> > -load_lp $MOD_LIVEPATCH3
>
> Nit: It seems that MOD_LIVEPATCH2 and MOD_LIVEPATCH3 are not longer used
>      at least in this test-sysfs.sh file. Well, I guess that we will
>      keep this test optional for older kernels.
>
> > -check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "3"
> > -
>
> Best Regards,
> Petr



--=20
Regards
Yafang
