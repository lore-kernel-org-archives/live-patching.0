Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8930CD92
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184139; cv=pass; b=lPpoXU8gk15SKOB1TFtW++Hx4gbb5P2scJOvuhvP/L4eK3drPgC5qQnJWrPtYnj30rtWW+mgE9hI/LDXkmRlgoLHLlI6sI7OXE8FB4C7gZxABpnruoGaarWGTkI0bgDXw6g0HGhrCvMwN/Z1NzCP+Czuv7ccENklz5j9T/KwRmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184139; c=relaxed/simple;
	bh=tyFZWHYSAZQCaTipjroQn3nXkpoa6Gt7GlyuRTz23hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmZw65bKKXqvfvOhigmYeUOUSIokbz8LWouk4p01McGxMxVVAykhBg1gpDVWMMDrkEE5lv6yYGqaFfq8grcnONUqmnOPJFj+Niatd5Qe2TnpaFf2fYgiF7BY26zaw0STmKqbda/Yo3KaqB07b8EEiy+kiBhmdISiDGFxv3B5vF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRDQYtkA; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRDQYtkA"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8051ad12d23so13574697b3.3
        for <live-patching@vger.kernel.org>; Mon, 22 Jun 2026 20:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782184132; cv=none;
        d=google.com; s=arc-20240605;
        b=eKEkIHPSMy3NPtgspVKK0NlvYImvr3hAkgmhHO7wK/skkQSWYmdhY7Zfcai1qpc3oo
         Sl0PYPnoxRA/wDJFoH1Lr4CEq57VNzt71EU5Ki935CfKnrwdFFeq0urXKkRn7rgkj2aA
         PCZxpg5alWFUMwcdHtXMngYov5LCsiW9B0Zziz3RIyUIkx1033Ex/r86Yl8eJctxwRVe
         GIyuc8ayi4HIw0qgtC+NzduqGN67QEUT5foKoXDRSP5V8qKMdeGM9VMElkaQuHbp9zIk
         kCBlILZGcztunW3qd1N4zW/LPf+oh8JgOhVghhEIMSi4wxeBZOSvjR8WddpmhmMaSXTM
         OV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hyKxrAeFghMjzlIwnTT7lWuHM+rRo7ttQ9U6nXhn2eo=;
        fh=yq8ZvsYG2NGkCff6+ULpGowoXxXeArlCPKKkdTvZ1ws=;
        b=dyRqXEoAEkMxkYxMGk9+LTtbhyW5+3goS9ZAVfvUISssSiWT1W8Qn0g4bw48zUlCPQ
         ZR+wbeJUshDEIiuugp8tgDLRFINx0MzvyBNl51pCZJoYo+a5HHIrvSUGQ8SEl4WI3/1M
         1vuXvD+ZZGJXiGVp/IJHO7ptqWwijTzrId8ijJHpMnaL0I8FU+P0DnsSJExxNU1lGWyu
         S0Ti4YG6pv5Uxe0/E0KcRufMvC+oqvtxzE8NrhxiU9jXSJS6lrkGXKn+2ZJDqSETBXS9
         IbXFpTWTT3wwDH6hFp7yoiGs2jTHPV22+MfZcaZ90dt82XIHM6Bpf/UDvVt6CafDjQwX
         fSFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782184132; x=1782788932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyKxrAeFghMjzlIwnTT7lWuHM+rRo7ttQ9U6nXhn2eo=;
        b=VRDQYtkAXAp3JUsxF/sUq0BzdVWzE2z23tGAskiCKv/ih96jXbJMzbfGhxFIjWvfLE
         d0SzSGGzLvmOMnkW9gV09gl9QQYvX7XsfGFEfbZzrULD1hyGd+rX8QBKE8RAbfoGuTuM
         MvPp6FYlHTratg67sSpr5Br86Yk23LnWk5+LBu4YA7dTACBN3rQ2m1yE2pU9TK9MML8G
         yvlJ8+hM0719+AtXMNRh12Cvt7yhjc03cBn5UWSWjRXuLXhpzCJ+UNZyMz2r7ZPckiIj
         vi+l0my9fKJSsaMpOvMxm5tKXglnq/6M/wtxvcQEy6AUO/AaGQ0uIPD+E7hGAghZgjgi
         puPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782184132; x=1782788932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hyKxrAeFghMjzlIwnTT7lWuHM+rRo7ttQ9U6nXhn2eo=;
        b=ES1xZQg3cHgt0wKmdASOWop2h5bFh66Zxw3LriopAM7FEmvNb6jtV17JYn0HBC02Xn
         1RoAPdLSttg7xVGETfrQ5AG+yyRuYfq5Jzn+OwGczSXRgbFKc5wc/pl+HNaxRmM7l5YK
         y/9BUMmhx3EEzrODjpcBQz4ibSVFrPGuyBNz5RBLMUnXXQZDqeaZT0nY/kDdCh9AiGJ9
         PhdO6cjG5Sn0IeERSlypX8432gHw4H8R2aPl4/G6pVX7ECIVoMdAdJ94rsLkyh8uckeW
         kPoaBHfu2pW+OQ2Hh+If9ifYTKDGS61+KaCm2YTWN2/DsGB7tO060ryEY6uirtqJWa+6
         fySQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8AdJXINSeRgIC5ES/lSG03NNypO0d7pSkJ92yXMCjAgL1pSAkRjhJrYGHjcQkEKlvBF+zP6Jpn/aHUjDq@vger.kernel.org
