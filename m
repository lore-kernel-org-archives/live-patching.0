Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F03F210C
	for <live-patching@vger.kernel.org>; Thu, 18 Jun 2026 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787847; cv=none; b=C2GUVdUhKv4W7PcWaurkh/Ijpl7bQKJXZIMP1BxAlnhLOdcimkEbgcDjJyCB8Elm28wzSKr2P7HpVzxVkf1JWq7ECdIJrdAEttuWZ7MCw1hB3Ci4BuavUtPmTa3MIIVi0m/E0PAYZYqbZA3d9ORrMdgvzWaS+ZkUcIIbxIWuh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787847; c=relaxed/simple;
	bh=foTalWDk6ZK9g/Spq271GlS2JRNUkC8kt5ppRB1btf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKqW6uu9wnP4yiZSlwo6YQa66gljX8nz6YUos/0YNlTXzPWroFTxchXxwtU8LaKcvkjLIDFZTUfJeZajJleWltbYKwvRCIsydLGjeI9J9g/WBwNzmFp4O++nBkWGXsO4SuNn0B+jONJ2OmoTFcfth/LinBj3P+Ak0S7spRFr4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gtTHsX3r; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gtTHsX3r"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46066e640easo585599f8f.1
        for <live-patching@vger.kernel.org>; Thu, 18 Jun 2026 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781787841; x=1782392641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4gY/1bAUpQxYul4/T0gFRrJBSxPv94jV4hFKedR614=;
        b=gtTHsX3rPm8V3kRvqjLJ/belk8+tzZIVjbcj+9aaGb0UgXjcTdRGAfE7Yo6iN9O5oa
         0EUvxl4iym3lXFUiTjiWIBFsQOwfRnC5WJgAdPATyC95x//BrfEt3xVBS5uRn9OljPST
         GWXUlbu1J75v0ObwzA6uQCbHYkqmxq/msBHhNYpLzsmOf0Buhv/WMX8jKfgwdA4rJYOm
         fbV2N7RnPoGWK/Oyb6FsxjHagt+jkF2aakzbuogUB2a/71WowewObkWxzoc6fffphPDL
         3ZE73lDQZog8fZQojltzSOW+FtZCSS+W0CGV841Ur8+NiBpwtfZYWiui4ZPM3HSIhw4l
         B9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787841; x=1782392641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4gY/1bAUpQxYul4/T0gFRrJBSxPv94jV4hFKedR614=;
        b=Us4lnaBmxF47Y3QC0mffbsGBry+yWU9FSbBL6e4ICtxhYcOW7YO0wFuZwfHh18C8sX
         UUvt/O1nQAGq/oWaZFyH5i9oEp0tgxBRxiaDJUf/WsT19/f7mTP3YtchNVuQd7l9RsOB
         imOIFuO6L8TlkDFeWLtAvmxK1K3Ekr7MfaOUH369MbvdEMdrIc8TRfy4B8UdnSLclMhs
         tQXmvwXWSNVZ/bLW+BIKRbYoSpiMImiz5uPWV1dnVCa3jEAGLMpiwcllcjZbyB62RY4o
         DeFKVRHdo0Rr0W5yJZVJ1/3nxL7PE4ZoUDB9mgWkIVHv+k2YC322578Lf2BJJbi2anJK
         bfvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gSbe3zLQ0fXlPPzK5JThjKLMoGxxfauVQ50KvgmcZQJaHmdjQ4yG2cDAuqp1d4AN4040dxsZL8hyetHN4@vger.kernel.org
X-Gm-Message-State: AOJu0YxnAeTriDg7TNLm8X18CS6zOLMGHOniJ4qdhH89xZSBAGPJrqej
	wthu11ZEXx/o8QkzxChxLMd3J5OcoiemmAR6yaHRDdeLf1Aeqxr5hw4F/Etn2VDZJVw=
X-Gm-Gg: AfdE7ckzCWq/Kt9kIqQ69d8Kv+F4Ck3kIOrzhzqmYC6k8V7Np5y28tRlA2csyM8sYJA
	WEbY+QxJGXE2Td2TKRA0QDDUpv5yqYgynBVqYXXJmxlVaS6wbPbBGFWBN8Gvm2/K57tI86N7T0h
	PUhOs7CtNIjOwGI7sbJBcjjkL9UXyqxIauQFuiDlMmbT68oDQSMiHr4sH5BiB1Q/rGsiro9pZiR
	6KXNTqoalpzKZpfmcvyyXJM2q+WXHKvwc65WjqU5N7cGgRGzu1o0BI/iAJa1NW+GLt0CHAKu7r4
	dfYTY8eIs00s6LV/6wFn+UT3YP9gAEod+Tk2p+w/lRjmQ526WZ03jVTDv6IiPEAGoq8LQzFyfK7
	Uexiiyju1eXDd4o4gVUYFU7o6kQPbRtC3bt2njZ19MEyt7VgJnBdwmjpfmqpWi6nbUNbTqig9IR
	gjVTqEoUaMudqBHPA=
