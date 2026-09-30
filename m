Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125636F419
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738040; cv=none; b=W472y+Am0bPbRQ+YXmJIXwN278IfR9Qn3SLS4VsnBfJX9FBbuURWHUiBsHVtr3oI/19AX/NOQJ0mawpvvq/xUCrpiv3fTTW4TLr01J6svAy8ahn/2N8ujJRoC5R6Ic0eWbtY0GkYqwvd/K4NzOeo0sIHpvTbvE5qbUmMYKN72uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738040; c=relaxed/simple;
	bh=FjDj57GL+LbKO5O+trgjR65+6F0F25QOn5midmLd8vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqgVViRIJTsxNiv8bbNstm9UgWwmRCeUBuC11Mzx4CG4ITEs94rCym37s9wZZ9FARjDocUltFZOMvtk1SX36SBuVmBcfmF0M6O8UmhdvDElphsr+iFj9j8U8rj7zkI16GuggpNR5EjXDAXOz3JeRFMX1VfpHqSBVejV0nMS263U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0NTBala; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0NTBala"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7611F000FF;
	Wed, 30 Sep 2026 03:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738039;
	bh=SouW21I3De23uTSogj5LoTkkF+fTIsQD0hE7xNUwuyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0NTBalapqKBdNFheVvZzH/NY/026ydBhHQ4o2ZIWpwDEMogF9861BUWqjvI+IKGp
	 Yxt38PVW9HnYlyHxnTR99i1iy5ExeoYtmJR7QLWM14Xnb+k85oqR9Gn6W/f9Ys7rTM
	 qO2/9wayHyPgJpwsMytD0OoVHUTcoG3dMZcBOM2aA+m3JHvIsXD7MhbpgkZuvm7acm
	 j2rHV5pZ/T3VXJd4i2izzQQCxmiFVRDaVdB7OZe9TZLry2GqCDOrNzqm2nJ80xwP2s
	 wAoDWcGufnXOZ256Kh8z0LJKQGcOPT5QDGjVHhi7gH7/RLVmlhMO6Hwg57aH0xumPi
	 Jv7UrV2MSwFkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/9] selftests/livepatch: Add provides/obsoletes
 test scenarios
Reply-To: sashiko-reviews@lists.linux.dev
To: jikos@kernel.org, "Yafang Shao" <laoar.shao@gmail.com>, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, jpoimboe@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20260930030323.14396-8-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-8-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:13:58 +0000
Message-Id: <20260930031358.8C7611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: comment mismatch in obsoletes test
--

commit b0b3364b7d14143d4a32c2c1ce9eaf4a8c23c322
Author: Yafang Shao <laoar.shao@gmail.com>

selftests/livepatch: Add provides/obsoletes test scenarios

This commit adds test scenarios for the new provides/obsoletes livepatch
mechanism, verifying various replacement semantics. The tests are skipped
on kernels that only support the legacy "replace" attribute.

> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh=
 b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> new file mode 100755
> index 0000000000000..a1c0ebb9ed44e
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh

[ ... ]

> +# - load a livepatch with provides=3D2 and obsoletes=3D[1] (cmdline),
> +#   then another with provides=3D1 (meminfo). Although the second patch

[Severity: Low]
Does this block comment swap the module names?

The text says cmdline is loaded with obsoletes=3D[1] and meminfo is loaded
second. However, as noted later in this same comment block and in the test
implementation below, MOD_MEMINFO is loaded first with obsoletes=3D1 and
MOD_CMDLINE is loaded second. This is functionally necessary because
test_klp_cmdline_lp.c does not declare an obsoletes module parameter.

> +#   does not list provides=3D2 in its own obsoletes list, it still
> +#   replaces the first one, because the obsoletes relationship is
> +#   symmetric: the first patch's obsoletes list contains the second
> +#   patch's provides id.
> +# - verify the provides sysfs value of the replacing patch
> +# - unload the remaining livepatch
> +#
> +#   MOD_MEMINFO(provides=3D2, obsoletes=3D[1])  -- loaded first
> +#   MOD_CMDLINE(provides=3D1)              -- loaded second, replaces ab=
ove
> +
> +start_test "symmetric obsoletes replaces"
> +
> +load_lp $MOD_MEMINFO provides=3D2 obsoletes=3D1
> +load_lp $MOD_CMDLINE provides=3D1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930030323.1439=
6-1-laoar.shao@gmail.com?part=3D7
