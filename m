Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C683F1075
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154309; cv=none; b=uMlap2n9bzO42GafguyR+69AZWtkHTj+ResnfprNOTRBJgCGZP6lDvWV712fhuhNKYhGG1AbpunO5wyKgXD5p1zepFjGTkBTbQKV92TnZJhtUYstuwMVL6ugKCyD/HNfanProhSftmgMCidqA0+wBVzbTdTw8gdGGa46tVfWHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154309; c=relaxed/simple;
	bh=RKx0DXS42tWX5gA4nxN3zuTQ5Bmf4m+ba8Tn7XcabCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5soZUn0myhbL9+WnQEQR149gdaNEzaeOmES4Et3INEbwZL42rUjJBQ+UZly+x3KiVsL0KcbELpCBJJDw2pN1mRpffQcmGYkar7zqe/LGNqSdfECtkrUYs1jgcODVOpygfZr/rJsXg0CwfIqzC75OlSiivUEkSm6ehvGP2MZUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKPu8fjK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKPu8fjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AB61F000FF;
	Fri, 11 Sep 2026 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154301;
	bh=Uh+/kqnyS8vHLeo30AzH5wkr5wBz+vUiYl3/giXIORE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nKPu8fjKJclMlInOnoqPayczTAdyILnC5jN0ZqdeMhMS2U5UtNo0rzFpSGexS5ZCS
	 8750hJyPISD1Ekqstf1Y9mqBWOn4O4eg5gQqdtFwIWo8iuJHaeIgBW9KxqbXsVoMbW
	 RaehwN83EjeFSp5lOgGXvADEly3kl/HodNImjfmg7TNDofkgHsKopqwccGljD0E8q8
	 cdj1U01Yw6URQoubLU0GSH1i3hh7toT9Qpw0taC7Uk2Kg0Dpu8M8WVpwpj2WUoegkg
	 T3eBDkf/Kfyz+P4Nh/2JqUHGwVnYwpvCtyeWoa6dSJJxhj3P+p2u8vz9o2aImVvhC/
	 u/KvysncffDaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/58] objtool/klp: Add test for rejecting references to
 init code/data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, kernel-team@meta.com, puranjay@kernel.org, mbenes@suse.cz, jikos@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, pmladek@suse.com
In-Reply-To: <20260911184305.1457308-24-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-24-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:18:20 +0000
Message-Id: <20260911191820.89AB61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The test fixture `init_reference.c` defines `init_only` as a `st=
atic` variable that is never written to, which allows the compiler to fold =
its read into a constant. This prevents the expected relocation from being =
emitted, breaking the test.

Pre-existing issues:
- [High] `objtool klp` fails to reject references to exported init symbols =
because `klp_find_sympos()` (which enforces the init check) is completely b=
ypassed for exports.
--

commit 89481f125a4328fb499128f2365603f31f38782d
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for rejecting references to init code/data

This commit introduces a new test fixture and script to ensure objtool's
klp mode correctly rejects livepatches that reference init code or data.

> diff --git a/tools/objtool/tests/generic/fixtures/init_reference.c b/tool=
s/objtool/tests/generic/fixtures/init_reference.c
> new file mode 100644
> index 0000000000000..51b2a57dde14f
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/init_reference.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Patched function referencing data in an .init section. */
> +
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) =3D "\0name=3Dvm=
linux";
> +
> +static int init_only __attribute__((section(".init.data"), used)) =3D 5;
> +
> +int target(int x)
> +{
> +#ifdef PATCHED
> +	return x + init_only + 1;

[Severity: Medium]
Since init_only is declared static and is never written to, won't the
compiler optimize its reads in target() via constant folding?

If the compiler replaces the read with the literal 5, no relocation to
the .init.data section will be emitted in the resulting object file. Does
this missing relocation prevent objtool klp from detecting the reference,
causing the test to silently fail its intended validation?

> +#else
> +	return x + init_only;
> +#endif
> +}
> diff --git a/tools/objtool/tests/generic/test-init-reference.sh b/tools/o=
bjtool/tests/generic/test-init-reference.sh
> new file mode 100755
> index 0000000000000..8bf4b98bf4585
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-init-reference.sh

[ ... ]

> +setup
> +build_pair init_reference.c
> +run_diff 255
> +
> +diff_log | grep -q "can't patch or reference init code/data" ||

[Severity: High]
This is a pre-existing issue, but while reviewing this test, I noticed that
the safety check it validates can be completely bypassed for exported symbo=
ls.

In tools/objtool/klp-diff.c:clone_reloc_klp(), the branch handling exports
bypasses klp_find_sympos():

        if (export) {
                sym_modname =3D export->mod;
                sym_orig_name =3D export->sym;
                sympos =3D 0;
        } else {
                ...
                sympos =3D klp_find_sympos(e->orig, patched_sym->twin);
        }

Because is_init_sym() is only checked inside klp_find_sympos(), objtool klp
will silently accept livepatches referencing exported .init code or data.

Does this gap in validation allow a livepatch to execute freed memory or
cause a use-after-free at runtime if it references an exported init symbol?

> +	fail "expected rejection, got: $(diff_log | tail -1)"
> +
> +pass "reference to init data rejected"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D23
