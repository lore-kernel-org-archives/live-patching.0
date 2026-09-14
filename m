Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F939B4A5
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428868; cv=none; b=izdR8MILvpKPGh2d8/vsThi6loJd/ANhR46haxK/lkGftciNz8Ik9hEa2HgMVGF1MTA/YmYsUrM5qMC6evFpihg55zcJ2VWRntc1wOApKwxo48GsDc7/QIfKGE8mTZDEFtkaox9Qlmkqec5yyJ9qbDNAmdgiTNFIP98V7UxZKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428868; c=relaxed/simple;
	bh=Z/R3BhsoXNlly1HMVUPryjDpv3ZK2rRa2cU5EKyYY7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbsC1xITgiyJ85z0dZBg4qEtwxTPWyVB7yISsOO1DWUMicNCz3ny2FDSC6AoYdbRy9NhynEXZHqolCvaXUNSPnOyTGOCoVdqZsurySrqMrANpPDZcLyQrvduL2VnZQQeap8s2Q3b8ymAupIIh7Kg6XqvT4vSmEwgy9MR2Kg8NOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onpwp/HM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onpwp/HM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96CE1F000FF;
	Mon, 14 Sep 2026 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428867;
	bh=hNmteMedIXzoMVj/a8SoGh2F5V+SisT5XoTZ8BdV44g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Onpwp/HMUAXw22ryR08AZPmgl/jE4uAwthj39kuuOjf/TVCZk0IpmQuj2uvtK4BSb
	 nAovGVVXiWYGrMCO47lYdS7XZBcXPQ90Wmqt9AiKte5ScxZqAiaxf48ABReOp3Is0C
	 OBxV0/8ug4O8RdeTrbXKtIakE//uq23moQkzP6A+j/UzqrCYzL85WKprrOEvWcp8Yg
	 xy5LwAm/i444OFJ5YkswTtmUFPG/vighOku5QVr/RTyWgQFeYzXNM8nAvPavbmnqUP
	 J6LDlIEzlxs9bsLuKPVqfxYqdTlRnCCUnDY+gBqzCICxj9l+6RcFei+QZdeoiVPKZz
	 yUyczwgmEeTOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/58] objtool/klp: Build klp test fixtures through
 the harness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: mbenes@suse.cz, jpoimboe@kernel.org, puranjay@kernel.org, kernel-team@meta.com, pmladek@suse.com, peterz@infradead.org, joe.lawrence@redhat.com, jikos@kernel.org
In-Reply-To: <20260914230355.3422996-6-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-6-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:34:26 +0000
Message-Id: <20260914233426.D96CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool: test harness leaks vmlinux.o state across build_pair() =
calls
--

commit 87b920426dfa2a217d6f9104d0f701cab5d67f5e
Author: Song Liu <song@kernel.org>

objtool/klp: Build klp test fixtures through the harness

This patch standardizes how klp test fixtures are built by shifting the
compile steps into harness helpers like build_one() and build_pair(). It
also establishes make_vmlinux_pair() to correctly build and diff vmlinux
images for tests.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index efe0a71326799..35be42758ece8 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> @@ -179,6 +192,13 @@ setup()
>  	workdir=3D"$(mktemp -d)" || fail "mktemp failed"
>  	trap cleanup EXIT
> =20
> +	# A test may run several segments, and make_vmlinux_pair() repoints
> +	# orig_obj at the image it builds.  Start each segment from the
> +	# defaults, or the next build_pair() diffs the previous segment's
> +	# object against the new one.
> +	orig_obj=3Dorig.o
> +	patched_obj=3Dpatched.o
> +
>  	export_syms "$@"
>  }

[Severity: Medium]
Since setup() only executes once during script initialization, doesn't this
fail to reset the state between test segments?

If a test calls make_vmlinux_pair() (which repoints orig_obj to vmlinux.o)
and subsequently calls build_pair() for a new segment, orig_obj will still
point to the stale vmlinux.o from the previous segment instead of orig.o.
This appears to cause run_diff() to evaluate the wrong file.

[ ... ]
>  # build_pair <fixture.c> [cflags...]
>  build_pair()
>  {
> -	local fixture=3D"$FIXTURES_DIR/$1"; shift
> +	local fixture=3D"$1"; shift
> =20
> -	[ -f "$fixture" ] || fail "missing fixture $fixture"
> +	build_one "$fixture" orig.o "$@"
> +	build_one "$fixture" patched.o "$@" -DPATCHED
> +}

[Severity: Medium]
Should the state reset logic for orig_obj and patched_obj be placed here in
build_pair() instead of setup(), to ensure run_diff() evaluates the correct
objects when multiple segments are executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D5
