Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6BF21A457;
	Sat, 15 Aug 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830828; cv=none; b=SepZjrS/8CkjSp9j6fIoSNAkXURj35HZbkGoyD2qGGwZejgZfr0zelQAxYXZwkhkEMgRBAreqcy2VkzMc5DCir5caJs5avWrvOkTEIE4Ng3Ej4Fdhp25LYVq7onyVAM8Twi581EoH/XwE38trLR3/J2Id6eoDPL+4KYK6euaxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830828; c=relaxed/simple;
	bh=TfaS4xsVEUti/Ld/sCXEUNN1G4AWkSUlF4uQG7INm0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSsrbT3RyQe3Qn+ygCI6Bei4PwN4DvudPjEais8oc2NNQd/e9VGAcOBXmmDn9xGezdQknc9quoazah5UJPyA/Q8zlLmp8SzBoKUeqgoNNBzrk8k8wszr0Z7T33AU6PpLT3YZVr8LWBDG/k3sTokkkjx6gRG8gw85HPzuCnF5X4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYQysflY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYQysflY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899231F000E9;
	Sat, 15 Aug 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786830826;
	bh=L1xQp6TnnctvVRvsmBO7lNUazoq7APGQJNQv5Cgr9VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iYQysflY5z6LJOT1PECEy9L7Pyjgx1OkM93zbDsKBNftTWEYrJM1TejoFe1QcGD1j
	 vWUFEV3hP9K2B14HKBsAvHwR4JSu2Y/WoXijAtHIurutCR+a1kKKqOmPx9mfqgB943
	 UNSv9khD0ANzi2gjhOLAT/2GlKhoHuDyZbHoQKasx46rMvaHfp2dLKr+dP4vOm6tvK
	 TyjVuSfM9PkRvDs1pDyiTNi24oR7kmZsPCx4kAAxiQauaLeWIxTA64PUj+rx43NIm3
	 NzK9CfqJnDii5NhMtSwvxLywVHYJMGUDfUE5KvY+51aHKRdnk/P7cR0mZLUg86BRut
	 Mk8k4bt1Vgj5A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6EE2E1AC527F; Sat, 15 Aug 2026 22:53:43 +0100 (BST)
Date: Sat, 15 Aug 2026 22:53:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 07/12] arm64/bti: Advertise BTI in assembly objects
Message-ID: <aoDf5x4iicivXsMc@sirena.co.uk>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <5340f3df281bebc81aad3cd9a7471d95061b4b9d.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHV2ZweC5h7oUr++"
Content-Disposition: inline
In-Reply-To: <5340f3df281bebc81aad3cd9a7471d95061b4b9d.1786768375.git.jpoimboe@kernel.org>
X-Cookie: My vaseline is RUNNING...


--hHV2ZweC5h7oUr++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2026 at 09:45:24PM -0700, Josh Poimboeuf wrote:
> On a kernel whose text exceeds the +/-128MB direct branch range, the
> linker inserts veneers.  With BTI enabled, the veneers' indirect branch
> targets need a BTI landing pad, which not all functions have starting
> with Clang 21 (and for all versions of GCC).

We already have explicit note generation support in asm/assembler.h
which is used in the vDSO code, it probably makes sense to replace that
too.  I didn't check if there's potential for the two to collide with
this as is.

--hHV2ZweC5h7oUr++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqA3+YACgkQJNaLcl1U
h9A/DQf/WTnuS2TWA3jYmXlJx0LmO3Ydemf68Q8UJia96H0cXBoAVbvlCLGelBJ+
xwrW2pLUAszFkVhshCZn9wIsBxiaJHvjNEJBiV11UN27ogqwqkF8P5omVVAoUx9n
Jd8YZb4KIDcof9ZXXeug2J5QFkXaZQ+TjCCAKunMT94QPA4Ku2PLSs41CVdm1aBB
Hda9JTCPsvER87662JHG7mICgPmUmlDQKwHpxS9V9YE+/fx+kgARnoEGc1O32DOb
JKhYD8v22nrMHu0sdcpQMwjc/6GDvB6nGzFsxtwqi9sOQ6RNDffXKaHWWnxY1+74
ZNAOYbZgbFNcnQb5BDrpiUMHGbWfjA==
=y+lK
-----END PGP SIGNATURE-----

--hHV2ZweC5h7oUr++--
