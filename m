Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EF38DD3
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430718; cv=none; b=s1OB0WUGc5YwelU27Va6YTpQOWgZ5oRnFF+1OZhczdvVroG/I21ildCIT+njlOnEDxr/c4vSCsHhvNHL7lAsX2gOucRBm0c4+CuwOADEBHyIoK7Ansudgb9YP9iXIuyGIodCvu1zZckKSk+kqiGa9b9ILv1vqZFeyBZE3YEAzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430718; c=relaxed/simple;
	bh=bSghgY1Hve9JqNltRdN9nfQmfgwuNLg06aCvOC1CDIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMQS1idPv8ZJkeWIuGVmGvZ4eqwqI3fFT4Dcum4O+B8RKVKv6nloOdaKZFjpDuxjh9in9OdoTqEx7KJJGHoACWbqWcYbgdDwKQdps13+rZg0lSPpyhZHExWU9HGUBusf1VSUe+dUhl4HCu5rfSHERQDB9Uc8oxAEd0EDQmzTb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atUBLQlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atUBLQlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B341F000FF;
	Tue, 15 Sep 2026 00:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789430716;
	bh=yLVXfTdGP5QPL1Tyz8PyLY8iyN8aBT6RRxIDoFJaa+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atUBLQlPnzvp7poTUysKNSorNCgElDRRd5buceUXfSeSARGOujJfRSMITotDOVVHS
	 9/8P2TUqSn8PxzOlBz/WSTjcT/jjOg6S6a9Q4N9jvEuIO/gfzfHFL4h/LyhshMBeh4
	 jukZ9oepq8X66Bk2rI0mDyZFe0d1x/ectCi/GsbASIHYmeueV1CcmqX56Z3vd+eD2O
	 YBphYDNLO34L5klmGFCzOMuJvoc1FUWk2NvKB3Uko7A6FWfN/i+XDd4Y6UvKnmVbyL
	 jnwDz58PwR9nMe27EOozwDwRySDPxC1AQtNe08Rq44yQ/JFwh2SN69mwS8FFiWrLIg
	 cIFbX0WWBdyrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/58] objtool/klp: Add test for rejecting
 module-owned static call keys
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jikos@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, puranjay@kernel.org, kernel-team@meta.com
In-Reply-To: <20260914230355.3422996-22-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-22-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:05:15 +0000
Message-Id: <20260915000515.B4B341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] objtool/klp test: manual .static_call_sites generation violates tes=
t design
- [Low] objtool/klp test: test-static-call-module-key.sh misses validation =
assertions
--

commit 07aa87afa035746af6f6fbcdd7b1840b00a88b3e
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for rejecting module-owned static call keys

This patch adds a test to verify that klp diff correctly accepts vmlinux-ow=
ned
static call keys and rejects module-owned ones. It introduces a C fixture
implementing the static call site and a bash script to test both paths.

> diff --git a/tools/objtool/tests/generic/fixtures/static_call.c b/tools/o=
bjtool/tests/generic/fixtures/static_call.c
> index 0000000000000..5975986c92eb0
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/static_call.c
[ ... ]
> @@ -0,0 +1,53 @@
[ ... ]
> +int target(int x)
> +{
> +#if defined(NEW_CALL) && !defined(PATCHED)
> +	/* The original has no static call at all. */
> +	return x + 1;
> +#else
> +	__asm__ volatile(
> +		"1:	nop\n\t"
> +		".pushsection	.static_call_sites, \"aw\"\n\t"

[Severity: Low]
Does this manual instantiation of the static_call_sites section bypass objt=
ool's
check generation?

According to klp-write-tests.txt documentation, tests should not hand-write
what objtool generates. This creates a synthetic edge case that artificially
omits sh_entsize and adds .discard.annotate_data boundaries, which might not
reflect how production objects are built.

> +		".balign	8\n\t"
> +		"912:\n\t"
[ ... ]
> diff --git a/tools/objtool/tests/generic/test-static-call-module-key.sh b=
/tools/objtool/tests/generic/test-static-call-module-key.sh
> index 0000000000000..9ab373e90e10e
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-static-call-module-key.sh
[ ... ]
> @@ -0,0 +1,25 @@
[ ... ]
> +setup
> +build_pair static_call.c
> +
> +has_input_section orig.o .static_call_sites ||
> +	probe_skip "fixture produced no .static_call_sites on this arch"
> +
> +run_diff
> +assert_patched target

[Severity: Low]
Does this successfully verify that the section was extracted and patched?

Without a check like assert_section .static_call_sites, this test might pass
vacuously if klp diff silently drops the static call section.

> +
> +rm -f "$workdir/out.o"
> +build_pair static_call.c -DMODNAME=3D'"klp_testmod"'
> +run_diff 255
> +
> +diff_log | grep -q 'unsupported static call key __SCK__klp_test_call' ||
> +	fail "expected rejection, got: $(diff_log | tail -1)"
> +

[Severity: Low]
Should there be a check here to ensure the malformed output object wasn't
leaked?

Usually module rejection paths are validated with something like
[ -e "$workdir/out.o" ] && fail to ensure the file was not produced.

> +pass "module-owned static call key rejected, vmlinux-owned accepted"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D21
