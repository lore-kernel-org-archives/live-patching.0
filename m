Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA50200110
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876778; cv=none; b=FoAmsp9UpvgQx2qleacvWgCrTK2uUc9SpWMl235d00UvkICmP/7Av5cPYHwT/IRMLm/n8RuMsGkf1ZxFXT7jGyKWg4Q1rmjXj3Q+VlOou3MgLzVf4/vryFVohlFyiCZd5zaAhTf8Z9lQm35HNj1wJKzYT8H/0wZD/TuqckSwGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876778; c=relaxed/simple;
	bh=t7ZE+330rCJDsf4GG/fluWyjcpBKJqBIdmUEQ+R0548=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS/O5twFajIw49jOk8XQiEieNWMvtwIbBj0gaC0Z+VunworqhqMTcMc9foSIhqI+HKrAtGJldugdyIpZwdDK6+NiI2FsW+LFKni3TBws4++FBurp8FmUqWI2qiF3qGKkAx5dn65XZIHQY/ck1KdwlH0LVVZlmdukBkewvW8fODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPyrDLZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPyrDLZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAE41F000E9;
	Fri, 28 Aug 2026 00:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787876776;
	bh=9egFvnDpBZQ3LdW2R1jvRXRAsRVgllbY6XwOW1w0cRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPyrDLZw1lCJzoRysxwsnBZ61NsF1MJ1JX37PpTiMO54gJ/b52GlJuGfvyZrRFpgT
	 KNRHvAmaWmoYs27k41itj0MJJ+J4rr8dajSnwp8pjRoebmKCUEoSXRgJw/RKI+DOD1
	 +mkKv4dsP5d2z4DdIIt5pTxKzZaX15LD+TUGs6hfCUCU0vMK4KJu+Cr3hggcdymLCY
	 vjVrM3+hg6iqp3oWh8Cm5y6c0nmQAx8hVRb2XwneLyyER1GyQjYUZUhjJrvmRBCdqD
	 6sRg+2G9uLDp5e76elZfs5ZIFiodcFetUUhzXVOWeE+bJJkiA9u/wWoS89X4dCdhbQ
	 JakKOmlDrSPMA==
Date: Thu, 27 Aug 2026 17:26:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 3/8] livepatch: Implement replace set for
 scoped atomic replace
Message-ID: <apDO-a2n9UlrO_FA@jpoimboe>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-4-laoar.shao@gmail.com>

On Tue, Aug 25, 2026 at 07:46:36PM +0800, Yafang Shao wrote:
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
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different replace sets.
> 
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

Should be klp_patch_replaces()?

> - klp_has_function_conflict(): rejects loading a livepatch that would
>   modify a function already patched by a livepatch with a different
>   provides id.

I'm not sure the commit log really needs to list some functions it adds,
that's already evident in the patch.

> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index ba9e3988c07c..854ed6230b96 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -123,7 +123,8 @@ struct klp_state {
>   * @mod:	reference to the live patch module
>   * @objs:	object entries for kernel objects to be patched
>   * @states:	system states that can get modified
> - * @replace:	replace all actively used patches
> + * @provides:	only one active livepatch per id
> + * @obsoletes:	replace given livepatch id(s)
>   * @list:	list node for global list of actively used patches
>   * @kobj:	kobject for sysfs resources
>   * @obj_list:	dynamic list of the object entries
> @@ -137,7 +138,9 @@ struct klp_patch {
>  	struct module *mod;
>  	struct klp_object *objs;
>  	struct klp_state *states;
> -	bool replace;
> +	unsigned int provides;
> +	unsigned int *obsoletes;
> +	unsigned int nr_obsoletes;

nr_obsoletes is missing from the kernel-doc above.

> @@ -72,15 +71,76 @@ static int __init livepatch_mod_init(void)
>  
>  	/* TODO patch->states */
>  
> -#ifdef KLP_NO_REPLACE
> -	patch->replace = false;
> +#ifdef KLP_PROVIDES
> +	patch->provides = KLP_PROVIDES;
>  #else
> -	patch->replace = true;
> +	patch->provides = 0;
> +#endif

'patch' is already zeroed, so the #else isn't needed.

> +#ifdef KLP_OBSOLETES
> +	/*
> +	 * Parse KLP_OBSOLETES string (format: "1,2,3") and convert to
> +	 * unsigned int array for patch->obsoletes.
> +	 *
> +	 * Note: The provides ID is not included here; the kernel will
> +	 * replace livepatch with the same provides ID.
> +	 */
> +	{
> +		unsigned int *obs_array;
> +		unsigned int count = 1;
> +		char *obsoletes_str;
> +		char *token, *str;
> +		int i = 0;
> +
> +		for (str = (char *)KLP_OBSOLETES; *str; str++) {
> +			if (*str == ',')
> +				count++;
> +		}
> +
> +		obsoletes_str = kstrdup(KLP_OBSOLETES, GFP_KERNEL);
> +		if (!obsoletes_str) {
> +			ret = -ENOMEM;
> +			goto err_free_objs;
> +		}
> +
> +		obs_array = kmalloc_array(count, sizeof(unsigned int), GFP_KERNEL);
> +		if (!obs_array) {
> +			kfree(obsoletes_str);
> +			ret = -ENOMEM;
> +			goto err_free_objs;
> +		}
> +
> +		str = obsoletes_str;
> +		while ((token = strsep(&str, ",")) != NULL) {
> +			unsigned int val;
> +
> +			ret = kstrtouint(token, 10, &val);
> +			if (ret) {
> +				kfree(obsoletes_str);
> +				kfree(obs_array);
> +				goto err_free_objs;
> +			}
> +			obs_array[i++] = val;
> +		}
> +
> +		patch->obsoletes = obs_array;
> +		patch->nr_obsoletes = i;
> +
> +		if (i > 0)
> +			pr_info("obsoletes patch ids: %s\n", KLP_OBSOLETES);
> +
> +		kfree(obsoletes_str);
> +	}

Can we do something simpler like this?

#ifdef KLP_OBSOLETES
static unsigned int klp_obsoletes[] = { KLP_OBSOLETES };
#endif

And in livepatch_mod_init():
	
#ifdef KLP_PROVIDES
	patch->provides = KLP_PROVIDES;
#endif
#ifdef KLP_OBSOLETES
	patch->obsoletes = klp_obsoletes;
	patch->nr_obsoletes = ARRAY_SIZE(klp_obsoletes);
#endif


> +++ b/scripts/livepatch/klp-build
> @@ -21,7 +21,8 @@ shopt -s lastpipe
>  
>  unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
>  
> -REPLACE=1
> +PROVIDES=0
> +OBSOLETES=""
>  SHORT_CIRCUIT=0
>  JOBS="$(getconf _NPROCESSORS_ONLN)"
>  shopt -o xtrace | grep -q 'on' && XTRACE=1
> @@ -132,7 +133,8 @@ Options:
>     -f, --show-first-changed	Show address of first changed instruction
>     -j, --jobs=<jobs>		Build jobs to run simultaneously [default: $JOBS]
>     -o, --output=<file.ko>	Output file [default: livepatch-<patch-name>.ko]
> -       --no-replace		Disable livepatch atomic replace
> +   -p, --provides=<id>		Set the provides id for this livepatch
> +   -r, --obsoletes=<ids>	Set the obsoletes ids array (e.g., "0,1,2")
>     -v, --verbose		Pass V=1 to kernel/module builds
>  
>  Advanced Options:
> @@ -147,7 +149,6 @@ Advanced Options:
>  
>  EOF
>  }
> -
>  usage() {

Unnecessary whitespace change

> @@ -235,6 +254,37 @@ process_args() {
>  		exit 1
>  	fi
>  
> +	# Remove duplicates from obsoletes (if specified)
> +	# Note: provides ID is not added here; the kernel will replace
> +	# livepatch with the same provides ID.
> +	if [[ -n "$OBSOLETES" ]]; then
> +		local obsoletes_clean="${OBSOLETES//[ ]/}"
> +		local IFS=','
> +		local -a obs_array=()
> +		local obs_id
> +		local already_exists
> +
> +		for obs_id in $obsoletes_clean; do
> +			if [[ -n "$obs_id" ]]; then
> +				already_exists=0
> +				for existing in "${obs_array[@]}"; do
> +					if [[ "$existing" -eq "$obs_id" ]]; then
> +						already_exists=1
> +						break
> +					fi
> +				done
> +
> +				if [[ "$already_exists" -eq 0 ]]; then
> +					obs_array+=("$obs_id")
> +				fi
> +			fi
> +		done
> +
> +		local IFS=','
> +		OBSOLETES="${obs_array[*]}"
> +		unset IFS
> +	fi
> +

What's the point of this?  Do we expect duplicates, and if so, wouldn't
it be the kernel's job to handle that?

-- 
Josh
