Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730882D7380
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367946; cv=none; b=jOB0yuqZMOM6K5bsx7U31WxIgzChSAJPTr3bdSXkVjRgApJYTX6UtHcSJHnccHcFJT3XodrsfBdoqMEb9zKuQOww+e0aCFWvR1l0OS9o4daNf08+u3lb00R9e6iAtcp4IuOnm+PWbAxpUqShEllseWp0TB5VpLyvJS6QkwkkZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367946; c=relaxed/simple;
	bh=GBfozdjRONvXtPq9ZtXxmc6PCH05niunscvFNDg6IkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aXFSamFxfTlD3bndyVOK5iqhIsHR1gKxFCr23PKQu83/SU3wzaixZjDWey9X6fmVFBBUrzVJ+eCuR2Q13JxYx4E5CNcnCAFeOtu4ONTVFGIgrP2LsRJ6BxtcVov8Q8bT4HLo/oP/qj+1fhCFA91zezzccirgkLNLqt8vu+AD0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqL6e5fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqL6e5fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33151F000FF;
	Mon, 14 Sep 2026 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367945;
	bh=XDNhdvuOraVs4TN86mYglEG/Lzk79Hc+UuriRacdJ9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqL6e5fsT0YJWFfQf3PGG3vWtodOoMYMNQCxZlMirNL7mrLNJ8QoQL/ipByCDwFaR
	 VjXsBr1QSpBO+GvJQlHKPbEz9EHG2Mh3WuYzgbZob83F1B1SYmDFH/BfNOG+gV3XU8
	 A88RuHGaKroAt7pIAP4TBzUbuYFPrdhnKitpJWhYQuG8NDAfVWUUGsyjQsL+Cwbcc5
	 ED1DhOXd8mVzrAPNhvevRf0/fAHZiJA/xcO4bJYmLSGF/Hck+sJKaGqQfrc1Q01uZi
	 h0PuzSDVh+Uz+72WrVIwEhGRmcMd2zmsvH65OgOvi6yQ07s6ygcfNImbHHrK2UtJ2C
	 YUXThpqDJo8Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/58] objtool: Forward toolchain variables to the
 klp test runner
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: peterz@infradead.org, joe.lawrence@redhat.com, jpoimboe@kernel.org, puranjay@kernel.org, jikos@kernel.org, mbenes@suse.cz, kernel-team@meta.com, pmladek@suse.com
In-Reply-To: <20260914062514.926997-12-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-12-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:39:04 +0000
Message-Id: <20260914063904.C33151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Forwarding CC=3D'$(CC)' breaks LLVM cross-compilation because Cl=
ang target flags are omitted.
- [Medium] Forwarding READELF forces the use of llvm-readelf under LLVM=3D1=
, which explicitly violates test suite assertions.
--

commit be049d84a50dfed10ff53ea94f5daa93c75008b3
Author: Joe Lawrence <joe.lawrence@redhat.com>
Subject: objtool: Forward toolchain variables to the klp test runner

This commit forwards toolchain variables from the objtool Makefile to the
klp test runner script. This ensures that the tests use the intended compil=
er
and tools, especially when specific toolchains are selected via environment
variables like LLVM=3D1.

> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -153,6 +153,7 @@ mrproper: clean
> =20
>  tests: $(OBJTOOL)
>  	$(Q)OBJTOOL=3D$(abspath $(OBJTOOL)) ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CR=
OSS_COMPILE) \
> +		CC=3D'$(CC)' LD=3D'$(LD)' READELF=3D'$(READELF)' OBJCOPY=3D'$(OBJCOPY)=
' \

[Severity: Medium]
When cross-compiling with LLVM=3D1, does forwarding CC like this drop the C=
lang
target flags (such as --target=3Daarch64-linux-gnu) normally passed via
CLANG_CROSS_FLAGS?

The top-level build sets CC to clang and passes target flags separately.
Because only CC is forwarded here, the test script runs clang without any
target flags and builds test fixtures for the host architecture instead.

This mismatch is then caught in tools/objtool/tests/lib.sh during
klp_preflight(), which bails out when it detects that the objects target
a different architecture:

tools/objtool/tests/lib.sh:klp_preflight()
	"$OBJTOOL" klp checksum "$tmp/probe.o" >/dev/null 2>&1 ||
	{ rm -rf "$tmp"
	  bail "objtool rejects an object built by '$CC'; they target" \
	       "different architectures (set CROSS_COMPILE, or" \
	       "--target=3D for clang)"; }


[Severity: Medium]
Will forwarding READELF break the test suite parsing when LLVM=3D1 is used?

The script tools/objtool/tests/lib.sh explicitly documents that it requires
GNU readelf because llvm-readelf spaces columns differently, which breaks t=
he
test assertions:

tools/objtool/tests/lib.sh:
# readelf reads any target, so it rarely needs overriding -- and it must st=
ay
# GNU readelf, whose column layout the assertions parse; llvm-readelf spaces
# them differently.

Forwarding READELF forces llvm-readelf into the script environment under
LLVM=3D1, which appears to violate this documented test framework constrain=
t.

>  		KEEP=3D$(KEEP) $(srctree)/tools/objtool/tests/run-tests.sh
> =20
>  FORCE:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D11
