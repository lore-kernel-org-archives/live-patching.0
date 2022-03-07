Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E4C433EF
	for <live-patching@archiver.kernel.org>; Mon,  7 Mar 2022 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiCGRDH (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiCGRDA (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 7 Mar 2022 12:03:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A1B6CA56;
        Mon,  7 Mar 2022 09:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16055B81654;
        Mon,  7 Mar 2022 17:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B20BC340E9;
        Mon,  7 Mar 2022 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646672523;
        bh=1P5v9F/mZnKMXAuqZg5b/RWXG24Id5fBXMZ4MlFif3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrBOBqNLjVfZ248m0etVeiFG940Kglk0T9zUitjXk46vR9Ngwgeg/kTx7/xq5a4bE
         SSXHkApH5/UcdvNZv66Fwp7TQgnbj1z1DY2kRNI/z3q+bek9EyQMfo9bXdV/nsTPe0
         icDq+BBRGi2F+BtJiL+7mRcxgAQ3XkpXeTyhp9epmR1o34D34pGizYCIfERVPnLXnE
         o5WGk+Zq/ThzQHsgKPRpCZAJx2LlH2ONGF9IL+VYA0HfpVwGh3BW9JhGIEvP4yJb3q
         LYmwPouLIKOO2GCf+BRyQPkpimAjytJ1w2ZfNgJArOp1drCybDjLXRfSlmLkqDTOgV
         NbSg4iWGhInbw==
Date:   Mon, 7 Mar 2022 17:01:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, jpoimboe@redhat.com,
        ardb@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        jmorris@namei.org, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 06/11] arm64: Use stack_trace_consume_fn and rename
 args to unwind()
Message-ID: <YiY6hecX0pVWowQ7@sirena.org.uk>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220117145608.6781-1-madvenka@linux.microsoft.com>
 <20220117145608.6781-7-madvenka@linux.microsoft.com>
 <YgutJKqYe8ss8LLd@FVFF77S0Q05N>
 <845e4589-97d9-5371-3a0e-f6e05919f32d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixglzDwA9geSqnO0"
Content-Disposition: inline
In-Reply-To: <845e4589-97d9-5371-3a0e-f6e05919f32d@linux.microsoft.com>
X-Cookie: Whatever became of eternal truth?
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org


--ixglzDwA9geSqnO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2022 at 10:51:38AM -0600, Madhavan T. Venkataraman wrote:
> Hey Mark Rutland, Mark Brown,
>=20
> Could you please review the rest of the patches in the series when you ca=
n?
>=20

Please don't send content free pings.  As far as I remember I'd reviewed
or was expecting changes based on review or dependent patches for
everything that you'd sent.

> Also, many of the patches have received a Reviewed-By from you both. So, =
after I send the next version out, can we upstream those ones?

That's more a question for Catalin and Will.  If myself and Mark have
reviewed patches then we're saying we think those patches are good to
go.

--ixglzDwA9geSqnO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImOoQACgkQJNaLcl1U
h9DW4Af/fUxJE80JR9yUH25qzBX7Hf16++AL6o3U3dW8Iiw8JBCFQhS/m/063PvM
OzG1hKZdDpW97rwicBDT6jRZednkDj9tgzrI2iuR10wldWLNmIR/ok3nOa1IZ+ZI
ZcHvDcGmVZeQdIY6EB2lLeFaNHIQlFx9Hzxn/lolgX51EOBDBofVgbqnndE3tZNC
1oLWd5ZrBUePi3g7hrVbqikU2zPIlykyS5MgMquBfqB1ybIgTXkpQyjbUnahOnrE
lWy54hhIHEuu0aPuy/m6bNC+EF86b0sF43dlzMueZKLW42Je+HRgvMKi9dI38zGC
bM+8tW+PNivVEE5waHX30nKhnpI8qg==
=+oMv
-----END PGP SIGNATURE-----

--ixglzDwA9geSqnO0--
