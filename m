Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDA3128D9
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826992; cv=none; b=Vw3arh3kNQyuIBXEEVVHiCtbSp3p4qR62g8iXjpqK5W3Gc6r6r+rxB4vT73IABVXLvVOva3/iVd0J5JAu/Mq17JYut8rZC6y/kK6E9E+NnTLHUMLJ7mv7TNFoL7V5yaC5LX+hY+OHonFEeCeAFQHGgCCHGWLJPjQQJ0YmFMehfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826992; c=relaxed/simple;
	bh=wsnYR3o1DMlaDr37FuyVuFvmBFN/dxDoctET0f5pLbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfAwa9Tb9wRJpaeQQEKCUGFPHasjT+FRddcrRTSBeIsoX8lV1gIxugaa+Ij+au20YGeTSV+FKH+zOhmkh0LfiuhHBLaGL7xtR9Q4DTy0W/YUfb2VJDxzHLXvzr+BYU49fMatUNJpknXFBekKFj9Y0AEzY52Ryqy7YvP2D2mF9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9POXwHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9POXwHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBB21F000E9;
	Tue,  4 Aug 2026 07:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826990;
	bh=NVvpiXDJUG0/ONA+0obUOSCVGW54i8r8Ihs7t027U7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9POXwHfLCay8+0e5lBDWMgLjRRor9At3vDvi24BKaCaGX/j7FBdRhuKlAS8UVynv
	 APP2hGh0pzDHcdO5qg61BTp/9WA0xs6TXLYTGnxNmcP3mRMjLwrRyFUeRlPvX6ymKc
	 thMGgdz9lDmPbiDPCZ3H+aO85QW3FKfNRh676GUQstkoTmNVEMb5bQgKYz4AAFERRA
	 3OovoTrDl9K6kOeS/9QPjUIkhxhaChfq2UYWw6OCDm6fU/txZ7rRVfwwhcF/ZfEST0
	 FbgdRf1ci2rKnCOE7HXxu1RL5QKyq9VnZmcHxvoSixK3m54DAFukjkoq3cZYnd039d
	 ku8e+ALeXQMNQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/4] livepatch: Implement replace set for scoped
 atomic replace
Reply-To: sashiko-reviews@lists.linux.dev
To: pmladek@suse.com, jpoimboe@kernel.org, joe.lawrence@redhat.com, jikos@kernel.org, mbenes@suse.cz, song@kernel.org
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260804065010.44922-4-laoar.shao@gmail.com>
References: <20260804065010.44922-1-laoar.shao@gmail.com>
 <20260804065010.44922-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:03:09 +0000
Message-Id: <20260804070310.4EBB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dynamically allocated `funcs` arrays are leaked on KLP_OBSOLETES=
 parsing failure.
--

--- Patch [3]: [RFC PATCH v4 3/4] livepatch: Implement replace set for scop=
ed atomic replace ---
commit d186609c1a3dbe210857d0040f657fa918504faf
Author: Yafang Shao <laoar.shao@gmail.com>
Subject: livepatch: Implement replace set for scoped atomic replace

This commit introduces a more flexible atomic replace model for livepatches
using provides and obsoletes fields. A new patch will replace any existing
patch with a matching provides ID or any ID listed in its obsoletes array.
The klp-build script and init code are updated to parse and validate these
new fields.

> diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
> --- a/scripts/livepatch/init.c
> +++ b/scripts/livepatch/init.c
[ ... ]
> @@ -72,10 +73,73 @@ static int __init livepatch_mod_init(void)
[ ... ]
> +#ifdef KLP_OBSOLETES
> +	/*
> +	 * Parse KLP_OBSOLETES string (format: "0,1,2" or "0" or empty)
> +	 * and convert to unsigned int array for patch->obsoletes
> +	 *
> +	 * Note: KLP_OBSOLETES is always defined and includes at least the
> +	 * provides ID, ensuring the patch replaces old patches with same ID.
> +	 */
> +	{
> +		unsigned int *obs_array;
> +		unsigned int count =3D 1;
> +		char *obsoletes_str;
> +		char *token, *str;
> +		int i =3D 0;
> +
> +		for (str =3D (char *)KLP_OBSOLETES; *str; str++) {
> +			if (*str =3D=3D ',')
> +				count++;
> +		}
> +
> +		obsoletes_str =3D kstrdup(KLP_OBSOLETES, GFP_KERNEL);
> +		if (!obsoletes_str) {
> +			ret =3D -ENOMEM;
> +			goto err_free_objs;
> +		}
> +
> +		obs_array =3D kmalloc_array(count, sizeof(unsigned int), GFP_KERNEL);
> +		if (!obs_array) {
> +			kfree(obsoletes_str);
> +			ret =3D -ENOMEM;
> +			goto err_free_objs;
> +		}
> +
> +		str =3D obsoletes_str;
> +		while ((token =3D strsep(&str, ",")) !=3D NULL) {
> +			unsigned int val;
> +
> +			ret =3D kstrtouint(token, 10, &val);
> +			if (ret) {
> +				kfree(obsoletes_str);
> +				kfree(obs_array);
> +				goto err_free_objs;
> +			}
> +			obs_array[i++] =3D val;
> +		}

[Severity: Medium]
Does this code leak the funcs arrays on error?

Earlier in livepatch_mod_init(), the funcs arrays are dynamically allocated=
=20
for each object in a loop:

	funcs =3D kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
	...
	obj->funcs =3D funcs;

If KLP_OBSOLETES parsing fails during string duplication, array allocation,=
=20
or integer conversion, the error paths jump to err_free_objs. It appears=20
that the cleanup label only frees the objs array itself but leaves the=20
individual obj->funcs arrays allocated:

err_free_objs:
	kfree(objs);
err_free_patch:
	kfree(patch);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804065010.4492=
2-1-laoar.shao@gmail.com?part=3D3
