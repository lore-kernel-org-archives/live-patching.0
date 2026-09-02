Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087A3B47C9
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334471; cv=none; b=QfJE+yJDQAC7wbbjpxsoZq+VcBkhxWwP20p3ic+KXMB55J7GpABrx8PcneqMCv/D4HTPvVyLeBhzopWBHDuuqt3N5GPMI9ah7LtjTUxW3QYcrcvOnW56RWQnYP6fG689lUhXGYGKHU0T54UVi90EVufoYEzYD3w52YUZAkgZ2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334471; c=relaxed/simple;
	bh=pKYpIgzXJJ6fZi7L1npC0B6nPfwEMo5TGR8OAhIP3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdngnQcC/AXFYP3YvDE3EKxBk9oUj6WG+1l+OpL/s3kwTPcStiUcafErUWz66MU9S/xsz98V4WiHLqPUuPILOChv+uaWBjMW81YnhqeDsL3HMI0oY1zT7h7DbV0yv5oX67lqcI5VMJDOTN6nb7F/w8v40RlsbUuRw3s9tRVxkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AZzhv2iq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AZzhv2iq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b9320423cso6776755e9.0
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788334467; x=1788939267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8SkUcBwsjgCEGiLN9VoiV8KYwIT+v+IQqhf9NDpiNA=;
        b=AZzhv2iqmfZOfDPZTM0a+JRrvh90QEI9Z2a8pywcfUd3NmiLw3NE1p61+JUp7qq5aT
         o78vV1htWsiT2Pr3y5VqQjCAm1wftlm68CiHXvSmz5WcnZz0f7a+fu1og8ruS1qSmvfz
         j7Rkp/zdpMhOCZk5dDkzd89jOPKFyC3t7cCc+B4Motj4TeM3onV1DR/ZkRXtBpipBdQh
         F1NsmtpJBbl5cf56Pako6HIgamgzfFOnUdfwbCCCzj+TYgnkeoHKH/WhUxoS1fuc9fBJ
         JXGPzXurplXdFRwkc0bAsUSWzc6p8KccxGbwNRfkI9lDr78GTOe9hrBJTOSvmkrAkBKM
         +o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334467; x=1788939267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8SkUcBwsjgCEGiLN9VoiV8KYwIT+v+IQqhf9NDpiNA=;
        b=Rz/LdQpafyEvbDx43pn5LW38+yEHlF0wwRzzI+es51yhaYtAPdbzq1D+jqWDqoCHWk
         vvPFue6cYIz2EG5WHqXIqsPEUmVP1YIxBV5tmcBgX61CQhFmPJHLMJc1+JyJQRNlAf0A
         5fckg/5fCrqu6l6jp8e3dnymFFtknfe9YbMyOvrupzjx4wzeOfF6Lyt38U+7Wg1v3Jsi
         1iyRFIyaJQPicjL9yOpU7m9zOEWzzpptzKyOop0VFwPJoTnYZz3kr9jaMx4RFHg6E7tx
         J27+IMIRVuIpa+y6hgxG71UQLggbOlA2XdIzVL2eciu8kw7NclOtXoSU+ui3asVLiFq+
         yq2w==
X-Forwarded-Encrypted: i=1; AHgh+RoniMhBCqe4GvoOra0zEVU+dfW6SSPY/5hPUor3a5Ioagjtv0QTEhwu/HWtHAVDmA2R6mFq0/U3V0XRn2Vs@vger.kernel.org
X-Gm-Message-State: AFuF++l0xohtuieiBGBwn0QHr32d/QQXwXGt5gImQ+3VI+82fZ/jFvzO
	NeB2Kdlm+JYiDAly6bLzz8odIDdLso9+J5fBe51be5zyCpwYX46+77qo4nwzjysu2dU=
