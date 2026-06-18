Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B03C6A2B
	for <live-patching@vger.kernel.org>; Thu, 18 Jun 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774444; cv=pass; b=bqFj/9f67NdBHGn3oxGIqX7FbxC8750L6qcThmHsbA4XRT4TEV0sCgUKIegEi7QRoVoXCE4K3sk5YEVpnEMqPhmxhY3RNH0LWXWgRYnfODp4p3/e/OTU9vz/K1By5s9th9JCiO8qE8XnAROtDtABQzMrkhoETey9nA6pJ0jnhrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774444; c=relaxed/simple;
	bh=jq96TsIulGzs3KuGpsY7qPgXPH7hXii8+FynJpjRqRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8eb872Gqmbzjz2Xs8vO1Glg8axE2GkInLQle7SQO1dRB+VM5/ZMoLuXiCs5XVhZ/74FeTCXOpkvP4yEBp+jE8v8Fp2z13eXf1rcbvmewW8BfY07nqo6/yLxgM2CLYrJpSJzGs81I9lUcKL4Chi9LsnL01OyJmF0cRY/LvE1MDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg6E1g0d; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg6E1g0d"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7f69b71f7b2so9098607b3.1
        for <live-patching@vger.kernel.org>; Thu, 18 Jun 2026 02:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781774439; cv=none;
        d=google.com; s=arc-20240605;
        b=GrL4mbOOKUySmIZpCJNBx7GmOkQGnWW101FUvnQdx1Yn87LY4I9AkLlQBGbMhOyG4Y
         ltoSe6WpB0YfdIs5WVWXSIaCKW+xAgZVMKuNZ5rslO4FXxLLSkESOobAdWdT8G/h+sdE
         hLMJjgWQh2TYea9Jx241UGwMJAAp7UAWMgmj32o5cCULsegRckRFOpxk1xNeLyG/EB+y
         HnthUHJxCfRk4jii4gCPLDXGNZvC5NQIFvqSax6wsglpbr9Q2Dhx9Q2q5Bh4HYg9mJuj
         GYlHPmeR4KJi7nUjnvuyb0l0G/fnM1F/tonMvlbp5CtOna8DXJOIieMKNWFDIm7Wr/TW
         0BTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Aw+Jru0oEhu6La9CLc23PxTTha8mkXmWZYy6vBF5Nk=;
        fh=Jxl7AzygCDHhq2dEPcH8pC5a5kKeNUmqfuhBDCmU1xI=;
        b=Fp1ThILqD/DN1Ax22U/6H/SLSNP87bXlRoXDR4nEiaXkAuwxdLzXKOLWoDDEPzCTLI
         SBvt0rnaSWj7FNn8dvW+alukIFa4zVT9ag30mQ5mdhMc35T1NSS3Pdiedk6HVeufrWUu
         or3hU1my/Pl4NkhiI+rt+rpR1Lh5IEYi9E3Nm8ebfzy91+aDTBSHyffyXOoTciF/lpQU
         Cj3eh0Hl804hlIPJrb3AUntdMbCEdXd9JKBgKdm2Bqx1RGpFNKz98LYprMg006JgJJE6
         X5xBuQVkf2DhgCK1zUqmgLs4nw5sXmlIKTVOFHEXPkOXoamjhzkFjSyzIDkf60vJ9caS
         LKHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781774439; x=1782379239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Aw+Jru0oEhu6La9CLc23PxTTha8mkXmWZYy6vBF5Nk=;
        b=Sg6E1g0dGVwAVAnmydv7/098L9z0+7Sb7NCG3p6D14i72ynH2Lm+n3KS3nTYpxmMK4
         fQMAvjjV/CxPJu98TidKGWOAJGHQR46ViFUY7z5NlPZPz6gsF1ktzwGLw9+HvBPugPOI
         8JfS4G6DTgZOqyC0sfUJawcf9XtEtZN/2OPCPdhLEeu/HqTMq3b4ABImxZIpi1koEoz8
         8i2ozrRmyPryH3F6RPDDkiHSzU4P/Z7YTCuFDHnmGhKK2O3wCk6NzkiEkNEnHOdCSv8z
         JUpOzltdxSLoOaUCd3tu3WtXXzu7K5/osHSHGXYJbSmURfZjKvnePQrh2mOrlXf39v8s
         OUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774439; x=1782379239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Aw+Jru0oEhu6La9CLc23PxTTha8mkXmWZYy6vBF5Nk=;
        b=OSQAvi901rNRkJQ6Alwh1aY9mk16RsrSwqySSQP6hEDUrb54nfJRZ7OzGwPPSmfG3x
         e6AG+zBytwi4OO6U7uFZsLMOcN8hrGk4pH7yHyhQ1EQWT8hUp6szZmaFqK93OPugiYyi
         TKlUVlGjSt2/m90OmEx/4IQ7VJky4KExB0cX5IPajRGAUIgRzIQ8t/93OQbLrMFn6C4w
         YAMDoX2F4/JEu72G6cUNgB/9f+akV0QP7pDcXix7vZ3kcg7TIQm80fvEFgyFH3BKnnVb
         W1zKbHQikfSvb6wwMrSq1YPnjszvWlmu6aMsHJFnI5D6nQQkNAhQ632nE4Awux1/e32g
         KNbw==
