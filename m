Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8033F597
	for <live-patching@vger.kernel.org>; Mon, 22 Jun 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149238; cv=none; b=NUratKQMWQkDldQMct8620h1QGr0ZpnPfRBQlc+06872ABRV+PtFWiPM5UO6sb/9n9lRzLrWzAG8klI8cMRIOVYgfkfsiFRGLJs5a+Awr2A+iOjU74uQikuygmi19Gbz3FdkLMPFEO7Dv/w4uJ4tsNV/ROwlrMBXKQXAmCmEjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149238; c=relaxed/simple;
	bh=4fvQAbw12URrR2lo7trQze7e+Qu7eJX1M5I1p+C84Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De3gqXhnE8PDDdABmU6xb22i678yqiksRLc7bSTvH2pHzDH62i+lgH0pbhk8ls/lMo1N2brOgbqkiHdTD20i6NTa9xIn5XvV+0BfjqgtxRithPH49aY0mNzn+dSu3eCIT6c4ICESp5381ERwylE0MLHx9wrlSOvFrImtrGPBVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHVOnJRi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHVOnJRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782149231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Guzo3q1HWFY/nTzB14CdcJs8oFnJUtAfhlUMFGJzLIY=;
	b=AHVOnJRimJegTwsUTq9BZolloMEXoYDcSCqQRbKgiHCf16UNvk+O+XoDCVsSjk8ucNF8Mf
	rzcCUvrLaRKdIUt5AImknwm39LBYuC8pt2Rt7dhpZPKE36n4zymWZhHysCQ9bSBofqHwqy
	ccv8REoxP03SwCV/QKvxz4/08MScvRw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-lOlITBfQNBujc86RRbh62w-1; Mon,
 22 Jun 2026 13:27:04 -0400
X-MC-Unique: lOlITBfQNBujc86RRbh62w-1
X-Mimecast-MFC-AGG-ID: lOlITBfQNBujc86RRbh62w_1782149222
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C699D1954B2E;
	Mon, 22 Jun 2026 17:27:02 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F39F1956041;
	Mon, 22 Jun 2026 17:27:01 +0000 (UTC)
Date: Mon, 22 Jun 2026 13:26:59 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajlwY8K3l4N49eVS@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com>
 <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
 <ajL-Y3dapC1FiAwx@redhat.com>
 <ajPsvHv4t3gyGOit@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajPsvHv4t3gyGOit@pathway.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 18, 2026 at 03:03:56PM +0200, Petr Mladek wrote:
