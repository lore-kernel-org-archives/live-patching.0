Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5492D1907
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515983; cv=none; b=i7wo/DSClsMaY7gr1NWZqXitlkzn1wmT5FssydiXTPV9NY75mSAEqI+Wy0e1pGYXajTf3euwKQrU7FhMitvw1fOFqTplJT3JgWDAMoEmzJxmznFen4+Z4BN64ZKWh/nu+4KVaxUpjDm6rau+rAp0Nphx77vK+Xdx/DtLN5VAEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515983; c=relaxed/simple;
	bh=0pdBUXojY5ob62HV3idokwELIbof3RZHC1zAg9uOxeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MADV5MVowOsNadHEOkRv8qftDK0xgXBeiq7lZf/HyEenGw16+WQwMaRAlqiY0BhBEFMxtQHCJLXncbq+dlWypA8eUPig0+FvMxptpJfcde5OC68dpxrpD15ZZL8wpVZk0Ns6GdjAj3/RnGz32ClUH23muAKKa/HTscliG4ztMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQQOsxbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQQOsxbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A301F000FF;
	Tue, 15 Sep 2026 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515982;
	bh=C/GxPdRbSpWU9pTrwlcsMX568lmO5Cpbof7vm8pov/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQQOsxbFFe8no2+5RKISuENFI267bcEjETljefJjP97pEHNk7u5/akFDoh21GR+Y/
	 vikEz87Hxuf+KJCUopmNijjmYDVm7l6nJcuutb3tEOKcVKZXQDxTkMlIViAJiXG7Iq
	 Bqei5uer5VV60psElYVhVfroh4HBaO8PRdQ1VhCTZtNVJ8Tj41vkatcV8QmiBbIt/f
	 2N8DS1yPmcADHkdg0e8dPEe99oGVRXCTQPmqme9stsa6IevXF4pPpYEm1jLhQjNfhP
	 6tIx6fGCSX3UvhT8OLFTaEBitUu8Ko18prWEhBEG/U82y/rtMXZf5BuC2wNTdbaoS5
	 nRQNlyZVPH5Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/58] objtool/klp: Add test for static local
 correlation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, jikos@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, puranjay@kernel.org, mbenes@suse.cz, kernel-team@meta.com, pmladek@suse.com
In-Reply-To: <20260915233454.2405019-16-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
 <20260915233454.2405019-16-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:46:21 +0000
Message-Id: <20260915234621.C2A301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] objtool/klp: test script grep matches file path instead of symbol n=
ame
--

commit 8279e7aebe31fad0b7cca275957a41207409ca61
Author: Puranjay Mohan <puranjay@kernel.org>

    objtool/klp: Add test for static local correlation

A static local must be correlated with its original rather than duplicated.
The replacement has to reach the existing variable through a klp
relocation; a fresh definition would discard whatever state the running
kernel accumulated.

> diff --git a/tools/objtool/tests/generic/test-static-local.sh b/tools/obj=
tool/tests/generic/test-static-local.sh
> new file mode 100755
> index 0000000000000..d57efa64dfd92
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-static-local.sh
> @@ -0,0 +1,24 @@
[ ... ]
> +out_symbols | grep -q '\.klp\.sym\..*\.counter' ||
> +	fail "static local not referenced through a klp relocation"
> +
> +out_symbols | grep 'counter' | grep -qvE 'UND|\.klp\.(sym|tombstone)' &&
> +	fail "static local was given a fresh definition"

[Severity: Low]
Will this grep command inadvertently match the ELF file path symbol's string
instead of uniquely matching the static local variable symbol?

If a developer checks out the kernel source tree in a directory path
containing the string 'counter' (e.g., /home/user/my_counters/linux/),
GCC populates the ELF file symbol with this full path. The unfiltered
grep 'counter' command matches this path in the readelf output. Since the
file symbol uses the absolute index rather than the undefined index, and do=
es
not match the .klp exclusions, it bypasses the negative filter, triggering a
false positive test failure.

> +
> +pass "static local correlated rather than duplicated"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915233454.2405=
019-1-song@kernel.org?part=3D15
