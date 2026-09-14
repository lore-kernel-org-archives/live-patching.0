Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B443CCFB4
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429581; cv=none; b=sM1Q+RUDStq6m044mJDdJtKW2YluD5AQ4YMdR5NF42ikyN4kfZUxuxw2+tCWDgIDz3De4kHN90RfLtzlbzTAf2BIOJW4dUczzl5BVC1Td0V1NDsq0YofLgHJ0bagFU/4ww/lWJD4L/QtEJSaiWyij3aYN/f45pJ0G7njTZzvSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429581; c=relaxed/simple;
	bh=KHFf9WXKsXuBfEwwKXPlw6zIMbYpCF3oWgrl/WpaMIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H9+ygvUmrIUkT3neOqSvePLwT98+tzHn4P69JJyjOOTBymCKH7BThpQUiVWkueyh2a2yWMU7QPIwgxX5xfVUDNtwz6CUqlnfmFV6YyOu55LCM2WWNsoQ7OS0LSKg0fE10ajnhdyWYNwL9y6tBpNhC+5jGNicS5zFpyU/VrOfjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqeX99mZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqeX99mZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122791F000FF;
	Mon, 14 Sep 2026 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429580;
	bh=/sfcR+xM1YkF9GHrSHeRRk7hlJnc4EAEq/HLcXkcGnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqeX99mZtph4SkNfwBPMMENP7imCpOf0KXcHaDqZ3w6yCO/4tL88hlIZQiWiCTpee
	 lTDIe5iNbZADr5VFwNadRHK0gROnbC5cYaguFaBHcs1ruIgZB4k/Rl5ykiCidA2hqG
	 Ki2llkTcYgI0H+WviiqiqgM5CcWLm4WrO3DWberopFg2t9OzdfhNE16v47S/u7K5Fz
	 S/dVYE6e9DJ4kvUrYmdTDlO9ix3tWp0i2coPiCrv8Wbg2wzK/3SAgrVC5P5zlIoPZY
	 IWt8NSnH0zlx27nv0cmvhPbTkvRGDVE0TA0so+21Hxp/FJJncJ6jkNkMsWRro5T+Ia
	 nDF/0sOWMznbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/58] objtool/klp: Add test for newly introduced
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: pmladek@suse.com, peterz@infradead.org, joe.lawrence@redhat.com, jikos@kernel.org, jpoimboe@kernel.org, puranjay@kernel.org, kernel-team@meta.com, mbenes@suse.cz
In-Reply-To: <20260914230355.3422996-15-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-15-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:46:19 +0000
Message-Id: <20260914234620.122791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/objtool: fragile symbol check matches section names
--

commit da3ad59507d5d910ed876f2401fd7f2746140303
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for newly introduced functions

A function added by the patch has no original to correlate against, and
still has to be carried into the livepatch or the changed caller ends up
referencing something which does not exist.

> diff --git a/tools/objtool/tests/generic/test-new-function.sh b/tools/obj=
tool/tests/generic/test-new-function.sh
> new file mode 100755
> index 0000000000000..17af18545b7de
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-new-function.sh
> @@ -0,0 +1,17 @@

[ ... ]

> +setup
> +build_pair new_function.c
> +run_diff
> +
> +assert_patched target
> +out_symbols | grep -q 'klp_new_helper' ||
> +	fail "new function was not carried into the patch"

[Severity: Medium]
Will this grep check falsely pass on newer versions of binutils?

It seems `grep -q 'klp_new_helper'` matches substrings, and newer versions =
of
binutils print section names (e.g., `.text.klp_new_helper`) in `readelf -s`
output. This could cause the test to erroneously pass if the section symbol
is present but the actual function symbol is missing.

Could this be updated to use the robust `assert_symbol` helper provided by
the test framework rather than directly grepping `out_symbols`?

> +
> +pass "new function carried into the patch with its caller"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D14
