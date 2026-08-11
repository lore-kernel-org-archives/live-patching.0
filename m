Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142829D268;
	Tue, 11 Aug 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468992; cv=none; b=YGU/1pdPfW2kXWtkuJKFnIJHp3bkk18MY1fUJ5cuZ8l6ArsSpzX1br4cwYdGKq4h/YuSTF5Qjvp3upElrKHKMxHg5dDnU5E9g1NfmzOqFSC6cOoC1xWwHQdWgJmU6g8ntMgpsnBdQRzXyWW31Hl7ojg02en/mSoiWPdoZPDEYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468992; c=relaxed/simple;
	bh=/sWlUZt2hIyx5lBiU4DkHYxqIqXd66gLt2iNZUww8GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OywpITcYf6zuD9hOLeWhaNj/NijRatTju2F6hekyDV6jkVOmlcwA2wlLGTZikp0p9U5wKPWs5YI8++nAqw89KAjl/NjYsA6hy90xRu5SKd759X4e/c52ee3Mh5cc30iAUEOjHnW2SgROYL8vbRAU/lq3Jb6tkvH5wCVk0+30jMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/bHkv9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/bHkv9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43B11F00A3A;
	Tue, 11 Aug 2026 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468990;
	bh=/sWlUZt2hIyx5lBiU4DkHYxqIqXd66gLt2iNZUww8GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F/bHkv9WcMTKagZFH81Gk+brL25RmGd+eLsleeqA9MAAaoGnCtkCyfljPNMRaOH3J
	 Lc1Gw5XWDrc69o0RcIDwN7ChAxTJPv4audpUB8wOJwoAuhFNCq8FKDq1acBuHqz8eb
	 HtQnSCdrP+wE/xg5R5iLVpsGjn5xvhLtVBo/jgVBlzvlqYV8VOTXOSFKR1IS/nSeKb
	 z3kedgLahvTH8o4dNxMUukPO89hxz5LkfZZcLhxaU8StwSLwpknrzPPdnkGX2VmXhV
	 2MjngvNiKT9VuHCzVl4BK06kx2LwZrR5sliaZkoXUbQ8lYKtuyk4Fhf86zc8e/OJIl
	 V3sxyX+SKbJHQ==
Date: Tue, 11 Aug 2026 18:23:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <ad261bfa-5301-4b3c-a146-86111d15e644@sirena.org.uk>
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
 <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck>
 <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com>
 <CAKwvOdkVxt-90Z_Af8s63RKCY-202r_0_bgF+8-g7iKn6XM_Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YYZV6sPaIVLOCKHI"
Content-Disposition: inline
In-Reply-To: <CAKwvOdkVxt-90Z_Af8s63RKCY-202r_0_bgF+8-g7iKn6XM_Sg@mail.gmail.com>
X-Cookie: Take me drunk, I'm home again!


--YYZV6sPaIVLOCKHI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 09:17:09AM -0700, Nick Desaulniers wrote:
> On Tue, Aug 11, 2026 at 6:18=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:

> > https://github.com/llvm/llvm-project/issues/215547

> Thanks.

> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106671 was closed as
> invalid pointing to the same commit in llvm. What's going on here?
> Where's the corresponding feature request for GCC?

TBH I'd missed that that got closed, basically it's what's in the report
there - the GCC people really dislike the idea of adding landing pads
and want to see veneers added by the linker to fix up issues where
they're missing.

> At the least, I could imagine there being a `-fno-omit-bti-pads` or
> whatever for the kernel to opt into this behavior.

That would be useful.

--YYZV6sPaIVLOCKHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp7WnYACgkQJNaLcl1U
h9AlWAf9EDmcgnnvuL4cqwpOwcFQBZ+OC5V5uyozWCWwwgFZWuxMkGFmeh9jP133
HxdCeyAn4jdemlf7UuUPAVjCCrd1a/vLdbUVWSDpxCqd0eCK0FiSG1a0l+ybSDdf
l2AH8bLabTs1znEf1iKhKnRF32zzYxIB+kbiBSOpqIVDRSZcUS4kOAK+tyHvHVFc
t6es633XMyu7a+P/Y3p4kRNlPF9W4p/xks40GlVe+Qi6PZ23K6nlIRSDpTUmR2dI
TCjdXk3d8f5UVkXb4xGbzKTEGAuIUifDxi2e0AgMKCd+4MTtOhiyb8bzsxjGTUkG
U0sngeJ0+vaxaJ8iHRjWANooW8b2pg==
=eLwd
-----END PGP SIGNATURE-----

--YYZV6sPaIVLOCKHI--