X-Gm-Gg: AR+sD11Ue0T+KfDnFasOou6AxToyxsSLfKQEkgCl3L4ou3hrHFKFx1OuFx+z8QdvrCe
	eTuaJEBoarTeqMAp2lIaXzMpX+PqzpJo9h3nhXPWeOE9ZfAsHnl3qp32snPei72YlovqOf18Xp4
	FvQaQ3/0YF0CR3aBv2bHKfT3a6v7ucLEDZ8o6T5LMAo7cgFHGhwlhsby04QtgHQkXjmndOuPc6l
	nupzCkx0aEaUfH+Ra6ieWJtA3mx1xya1rDzJ9gXsjCPfZlk0wBNHTCSqvoNfvd9BRIGFqoqADZe
	JjCVE2jj+XttwSUAv6OjQOEy7+/4drsE7REIqzZcb3Oup3K7h5fQnZwycmFQRW6pRDhyMtCpSuL
	nACNltJLEL7NeqtbKFqZON4USqG6b3X05ldUiR8heCRa+rJIAdDv82FkWSLlqs3NPL1ZpLmQpz2
	azEHhH8tUY1bO7aXciwv2BhCtoggNVPXh89nkdwO3S01RDICHqc8efxje6vfkpjw==
X-Received: by 2002:a05:600c:83c8:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49ce581779dmr52865215e9.4.1788334467358;
        Wed, 02 Sep 2026 00:34:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7315bsm4685433f8f.7.2026.09.02.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:34:26 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:34:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: documentation: was: Re: [PATCH v7 for-next 3/8] livepatch: Implement
 replace set for scoped atomic replace
Message-ID: <apfRgPN7FWsgYSOn@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-4-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the patch replace set.
>   By default (provides=0), any livepatch replaces any other livepatch.

What is the "replace set"? The term is used few times in
the commit message, documentation, comments but it is not
defined anywhere.

IMHO, the term is a bit misleding, both "replace" and "set" parts.

1. My understanding is that "provides" is an "id" which is connected
   by a set of objects, and functions which are modified (replaced?)
   by the livepatch? Here the "replace" would mean "replaced
   functionality".

   But the provides id also covers the related callbacks, shadow
   variables and livepatch states. Here the word "replace" does
   not fit.


2. We are talking about "atomic replace". Here one livepatch replaces
   one or more other livepatches. Here the word "replace" would mean
   "replace livepatch(es)". But does the livepach replace one or more
   livepatch sets?

Do we need this term at all?

IMHO, we could live better without it, for example:

<proposal>
Subject: livepatch: Implement provides and obsoletes for scoped atomic
replace

- provides: an usinged int id identifying the changes made by
  the related livepatch. Where the changes are a set
  of modified objects, functions, and used callbacks,
  shadow variable ids, and state ids.
</proposal>

> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different replace sets.

We should mention here the special meanting of the "0" id.
It enforces the most secure mode when only one livepatch
can be enabled at any time.

Also it is important to explain here also the compatibility
rules. They are important part of the design.

This approach allows to have more livepatches installed in parallel
but only when they are not conflicting. They would conflict if
they attempt to livepatch the same function or use livepatch states
with the same ID.

> A new livepatch atomically replaces any existing livepatch whose
> provides id matches either:
>   1. The new patch provides id (same replace set), or
>   2. Any id in the new patch obsoletes list
> 
> The klp-build script is updated with -p/--provides and -r/--obsoletes
> options. The obsoletes list automatically includes the provides id
> and deduplicates entries. Input validation rejects malformed values
> at build time.
> 
> Two helper functions are introduced:
> - klp_patch_replaceable(): checks if an new patch will replace the old
>   patch
> - klp_has_function_conflict(): rejects loading a livepatch that would
>   modify a function already patched by a livepatch with a different
>   provides id.

I agree with Josh. There is no need to mention these two new
functions in the commit message.

> Suggested-by: Song Liu <song@kernel.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  .../ABI/testing/sysfs-kernel-livepatch        | 22 ++++-
>  .../livepatch/cumulative-patches.rst          | 93 +++++++++++++------
>  Documentation/livepatch/livepatch.rst         | 23 +++--
>  include/linux/livepatch.h                     |  7 +-
>  kernel/livepatch/core.c                       | 69 ++++++++++++--
>  kernel/livepatch/core.h                       |  1 +
>  kernel/livepatch/state.c                      | 57 ++++++++++--
>  kernel/livepatch/transition.c                 | 11 ++-
>  scripts/livepatch/init.c                      | 71 +++++++++++++-
>  scripts/livepatch/klp-build                   | 78 ++++++++++++++--
>  10 files changed, 351 insertions(+), 81 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
> index 3c3f36b32b57..2588f676deb1 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -47,13 +47,25 @@ Description:
>  		disabled when the feature is used. See
>  		Documentation/livepatch/livepatch.rst for more information.
>  
> -What:		/sys/kernel/livepatch/<patch>/replace
> -Date:		Jun 2024
> -KernelVersion:	6.11.0
> +What:		/sys/kernel/livepatch/<patch>/provides
> +Date:		Jun 2026
> +KernelVersion:	7.4.0
>  Contact:	live-patching@vger.kernel.org
>  Description:
> -		An attribute which indicates whether the patch supports
> -		atomic-replace.
> +		An attribute to show the provides id of this livepatch.
> +		Only one active livepatch per provides id is allowed.

