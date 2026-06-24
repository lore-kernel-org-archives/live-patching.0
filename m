Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07403624C2
	for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309376; cv=none; b=u/TEjkntjBVoW+VxoSgB8SLVknis5+yycwwHdI19lN2KkqgA4EyAKmX+BfV5INvnWYb5EvtQVsKi8Zb1hR1iFXjmn8ZEz7AaMyCvJsOs1JjwGeTUVjUiHJZZPXjCXjlLD1xMFZzD1DOKQ+Vti6uLH4LePahMThqX73CDP0c2bOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309376; c=relaxed/simple;
	bh=C/9M3/amxP1OAVQAthHHKpK5OgmWfdU/PasElRh8Unk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3hdQZyh7LARszkGI7WSSoaPRfQ9CGDKjlKgLJ6qSeRv1oGWqRKp8G2Z2FVmTMqh9McDS0ppz/1hUdn0C6EextO/a0LtmToRNNjLT7UtqGvGkAcoGXEk9TD5rpw5UMjJapJRpvLeldtHXnQjTYqjD0hIf6C9R1jNzmXcU0nfhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gYg/8oDp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gYg/8oDp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so8943455e9.2
        for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782309373; x=1782914173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzS0IrPXzLvwOk9ygCaJpomrcePV/yR6t2T0hbYCUzs=;
        b=gYg/8oDpivM3wAvbtH404EKbuh/K3izUOkx7LR/QK8hF0dVchOnLuc/RFB29mfr4F1
         83FggDk7BU+uFC4WtEArf+uetMXs76nCyu1FU4d4VQPRl+PDlXlaJIf2xN+2+VrR6fBi
         nLPjfEhpWjQxWyMslgfrTlyQPdlmiGr+5USdYdTaiBdt9yj5/Q0/6H/lanqOHmjtLH3Y
         5gSTVIp2gEEibstXLg1QvtBFqpIW+bFk3RIraZDFLMZoNFf9pblu8BMkJFqPCzL0j6/i
         sMjQYYoLffdASJ1mqeKOcUhlt95+LFJ84eRuCtYRS+0wwy8irf4/vi+1wq7rLsVjyyIr
         6/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309373; x=1782914173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzS0IrPXzLvwOk9ygCaJpomrcePV/yR6t2T0hbYCUzs=;
        b=lm/YBDgVIc0ZFymZbsSjZ8CWX0zdn7iEbpZczw5SwyqVQ5Z67KfTuV5talAHFLvpfu
         BcFbFYPXy9uV6rwxmXmNIXYgtla5CWWB79FF5ck/4UiB8Lq+hO1iOVK7rmfZpj3cubgG
         s8ZSB6jhaUODNnk8v5IFgWSO5EqckCj+3Nz1iGFCu8YdqlZexS+WTV9XumsADWBvTiVH
         kY4+Wr3VOWWtDOmdliVyo9VFWK00SlWedmIWYLtGHGNeGSXQrc17kCo1YonwjZW9aUW7
         GynVCBfwdsxxNAZq9A8SzmCh2XwZvUamFowlXH1tSyDSbRTCVDOKkExeoYJt52HzSV7q
         ZrnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JpX3KU5gEwHm0zsVHP0LjFWUEI8xX6uhFPMy6PiX2fKDS1YqvVLFEk2xb9hrk/v9BAjRvZxZsmnoblK0O@vger.kernel.org
X-Gm-Message-State: AOJu0YxcndN4oPy2XZfoH2LuoASgevEMcAF2YsCSMHCRzq8ut9yOPmuE
	b5H1NW6+egwbcYJvSqVwO33B2fwi2cfmRmmvfpAsegqiPquMdUs1oflFsz+tT2EXyEtS5BlC1y0
	rnQhJ
X-Gm-Gg: AfdE7cnyk6Mwwy1Y0dzciKgqkRA3QyHN1MiuboPrmmhWtJ4uWnCrshs7DdHLjDlV5BS
	bBiD+8gXCnggpTRcqZef1fS3zOlxIXvPHlVrTwSXtZLGQR8AuYJD93DY0S8P0enl0rz75ao4DAA
	y1I3qdzS/HSiut6ZIjGqBNurzMsnwWCpO7vmGwkqpvft9FccTsRROqxuMLKQu8Q57Xfz07c1Qzw
	B40NKNKMCCkeMdAmJqyXZx9ZBJGhE/v2zR7qGT1Lu6KGhG+e6EZDhyzA7AMmLGUbtOsCUzXWB9s
	bd2+164loVnfbFVH9hcbxf0ANQibYvf1nGxsezbzUee3FpfmwuD5av9cH2cDulK/x5mG9hp7gM0
	6BfbhYnaLtE8lJ20LNZ047UjUzTDDU9S/lRrEq92VdsbEaoARIGrJbgjcgZHIGodkexMomREeYY
	k9UrWzPQdqf3guvbQ=
X-Received: by 2002:a05:600c:4686:b0:492:3fcb:22fe with SMTP id 5b1f17b1804b1-49260849d7bmr51274575e9.1.1782309373195;
        Wed, 24 Jun 2026 06:56:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm457546265e9.7.2026.06.24.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:56:12 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:56:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajvh-mMT2blBXJ3x@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <alpine.LSU.2.21.2606231124200.1711@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2606231124200.1711@pobox.suse.cz>

