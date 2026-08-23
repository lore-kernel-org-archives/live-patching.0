Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1320D4E9;
	Sun, 23 Aug 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787466195; cv=none; b=IJO47PbyQ8u8OK0RNzbb5OXhcOMP8Ig21266VrDzVj5AYDUoyTImKX7MFp78EJ82cd7/gqKI2xcm3rqy/kycGsbojyjDgN0c45icrYgHt/1MkxX8KpnkH2N2frPrVHC5u/wDAg57Br8DExRlzFX2H+94AG8925mdmaInYPHcErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787466195; c=relaxed/simple;
	bh=lNQni7ngKdv68Vz4g9gbtPwUqA7a0l7ajRGDbk9Ld8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W/ksCRRgcpIFdhopH4Rsb0fABPu1pX+qR6PULlRfCx+SmVDDUrDkWk9nkErLiCqpRVJyxQrp/Ytu5TORD/s3AyJejVpA2PKSlfCd2ILJyi8Cz6ocjJLqvS7qccOlutVYPDASHfxUnBGjzdZKZ9TsVIrULmIbel0CH/aihBp94VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdEmztKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdEmztKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1321B1F000E9;
	Sun, 23 Aug 2026 06:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787466193;
	bh=FRhn4i+MGiAFI+TZrNHodWRwBZr3HwweYXbfc5LTvf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdEmztKg9ECRMUvNt9cAheYHtkyfLGPAuXDzJO105ywcvUIOs9ITTPY3vp2fpwpU7
	 se0bzkqx497yRBdbgWeJajLcHEx0GmKCxockxsS8gQhAZ7k9n0lwtUdb0MUfp3i6AH
	 OREKsDubWVwE9pgyMc4u4QhQJidVxD7Ec0773AB6yoK3PwhYFwDGTRd0hIaS6Zz2Rs
	 IJIAd9dDTlF5HzulutA5U8rg1f31yhcUQIlabnb/etGJr0uyeUKABGeDx50v5AbBqn
	 9HHjXex6LUYFUAgpU1wg71y4f+eRXI71iloZ82j3DsYwC0784hRUbhPDScHKQiwAE9
	 ilt03OCDXFIZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harry Hsu" <x90613@gmail.com>, pmladek@suse.com
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com
In-Reply-To: <20260823060734.58443-1-x90613@gmail.com>
References: <20260823060734.58443-1-x90613@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 06:23:12 +0000
Message-Id: <20260823062313.1321B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Initialization failures in klp_init_object_loaded() leave livepatc=
h module relocations uncleared, leading to state corruption and permanently=
 preventing target module loading.
--

--- Patch [1]: [PATCH v2] livepatch: Reject livepatches with aliased old_fu=
nc ---
commit 230a471112d181b2e9810c9877ffebb05a42d61c
Author: Harry Hsu <x90613@gmail.com>

livepatch: Reject livepatches with aliased old_func

This patch adds a check during livepatch initialization to reject
configurations where multiple functions resolve to the same alias address.
It prevents ambiguity when the redirection logic evaluates the func_stack
in the ftrace handler.

Link: https://lore.kernel.org/all/20260812140232.48079-1-x90613@gmail.com/

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26d..c35cf08c27c86 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -866,7 +866,7 @@ static void klp_clear_object_relocs(struct klp_patch =
*patch,
>  static int klp_init_object_loaded(struct klp_patch *patch,
>  				  struct klp_object *obj)
>  {
> -	struct klp_func *func;
> +	struct klp_func *func, *prev_func;
>  	int ret;
> =20
>  	if (klp_is_module(obj)) {
[ ... ]
> @@ -888,6 +888,21 @@ static int klp_init_object_loaded(struct klp_patch *=
patch,
>  		if (ret)
>  			return ret;
> =20
> +		/*
> +		 * Aliased symbols share one address, so they would resolve to
> +		 * the same klp_ops and stack up on a single ops->func_stack,
> +		 * leaving the redirection ambiguous.  Reject the livepatch.
> +		 */
> +		klp_for_each_func(obj, prev_func) {
> +			if (prev_func =3D=3D func)
> +				break;
> +			if (prev_func->old_func =3D=3D func->old_func) {
> +				pr_err("'%s' and '%s' resolve to the same address, aliased symbols a=
re not supported\n",
> +				       prev_func->old_name, func->old_name);
> +				return -EINVAL;

[Severity: High]
This is a pre-existing issue, but returning an error here leaves the
module relocations applied earlier in this function uncleared.

When a module is loaded, klp_module_coming() iterates over patches and
calls klp_init_object_loaded(). If initialization fails, it delegates
cleanup to the error path:

kernel/livepatch/core.c:klp_module_coming() {
	...
	ret =3D klp_init_object_loaded(patch, obj);
	if (ret) {
		...
		goto err;
	}
	...
err:
	...
	klp_cleanup_module_patches_limited(mod, patch);
	...
}

However, the cleanup loop skips the failing patch entirely:

kernel/livepatch/core.c:klp_cleanup_module_patches_limited() {
	...
	klp_for_each_patch(patch) {
		if (patch =3D=3D limit)
			break;
		...
		klp_clear_object_relocs(patch, obj);
	}
}

Because it breaks when reaching the limit patch, klp_clear_object_relocs()
is never called for the relocations that were successfully applied at the
start of klp_init_object_loaded() via klp_apply_object_relocs().

Could this permanently corrupt the livepatch module's state and prevent
the target module from safely loading again, since the relocations are
never reverted?

> +			}
> +		}
> +
>  		ret =3D kallsyms_lookup_size_offset((unsigned long)func->old_func,
>  						  &func->old_size, NULL);
>  		if (!ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823060734.5844=
3-1-x90613@gmail.com?part=3D1
