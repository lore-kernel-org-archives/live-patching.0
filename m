Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D292E737C
	for <live-patching@vger.kernel.org>; Wed, 17 Jun 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708107; cv=none; b=XKf+XOH97sazGoGNmAEXIs/VlYHKZUprSrnjToAiqP2oMpe+EvgSoRDD+SuzVopxeAb7Ypu0FN+RE/2o6exRXxKZEXo2mEL4GTDZO9DK96416d0+ymxFy9Bw8+vHq4kzkoiZd2HfCOT2gG05xK9ujojPQoOMqizHAJ5qnS/PMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708107; c=relaxed/simple;
	bh=xMyFTixEjBgd4IE8c+lhM2xMssnuYJUqsILMv9z0n+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzszxZuPLyE6m88Ravrw5eUJ7hVJZNToq4SAXH95/TqKvAV7JUECq0hl/o9etiwCZ8t4AQFHk7nxjzGDZi4ypjHg3d1wiKkCB3q35NSZHjMJ+Sa8hSuwRcdadaDu5SWWh9ZUJ1yBQzkwo1o7SLYQ1RKqQKkZ4DGv0WFNb1Azw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCKyMNBS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCKyMNBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw8yToIxSCN31sfPNf7wYfwNDTw6S18+aKpR2V6cabU=;
	b=fCKyMNBS8/bJnvHjfqOKglSpJDDLi9E1RTzS6fm2d8gK/4Z02GBcS2++QyqwTSn4uLoRzQ
	tM7Idz9S1jC8Pzj5EfKdmoy3EjcZ6lVMvKUQp9efVd9WvTsLInPVQU+zFqA1UlH6DhVtLZ
	DYoKPN6c3rSqmNmmfUI03+akdgi/3Us=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-E9MPjMB_P--S7bg35PHXAA-1; Wed,
 17 Jun 2026 10:55:01 -0400
X-MC-Unique: E9MPjMB_P--S7bg35PHXAA-1
X-Mimecast-MFC-AGG-ID: E9MPjMB_P--S7bg35PHXAA_1781708099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 958F41800A34;
	Wed, 17 Jun 2026 14:54:59 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 656E3180049F;
	Wed, 17 Jun 2026 14:54:58 +0000 (UTC)
Date: Wed, 17 Jun 2026 10:54:56 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajK1QNpTRbVfEpFm@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com>
 <CALOAHbCSwj9EtYjNA_zoAj_+2PYb9i+U9hLJeHd78S8HBkOdQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCSwj9EtYjNA_zoAj_+2PYb9i+U9hLJeHd78S8HBkOdQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jun 17, 2026 at 10:40:50AM +0800, Yafang Shao wrote:
> On Wed, Jun 17, 2026 at 4:15 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > > > I would write something like:
> > > >
> > > > <proposal>
> > > > The practice shows that the current semantic of the patch.replace flag is
> > > > not ideal.
> > > >
> > > > The atomic replace is disabled by default. And the no-replace mode allows
> > > > wild installation of many livepatches in parallel. The author and
> > > > administrator are fully responsible for preventing problems caused
> > > > by producing and installing incompatible livepatches.
> > > >
> > > > The most safe atomic replace mode must be explicitly enabled by
> > > > setting "patch.replace = true". It is all or nothing. The livepatch
> > > > with enabled .replace will always replace all already installed
> > > > livepatches. It makes it very safe but it might be too harsh.
> > > >
> > > > Improve the situation by switching "bool .replace" flag to
> > > > "u32 .replace_set" and and updating its semantic.
> > > >
> > > > Any .replace_set value might be associated with a set of livepatched
> > > > symbols, callbacks, shadow variable and state IDs.
> > > >
> > > > A livepatch with a particular .replace_set number will atomically
> > > > rreplace any already installed livepatch with the same .replace_set
> > > > number. By definition, there can only ever be one active livepatch
> > > > for a given replace_set number.
> > > >
> > > > On the contrary, livepatches with a different .replace_set number
> > > > must not modify the same function, or use the state with the same
> > > > ID [*]. Any attempt to load an incompatible livepatch will be
> > > > rejected.
> > > >
> > > > Summary:
> > > >
> > > > The most safe mode when any livepatch replaces any other livepatch
> > > > will be the default. Note that all livepatches must keep
> > > > .replace_set = 0.
> > > >
> > > > It will be possible to install more livepatches in parallel by
> > > > using different .replace_set numbers. The livepatches might be
> > > > updated independently using the atomic replace feature as long
> > > > as the new version does not break compatibility. The kernel will
> > > > reject a livepatch from a different replace set when it would
> > > > want to modify the same function or livepatch state from
> > > > another replace set.
> > > >
> > > > [*] The compatibility check of callbacks and shadow variables will
> > > >     be improved later by reworking their semantic. There is a work
> > > >     in progress, see [0]
> > > > </proposal>
> > > >
> > > > > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]
> > > >
> > > > I have realized that I actually sent "v1-iter12" to the public
> > > > mailing list as the official v1. So we could use:
> > > >
> > > > Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/ [0]
> > > >
> > > >
> > > > New idea:
> > > >
> > > > I have briefly discussed the new semantic with Miroslav when I met
> > > > him in person. And he was a bit concerned. We as an OS distributor
> > > > might want to be sure that our livepatches can be installed the most
> > > > safe way. So, we still might want to preserve the "replace all"
> > > > semantic to make sure that our livepatches will not break anything.
> > >
> > > I thought more about it and we would need some solution to preserve
> > > the replace_all functionality.
> > >
> > > There were recently reported few serious 0-day vulnerabilities.
> > > We discussed a possibility to ship a quick fix with a livepatch.
> > > Or that customers might want to fix it themself by a livepatch.
> > > Such a livepatch would need to be installed in parallel to
> > > the official livepatch fixing older bugs. But the next official
> > > cumulative livepatch would need to replace it.
> > >
> > > The above scenario will not longer work with the current
> > > "replace_set" handling. The hotfix would need to use another
> > > "replace_set" so that it can be installed in parallel.
> > > But the next cumulative livepatch won't be able to replace
> > > it because it would need to modify the same function.
> > >
> > > I consulted this with AI (claude-sonet-4.6) and it gave the following
> > > feedback/ideas ;-)
> > >
> > > > I though about 4 approaches approaches:
> > > >
> > > > 1. Make .replace_set=0 special so that it will always replace
> > > >    everything. Similar to the current .replace=true mode.
> > > >
> > > >    Customers will still be able to install custom livepatches
> > > >    later with .replace_set != 0. But the "0" livepatch will
> > > >    always wipe them out.
> > >
> > > This is not ideal because it is asymetric. Why is "0" special?
> > >
> >
> > Hah, why is zero special?  Because we said so and the asymmetry is the
> > point. :)  On my first pass through this patchset and reply chain, I'd
> > say I lean toward approach (1) as it's dead simple and means not
> > participating in replace_set values = no functional changes for the
> > former atomic-replace user ...
> 
> Making zero a special case might reintroduce the issues with
> cumulative and non-cumulative patches. See the detailed example below.
> 
> >
> > >
> > > > 2. Use two flags in the livepatch, for example
> > > >
> > > >      a. Rename .replace to .replace_all. The livepatch with this
> > > >     flag set will always wipe all other livepatches.
> > > >
> > > >      b. Add .replace_set which will allow to install more livepatches
> > > >     in parallel, replace the livepatches with the same .replace_set
> > > >     atomically, and check the compatibility. As described above.
> > > >
> > > >     It is a bit more complicated. But it is more compatible with
> > > >     the current state. And it removes the special meaning of
> > > >     .replace_set == 0.
> > >
> > > This looks more straightforward. But the fact that "replace_all"
> > > replaces everything brings back the problem with the original
> > > "replace" flag. So, it makes this whole exercise more or less
> > > pointless.
> > >
> > > I had another idea with storing list of fixed bugs/CVEs in each
> > > livepatch. Independent fixes might be fixed by independent
> > > livepatches. Then a cumulative livepatch would replace only
> > > the livepatches which fixed the same bugs before.
> > >
> > > And (claude-sonnet-4.6) came with an interesting simplification.
> > >
> > > We could add:
> > >
> > > struct klp_patch {
> > > [...]
> > >       unsigned int replace_set;
> > >       const unsigned int *supersedes;   /* Zero terminated array of replace_set IDs */
> > > [...]
> > > }
> > >
> > > So that the cumulative livepatch might optionally define
> > > another "replace_set"s which would be replaced.
> > >
> > > This would work well when both cumulative livepatches and the hotfix
> > > are provided by the same vendor or group.
> > >
> > > We could also allow to change it dynamically by adding an module
> > > option to the cumulative livepatch, .e.g supersedes=id[,id]*
> > > We could add some support into the kernel for handling the module
> > > parameter a standard way.
> > >
> > > It is not trivial. But it is also not horribly complex.
> > > It looks like a good compromise between the requirements and
> > > code complexity.
> > >
> > > We really need input from others here.
> > >
> >
> > I'm not against supercedes functionality, but continuing the
> > brainstorming: what about solution 1 (.replace_set=0 special) with a
> > special zero-day overlay?
> >
> > The model becomes:
> >
> > - replace_set: isolation sets (as Yafang has implemented)
> > - overlay (bool): "I'm a partial addition to my set, not a full replacement"
> >
> > and then the vendor zero-day scenario looks like:
> >
> >   Mon: cumulative patch (set 0, overlay=false)
> >   Tue: hotfix (set 0, overlay=true) stacks on top, overrides one function
> 
> At this point, if the user reboots the machine, the loading order of
> these livepatches becomes undetermined. If the hotfix is loaded first,
> the cumulative patch loaded next will replace it. As a result, the
> user must maintain the load order of these livepatches, which can be
> quite painful.
> 