X-Gm-Message-State: AOJu0YzKj5vTiLKf/4WAEFgqFrSh2kz00cqdiOZrPwghNXozZ+5bGod7
	q622Gpe6O1vjqqe32up9/VhWBU3Wvux67hRjTYmI7PgGMcgofzNfzgmD66WlEW3P7yW30KxOX35
	oBJ2V+qnP/U4B7SmeY/rtHNz2jXTIdQY=
X-Gm-Gg: AfdE7cnjB8W2ryuq9vYtqIBaXyT2I5ysNf8/RMZoCB0dURnZ+x2FPltmpUg74r2ap2s
	UM/m3OG48ICp3ei3OT9RCcY6CrwqKgypsYSVQff1cDVuGPXKY+/ma+IZY1/BJhV3uixGUuz3LDp
	IHa++VqPe/+idtB8sIk7VAk3SHPjcctZku7Rs5IM+xyy71kQe2cadtA0J0VhQsLRFBEA09QMTtB
	2zbHHO1CIDsRSua1GvPkz6Lj9ZzNRkuyxmKx+zqk1lfSQjKNJK16b9m7rZhD0YlhPY2EhuEXoEH
	Yz9X4hYgzAcnzdWQfHBksWlLj2wjqA==
X-Received: by 2002:a05:690c:e199:10b0:806:7aec:998 with SMTP id
 00721157ae682-8067aec1ec2mr18225397b3.21.1782184131855; Mon, 22 Jun 2026
 20:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz> <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com> <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
 <ajL-Y3dapC1FiAwx@redhat.com> <ajPsvHv4t3gyGOit@pathway.suse.cz> <ajlwY8K3l4N49eVS@redhat.com>
