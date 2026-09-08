Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24253A88C;
	Tue,  8 Sep 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869896; cv=none; b=bdhlTQK5b5gpcHMD2y8YiBwkrTFUG1DkSDf8KrRDCwbE8T/J1t68gyj5ht696IFrq6q+4s4m5q6Fh+2wkti2SokmR5zkQqVX5qZarDpgFnM2ameuDBD5gvVMNGCuk5wDXqcer2EYgsOnbyUtRIJj0Cytq7W/mkDKzEwqu48zoH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869896; c=relaxed/simple;
	bh=TIRcg9IQT3/cIx5oKWUzo6r87yIoibtLWFHboGqSczs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8akBjN7EM/PTdZx2k3znAw5ti+xK5IiMKjmm0l3Z2GnTLao2E1DGHjyYPzPpYDFfLLk9jKSoVqXhT8k62cnxWNyj0hHMiUD2xrkcRj+eoNE57dw5127OpGj3Y1NctBxkglQ5uyCIeN+59F/RLbhcQBmTuiuD4eK7bDFFpOW1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHuH6apw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHuH6apw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9577A1F00A3A;
	Tue,  8 Sep 2026 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788869891;
	bh=+KFsR2PjohcrJpHQ9FZuDGDq2ithXoh9dhtMY1cu5vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHuH6apwDchlIJvBE/ZGWQeVmeUrl0nwSF0oIbd0GUWkL8kAR+NXrokO3EPoLuZow
	 CbRUvl7SrMHFDQkO/CFvvmuKbUIhn84Fl7XR18FeAnAXYBSU96b0LDQK2ghQuE9QUQ
	 VXtCvHzLoSIfJ1MrSf4CULqqXlhg+wvvEWchJj6OJjH07Dw0lptZGXfPD5Zbfjn6h1
	 6S4naBF7g5b3zkF7AJ/sPQb+VDRLmq5NTZrluTG9DsdPl8AcO7bgD2PHTeM1MIXOyE
	 RueuoAYPG30PD8UAzLGuNDnmhftmhEG+41rGwHH6BAdpbZFcc5tw5+Ne+tzk6ZDKxY
	 JOu2utDBVCcWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] livepatch: Clear relocations when
 klp_apply_object_relocs() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: joe.lawrence@redhat.com, "Harry Hsu" <x90613@gmail.com>, jpoimboe@kernel.org, "Petr
 Mladek" <pmladek@suse.com>, mbenes@suse.cz
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, jikos@kernel.org, song@kernel.org
In-Reply-To: <20260908120325.299649-5-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-5-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:18:10 +0000
Message-Id: <20260908121810.9577A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Off-by-one error in the rollback loop leaves the failing section=
's partially applied relocations uncleared.
--

commit d297505bb4b1d833ec93725770d65ac1044abcad
Author: Petr Mladek <pmladek@suse.com>

livepatch: Clear relocations when klp_apply_object_relocs() fails

This commit introduces klp_write_object_relocs_limited() to unwind and
clear only the relocations that were successfully applied before
klp_write_object_relocs() encountered an error. This prevents partially
applied patches from leaving un-reverted changes that cause subsequent
patch operations to fail validation.

Link: https://lore.kernel.org/r/20260830175608.4BABB1F000E9@smtp.kernel.org

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index a6796cd6b65fd..714f97fdd271a 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -342,14 +342,17 @@ int klp_apply_section_relocs(struct module *pmod, E=
lf_Shdr *sechdrs,
[ ... ]
> +static int klp_write_object_relocs_limited(struct klp_patch *patch,
> +					   struct klp_object *obj,
> +					   bool apply, int limit)
>  {
>  	int i, ret;
>  	struct klp_modinfo *info =3D patch->mod->klp_info;
> =20
> -	for (i =3D 1; i < info->hdr.e_shnum; i++) {
> +	if (!limit || limit > info->hdr.e_shnum)
> +		limit =3D info->hdr.e_shnum;
> +
> +	for (i =3D 1; i < limit; i++) {
>  		Elf_Shdr *sec =3D info->sechdrs + i;
[ ... ]
> -		if (ret)
> +		if (ret) {
> +			if (apply)
> +				klp_write_object_relocs_limited(patch, obj, false, i);

[Severity: Medium]
When an error occurs in klp_write_section_relocs(), the rollback is trigger=
ed
with the failing section index passed as the limit. Since the rollback loop
iterates with a strict less-than bounds check against this limit, will this
skip the rollback for any relocations that were successfully applied within
the failing section itself before it encountered the error?

It looks like this could leave partially applied relocations permanently
in memory within the failing section, causing future module loads to fail
validation.

>  			return ret;
> +		}
>  	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908120325.2996=
49-1-pmladek@suse.com?part=3D4