X-Received: by 2002:a05:600c:1f8f:b0:492:3670:85a7 with SMTP id 5b1f17b1804b1-4923677d803mr90973285e9.35.1781787840142;
        Thu, 18 Jun 2026 06:04:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923a154446sm31596275e9.0.2026.06.18.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:03:59 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:03:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajPsvHv4t3gyGOit@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
 <aiqw_74v-1_2D9rJ@pathway.suse.cz>
 <ajGu1cP2znjHmN2H@redhat.com>
 <ajKmm5GIkvRUlJ2c@pathway.suse.cz>
 <ajL-Y3dapC1FiAwx@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajL-Y3dapC1FiAwx@redhat.com>

On Wed 2026-06-17 16:06:59, Joe Lawrence wrote:
> On Wed, Jun 17, 2026 at 03:52:27PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 16:15:17, Joe Lawrence wrote:
> > > On Thu, Jun 11, 2026 at 02:58:39PM +0200, Petr Mladek wrote:
> > > > On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> > > > > On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > [ ... snip ... ]
> > > I'm not against supercedes functionality, but continuing the
> > > brainstorming: what about solution 1 (.replace_set=0 special) with a
> > > special zero-day overlay?
> > 
> > I continue with the brainstorming ;-)
> > 
> 
> Thanks for walking through it with me.  Your reply crossed with my note
> to Yafang at nearly the same time.
> 
> > [ ... snip ... ]
> > > So maybe it boils down to: is the supercedes big hammer desired and safe
> > > enough to deploy?
> > 
> > I personally like the solution with a zero-terminated array of
> > replace_sets:
> > 
> > 	struct patch {
> > 	       [...]
> > 	       unsigned int *replace_sets;
> > 	       [...],
> > 	};
> > 
> > , which would allow to build a cumulative livepatch which replaces
> > known hotfixes out of box.
> > 
> 
> Question on this at the bottom ...
> 
> > Note that the hotfix should not be allowed to modify a function or
> > livepatch state which is modified by another livepatch. It would
> > be dangerous. We should allow to solve this only by a cumulative
> > livepatch.
> > 
> 
> Agreed.
> 
> > IMHO, the OS vendor should not touch customer specific livepatches
> > by default. The customer installed them for a reason. We should
> > just refuse to install two conflicting livepatches. Where
> > we could reliably compare only the livepatched functions.
> > But it still is good because most livepatches only modify
> > functions.
> > 
> > Plus, I would still allow to resolve the possible conflict by using
> > the atomic replace. It could be done by a module-specific parameter.
> > I would call it: override_replace_sets=X[,Y]... or so.
> > 
> 
> Naming nitpick: "override_replace_sets" sounds like it may override the
> "replace_sets" value and not supplement it.  But that's just an
> implementation detail to bikeshed later :D 

Good point! "supplement_replace_sets" or "add_replace_sets"
would be better :D

But see below.

> > Finally, I assume that most users will keep using only the default
> > replace_sets=0 [*]. They will never have to deal with another sets.
> > 
> > The non-default replace sets will be only for adventurous users
> > who want to deal with the complexity and accept the risks.
> > 
> > [*] It we allow the zero-terminated array of replace_sets then
> >     zero should not be the default. Or it could be but it would
> >     be a special set which could never be replaced by anything
> >     else than another zero replace set.
> > 
> >     The zero replace set might be for users who do not want to
> >     deal with the complexity at all. For example, for an os-vendor
> >     who does not want to release separate hotfixes.
> > 
> 
> Hmm, I do like the default replace_sets=0 not dealing with the
> complication of the replace sets.
> 
> But first, back to the larger question I mentioned at the beginning.
> 
> Originally there was:
> 
>   unsigned int replace_set;            /* the set I belong to */
>   const unsigned int *supersedes;      /* other sets I also replace */
> 
> and now it's just:
> 
>   unsigned int *replace_sets;          /* sets I belong to AND replace? */
> 
> Could you trace through a few cycles of cumulative + hotfix releases with
> this approach?  For example:
> 
>   Wed: klp-1a: cumulative    (replace_sets={1})
>   Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
>   Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b (same set)
>   Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a AND wipes klp-1c *
>   Tue: klp-2b: hotfix        (replace_sets={2})     <- coexists with klp-2a
> 
> [*] After klp-2a loads with {1, 2}, is it permanently in both sets?  Or
>     does it just evict set 2 and then only occupy set 1 going forward?  The
>     latter makes klp-2b's load straightforward.
> 
> I can read replace_sets two ways:
> 
>   1. Positional: { set [, eviction_set ...] } where the first element is
>      the patch's own set and the rest are evicted on load.
> 
>   2. Flat: the patch belongs to every listed set equally.  But then how
>      could klp-2b load into set 2 without replacing the entire
>      cumulative klp-2a that also occupies it?

I understand it a 3rd way (similar to Yafang?) ;-)

      3. Set: the patch replaces the given set of replace_sets.
	 Where klp-2a is a cumulative livepatch for two
	 replace_sets: 1,2. And klp-2b hotfix would need to
	 use a new replace_set, .e.g. 3.

	 I see "replace_set" as a set of modifications (functions,
	 shadow variables, and callbacks) which is supposed to
	 replace/update/downgrade the same "replace_set".

