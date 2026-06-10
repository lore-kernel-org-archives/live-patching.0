Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5732DF6F6
	for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061936; cv=pass; b=IVIqmoR5u85Wj5zlVZb3vhXe1cUOFSh+LDu7wYMfGUilYvtYI+iWu+f1d2rhHyV3uTCafG9/U43z06wnW8eISfkhM4FweDbiVhXyCXN3XQ4/Z4OORwkTaPxDnkcRFBUKMivWsMzL412iUJFpHfiSc6f2n/gRqF5/IQwRwtfoyso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061936; c=relaxed/simple;
	bh=jYMBBkte/N4PwigeIb8G5mnr3X4cQDrMJR8EycAdM+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEuEdV2tsaN9FXJkxDa57VcWCqK6iYJ6lVofWLWfputb7vNGHfhHJRkOjW4eFRcvAf6ZhMv0Opnkx3MbFhUCfjLtWwBmv4pdGk6fznMbEFwyQ9zoFHb1egioOATAmDb5tVSUVPfagCS2+IIqD3EecWZQdrbbftoUF/QuTnzCM70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5tNGnSx; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5tNGnSx"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7f015f87fddso33395227b3.0
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 20:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781061934; cv=none;
        d=google.com; s=arc-20240605;
        b=CCOT10HIZptY6qJ+vjdJTgw9Ubmkd5934sHut7/fIJXNFeUk1hykH+Fs+2vTW4jt+u
         TjkYNwoXuEdMnhIpBPCd+HM8H0g6tyBIQbnFxPYjG9oerXWtI5ymwjKnEf11OuToPSZN
         mVfNo+mFPTm1KJpQ9NtjhygOFqEjg540Bu1Gn0xqHyOzgy09jTEcsLpq8wqcaU98id/k
         ssjNl8Txg8/sHC2lSoLbiWS2/+Qi2LhJwEDwTaoyKuZYkyJkGNmBcIZxiMgjnO23N9wn
         WPdg0Xfti5dwCvuhX84DNeOvo/3qOLfdlvrtX2aVe0T9NyGLi35FL1mbsZ8ODFUWkvS5
         Jgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SH9vL0ftw6jmGVqDRega63hOdVqrTpJHcl3LcaaWWzI=;
        fh=ESqwOa5A1K0rZYoX0JVkjO4VBgFoVNOHhC3bN0xp3TI=;
        b=E3qZ97ZI3igqSguYuJpx6jSl81b9w3FW6LF1RzqnZ01SIFcVsb3+g3DFAAevxiEY0c
         FG0G14gghqg9TRMpS8B/VTtQhNll+GLQpsLfZfsikc5zOh5X7mWmfPN55Nu46s/M/8HO
         De/akRIcyyFaiOdJUdlo/Zu6KAxKkSAcOcO9Up700t0xMp6nMiUYc3klLdbLrTAt1roW
         rRa68QdbYZ/EoGLtiIMDVDhcS5GlIRHS/XSMW0X/ralPg1HTcqNJwp9LHlJlVqXwN8Sl
         cs25gTl74ldnJmCfwjjym6Y3gr99tSFHP2ENoVSiq2Pf2LE1/GEJDfrRgDCAYsBb2P1P
         vY1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781061934; x=1781666734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH9vL0ftw6jmGVqDRega63hOdVqrTpJHcl3LcaaWWzI=;
        b=Z5tNGnSx9FlIQZ3N/CZc7RZvPxU/VGQcpgLDXS1Gl/G8CkTTQUPftSotBRBQ9GfnV5
         5CQ9gyh0ht0lR43W2zqiwANanNZRSIPPUQ9uHAUTclAgiBAkf3U0NhQGbGsw/6f/m76q
         1NU2ObFpk3wg7DU2J3/8+HdzXb5gPszgx7ETYDURP4jMvCprcGEPyQ9lkkhdsufnHWZ+
         j4m1f+0ocZ6LU/5aqXC1NBUl4OAa7dViLFRPurZyWQMKJud5DuNqM79o55vzglSJOtpX
         0wjkwnaY771+yP2vZfRrv6B8D1P/fqE2hqY/7OTNIDCrV9hVjfYeflrpDwVM9FSPsgV1
         oomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061934; x=1781666734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SH9vL0ftw6jmGVqDRega63hOdVqrTpJHcl3LcaaWWzI=;
        b=g24cQ9T3nr82CuLz/lIzSRAGeX6l4v7HqmCmG/KGogour7XSV/jy2IPoVWTiG8CayV
         4xYIihhRSoKX6g5mstzomg4Lt4b2s6l8wgfNpBAHcuR3HrI6kRHEB/qbh+sLsj+joRKz
         d3cLym9zmdpKwWpPPA8b0O9pb6zSaZ0yMoHv/G37nGP7qfTkVJMMIKKQX+aV9ClbPcsX
         cDBZjPYRlZOzcyISX/z7YNRQahrjxsRYBLtynJOpUyEUs39+otGBtrpmIg4tUTbgN6IB
         sRQ3U7j9fpEKOdmDSWIk6kIwmS4Epk2KEybRzQ2pwund6+Jl8aTicVozohuHtevgy+ga
         EKBg==