> On Wed 2026-06-17 16:06:59, Joe Lawrence wrote:
> > On Wed, Jun 17, 2026 at 03:52:27PM +0200, Petr Mladek wrote:
> > > On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
> > > > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > [ ... snip ... ]
> > > > I'm not against supercedes functionality, but continuing the
> > > > brainstorming: what about solution 1 (.replace_set=0 special) with a
> > > > special zero-day overlay?
> > > 
> > > I continue with the brainstorming ;-)
> > > 
> > 
> > Thanks for walking through it with me.  Your reply crossed with my note
> > to Yafang at nearly the same time.
> > 
> > > [ ... snip ... ]
> > > > So maybe it boils down to: is the supercedes big hammer desired and safe
> > > > enough to deploy?
> > > 
> > > I personally like the solution with a zero-terminated array of
> > > replace_sets:
> > > 
> > > 	struct patch {
> > > 	       [...]
> > > 	       unsigned int *replace_sets;
> > > 	       [...],
> > > 	};
> > > 
> > > , which would allow to build a cumulative livepatch which replaces
> > > known hotfixes out of box.
> > > 
> > 
> > Question on this at the bottom ...
> > 
> > > Note that the hotfix should not be allowed to modify a function or
> > > livepatch state which is modified by another livepatch. It would
> > > be dangerous. We should allow to solve this only by a cumulative
> > > livepatch.
> > > 
> > 
> > Agreed.
> > 
> > > IMHO, the OS vendor should not touch customer specific livepatches
> > > by default. The customer installed them for a reason. We should
> > > just refuse to install two conflicting livepatches. Where
> > > we could reliably compare only the livepatched functions.
> > > But it still is good because most livepatches only modify
> > > functions.
> > > 
> > > Plus, I would still allow to resolve the possible conflict by using
> > > the atomic replace. It could be done by a module-specific parameter.
> > > I would call it: override_replace_sets=X[,Y]... or so.
> > > 
> > 
> > Naming nitpick: "override_replace_sets" sounds like it may override the
> > "replace_sets" value and not supplement it.  But that's just an
> > implementation detail to bikeshed later :D 
> 
> Good point! "supplement_replace_sets" or "add_replace_sets"
> would be better :D
> 
> But see below.
> 
> > > Finally, I assume that most users will keep using only the default
> > > replace_sets=0 [*]. They will never have to deal with another sets.
> > > 
> > > The non-default replace sets will be only for adventurous users
> > > who want to deal with the complexity and accept the risks.
> > > 
> > > [*] It we allow the zero-terminated array of replace_sets then
> > >     zero should not be the default. Or it could be but it would
> > >     be a special set which could never be replaced by anything
> > >     else than another zero replace set.
> > > 
> > >     The zero replace set might be for users who do not want to
> > >     deal with the complexity at all. For example, for an os-vendor
> > >     who does not want to release separate hotfixes.
> > > 
> > 
> > Hmm, I do like the default replace_sets=0 not dealing with the
> > complication of the replace sets.
> > 
> > But first, back to the larger question I mentioned at the beginning.
> > 
> > Originally there was:
> > 
> >   unsigned int replace_set;            /* the set I belong to */
> >   const unsigned int *supersedes;      /* other sets I also replace */
> > 
> > and now it's just:
> > 
> >   unsigned int *replace_sets;          /* sets I belong to AND replace? */
> > 
> > Could you trace through a few cycles of cumulative + hotfix releases with
> > this approach?  For example:
> > 
> >   Wed: klp-1a: cumulative    (replace_sets={1})
> >   Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
> >   Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b (same set)
> >   Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a AND wipes klp-1c *
> >   Tue: klp-2b: hotfix        (replace_sets={2})     <- coexists with klp-2a
> > 
> > [*] After klp-2a loads with {1, 2}, is it permanently in both sets?  Or
> >     does it just evict set 2 and then only occupy set 1 going forward?  The
> >     latter makes klp-2b's load straightforward.
> > 
> > I can read replace_sets two ways:
> > 
> >   1. Positional: { set [, eviction_set ...] } where the first element is
> >      the patch's own set and the rest are evicted on load.
> > 
> >   2. Flat: the patch belongs to every listed set equally.  But then how
> >      could klp-2b load into set 2 without replacing the entire
> >      cumulative klp-2a that also occupies it?
> 
> I understand it a 3rd way (similar to Yafang?) ;-)
> 
>       3. Set: the patch replaces the given set of replace_sets.
> 	 Where klp-2a is a cumulative livepatch for two
> 	 replace_sets: 1,2. And klp-2b hotfix would need to
> 	 use a new replace_set, .e.g. 3.
> 
> 	 I see "replace_set" as a set of modifications (functions,
> 	 shadow variables, and callbacks) which is supposed to
> 	 replace/update/downgrade the same "replace_set".
> 
> It would have the following consequences:
> -----------------------------------------
> 
> First, any newer cumulative livepatch would need to replace all
> older hotfixes. Let's extend your example:
> 
>    Wed: klp-1a: cumulative    (replace_sets={1})
>    Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
>    Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b (same set)
>    Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a AND wipes klp-1c
>    Tue: klp-2b: hotfix        (replace_sets={3})     <- coexists with klp-2a
>    Fri: klp-3a: cumulative    (replace_sets={1,2,3}) <- replaces klp-2a AND wipes klp-2b
>    Fri: klp-4a: cumulative    (replace_sets={1,2,3}) <- replaces klp-3a
>    Fri: klp-5a: cumulative    (replace_sets={1,2,3}) <- replaces klp-4a
> 

This is making sense so far: hotfixes introduce new replace_set(s),
subsequent cumulatives replace all sets that came before it.

Quick question for you or Yafang based on his thoughts on my other reply:

> [Yafang] I support the flat mode approach. The hotfix should be assigned to a
> set that is not currently in use — for example, klp-2a should select a
> new set like set 3. The core design idea is to set replace_set
> dynamically. To determine which sets are already occupied, a
> user-space script can inspect /sys/kernel/livepatch/*/replace_set.

How would Petr's 3rd way handle such dynamic replace_set enumeration?
Using the extended example above, without considering user patches, a
vendor could hardcode the replace_sets values at build time as shown. 

However, if a user patch has already occupied say, replace_set 3, then
klp-2b would need to skip over 3 and set replace_sets=4.  But then when
the next cumulative patch, klp-3a, loads, how does it know that it
should replace_sets=1,2,4 and leave 3 alone? 

> Second, it would limit downgrades, for example:
> 
>    + klp-3a, klp-4a, and klp-5a looks compatible from the replace_set POV.
>      The replace_set should not limit replacing each other.
> 

This should be somewhat minimized assuming they are upgraded as part of
the same distro package, each new one replaces the previous one on disk.
But there would be nothing preventing someone from loading klp-3a after
klp-5a if they wanted to.

>      Well, the replacing still might be limited by the states.
> 
>      Plus the pending patchset adds per-state "block_disable" flag
>      which should handle situations where the change (by a callback)
>      can't be reverted, see
>      https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/
> 
> 
> Hmm, this brings a question how exactly replace_sets and states
> play together and if we need them both.
> 
> I did some brainstorming and came with the following definitions:
> -----------------------------------------------------------------
> 
>    + Each patch.objs[i].funcs[j] defines a particular
>        livepatched function.
> 
>    + Each patch.states[i] defines either a particular shadow variable
>       (same id + state.is_shadow=true) [1] and/or set of callbacks [2]
> 
>      [1] https://lore.kernel.org/all/20250115082431.5550-3-pmladek@suse.com/
>      [2] https://lore.kernel.org/all/20250115082431.5550-2-pmladek@suse.com/
> 
>    + Each shadow variable "id" defines a particular data (type)
> 
>    + Each set of callback (pre/post/enable/disable) is connected
>      either with a particular shadow variable (for its lifetime handling)
>      or it can change the system state with a one-time operation.
> 
> Why do we need "states"?
> ------------------------
> 
>    I see "states" as a definition of shadow variable ids and
>    callbacks sets. We need to somehow tell the kernel that the
>    livepatch is going to use them.
> 

Aside: IIRC the shadow variable + callback sets were the concrete use
case for states, but technically any special livepatch side effect could
be considered its own state, right?

>    The numeric "id" allows to compare the compatibility of the
>    definitions between livepatches "easily".
> 
>    Note that we do not need states to compare livepatched functions.
>    The kernel can compare them by the info in patch.objs[].funcs[].old_name.
> 
> 
> Why do we need "replace_set" ?
> ------------------------------
> 
>    I see "replace_set" as an union of fixes (livepatched functions,
>    shadow variables, callbacks) which is supposed to be handled
>    using atomic replace.
> 
>    It defines which livepatches upgrade/downgrade or can be installed
>    in parallel with other livepatches.
> 
>    I see it like "package name" in the RPM package management system.
>    The "rpm" tools allows to upgrade/downgrade packages with the same
>    name. It can even upgrade/downgrade a package with another name
>    when "provides" [*] are defined.
> 

<nod> When listing out the future culumative + hotfix examples, my brain
went there (package mgmt), too.

>    Note that the "replace_set" would allow even downgrade because
>    new livepatch might:
> 
>       + stop modifying some functions,see klp_add_nops().
> 
>       + stop using some shadow variables and/or revert changes
> 	done by some callbacks, until it gets blocked by per-state
> 	"block_disable", see
> 	https://lore.kernel.org/all/20250115082431.5550-5-pmladek@suse.com/
> 
> [*] "provides" seems to be better name than "supplements".
> 
> 
> Has "replace_set" a good name and semantic?
> -------------------------------------------
> 
> I think that we really could find some analogy with the package
> management.
> 
> "replace_set" does not exist in the package management terminology.
> Also "replace_sets" is a set of replace sets which sounds a bit ugly.
> Also I sometimes wanted to say "replace a replace set" which
> overwhelming.
> 
> Well, we likely do not want to introduce livepatch names. They
> might get confused with module names.
> 
> We could not use module names because they must differ. Otherwise,
> kernel could not load both old and newer livepatch in parallel.
> 
> I would stay with numbers. They are kind of IDs. But we do want
> to name it patch.id because it might get confused with state.id.
> 
> We could call it "patch_id" but "patch.patch_id" is a but ugly.
> 
> I did some brainstorming and came up with:
> 
>     "project_id"
>     "changeset_id"
>     "provides_id"
>     "track_id"
>     "fix_id"
> 
> and claude-sonnet-4.6 also suggested to use:
> 
>     "slot"
> 
> which has a similar meaning in the Gentoo package management,
> see https://devmanual.gentoo.org/general-concepts/slotting/
> 
> The "slots" name is interesting but they seems to be always
> mutually exclusive. I do not see any concept of merging
> slots in Gentoo.
> 
> 
> My preferences:
> 
> Honestly, I feel a bit lost. I think that I need to sleep over it.
> 
> I kind of like:
> 
>      * @slot: Livepatches with the same slot replace each other.
> 	      Livepatches with different slots might be installed in parallel.
>     unsigned long slot;
> 
> And I would handle the merging of other slots separately by:
> 
>      * @merge_slots: Replace livepatches with the given slots.
>      unsigned long merge_slots[];
> 
> Plus, a module parameter add_merge_slots=x[,y]...
> 
> But I do not have strong opinion.
> 

How about following the package management analogy almost exactly:

  @provides:       id                  < only one active livepatch per id
  @obsoletes:      { id [, id ...] }   < replace given livepatch id(s)
  @also_obsoletes: { id [, id ...] }   < replace addt'l livepatch id(s)

Claude offers alternative naming like: family, group, track, series and
absorbs, evicts, replaces, retires.

--
Joe