It would have the following consequences:
-----------------------------------------

First, any newer cumulative livepatch would need to replace all
older hotfixes. Let's extend your example:

   Wed: klp-1a: cumulative    (replace_sets={1})
   Thu: klp-1b: hotfix        (replace_sets={2})     <- coexists with klp-1a
   Fri: klp-1c: hotfix v2     (replace_sets={2})     <- replaces klp-1b (same set)
   Mon: klp-2a: cumulative    (replace_sets={1,2})   <- replaces klp-1a AND wipes klp-1c
   Tue: klp-2b: hotfix        (replace_sets={3})     <- coexists with klp-2a
   Fri: klp-3a: cumulative    (replace_sets={1,2,3}) <- replaces klp-2a AND wipes klp-2b
   Fri: klp-4a: cumulative    (replace_sets={1,2,3}) <- replaces klp-3a
   Fri: klp-5a: cumulative    (replace_sets={1,2,3}) <- replaces klp-4a

Second, it would limit downgrades, for example:

   + klp-3a, klp-4a, and klp-5a looks compatible from the replace_set POV.
     The replace_set should not limit replacing each other.

     Well, the replacing still might be limited by the states.

     Plus the pending patchset adds per-state "block_disable" flag
     which should handle situations where the change (by a callback)
     can't be reverted, see
     https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/


Hmm, this brings a question how exactly replace_sets and states
play together and if we need them both.

I did some brainstorming and came with the following definitions:
-----------------------------------------------------------------

   + Each patch.objs[i].funcs[j] defines a particular
       livepatched function.

   + Each patch.states[i] defines either a particular shadow variable
      (same id + state.is_shadow=true) [1] and/or set of callbacks [2]

     [1] https://lore.kernel.org/all/20250115082431.5550-3-pmladek@suse.com/
     [2] https://lore.kernel.org/all/20250115082431.5550-2-pmladek@suse.com/

   + Each shadow variable "id" defines a particular data (type)

   + Each set of callback (pre/post/enable/disable) is connected
     either with a particular shadow variable (for its lifetime handling)
     or it can change the system state with a one-time operation.

Why do we need "states"?
------------------------

   I see "states" as a definition of shadow variable ids and
   callbacks sets. We need to somehow tell the kernel that the
   livepatch is going to use them.

   The numeric "id" allows to compare the compatibility of the
   definitions between livepatches "easily".

   Note that we do not need states to compare livepatched functions.
   The kernel can compare them by the info in patch.objs[].funcs[].old_name.


Why do we need "replace_set" ?
------------------------------

   I see "replace_set" as an union of fixes (livepatched functions,
   shadow variables, callbacks) which is supposed to be handled
   using atomic replace.

   It defines which livepatches upgrade/downgrade or can be installed
   in parallel with other livepatches.

   I see it like "package name" in the RPM package management system.
   The "rpm" tools allows to upgrade/downgrade packages with the same
   name. It can even upgrade/downgrade a package with another name
   when "provides" [*] are defined.

   Note that the "replace_set" would allow even downgrade because
   new livepatch might:

      + stop modifying some functions,see klp_add_nops().

      + stop using some shadow variables and/or revert changes
	done by some callbacks, until it gets blocked by per-state
	"block_disable", see
	https://lore.kernel.org/all/20250115082431.5550-5-pmladek@suse.com/

[*] "provides" seems to be better name than "supplements".


Has "replace_set" a good name and semantic?
-------------------------------------------

I think that we really could find some analogy with the package
management.

"replace_set" does not exist in the package management terminology.
Also "replace_sets" is a set of replace sets which sounds a bit ugly.
Also I sometimes wanted to say "replace a replace set" which
overwhelming.

Well, we likely do not want to introduce livepatch names. They
might get confused with module names.

We could not use module names because they must differ. Otherwise,
kernel could not load both old and newer livepatch in parallel.

I would stay with numbers. They are kind of IDs. But we do want
to name it patch.id because it might get confused with state.id.

We could call it "patch_id" but "patch.patch_id" is a but ugly.

I did some brainstorming and came up with:

    "project_id"
    "changeset_id"
    "provides_id"
    "track_id"
    "fix_id"

and claude-sonnet-4.6 also suggested to use:

    "slot"

which has a similar meaning in the Gentoo package management,
see https://devmanual.gentoo.org/general-concepts/slotting/

The "slots" name is interesting but they seems to be always
mutually exclusive. I do not see any concept of merging
slots in Gentoo.


My preferences:

Honestly, I feel a bit lost. I think that I need to sleep over it.

I kind of like:

     * @slot: Livepatches with the same slot replace each other.
	      Livepatches with different slots might be installed in parallel.
    unsigned long slot;

And I would handle the merging of other slots separately by:

     * @merge_slots: Replace livepatches with the given slots.
     unsigned long merge_slots[];

Plus, a module parameter add_merge_slots=x[,y]...

But I do not have strong opinion.

Best Regards,
Petr
