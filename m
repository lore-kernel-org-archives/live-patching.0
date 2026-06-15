Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8D3F7AAC
	for <live-patching@vger.kernel.org>; Mon, 15 Jun 2026 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526688; cv=pass; b=T0MTTvPjeH/1lciHoy+Hly7Jev87Aahd6Ds6Iqh3JGCGxl8T9mhDqNyxITWERLWo4HfO+nmHoSaIVmBxXUJ4m7vNx4U3oyfs3++BLHjRMrGekuTh4mCt4smEnzYpTh9V/YJ2iec7iAEh1PEofzuAg2sAefSMEgQj/l9O2zz6Rxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526688; c=relaxed/simple;
	bh=EW8C0ZSHrNOSItvj30JnFkyzU6tGl36bZn+gfzS68I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjrxWRrqppYYLVxYgHRrgEEUYwaU1oRh4THxIZ3J5PeVcbADYWnDLN7XYSRScRTHEhxtDv5/GoipWk+Lrfo1jr06Z1U8TL1FPI0Qsq8FY1qwSgUzBBwm6W03g6Z+1ydaK/s1lpUTSdZBD0PvTmYBDBvt2ADLwEaCKQ9Kf7tc0qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYIFXn+N; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYIFXn+N"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7de68222e96so23117207b3.2
        for <live-patching@vger.kernel.org>; Mon, 15 Jun 2026 05:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781526678; cv=none;
        d=google.com; s=arc-20240605;
        b=DvLIhvacVSlItf6UIxS2gU2dSF+Y6yUhEfROlMFfD6XonRMtRFqU8Ek6Tex4VUV0tP
         vG2BoYzL3V2+4P6+9FLweLSRB0xm9++WQN5ziguszkB5V5ULubgxtoT8EJcn2DRW+wPd
         Uu2mE7ICe5HzLsrtyya6zqFL3x5pk3WLUQXsaKl5xMSZpcNkUyPKAuocNrFXVrEVn2Ua
         EeUbn3c2D2eCpZO/XyoxId3HVZcKqCaT0c0lYVagga1nQ9wDZEg9IlGmn5i6RQNPw589
         muBKpndFGnQv9DZna04xdlvEy6v0B/Uvo61puh+cKg83PO1rxb98cm4wRTddl8+f231W
         8A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JffxgVmpVGJDXnwFYgi7vbNatBZ63lQAh3zjUKY7sS0=;
        fh=SHAmIaiERrqEmmJEh++1N56pUETpuhU7emjZqK/+Mz0=;
        b=SNQvB/t2vHHBvBboXgatGJif4CAh69ml6YgO3ZmhVr4YhJj6Ly6+b/lKK8Op2NlPIe
         6AFTk5UIw7cfM2Q4o+wdQUBFCKnOD3J7OQNvXNvTzpXkwJ/B5zANW5XwKlomaTz4Ss3q
         VQxY5LaEd5xr9ILO10QI0rTVodrT9qMLpr7s0tWsjhy9llzWw7NxwnLjg+0fFcei27W4
         uQyXAzfhjBl6+Mx7+jPqRb0BoC9zmROZZGPl0HRMAQaOFQU/0BgFwTEk+xEra260Mn+0
         zbEmo/v4Pl9CDx4N9BVlD58PQ1idd/NDKitrlC17FaTryagC2ucUFkXSkId/xT2BjkfG
         qTcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781526678; x=1782131478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JffxgVmpVGJDXnwFYgi7vbNatBZ63lQAh3zjUKY7sS0=;
        b=bYIFXn+NQpVgt6A5iPe+RvX8U0BbTZTrc97NKAIvQ2Nk/Kpr8naZQ6DdNuhOus+fJ6
         oGAv0v4O1XFFNTAqSfyFc8jOzPssPkKzQrtqZxO3wehQ7Xu9L5Y57ZNBJmPRdsLpb4EJ
         3GDJtp1QWfZnLx86H5uHKCV3tU/WdErThGewGjBV5SdRp9z1dacsJYQmw3itgewG9fr+
         NAULxXpj721PVtPhXp83dtmb+RUB6M0uQj5xhJqzsw4sqbvUqlTdNt9aWPJR/Zuten8I
         uR4KhieU8xvW87+m8k2nTCIS001FGbeMzxG36KaFAElVpY2KcSPrd0GIvNVEJ2S2I2j8
         wFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526678; x=1782131478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JffxgVmpVGJDXnwFYgi7vbNatBZ63lQAh3zjUKY7sS0=;
        b=cD8CiN7ugm9K5O6oywH8qGxt+6Le3FhTSIy821CN1I0/6kltMP8tMefcNrBzY8F/uf
         BOMqXeOS78Ut6vHJMsSolzZBqfA3Rblyg+thOF5Hy3utSQzCDat9I5u1ZaG+ImmOpdDn
         CmrmpMagu3GEC+F2ePiSJ1ch5d+A9lUkmOb7Yjp7PEeIhD2zfcaVMRD+a/hGN+97rbYm
         mYYBVzpWc9tq9s5uMZ9mXts3MBfXPJVU4jjO/fdA+Pg/FUtFx3LRLH/Ip2SgJKPTV8u6
         QX2auvthgG6p4S6a3bLITHcuh55bSE2a3vko8BqtzZ+GP9oFwjse7+HaXVg/RKhbPCZ/
         MP6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9JX+tC+bRPbEQS/xJms3noNus/EbY/3R4YZ6Ca+So3ciGGtynjrWyBFZWRykmu3WkEFmuFZ3BEEjA22n4f@vger.kernel.org