On Tue 2026-06-23 11:40:31, Miroslav Benes wrote:
> Hi,
> 
> On Sun, 7 Jun 2026, Yafang Shao wrote:
> 
> > Convert the replace attribute from a boolean to a u32 to function as a
> > "replace set." A newly loaded livepatch will now atomically replace any
> > existing patch belonging to the same set. There can only ever be one active
> > livepatch for a given replace_set number.
> > 
> > This change currently supports function replacement only. Livepatches that
> > belong to different replace sets cannot modify the same function. If a new
> > livepatch attempts to modify a function already modified by an older
> > livepatch from a different replace_set, the loading of the new livepatch
> > will be refused.
> > 
> > Similarly, for the KLP state, livepatches belonging to different replace
> > sets cannot use the same state ID. The system will refuse to load a new
> > livepatch if it uses a state ID already in use by an older livepatch from
> > a different replace_set.
> > 
> > For the KLP shadow variable mechanism, developers must assign unique shadow
> > IDs to livepatches that belong to different replace sets.
> > 
> > Support for replace_set compatibility with KLP state and shadow variables
> > will be implemented after Petr's KLP state transfer work is completed [0].
> > 
> > Other user-visible changes include:
> > - The non-replace model is now deprecated
> > - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
> >   /sys/kernel/livepatch/livepatch_XXX/replace_set
> 
> I will add my feedback here because the thread where it would belong to is 
> more about details now. I am sorry that I got to it later than I wanted 
> to.
> 
> What I like about the current state (non-replace and replace_all patches) 
> is that it is simple when it comes to the code and it is agnostic to 
> different use cases as we know them. Yes, it can lead to really 
> problematic scenarios on users' side but the kernel code is 
> relatively simple and flexible to allow that. As a distributor we chose 
> something that suits our needs and what we think suits our customers as 
> well. However, it is a downstream choice and implementation.
> 
> Now we learnt that some users would welcome a specific use case of keeping 
> parallel live patches applied on their system and they lack the kernel 
> support for that. That is ok and we should do something about that. There 
> are two things which I am concerned about though.
> 
> 1. I think that we should not leave our existing users (which we do not 
> know much about) behind and regress. I mean we should still allow the same 
> level of flexibility. If not possible, it should be seriously thought 
> through. I am talking about non-replace patches here.

Good point! We do not know about all existing users.

We have already changed the behavior in the past but it has been
relatively long time ago. And it was related to introducing
the "atomic replace":

  + commit 0b3d52790e1cfd6b ("livepatch: Remove signal sysfs attribute
	[Jan 2019]
  + commit d67a53720966f2ef ("livepatch: Remove ordering (stacking)
	of the livepatches")  [Jan 2019]
  + commit e1452b607c48c642c ("livepatch: Add atomic replace")
	[Jan 2019]
  + commit 958ef1e39d24d6cb8 ("livepatch: Simplify API by removing
	registration step") [Jan 2019]

IMHO, we hoped that people would start using the concept of
"cumulative livepatches" and stop using the no-replace mode at all.

Obviously, some users keep using the no-replace mode. And it causes
problems. I am pretty sure that it motivated the following changes:

  + commit 3dae09de4061671 ("livepatch: Add stack_order sysfs
	attribute") [Oct 2024. Wardenjohn <zhangwarden@gmail.com>]
  + commit adb68ed26a3e922 ("livepatch: Add "replace" sysfs
	attribute") [Jun 2024, Yafang Shao <laoar.shao@gmail.com>]

I am not sure if Wardenjohn and Yafang made the changes for the same
user or they were independent.

Another question is whether there are other users who are managing
the dependencies another way or were not able to contribute
to the kernel.

My view:

I believe that there are only very few users who create livepatches.
And they should have capable kernel developers. Because creating
livepatches is not trivial, requires kernel development knowledge,
and some infrastructure.

It is clear that some companies use the non-replace mode for some
reason. But I believe that they have problems to manage them
a safe way.


> 2. Slightly connected. We should not optimize too much for specific 
> scenarios. It seems perfectly fine to introduce a specific feature which 
> helps someone but I am concerned about restricting different use cases at 
> the same time. The latest discussion next door dives into very specific 
> scenarios and my question is "Do we really care?". The user (either a 
> distributor or anyone else) can choose what they want to implement in the 
> end (policy) and how to maintain it (a distributor will typically refuse 
> to support a system with a user applied live patches not provided by the 
> distributor).

> I think that latest proposals in the other thread go in the right 
> direction if I understand them correctly but I also think that we should 
> keep the above in mind (or disagree with me please).

I personally see the proposed changes as another evolution/replacement
of the too-wild and hard-to-manage no-replace mode.

IMHO, the gain is:

    + atomic replace even for livepatches installed in parallel
    + more safety by avoiding conflicts in livepatched functions
	and shadow variable IDs.

the drawback is:

   + loose of a complete freedom (jungle)
   + atomic replace must be used to replace already livepatched function
   + two or more livepatches need to be replaced using a single
     cumulative livepatch when a new change brings dependency
     between them


> It might be difficult to keep the code simple and maintainable in the end 
> and it certainly would not have benefits as the original replace_set 
> proposal where it would all be very simple in the end (only one live patch 
> per function allowed which might lead to substantial code simplification 
> all around the stack).

I agree that we do not want to maintain three modes. We should add the
new approach only when it replaces to old unrestricted no-replace mode.

I personally believe that it is a good step forward and it should be
acceptable. 

Best Regards,
Petr
