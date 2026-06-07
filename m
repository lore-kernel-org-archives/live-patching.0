Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE01DA23
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780839195; cv=none; b=p/uEUTD04vyUHGyzJskvy634ne9JHr2XDOCGLiqw4pkijIfUiVYkaZ8Cx50hCVVAMzhpIW5ERXL8ybYe7RwbqyWTS4Ecj0YqtujchxCryUVWMUYrDc1xq6T96AIk5yoQ4dcDOTy/HjkjkYiR8CiuEBuAUjK3c2w6cHY4PAmU/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780839195; c=relaxed/simple;
	bh=Kb7+F3SMtaeubqtqjCjefEqoCU3dWicwwcAnVdvgid0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c6uT750AEFqnZZ1werJKKxgAN6F4jkZcxNwBfCrzDiT6sgS/MwKbaIuv/XnKHrH4HQKTIS9JlVAa6ohvrcybBNpu6aEKfDd/lfKnhYV8UoFJiJVBuN2OMQBUghzJYLY7Q5Dz0rxZUEEWDcx3itVGMH4tzPZTMYFd0Rf9sdpe004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1BPd8Zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1BPd8Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A21F00893;
	Sun,  7 Jun 2026 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780839194;
	bh=HfDofwrc96vQ3pNg0TLSEy/ocTkqxK5k9kilRtsbQgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1BPd8Zr4f+I3KBshiZ8ULVyqQEnGN/l06XJGB1oLElZWkLH1OKeDrS2Q1SdhQnku
	 NPauT3Jtr7MgsygsT7V8p0U/mzeT69UqclF+T+Qv1OCD3Qh7Am+JlGJZaxqhCwE4NQ
	 xZ9Hk5bxVDQVRCNojy+29g7Y/wBmotERVvxcBFi6JJwBX5ZUUyVo9fCizE2DNO7qep
	 dRABVTOGKEXPS8M6EzM5n3zXEKv+nPYJVymJlhecrKtV68BEnMAo2VvQ4/zp1nilt5
	 GHFt5ofhl/gaJ6EXUDK/t2FZmJSbL1YN592K2galkn6QDlbMS3NSRQFVAM4Q9kjZ8o
	 cLV+5BqBK8syg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Reply-To: sashiko-reviews@lists.linux.dev
To: joe.lawrence@redhat.com, mbenes@suse.cz, jikos@kernel.org, song@kernel.org, jpoimboe@kernel.org, pmladek@suse.com
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260607131659.29281-4-laoar.shao@gmail.com>
References: <20260607131659.29281-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 13:33:13 +0000
Message-Id: <20260607133313.EE8A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly introduced check in `klp_is_patch_compatible` causes a k=
ernel panic if a livepatch module contains a `klp_func` entry with `old_nam=
e =3D=3D NULL`.
--

commit ed678e88294b650a730cda1a47351fce99677c1e
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Support scoped atomic replace using replace_set

Convert the replace attribute from a boolean to a u32 to function as a
"replace set." A newly loaded livepatch will now atomically replace any
existing patch belonging to the same set.

Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]

[ ... ]
> --- a/kernel/livepatch/state.c
> +++ b/kernel/livepatch/state.c
[ ... ]
> +		/*
> +		 * Refuse loading a livepatch which would want to modify a
> +		 * function which is already livepatched with the livepatch
> +		 * with another "replace_set".
> +		 */
> +		klp_for_each_object_static(patch, obj) {
> +			klp_for_each_object(old_patch, old_obj) {
> +				if (!!obj->name !=3D !!old_obj->name)
> +					continue;
> +				if (obj->name && strcmp(obj->name, old_obj->name))
> +					continue;
> +				klp_for_each_func_static(obj, func) {
> +					if (klp_find_func(old_obj, func))
> +						return false;
> +				}
> +			}
> +		}
>  	}

[Severity: High]
Can passing an unvalidated function to klp_find_func() cause a NULL pointer
dereference here?

If a new livepatch module is loaded with an improperly initialized klp_func
array (e.g., accidentally missing old_name but providing new_func),
klp_for_each_func_static() will still process it because structural
validation in klp_init_patch() hasn't occurred yet at this point in the
loading process.

When this unvalidated func is passed as the second argument to
klp_find_func(old_obj, func), the roles inside klp_find_func() are reversed
from its usual context. The old_func parameter represents the new patch's
unvalidated function, while the local func iterator represents the
already-installed patch.

Inside klp_find_func(), the check evaluates:

    if ((func->old_name && strcmp(old_func->old_name, func->old_name) =3D=
=3D 0)

Since the installed patch's func->old_name is guaranteed to be non-NULL,
strcmp() will be called with old_func->old_name. If old_func->old_name is
NULL, does this turn what would normally be a graceful -EINVAL module
rejection into a system crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607131659.2928=
1-1-laoar.shao@gmail.com?part=3D3
