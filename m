Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7D35975
	for <live-patching@vger.kernel.org>; Thu, 13 Aug 2026 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590973; cv=none; b=f+oipmQQWXzeRD/8t00CzdKIDuzsQo7xWJYCeEi3CNEdDAcNLqgNbIOovGn6UHVWOLtozlQaZJs1wSBNVt2ToDfq3ZlpFZhInPWEREzGPst/Z8yUi+e4fvDfI2PZMDe3eoTiZLmnJXUT3SosCAiJ3l8GwovdTv1nsrhg2iO3hjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590973; c=relaxed/simple;
	bh=oMFqpdTBGsGOhIbb60MuwxaBDNLLXwFgDpzQ0+ju5wE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IoTNnufgQbctvcCM4GowgHwe9Zv5fqurWDkZhhEH7vTtfRtuu0Vk1S338WsRjT3VIHISlH8glko12d/F5L2dYWBre8ka13eq2MrlsdxXA391xNxh8ySLbo4Ozs+T6U5gOHZgevBD07HsCM+6zbFrZpGyDInGUzJHfY2//ZMNI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iyfuhzvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iyfuhzvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EAD1F000E9;
	Thu, 13 Aug 2026 03:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786590972;
	bh=tODOL0/KVaRaAQ8MkwgCZyyh4d/o2wUx17PMGaW2gqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IyfuhzvqDKvMXEtc+mI/PxnYFgwsrD/rj+Ptv2JrNJGkeHzrwuaAITEp8M0l9qb19
	 c4vMjf6aBnll3SPagfTMCxfPb3BX5rCcJGleLeZ1aqaCr4/xb8GPZlz4tRAKY+xZ21
	 DgNU1W0/FGC36blLh14yns7FO/ZBP92k4MAe2sPtQ9vRjcB4Z3W0633tUNcq8mQTK3
	 AxLHaduyEq+buFoUbpW/W1rK0T19BU/H1dB5NYkefvM5e4kfx8CE87xhLgNvREg9Fj
	 VNR3IBA49PtDTP6VBB465AumtgyODNmcZUpSmk/VWXxD0tdK8BzL34bL5oVuVLp1/q
	 pHJYs8VdfakDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] livepatch: Fix UAF of unregistered patch kobjects
Reply-To: sashiko-reviews@lists.linux.dev
To: joe.lawrence@redhat.com, jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org, pmladek@suse.com, song@kernel.org, "Yafang
 Shao" <laoar.shao@gmail.com>
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260813030408.9761-3-laoar.shao@gmail.com>
References: <20260813030408.9761-1-laoar.shao@gmail.com>
 <20260813030408.9761-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:16:11 +0000
Message-Id: <20260813031611.A4EAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The newly added release signaling logic introduces a direct Us=
e-After-Free when processing dynamically allocated objects and NOP function=
s in the kobject release paths.

Pre-existing issues:
- [High] The patch fails to fully resolve the original delayed kobject rele=
ase Use-After-Free if partial initialization fails after the patch kobject =
has been added, leaving child kobjects un-added.
--

--- Patch [2]: [PATCH 2/2] livepatch: Fix UAF of unregistered patch kobject=
s ---
commit ac38837d810b471eed544191021bf254f8b9e585
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Fix UAF of unregistered patch kobjects

When klp_enable_patch() fails after klp_init_patch_early() has run,
delayed kobject releases can cause use-after-free bugs when the module
is unloaded. This patch tracks pending kobject releases and waits for
them before completion.

Link: https://lore.kernel.org/all/20260809094046.50ED31F000E9@smtp.kernel.o=
rg/

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26d..e07b026feeb99 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c

[ ... ]

> @@ -652,6 +653,14 @@ static void klp_kobj_release_object(struct kobject *=
kobj)
> =20
>  	if (obj->dynamic)
>  		klp_free_object_dynamic(obj);
> +
> +	/*
> +	 * The object kobject was initialized but never added to sysfs.
> +	 * Signal the release to the owning patch.
> +	 */
> +	if (!obj->patch->kobj_added &&
> +	    atomic_dec_and_test(&obj->patch->kobj_pending))
> +		complete(&obj->patch->finish);
>  }

[Severity: Critical]
Does this dereference the freed obj pointer?

If obj->dynamic is true, klp_free_object_dynamic(obj) is called, which
frees the object structure. Immediately after this intentional free, the
newly added logic dereferences the freed pointer by evaluating
!obj->patch->kobj_added.

> @@ -668,6 +677,13 @@ static void klp_kobj_release_func(struct kobject *ko=
bj)
> =20
>  	if (func->nop)
>  		klp_free_func_nop(func);
> +	/*
> +	 * The function kobject was initialized but never added to sysfs.
> +	 * Signal the release to the owning patch.
> +	 */
> +	if (!func->obj->patch->kobj_added &&
> +	    atomic_dec_and_test(&func->obj->patch->kobj_pending))
> +		complete(&func->obj->patch->finish);
>  }

[Severity: Critical]
Similarly here, does this access func after it has been freed?

If func->nop is true, klp_free_func_nop(func) frees the function,
but the new check immediately dereferences func->obj->patch->kobj_added.

[ ... ]

> @@ -737,9 +753,29 @@ static void klp_free_objects_dynamic(struct klp_patc=
h *patch)
>   */
>  static void klp_free_patch_start(struct klp_patch *patch)
>  {
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +
>  	if (!list_empty(&patch->list))
>  		list_del(&patch->list);
> =20
> +	if (!patch->kobj_added) {

[Severity: High]
This is a pre-existing issue, but does this check leave child kobjects
unprotected if partial initialization fails after the patch kobject has
been added?

If klp_init_patch() successfully adds the patch kobject, it sets
patch->kobj_added =3D true. If a subsequent operation like klp_add_nops()
or klp_init_object() fails, klp_free_patch_start() is called on the
error path.

Because patch->kobj_added is true, this check is bypassed and
patch->kobj_pending tracking is not initialized. However, child kobjects
that were initialized early but not yet added to sysfs do not hold a
reference to patch->kobj. Thus, patch->kobj will be released
independently, unblocking patch->finish, and allowing the livepatch
module to be unloaded while un-added child kobjects may still trigger
their delayed releases and access freed module memory.

> +		/*
> +		 * The kobjects were only initialized and never added to
> +		 * sysfs. Count them so that klp_free_patch_finish() can
> +		 * wait for all their releases before the patch module is
> +		 * unloaded. Without this, a delayed kobject release
> +		 * (CONFIG_DEBUG_KOBJECT_RELEASE) could access the freed
> +		 * module memory.
> +		 */
> +		atomic_set(&patch->kobj_pending, 1); /* the patch kobject */
> +		klp_for_each_object(patch, obj) {
> +			atomic_inc(&patch->kobj_pending);
> +			klp_for_each_func(obj, func)
> +				atomic_inc(&patch->kobj_pending);
> +		}
> +	}
> +
>  	klp_free_objects(patch);
>  }

[ ... ]

> @@ -987,6 +1027,7 @@ static int klp_init_patch(struct klp_patch *patch)
>  	ret =3D kobject_add(&patch->kobj, klp_root_kobj, "%s", patch->mod->name=
);
>  	if (ret)
>  		return ret;
> +	patch->kobj_added =3D true;
> =20
>  	if (patch->replace) {
>  		ret =3D klp_add_nops(patch);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813030408.9761=
-1-laoar.shao@gmail.com?part=3D2
