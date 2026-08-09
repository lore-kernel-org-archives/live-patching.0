Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187032D8376
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267732; cv=none; b=t54wiTfW89jr3KoLkzNb6uLUSvXc4aE5sWiI/b9cbgI9mDseSuZuP9LKglUt+R55wa6ZZsfQ1Jz6Xzk4gybgZU2puqzD16BHP5hzPqlXi9MdK4OyFJwHQKLjcxlCjJCyZL5HKNWK+Fpg+hn1VP2jCv82XFeH8E+lVldY7Tf73B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267732; c=relaxed/simple;
	bh=s6ObsVyk8x4L+I/R1hzkLHJzEeX9W0bdLxQeoxK8vBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T4jIDZMrXl8PVc0XebNyFsb6fG4J4VW2MDEDgQoRTileoPx6dYZlryxI4/NxX/tSeunShLLxEl29ZK8ctBG4Ah1SFBf4e4DrR5aceIxoPMknXqH8IXJgy6ldxMWZYjZahLpLBsfAqit0A1aEcakvcWJFHdW/q+7FG3Q0A7FR2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE1BrUtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE1BrUtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E6B1F000E9;
	Sun,  9 Aug 2026 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786267730;
	bh=5Qsx4J0CHzxeAKnouGagEP0JBCbuM7Snr3jRLMdCY/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EE1BrUtTNsCPi/YIiJu9yoSaqvNbDCVBfQJSIBgEqDJxCCaGkKk3rl298VVZOLP/l
	 HddZhszMb36dsmqWpDdW3F7zHTaKkaf6l4hKzm9EG5O3LON5PfCIqSZVYXzA6QMvtZ
	 IENnghIVtxu4kdCfwzj7+3v3zxo4O07RKPxVYG/3alJg+LZywT8TQxhx2keCFOzOZP
	 5F47GuWF6lerNs4vXWvpI9/MYuX2oMKDS4wBCee6ibWtVMGQ+lWXE2zV1OSwo6WGlZ
	 gAho0vzcvgqu6pvHi/Cwnve6LnkjNb5ePPA4tC7eN7wbie9K3dZXra2Opu8a/G/DTz
	 1YhKAwuWY49RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] livepatch: Fix wrong index in funcs cleanup
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: mbenes@suse.cz, jikos@kernel.org, song@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, jpoimboe@kernel.org
Cc: "Yafang Shao" <laoar.shao@gmail.com>, live-patching@vger.kernel.org
In-Reply-To: <20260809091954.22930-2-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:28:49 +0000
Message-Id: <20260809092850.28E6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a double free vulnerability on the `funcs` al=
location error path.
--

--- Patch [1]: [PATCH v5 1/9] livepatch: Fix wrong index in funcs cleanup e=
rror path ---
commit c03811c85b7c79e0d681d9978c346e4424c48a99
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Fix wrong index in funcs cleanup error path

This commit modifies the cleanup loop in livepatch_mod_init() to use the
index j instead of i when kzalloc() fails for a function array. This
attempts to prevent leaking previously allocated function arrays.

> diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> index f14d8c8fb35fa..16aff8f736eb6 100644
> --- a/scripts/livepatch/init.c
> +++ b/scripts/livepatch/init.c
> @@ -51,7 +51,7 @@ static int __init livepatch_mod_init(void)
>  		if (!funcs) {
>  			ret =3D -ENOMEM;
>  			for (int j =3D 0; j < i; j++)
> -				kfree(objs[i].funcs);
> +				kfree(objs[j].funcs);

[Severity: High]
Does this introduce a double free in livepatch_mod_init()?

When the inner loop here frees objs[j].funcs, it leaves the dangling pointer
in the objs array. The code then jumps to err_free_objs, which iterates over
all objects and frees the arrays again:

err_free_objs:
	for (int i =3D 0; i < nr_objs; i++)
		kfree(objs[i].funcs);

Since the pointers weren't set to NULL in the inner loop, won't the
err_free_objs cleanup loop free the identical memory allocations a
second time?

>  			goto err_free_objs;
>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D1
