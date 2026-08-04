Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA442F71E
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827018; cv=none; b=hYLbxHz284trO0uMSOGru4rBk1NQApQVEKufz3IorsiL3gn/6KQMQ0o+5ngqVVcdM+aYjUGc/0ytxlHJnb6hDk4zlJStzH3UP5to5iqHFscWulHfmzUXL0DDefdlgHDZ7CVrcVm/I86K0rEol2T2YL6cAfuIbcvYPXmA7dHQ4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827018; c=relaxed/simple;
	bh=cltwIxaSJc849A7wkszctKYcqphToBfmUBGBrwkNPcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmC3jpwDU6rXBuSVf7tgzyB3FVEnP/yR4ph8QC8LEaalAlJVEUPDO7YaqnEeyd89YqkAj0rUudT1vTSTDUrFAHnT0m6nMKsJpJR11tDJKS7cFvrY+TEN1xQWUyBjZDZPrbX907hGVByXyUoRVpOoeWi6XlyHfZpzE5ggMI1XoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDoneOXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDoneOXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5878F1F000E9;
	Tue,  4 Aug 2026 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785827016;
	bh=eebrT5tD40vFxfnuITnQsIl1euawWgVNVthAn4BG3rE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDoneOXNPKcusQqGdthK1x5OWDGX4uAQX7Pja+hNhg/ZkImN4EmM3HSgdi7U/SLu/
	 LY16gB+rjjbialZRg7aOcDdq7+I7Vo6k4+xeSm9JVpkDURdeiLP+EagXW/ClZmoWfZ
	 fG55W4rhb3tW82e+rk4o7e5tOMhML+ILBA5wTr+DjDb7q0OtghqJ65VQYLQpdnOb1Z
	 zx0JIvyd37zKFgmVSF5mRx4khWhzeKVB3/+TCqheIZnH1TAFqbLJVxA72CgrM5kDqM
	 So4DLt/IDXyFtLwZhS6pnE8Ta6iE8P3fXNRdLIzHHzoLMZTVgULx6VIV39Sx9QLLaP
	 fnOLbp7jbZt0Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/4] livepatch: Call klp_init_patch_early()
 earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260804065010.44922-3-laoar.shao@gmail.com>
References: <20260804065010.44922-1-laoar.shao@gmail.com>
 <20260804065010.44922-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:03:35 +0000
Message-Id: <20260804070336.5878F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Moving klp_init_patch_early() before early failure checks violat=
es the kobject API lifecycle and introduces missing cleanup on error paths.
--

--- Patch [2]: [RFC PATCH v4 2/4] livepatch: Call klp_init_patch_early() ea=
rlier ---
commit 6b8df20b82104d4c61053ebea3721f1d77891456
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Call klp_init_patch_early() earlier

This commit moves the invocation of klp_init_patch_early() earlier in the
livepatch initialization process. This prepares the code for an upcoming
patch by avoiding mixing iteration variants later in the sequence.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index e07c41a0f3ac8..c98cbcf59566d 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1135,6 +1135,8 @@ int klp_enable_patch(struct klp_patch *patch)
> =20
>  	mutex_lock(&klp_mutex);
> =20
> +	klp_init_patch_early(patch);
> +
>  	if (!klp_is_patch_compatible(patch)) {
>  		pr_err("Livepatch patch (%s) is not compatible with the already instal=
led livepatches.\n",
>  			patch->mod->name);
> @@ -1147,8 +1149,6 @@ int klp_enable_patch(struct klp_patch *patch)
>  		return -ENODEV;
>  	}

[Severity: Medium]
Since klp_init_patch_early() initializes kobjects for the patch, does
returning directly on compatibility or try_module_get() failures leak
these resources?

The kobject API requires that once kobject_init() is called, kobject_put()
must be used to release the object. Because klp_init_patch_early() is now
called before these checks, if we hit the early return paths in
klp_enable_patch(), we bypass cleaning up the initialized kobjects.

Also, would simply changing these early returns to jump to the err label
cause issues with klp_free_patch_finish()?

kernel/livepatch/core.c:klp_enable_patch() {
    ...
err:
	klp_free_patch_start(patch);
	mutex_unlock(&klp_mutex);
	klp_free_patch_finish(patch);
	return ret;
}

It looks like klp_free_patch_finish() calls module_put(patch->mod)
unconditionally. If try_module_get() failed, jumping to the err label
might underflow the module reference count.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804065010.4492=
2-1-laoar.shao@gmail.com?part=3D2