X-Gm-Message-State: AOJu0YztaQmdRdezdY/N9UR5JkytL4cpy07XkoaC455pCPhcR8q9uoqw
	Cn0j/9oBMBEr698Je7CyNCY0mVYLVTgWfIHgEB/q5QLSltPdpPyrux0NDray+2olJazqVQ9nv32
	F1GftwbOrVI4tUSNspgnjVuLWariDYr4=
X-Gm-Gg: Acq92OHdzuxdAWDsKXxDAnexw/hrSAri+myPL63b6iTbVRFTndKzyj2vkUAWZxdmmvD
	flkjNWbGN+ekYKuP30a6N8GgEaO8bkF8AxmmfulrP96BW1J6nJiJP5QOoexbr9QsIAjEtCkTSss
	ClD66ePS4FdER4yaklYkaKse2uwFoShJoEb12jXCm35BwVJQDxoBhaZfk25dvWpIblUYqyvqX5i
	R5tbeWS4J8xJ5ZygWztf5g0lED8FniPbkG7IP07XlL7Mwq2JLb1IFG3gn0sRTJL4BQbEd7MNXGF
	vni/7m5CoCwdnAbqOLF+CAXNiqyehVW3LBPDza41fuYNYWhysp4=
X-Received: by 2002:a05:690c:260e:b0:7bd:9f34:59a0 with SMTP id
 00721157ae682-7f7bcf107b8mr141254237b3.23.1781526677650; Mon, 15 Jun 2026
 05:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz>
