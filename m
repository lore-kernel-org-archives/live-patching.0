Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891A3FF89B
	for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337557; cv=none; b=dM1XVu9pOxRSefkxVHyC/Mk4ReEMJlMN2j9LVCYjniTtkv2BrVwhonFrX+Ho0L4LY4fP5XkbdY1vkEzq6il9spPNXfhYLv4I7Gy6s8hvbyOWchNIRvvfi0dUSujpT7rBroXrYeEPiS19O8rG2HG9yYRCIh4Zl22I4JkrZPabsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337557; c=relaxed/simple;
	bh=XHpneeWgtSZbyfAFhM9uJMQF6pLA+5ph6LR1vSZojvg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KBNhvMME2gfoyBlH0CoT+C+k33RnhJN9oO6pqpepyeqO9ybx8ELRtF5QRposJdwyL4PCshlBBtp3hZeTQYXNr8bNbrKWTc1exyWhHvN5Wki3/Z41Sqn7rdQitLm+BpULLKO6rMys3M0AfRh0tOCWMSXtNIzBg0kfiEOfeAqupiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUDljpWv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eQe46sB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tl7IGuNz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPgU6ek9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUDljpWv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eQe46sB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tl7IGuNz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPgU6ek9"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8A73021AEC;
	Fri, 25 Sep 2026 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790337545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4SfW19FOgZeK+Pc8OhKa8QzdvXP3AYYYUwMp0IqgZY=;
	b=iUDljpWv9iQ6E+bF5v6XCb5DCZIgggg2Al9LB1oemiUI0U7kdp7ktXoBrBzK5yGc+LmgmY
	Squq/MDGgq+YD1H6hXjU36ZdlVerD8hmywevnDe1dJARDvworYfgah3OspqC43n/tUUogG
	P387pjoVLOXb+CFUQqRe/C9r/jKuESo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790337545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4SfW19FOgZeK+Pc8OhKa8QzdvXP3AYYYUwMp0IqgZY=;
	b=5eQe46sBOY2v3YmjqcMbeluR/LBfBftyv2UJ1Wd8HiNQiCk+dyAJs1M1ce+MigLv0mDxKe
	o/UCxGO8Z2kIEDBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tl7IGuNz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YPgU6ek9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790337541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4SfW19FOgZeK+Pc8OhKa8QzdvXP3AYYYUwMp0IqgZY=;
	b=Tl7IGuNzL8t9lrrISQ6S3B+pGPlPbq41OoGJqxNOPKr/f4NkcIJ1JboxoTSrVAMYGWl5lo
	tLtdwmjWyAg8WPA/QyiOJJZ4k43cQN7aryNPHr/ljkWMS2TzMsQPnOaOKEcpnKgW7dwMEt
	CS7UzELehpn3gt1snJmNT9hVHZvLjZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790337541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4SfW19FOgZeK+Pc8OhKa8QzdvXP3AYYYUwMp0IqgZY=;
	b=YPgU6ek9X1oQq/ylUKj5HBAQBvGOUMgydPk3EkNgSBE5N+QN6kddncv/hrdgKj6+xF7TT1
	wyfkPZhvUO83V0Ag==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260913024228.72317-6-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <20260913024228.72317-6-laoar.shao@gmail.com>
Date: Fri, 25 Sep 2026 13:59:00 +0200
Message-Id: <179033754033.68715.11352947492609559639.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25626; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=XHpneeWgtSZbyfAFhM9uJMQF6pLA+5ph6LR1vSZojvg=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqxtSaxxTW2zzPKZHjru4Ax29dzyUEzy6OLJ1hz7Lh5jP
 ir26kF7J6M/CwMjB4OlmCLL673OcoZTcg00q9/dhRnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmOqqNg6GxruHZjiInphsWNg4t/83x61i746j4b1eTknfNa79sa9nLk5Iejmfe8H
 SHp+nTqxFshvZ1WaGH5ReWMvT8ejRjafrjn8KehxS6bv2zaSbAgmqbHEdcy5ZdeXqSHiUPzgV0z
 Tjcv86yTLle6FHd5TPlTqlNflbNqcmc+ost6TLrbJ5D66F1ey5vi7kStf+PL6Kk1822ztsq2DcX
 ZdhdmZS7UaNDRu51Jv85rTzWKfOvmdkMKvwY+rnc/fCbLyzpl6buUcxsCFy4srLCj6T1WPtkp2t
 vh2tXad54b1Ourz4wW1bHHKFlmSyFzg2V5nyGVYWLFseqGiWYmvYssRlW2iVjmKU+telL2OzNl/
 V5gQA
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Level: ****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 8A73021AEC
X-Spamd-Result: default: False [16.55 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.66)[0.219];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Spamd-Bar: ++++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 16.55
X-Spam: Yes

> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the changes made by
>   the related livepatch. Where the changes are a set
>   of modified objects, functions, and used callbacks,
>   shadow variable ids, and state ids.
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different scopes.
> 
> A new livepatch atomically replaces any existing livepatch that
> meets any of the following conditions:
> 1. It has the same provides id as the new patch,
> 2. Its provides id is listed in the new patch's obsoletes list, or
> 3. The new patch's provides id is listed in its obsoletes list
>    (the obsoletes relationship is symmetric).
> 
> The obsoletes relationship is symmetric: two livepatches that
> obsolete each other are mutually exclusive. Loading either one
> atomically removes the other, so they can never be enabled at the
> same time. This allows swapping between two independently prepared
> livepatches that cover the same scope, in either direction.
> 
> klp-build gains -p/--provides and -r/--obsoletes options.  The two
> parameters are not validated in klp-build, since the compiler and the
> kernel handle invalid values.
> 
> Suggested-by: Song Liu <song@kernel.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  .../ABI/removed/sysfs-kernel-livepatch        |  7 ++
>  .../ABI/testing/sysfs-kernel-livepatch        | 25 ++++-
>  .../livepatch/cumulative-patches.rst          | 99 +++++++++++++------
>  Documentation/livepatch/livepatch.rst         | 25 +++--
>  include/linux/livepatch.h                     |  8 +-
>  kernel/livepatch/Kconfig                      | 14 +++
>  kernel/livepatch/core.c                       | 80 +++++++++++++--
>  kernel/livepatch/core.h                       |  1 +
>  kernel/livepatch/state.c                      | 58 +++++++++--
>  kernel/livepatch/transition.c                 | 15 +--
>  scripts/livepatch/init.c                      | 19 ++--
>  scripts/livepatch/klp-build                   | 23 +++--
>  12 files changed, 291 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
>
> diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
> new file mode 100644
> index 000000000000..87d57ba27326
> --- /dev/null
> +++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
> @@ -0,0 +1,7 @@
> +What:		/sys/kernel/livepatch/<patch>/replace
> +Date:		Jun 2024
> +KernelVersion:	6.11.0
> +Contact:	live-patching@vger.kernel.org
> +Description:
> +		An attribute which indicates whether the patch supports
> +		atomic-replace.
> diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
> index 3c3f36b32b57..7ccfe5414ac3 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -47,13 +47,28 @@ Contact:	live-patching@vger.kernel.org
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
> +		Livepatches with the same provides id replace each other.
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
> +		The obsoletes relationship is symmetric: an existing
> +		livepatch that obsoletes this patch's provides id will
> +		also be atomically replaced by this patch.
>  
>  What:		/sys/kernel/livepatch/<patch>/stack_order
>  Date:		Jan 2025
> diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
> index 1931f318976a..8898a2ee356c 100644
> --- a/Documentation/livepatch/cumulative-patches.rst
> +++ b/Documentation/livepatch/cumulative-patches.rst
> @@ -2,33 +2,72 @@
>  Atomic Replace & Cumulative Patches
>  ===================================
>  
> -There might be dependencies between livepatches. If multiple patches need
> -to do different changes to the same function(s) then we need to define
> -an order in which the patches will be installed. And function implementations
> -from any newer livepatch must be done on top of the older ones.
> +Livepatches are used to fix kernel bugs. New fixes need to be added over time.
> +The fixes might be independent, but they might also depend on each other. This
> +brings a challenge of how to keep the livepatched system safe and consistent.
>  
> -This might become a maintenance nightmare. Especially when more patches
> -modified the same function in different ways.
> +Part of the solution is the "Atomic Replace" feature, which allows the kernel to
> +atomically replace an existing livepatch with another one. These newer
> +livepatches are designed as "Cumulative Patches". They include all wanted
> +changes from all older livepatches and completely replace them in one
> +transition.
>  
> -An elegant solution comes with the feature called "Atomic Replace". It allows
> -creation of so called "Cumulative Patches". They include all wanted changes
> -from all older livepatches and completely replace them in one transition.
> +The second part of the solution are ``provides`` and ``obsoletes`` fields in
> +``struct klp_patch``, which allow the installation of multiple livepatches in
> +parallel. A livepatch will atomically replace any already installed livepatch
> +whose ``provides`` id matches either the new patch's ``provides`` id or any id
> +in the new patch's ``obsoletes`` list. This might be used to fix independent
> +problems separately, for example, the livepatches might be prepared by separate
> +teams focusing on particular functionality or a subsystem.
>  
> -Usage
> ------
> +It should be emphasized that the preferred and most secure way is to always use
> +the default ``provides = 0``. As long as all livepatches use the same default
> +id, any livepatch replaces any other livepatch, preventing any unexpected
> +interactions between incompatible livepatches.
>  
> -The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
> -for example::
> +Provides and Obsoletes
> +-----------------------
>  
> -	static struct klp_patch patch = {
> -		.mod = THIS_MODULE,
> -		.objs = objs,
> -		.replace = true,
> -	};
> +The ``provides`` field in ``struct klp_patch`` is an unsigned integer that
> +identifies the livepatch. By default, it is 0.
>  
> -All processes are then migrated to use the code only from the new patch.
> -Once the transition is finished, all older patches are automatically
> -disabled.
> +The ``obsoletes`` field is an optional array of unsigned integers that
> +specifies additional ``provides`` ids to be replaced when this patch is
> +loaded.
> +
> +The ``obsoletes`` relationship is symmetric. If livepatch A lists the
> +``provides`` id of livepatch B in its ``obsoletes`` list, then B also
> +atomically replaces A when it is loaded, because A's ``obsoletes`` list
> +contains B's ``provides`` id. In other words, two livepatches that
> +obsolete each other are mutually exclusive: loading either one always
> +removes the other one, so they can never be active at the same time.
> +This allows swapping between independently prepared livepatches that
> +cover the same functionality, in either direction.
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
> @@ -64,7 +103,11 @@ Features
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
> index acb90164929e..dfdacd347773 100644
> --- a/Documentation/livepatch/livepatch.rst
> +++ b/Documentation/livepatch/livepatch.rst
> @@ -347,15 +347,22 @@ to '0'.
>  5.3. Replacing
>  --------------
>  
> -All enabled patches might get replaced by a cumulative patch that
> -has the .replace flag set.
> +There can be only one active livepatch for a given ``provides`` id.
> +A new livepatch atomically replaces any existing livepatch whose
> +``provides`` id matches either the new patch's ``provides`` id or
> +any id in the new patch's ``obsoletes`` list.
>  
> -Once the new patch is enabled and the 'transition' finishes then
> -all the functions (struct klp_func) associated with the replaced
> -patches are removed from the corresponding struct klp_ops. Also
> -the ftrace handler is unregistered and the struct klp_ops is
> -freed when the related function is not modified by the new patch
> -and func_stack list becomes empty.
> +The replacement is symmetric: if an existing livepatch's ``obsoletes``
> +list contains the new patch's ``provides`` id, the new patch will also
> +atomically replace that existing livepatch. Consequently, two
> +livepatches that obsolete each other can never be enabled at the same
> +time, and either of them can be loaded to take over from the other.
> +
> +Once the transition is complete, all functions (``struct klp_func``)
> +associated with the matching replaced patches are removed from the
> +corresponding ``struct klp_ops``. If a function is no longer modified by
> +the new patch and its ``func_stack`` list becomes empty, the ftrace
> +handler is unregistered and the ``struct klp_ops`` is freed.
>  
>  See Documentation/livepatch/cumulative-patches.rst for more details.
>  
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 5f74f79c22b4..1e3a09e29a65 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -127,7 +127,9 @@ struct klp_state {
>   * @mod:	reference to the live patch module
>   * @objs:	object entries for kernel objects to be patched
>   * @states:	system states that can get modified
> - * @replace:	replace all actively used patches
> + * @provides:	only one active livepatch per id
> + * @obsoletes:	replace given livepatch id(s)
> + * @nr_obsoletes: number of entries in the @obsoletes array
>   * @list:	list node for global list of actively used patches
>   * @kobj:	kobject for sysfs resources
>   * @obj_list:	dynamic list of the object entries
> @@ -141,7 +143,9 @@ struct klp_patch {
>  	struct module *mod;
>  	struct klp_object *objs;
>  	struct klp_state *states;
> -	bool replace;
> +	unsigned int provides;
> +	unsigned int *obsoletes;
> +	unsigned int nr_obsoletes;
>  
>  	/* internal */
>  	struct list_head list;
> diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
> index 4c0a9c18d0b2..d92603658f7e 100644
> --- a/kernel/livepatch/Kconfig
> +++ b/kernel/livepatch/Kconfig
> @@ -30,3 +30,17 @@ config KLP_BUILD
>  	select OBJTOOL
>  	help
>  	  Enable klp-build support
> +
> +config KLP_HAS_PROVIDES
> +	def_bool y
> +	help
> +	  Compile-time marker for the livepatch provides/obsoletes support.
> +	  It is always set when the kernel is built with the scoped atomic
> +	  replace model, i.e. struct klp_patch provides the "provides" and
> +	  "obsoletes" fields instead of the legacy "replace" flag.
> +
> +	  The option itself does not enable or add any functionality; it
> +	  only serves as a compile-time marker so that out-of-tree modules
> +	  and tools (e.g. the livepatch kselftests) can detect kernels that
> +	  speak the provides/obsoletes interface and adapt to it with
> +	  #ifdef CONFIG_KLP_HAS_PROVIDES.
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index c0879b5d9dc0..a4616a6d9932 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -350,7 +350,8 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
>   * /sys/kernel/livepatch/<patch>/enabled
>   * /sys/kernel/livepatch/<patch>/transition
>   * /sys/kernel/livepatch/<patch>/force
> - * /sys/kernel/livepatch/<patch>/replace
> + * /sys/kernel/livepatch/<patch>/provides
> + * /sys/kernel/livepatch/<patch>/obsoletes
>   * /sys/kernel/livepatch/<patch>/stack_order
>   * /sys/kernel/livepatch/<patch>/<object>
>   * /sys/kernel/livepatch/<patch>/<object>/patched
> @@ -448,13 +449,32 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static ssize_t replace_show(struct kobject *kobj,
> +static ssize_t provides_show(struct kobject *kobj,
>  			    struct kobj_attribute *attr, char *buf)
>  {
>  	struct klp_patch *patch;
>  
>  	patch = container_of(kobj, struct klp_patch, kobj);
> -	return sysfs_emit(buf, "%d\n", patch->replace);
> +	return sysfs_emit(buf, "%u\n", patch->provides);
> +}
> +
> +static ssize_t obsoletes_show(struct kobject *kobj,
> +			      struct kobj_attribute *attr, char *buf)
> +{
> +	struct klp_patch *patch;
> +	unsigned int i;
> +	int len = 0;
> +
> +	patch = container_of(kobj, struct klp_patch, kobj);
> +	if (!patch->obsoletes || !patch->nr_obsoletes)
> +		return sysfs_emit(buf, "\n");
> +
> +	for (i = 0; i < patch->nr_obsoletes; i++)
> +		len += sysfs_emit_at(buf, len, "%s%u", i == 0 ? "" : ",",
> +				     patch->obsoletes[i]);
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +	return len;
>  }
>  
>  static ssize_t stack_order_show(struct kobject *kobj,
> @@ -481,13 +501,15 @@ static ssize_t stack_order_show(struct kobject *kobj,
>  static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
>  static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
>  static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
> -static struct kobj_attribute replace_kobj_attr = __ATTR_RO(replace);
> +static struct kobj_attribute provides_kobj_attr = __ATTR_RO(provides);
> +static struct kobj_attribute obsoletes_kobj_attr = __ATTR_RO(obsoletes);
>  static struct kobj_attribute stack_order_kobj_attr = __ATTR_RO(stack_order);
>  static struct attribute *klp_patch_attrs[] = {
>  	&enabled_kobj_attr.attr,
>  	&transition_kobj_attr.attr,
>  	&force_kobj_attr.attr,
> -	&replace_kobj_attr.attr,
> +	&provides_kobj_attr.attr,
> +	&obsoletes_kobj_attr.attr,
>  	&stack_order_kobj_attr.attr,
>  	NULL
>  };
> @@ -520,6 +542,39 @@ static void klp_init_func_early(struct klp_object *obj,
>  static void klp_init_object_early(struct klp_patch *patch,
>  				  struct klp_object *obj);
>  
> +/*
> + * Check if @new_patch will replace @old_patch:
> + * 1. Same provides ID
> + * 2. Old provides ID is in new patch's obsoletes list
> + * 3. New provides ID is in old patch's obsoletes list (symmetric replace)
> + */
> +bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch *old_patch)
> +{
> +	unsigned int i;
> +
> +	if (old_patch->provides == new_patch->provides)
> +		return true;
> +
> +	if (new_patch->obsoletes) {
> +		for (i = 0; i < new_patch->nr_obsoletes; i++) {
> +			if (new_patch->obsoletes[i] == old_patch->provides)
> +				return true;
> +		}
> +	}
> +
> +	/*
> +	 * The relationship is symmetric: an old patch that obsoletes the
> +	 * new one is also replaced by it.
> +	 */
> +	if (old_patch->obsoletes) {
> +		for (i = 0; i < old_patch->nr_obsoletes; i++) {
> +			if (old_patch->obsoletes[i] == new_patch->provides)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static struct klp_object *klp_alloc_object_dynamic(const char *name,
>  						   struct klp_patch *patch)
>  {
> @@ -618,6 +673,9 @@ static int klp_add_nops(struct klp_patch *patch)
>  	struct klp_object *old_obj;
>  
>  	klp_for_each_patch(old_patch) {
> +		if (!klp_patch_replaces(patch, old_patch))
> +			continue;
> +
>  		klp_for_each_object(old_patch, old_obj) {
>  			int err;

The comment before klp_add_nops() function would deserve an update as
well.

>  
> @@ -799,6 +857,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
>  	klp_for_each_patch_safe(old_patch, tmp_patch) {
>  		if (old_patch == new_patch)
>  			return;
> +		if (!klp_patch_replaces(new_patch, old_patch))
> +			continue;
>  		klp_free_patch_async(old_patch);
>  	}
>  }
> @@ -995,11 +1055,9 @@ static int klp_init_patch(struct klp_patch *patch)
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
>  
>  	klp_for_each_object(patch, obj) {
>  		ret = klp_init_object(patch, obj);
> @@ -1214,6 +1272,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
>  	klp_for_each_patch(old_patch) {
>  		if (old_patch == new_patch)
>  			return;
> +		if (!klp_patch_replaces(new_patch, old_patch))
> +			continue;

And perhaps here as well.

>  
>  		old_patch->enabled = false;
>  		klp_unpatch_objects(old_patch);
> diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
> index 361a0917a03f..b03cfc58b660 100644
> --- a/kernel/livepatch/core.h
> +++ b/kernel/livepatch/core.h
> @@ -18,6 +18,7 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch);
>  void klp_unpatch_replaced_patches(struct klp_patch *new_patch);
>  void klp_discard_nops(struct klp_patch *new_patch);
>  struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *func);
> +bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch *old_patch);
>  
>  static inline bool klp_is_object_loaded(struct klp_object *obj)
>  {
> diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
> index 2565d039ade0..3b262df48c35 100644
> --- a/kernel/livepatch/state.c
> +++ b/kernel/livepatch/state.c
> @@ -85,24 +85,63 @@ EXPORT_SYMBOL_GPL(klp_get_prev_state);
>  
>  /* Check if the patch is able to deal with the existing system state. */
>  static bool klp_is_state_compatible(struct klp_patch *patch,
> +				    struct klp_patch *old_patch,
>  				    struct klp_state *old_state)
>  {
>  	struct klp_state *state;
>  
>  	state = klp_get_state(patch, old_state->id);
> +	if (klp_patch_replaces(patch, old_patch)) {
> +		/*
> +		 * If the new livepatch will replace the old one, it must
> +		 * handle all already modified states (cumulative patch).
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
> +	 * Two livepatches with a different "provides" must _not_ use
> +	 * the same "state->id".
> +	 */
> +	return !state;
>  }
>  
>  /*
> - * Check that the new livepatch will not break the existing system states.
> - * Cumulative patches must handle all already modified states.
> - * Non-cumulative patches can touch already modified states.
> + * Refuse loading a livepatch which would want to modify a function
> + * which is already livepatched by a patch that will not be replaced.
> + * A patch is replaced if it has the same provides id or if its
> + * provides id is in the new patch's obsoletes list or if the new patch's
> + * provides id is in the old patch's obsoletes list.
>   */
> +static bool klp_has_function_conflict(struct klp_patch *patch,
> +				      struct klp_patch *old_patch)
> +{
> +	struct klp_object *obj, *old_obj;
> +	struct klp_func *func;
> +
> +	if (klp_patch_replaces(patch, old_patch))
> +		return false;
> +
> +	klp_for_each_object(patch, obj) {
> +		klp_for_each_object(old_patch, old_obj) {
> +			if (!!obj->name != !!old_obj->name)
> +				continue;
> +			if (obj->name && strcmp(obj->name, old_obj->name))
> +				continue;
> +
> +			klp_for_each_func(obj, func) {
> +				if (klp_find_func(old_obj, func))
> +					return true;
> +			}
> +		}
> +	}
> +	return false;
> +}
> +
> +/* Check that the new livepatch will not break the existing system states. */
>  bool klp_is_patch_compatible(struct klp_patch *patch)
>  {
>  	struct klp_patch *old_patch;
> @@ -110,9 +149,12 @@ bool klp_is_patch_compatible(struct klp_patch *patch)
>  
>  	klp_for_each_patch(old_patch) {
>  		klp_for_each_state(old_patch, old_state) {
> -			if (!klp_is_state_compatible(patch, old_state))
> +			if (!klp_is_state_compatible(patch, old_patch, old_state))
>  				return false;
>  		}
> +
> +		if (klp_has_function_conflict(patch, old_patch))
> +			return false;
>  	}
>  
>  	return true;
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9..ef70ff582da1 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -89,7 +89,7 @@ static void klp_complete_transition(void)
>  		 klp_transition_patch->mod->name,
>  		 klp_target_state == KLP_TRANSITION_PATCHED ? "patching" : "unpatching");
>  
> -	if (klp_transition_patch->replace && klp_target_state == KLP_TRANSITION_PATCHED) {
> +	if (klp_target_state == KLP_TRANSITION_PATCHED) {
>  		klp_unpatch_replaced_patches(klp_transition_patch);
>  		klp_discard_nops(klp_transition_patch);
>  	}
> @@ -496,10 +496,10 @@ void klp_try_complete_transition(void)
>  	 * klp_complete_transition() but it is called also
>  	 * from klp_cancel_transition().
>  	 */
> -	if (!patch->enabled)
> -		klp_free_patch_async(patch);
> -	else if (patch->replace)
> +	if (patch->enabled)
>  		klp_free_replaced_patches_async(patch);
> +	else
> +		klp_free_patch_async(patch);
>  }

A total nit but just s/else if/else/ would also be fine here, no?

>  
>  /*
> @@ -720,11 +720,12 @@ void klp_force_transition(void)
>  		klp_update_patch_state(idle_task(cpu));
>  
>  	/* Set forced flag for patches being removed. */
> -	if (klp_target_state == KLP_TRANSITION_UNPATCHED)
> +	if (klp_target_state == KLP_TRANSITION_UNPATCHED) {
>  		klp_transition_patch->forced = true;
> -	else if (klp_transition_patch->replace) {
> +	} else {
>  		klp_for_each_patch(patch) {
> -			if (patch != klp_transition_patch)
> +			if (patch != klp_transition_patch &&
> +			    klp_patch_replaces(klp_transition_patch, patch))
>  				patch->forced = true;
>  		}
>  	}

This is probably fine but I still have an awkward feeling about it.

The rest of the patch looks ok to me.

-- 
Miroslav

