Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDF2EA480
	for <live-patching@vger.kernel.org>; Sat, 17 Oct 2026 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197016; cv=none; b=XdrNKIg947NPWoAaYhdn5EOBMXIZokZ8a9SdOYr7KwT9o6zAdeCSTWxBsLac1IOiBybD5ywpXB6x93YyZ5lBb3SFkUX+xB+JTQuZJaRpIpBcU4fcCVDPbuEkCRL012FhAAbThmvnnr8CvOrO26Yb9hp+o5wdKbCX+n2W2W1cH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197016; c=relaxed/simple;
	bh=aSU09TteO1I2mIJBcOE+b6s/N5VMKfvri4C8YY/Iqfo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pYJOMQV8oflyg7IfF1l80uW0CLRVt99JgH6V/tN+I5pi0s2dQLU3CFNbaXlmD15A2bJF1J+VvTzIM4/cQVEpSVX3k5jkgmiUsEpa5p6ARYsXepHxsvrW2kCR24NB7EEvVeav9mcugBfvvnYYB7N8N3u6UODjiCi9PfVNUeze0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv9vziG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv9vziG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B911F000C4;
	Sat, 17 Oct 2026 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792197014;
	bh=cPElS7OS4PJfCC7ex/nCn9n4pTlmbSAlLAHtbrzT6eE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dv9vziG9Ac9/grVyYbPUFeUFHZzc4oaweWwumOTkidBqp8/UrNoqKHqF41AB9OPWn
	 2hTpwpjyh2Ev41grY0WYleo8a7fnvGI6geVT8y88hNrmEQe3w5cwuAu9z9FxNdt8r0
	 lR+93d5Z04dml5Ge+gaDqAdMc7Gw28e8v0aDnmi2/D/HVO/yN94NVGAn0Nx9QNUWlC
	 fEMahlUhjJfIML98pyUry/WLQXfoMhx0KpwArs5qzW9hDrM7y5Vj/vPQtDtCFbiGNe
	 V8lLPPRc67aI0LYoGXOUrvmDIZpm+jUEdcNhZpttNlD9h9ygxoqd5j3j7XXUv0fojL
	 1rpXHBwD89oLg==
Message-ID: <sashiko-outbox-175075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] selftests/livepatch: Test klp-build with
 dependent patches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org
In-Reply-To: <20261017002441.716615-5-song@kernel.org>
References: <20261017002441.716615-1-song@kernel.org>
 <20261017002441.716615-5-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:30:13 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/livepatch: test-dependent-patches.sh duplicates test-basi=
c.sh setup
--

commit fc2a73d39b4eb0e68d2bd9630878b28c5feeaab1
Author: Song Liu <song@kernel.org>

selftests/livepatch: Test klp-build with dependent patches

This commit adds a new selftest script, test-dependent-patches.sh, to test
klp-build when a second patch modifies lines added by an earlier patch.

> diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-depend=
ent-patches.sh b/tools/testing/selftests/livepatch/test_klp_build/test-depe=
ndent-patches.sh
> new file mode 100755
> index 0000000000000..75b957ac002c0
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_klp_build/test-dependent-pat=
ches.sh
> @@ -0,0 +1,72 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(dirname "$0")/functions.sh"
> +
> +setup_tree
> +
> +add_file drivers/foo/foo.c <<'EOT'
> +int foo(int x)
> +{
> +	if (x < 0)
> +		return -1;
> +	return x;
> +}
> +
> +int bar(void)
> +{
> +	return __LINE__;
> +}
> +EOT
> +
> +# - a patch which changes lines added by an earlier patch doesn't apply =
to the
> +#   original source on its own, but the combined patch does
> +
> +start_test "patch which depends on an earlier one"
> +
> +add_patch 0001-foo.patch <<'EOT'
> +--- a/drivers/foo/foo.c
> ++++ b/drivers/foo/foo.c
> +@@ -1,6 +1,8 @@
> + int foo(int x)
> + {
> ++	if (!x)
> ++		return 0;
> + 	if (x < 0)
> + 		return -1;
> + 	return x;
> + }
> +EOT

[Severity: Low]
In tools/testing/selftests/livepatch/test_klp_build/test-basic.sh, the
script already calls setup_tree, creates the identical drivers/foo/foo.c
via add_file, and defines the identical 0001-foo.patch via add_patch.

Since run_klp_build() in functions.sh leaves $TREE unmodified between
invocations and supports running multiple start_test cases sequentially in
a single script, should this dependent-patch test case be added to
test-basic.sh instead of duplicating the setup in a new standalone
test-dependent-patches.sh file?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017002441.7166=
15-1-song@kernel.org?part=3D4
