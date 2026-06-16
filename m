Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AC35292A
	for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634054; cv=none; b=sPp+wb/3BMmglaM65QCme93YM4u7dE1r1sG/TxEr/mRxoE9+QkcG2bhpzYPUZ8ME96bvwo16ySflVQUzgUeTGaOoQGQicp9jKRYLrczRULS1FoSYS0e8SyJ6T3IgF5gBWfgN8PAAkZ+7to3H3yHU4FkYjbvsGpqeig755vzDUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634054; c=relaxed/simple;
	bh=9zcIA0cyDF9PJI730ozJOWLT+Pj3VODz2/NaCgU0PKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BREwOjVSS6VCSH7z5k1xsfnWtXBplwq8cs0C65/lSKO3f9Tp8Q6bDnAGBeE27GCO41zamdGsL/haBnogdN6Ii6W1WTRQJW19DkmC7J7aoWepeF4B36rdzRCrC5fsYC5g7EdIKbEGjBewAgVxGvM7LQ0LLTevkkIK8UsVMUSVpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgPXfGkW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgPXfGkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781634052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n1FxRpGhCUQ12/UmMWgUtST1f+q7/kBCkp7ce9s9NZM=;
	b=MgPXfGkWY5ncD6RoJyd2f9FWgOFzOKiZlrPj7YQl2X1JghHU7avNfHc6qelTF1NgLDJdm3
	D817kv9JE6KejPqc7ZSfkPUN6QvtOalonD9ZAxSn8nU35rF0usHp5H3qGiiyM47fbwvPTO
	11bXRFQ/j99IYl5WcYcCms1K1kaHqrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-9Vw8NdqyPhmfnw7dFGGjaQ-1; Tue,
 16 Jun 2026 14:20:46 -0400
X-MC-Unique: 9Vw8NdqyPhmfnw7dFGGjaQ-1
X-Mimecast-MFC-AGG-ID: 9Vw8NdqyPhmfnw7dFGGjaQ_1781634045
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DB171955EA2;
	Tue, 16 Jun 2026 18:20:45 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.115])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D39C195419F;
	Tue, 16 Jun 2026 18:20:43 +0000 (UTC)
Date: Tue, 16 Jun 2026 14:20:40 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
	song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <ajGT-B6EaOyhAOnb@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-4-laoar.shao@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Jun 07, 2026 at 09:16:55PM +0800, Yafang Shao wrote:
> Convert the replace attribute from a boolean to a u32 to function as a
> "replace set." A newly loaded livepatch will now atomically replace any
> existing patch belonging to the same set. There can only ever be one active
> livepatch for a given replace_set number.
> 
> This change currently supports function replacement only. Livepatches that
> belong to different replace sets cannot modify the same function. If a new
> livepatch attempts to modify a function already modified by an older
> livepatch from a different replace_set, the loading of the new livepatch
> will be refused.
> 
> Similarly, for the KLP state, livepatches belonging to different replace
> sets cannot use the same state ID. The system will refuse to load a new
> livepatch if it uses a state ID already in use by an older livepatch from
> a different replace_set.
> 
> For the KLP shadow variable mechanism, developers must assign unique shadow
> IDs to livepatches that belong to different replace sets.
> 
> Support for replace_set compatibility with KLP state and shadow variables
> will be implemented after Petr's KLP state transfer work is completed [0].
> 
> Other user-visible changes include:
> - The non-replace model is now deprecated
> - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
>   /sys/kernel/livepatch/livepatch_XXX/replace_set
> 
> Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]
> Suggested-by: Song Liu <song@kernel.org>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../ABI/testing/sysfs-kernel-livepatch        |  5 +-
>  .../livepatch/cumulative-patches.rst          | 23 ++++++---
>  Documentation/livepatch/livepatch.rst         | 21 ++++----
>  include/linux/livepatch.h                     |  5 +-
>  kernel/livepatch/core.c                       | 24 +++++----
>  kernel/livepatch/state.c                      | 51 +++++++++++++++----
>  kernel/livepatch/transition.c                 | 11 ++--
>  scripts/livepatch/init.c                      |  6 +--
>  scripts/livepatch/klp-build                   | 16 +++---
>  9 files changed, 104 insertions(+), 58 deletions(-)
> 
> [ ... snip ... ]
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 6e15ae96a0a7..361999e5ce3d 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> [ ... snip ... ]
> @@ -600,6 +600,8 @@ static int klp_add_nops(struct klp_patch *patch)
>  		klp_for_each_object(old_patch, old_obj) {
>  			int err;
>  
> +			if (patch->replace_set != old_patch->replace_set)
> +				continue;
>  			err = klp_add_object_nops(patch, old_obj);
>  			if (err)
>  				return err;
> @@ -772,6 +774,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
>  	klp_for_each_patch_safe(old_patch, tmp_patch) {
>  		if (old_patch == new_patch)
>  			return;
> +		if (old_patch->replace_set != new_patch->replace_set)
> +			continue;
>  		klp_free_patch_async(old_patch);
>  	}
>  }
> @@ -967,11 +971,9 @@ static int klp_init_patch(struct klp_patch *patch)
>  	if (ret)
>  		return ret;
>  
> -	if (patch->replace) {
> -		ret = klp_add_nops(patch);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = klp_add_nops(patch);
> +	if (ret)
> +		return ret;

The pre-existing comment above klp_add_nops() is now misleading:

  They are added only when the atomic replace mode is used and only for
  functions which are currently livepatched but are no longer included
  in the new livepatch.

That function is now called unconditionally, and with this patchset,
there is no more "replace mode" but "replace sets".  How about something
like:

  For each older patch in the same replace_set, any function that is
  currently livepatched, but no longer included in the new livepatch
  gets a nop entry, ensuring a clean transition back to the original
  code during atomic replacement.

--
Joe 

