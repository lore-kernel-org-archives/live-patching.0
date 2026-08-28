Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7486341
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888392; cv=none; b=ODKtKt/neCQF21U3VPax+1bK8yUNb1WTsV/jFfnZWhNuPsCV+gNI9iXLTwPJBZIepn4VbcL60Qw5jfMV/rRI5ISOTWVFzSgq1EAY6WypoLbKgoDu9GDFr7kbFKm4sELAcFcj48bTEzTJ0h0qTZL2vGLGgpO84evfc2fK+EE7yGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888392; c=relaxed/simple;
	bh=Db7Xrf/4P4xHZomwNNmkWrLPYPmpjGwZhytNcvCAsrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8k7sxSOFBtnfDsEZdwiDIiqt2VJYmaIS5fZVunPRIJdajBHT3V7A2MdgxpQ3NfDuF2eS1za5KEG/RYYBBaSDJvUbSLmtxvzNCiqsdNt5bNuhxDqXvEiKaxn4NXa1jbi56FohSZy31xaIqiM22aAYnr/1NNd67OBpiF+M45iKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=At61Qs0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="At61Qs0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBBB1F000E9;
	Fri, 28 Aug 2026 03:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787888391;
	bh=UNHOyDjEg1wNpS+JtAz81MHZ0KV98ZhqM14rKLP7VtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=At61Qs0y9U4oshqy4YSBRdXax9XupwgGLa4dxQONchmOVLOC5bwUqxZYsqxt/IQ2+
	 4dgaMipbHOJaf2+3A/zMr4EP6FwzdY9SxgFyCNiSI0s20I0k/9RFR8TG+32QYLJEPx
	 YZPbUHvzrpVTu5SIAVDB39gOG2w+UZOkwbzrqqGb/KWV0kGk2vfH7uoM0F8ekQkpl8
	 15Dy3DPoGSbn3vRcQZrLAhIP4hsFiNqDrNa2mwRP98StYPVm7NZeZ85aKJ9bq8LgiO
	 7In+nAKck7XHHFXou5qqO9c6gpJIsaqFP0h2nwRt9RJPFeRfEgOdxfEdgO/uFJGcIq
	 9sZBoAFbjTN6g==
Date: Thu, 27 Aug 2026 20:39:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 3/8] livepatch: Implement replace set for
 scoped atomic replace
Message-ID: <apD937ehtQ3CUPBY@jpoimboe>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
 <apDO-a2n9UlrO_FA@jpoimboe>
 <CALOAHbAoJf-brcQW-QtXZzR+8xi2ZCAJNwyHBQguXJCr+5+5xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAoJf-brcQW-QtXZzR+8xi2ZCAJNwyHBQguXJCr+5+5xg@mail.gmail.com>

On Fri, Aug 28, 2026 at 11:03:02AM +0800, Yafang Shao wrote:
> On Fri, Aug 28, 2026 at 8:26 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > +     # Remove duplicates from obsoletes (if specified)
> > > +     # Note: provides ID is not added here; the kernel will replace
> > > +     # livepatch with the same provides ID.
> > > +     if [[ -n "$OBSOLETES" ]]; then
> > > +             local obsoletes_clean="${OBSOLETES//[ ]/}"
> > > +             local IFS=','
> > > +             local -a obs_array=()
> > > +             local obs_id
> > > +             local already_exists
> > > +
> > > +             for obs_id in $obsoletes_clean; do
> > > +                     if [[ -n "$obs_id" ]]; then
> > > +                             already_exists=0
> > > +                             for existing in "${obs_array[@]}"; do
> > > +                                     if [[ "$existing" -eq "$obs_id" ]]; then
> > > +                                             already_exists=1
> > > +                                             break
> > > +                                     fi
> > > +                             done
> > > +
> > > +                             if [[ "$already_exists" -eq 0 ]]; then
> > > +                                     obs_array+=("$obs_id")
> > > +                             fi
> > > +                     fi
> > > +             done
> > > +
> > > +             local IFS=','
> > > +             OBSOLETES="${obs_array[*]}"
> > > +             unset IFS
> > > +     fi
> > > +
> >
> > What's the point of this?   Do we expect duplicates,
> 
> Duplicated ids are indeed a user input error (e.g. -r "1,1,2,3") and
> should not be expected.
> 
> > and if so, wouldn't
> > it be the kernel's job to handle that?
> 
> On the kernel side the duplicates are safe:
> klp_patch_replaces() iterates over the obsoletes array and compares
> each entry against the other patches' provides, so a duplicated id is
> simply idempotent - the only side effect is duplicated ids shown in
> the /sys/kernel/livepatch/<patch>/obsoletes attribute.
> 
> Silently deduplicating in klp-build was masking the input mistake.
> Agreed on the fail-fast approach: klp-build will now error out with a
> clear message when duplicate obsoletes ids are detected.  The list
> passed to the kernel is then guaranteed clean, and the sysfs side
> effect cannot happen.

There are other ways of building livepatches beyond klp-build, and this
wouldn't prevent those other patch generation methods from making the
same mistake.

But since it doesn't actually break anything, and the user is not likely
to be setting multiple obsoletes, much less introducing duplicates, I
would say just remove the check altogether.  It's not really a bug and I
doubt that somebody who is careless enough to have duplicate obsoletes
would notice or care that sysfs also has duplicates... and if they do
care, they should fix their patch :-)

For similar reasons I think some of the other error checking isn't
really needed (invalid comma usage, negative number check) as those will
either fail the build or will give the user what they asked for, not
dissimilar from providing a buggy patch.

Then I think the majority of those klp-build changes aren't needed, and
it can be a simple passthrough of the user cmdline:

  cflags+=("-DKLP_OBSOLETES=$OBSOLETES")

-- 
Josh
