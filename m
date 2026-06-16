Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753041FC7FB
	for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577752; cv=pass; b=lRPrZJteHN/SjFywjN+pyrxiDXtjJqEmGXp9BzAd0A5k/Uz96GBSb2uEj3aFw/zhFEzqdcz+P8jh7SWoKPCWxZ6TGx13SiAt61L76qej3o4AQa51GxM9hKp1G3rv2oa2wjc0HgDLBX4VoqgVroTZotIVuZ4mb4kd631q+JTbVgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577752; c=relaxed/simple;
	bh=1kxXAJh2vEXLsf++TQrtGo7zzXgswMyK+awtc+6ufRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZDZ8p6NrzIs93YnZUFc0ruYd92TsLFiG0NIN6kElYUYUCMjXBtNETc4tEymkl8XTMgHrzJud/8Bb8Xn/WE80CpMKw2kSvcF0qg3/7mtecG0i+iX3iC0sh8Mqj7qOuYbfYuvHmxWRNgwXihGVpyN7DboYJKHyVGYXWVGOmqfO0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UarcN4sa; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UarcN4sa"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e1916922b9so45379137b3.1
        for <live-patching@vger.kernel.org>; Mon, 15 Jun 2026 19:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781577750; cv=none;
        d=google.com; s=arc-20240605;
        b=RP7b3ZFjbawgFo8ruBo0AjOPxmktHts+aRbRcxyyHKlgT2TcyNodldODWHCeFl5uJs
         sEYCenCOdd3EMgeDn/DGnzTg9GZOn63ZKqpYm19IQoXq2s/4EdkndKUju9ztzjE8ewWZ
         CyvwdHtj03X05zJulr9I1C9cYcbIRAO83k5yP7FC8lgi94fNFk2bVIaV5iFODT6Y4MpC
         E7K0tzceAIVtKMDyshVO9hY0lm4lE6bUaTepiLAcX8kcMT/tPmayWejKyUW7zlALcZre
         ZruK5+Zr9hquTu+HN5AU0qcGIngetzuWFC9RMIUixR3wLKL9q98IykbHdE4YyiuFNmkZ
         3y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tNbXsKONBtToiZuPIMl13silX6Lv3biZiqJFdtn7MuM=;
        fh=ZJOXYEJ2jbH1CciNRYixtEzc3kknmcIMd0cjP5oIU6Q=;
        b=AOozbNiodsz0HVsLiOfmV/rT19Q4N1N3C7zQ/XyFojt+RjiPG+YyQRQBnV8YOSdAFB
         WLUQXNBpc44Gwok+yVJiv/Jb703/tQpqpVKkiHC0jcVrP+Y9fJ0ka3LyDzTOdGGihIV4
         JGUl66bJyHbOGNaCFZTUylOYy0TLx9PzOe6P/pfPYBuCiQ3ovWDv2LGPLk1JiU2LBF4U
         7FNvncLzxwdvaU2taOdzR0WrP90Xck+jwZCh24Xdn1kB6lezPeYm4oWHmC5sReOFox2l
         nF7oSD3UenFKUyhBIXeXo1QofEd4+dGq9wYgo6cscsH8dUESmGNhHLVXuG0umJKo9XUB
         4sog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781577750; x=1782182550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNbXsKONBtToiZuPIMl13silX6Lv3biZiqJFdtn7MuM=;
        b=UarcN4sam8umGBqM6cpOOZl+cRoun6KnqD/gx3rnazDEwBa+MlRcmO1xga7Ul5gyGL
         l1vnh5PE/d86Y1nkLDNmo3Z6nMoD5h+eVIOrnaRSNQeTu1NqfAbAt2EnbksluARymucr
         +opg2U98pA6bJ1Du7GarJrxfTmMS/+sADuFZFoGRcEz0WsavA7roL8oks+BECm6jN3is
         b3rzST2rPSru4gk7KHrBmvOxVUKVX+e+HsqXpfc5oJuIXTUbmhWAyW7wZ4qCIbKWgnPY
         lLvUbbtRj5quc+2zmqxy4Z1B5kJAHNc+itIegW8kAsg4VLt94tCc1xQhdCoybonKFsmR
         9VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781577750; x=1782182550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNbXsKONBtToiZuPIMl13silX6Lv3biZiqJFdtn7MuM=;
        b=XzMMZjn4rGdh+K1wxJ/OAHhR0g/CTohJvUhuDXQapI7TdXVRUmVvEyN7eDLbTaiqM+
         MW92V4S32VlgQ2KXmriyekSxtUBuFxexHc6MfbUcnq0fV1goZRUQMiVlF/G42E2FNc8d
         j6z3pRzvytn9S+SkZpEfkMavqAZLazWOBh1UeWBuplRYO0cI6SbE79ef0lOfu0mfOted
         lQSyVeIdJUdysP/YByvJAE5DTyojViy54uSDibOyRCwYFsI+mTWa1T/WxOio2YGp+Lg9
         pioXnVlCorioLBnK8YwjBP95OYu3u+Il4fPLTDqZwRlICCG3TKPkms+FIaceLmZFFkPk
         2fXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8O+ailLmA9CzHuNmdDQM24ycwwIi2uaw2e4aOhlJV91aNxSejfL/3/HY9ob8PJwnoAftvX2oDlTBlaDmDM@vger.kernel.org
