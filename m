Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2ED1A6838
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267936; cv=none; b=FYF7e0LdCxEJVqRNiWstTJPgJTynMYl9TfpHV13OP/zMznXn8YVuxUsojJJMkYGrOyV6Dhve6R1HxjBRFTZ+o9Zt4ttdz7Od4mgXQcVCNLCkLr9ryTRWJr/zUNZ6pgP3ZVMgTOfaewkd+g8+vntMhlXrDqZ35x4aBFyJ+VQZqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267936; c=relaxed/simple;
	bh=rCiPFImQsxSQdQLqegMxfEVH+kkqFmgPR1wgnaCF3DQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpdYHw+bV7EhDh19yh4qUDkLXidz2kUwO8khvh9tY+IQLXK0fPSEqYTnmHhVorU/dIY8C922nGvz2fQzlV0NBsLxdrHz8jGcm7lZ01IdKr+Pz8nq/Rqob4byZl+IIKWGOLbITyCDUCcBngJbLfR1bKErti51Hy1hXy0QHGoTUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgkCujZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgkCujZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169491F000E9;
	Sun,  9 Aug 2026 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786267934;
	bh=Xok7zpzI7Zb+5iiGlxwIjlvxyihwgAmKQAKVHYx0Rbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UgkCujZlmkSKDFVrg5JH5RRe4RIRig0g4MQ6yxwL5gAuMZgM9hjqSG2/0cavjMjcb
	 jghUoVNxihklio3YsrmykeimLkqn05tOvqu4WnD0AojfoznQGvLs64Arde33esVA1S
	 lLB2n2OZxyzjySyEd4wzk4XAMxebfDLJjDYxvT59IkEkpwVR/nhnJRkcLUvZm0JCKw
	 xvjTxoC/5uH7bKZ7tSeyJL4idaGDqQa9O5OI2p1wPYd/sPHZfEmaq3mv9amPZJ6wLW
	 234Ipfgt3Q2EgBD6WP2pBLDc8FfBC78zblCjbmxC8Tl9zlc/IcmdxlNTgF1jza8TT9
	 dn6WM/mrppSQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] livepatch: Make klp_find_func() non static
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, mbenes@suse.cz, song@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, jikos@kernel.org
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260809091954.22930-3-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:32:13 +0000
Message-Id: <20260809093214.169491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malformed livepatch module with a missing `old_name` triggers a =
NULL pointer dereference in `klp_find_func()`.
--

--- Patch [2]: [PATCH v5 2/9] livepatch: Make klp_find_func() non static ---
commit c50e76ff358d6d9f27c1c156d6d6f492f2cdd3b1
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Make klp_find_func() non static

This commit makes klp_find_func() non-static to allow its use in other
source files by an upcoming patch. It also renames the parameter @old_func
to @func.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26d..5d05d6fcbf57c 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c

[ ... ]

> @@ -82,21 +82,21 @@ static bool klp_initialized(void)
>  	return !!klp_root_kobj;
>  }
> =20
> -static struct klp_func *klp_find_func(struct klp_object *obj,
> -				      struct klp_func *old_func)
> +/* Check if @func is present in @obj. */
> +struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *=
func)
>  {
> -	struct klp_func *func;
> +	struct klp_func *obj_func;
> =20
> -	klp_for_each_func(obj, func) {
> +	klp_for_each_func(obj, obj_func) {
>  		/*
>  		 * Besides identical old_sympos, also consider old_sympos
>  		 * of 0 and 1 are identical.
>  		 */
> -		if ((strcmp(old_func->old_name, func->old_name) =3D=3D 0) &&
> -		    ((old_func->old_sympos =3D=3D func->old_sympos) ||
> -		     (old_func->old_sympos =3D=3D 0 && func->old_sympos =3D=3D 1) ||
> -		     (old_func->old_sympos =3D=3D 1 && func->old_sympos =3D=3D 0))) {
> -			return func;
> +		if ((strcmp(obj_func->old_name, func->old_name) =3D=3D 0) &&

[Severity: High]
This is a pre-existing issue, but could this strcmp() trigger a null pointer
dereference if a malformed livepatch module has a missing old_name field?

When loading a livepatch module where patch->replace is true, if a
struct klp_func element has .new_func defined but .old_name set to null,
klp_init_patch_early() adds this unvalidated function to obj->func_list.

Subsequently, klp_add_object_nops() calls klp_find_func() on the unvalidated
new patch object before klp_init_object() performs the expected null check:

kernel/livepatch/core.c:klp_add_object_nops() {
    ...
		func =3D klp_find_func(obj, old_func);
    ...
}

This unconditionally passes the unvalidated, null obj_func->old_name to
strcmp().

Does this allow a malformed module to bypass validation and crash the
system instead of being gracefully rejected?

> +		    ((obj_func->old_sympos =3D=3D func->old_sympos) ||
> +		     (obj_func->old_sympos =3D=3D 0 && func->old_sympos =3D=3D 1) ||
> +		     (obj_func->old_sympos =3D=3D 1 && func->old_sympos =3D=3D 0))) {
> +			return obj_func;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D2
