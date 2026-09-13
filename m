Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54E1DD0EF
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268107; cv=none; b=MpjivO7LPRJ+DEAN1b/tSi2BZxXGp6kFft5XqLAMFg4lpikGO8kX6VSLckFm9snMQ0aPan3dOsWsFmWrS1A8ysHWnKQtpe8n7Ozw/LfPeGEY1AQ5kqCrnF/8i11+RNeBSbMPkbvw07Pdta+luN4ezPx5NTGe3vraF1M7SUKv3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268107; c=relaxed/simple;
	bh=/G27/qmqrtVe/eJBL2fjwbY2BBrlax8i7OYaZndibL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qhyQbnoG3ddVqQB14Yz+d7rPbYh7Z0PuALYJ1X9wBilXUFLfG1QE328QrRfY/gWX9upz2kKsRXOXz963vJwcA+k2I/8nmJ+Heez+Hr7p5im6dSWfHrMPwnsPbiCi+Z/X1GCuRfm6xnf/82pvoQApykzrT5eu3o2cPw4fLbf69/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOZXqRvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOZXqRvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F501F000FF;
	Sun, 13 Sep 2026 02:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789268106;
	bh=bNQPckbmpcDaiICRRx+e9935DYKqSWLKiyf00xB02FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOZXqRvCEetNkvsAPdhSsBzl4JWXouII5ae99Q/kkgLsc9foB22gqqRyuWJmPgbaE
	 ELLR4VgZEt6y7f7Xs6xAwv3yBUtfsswwnK1w/6+P9mhHl0CyiCL+lEGl11hzXL07E/
	 Tzwa7UTITWA6Xw10Sb6MVpE1iL+2Ic2lI6FpoeYcDB5QsA9S4ijCHW9SAuy9kMsdoR
	 98CDyUOgpSdsUUQVbFK6rdB8QvDPi3Ir4Qocc1vWwzFItba//wxuRrFuE3hkpjB5jb
	 hgaiN1Xb0GPyQWPXMqUxGU7fmaoxRpPUVX71FLRE0WUr3FujUCtb1v5TQwdSOsVi8g
	 QtXgSI5d9ZZ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/9] livepatch: Call klp_init_patch_early() earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: song@kernel.org, "Yafang Shao" <laoar.shao@gmail.com>, jikos@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260913024228.72317-5-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
 <20260913024228.72317-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:55:05 +0000
Message-Id: <20260913025505.D1F501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free on statically allocated kobjects when CONFIG_DEBUG_=
KOBJECT_RELEASE is enabled
--

commit 482a331678a5995d891ae6ebde80245198dd0aba
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Call klp_init_patch_early() earlier

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index c34306ecfb0bb..f088955de8557 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c

[ ... ]

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

[Severity: High]
This is a pre-existing issue, but could jumping to the error path here
cause a use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE is enabled?

If klp_enable_patch() fails here due to patch incompatibility, the error
path calls klp_free_patch_start(), which eventually invokes kobject_put()
on the statically allocated obj and func structures:

kernel/livepatch/core.c:__klp_free_objects() {
    ...
    kobject_put(&obj->kobj);
    ...
}

When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() schedules
delayed release works for these kobjects, which are embedded within the
livepatch module's memory.

Since klp_enable_patch() only waits for the patch kobject's completion and
ignores the obj and func kobjects, module_init() returns an error. This
leads the kernel to unload the module and free its memory while the delayed
release works are still pending.

Is there a way to ensure the module memory isn't freed before these
delayed works complete?

> +	}
> +
>  	ret =3D klp_init_patch(patch);
>  	if (ret)
>  		goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913024228.7231=
7-1-laoar.shao@gmail.com?part=3D4
