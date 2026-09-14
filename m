Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5133ADBA
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418918; cv=none; b=gyvtYbJwShJCgo/mYH6YqouPI9xPL3a1aP69dCByZwMKS+lZ5rh7XHggVqnYUu36WzFwojS1IEcqN9xwTZdYa+jKaTH4ZbXZql+eoaNTx0FkkyIRyZDCwfoYZb0V7FgpdicGi2nIaqDXrh3LeudEKLuLTXN0dEqhzz0M+JQJtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418918; c=relaxed/simple;
	bh=mKh5gyL3KpI6B4m4WZcd8olIKysaKP6+IYHhbGb8nBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/cK5VK9EOwBVrLeHe0ubUG9FapDx9GSurP4QQBbIGzD7PU3aDRoMyFds1RRDr6qv03zTxlkSo+aoU+y8y1YnjSLcD4/L86Mj4+UDC6Uo6B2mzfWZWL2Aa0WySvD6zoH7hIJMBw5BPO21mb9VhrUiQyZK7dIyARMb8CTvkDioZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3SF63DH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3SF63DH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463ED1F00899
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418915;
	bh=czBR+cQ1E5vh1wX+8I9yM1HEnngW7GygXtp3+M0Vjy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R3SF63DHOREZfOPyl6XMbYpJwZaW2f8IdQOHhQ+78MemtQ7bZibZhvaebPsQ9V9c/
	 DbaR/Ugb7IfranIsA1+/wRezJuHo2iRE7tLk5hoz1s+o9T+3AII6jBa2hJrREgnaKk
	 l6SUqto6Aib/2Xnxf+bhIZHEiK8JAUveqmGszmr84nkYHFu94xdEAnDg5cKPsMJXdq
	 wQCYfBoo4XPdbb713aUf7esUf4do/GCFbXid5wzN1ewbQcM9FzGgKlXuvaRCeo6L5H
	 oIhB7/YY3d77hP/BFT+wXcHPZEXy3Lem1uPgeW8ZgMj1g1g2O/g3GTYj/k0Ma5rC5I
	 MkpLDwTqb35eQ==
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-912355b1bf6so180566d6.1
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 13:48:35 -0700 (PDT)
X-Gm-Message-State: AFuF++nyMR9Izpo8eexR4YMQE7W6PW1HPtV60L76UIOYeBspO5UUmI9p
	Cg16xRfUJhSOMnTWE8Wry1kZrVMCgmvW8mTlXqYPcz1LZBO2y4jmgBuxQT+sXGovRYUkeXo4mjk
	5VB0XxLQR4ogjslhAcr6adxCXViZUHho=
X-Received: by 2002:a05:620a:458b:b0:939:2b7c:34d1 with SMTP id
 af79cd13be357-93a34654781mr144877985a.15.1789418914479; Mon, 14 Sep 2026
 13:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-12-song@kernel.org>
 <20260914063904.C33151F000FF@smtp.kernel.org>
In-Reply-To: <20260914063904.C33151F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 13:48:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6GEEivdaF8==SSExPmqtOKeVY+W-bTrpvc8aqyxGkNZQ@mail.gmail.com>
X-Gm-Features: AcwNN1Unzg4JsGrtPWlmReEfo0cV3Uoeo2J-eRexAFScWxkF0JK_VpV1TJt02E8
Message-ID: <CAPhsuW6GEEivdaF8==SSExPmqtOKeVY+W-bTrpvc8aqyxGkNZQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/58] objtool: Forward toolchain variables to the klp
 test runner
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, peterz@infradead.org, 
	joe.lawrence@redhat.com, jpoimboe@kernel.org, puranjay@kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, kernel-team@meta.com, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:39=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Forwarding CC=3D'$(CC)' breaks LLVM cross-compilation because =
Clang target flags are omitted.
> - [Medium] Forwarding READELF forces the use of llvm-readelf under LLVM=
=3D1, which explicitly violates test suite assertions.
> --
>
> commit be049d84a50dfed10ff53ea94f5daa93c75008b3
> Author: Joe Lawrence <joe.lawrence@redhat.com>
> Subject: objtool: Forward toolchain variables to the klp test runner
>
> This commit forwards toolchain variables from the objtool Makefile to the
> klp test runner script. This ensures that the tests use the intended comp=
iler
> and tools, especially when specific toolchains are selected via environme=
nt
> variables like LLVM=3D1.
>
> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -153,6 +153,7 @@ mrproper: clean
> >
> >  tests: $(OBJTOOL)
> >       $(Q)OBJTOOL=3D$(abspath $(OBJTOOL)) ARCH=3D$(ARCH) CROSS_COMPILE=
=3D$(CROSS_COMPILE) \
> > +             CC=3D'$(CC)' LD=3D'$(LD)' READELF=3D'$(READELF)' OBJCOPY=
=3D'$(OBJCOPY)' \
>
> [Severity: Medium]
> When cross-compiling with LLVM=3D1, does forwarding CC like this drop the=
 Clang
> target flags (such as --target=3Daarch64-linux-gnu) normally passed via
> CLANG_CROSS_FLAGS?
>
> The top-level build sets CC to clang and passes target flags separately.
> Because only CC is forwarded here, the test script runs clang without any
> target flags and builds test fixtures for the host architecture instead.
>
> This mismatch is then caught in tools/objtool/tests/lib.sh during
> klp_preflight(), which bails out when it detects that the objects target
> a different architecture:
>
> tools/objtool/tests/lib.sh:klp_preflight()
>         "$OBJTOOL" klp checksum "$tmp/probe.o" >/dev/null 2>&1 ||
>         { rm -rf "$tmp"
>           bail "objtool rejects an object built by '$CC'; they target" \
>                "different architectures (set CROSS_COMPILE, or" \
>                "--target=3D for clang)"; }
>
>
> [Severity: Medium]
> Will forwarding READELF break the test suite parsing when LLVM=3D1 is use=
d?
>
> The script tools/objtool/tests/lib.sh explicitly documents that it requir=
es
> GNU readelf because llvm-readelf spaces columns differently, which breaks=
 the
> test assertions:
>
> tools/objtool/tests/lib.sh:
> # readelf reads any target, so it rarely needs overriding -- and it must =
stay
> # GNU readelf, whose column layout the assertions parse; llvm-readelf spa=
ces
> # them differently.
>
> Forwarding READELF forces llvm-readelf into the script environment under
> LLVM=3D1, which appears to violate this documented test framework constra=
int.
>
> >               KEEP=3D$(KEEP) $(srctree)/tools/objtool/tests/run-tests.s=
h
> >
> >  FORCE:

Fixed both in v3.

Thanks,
Song
