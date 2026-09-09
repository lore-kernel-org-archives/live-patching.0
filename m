Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF984321F2D
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922592; cv=none; b=Tymo/p0Eukxw4NggTwQiwJ3wfyz9gUykerMAYq1ELLcDvymPLks2E7F9m9BvV3xha5m8ssDkAjWMBfHurZNLxSvSnzGa2jk+kvQ0sEVhAUea0Itg3w7Ggd6PoKIyuqA2sTtHgJ0nGmUnm2IILlaFeBvsLCpJAO9gqpXtbk8bEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922592; c=relaxed/simple;
	bh=F2OrixGoZq/tMzEalK3+1WTdosCxIu383ILsDOCYPUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CO9i9IOiOv8J4lg8nNL7HAZwvleo8rmbVVx6CCHrvMCbQy5hRDZetT02v1E+5h9OHk4q0llR1HbUjhVB2ZhYz0jehSz1CIIUKUZ55RxbKI8w4l0lboQqSM1MxFkCF+sf6Qzoq/rGpWkpGF4Fob245U9aDLYpDIwzV/VpuIL4/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMyFoMld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMyFoMld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110F31F00A3A;
	Wed,  9 Sep 2026 02:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788922585;
	bh=xVky2Y2vSOU2GjFf4Yx5fiiMxFG23hUAYozvM8FZV00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMyFoMldH3M96+cusZZp4P1uPxLg5Q05r/BhmUaywEW7TKdf6fIeQ1/vBYyRq2M5o
	 aOxDf2W8VApIFgwSvrrj8g+h+xyzgM9CmsbtkFiXN146uR8ly9NoRmO6E0S2NcPQcw
	 guC/pZKcLyybIji3iLkp4U5sBUpZ/qqf71meh+GNatTO9GGzVcbKxYUOpJPoD82yNO
	 +kgcCPs3impYFr5WcBr7G7ip9TYRHcuxH59MCmYLj/uSubYM7HsYQVr4y2CHi6f+yO
	 Rt6hw5LsC3JbVyPqpUbOxX7wa+5fxPlh5EM0yoSaMJy3FLSOdtcyepFTAgxDrvUODG
	 GVwwPOUN9v0rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/9] livepatch: Call klp_init_patch_early() earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: jikos@kernel.org, joe.lawrence@redhat.com, song@kernel.org, mbenes@suse.cz, "Yafang
 Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, pmladek@suse.com
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260909024324.16002-5-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
 <20260909024324.16002-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:56:24 +0000
Message-Id: <20260909025625.110F31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Fatal UAF / Kernel Panic on module unload due to unparented kobjec=
ts triggering delayed work in freed memory.
--

commit 92da60558ebea290d37fbe304d56429622a3eb02
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Call klp_init_patch_early() earlier

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index c34306ecfb0bb..f088955de8557 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c

[ ... ]

> @@ -1152,10 +1145,17 @@ int klp_enable_patch(struct klp_patch *patch)
> =20
>  	klp_init_patch_early(patch);
> =20
> +	if (!klp_is_patch_compatible(patch)) {
> +		pr_err("Livepatch patch (%s) is not compatible with the already instal=
led livepatches.\n",
> +			patch->mod->name);
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but moving the compatibility check after
klp_init_patch_early() makes it highly reachable when an incompatible
patch is loaded. Could this lead to a use-after-free and kernel panic
during module unload?

When klp_init_patch_early() runs, it calls kobject_init() for child obj
and func objects. However, their parent pointers are not set until later
in klp_init_patch() via kobject_add().

If klp_is_patch_compatible() fails here, the error path calls
klp_free_patch_start() which puts these unparented child kobjects. Under
CONFIG_DEBUG_KOBJECT_RELEASE, their release functions are scheduled
asynchronously with a random delay.

Because the children lack parent pointers, they do not hold a reference to
patch->kobj. As a result, klp_free_patch_finish() will complete immediately
when waiting on patch->finish, and module_put(patch->mod) allows the module
to unload, freeing the statically allocated obj and func structures.

Later, when delayed release functions like klp_kobj_release_object() finally
execute, they will dereference obj->dynamic in freed memory.

>  	ret =3D klp_init_patch(patch);
>  	if (ret)
>  		goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909024324.1600=
2-1-laoar.shao@gmail.com?part=3D4
