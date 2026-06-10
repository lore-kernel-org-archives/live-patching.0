Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECA358363
	for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102765; cv=none; b=MFxJOpFj1OWTvPn4NGqZcl69hJMc2SPzUFedCCWVOagsODuCnUStoydSBOXviKYHj5ZWxokb2eZyRpgZapPumGDrylBlVIpqPc3+kTmnUZEssx/DR6rhFYeuG5HVzJFlLd2vuELhUsEyEJQ4a5FEzOVcf92+iG/6UtvYj8apc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102765; c=relaxed/simple;
	bh=gBYPnkyUjGF9t+Re3em0UhYqTdz9ijNR+Edzpqu6jfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6FPsNr3tiSs3PrmW69bNjB33SNSViF78RBjoQxO0Y49jA4xYVBwYGBPBA1ml5CDKPZKJoAWb+6l25wNLo0ve28bDTULls4E9nGIp6bUQ9hCbD2xwAszVrGo1VHBQN7kI5boLCoNOIKtON6QOqmxU6Qek+cvWHnS2mnGK11DLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HUdXntMS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HUdXntMS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so5198685f8f.2
        for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781102759; x=1781707559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHviteDo9sRtHYMVs15OACepiXc/N29PQJ4BwLqhqYo=;
        b=HUdXntMSEY44jom4bf0hCBI5OrZ5qdv7OeEPkO43IRKylPAVqOelUyVSeLilQw2IlF
         eYb21hTjBs7KhOxmpdd+8hDgY0ohHNTUWQ9eY7zscQjaS2kvz0nC73aQ/XlT8dFPzbfv
         gNgiMJD7cNIsLR8OkUaV3NJVCAiDYK1luOkH54PrddfF34tEouQ/wKyYP6ZPxPEbL0bl
         tYBBXQL8nXH/B/ft5N5ZSzjIGCSVVVCPjBsPS6XprBICBO57kDIKVGta7GUolf4FnFeI
         yQvyQf0jBzlcx7UL5TNi4kQ2VO2EjOJIYaHo8yDP/8NGaOW+DpxY32GUn0m/wEJHL32W
         exnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102760; x=1781707560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHviteDo9sRtHYMVs15OACepiXc/N29PQJ4BwLqhqYo=;
        b=kOx7bB6No1Zm6gmRNiFjmakGHjZq5exVm+l+K+DxNL2g5DVoo9f8KQtZWm9bNfSnjO
         USHVeLGL2ToMeooLsVEYpu0c7B3O2ACZ4ItkMra4agc4ea4Z6XjYuD1N+gKPRJ3xzROr
         uJX535oHI9MkuUY0pi/hct+Q5sKMy01PTOh72M1yN/ypNXWa6Jj1rh4bYetF8WkX3OOF
         EdmJIViyPby2iXewqDcuMi5S5rBMugaXqfS7JoM9dtYPVkPAjsoWUi7PG17aKhzYyHjS
         KZW4j0F+4q23AJ5fPsrCj9t90nGCpTnMmnglzzHLByY6v7CKEjYLoiY+VDYPyNHTeZXR
         n1Ng==
X-Forwarded-Encrypted: i=1; AFNElJ/2805x/Q+FWhxL8sJ1m8z4fGmvJAM+oN2N3UMkZF1sSpOzIOh1hRnHipV+4/6x01Yg3dOKaAPb25ACc7qe@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4+AxQ4OBMozN59iJM7CGZL3ys5adEF2DF3sMwOWNrB1XGV3k
	gfGB6ugDAC3XcUiVBAYvgQAWI4TTv/4FZRc3w22HmhBIH3ICshRrRygjNq0lZJ7O0H0=
X-Gm-Gg: Acq92OGM7FnNc3h5ggUOCxgcqiavpU8PezMs6wdG/IpsPgzT0pSNwKKkly8hunZig9h
	WVx03RfFqb0TfxoT3seD3H1uN8oh494LHxopNWaYYWgiUGSK26rTncZ5iQwcTx27frsE/bkD28u
	m2jcaGXiawP3sGeEhbD/E09bymBp71gHtuUTCdfZKde1LMlxASlfOZFdEL1V4ks01j5GElt5bkQ
	EJ65+vGz7GLgjs58Z6phwWbcFoL1l2AMaMqWAhWbhvx2PfN6mxfR/rHWqf1U5Rk3UAVxHUIUIX7
	txaw8vygGiERagPHavoQLv12vyEv5LPvbPhU1+ZRcFQRu+WzFyIAyLVb/Y1rZP/dduGL9kYvf6n
	ArM2BJuX6/QPr40/49X5ZHLBU1HGf+UaxNoQZsc+C0MQ9xeRsMUcR7nRWZfmO0FByRKkKSEDRgl
	xaz9i/dztyFDnOcm0C6/Zmm0rCWr719Qh6pJgi