X-Forwarded-Encrypted: i=1; AFNElJ9whhGVzEFgOE/05kzV9BXvdkmhgPIILQfc+/n36IMz9KpGpFoKl+NaSEzxAY+4+G3OBtFXce1QGjuqp1f2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i4R86fyfxZIxl4oGfXcm9oAmXPLq7pQvW91nmK3oTzMZBK2D
	v81nSzXoYl54Lrg7PWHWP55UWwATuvEskGVFu3BqvencRMTQGH3Xz+kPYtyrF220ASry9kqoT8Q
	mgI2YmE5zs2Tt9x31EYJh2DDG8qckk2Q=
X-Gm-Gg: AfdE7cljcuNKvLQ5KWodm0HZApF0vJsH9WE1NelKcVuWLeDUMCmDT/kohC/1of3dpPc
	QlJi6yiPFqlimGMklFB5QgkTn+Yoo24w81GFR7vPLZCfVQeNsX8Hud4wS5ORfqwNJuO5+HHnvT1
	uq8/kokBqnDY472j3Jc133MoDJv3rfNmNG6b9lhYH0a0VdJdRe7VhbhJrz8+fod+KuJHRF1wxGu
	79GWGbSPlnXY96Ee1SxWQDxcuQ/JG2sLI3jV75ipPbVG6+E0Lc96PjVTVq+V40jdPH1XbpdiJ+o
	HD7iK8CO6KfLBGWRW5cIPbyXWrBJrPC++bG5a5eN
X-Received: by 2002:a05:690c:64c7:b0:7c5:f6c:d311 with SMTP id
 00721157ae682-7fe5dea9956mr89511107b3.13.1781774439106; Thu, 18 Jun 2026
 02:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com> <CALOAHbCSwj9EtYjNA_zoAj_+2PYb9i+U9hLJeHd78S8HBkOdQA@mail.gmail.com>
 <ajK1QNpTRbVfEpFm@redhat.com>
In-Reply-To: <ajK1QNpTRbVfEpFm@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 18 Jun 2026 17:20:02 +0800
X-Gm-Features: AVVi8Cdg2Zjibo2A85t2WDH72yv8H1iFhy8ULX8t2O99PxyEpD-J_lhWKnYr7qs
Message-ID: <CALOAHbDyJGFetgBDjmitJe62VXz-nEd47dfEw4_nOTp5oafG3Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 10:55=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.=
com> wrote:
>
> On Wed, Jun 17, 2026 at 10:40:50AM +0800, Yafang Shao wrote:
> > On Wed, Jun 17, 2026 at 4:15=E2=80=AFAM Joe Lawrence <joe.lawrence@redh=
at.com> wrote:
> > >
> > > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > > > I would write something like:
> > > > >
> > > > > <proposal>
> > > > > The practice shows that the current semantic of the patch.replace=
 flag is
