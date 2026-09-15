Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFE49EC4B
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516306; cv=none; b=jPiRHsyHeuHDs3WVUQP34JRIL/nT23G8fCkysAwZEafhWU3PGrli9Mui6M3uMvZQSdACHJa3PF9JXtxyzp5QMqOkNpqm6JwY9pIyT+McyafjoUIj8t/ge8+bEoVOxHbHlPqBpWMo437+BLgmYF+GDz0AYjrCNQDuLK4bAxn1bkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516306; c=relaxed/simple;
	bh=Bw5FWDznTrfwCcbh8ahILQ0y6QMncB9ztOf0X1QftOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWN4EmknwHNXonOzpFZrel7kb+JEa9V9G7GtmsbI6ASudv/99ZsdVQi+tSIJ3xWZu2IAEbnH+djVf9Go+Y8xX85v9BlChdHBN4cZFS324ojcRrVrIe1w50zyt1nQPGwYwMmli3pTL+PcRS9V/dBFZq5HDqfkOvtoJKW0LuQjJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoic6Onm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoic6Onm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B361F000FF;
	Tue, 15 Sep 2026 23:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516305;
	bh=jz311AswEtksvm/TvcMXiQYOXOiYueRtAV5OD7SzBRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoic6OnmvR6DCgl75gTuRCCMX8alxPLmZqvlWBWyvZcFNAus92iV3dEfjgoKfSolJ
	 TJDpjEd8aY47FPbGst8vMVcYHE6NHf6BoijA0FS7Pyp9c8AftPAjJdWNmtE6rswmK1
	 eOaPfSmbXU5znGNgafHCHj16KSNJqApU4JWe8i5OOjo1sBXHv5KzVuO4dmdgmlMIvp
	 LXZ6k2OSn6BLFAV2zmwz4okJppVvUOcFT4dSjnmzVUNt4Q/3Vqa/Nx/a9zhK6TRvKi
	 wN9/sD2DmRKj66hGWT+CbbdQMsgqTtVW3aJgZ3/f7oJmxpxzTKPPrUX0aRI8y5eFGH
	 C1FFnygSvJxRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 39/58] objtool/klp: Add test for static locals which
 must not be correlated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: kernel-team@meta.com, jpoimboe@kernel.org, peterz@infradead.org, jikos@kernel.org, pmladek@suse.com, mbenes@suse.cz, joe.lawrence@redhat.com, puranjay@kernel.org
In-Reply-To: <20260915233454.2405019-40-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
 <20260915233454.2405019-40-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:51:44 +0000
Message-Id: <20260915235145.23B361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool: klp test regex fails on architectures with small data s=
ections
--

commit 4400f73b697d110a1f506b61da1421c4d22b7608
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for static locals which must not be correlated

This commit adds an objtool livepatch test to verify that certain static
local variables are properly uncorrelated in patched functions. It checks
that .data..once flags and per-instance variables use a fresh copy, while
ordinary static locals remain correlated.

> diff --git a/tools/objtool/tests/generic/test-static-local-uncorrelated.s=
h b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh
> new file mode 100755
> index 0000000000000..fa4ce88a79b1e
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh

[ ... ]

> +
> +# Not correlated: no klp symbol, and a copy cloned into the patch instea=
d.
> +out_symbols | grep -q '\.klp\.sym\..*__key' &&
> +	fail "__key was correlated; it must use a fresh copy"
> +out_sections | grep -qE '\.(bss|data)[^ ]*__key' ||
> +	fail "__key was neither correlated nor cloned"

[Severity: Medium]
Will this grep pattern cause spurious test failures on architectures that u=
se
small data sections?

When compiling for architectures like PowerPC or LoongArch, the compiler mi=
ght
place small variables like __key into .sbss or .sdata rather than .bss or
.data. Since the regex strictly expects .bss or .data, it appears it will f=
ail
when small data sections are used.

> +
> +out_symbols | grep -q '\.klp\.sym\..*once_flag' &&
> +	fail ".data..once variable was correlated; it must use a fresh copy"
> +assert_section '.data..once'
> +
> +pass "per-instance static locals cloned, ordinary ones correlated"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915233454.2405=
019-1-song@kernel.org?part=3D39
