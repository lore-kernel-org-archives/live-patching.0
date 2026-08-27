Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4B313E1B
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875033; cv=none; b=FHZRUYLi5OTacqdcYAKiDXTCnZ7SYQXypLx9aZlaYHT34Bkw7UQ6mOSyCDvJSUdI07+4xtRQ/ipsGXOxUuIadhcIW/AF6LqX5s/k0NVQXwORo4HokSxG54qhEMWdyxGBG15GOivMjfe1f91/cJ9V9geULtFMQVXlhgAhl5T6c5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875033; c=relaxed/simple;
	bh=rh7q72aqXZVpa4CyRoJTAxBf2lynmUfc/Sfp4783vxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is/Jel9m62xuJirfEW797+ZeOSuTf+BfZY8tNhZNw2aQtk36DNzCUlM4PHFZQ5olc9ngI8jEzQ171BRy1m325ymc25U8GUv7ORvVsxkP8f71+Jrz+txfH116obZGIlQ0Kg2t44yaKORV0Da+INh8bgj2pA+vfCXqGoNMhitp4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2s1Z4yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2s1Z4yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FA51F000E9;
	Thu, 27 Aug 2026 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787875031;
	bh=lKQLgzNu/cn1CB7RqfZ804rmj8zXBM2C4J+JOPASx0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2s1Z4yj4z2TBseQJHj7GessJ9AO2/Pc80CEdkmrGnM0fdik6XeBcLVgNLxAZWlpF
	 ztgGoPM5CrDXYrYUpFiGy6PmTwN/j6/OEZa8zfbZTC4ueVptMTf3k74iccKsKFw3B2
	 bo8pzAMEFT5dxMb28jktsBKmjHY7tqPZCK+zbjgGFr/36km+XGFck6B3+H5S40+wwQ
	 GiMw5f/UZevsFiXWJid192lcJnIPVxXDTHaIi1aWujMQT/9PP037JyXraxVeFXKLPC
	 uc4xDmrv42ys3jookDL0noxhf2KIdaVLV/+lKrXz5Msr1z0NG73FZ0rVRXJhwkMQe2
	 smyXAoyPyahJQ==
Date: Thu, 27 Aug 2026 16:57:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early()
 earlier
Message-ID: <apDOvYOV0DtouAVF@jpoimboe>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-3-laoar.shao@gmail.com>

On Tue, Aug 25, 2026 at 07:46:35PM +0800, Yafang Shao wrote:
> Invoke klp_init_patch_early() during early initialization to avoid
> mixing for_each_() and for_each_*_static() variants later in the code.
> 
> No functional change. This prepares the code for an upcoming patch.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  kernel/livepatch/core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index c34306ecfb0b..3de3940d34b2 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1145,13 +1145,6 @@ int klp_enable_patch(struct klp_patch *patch)
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_compatible(patch)) {
> -		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
> -			patch->mod->name);
> -		mutex_unlock(&klp_mutex);
> -		return -EINVAL;
> -	}
> -
>  	if (!try_module_get(patch->mod)) {
>  		mutex_unlock(&klp_mutex);
>  		return -ENODEV;
> @@ -1159,6 +1152,14 @@ int klp_enable_patch(struct klp_patch *patch)
>  
>  	klp_init_patch_early(patch);
>  
> +	if (!klp_is_patch_compatible(patch)) {
> +		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
> +			patch->mod->name);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +
>  	ret = klp_init_patch(patch);
>  	if (ret)
>  		goto err;

Stray newline.

-- 
Josh
