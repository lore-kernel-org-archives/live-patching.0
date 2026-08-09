Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB5379982
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268454; cv=none; b=OlRiHPZPc7bXk7pkYygjI4mW8P+adRI/vyD4I5Ufoe+K541Q5uhh50qaSYP6COjK0Zq/YScA8gWAZfHwC5LXZIVAg99umJATZeurNUjjHuqjfpBWPRSTH6Gy0+p4aACQ6ZmJVAaNSCGmJHLiN2v6fLro8g38kE8ArR39jSlx3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268454; c=relaxed/simple;
	bh=xy16RZq4rrFgt68Xqr3jx7Kst2suXDPigOFDkpGoSQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PcxtW429Su0P9ZVayg2eTJzXcXJ5VtkyXlSEiQrxzQQAqXXTldM+xOuq4dWpoCJMKYAQ6dYPSe/giJzCkg0nkW/R1rr1Fk8Lk2vdW1F6i8EDMPdw6DUGtpyNxsfxQIzzO3D3vrFg1RJpNyYnzLXSqT1n8X7R5VAJQtJ9Kms7RZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb+fWo0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb+fWo0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ED31F000E9;
	Sun,  9 Aug 2026 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786268446;
	bh=hnpvMN9u/S7W5N1hQ0D2E2SSD4nRBEnvolxR42VHnwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xb+fWo0n/q1C+1aZS1NvJJG2XSwZoohdgNWDJ+sSx1XqR9uVATSuIyTnU1nQSACiq
	 4/H2i0geCsTUNqv+1nffbVf9vo5I2h9PpmQ6wBi5EL0+WyJLqpRLQE5Wzz5Od4GkoY
	 qcZUbzaUBpgwEvy9Y4f5y9PokKoSTC1vqnJ6DZwvHZoNg6hO93fg7/7lEFVRXq0O5y
	 NDuPoMWdVY52HZu/lHhzQs2SnCxHHT3cQnLUaqvwEt8rkScUGczL9WMG8mVCfREU9H
	 +8OYkdJQd9043RfufnjCwWBilocG/f3t/TiTyFEevTz9zV3ZT6cDLNtomalIEPpwQf
	 h+s27zGOs6Z+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] livepatch: Call klp_init_patch_early() earlier
Reply-To: sashiko-reviews@lists.linux.dev
To: song@kernel.org, jikos@kernel.org, mbenes@suse.cz, jpoimboe@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260809091954.22930-4-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:40:45 +0000
Message-Id: <20260809094046.50ED31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, an error during patc=
h initialization causes a Use-After-Free during module unload due to delaye=
d kobject release.
--

--- Patch [3]: [PATCH v5 3/9] livepatch: Call klp_init_patch_early() earlie=
r ---
commit ebdb1e39e8d2124754d0f852abe91968ee2bb0d7
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Call klp_init_patch_early() earlier

This patch moves klp_init_patch_early() to an earlier stage during patch
initialization. This is intended to avoid mixing for_each_() and
for_each_*_static() variants later in the code.

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 5d05d6fcbf57c..1908ebedf8734 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
[ ... ]
> @@ -1149,6 +1142,14 @@ int klp_enable_patch(struct klp_patch *patch)
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
This is a pre-existing issue, but does moving klp_init_patch_early() before
klp_is_patch_compatible() make a delayed kobject release crash easier to hit
if the patch is incompatible?

When klp_init_patch_early() completes, it has called kobject_init() on the
patch->kobj, as well as all obj->kobj and func->kobj. If klp_is_patch_compa=
tible()
fails and jumps to the err label, klp_free_patch_start() and klp_free_patch=
_finish()
are called.

klp_free_patch_start() drops the object and function kobject references:

kernel/livepatch/core.c:__klp_free_funcs() {
    ...
    kobject_put(&func->kobj);
    ...
}

kernel/livepatch/core.c:__klp_free_objects() {
    ...
    kobject_put(&obj->kobj);
    ...
}

However, klp_free_patch_finish() only waits for the patch kobject completio=
n:

kernel/livepatch/core.c:klp_free_patch_finish() {
    ...
    wait_for_completion(&patch->finish);
    ...
}

When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, the kobject_put() on the
un-added objects queues a delayed work up to 4 seconds later to free the
kobjects. Because klp_free_patch_finish() doesn't wait for the child
kobjects, klp_enable_patch() can return and allow the module to unload,
freeing the klp_object and klp_func arrays before the delayed work accesses
them.

Can this result in a Use-After-Free during module unload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D3