X-Gm-Message-State: AOJu0YwDb5L71EOq5QS2g9lMiQOMT+fPXq6BAhiam4QCkGck6fuOzYdT
	81Q9tM5D3JET2XWhi0zxkJ5LGD5XzV/dMcukJsuvFmqP66OjUqDeMtMST01vpTf/Uz0pG4tTOKT
	9K1LL7XhX3DHGnFL2n4gR3HiNKxN60ck=
X-Gm-Gg: Acq92OHBwPGsV1gXmfddNhQ/1VByL60hcJUcXm8mqrBU3Ao/gpoLGqAVKpTwVA8E2aX
	hTzFb9Gwc+0fZA7/ZWC8/UJh/Hd9olVrsblJDcGSbWCHt3/MzBYNzfuIyK7EFuZJW8JsRqDjci+
	tmajHp2tFxma9OD2sfRIDDmr2IXe0PmSOBXNLYogHVjlyoLACSk0Nxg/p4AacbufguLD4JU2cjv
	d3dQz0lec7NbYhafMcB0BVBOHxqjsoIfvoNVcW/EKouv16uSLC/zy3NniK97sQxnfVD+T0PIGbG
	YbgGnWuszaCxXho3f2n7JNVep9AQmLH6misOkr2K
X-Received: by 2002:a05:690c:6d0a:b0:7f0:4c1e:8bb1 with SMTP id
 00721157ae682-7f8c1522091mr150120517b3.4.1781577750447; Mon, 15 Jun 2026
 19:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz> <CALOAHbDkv3yLsHKfAPE_u73jpDZYHYsk0rsuy_2e=HhPuaE56Q@mail.gmail.com>