> > > > > not ideal.
> > > > >
> > > > > The atomic replace is disabled by default. And the no-replace mod=
e allows
> > > > > wild installation of many livepatches in parallel. The author and
> > > > > administrator are fully responsible for preventing problems cause=
d
> > > > > by producing and installing incompatible livepatches.
> > > > >
> > > > > The most safe atomic replace mode must be explicitly enabled by
> > > > > setting "patch.replace =3D true". It is all or nothing. The livep=
atch
> > > > > with enabled .replace will always replace all already installed
> > > > > livepatches. It makes it very safe but it might be too harsh.
> > > > >
> > > > > Improve the situation by switching "bool .replace" flag to
> > > > > "u32 .replace_set" and and updating its semantic.
> > > > >
> > > > > Any .replace_set value might be associated with a set of livepatc=
hed
> > > > > symbols, callbacks, shadow variable and state IDs.
> > > > >
> > > > > A livepatch with a particular .replace_set number will atomically
> > > > > rreplace any already installed livepatch with the same .replace_s=
et
> > > > > number. By definition, there can only ever be one active livepatc=
h
> > > > > for a given replace_set number.
> > > > >
> > > > > On the contrary, livepatches with a different .replace_set number
> > > > > must not modify the same function, or use the state with the same
> > > > > ID [*]. Any attempt to load an incompatible livepatch will be
> > > > > rejected.
> > > > >
> > > > > Summary:
> > > > >
> > > > > The most safe mode when any livepatch replaces any other livepatc=
h
> > > > > will be the default. Note that all livepatches must keep
> > > > > .replace_set =3D 0.
> > > > >
> > > > > It will be possible to install more livepatches in parallel by
> > > > > using different .replace_set numbers. The livepatches might be
> > > > > updated independently using the atomic replace feature as long
> > > > > as the new version does not break compatibility. The kernel will
> > > > > reject a livepatch from a different replace set when it would
> > > > > want to modify the same function or livepatch state from
> > > > > another replace set.
> > > > >
> > > > > [*] The compatibility check of callbacks and shadow variables wil=
l
> > > > >     be improved later by reworking their semantic. There is a wor=
k
> > > > >     in progress, see [0]
> > > > > </proposal>
> > > > >
> > > > > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-=
v1-iter12 [0]
> > > > >
> > > > > I have realized that I actually sent "v1-iter12" to the public
> > > > > mailing list as the official v1. So we could use:
> > > > >
> > > > > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@s=
use.com/ [0]
> > > > >
> > > > >
> > > > > New idea:
> > > > >
> > > > > I have briefly discussed the new semantic with Miroslav when I me=
t
> > > > > him in person. And he was a bit concerned. We as an OS distributo=
r
> > > > > might want to be sure that our livepatches can be installed the m=
ost
> > > > > safe way. So, we still might want to preserve the "replace all"
> > > > > semantic to make sure that our livepatches will not break anythin=
g.
> > > >
> > > > I thought more about it and we would need some solution to preserve
> > > > the replace_all functionality.
> > > >
> > > > There were recently reported few serious 0-day vulnerabilities.
> > > > We discussed a possibility to ship a quick fix with a livepatch.
> > > > Or that customers might want to fix it themself by a livepatch.
> > > > Such a livepatch would need to be installed in parallel to
> > > > the official livepatch fixing older bugs. But the next official
> > > > cumulative livepatch would need to replace it.
> > > >
> > > > The above scenario will not longer work with the current
> > > > "replace_set" handling. The hotfix would need to use another
> > > > "replace_set" so that it can be installed in parallel.
> > > > But the next cumulative livepatch won't be able to replace
> > > > it because it would need to modify the same function.
> > > >
> > > > I consulted this with AI (claude-sonet-4.6) and it gave the followi=
ng
> > > > feedback/ideas ;-)
> > > >
> > > > > I though about 4 approaches approaches:
> > > > >
> > > > > 1. Make .replace_set=3D0 special so that it will always replace
> > > > >    everything. Similar to the current .replace=3Dtrue mode.
> > > > >
> > > > >    Customers will still be able to install custom livepatches
> > > > >    later with .replace_set !=3D 0. But the "0" livepatch will
> > > > >    always wipe them out.
> > > >
> > > > This is not ideal because it is asymetric. Why is "0" special?
> > > >
> > >
> > > Hah, why is zero special?  Because we said so and the asymmetry is th=
e
> > > point. :)  On my first pass through this patchset and reply chain, I'=
d
> > > say I lean toward approach (1) as it's dead simple and means not
> > > participating in replace_set values =3D no functional changes for the
> > > former atomic-replace user ...
> >
> > Making zero a special case might reintroduce the issues with
> > cumulative and non-cumulative patches. See the detailed example below.
> >
> > >
> > > >
> > > > > 2. Use two flags in the livepatch, for example
> > > > >
> > > > >      a. Rename .replace to .replace_all. The livepatch with this
> > > > >     flag set will always wipe all other livepatches.
> > > > >
> > > > >      b. Add .replace_set which will allow to install more livepat=
ches
> > > > >     in parallel, replace the livepatches with the same .replace_s=
et
> > > > >     atomically, and check the compatibility. As described above.
> > > > >
> > > > >     It is a bit more complicated. But it is more compatible with
> > > > >     the current state. And it removes the special meaning of
> > > > >     .replace_set =3D=3D 0.
> > > >
> > > > This looks more straightforward. But the fact that "replace_all"
> > > > replaces everything brings back the problem with the original
> > > > "replace" flag. So, it makes this whole exercise more or less
> > > > pointless.
> > > >
> > > > I had another idea with storing list of fixed bugs/CVEs in each
> > > > livepatch. Independent fixes might be fixed by independent
> > > > livepatches. Then a cumulative livepatch would replace only
> > > > the livepatches which fixed the same bugs before.
> > > >
> > > > And (claude-sonnet-4.6) came with an interesting simplification.
> > > >
> > > > We could add:
> > > >
> > > > struct klp_patch {
> > > > [...]
> > > >       unsigned int replace_set;
> > > >       const unsigned int *supersedes;   /* Zero terminated array of=
 replace_set IDs */
> > > > [...]
> > > > }
> > > >
> > > > So that the cumulative livepatch might optionally define
> > > > another "replace_set"s which would be replaced.
> > > >
> > > > This would work well when both cumulative livepatches and the hotfi=
x
> > > > are provided by the same vendor or group.
> > > >
> > > > We could also allow to change it dynamically by adding an module
> > > > option to the cumulative livepatch, .e.g supersedes=3Did[,id]*
> > > > We could add some support into the kernel for handling the module
> > > > parameter a standard way.
> > > >
> > > > It is not trivial. But it is also not horribly complex.
> > > > It looks like a good compromise between the requirements and
> > > > code complexity.
> > > >
> > > > We really need input from others here.
> > > >
> > >
> > > I'm not against supercedes functionality, but continuing the
> > > brainstorming: what about solution 1 (.replace_set=3D0 special) with =
a
> > > special zero-day overlay?
> > >
> > > The model becomes:
> > >
> > > - replace_set: isolation sets (as Yafang has implemented)
> > > - overlay (bool): "I'm a partial addition to my set, not a full repla=
cement"
> > >
> > > and then the vendor zero-day scenario looks like:
> > >
> > >   Mon: cumulative patch (set 0, overlay=3Dfalse)
> > >   Tue: hotfix (set 0, overlay=3Dtrue) stacks on top, overrides one fu=
nction
> >
> > At this point, if the user reboots the machine, the loading order of
> > these livepatches becomes undetermined. If the hotfix is loaded first,
> > the cumulative patch loaded next will replace it. As a result, the
> > user must maintain the load order of these livepatches, which can be
> > quite painful.
> >
>
> [ Edit: Feel free to jump to the bottom.  Having been on PTO + holiday,
>   I needed to run through the full thought experiement below to come to
>   the same conclusion as Petr and Yafang.  Leaving it here in case it
>   helps anyone else trace through the problem. ]
>
> Ah right, this overlay idea drives us right back into stack_order
> headache.
>
> Now to take the same scenario to the supersede feature.  If I understand
> correctly, the idea is that cumulative vendor patches roll out at some
> interval (weekly, monthly, etc.) and they live in set=3D0.  Emergency CVE
> firedrill ensues and to expedite the fix, the vendor skips the long
> cumulative build/QE/etc. with a targeted hotfix that lives in set=3D1.  A
> while later, the vendor releases a full cumulative update, set=3D0 and
> supersedes=3D1 to replace the temporary hotfix(es):
>
>   Mon: cumulative base patch                      (set=3D0)
>   Tue: hotfix v1 disable vulnerable code          (set=3D1)
>   Wed: hotfix v2 vendor-specific attempt to solve (set=3D1)
>   Thu: cumulative patch with final CVE fix        (set=3D0, supersedes=3D=
1)
>
> If Wednesday's hotfix v2 removes hotfix v1 from disk, then rebooting
> before Thursday's cumulative is safe regardless of load order, as set=3D0
> and set=3D1 coexist independently.  If stale hotfix versions remain on
> disk however, same-set replacement within set=3D1 means the last one
> loaded wins, which may silently downgrade the fix.  With that packaging
> detail in place, this scenario looks good.
>
> One additional note is that supersedes is only a mechanism to replace
> the hotfixes.  Hotfixes still adhere to replace set rules, so if a 0-day
> lands in a function the current cumulative already patches, the hotfix
> can't be deployed as a separate set at all.  The vendor is forced to
> rebuild the full cumulative.
>
> > >   Wed: new cumulative (set 0, overlay=3Dfalse) replaces both
> > >
> > > If overlay patches are cumulative, then it should support iterating o=
n
> > > zero-day fixes like:
> > >
> > >   Mon: cumulative base patch
> > >   Tue: hotfix v1 disable vulnerable code
> > >   Wed: hotfix v2 vendor-specific attempt to solve
> > >   Thu: cumulative patch with final CVE fix
> > >
> > > So I think either the supercedes or overlay feature handle vendor-onl=
y
> > > scenarios well.
> > >
> > > The big difference overlay has from supercede is that it intentionall=
y
> > > only plays within the vendor replace-set space.  So if a (customer)
> > > feature replace-set was off touching function_foo() and a CVE landed
> > > there, the overlay feature would remain blocked from patching it.
> > > Supercede provides a big hammer here.
> > >
> > > That said, blind eviction via supersede assumes the customer's
> > > replace-set patches are actually safe to bounce.  The customer's patc=
h
> > > may have allocated shadow variables, modified system state via
> > > callbacks, or changed data structure semantics, all designed to be
> > > unwound by the next customer version of that patch, not by an unrelat=
ed
> > > vendor patch.  The vendor can't know what semantic landmines the
> > > customer's patch left behind, and the kernel can't validate that at l=
oad
> > > time.
> > >
>
> Now it gets complicated and I've got a fresh cup of tea to consider how
> supersede coexists with user livepatch replace sets.
>
> Scenario 1: 0-day in foo(), nobody patches it yet:
>
>   Mon: cumulative base patch                      (set=3D0)
>        customer feature patch                     (set=3D2)
>   Tue: hotfix v1 disable vulnerable code          (set=3D1)
>   Wed: hotfix v2 vendor-specific attempt to solve (set=3D1)
>   Thu: cumulative patch with final CVE fix        (set=3D0, supersedes=3D=
1)
>
> Life is great, the customer feature livepatch sits out in set=3D2,
> unaffected by all the vendor cumulative (set=3D0) and hotfix (set=3D1)
> churn.
>
> Scenario 2: 0-day in bar(), customer's set owns it:
>
>   Mon: cumulative base patch                      (set=3D0)
>        customer feature patch                     (set=3D2)
>   Tue: hotfix v1 patches bar()                    (set=3D1)  < REJECTED, =
bar() owned by set=3D2
>
> The kernel rejects the vendor's hotfix because the customer set=3D2 owns
> bar() and it doesn't supersede it.  <Ahah moment> if supersedes is
> provided as a vendor livepatch module parameter, the educated customer
> could then choose the hammer and let their vendor's livepatch replace
> their bar().
>
> [ Edit: Joe is finally up to speed here. ]
>
> Alright I think I'm onboard with the supersede feature and its optional
> module parameter.
>
> With that, is it worth documenting a convention for replace_set
> allocation?  Something as simple as "vendors use low-numbered sets,
> customers use higher ones" might help avoid collisions, with the
> understanding that the kernel makes no distinction between them.

Since replace_sets can be configured dynamically as needed, I don't
think we need to document it explicitly. Users can simply choose the
right sets for their production environment=E2=80=94for example, by checkin=
g
the currently used sets and adjusting accordingly.

--=20
Regards
Yafang
