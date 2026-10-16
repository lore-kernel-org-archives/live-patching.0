Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74ADC2C8
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129624; cv=none; b=t2nQrhrKivOd/n4uVtA0nRPoYWwDrW4oRDab29lK4dpQN8Dg+gtP+P8x+5Lh1nG9uwe2uohAYA2YJWKy6rSzhXDvN4+GysoO8emlQ9g+qxgpC+0MT6OFoFE0BFOrwHfcznDOHsxJC29R46XaPjWni3P8gUeB7MIOFYsAFYfPMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129624; c=relaxed/simple;
	bh=FzpKPafzluUd4sfdWaYUAuQNEMQ4AppAIy/eMki/+1s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=toCKtIeNOSrbWmorqCSRBOyN1MW/3RLUc1U9cC+RHHSsWP0rPFOkzeUzlFYbaFEpigvaoVmtNNt7YgFMs8o5xwrLrUsrqgcBE+XEc0LuKqF7AzZsYguZZqU84avvtFvlc005cPa9ARlf2YoO9f+ekK7IMwDsP7rSJo5V1jCzjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhF61sma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhF61sma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE24D1F000C4;
	Fri, 16 Oct 2026 05:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792129623;
	bh=MBr7mxLevJT8q8mX+2iqMgzEFPqBPiXsIoPHaCuwH5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mhF61smaApfwIQywp45a0dAj8duIGUaRE+eNbaudjgdSVf/CmgrbN+1/NTwQRqf5G
	 cqm8rkgT1QS7IHY8hANoiLX1nKs4TRD+4caG1VDkyNAN3oS1EqzJQxgExIs9C7V1X7
	 nCdoqLrInI5iN7M03tpk2FUQZIWmh3JnfHT3O0KjejGO3feDTG4YO/E8GiZyl4htBp
	 SEWPCaJechshV9G93mpS5ysf7G3ThJt/eXdu4msQ6xFSoQFR928RU4ltZDT2qvC/Zs
	 3lHrHg2P5NcvZFWXDWESz4+Sz8BMmwsLF5ZG7r7ugbehcjH5iP9S9MYlkqbKgxsjjA
	 RahV1NrkVrp2Q==
Message-ID: <sashiko-outbox-173836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/9] livepatch: Call klp_init_patch_early() earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20261016053708.47089-5-laoar.shao@gmail.com>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 05:47:02 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] livepatch: UAF on module unload if klp_is_patch_compatible() fai=
ls with DEBUG_KOBJECT_RELEASE
--

commit bd925cd8bf4694e6331eda23e1ebe254ec598efe
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Call klp_init_patch_early() earlier

Invoke klp_init_patch_early() during early initialization to avoid mixing
for_each_() and for_each_*_static() variants later in the code. This prepar=
es
the code for an upcoming patch.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index c34306ecfb0bb..f088955de8557 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1145,13 +1145,6 @@ int klp_enable_patch(struct klp_patch *patch)
> =20
>  	mutex_lock(&klp_mutex);
> =20
> -	if (!klp_is_patch_compatible(patch)) {
> -		pr_err("Livepatch patch (%s) is not compatible with the already instal=
led livepatches.\n",
> -			patch->mod->name);
> -		mutex_unlock(&klp_mutex);
> -		return -EINVAL;
> -	}
> -
>  	if (!try_module_get(patch->mod)) {
>  		mutex_unlock(&klp_mutex);
>  		return -ENODEV;
> @@ -1159,6 +1152,13 @@ int klp_enable_patch(struct klp_patch *patch)
> =20
>  	klp_init_patch_early(patch);
> =20
> +	if (!klp_is_patch_compatible(patch)) {
> +		pr_err("Livepatch patch (%s) is not compatible with the already instal=
led livepatches.\n",
> +			patch->mod->name);
> +		ret =3D -EINVAL;
> +		goto err;

[Severity: Medium]
Can this sequence lead to a use-after-free regression during module unload =
if
CONFIG_DEBUG_KOBJECT_RELEASE is enabled?

If klp_is_patch_compatible() fails, we jump to err. This triggers kobject
teardown for objects that were initialized but never linked to a parent:

err:
    klp_free_patch_start(patch);
    ...
    klp_free_patch_finish(patch);

Because the child kobjects lack a parent linkage at this early stage, waiti=
ng
on patch->finish completes without waiting for the child kobjects to be ful=
ly
released.

If CONFIG_DEBUG_KOBJECT_RELEASE is enabled, the release is delayed. The
function returns and the livepatch module is unloaded, freeing its static
memory. Later, the delayed release work executes:

kernel/livepatch/core.c:klp_kobj_release_object()
    obj =3D container_of(kobj, struct klp_object, kobj);
    if (obj->dynamic)

Accessing obj->dynamic here would cause a use-after-free on the freed module
memory.

Should we ensure all child kobjects are fully released before returning, or
handle the initialization state differently?

> +	}
> +
>  	ret =3D klp_init_patch(patch);
>  	if (ret)
>  		goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016053708.4708=
9-1-laoar.shao@gmail.com?part=3D4