In-Reply-To: <ajlwY8K3l4N49eVS@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 23 Jun 2026 11:08:15 +0800
X-Gm-Features: AVVi8CdwHRlnEcjK3wA863gBozLwc9XXgPwkwtLlgCfgUUc3UT4_NIf8NKRQeAc
Message-ID: <CALOAHbBVjTX76u18jMQb3R4H+4=ipT4ybfjxq6tBFQNF4ALNQg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 1:27=E2=80=AFAM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Thu, Jun 18, 2026 at 03:03:56PM +0200, Petr Mladek wrote:
> > On Wed 2026-06-17 16:06:59, Joe Lawrence wrote:
> > > On Wed, Jun 17, 2026 at 03:52:27PM +0200, Petr Mladek wrote:
> > > > On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
> > > > > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > > > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > > [ ... snip ... ]
> > > > > I'm not against supercedes functionality, but continuing the
> > > > > brainstorming: what about solution 1 (.replace_set=3D0 special) w=
ith a
> > > > > special zero-day overlay?
> > > >
> > > > I continue with the brainstorming ;-)
> > > >
> > >
> > > Thanks for walking through it with me.  Your reply crossed with my no=
te
> > > to Yafang at nearly the same time.
> > >
> > > > [ ... snip ... ]
> > > > > So maybe it boils down to: is the supercedes big hammer desired a=
nd safe
> > > > > enough to deploy?
> > > >
> > > > I personally like the solution with a zero-terminated array of
> > > > replace_sets:
> > > >
> > > >   struct patch {
> > > >          [...]
> > > >          unsigned int *replace_sets;
> > > >          [...],
> > > >   };
> > > >
> > > > , which would allow to build a cumulative livepatch which replaces
> > > > known hotfixes out of box.
> > > >
> > >
> > > Question on this at the bottom ...
> > >
> > > > Note that the hotfix should not be allowed to modify a function or
> > > > livepatch state which is modified by another livepatch. It would
> > > > be dangerous. We should allow to solve this only by a cumulative
> > > > livepatch.
> > > >
> > >
> > > Agreed.
> > >
> > > > IMHO, the OS vendor should not touch customer specific livepatches
> > > > by default. The customer installed them for a reason. We should
> > > > just refuse to install two conflicting livepatches. Where
> > > > we could reliably compare only the livepatched functions.
> > > > But it still is good because most livepatches only modify
> > > > functions.
> > > >
> > > > Plus, I would still allow to resolve the possible conflict by using
> > > > the atomic replace. It could be done by a module-specific parameter=
.
> > > > I would call it: override_replace_sets=3DX[,Y]... or so.
> > > >
> > >
> > > Naming nitpick: "override_replace_sets" sounds like it may override t=
he
> > > "replace_sets" value and not supplement it.  But that's just an
> > > implementation detail to bikeshed later :D
> >
> > Good point! "supplement_replace_sets" or "add_replace_sets"
> > would be better :D
> >
> > But see below.
> >
> > > > Finally, I assume that most users will keep using only the default
> > > > replace_sets=3D0 [*]. They will never have to deal with another set=
s.
> > > >
> > > > The non-default replace sets will be only for adventurous users
> > > > who want to deal with the complexity and accept the risks.
> > > >
> > > > [*] It we allow the zero-terminated array of replace_sets then
> > > >     zero should not be the default. Or it could be but it would
> > > >     be a special set which could never be replaced by anything
> > > >     else than another zero replace set.
> > > >
> > > >     The zero replace set might be for users who do not want to
> > > >     deal with the complexity at all. For example, for an os-vendor
> > > >     who does not want to release separate hotfixes.
> > > >
> > >
> > > Hmm, I do like the default replace_sets=3D0 not dealing with the
> > > complication of the replace sets.
> > >
> > > But first, back to the larger question I mentioned at the beginning.
> > >
> > > Originally there was:
> > >
> > >   unsigned int replace_set;            /* the set I belong to */
> > >   const unsigned int *supersedes;      /* other sets I also replace *=
/
> > >
> > > and now it's just:
> > >
> > >   unsigned int *replace_sets;          /* sets I belong to AND replac=
e? */
> > >
> > > Could you trace through a few cycles of cumulative + hotfix releases =
with
> > > this approach?  For example:
> > >
> > >   Wed: klp-1a: cumulative    (replace_sets=3D{1})
> > >   Thu: klp-1b: hotfix        (replace_sets=3D{2})     <- coexists wit=
h klp-1a
> > >   Fri: klp-1c: hotfix v2     (replace_sets=3D{2})     <- replaces klp=
-1b (same set)
> > >   Mon: klp-2a: cumulative    (replace_sets=3D{1,2})   <- replaces klp=
-1a AND wipes klp-1c *
> > >   Tue: klp-2b: hotfix        (replace_sets=3D{2})     <- coexists wit=
h klp-2a
> > >
> > > [*] After klp-2a loads with {1, 2}, is it permanently in both sets?  =
Or
> > >     does it just evict set 2 and then only occupy set 1 going forward=
?  The
> > >     latter makes klp-2b's load straightforward.
> > >
> > > I can read replace_sets two ways:
> > >
> > >   1. Positional: { set [, eviction_set ...] } where the first element=
 is
> > >      the patch's own set and the rest are evicted on load.
> > >
> > >   2. Flat: the patch belongs to every listed set equally.  But then h=
ow
> > >      could klp-2b load into set 2 without replacing the entire
> > >      cumulative klp-2a that also occupies it?
> >
> > I understand it a 3rd way (similar to Yafang?) ;-)
> >
> >       3. Set: the patch replaces the given set of replace_sets.
> >        Where klp-2a is a cumulative livepatch for two
> >        replace_sets: 1,2. And klp-2b hotfix would need to
> >        use a new replace_set, .e.g. 3.
> >
> >        I see "replace_set" as a set of modifications (functions,
> >        shadow variables, and callbacks) which is supposed to
> >        replace/update/downgrade the same "replace_set".
> >
> > It would have the following consequences:
> > -----------------------------------------
> >
> > First, any newer cumulative livepatch would need to replace all
> > older hotfixes. Let's extend your example:
> >
> >    Wed: klp-1a: cumulative    (replace_sets=3D{1})
> >    Thu: klp-1b: hotfix        (replace_sets=3D{2})     <- coexists with=
 klp-1a
