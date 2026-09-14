Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BD3254B8
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368426; cv=none; b=eErGX55WjlOdk2EOVIp9gzY1VsGOEZHluiA8rvX+bZzYF+jtadfLOzp7SqOFf4XPyPPFW7YwYkt3HC6fYphCKzZg3d+Ov1k3hWOTSyL04eB08Z2jjbqCtdKS4QPuxJb7pJMnFl6/hO82tuUemlNFS1Z73DKPMsYwT01HRXB5swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368426; c=relaxed/simple;
	bh=3oEemN8sGbQ0cFs9VSM57z6brQuoSZD95a6TeFgxfwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DlUyDnmG9aL8bq2nEjqFetUxdwRMopXbUG+2b4OcIAPCye+njIt/i565vRFDUtPpR3+/ns6GfRq/sGhDV0LHV2DLsRGoUxjAhiGuZv2JqOinwaWRMT3onRpxJeGKjb8YdVbEpr9udnpWpIoewtz7COhSZNoNjfgDODUxkKJ4Qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTXYY4pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTXYY4pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4B1F000FF;
	Mon, 14 Sep 2026 06:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368425;
	bh=7kZFwCFgahOUMPYGps1M5BWo5NlBp9DtWwLSKtRSsaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTXYY4pecGFn4RUZ3BLvP27QF+fZJcsEgv6lKNigxU5MGSp5R/NxjnXmkScd7qlQI
	 wOgJvxCmMWhiwIT3mmbfh+URb0z+ugB9/xN+SFFKDDHN+gqrC/cKQM+8qGS58FkwV0
	 bxAHj70wPWGQxypUVf8xP8RVW5a13dGFYkCKVZegOuOMllKRqoOq7rbFpEa+C2hU8o
	 lR9GyqE/XrVbAQnIQK6agf9OkqG8xvcM9PY4imE4/rW2e5OAapENbCtaLFl/civnsB
	 EInvOF2DWeQBX2K3swDrJFV8K8mOugU46eQoBo/jRxbSrddppk/9ePNjd0Ut77IOIu
	 zus/lbYlCHgfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 42/58] objtool/klp: Add test for symbols whose
 linkage the patch changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org, kernel-team@meta.com, jikos@kernel.org, mbenes@suse.cz, puranjay@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, peterz@infradead.org
In-Reply-To: <20260914062514.926997-43-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-43-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:47:04 +0000
Message-Id: <20260914064704.77F4B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test fixture sanity checks for LOCAL symbol binding will produce=
 false positives on newer binutils.
--

commit e2b339e9e0066c89f1967f8ca7015610df269518
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for symbols whose linkage the patch changes

A patch can move a symbol between static and global without renaming it:
dropping "static" from a helper so something else can call it, or adding it
to one that is no longer shared.  Correlation keys off more than the name,
so a symbol whose binding moved has to still pair with itself.

> diff --git a/tools/objtool/tests/generic/test-local-to-global-flip.sh b/t=
ools/objtool/tests/generic/test-local-to-global-flip.sh
> new file mode 100755
> index 0000000000000..b4dca6cff0f2d
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-local-to-global-flip.sh
[ ... ]
> +setup
> +build_pair local_to_global.c
> +
> +# Confirm the fixture really moved the bindings, in both directions.
> +in_symbols orig.o    | grep -qE 'LOCAL.*flipped_up' ||
> +	fail "flipped_up is not local in the original"

[Severity: Medium]
Since this test fixture is compiled with -ffunction-sections and
-fdata-sections (as enforced by FIXTURE_CFLAGS), dedicated sections like
.text.flipped_up are created.

On newer binutils, readelf -s includes the section name for section symbols,
which always have LOCAL binding.

Does grep -qE 'LOCAL.*flipped_up' inadvertently match the section symbol
instead of verifying the actual function symbol's binding? Could this result
in a false positive that masks potential test fixture breakages if the symb=
ol
is actually GLOBAL?

> +in_symbols patched.o | grep -qE 'GLOBAL.*flipped_up' ||
> +	fail "flipped_up is not global in the patched object"
> +in_symbols orig.o    | grep -qE 'GLOBAL.*flipped_down' ||
> +	fail "flipped_down is not global in the original"
> +in_symbols patched.o | grep -qE 'LOCAL.*flipped_down' ||
> +	fail "flipped_down is not local in the patched object"

[Severity: Medium]
Similarly here, could 'LOCAL.*flipped_down' accidentally match the section
symbol for .data.flipped_down instead of verifying the variable's binding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D42
