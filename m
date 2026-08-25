Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E52400DE1
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659579; cv=none; b=W52L69G1dx2PVtzWuH3NM67EhAa8H0KDtw1vGTnaF7bdU3HcHRVUSGsw/cSBq9xsiALHN+tHAgevV70kMQxRJoaSrC6o02XmXKpzoYca+ku7AoIWznMK3NuAUistnMXcHHG5YAWU1BYST9SYisMTlxSw2jeaIx8TZrUyMqAeiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659579; c=relaxed/simple;
	bh=89htUvbTfg8M/14fsnfPLLIyxju4u5xnXteL18LiH08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nihp7vK7kkihXhw9UT02SVfb9LXERQfEHIkvXV9m0+qW/Tgc8IOQgVGb/9HyNmALsN36oUSJgAOOXhQ1TA7zlFjzpxYXSKlFaMsDyzFibUPvkx67hZhRlR+nQPAtb7LJTUexgcSdmgVXsRdUQ1UDLSTwdOU4rvQOJ04oEOlq/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIZesTyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIZesTyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB401F00A3A;
	Tue, 25 Aug 2026 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787659569;
	bh=//Ywcsm1XtrbnWUdEus2M6tiypi8Bf7AdHk0bFKNCQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIZesTyz/5MT0SZe81WiQ1sSWE8o47EMisW5UvKD6Ti8lQl9A3P5r/CWrBHHswzvT
	 UbKabsgiqijKPhrdAdyWhUwwrfXyumaX4vPjYI6cL29co+cAMN7NU6FFVRM0BX4+wX
	 zmH3+espv/yCtETIFZXrv5k5oybkLCjHidnjJldfYi/Iams2IqrLtAYA3/+ahue2EO
	 FwieMRjAUUBvy7bJLRDzty/kx1w8KS9l0Qi7iIFuUK4XaM4UOMlv7kZ5/Gxm+MrxPG
	 T+D/ms5sbrcn7SQ+Us/FOvdpY11r2FZ/U1QbdixBwHBnGzSaE1irHHxeCkHOA4hXlR
	 gcRHawGYrN4cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early()
 earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: pmladek@suse.com, jpoimboe@kernel.org, song@kernel.org, jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com, "Yafang
 Shao" <laoar.shao@gmail.com>
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260825114641.80452-3-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:06:08 +0000
Message-Id: <20260825120608.BAB401F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential use-after-free of kobject delayed work structs during er=
ror cleanup if CONFIG_DEBUG_KOBJECT_RELEASE is enabled.
--

--- Patch [2]: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early=
() earlier ---
commit b5f9135d749ffc4d6ea6c6a68a0fc6489e7a1cbf
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Call klp_init_patch_early() earlier
   =20
Invoke klp_init_patch_early() during early initialization to avoid mixing
for_each_() and for_each_*_static() variants later in the code.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
[ ... ]
> @@ -1152,6 +1152,14 @@ int klp_enable_patch(struct klp_patch *patch)
> =20
>  	klp_init_patch_early(patch);
> =20
> +	if (!klp_is_patch_compatible(patch)) {
> +		pr_err("Livepatch patch (%s) is not compatible with the already instal=
led livepatches.\n",
> +			patch->mod->name);
> +		ret =3D -EINVAL;
> +		goto err;
> +	}

[Severity: High]
This is a pre-existing issue, but does this error path expose a use-after-f=
ree
of kobject delayed work structs when CONFIG_DEBUG_KOBJECT_RELEASE is enable=
d?

Because kobject_add() has not yet run (it runs later in klp_init_patch()), =
the
child kobjects (obj and func) do not have their parent pointers set to
patch->kobj during this cleanup path.

When the error path jumps to err and calls klp_free_patch_start(), it drops
references to the child kobjects. Since their parent pointers aren't set,
putting the child kobjects does not elevate or pin the parent patch->kobj.=
=20

Consequently, the wait_for_completion() in klp_free_patch_finish() only wai=
ts
for the patch kobject to finish releasing, but not the child kobjects:

kernel/livepatch/core.c:klp_free_patch_finish() {
	...
	kobject_put(&patch->kobj);
	wait_for_completion(&patch->finish);

	/* Put the module after the last access to struct klp_patch. */
	if (!patch->forced)
		module_put(patch->mod);
}

This allows the module memory to be completely freed while the delayed work
for the child obj and func kobjects (which reside in the now-freed module
memory) might still be queued. When the workqueue executes them, it results=
 in
a use-after-free.

While this issue already existed for klp_init_patch() failures, moving
klp_is_patch_compatible() after klp_init_patch_early() makes it trivially
reachable by simply providing an incompatible livepatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825114641.8045=
2-1-laoar.shao@gmail.com?part=3D2
