Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B052E2852
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838964; cv=none; b=JKuVMNiaK07jhONMos33QDTPJ8yLE7itMSH/shwsANaNKvHBOEnXh89VxkCwc3ub4377UJq/leopfe8hnMZQNHxawOh9aMpz4KmiCwOPmr7mdVbyOn27H05ZAXgQJ8vqhmFGTVrwmkVeoWX83fTUmBQbpQbJm4U2HbUUCzrAA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838964; c=relaxed/simple;
	bh=H5S9fE3H3IQGQDHG5gT2/2MIiqF2ezqGzjhq/U3E/VE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ois6g+CwOIHFhjpWF2GzT288IXeNZV4n7yeJ/LpiorJTnKSZ5ihdz3L+U1mksFzN5bDolKh2cNOchiw5nMWR23Lpvf7z+dnnD1rrm0s9v5Rc4ZKgLFCqVsrc4V5P65HFwJUq4+Y4WrA9N3XSeTpKBRb5lVwwDhdLrbNx6QzxYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxPjnE9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxPjnE9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FF1F00893;
	Sun,  7 Jun 2026 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780838963;
	bh=rjS3PGpMwrUygfRu/NC0SvSSApS1IxmcnrIuKRsJUtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxPjnE9KZqnPLDWnJ3DRokZTF6EOeii3LYhBIa+7PMcSUDcD/+ZhCB18UTVs6syuT
	 pRn+ISBvg7KeNv8w9LQtxh2GbWiyaahuEOXlwmRWPnmXNvKf+uUAbRkxpA+6skb2Ae
	 bELqHKNjTFrSVTz8z9V7zvcMP2scd80h1fHr9vjtnIEaQxsZShLF6THmPjAvSU+vU7
	 QeskR+afao8Qrn0JDnd6eUAcf8XquDoD9Km3hHX8BmDgeL9796/6hsgv/l3DdpZZ2l
	 jXklV+04RnZ0WA/pjZ+O7C0RwN0th2E9lMmZJNZ99aQHeZB7SpdIGZMiAV5/mMNQxo
	 d7XnLqbHxu/xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] selftests/livepatch: Update tests for
 replace_set
Reply-To: sashiko-reviews@lists.linux.dev
To: joe.lawrence@redhat.com, jikos@kernel.org, mbenes@suse.cz, jpoimboe@kernel.org, song@kernel.org, pmladek@suse.com
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260607131659.29281-6-laoar.shao@gmail.com>
References: <20260607131659.29281-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 13:29:22 +0000
Message-Id: <20260607132923.251FF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `replace_set` module parameter is defined as `int` with `0644` =
permissions, but the `replace_set` field in `struct klp_patch` is an `unsig=
ned int` and cannot be dynamically modified post-initialization.
--

commit 4cfbab500868bad0b10a33bdcbb852806612d546
Author: Yafang Shao <laoar.shao@gmail.com>

selftests/livepatch: Update tests for replace_set

This commit updates the livepatch selftests to replace the replace flag
with replace_set. It adjusts test cases to configure multiple livepatches
that share either the same or different replace_set values, and removes the
test case where an atomic replace disables multiple existing livepatches.

[ ... ]

> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atom=
ic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atom=
ic_replace.c
> index 5af7093ca00c4..5333503f193a3 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_repl=
ace.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_repl=
ace.c
> @@ -7,9 +7,9 @@
>  #include <linux/kernel.h>
>  #include <linux/livepatch.h>
> =20
> -static int replace;
> -module_param(replace, int, 0644);
> -MODULE_PARM_DESC(replace, "replace (default=3D0)");
> +static int replace_set;
> +module_param(replace_set, int, 0644);

[Severity: Low]
The replace_set field in struct klp_patch is an unsigned int, and it cannot
be dynamically modified after initialization.

Should this module parameter be defined as uint with read-only permissions
(0444) instead of int and 0644?

Using int and 0644 allows negative values which could cause improper implic=
it
casts, and runtime modifications have no actual effect on the livepatch.

[ ... ]

> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_live=
patch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch=
.c
> index aff08199de712..fedd2494d187f 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
> @@ -15,6 +15,10 @@ static int livepatch_cmdline_proc_show(struct seq_file=
 *m, void *v)
>  	return 0;
>  }
> =20
> +static int replace_set;
> +module_param(replace_set, int, 0644);

[Severity: Low]
Does this parameter also need to be updated to uint and 0444?

As noted above, the underlying struct klp_patch replace_set field is an
unsigned int and is unaffected by modifications after initialization.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607131659.2928=
1-1-laoar.shao@gmail.com?part=3D5