This sounds like you could not load another livepatch with the same
id. But you actually could. We should make it clear that it would
replace the existing one. I suggest something like:

<proposal>
		An attribute to show the provides id of this livepatch.
		Livepatches with the same provides id replace each other.
</proposal

> +
> +What:		/sys/kernel/livepatch/<patch>/obsoletes
> +Date:		Jun 2026
> +KernelVersion:	7.4.0
> +Contact:	live-patching@vger.kernel.org
> +Description:
> +		An attribute to show the obsoletes ids of this livepatch.
> +		The obsoletes ids are a comma-separated list of provides
> +		ids that this patch obsoletes. When this livepatch is
> +		loaded, any existing livepatch whose provides id matches
> +		either this patch's provides id or any id in the obsoletes
> +		list will be atomically replaced.
>  
>  What:		/sys/kernel/livepatch/<patch>/stack_order
>  Date:		Jan 2025
> diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
> index 1931f318976a..04352ae3f0d0 100644
> --- a/Documentation/livepatch/cumulative-patches.rst
> +++ b/Documentation/livepatch/cumulative-patches.rst
> @@ -2,33 +2,66 @@
>  Atomic Replace & Cumulative Patches
>  ===================================
>  
> -There might be dependencies between livepatches. If multiple patches need
> -to do different changes to the same function(s) then we need to define
> -an order in which the patches will be installed. And function implementations
> -from any newer livepatch must be done on top of the older ones.
> -
> -This might become a maintenance nightmare. Especially when more patches
> -modified the same function in different ways.
> -
> -An elegant solution comes with the feature called "Atomic Replace". It allows
> -creation of so called "Cumulative Patches". They include all wanted changes
> -from all older livepatches and completely replace them in one transition.
> -
> -Usage
> ------
> -
> -The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
> -for example::
> -
> -	static struct klp_patch patch = {
> -		.mod = THIS_MODULE,
> -		.objs = objs,
> -		.replace = true,
> -	};
> -
> -All processes are then migrated to use the code only from the new patch.
> -Once the transition is finished, all older patches are automatically
> -disabled.
> +Livepatches are used to fix kernel bugs. New fixes need to be added over time.
> +The fixes might be independent, but they might also depend on each other. This
> +brings a challenge of how to keep the livepatched system safe and consistent.
> +
> +Part of the solution is the "Atomic Replace" feature, which allows the kernel to
> +atomically replace an existing livepatch with another one. These newer
> +livepatches are designed as "Cumulative Patches". They include all wanted
> +changes from all older livepatches and completely replace them in one
> +transition.
> +
> +The second part of the solution is the newly introduced ``provides`` and

s/is the newly introduced/are/

"the newly introduced" would fit into the commit message but not into
the documentation. The fields are new _now_. But the documentation
should make sense as long as the feature is there.

> +``obsoletes`` fields in ``struct klp_patch``, which allow the installation of
> +multiple livepatches in parallel. A livepatch will atomically replace any
> +already installed livepatch whose ``provides`` id matches either the new
> +patch's ``provides`` id or any id in the new patch's ``obsoletes`` list.
> +This might be used to fix independent problems separately, for example, the
> +livepatches might be prepared by separate teams focusing on particular
> +functionality or a subsystem.
> +
> +It should be emphasized that the preferred and most secure way is to always use
> +the default ``provides = 0``. In this mode, any livepatch replaces any other
> +livepatch, preventing any unexpected interactions between incompatible
> +livepatches.

We should make it clear here that '0' is really special. It basically
provides and obsoletes livepatches with any other IDs.

> +Provides and Obsoletes
> +-----------------------
> +
> +The ``provides`` field in ``struct klp_patch`` is an unsigned integer that
> +identifies the livepatch's replace set. By default, it is 0.

