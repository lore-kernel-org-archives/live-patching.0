Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CD30E858
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129695; cv=none; b=Ahv6G9o87oIhW9HjWZSKLL7axV42S9+caXJqly4YVwNuy/xcmrpzXgMskuZsG3RnnYfJ0iWr/xP5B+XzMV0/ulLW9ALQCfI22kxK49BG54sPFu4jLMqcFBhN003KCae6MJSnrjG9K5vTTVIMRE73GNDgmbcyKsCbrHAhNhzjpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129695; c=relaxed/simple;
	bh=1DNxek0QOWUhvHNBsXwPUuL2ewYTwcVSU+/mdiE0ASs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=L+7vxmEibWLQjlov0GLVKE0ogqGv4Y2Pa4XM1TrqssEoIi68banvt5ynMics3RSQ6psSpe2V2DbEWqFHMCDQ6yq7H9ytk4sEQj7b7uM29H0BdqYAD10BdQu1VptWcT6oQ2r9ycoz7VIml1GcmCMfx1wOR6YhmS5JFRTf4cCoP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htTiAT32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htTiAT32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13DF1F000C4;
	Fri, 16 Oct 2026 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792129694;
	bh=6D1KkWMyY1VFYiA+M1dey36WzdhehZPiusRDrh8yCX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=htTiAT32iKtOErie9ZqGgmFz7U7gj/JBw929TMEcEDu8j7Htsq3EHovF8U4P+cjK2
	 M2Nar+XCxA2bLr3Xf+55EAl+cr2oK9NUfuaoXhh3DxWwnsGct4rY//C7pFxI6z/+Mh
	 AYaKJ1eaLmdYxIv3a83F2jqSb067S663WBv/URxvvz6R7TzkfrswkHsZAavb9tcnzc
	 cG6SqK2yIXCiSQd2sNycA93XRcKwtEsKwULt/vwBOEHEBbnc/xWTd+2HPnLcX/liej
	 pu8WqBc7fjSwfH7ER/llcyMQ8kcMa1xNGSyoogjk2etX0T2hzoImU+uXoZUxRFu5eU
	 ZsH2TaQiVy9vg==
Message-ID: <sashiko-outbox-173837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20261016053708.47089-6-laoar.shao@gmail.com>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 05:48:13 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] livepatch: memory leak of dynamically allocated patch structures=
 on klp_enable_patch failure
--

commit 160ccf1ed36fde593c80db0147adb4d9a0aa689f
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Implement provides and obsoletes for scoped atomic replace

This commit replaces the boolean replace flag in klp_patch with provides
and obsoletes fields. It introduces a new flexible model to allow multiple
independent livepatch sets to coexist safely on the same system.

> diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> index f14d8c8fb35fa..1eb124191cf22 100644
> --- a/scripts/livepatch/init.c
> +++ b/scripts/livepatch/init.c

[ ... ]

> @@ -72,15 +75,19 @@ static int __init livepatch_mod_init(void)
> =20
>  	/* TODO patch->states */
> =20
> -#ifdef KLP_NO_REPLACE
> -	patch->replace =3D false;
> -#else
> -	patch->replace =3D true;
> +#ifdef KLP_PROVIDES
> +	patch->provides =3D KLP_PROVIDES;
> +#endif
> +#ifdef KLP_OBSOLETES
> +	patch->obsoletes =3D klp_obsoletes;
> +	patch->nr_obsoletes =3D ARRAY_SIZE(klp_obsoletes);
>  #endif
> =20
>  	return klp_enable_patch(patch);

[Severity: Medium]
If klp_enable_patch() fails (e.g., due to patch incompatibility or early
-ENODEV) and returns an error code, does this direct return bypass the=20
err_free_objs cleanup path below?

The primary structures (patch, objs, and funcs) are allocated with kzalloc()
earlier in livepatch_mod_init(). Because the core livepatch error path insi=
de
klp_enable_patch() treats these structures as statically provided by the mo=
dule,
it will not kfree() them upon failure.=20

Does this code permanently leak the patch, objs, and funcs structures? Woul=
d it
be better to save the return status and goto err_free_objs on failure?

> =20
>  err_free_objs:
> +	for (int i =3D 0; i < nr_objs; i++)
> +		kfree(objs[i].funcs);
>  	kfree(objs);
>  err_free_patch:
>  	kfree(patch);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016053708.4708=
9-1-laoar.shao@gmail.com?part=3D5