In-Reply-To: <aiqw_74v-1_2D9rJ@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 15 Jun 2026 20:30:41 +0800
X-Gm-Features: AVVi8CdXyiDHvYLckWMtmvnsTcC0YcCcxDPzDdO-I4_r7VyFbPRsbXrgL3MhCSQ
Message-ID: <CALOAHbDkv3yLsHKfAPE_u73jpDZYHYsk0rsuy_2e=HhPuaE56Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:58=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > I would write something like:
> >
> > <proposal>
> > The practice shows that the current semantic of the patch.replace flag =
is
> > not ideal.
> >
> > The atomic replace is disabled by default. And the no-replace mode allo=
ws
> > wild installation of many livepatches in parallel. The author and
> > administrator are fully responsible for preventing problems caused
> > by producing and installing incompatible livepatches.
> >
> > The most safe atomic replace mode must be explicitly enabled by
> > setting "patch.replace =3D true". It is all or nothing. The livepatch
> > with enabled .replace will always replace all already installed
> > livepatches. It makes it very safe but it might be too harsh.
> >
> > Improve the situation by switching "bool .replace" flag to
> > "u32 .replace_set" and and updating its semantic.
> >
> > Any .replace_set value might be associated with a set of livepatched
> > symbols, callbacks, shadow variable and state IDs.
> >
> > A livepatch with a particular .replace_set number will atomically
> > rreplace any already installed livepatch with the same .replace_set
> > number. By definition, there can only ever be one active livepatch
> > for a given replace_set number.
> >
> > On the contrary, livepatches with a different .replace_set number
> > must not modify the same function, or use the state with the same
> > ID [*]. Any attempt to load an incompatible livepatch will be
> > rejected.
> >
> > Summary:
> >
> > The most safe mode when any livepatch replaces any other livepatch
> > will be the default. Note that all livepatches must keep
> > .replace_set =3D 0.
> >
> > It will be possible to install more livepatches in parallel by
> > using different .replace_set numbers. The livepatches might be
> > updated independently using the atomic replace feature as long
> > as the new version does not break compatibility. The kernel will
> > reject a livepatch from a different replace set when it would
> > want to modify the same function or livepatch state from
> > another replace set.
> >
> > [*] The compatibility check of callbacks and shadow variables will
> >     be improved later by reworking their semantic. There is a work
> >     in progress, see [0]
> > </proposal>
> >
> > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-ite=
r12 [0]
> >
> > I have realized that I actually sent "v1-iter12" to the public
> > mailing list as the official v1. So we could use:
> >
> > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.co=
m/ [0]
> >
> >
> > New idea:
> >
> > I have briefly discussed the new semantic with Miroslav when I met
> > him in person. And he was a bit concerned. We as an OS distributor
> > might want to be sure that our livepatches can be installed the most
> > safe way. So, we still might want to preserve the "replace all"
> > semantic to make sure that our livepatches will not break anything.
>
> I thought more about it and we would need some solution to preserve
> the replace_all functionality.
>
> There were recently reported few serious 0-day vulnerabilities.
> We discussed a possibility to ship a quick fix with a livepatch.
> Or that customers might want to fix it themself by a livepatch.
> Such a livepatch would need to be installed in parallel to
> the official livepatch fixing older bugs. But the next official
> cumulative livepatch would need to replace it.
>
> The above scenario will not longer work with the current
> "replace_set" handling. The hotfix would need to use another
> "replace_set" so that it can be installed in parallel.
> But the next cumulative livepatch won't be able to replace
> it because it would need to modify the same function.
>
> I consulted this with AI (claude-sonet-4.6) and it gave the following
> feedback/ideas ;-)
>
> > I though about 4 approaches approaches:
> >
> > 1. Make .replace_set=3D0 special so that it will always replace
> >    everything. Similar to the current .replace=3Dtrue mode.
> >
> >    Customers will still be able to install custom livepatches
> >    later with .replace_set !=3D 0. But the "0" livepatch will
> >    always wipe them out.
>
> This is not ideal because it is asymetric. Why is "0" special?
>
>
> > 2. Use two flags in the livepatch, for example
> >
> >      a. Rename .replace to .replace_all. The livepatch with this
> >       flag set will always wipe all other livepatches.
> >
> >      b. Add .replace_set which will allow to install more livepatches
> >       in parallel, replace the livepatches with the same .replace_set
> >       atomically, and check the compatibility. As described above.
> >
> >     It is a bit more complicated. But it is more compatible with
> >     the current state. And it removes the special meaning of
> >     .replace_set =3D=3D 0.
>
> This looks more straightforward. But the fact that "replace_all"
> replaces everything brings back the problem with the original
> "replace" flag. So, it makes this whole exercise more or less
> pointless.
>
> I had another idea with storing list of fixed bugs/CVEs in each
> livepatch. Independent fixes might be fixed by independent
> livepatches. Then a cumulative livepatch would replace only
> the livepatches which fixed the same bugs before.
>
> And (claude-sonnet-4.6) came with an interesting simplification.
>
> We could add:
>
> struct klp_patch {
> [...]
>       unsigned int replace_set;
>       const unsigned int *supersedes;   /* Zero terminated array of repla=
ce_set IDs */
> [...]
> }
>
> So that the cumulative livepatch might optionally define
> another "replace_set"s which would be replaced.
>
> This would work well when both cumulative livepatches and the hotfix
> are provided by the same vendor or group.
>
> We could also allow to change it dynamically by adding an module
> option to the cumulative livepatch, .e.g supersedes=3Did[,id]*
> We could add some support into the kernel for handling the module
> parameter a standard way.

I prefer this option because it allows us to dynamically set the
supersedes at runtime, avoiding hardcoded values at build time. This
flexibility is essential for handling complex production environments.

>
> It is not trivial. But it is also not horribly complex.
> It looks like a good compromise between the requirements and
> code complexity.
>
> We really need input from others here.

Happy to hear what others think as well.

--=20
Regards
Yafang