X-Received: by 2002:a5d:53cb:0:b0:45e:b215:12e9 with SMTP id ffacd0b85a97d-460302dcb18mr27430239f8f.6.1781102759439;
        Wed, 10 Jun 2026 07:45:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm74632954f8f.11.2026.06.10.07.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:45:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:45:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: code review: was: Re: [PATCH v3 3/7] livepatch: Support scoped
 atomic replace using replace_set
Message-ID: <ail4pUt-t-0AB2wi@pathway.suse.cz>
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

On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
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
> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -47,13 +47,12 @@ Description:
>  		disabled when the feature is used. See
>  		Documentation/livepatch/livepatch.rst for more information.
>  
> -What:		/sys/kernel/livepatch/<patch>/replace
> +What:		/sys/kernel/livepatch/<patch>/replace_set
>  Date:		Jun 2024
>  KernelVersion:	6.11.0

The Date and KernelVersion should be upsated as well.
It is a new attribute...

>  Contact:	live-patching@vger.kernel.org
>  Description:
> -		An attribute which indicates whether the patch supports
> -		atomic-replace.
> +		An attribute to show the replace_set of this livepatch.
>  
>  What:		/sys/kernel/livepatch/<patch>/stack_order
>  Date:		Jan 2025
> diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
> index 1931f318976a..0361adb12f6d 100644
> --- a/Documentation/livepatch/cumulative-patches.rst
> +++ b/Documentation/livepatch/cumulative-patches.rst
> @@ -17,18 +17,20 @@ from all older livepatches and completely replace them in one transition.

We need to update also the introduction part above. I propose
the following text:

<proposal>
Livepatches are used to fix kernel bugs. New fixes need to be added over time.
The fixes might be independent, but they might also depend on each other. This
brings a challenge of how to keep the livepatched system safe and consistent.

Part of the solution is the "Atomic Replace" feature, which allows the kernel to
atomically replace an existing livepatch with another one. These newer
livepatches are designed as "Cumulative Patches". They include all wanted
changes from all older livepatches and completely replace them in one
transition.

The second part of the solution is the newly introduced ``replace_set`` feature,
which allows the installation of multiple livepatches in parallel. A livepatch
will only replace other livepatches that share the same ``replace_set`` number.
This might be used to fix independent problems separately, for example, the
livepatches might be prepared by separate teams focusing on particular
functionality or a subsystem.

It should be emphasized that the preferred and most secure way is to always use
the default ``replace_set = 0``. In this mode, any livepatch replaces any other
livepatch, preventing any unexpected interactions between incompatible
livepatches.
</proposal>

>  Usage
>  -----

I would split the "Usage" section into two new sections, see below.

> -The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
> -for example::
> +The "replace_set" attribute in ``struct klp_patch`` acts as a **replace_set**,
> +defining the scope of the replacement. By default, the replace_set is 0.
> +
> +For example::
>  
>  	static struct klp_patch patch = {
>  		.mod = THIS_MODULE,
>  		.objs = objs,
> -		.replace = true,
> +		.replace_set = 0,
>  	};

I would use the above text in a new section called "Replace Set":

<proposal>
Replace Set
-----------

The "replace_set" attribute in ``struct klp_patch`` acts as a **replace_set**,
defining the scope of the replacement. By default, the replace_set is 0.

For example::

	static struct klp_patch patch = {
		.mod = THIS_MODULE,
		.objs = objs,
		.replace_set = 0,
	};

Any ``replace_set`` value might be associated with a set of livepatched symbols,
callbacks, shadow variables, and state IDs. By definition, there can only ever
be one active livepatch for a given ``replace_set`` number.

On the contrary, livepatches with a different ``replace_set`` number must not
modify the same function, or use the state with the same ID. Any attempt to
load an incompatible livepatch will be rejected by the kernel.
</proposal>

And the rest would be in a new section called:

Atomic Replace
--------------

>  All processes are then migrated to use the code only from the new patch.
> -Once the transition is finished, all older patches are automatically
> -disabled.
> +Once the transition is finished, all older patches with the same replace
> +set are automatically disabled. Patches with different tags remain active.

There always could be only one livepatch with the given replace set.
I would write something like:

<proposal>
A livepatch with a given ``replace_set`` number is replaced by another
livepatch using the same number. All processes are migrated to use
the code only from the new patch. Once the transition is finished,
the older patch. Patches with different replace sets are not affected
and remain active.
</proposal>

>  Ftrace handlers are transparently removed from functions that are no
>  longer modified by the new cumulative patch.
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -600,6 +600,8 @@ static int klp_add_nops(struct klp_patch *patch)
>  		klp_for_each_object(old_patch, old_obj) {
>  			int err;
>  
> +			if (patch->replace_set != old_patch->replace_set)
> +				continue;

This should be checked on the klp_for_each_patch(old_patch) level.
The result is the same for each old_obj from the given old_patch...

>  			err = klp_add_object_nops(patch, old_obj);
>  			if (err)
>  				return err;
> @@ -1174,6 +1176,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
>  		if (old_patch == new_patch)
>  			return;
>  

Nit: Remove the empty line here.

> +		if (old_patch->replace_set != new_patch->replace_set)
> +			continue;

Nit: And put it here instead. To separate if/return/continue part from
     the changes done for the eligible old_patch.

>  		old_patch->enabled = false;
>  		klp_unpatch_objects(old_patch);
>  	}
> diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
> index 2565d039ade0..a1ac46637336 100644
> --- a/kernel/livepatch/state.c
> +++ b/kernel/livepatch/state.c
> @@ -85,34 +85,65 @@ EXPORT_SYMBOL_GPL(klp_get_prev_state);
>  
>  /* Check if the patch is able to deal with the existing system state. */
>  static bool klp_is_state_compatible(struct klp_patch *patch,
> +				    struct klp_patch *old_patch,
>  				    struct klp_state *old_state)
>  {
>  	struct klp_state *state;
>  
>  	state = klp_get_state(patch, old_state->id);
> +	if (patch->replace_set == old_patch->replace_set) {
> +		/*
> +		 * If the new livepatch shares a state set with an existing
> +		 * one, it must maintain compatibility with all states
> +		 * modified by the old patch.
> +		 */
> +		if (!state)
> +			return false;
> +		return state->version >= old_state->version;
>  
> -	/* A cumulative livepatch must handle all already modified states. */
> -	if (!state)
> -		return !patch->replace;
> +	}
>  
> -	return state->version >= old_state->version;
> +	/*
> +	 * Two livepatches with a different "replace_set" must _not_ use
> +	 * the same "state->id.
> +	 */
> +	return !state;
>  }
>  
> -/*
> - * Check that the new livepatch will not break the existing system states.
> - * Cumulative patches must handle all already modified states.
> - * Non-cumulative patches can touch already modified states.
> - */
> +/* Check that the new livepatch will not break the existing system states. */
>  bool klp_is_patch_compatible(struct klp_patch *patch)
>  {
> +	struct klp_object *obj, *old_obj;
>  	struct klp_patch *old_patch;
>  	struct klp_state *old_state;
> +	struct klp_func *func;
>  
>  	klp_for_each_patch(old_patch) {
>  		klp_for_each_state(old_patch, old_state) {
> -			if (!klp_is_state_compatible(patch, old_state))
> +			if (!klp_is_state_compatible(patch, old_patch, old_state))
>  				return false;
>  		}
> +
> +		if (old_patch->replace_set == patch->replace_set)
> +			continue;
> +
> +		/*
> +		 * Refuse loading a livepatch which would want to modify a
> +		 * function which is already livepatched with the livepatch
> +		 * with another "replace_set".
> +		 */
> +		klp_for_each_object_static(patch, obj) {
> +			klp_for_each_object(old_patch, old_obj) {
> +				if (!!obj->name != !!old_obj->name)
> +					continue;
> +				if (obj->name && strcmp(obj->name, old_obj->name))
> +					continue;
> +				klp_for_each_func_static(obj, func) {
> +					if (klp_find_func(old_obj, func))
> +						return false;
> +				}

The combination of for_each_() and for_each_*_static() variants look
correct but it is a bit scarry.

I think about calling klp_init_patch_early() before
klp_is_patch_compatible() so that we could use the non-static
for_each_*() variants even for the new patch. It would make the life
easier. But I do not have strong opinion about it.

> +			}

Anyway, please, put the new check into a separate function, something
like:

bool klp_has_function_conflict(struct klp_patch *patch,
			       struct klp_patch *old_patch);


> +		}
>  	}
>  
>  	return true;

The rest looks good.

Best Regards,
Petr
