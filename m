Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A249EC4B
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516425; cv=none; b=ZLhzOUQhXPEnc8X9Ugj6cy/TOzPUy3xZa07saHvO3PH9fRmMP1jQ1NpAsTgQXVpaP0YyAWGvypCiit/LpkglR85duDWuR6Y8mRAE9q7hnBQbApyuJb3qW776HuENi4c3m3lmruW8Edn4aYSuLTUC6VqXbGE29hVa7qPgPHdn0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516425; c=relaxed/simple;
	bh=fe6sfgX+YEeU0KDV0Wu8iEypN5mNrlGUqwyCoKs0ikM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JjEcNxdlq59JAT6FqU89rlIwpKRaArte/V4NjLp24ToEdVB4yF4IehbyA2ca84XOvINOVktcChPSJSzKuM9qz5nCc6cgJlVNbb50fjPI6AD3jxmkcRQ9htfIIqr27kf5c8ydbrKC2d/aFIvngTdtBpeW6jt7qB9bKFXWfx+vSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRgDRHBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRgDRHBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E13A1F000FF;
	Tue, 15 Sep 2026 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516421;
	bh=Kcavj/e2oVWnrqQkQ0NLXMjhlwtk+zcHrmIxKgmq9Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRgDRHBHrbTPKknInervWdplfMZArD8V1seGahz/W67xsff1UWs0aTynrp8V8kVzj
	 UWTHPxvJl8oKHrvcRY3C5EJmO7wgLa+TwP+N4p6OlF1QDcRaRyUAgNiLXVOWjuQQbc
	 UTbMiZym3Ge4nn2DPpxwmNeg4f8w7cF6XHfqaHM9dKqhqAQAMYbua8q6/o4niYiL2L
	 JJu2WO0h4DJGnIapr2bgozeJpe6L3WahQ2c49VoSEGhliRKJCeCeqzGjnF2YN0tGqB
	 DK70VP+wVdqFHT8bJm14/uFARdOs+qCp260Ho51aG61gVUMmx1aW4Dv9S6PdzZjqnY
	 1rYSCwmYlXhzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 46/58] objtool/klp: Add test for data object
 checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: peterz@infradead.org, jikos@kernel.org, puranjay@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, mbenes@suse.cz, jpoimboe@kernel.org, kernel-team@meta.com
In-Reply-To: <20260915233454.2405019-47-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
 <20260915233454.2405019-47-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:53:40 +0000
Message-Id: <20260915235341.3E13A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] objtool/klp: test-checksum-data fails on GCC < 10 due to missing -f=
no-common
--

commit 1954bfc131a001b6d52e72e9ea82e16372d49e2b
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for data object checksums

This commit adds a test suite for data object checksum calculations in
objtool's klp functionality. It verifies that various changes to data
objects, such as length, bytes, reloc targets, and string contents, correct=
ly
update the objtool klp checksum.

> diff --git a/tools/objtool/tests/generic/fixtures/checksum_data.c b/tools=
/objtool/tests/generic/fixtures/checksum_data.c
> new file mode 100644
> index 0000000000000..6310af5c02d34
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/checksum_data.c

[ ... ]

> +/*
> + * A .bss object, where length is the only thing there is to hash: the s=
ection
> + * has no data, so the bytes are skipped and only sym->len distinguishes=
 this
> + * from an object of another size.  An initialised array would not isola=
te it
> + * -- growing one changes the hashed bytes as well.
> + */
> +#if defined(PATCHED) && defined(LONGER)
> +char sized[4];
> +#else
> +char sized[2];
> +#endif

[Severity: Low]
Will this test fail on older toolchains (like GCC < 10 or Clang < 11) where
-fcommon is the default?

Because sized is an uninitialized array, these older compilers emit it as
a SHN_COMMON symbol. objtool klp checksum skips SHN_COMMON symbols because
they lack a data section pointer (!sym->sec->data), meaning no checksum is
calculated for sized. This would cause the test script to abort.

Could we add -fno-common to the test's FIXTURE_CFLAGS, or initialize this
array to ensure it lands in .bss instead of COMMON?

> +
> +/*

[ ... ]

> diff --git a/tools/objtool/tests/generic/test-checksum-data.sh b/tools/ob=
jtool/tests/generic/test-checksum-data.sh
> new file mode 100755
> index 0000000000000..e915026b79a73
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-checksum-data.sh

[ ... ]

> +# The object's own bytes.
> +check PLAIN_VALUE plain
> +# Its length, for a .bss object whose bytes are not hashed at all.
> +check LONGER sized

[Severity: Low]
Could this check fail with "no checksum recorded for 'sized'" on compilers
defaulting to -fcommon due to the SHN_COMMON behavior mentioned above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915233454.2405=
019-1-song@kernel.org?part=3D46
