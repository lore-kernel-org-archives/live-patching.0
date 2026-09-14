Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CCF31E835
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368415; cv=none; b=AKyJUWFTmNjOLTEgddcFZIbsgZwVjHUkQX4IIYBDwEegsNPFNmHnLvbe/heBsyJOehQom16IgS5IkhakIqoc21XBwMAETSemeP+AiOo5qCB2QfoKyQTTJNu0sBCAFfFCRhUJ+Xdxidwkz2saxK8YyU3txKW0kT/eJayErPn1LE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368415; c=relaxed/simple;
	bh=OKIcS3OvQLL6D/7Tz5RSh2TqoyFUm3SrklEk5huEJUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQjoIbwG9BAoKt1h2vz1x+CEqVwOj6AKnDB8SDXrZy+CzGQtMG+D5ky55GhZp8FBYNe/HTKHLbF6wo4wv+x8aLPq35r40dmhp9a3iO4wizN9qnxXH+Q4OTbiERZUCw03LpWC+VGDqbIBW5Iejd/zV6ZqS8zPtImrCkN4GOnGXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFt+tz9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFt+tz9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505A21F00893;
	Mon, 14 Sep 2026 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368413;
	bh=Pu9yJndd8xN6nkXWWEt+spQzkjprmsXsM6K9b0Pi8fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFt+tz9jct2d/cZCsmt9u56J0//GZpDnVZs22NvH7XFSKpUX1+qFQv8ydPEhs/RqL
	 9T4dbkxOnm4rLcOKsFySVuw5rDiZrEA1Wd1wmx6dJd+BGVuktRX3C2ppvxWaJaV9Cj
	 ewNV3zoS3fXplfeaQ15Hvbk609duJ6YT9l0s1nwJySJ9pz2fK7tEVWDdRW9CP0DxAy
	 jSRIOwVRrX6QBl/OFPhB24fi4lfdc6xSz+CuI/nLjl+6dsfvBVR4IemPOrpeKvQPsi
	 Jl2RWVF/59PR9FFdBlgPosF42enV4WRq9R3ogV9hs7KsHUBB73Kdsb2Mf6gQRv0aU1
	 36ra0P3zwzn3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/58] objtool/klp: Add test for the contents of the
 klp_funcs list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: pmladek@suse.com, jpoimboe@kernel.org, peterz@infradead.org, puranjay@kernel.org, kernel-team@meta.com, joe.lawrence@redhat.com, mbenes@suse.cz, jikos@kernel.org
In-Reply-To: <20260914062514.926997-32-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-32-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:46:52 +0000
Message-Id: <20260914064653.505A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Test script relies on non-portable `grep` features (`\b` and `-w` o=
n non-word boundaries), causing false test failures on BSD/macOS environmen=
ts.
--

commit 4a06859b140cc416baf636400fbe85d7c99ad01c
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for the contents of the klp_funcs list

The patch list is what livepatch acts on, and asserting only that it exists
does not say it is right. The fixture changes two of three functions and
asserts on all three: the two by name, and the third by its absence.

> diff --git a/tools/objtool/tests/generic/test-klp-funcs-content.sh b/tool=
s/objtool/tests/generic/test-klp-funcs-content.sh
> new file mode 100755
> index 0000000000000..c4ec7098d9482
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-klp-funcs-content.sh
> @@ -0,0 +1,44 @@
[ ... ]
> +# The names the kernel matches on are real strings, not just relocations.
> +out_strings .rodata.klp.str1.1 |
> +	grep -q '\bfirst\b' ||
> +	fail "no 'first' string in .rodata.klp.str1.1"

[Severity: Low]
Is it possible to use POSIX regex features instead of \b here? The \b
extension is a GNU/PCRE feature and is unsupported by BSD grep, which can
cause spurious test failures on non-GNU platforms such as macOS or FreeBSD.

> +out_strings .rodata.klp.str1.1 |
> +	grep -q '\bsecond\b' ||
> +	fail "no 'second' string in .rodata.klp.str1.1"

[Severity: Low]
Does this code also need to avoid the \b extension to prevent false test
failures on environments using BSD grep?

> +
> +# The object list has to reach the function list, or nothing is walked.
> +assert_reloc_sym .init.klp_objects .init.klp_funcs

[Severity: Low]
Will this assertion fail on BSD grep? This passes a section name starting
with '.' to a helper that uses grep -qw.

On BSD grep, the -w option requires a transition between word and non-word
characters, which always fails when the matched pattern begins with a
non-word character like a dot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D31
