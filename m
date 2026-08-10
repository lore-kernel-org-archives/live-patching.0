Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A993F86EA;
	Mon, 10 Aug 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379151; cv=none; b=X4lYcqAYJpiBNJG7izBKwtaKsiERO5BoN9AW8ON/kA7GEMjKKvJl+189KJQiAf+wxaCoQjHjagWzdoxCISq6ydkjVcH53M9QMgPRbX7dm+FCM5EpLwgX14nQn5tGTA+1foloH4Dnf9szOtOa0K2Wes7+uqXTKyxFhms5xiJ1YcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379151; c=relaxed/simple;
	bh=Ri8nRuGfZo/RE/UwMW2GuEo8sueaiQ+bLEMy7nBJp2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGu6X2QFPwhCBz+UIT52DvVZOH+X9BXShds9Sp6k1OOSUm9RUaW1PG7zBe1GH1Dxo6XFXCVKDExTju9ODNR4qHh/MLRYutHABxdKeTqayRa7/Jz6OETljISWUizx2bWtTbIjoCQwHnvUsS4toIW5GgsgIPCOSU2iMDa5uX7Ksd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M49pubjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M49pubjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A771E1F000E9;
	Mon, 10 Aug 2026 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786379145;
	bh=puBf023P8WVgEypU/hph2K8P+fCv6S17KYbYjmpQwxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M49pubjnLA0rHT6FWPVJ4HZhQCNpICjrdptC1Wld14EziZlXYWnCHNVLVAqE5/SMs
	 3tJ8oGbP506c1sPHNoWsPP+HcrFT59RJMPNS+X3hEUWG0f5QlQ98nihi3OsMfCYatl
	 VvugBLa1bcSU1nwOOt3W7Sal8pMIozzGWMojt8776gmkPnJ2Mw4YWHHHPXHuleuNes
	 eaqAH6gm9xnJTjRaaI6tg6PbLXUsrI9OYnalrbiJpboNh0pmp9CGW8l9wXrZjXu/We
	 CtrvfQ7YE5B6mC/tf99BwsxbISFwcYvi0utZYOJGS+d0mPlM1wxSfMhbkDo36lmZ8b
	 +21FfypVVn3aQ==
Date: Mon, 10 Aug 2026 17:25:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <da06bbd3-d04b-4d0f-b331-f5b91bc373a5@sirena.org.uk>
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OrzuF7qUiD0sqMOd"
Content-Disposition: inline
In-Reply-To: <anmobvJXiBQqWn6S@willie-the-truck>
X-Cookie: -- Owen Meredith


--OrzuF7qUiD0sqMOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2026 at 11:31:10AM +0100, Will Deacon wrote:
> On Fri, Aug 07, 2026 at 02:46:11PM -0700, Josh Poimboeuf wrote:

> > The following BTI exception was seen when loading a livepatch module:

> >   Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
> >   pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
> >   pc : kill_orphaned_pgrp+0x0/0x150
> >   lr : do_exit+0x498/0xaf0 [livepatch_combined]

> > This was found by testing with klp-build and Clang 21, but the issue is
> > not specific to klp-build.  It's inherent to any livepatch module use of
> > klp relocations.

> > Previous tests with Clang 20 did not show this problem, as older Clang
> > unconditionally emits "bti c" for every C function.

> Is there an option to restore that behaviour if CONFIG_LIVEPATCH=y?
> Otherwise, I think I'd be more inclined to add yet-another dependency
> to CONFIG_ARM64_BTI_KERNEL so it's disabled if LIVEPATCH is selected.

This won't even be livepatch specific I think - I expect the same issue
can be triggered for module loading by using annotations to place
functions from the same translation unit in different sections if the
sections get placed far enough apart.  That was what was impacting GCC.

--OrzuF7qUiD0sqMOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp5+4MACgkQJNaLcl1U
h9DWCwf/Xti+nVWpJHcUhn6hWKTHMFbXPU/xtxs0DQDxretJilC2YDU3AkLOsCz+
Rh/Fd8sq539JCsMpATZOU8Od41skWS33mhDmcJy2agCj4ObNs7e1V8mEF9hp9Ait
32wCO5WCOSJo4ZXGoTTxDkcU6cMn5eDYvnzOfe6FeoqyU0RIH7b4/S4joYpU88kj
vUX/Nsi98auZZ6ddIj2hWlg2nAAMxC9oFWwVTj5A8z93JZSshimwQkcOWB9OqKS5
bS/7J0KYX5wS4EJplq7pHNweCmT2tJPKG67eqhYHkolXEzu6ptzqbC9GALsm5uFE
P053/E6HJtLxJ1UYa5a9nODlmhXKEA==
=Z6Dc
-----END PGP SIGNATURE-----

--OrzuF7qUiD0sqMOd--
