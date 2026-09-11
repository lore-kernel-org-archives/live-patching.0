Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050694AC151
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155033; cv=none; b=KYMraVeTb+uZ8yTmfIls/ewGnSSumM5E/li7wzNOdtsDhtUJJiRZruFTzmRHHd1j1EIhkV10lyOrZQT3hQN8YoBxQSix+eq/5u2A3LZFltulQ1MTy0gKUxJuRgfAo4jcEUazwGZXs2LzsX6VojLh3mU7P5sGPB1k5CZy6soYYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155033; c=relaxed/simple;
	bh=txhX4D348pIpcpc076fcmRc2BoYDX/5U5H7PSgndxFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/dcVBGBqMEcKL2RpiyHbQf+xWHoQAs6jHiKvcXsVDAOQfUh/PLWLvctmE/zOuXYPe9Kiitv06reWGSZy9HA7GhFc6/fWSevB+yO9gSsBr4L/TfzK7+5Mwli0HKaYM36PcqQQ+l2RyyrhpRiDgPVRdk61RGdLvuqWwUMr/S/Vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6wRtG+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6wRtG+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE31F000FF;
	Fri, 11 Sep 2026 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155024;
	bh=crSXL90rfQDgOn7aTLcNDwzFcuHsh1vwl2DQYNME46Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6wRtG+HrhpL3ACwNE11RSTEkNr8Z9Z1xtHLW6vQGJX40I8gJERQsXnUrGkSRMcxz
	 yvDXYs38n1LZ9AcedTx5d+LDGZ/7EOsy70jZvX1gNCgguMWXT0x98s8Q390Dk/EyOE
	 tywWauydTdmZmi+3KM8bx7akZZ1Ny+HVrGyb88cg5S+3p7b4fkgYyL+n+lPgOAiaxn
	 Cq2Zs8erY7yPKRX8pqchehJE2+TUfSqONZuTDZBeJ68X9E3p9cKQ4KjmRy6gyk3q30
	 HjmakuCYQe0PFrEuUpivujaBe4hZUHeabbrhRsItvoG3g3Faukw8EOlABoNC8Og+Nu
	 HD7z4j8HBjN7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 52/58] objtool/klp: Add test for alternative replacement
 code in checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: kernel-team@meta.com, jikos@kernel.org, peterz@infradead.org, joe.lawrence@redhat.com, jpoimboe@kernel.org, puranjay@kernel.org, mbenes@suse.cz, pmladek@suse.com
In-Reply-To: <20260911185031.1534046-27-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-27-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:30:23 +0000
Message-Id: <20260911193023.9BEE31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The test fixture defines a replacement instruction that is larger t=
han the original instruction, violating x86 alternative constraints.
--

commit 509cbfff90fd6a32748a4ce13dc568b4181b4904
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for alternative replacement code in checksums

checksum_update_insn() walks insn->alts after hashing the instruction
itself: the alternative's type, and where the replacement forms a group,
its feature number and every instruction in it.  A patch which edits only
the replacement -- code that runs on some CPUs and not others -- still has
to move the function's checksum.

> diff --git a/tools/objtool/tests/x86/fixtures/checksum_alt.c b/tools/objt=
ool/tests/x86/fixtures/checksum_alt.c
> new file mode 100644
> index 0000000000000..47ff93bc77556
> --- /dev/null
> +++ b/tools/objtool/tests/x86/fixtures/checksum_alt.c
> @@ -0,0 +1,60 @@

[ ... ]

> +#if defined(PATCHED) && defined(ALT_REPL)
> +#define REPL_INSN "	xchg %ax, %ax\n\t"
> +#else
> +#define REPL_INSN "	nop\n\t"
> +#endif

[ ... ]

> +int target(int x)
> +{
> +	asm volatile(
> +		"661:	nop\n\t"
> +		"662:\n\t"
> +		".pushsection .altinstr_replacement, \"ax\"\n\t"
> +		".globl target_repl\n\t"
> +		"target_repl:\n\t"
> +		REPL_INSN
[Severity: Low]
Since the original instruction defined at label 661 in target() is a 1-byte
nop, and REPL_INSN can be defined as xchg %ax, %ax (which is 2 bytes), does
this replacement exceed the original instruction's size?

x86 alternatives strictly require the replacement instruction length to be =
less
than or equal to the original instruction length. While this test fixture in
checksum_alt.c does not execute at runtime, emitting structurally invalid
metadata into the object file could cause failures if objtool adds stricter
size validation in the future.

> +		"target_repl_end:\n\t"
> +		".popsection\n\t"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D52