[ Edit: Feel free to jump to the bottom.  Having been on PTO + holiday,
  I needed to run through the full thought experiement below to come to
  the same conclusion as Petr and Yafang.  Leaving it here in case it
  helps anyone else trace through the problem. ]

Ah right, this overlay idea drives us right back into stack_order
headache.

Now to take the same scenario to the supersede feature.  If I understand
correctly, the idea is that cumulative vendor patches roll out at some
interval (weekly, monthly, etc.) and they live in set=0.  Emergency CVE
firedrill ensues and to expedite the fix, the vendor skips the long
cumulative build/QE/etc. with a targeted hotfix that lives in set=1.  A
while later, the vendor releases a full cumulative update, set=0 and
supersedes=1 to replace the temporary hotfix(es):

  Mon: cumulative base patch                      (set=0)
  Tue: hotfix v1 disable vulnerable code          (set=1)
  Wed: hotfix v2 vendor-specific attempt to solve (set=1)
  Thu: cumulative patch with final CVE fix        (set=0, supersedes=1)

If Wednesday's hotfix v2 removes hotfix v1 from disk, then rebooting
before Thursday's cumulative is safe regardless of load order, as set=0
and set=1 coexist independently.  If stale hotfix versions remain on
disk however, same-set replacement within set=1 means the last one
loaded wins, which may silently downgrade the fix.  With that packaging
detail in place, this scenario looks good.

One additional note is that supersedes is only a mechanism to replace
the hotfixes.  Hotfixes still adhere to replace set rules, so if a 0-day
lands in a function the current cumulative already patches, the hotfix
can't be deployed as a separate set at all.  The vendor is forced to
rebuild the full cumulative.

> >   Wed: new cumulative (set 0, overlay=false) replaces both
> >
> > If overlay patches are cumulative, then it should support iterating on
> > zero-day fixes like:
> >
> >   Mon: cumulative base patch
> >   Tue: hotfix v1 disable vulnerable code
> >   Wed: hotfix v2 vendor-specific attempt to solve
> >   Thu: cumulative patch with final CVE fix
> >
> > So I think either the supercedes or overlay feature handle vendor-only
> > scenarios well.
> >
> > The big difference overlay has from supercede is that it intentionally
> > only plays within the vendor replace-set space.  So if a (customer)
> > feature replace-set was off touching function_foo() and a CVE landed
> > there, the overlay feature would remain blocked from patching it.
> > Supercede provides a big hammer here.
> >
> > That said, blind eviction via supersede assumes the customer's
> > replace-set patches are actually safe to bounce.  The customer's patch
> > may have allocated shadow variables, modified system state via
> > callbacks, or changed data structure semantics, all designed to be
> > unwound by the next customer version of that patch, not by an unrelated
> > vendor patch.  The vendor can't know what semantic landmines the
> > customer's patch left behind, and the kernel can't validate that at load
> > time.
> >

Now it gets complicated and I've got a fresh cup of tea to consider how
supersede coexists with user livepatch replace sets.

Scenario 1: 0-day in foo(), nobody patches it yet:

  Mon: cumulative base patch                      (set=0)
       customer feature patch                     (set=2)
  Tue: hotfix v1 disable vulnerable code          (set=1)
  Wed: hotfix v2 vendor-specific attempt to solve (set=1)
  Thu: cumulative patch with final CVE fix        (set=0, supersedes=1)

Life is great, the customer feature livepatch sits out in set=2,
unaffected by all the vendor cumulative (set=0) and hotfix (set=1)
churn.

Scenario 2: 0-day in bar(), customer's set owns it:

  Mon: cumulative base patch                      (set=0)
       customer feature patch                     (set=2)
  Tue: hotfix v1 patches bar()                    (set=1)  < REJECTED, bar() owned by set=2

The kernel rejects the vendor's hotfix because the customer set=2 owns
bar() and it doesn't supersede it.  <Ahah moment> if supersedes is
provided as a vendor livepatch module parameter, the educated customer
could then choose the hammer and let their vendor's livepatch replace
their bar().

[ Edit: Joe is finally up to speed here. ] 

Alright I think I'm onboard with the supersede feature and its optional
module parameter.

With that, is it worth documenting a convention for replace_set
allocation?  Something as simple as "vendors use low-numbered sets,
customers use higher ones" might help avoid collisions, with the
understanding that the kernel makes no distinction between them.

--
Joe