X-Forwarded-Encrypted: i=1; AFNElJ/oug7NxG0CholmroXZHrWVdaYByCcN0Scs6JNZQqvGEiPVC3WCn+rvfsCv49Ew4OoW2QHjN37TvDZ6F+1C@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRGfvXAzFCtKjBC5trEXrq1+BKS+0/dtls+NWwwriaV9MGtMq
	gJPHS9b+nR1fWWfCSaYkkb+5umIdC7W2p+U+S+y3HC7DAVzWmZbnPXW8+d+S1++XOJ/pOJTDlNl
	JSewJSb5+tYiWbGRQEYLBZvZ+9lOnEPk=
X-Gm-Gg: Acq92OFHV2/CJGo/taAblxZOwx3xkSUKz1zUe1jDNFiiCAPF/w0WeXcwPH2GANFvW0s
	TWOFLVbAAb7TcJ8C6TSp7zVAINrG7ECN7ubQ7v5lOqYVuImqgDyEmXSNVXw1wPZLsE8PpD3Gk5W
	2MNzDe3kpQoa0etv6DQFRlnuYv/rPO/4+6KNq2I80DvaodP4XEsME8JdoaN1yWMRdKIZqwRzxsT
	jYpYN+LGkkYkoJgyjS+cTOF8RdFZL6zcrKOlXgfgJU4hKCMwggaTkCsNfhFlXwzD5VD5jxknYlY
	MWuS715ng46NtflGcKUeDlb0AcV2y/+IKsnzB5xuJSpf6MDByBM=
X-Received: by 2002:a05:690c:4d8a:b0:7bd:a94b:5df5 with SMTP id
 00721157ae682-7ed5097a77dmr165133407b3.8.1781061934360; Tue, 09 Jun 2026
 20:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