I would get rid of the "replace set" term.

> +The ``obsoletes`` field is an optional array of unsigned integers that
> +specifies additional ``provides`` ids to be replaced when this patch is
> +loaded.

The above part is good.

> By default, it includes the patch's own ``provides`` id, ensuring
> +that a new patch always replaces any existing patch with the same
> +``provides`` id.

This sentence is confusing. My undestanding is that we do not need
to mention patch's own provides id in the obsoletes array. I would
just omit this sentence.

> +
> +For example::
> +
> +        static struct klp_patch patch = {
> +                .mod = THIS_MODULE,
> +                .objs = objs,
> +                .provides = 0,
> +        };
> +
> +Any ``provides`` value might be associated with a set of livepatched symbols,
> +callbacks, shadow variables, and state IDs. By definition, there can only ever
> +be one active livepatch for a given ``provides`` id.
> +
> +On the contrary, livepatches with a different ``provides`` id must not
> +modify the same function, or use the state with the same ID. Any attempt to
> +load an incompatible livepatch will be rejected by the kernel.
> +
> +Atomic Replace
> +--------------
> +
> +A livepatch with a given ``provides`` id is replaced by another livepatch
> +with the same ``provides`` id, or whose ``obsoletes`` list includes that id.
> +All processes are migrated to use the code only from the new patch. Once
> +the transition is finished, the older patch is disabled. Patches with a
> +different ``provides`` id are not affected and remain active.
>  
>  Ftrace handlers are transparently removed from functions that are no
>  longer modified by the new cumulative patch.
> @@ -64,7 +97,11 @@ Limitations:
>    - Once the operation finishes, there is no straightforward way
>      to reverse it and restore the replaced patches atomically.
>  
> -    A good practice is to set .replace flag in any released livepatch.
> +    A good practice is to use only one (default) ``provides`` id. It
> +    makes sure that there always will be only one enabled livepatch
> +    on the system. The consistency model will ensure a safe update
> +    between two versions. It prevents potential problems with installing
> +    two livepatches doing incompatible functional changes.
>      Then re-adding an older livepatch is equivalent to downgrading
>      to that patch. This is safe as long as the livepatches do _not_ do
>      extra modifications in (un)patching callbacks or in the module_init()
> diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
> index acb90164929e..73635f9ddd91 100644
> --- a/Documentation/livepatch/livepatch.rst
> +++ b/Documentation/livepatch/livepatch.rst
> @@ -347,15 +347,20 @@ to '0'.
>  5.3. Replacing
>  --------------
>  
> -All enabled patches might get replaced by a cumulative patch that
> -has the .replace flag set.
> -
> -Once the new patch is enabled and the 'transition' finishes then
> -all the functions (struct klp_func) associated with the replaced
> -patches are removed from the corresponding struct klp_ops. Also
> -the ftrace handler is unregistered and the struct klp_ops is
> -freed when the related function is not modified by the new patch
> -and func_stack list becomes empty.
> +There can be only one active livepatch for a given ``provides`` id.
> +A new livepatch atomically replaces any existing livepatch whose
> +``provides`` id matches either the new patch's ``provides`` id or
> +any id in the new patch's ``obsoletes`` list.
> +
> +Once the transition is complete, all functions (``struct klp_func``)
> +associated with the matching replaced patches are removed from the
> +corresponding ``struct klp_ops``. If a function is no longer modified by
> +the new patch and its ``func_stack`` list becomes empty, the ftrace
> +handler is unregistered and the ``struct klp_ops`` is freed.
> +
> +Patches with a different ``provides`` id are not affected by this
> +process and remain active. This allows for the independent management
> +and stacking of multiple, non-conflicting livepatch sets.

I would avoid the word "stacking". The livepatch code has this term
connected with func->stack_node and ops->func_stack. It allows to
associate more struct klp_func entries with the same ftrace handler.
The last or the last-but-one entry is then used depending on
the state of the transition.

By other words, the stacking is used in the livepatching code when
two livepatches modify the same function. But such livepatches are
_conflicting_.

By other words, the  sentence: "allows independent.*stacking of multiple,
non-conflicting livepatch sets" does not make sense.

>  See Documentation/livepatch/cumulative-patches.rst for more details.

Best Regards,
Petr
