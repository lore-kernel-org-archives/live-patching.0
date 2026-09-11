Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CA38E11A
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154525; cv=none; b=mkab7XPkT9YGGvRn3HdiMVc6A0yP5gRd8gt7M6R8ajtttEwqrSTlFAKX3rblSy4aYWHxe4c2NEVVSwLNjov1FQbEcy0x1HOzpI/RIgNhpeAonzCkw4Fg0FMM9MrmjTVEARnG7UHr5JEPS68QcgkxS/l9IrQmRACLM6cxKG/RWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154525; c=relaxed/simple;
	bh=tZSsw9U+jurkMl6oEb4efV30/GD7HDfeICWLXWjLd54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QsIa32RyEvq5FeuWT6p/ZPABB45TAzAhjbBf9LMixyxCpz9VpeJiMaHT1dPmxOlwmEEKzpFEmQgNZHIPj5HgutuA6SFQTQFOoC6QOy0khp2Dv5x/3dkBL2RzkKP2+vBAQsdbI8mWDwFTWUvhSZMvPdbg9QqZzYveYJ9A5LQMh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKZccGqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKZccGqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2951F000FF;
	Fri, 11 Sep 2026 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154515;
	bh=cUmY+/fFM9tg2NjkjEqq/mlMuSRCJKvbpHgwfYtWlag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKZccGqwFslpQK8Mxo8M6nGnBlusXG9X6kTjGHEz48FGNYoBVCe1oUUqthXgclKSr
	 1kuVj7EOPe5sc212z+S5R7asv+ILPhWGBS2LVsLUva5iIkQbboud+O9hr5nXV3bV0y
	 7Oa1uvh+0AXB74+tQlOA4b6r9S240tj891kIT7k/Mf940cX4rk3Sht1XOoifvkVBbi
	 LLPK6kfbTU4SjbSycUuE+93O++29DZVm7Ml7ZyC9cpw9OT+iO8yfmFL5q/23JRnv+m
	 PKveBOtduVc9L/79DxSrc9SlpjcomWfmjgOyXQKb+vDS/8/8rwNvoxMpoCpRAH7hia
	 xDmUNk9qH1Gwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 37/58] objtool/klp: Add test for sympos in module
 objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: pmladek@suse.com, puranjay@kernel.org, kernel-team@meta.com, jikos@kernel.org, jpoimboe@kernel.org, mbenes@suse.cz, peterz@infradead.org, joe.lawrence@redhat.com
In-Reply-To: <20260911185031.1534046-12-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-12-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:21:54 +0000
Message-Id: <20260911192154.9B2951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `klp_find_sympos()` module path fails to filter undefined, unalloc=
ated, and .init symbols, leading to incorrect livepatch symbol resolution.
--

commit 27e67aed6ae8f7baebc0b3436a1ab04c5f011800
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for sympos in module objects

klp-sympos.c had no coverage at all.  sympos disambiguates same-named
symbols for livepatch, counting from 1, with 0 meaning the name is unique.
Resolving to the wrong one is not a load failure -- it is a patch quietly
wired to the wrong object.

> diff --git a/tools/objtool/tests/generic/test-sympos.sh b/tools/objtool/t=
ests/generic/test-sympos.sh
> new file mode 100755
> index 0000000000000..b71d4930a22af
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-sympos.sh
> @@ -0,0 +1,51 @@
[ ... ]
> +# sympos is what livepatch uses to tell duplicate symbol names apart in =
the
> +# patched object: which "dup_counter" of several the relocation means.  =
Get it
> +# wrong and the patch resolves to the wrong object at load time, silentl=
y.
> +#
> +# klp_find_sympos() reports 0 when a name is unique and a 1-based positi=
on when
> +# it is not, so both need checking -- always reporting a position, or ne=
ver,
> +# each looks right in one of the two cases.

[Severity: High]
This is a pre-existing issue, but does klp_find_sympos() correctly filter
out unallocated, undefined, or .init symbols when calculating the position?

Looking at tools/objtool/klp-sympos.c:klp_find_sympos(), it appears to count
all matching symbols without filtering:

	for_each_sym(elf, s) {
		if (!strcmp(s->name, sym->name)) {
			nr_matches++;
			if (s =3D=3D sym)
				sympos =3D nr_matches;
			else
				has_dup =3D true;
		}
	}

Because the kernel resolves symbols at runtime using core_kallsyms (which
explicitly excludes SHN_UNDEF and .init sections), counting them in objtool
could result in an incorrect sympos assignment.

Could this mismatch cause the livepatch loader to wire the patch to the wro=
ng
target if an identically-named static symbol exists in an .init section or =
is
undefined?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D37
