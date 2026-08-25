Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE7383C83
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659191; cv=none; b=m2ASSmyRBD8+L67mipdl3HlPvO/qxTpptiSwiZ48qLEihH5zn5xVT9kMSKTyJdn17ypQTErf0p5LlE7iOL3krJ9G7f4ZHuQneW6uJjvto08s8/hBrQNiaUd2GIEyuCuVIcIyKLl6T2xtcfXNvUdphkvvenhrHNpWjzRVp1xC8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659191; c=relaxed/simple;
	bh=0A9fuR12Bv+fLjdUguiRFnzROQzeZGTfCSngsjfnoSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OG/qPmedw4ArFDmYT0921XXrAtGVDGBbbZdQe+AWW1j4ildfLzmP8uTT40kXLTJc1Enc4tdY2IcTUde6bgNiNYTWqN6JEsleiKUVa9dhw9OsR1k50U4+s3opbJkbWGPV7ERyINVDRbcuZ7XTIPuic1X2Wwyz7WjZ6DPOtkdL+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0jJnG+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0jJnG+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A6E1F000E9;
	Tue, 25 Aug 2026 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787659189;
	bh=DN0hnNvSVEK/cEBQc/1V6WfF/VWi1S+SvzN20Pr69I0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H0jJnG+gznhTmy0xnOWQ8XH+tI70yniEvTZaxD0E2eVF9aK+J2HtJNBfk8D5Dkw22
	 a5fwOhQP1ahsiPQSvuD6lM1zic8lgr3XjW0oJk7dE20NSJzBy1kDy92tbKTRP308eg
	 fkzLZLCRDj94JCc/t4Piac92vboHnv9/jPi+VWwzQzDpkZJR8I7QihcWMjb1yYSaUp
	 qRSmS3Y6u1we9oJzfFaDFNwmxsoDSVqKz359wtsb29zC0hz+HamclHKsPHDveqCkSs
	 g1kbxHbBRTb2OUHMI6jrvXgJspAIpnwBP2NsLoRomSqz99s3tBJXQX9lD/4wIjUUfR
	 K5ClTXWh1Ao5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 for-next 3/8] livepatch: Implement replace set for
 scoped atomic replace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, mbenes@suse.cz, jpoimboe@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, song@kernel.org, jikos@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260825114641.80452-4-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 11:59:48 +0000
Message-Id: <20260825115949.50A6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Contradiction between documentation/commit message and actual co=
de regarding the 'obsoletes' list.
--

--- Patch [3]: [PATCH v7 for-next 3/8] livepatch: Implement replace set for=
 scoped atomic replace ---
commit 32e1bcc9ed17f1580951816746e0cfa7cadbca0b
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Implement replace set for scoped atomic replace

This commit replaces the boolean replace flag with a more flexible model
using provides and obsoletes fields to allow multiple independent livepatch
sets to coexist on the same system.

> The klp-build script is updated with -p/--provides and -r/--obsoletes
> options. The obsoletes list automatically includes the provides id
> and deduplicates entries. Input validation rejects malformed values
> at build time.

[Severity: Medium]
Is this description accurate? The code and inline comments in the build
script and init.c explicitly state that the provides ID is not included in
the obsoletes list, and the kernel instead relies on explicitly checking the
provides ID directly.

> diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentati=
on/livepatch/cumulative-patches.rst
> index 1931f318976a5..04352ae3f0d06 100644
> --- a/Documentation/livepatch/cumulative-patches.rst
> +++ b/Documentation/livepatch/cumulative-patches.rst

[ ... ]

> +Provides and Obsoletes
> +-----------------------
> +
> +The ``provides`` field in ``struct klp_patch`` is an unsigned integer th=
at
> +identifies the livepatch's replace set. By default, it is 0.
> +
> +The ``obsoletes`` field is an optional array of unsigned integers that
> +specifies additional ``provides`` ids to be replaced when this patch is
> +loaded. By default, it includes the patch's own ``provides`` id, ensuring
> +that a new patch always replaces any existing patch with the same
> +``provides`` id.

[Severity: Medium]
This isn't a code bug, but does this documentation match the implementation?
The text here states that the obsoletes field automatically includes the
patch's own provides id by default.=20

> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index b52a8489d9f67..64bf3fce7fbc1 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build

[ ... ]

> @@ -235,6 +254,37 @@ process_args() {
>  		exit 1
>  	fi
> =20
> +	# Remove duplicates from obsoletes (if specified)
> +	# Note: provides ID is not added here; the kernel will replace
> +	# livepatch with the same provides ID.

[Severity: Medium]
Here the build script explicitly notes that the provides ID is not added to
the obsoletes list. Could the commit message and the documentation in
cumulative-patches.rst be updated to match this behavior to avoid confusion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825114641.8045=
2-1-laoar.shao@gmail.com?part=3D3