In-Reply-To: <CALOAHbDkv3yLsHKfAPE_u73jpDZYHYsk0rsuy_2e=HhPuaE56Q@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 16 Jun 2026 10:41:54 +0800
X-Gm-Features: AVVi8CeTFaueLVdlY_fyEupfgf0NlyajbJooVWAuDzYVmWOcEK1NOMkpVurBt50
Message-ID: <CALOAHbADBDr15_i=S5CzJc5XCQ+hSA0fdLcCVXXjdjvKLZUNpA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 8:30=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Jun 11, 2026 at 8:58=E2=80=AFPM Petr Mladek <pmladek@suse.com> wr=
ote:
> >
> > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > I would write something like:
> > >
> > > <proposal>
> > > The practice shows that the current semantic of the patch.replace fla=
g is
> > > not ideal.
> > >
> > > The atomic replace is disabled by default. And the no-replace mode al=
lows
> > > wild installation of many livepatches in parallel. The author and
> > > administrator are fully responsible for preventing problems caused
> > > by producing and installing incompatible livepatches.
> > >
> > > The most safe atomic replace mode must be explicitly enabled by
> > > setting "patch.replace =3D true". It is all or nothing. The livepatch
> > > with enabled .replace will always replace all already installed
> > > livepatches. It makes it very safe but it might be too harsh.
> > >
> > > Improve the situation by switching "bool .replace" flag to
> > > "u32 .replace_set" and and updating its semantic.
> > >
> > > Any .replace_set value might be associated with a set of livepatched
> > > symbols, callbacks, shadow variable and state IDs.
> > >
> > > A livepatch with a particular .replace_set number will atomically
> > > rreplace any already installed livepatch with the same .replace_set
> > > number. By definition, there can only ever be one active livepatch
> > > for a given replace_set number.
> > >
> > > On the contrary, livepatches with a different .replace_set number
> > > must not modify the same function, or use the state with the same
> > > ID [*]. Any attempt to load an incompatible livepatch will be
> > > rejected.
> > >
> > > Summary:
> > >
> > > The most safe mode when any livepatch replaces any other livepatch
> > > will be the default. Note that all livepatches must keep
> > > .replace_set =3D 0.
> > >
> > > It will be possible to install more livepatches in parallel by
> > > using different .replace_set numbers. The livepatches might be
> > > updated independently using the atomic replace feature as long
> > > as the new version does not break compatibility. The kernel will
> > > reject a livepatch from a different replace set when it would
> > > want to modify the same function or livepatch state from
> > > another replace set.
> > >
> > > [*] The compatibility check of callbacks and shadow variables will
> > >     be improved later by reworking their semantic. There is a work
> > >     in progress, see [0]
> > > </proposal>
> > >
> > > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-i=
ter12 [0]
> > >
> > > I have realized that I actually sent "v1-iter12" to the public
> > > mailing list as the official v1. So we could use:
> > >
> > > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.=
com/ [0]
> > >
> > >
> > > New idea:
> > >
> > > I have briefly discussed the new semantic with Miroslav when I met
> > > him in person. And he was a bit concerned. We as an OS distributor
> > > might want to be sure that our livepatches can be installed the most
> > > safe way. So, we still might want to preserve the "replace all"
> > > semantic to make sure that our livepatches will not break anything.
> >
> > I thought more about it and we would need some solution to preserve
> > the replace_all functionality.
> >
> > There were recently reported few serious 0-day vulnerabilities.
> > We discussed a possibility to ship a quick fix with a livepatch.
> > Or that customers might want to fix it themself by a livepatch.
> > Such a livepatch would need to be installed in parallel to
> > the official livepatch fixing older bugs. But the next official
> > cumulative livepatch would need to replace it.
> >
> > The above scenario will not longer work with the current
> > "replace_set" handling. The hotfix would need to use another
> > "replace_set" so that it can be installed in parallel.
> > But the next cumulative livepatch won't be able to replace
> > it because it would need to modify the same function.
> >
> > I consulted this with AI (claude-sonet-4.6) and it gave the following
> > feedback/ideas ;-)
> >
> > > I though about 4 approaches approaches:
> > >
> > > 1. Make .replace_set=3D0 special so that it will always replace
> > >    everything. Similar to the current .replace=3Dtrue mode.
> > >
> > >    Customers will still be able to install custom livepatches
> > >    later with .replace_set !=3D 0. But the "0" livepatch will
> > >    always wipe them out.
> >
> > This is not ideal because it is asymetric. Why is "0" special?
> >
> >
> > > 2. Use two flags in the livepatch, for example
> > >
> > >      a. Rename .replace to .replace_all. The livepatch with this
> > >       flag set will always wipe all other livepatches.
> > >
> > >      b. Add .replace_set which will allow to install more livepatches
> > >       in parallel, replace the livepatches with the same .replace_set
> > >       atomically, and check the compatibility. As described above.
> > >
> > >     It is a bit more complicated. But it is more compatible with
> > >     the current state. And it removes the special meaning of
> > >     .replace_set =3D=3D 0.
> >
> > This looks more straightforward. But the fact that "replace_all"
> > replaces everything brings back the problem with the original
> > "replace" flag. So, it makes this whole exercise more or less
> > pointless.
> >
> > I had another idea with storing list of fixed bugs/CVEs in each
> > livepatch. Independent fixes might be fixed by independent
> > livepatches. Then a cumulative livepatch would replace only
> > the livepatches which fixed the same bugs before.
> >
> > And (claude-sonnet-4.6) came with an interesting simplification.
> >
> > We could add:
> >
> > struct klp_patch {
> > [...]
> >       unsigned int replace_set;
> >       const unsigned int *supersedes;   /* Zero terminated array of rep=
lace_set IDs */
> > [...]
> > }

After further consideration, what about merging replace_set and
supersedes into a single field? For example:

  struct klp_patch {
  [...]
       unsigned int *replace_set;
  [...]
  };

This replace_set field can be set at build time and also dynamically
updated at load time. By default, it contains a single ID, 0. To
replace a livepatch with ID 1, we can set it to 1 at load time. To
replace livepatches with both ID 1 and ID 2, we can set it to [1, 2].

In other words, a livepatch with replace_set [1, 2] can replace
livepatches with IDs 1, 2, or [1, 2]. A livepatch with replace_set [1,
2, 3] can replace livepatches with IDs 1, 2, 3, [1, 2], [1, 3], [2,
3], or [1, 2, 3].

I believe this approach is well-suited to complex production
deployment environments.

[...]

--=20
Regards
Yafang