> >    Fri: klp-1c: hotfix v2     (replace_sets=3D{2})     <- replaces klp-=
1b (same set)
> >    Mon: klp-2a: cumulative    (replace_sets=3D{1,2})   <- replaces klp-=
1a AND wipes klp-1c
> >    Tue: klp-2b: hotfix        (replace_sets=3D{3})     <- coexists with=
 klp-2a
> >    Fri: klp-3a: cumulative    (replace_sets=3D{1,2,3}) <- replaces klp-=
2a AND wipes klp-2b
> >    Fri: klp-4a: cumulative    (replace_sets=3D{1,2,3}) <- replaces klp-=
3a
> >    Fri: klp-5a: cumulative    (replace_sets=3D{1,2,3}) <- replaces klp-=
4a
> >
>
> This is making sense so far: hotfixes introduce new replace_set(s),
> subsequent cumulatives replace all sets that came before it.
>
> Quick question for you or Yafang based on his thoughts on my other reply:
>
> > [Yafang] I support the flat mode approach. The hotfix should be assigne=
d to a
> > set that is not currently in use =E2=80=94 for example, klp-2a should s=
elect a
> > new set like set 3. The core design idea is to set replace_set
> > dynamically. To determine which sets are already occupied, a
> > user-space script can inspect /sys/kernel/livepatch/*/replace_set.
>
> How would Petr's 3rd way handle such dynamic replace_set enumeration?
> Using the extended example above, without considering user patches, a
> vendor could hardcode the replace_sets values at build time as shown.
>
> However, if a user patch has already occupied say, replace_set 3, then
> klp-2b would need to skip over 3 and set replace_sets=3D4.  But then when
> the next cumulative patch, klp-3a, loads, how does it know that it
> should replace_sets=3D1,2,4 and leave 3 alone?

  Wed: klp-1a: cumulative    (replace_sets=3D{1})
  Thu: klp-1b: hotfix        (replace_sets=3D{2})     <- coexists with klp-=
1a
  Fri: klp-1c: hotfix v2     (replace_sets=3D{2})     <- replaces klp-1b
(same set)
  Mon: klp-2a: cumulative    (replace_sets=3D{1,2})   <- replaces klp-1a
AND wipes klp-1c
  Mon: klp-user: cumulative (replace_sets=3D{3})  <- coexists with klp-2a
  Tue: klp-2b: hotfix        (replace_sets=3D{4})    <- choose an unused id
  Wed: klp-3a: cumulative

When loading klp-3a, the user can inspect the currently active set IDs
by checking /sys/kernel/livepatch/klp-2a/replace_set and
/sys/kernel/livepatch/klp-2b/replace_set, then dynamically configure
replace_sets to {1, 2, 4} accordingly.

However,  I don't have a strong opinion on this. If you both prefer
the positional mode, I'm happy to implement it that way.

>
> > Second, it would limit downgrades, for example:
> >
> >    + klp-3a, klp-4a, and klp-5a looks compatible from the replace_set P=
OV.
> >      The replace_set should not limit replacing each other.
> >
>
> This should be somewhat minimized assuming they are upgraded as part of
> the same distro package, each new one replaces the previous one on disk.
> But there would be nothing preventing someone from loading klp-3a after
> klp-5a if they wanted to.
>
> >      Well, the replacing still might be limited by the states.
> >
> >      Plus the pending patchset adds per-state "block_disable" flag
> >      which should handle situations where the change (by a callback)
> >      can't be reverted, see
> >      https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com=
/
> >
> >
> > Hmm, this brings a question how exactly replace_sets and states
> > play together and if we need them both.
> >
> > I did some brainstorming and came with the following definitions:
> > -----------------------------------------------------------------
> >
> >    + Each patch.objs[i].funcs[j] defines a particular
> >        livepatched function.
> >
> >    + Each patch.states[i] defines either a particular shadow variable
> >       (same id + state.is_shadow=3Dtrue) [1] and/or set of callbacks [2=
]
> >
> >      [1] https://lore.kernel.org/all/20250115082431.5550-3-pmladek@suse=
.com/
> >      [2] https://lore.kernel.org/all/20250115082431.5550-2-pmladek@suse=
.com/
> >
> >    + Each shadow variable "id" defines a particular data (type)
> >
> >    + Each set of callback (pre/post/enable/disable) is connected
> >      either with a particular shadow variable (for its lifetime handlin=
g)
> >      or it can change the system state with a one-time operation.
> >
> > Why do we need "states"?
> > ------------------------
> >
> >    I see "states" as a definition of shadow variable ids and
> >    callbacks sets. We need to somehow tell the kernel that the
> >    livepatch is going to use them.
> >
>
> Aside: IIRC the shadow variable + callback sets were the concrete use
> case for states, but technically any special livepatch side effect could
> be considered its own state, right?
>
> >    The numeric "id" allows to compare the compatibility of the
> >    definitions between livepatches "easily".
> >
> >    Note that we do not need states to compare livepatched functions.
> >    The kernel can compare them by the info in patch.objs[].funcs[].old_=
name.
> >
> >
> > Why do we need "replace_set" ?
> > ------------------------------
> >
> >    I see "replace_set" as an union of fixes (livepatched functions,
> >    shadow variables, callbacks) which is supposed to be handled
> >    using atomic replace.
> >
> >    It defines which livepatches upgrade/downgrade or can be installed
> >    in parallel with other livepatches.
> >
> >    I see it like "package name" in the RPM package management system.
> >    The "rpm" tools allows to upgrade/downgrade packages with the same
> >    name. It can even upgrade/downgrade a package with another name
> >    when "provides" [*] are defined.
> >
>
> <nod> When listing out the future culumative + hotfix examples, my brain
> went there (package mgmt), too.
>
> >    Note that the "replace_set" would allow even downgrade because
> >    new livepatch might:
> >
> >       + stop modifying some functions,see klp_add_nops().
> >
> >       + stop using some shadow variables and/or revert changes
> >       done by some callbacks, until it gets blocked by per-state
> >       "block_disable", see
> >       https://lore.kernel.org/all/20250115082431.5550-5-pmladek@suse.co=
m/
> >
> > [*] "provides" seems to be better name than "supplements".
> >
> >
> > Has "replace_set" a good name and semantic?
> > -------------------------------------------
> >
> > I think that we really could find some analogy with the package
> > management.
> >
> > "replace_set" does not exist in the package management terminology.
> > Also "replace_sets" is a set of replace sets which sounds a bit ugly.
> > Also I sometimes wanted to say "replace a replace set" which
> > overwhelming.
> >
> > Well, we likely do not want to introduce livepatch names. They
> > might get confused with module names.
> >
> > We could not use module names because they must differ. Otherwise,
> > kernel could not load both old and newer livepatch in parallel.
> >
> > I would stay with numbers. They are kind of IDs. But we do want
> > to name it patch.id because it might get confused with state.id.
> >
> > We could call it "patch_id" but "patch.patch_id" is a but ugly.
> >
> > I did some brainstorming and came up with:
> >
> >     "project_id"
> >     "changeset_id"
> >     "provides_id"
> >     "track_id"
> >     "fix_id"
> >
> > and claude-sonnet-4.6 also suggested to use:
> >
> >     "slot"
> >
> > which has a similar meaning in the Gentoo package management,
> > see https://devmanual.gentoo.org/general-concepts/slotting/
> >
> > The "slots" name is interesting but they seems to be always
> > mutually exclusive. I do not see any concept of merging
> > slots in Gentoo.
> >
> >
> > My preferences:
> >
> > Honestly, I feel a bit lost. I think that I need to sleep over it.
> >
> > I kind of like:
> >
> >      * @slot: Livepatches with the same slot replace each other.
> >             Livepatches with different slots might be installed in para=
llel.
> >     unsigned long slot;
> >
> > And I would handle the merging of other slots separately by:
> >
> >      * @merge_slots: Replace livepatches with the given slots.
> >      unsigned long merge_slots[];
> >
> > Plus, a module parameter add_merge_slots=3Dx[,y]...
> >
> > But I do not have strong opinion.
> >
>
> How about following the package management analogy almost exactly:
>
>   @provides:       id                  < only one active livepatch per id
>   @obsoletes:      { id [, id ...] }   < replace given livepatch id(s)
>   @also_obsoletes: { id [, id ...] }   < replace addt'l livepatch id(s)
>
> Claude offers alternative naming like: family, group, track, series and
> absorbs, evicts, replaces, retires.

It seems @provides and @obsoletes are easier to understand, but I
don't have a strong opinion either way.

--=20
Regards
Yafang