In-Reply-To: <aig4smgme6DR8pfs@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 11:24:57 +0800
X-Gm-Features: AVVi8Cffdtl3IGED-_JgqhUYnT-T9biq9nrbxx2k87tjb64F9ypv_dZKo4uhw5A
Message-ID: <CALOAHbD6q0By=NZ2Lk0SAFjzpJ_=AKPLdVqd5T09PiKsppiwOA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 12:00=E2=80=AFAM Petr Mladek <pmladek@suse.com> wro=
te:
>
> On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > Convert the replace attribute from a boolean to a u32 to function as a
> > "replace set." A newly loaded livepatch will now atomically replace any
> > existing patch belonging to the same set. There can only ever be one ac=
tive
> > livepatch for a given replace_set number.
> >
> > This change currently supports function replacement only. Livepatches t=
hat
> > belong to different replace sets cannot modify the same function. If a =
new
> > livepatch attempts to modify a function already modified by an older
> > livepatch from a different replace_set, the loading of the new livepatc=
h
> > will be refused.
> >
> > Similarly, for the KLP state, livepatches belonging to different replac=
e
> > sets cannot use the same state ID. The system will refuse to load a new
> > livepatch if it uses a state ID already in use by an older livepatch fr=
om
> > a different replace_set.
> >
> > For the KLP shadow variable mechanism, developers must assign unique sh=
adow
> > IDs to livepatches that belong to different replace sets.
> >
> > Support for replace_set compatibility with KLP state and shadow variabl=
es
> > will be implemented after Petr's KLP state transfer work is completed [=
0].
> >
> > Other user-visible changes include:
> > - The non-replace model is now deprecated
> > - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
> >   /sys/kernel/livepatch/livepatch_XXX/replace_set
>
> The commit message is not bad. But the patch is breaking the backward
> compatibility. We should explain the motivation first.
>
> I would write something like:
>
> <proposal>
> The practice shows that the current semantic of the patch.replace flag is
> not ideal.
>
> The atomic replace is disabled by default. And the no-replace mode allows
> wild installation of many livepatches in parallel. The author and
> administrator are fully responsible for preventing problems caused
> by producing and installing incompatible livepatches.
>
> The most safe atomic replace mode must be explicitly enabled by
> setting "patch.replace =3D true". It is all or nothing. The livepatch
> with enabled .replace will always replace all already installed
> livepatches. It makes it very safe but it might be too harsh.
>
> Improve the situation by switching "bool .replace" flag to
> "u32 .replace_set" and and updating its semantic.
>
> Any .replace_set value might be associated with a set of livepatched
> symbols, callbacks, shadow variable and state IDs.
>
> A livepatch with a particular .replace_set number will atomically
> rreplace any already installed livepatch with the same .replace_set
> number. By definition, there can only ever be one active livepatch
> for a given replace_set number.
>
> On the contrary, livepatches with a different .replace_set number
> must not modify the same function, or use the state with the same
> ID [*]. Any attempt to load an incompatible livepatch will be
> rejected.
>
> Summary:
>
> The most safe mode when any livepatch replaces any other livepatch
> will be the default. Note that all livepatches must keep
> .replace_set =3D 0.
>
> It will be possible to install more livepatches in parallel by
> using different .replace_set numbers. The livepatches might be
> updated independently using the atomic replace feature as long
> as the new version does not break compatibility. The kernel will
> reject a livepatch from a different replace set when it would
> want to modify the same function or livepatch state from
> another replace set.
>
> [*] The compatibility check of callbacks and shadow variables will
>     be improved later by reworking their semantic. There is a work
>     in progress, see [0]
> </proposal>
>
> > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter1=
2 [0]
>
> I have realized that I actually sent "v1-iter12" to the public
> mailing list as the official v1. So we could use:
>
> Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/=
 [0]

Thanks for refining the commit message. I will update it.

>
>
> New idea:
>
> I have briefly discussed the new semantic with Miroslav when I met
> him in person. And he was a bit concerned. We as an OS distributor
> might want to be sure that our livepatches can be installed the most
> safe way. So, we still might want to preserve the "replace all"
> semantic to make sure that our livepatches will not break anything.
>
> I though about 4 approaches approaches:
>
> 1. Make .replace_set=3D0 special so that it will always replace
>    everything. Similar to the current .replace=3Dtrue mode.
>
>    Customers will still be able to install custom livepatches
>    later with .replace_set !=3D 0. But the "0" livepatch will
>    always wipe them out.
>
>
> 2. Use two flags in the livepatch, for example
>
>      a. Rename .replace to .replace_all. The livepatch with this
>         flag set will always wipe all other livepatches.
>
>      b. Add .replace_set which will allow to install more livepatches
>         in parallel, replace the livepatches with the same .replace_set
>         atomically, and check the compatibility. As described above.
>
>     It is a bit more complicated. But it is more compatible with
>     the current state. And it removes the special meaning of
>     .replace_set =3D=3D 0.
>
>
> 3. Introduce a system wide flag, sysctl livepatch_replace_all
>    which would allow to enable/disable the replace_all feature
>    of either .replace_set =3D=3D 0 or per-patch.replace_all flag.
>
>    It would allow the customer to preserve their custom livepatches
>    when they know what they do. For example, when they use the livepatch
>    to modify a 3rd party module or tune some functionality.
>
>
> 4. Just taint the kernel when a livepatch with .replace_set !=3D 0
>    is installed. Then the OS provider could say that a tainted kernel
>    is not longer officially supported.

Since the kernel is already tainted with TAINT_LIVEPATCH upon loading
a livepatch, are you recommending the addition of a distinct flag,
such as TAINT_LIVEPATCH_REPLACE_SET?

>
>
> I personally prefer the 4th solution because it is simple.
>
>
> Best Regards,
> Petr
>
> PS: I still have to review the actual code changes. I'll do
>     it in a separate mail, ...



--=20
Regards
Yafang
