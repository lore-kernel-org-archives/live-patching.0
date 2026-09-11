Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C13FA5C8
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154484; cv=none; b=UIMN8gu5RCb6RNDIAotrx7G3+krSI5zoq4DSfsANle2uqGdgX2RGmhvDTvmvQNeoBtRqcSXpzDHfRagiwjQVTDZqglhUuYsg+9aTjc2eT/6Q+nkbPo4jFq7VyqbEiCPRTQee4y3OTw2cWwxJHXMUb9hbE/q/nS26Cg5QtXDHevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154484; c=relaxed/simple;
	bh=msYJGJqCr/5eUU54SlvJZ1GnYLQrRX5/GKBdVRebrzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eiuFypKw2t/0XWs2P4eRWayRa5OvBMlghPWSf5S7c6rKQ+FWOj2I+WiJ4EziywSINKoTbAhd9NG6GXNSivp+LLY6v6RwFrKv9uBEd30Xju84o9kOosNELph/uxAlqikRDZlXwvmVcwQiHbqm+JYcEtr7+yzNPk6fhRi9P56b6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlYg6/ZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlYg6/ZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17971F000FF;
	Fri, 11 Sep 2026 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154473;
	bh=wJBDsAacMnYsoezXWnzel+gcnG+z/bt/5gpiOLFVIUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlYg6/ZYm8/tD+cSUEF8DIdbKMxXB+h/KmGLTNMA4QQYel5f17rM7QDemKI2TPaoZ
	 KDhJSL6YCBqlypjtEN6xxDZct+llIXrQZdoJ9eDzy2mIIxyFigSZKcz4XUwS52A48F
	 y56fGU+HdkwIXm5gd9USgHom2WMzIFXIvqGHAvxa1wmuJKYz8iNnhxCnXkZ6dBtcq+
	 a+/UAYt26SFRCpLfqEbGtv8GpYuoDPi28BIOQzKDaod9AC6r/zMJGWQtRqtOyNZQfW
	 Y3/ir8JiLuWOnl5UdYmmmOo//gW53ZKo+zYl52wLoJfWeW4KvQnaaIouLW/mhT5FOD
	 OjptC7k7+3fug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 41/58] objtool/klp: Add test for kCFI prefix symbols and
 traps
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: peterz@infradead.org, jpoimboe@kernel.org, jikos@kernel.org, joe.lawrence@redhat.com, mbenes@suse.cz, puranjay@kernel.org, kernel-team@meta.com, pmladek@suse.com
In-Reply-To: <20260911185031.1534046-16-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-16-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:21:12 +0000
Message-Id: <20260911192112.A17971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The compiler may optimize away the indirect call in `target()`, whi=
ch would eliminate the expected `.kcfi_traps` entry and break the test on n=
ewer or more aggressive Clang versions.
--

commit ab08ca5f9689c4205bf1341ad94b14e2747fd94b
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for kCFI prefix symbols and traps

This commit adds a test case to verify that the __cfi_<func> prefix symbol
and its .kcfi_traps entry are correctly handled and carried into a patch for
kCFI-enabled builds.

> diff --git a/tools/objtool/tests/x86/fixtures/kcfi.c b/tools/objtool/test=
s/x86/fixtures/kcfi.c
> new file mode 100644
> index 0000000000000..52cbb0fe6df2a
> --- /dev/null
> +++ b/tools/objtool/tests/x86/fixtures/kcfi.c

[ ... ]

> +int (*pick(int x))(int)
> +{
> +	return (x & 1) ? impl_a : impl_b;
> +}

[Severity: Low]
Will the compiler aggressively inline this function into target()?

Lacking a noinline attribute, this function can be fully inlined, exposing =
the
function pointers for devirtualization.

> +
> +int target(int x)
> +{
> +	int (*fn)(int arg) =3D pick(x);
> +
> +#ifdef PATCHED
> +	return fn(x) + 2;

[Severity: Low]
Could aggressive compiler optimizations devirtualize this indirect call?

The indirect call fn(x) relies on pick() and its targets not being inlined =
to
remain an indirect call in the final object code. If devirtualized, the
expected .kcfi_traps entry would be removed, potentially causing the test to
spuriously fail on newer or more aggressive Clang versions.

> +#else
> +	return fn(x) + 1;
> +#endif
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D41
