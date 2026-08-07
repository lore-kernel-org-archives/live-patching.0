Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728E3F8226;
	Fri,  7 Aug 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140016; cv=none; b=lKnBNxAzEbi5Z+hewVa8swzUVeRD0GYTqpzG61eS/cEi3Kgp9y15UnZ3OBwMiCk/vfCku3e1/FGFrkvvijjdb6NbIsjggAa49/TJfH36lCd1OGSx9pcMyd3yQzv37fpRjJ53uSs16hlV8Dbd3cK3ZSeRebgjoBAAW3W0oZPYWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140016; c=relaxed/simple;
	bh=95UDv9U396aDngr02p9i9YEtT6gGyRth+z17BKIvq8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TBlw4TDjFGODuoR8I1yDbdEDvPVct/pwK4wIZ7SSIsMMINqVD+/NRZ0CoaaiPTYuxRBfK1r/QtmAyqgPEy6NB+Wvh52mQ0fDIm8Z3YvkmNXzexPmPnK0snWVjh/lm2VDZgxqmPEqBrppGBgm+fQmRTmiAb0QdQc5zIR9KYpx3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyYMMaie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyYMMaie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FCD1F000E9;
	Fri,  7 Aug 2026 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140014;
	bh=Quf92lF6C+YF//JgzY89fF9Z54wBSk3iWTnjDRWBm3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyYMMaiepK4f/MfevSHCv+CYqEaIQjV+IX7lP77M5foo9CM8BzXbFIm9KASzDfj6G
	 /gsgcLP47M8UO46PHD+iFGpfteimiN4HsimtrngkNaU4k8NdIQl14SXBxcyOsNqbiN
	 3gxSDaejEDpJeHMw9zrOmF1UQwts+VL+jBe4u238eigbfkk472tNKV7lWQEe1oVvBF
	 xobT3XiAPKmCL877riR3r/O/jS/dLa7w9p3N4bftGWVhT+eL3nTsEu70FyA4dovira
	 0WihFrRNV50O/eAn8dp3nH3/ZWlZ/SiZd8Fc2UJG2ane87yqHWhENG1ZQVZSCuwnvL
	 dOfiTZZ1lfQFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang
 21+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Will Deacon" <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>
Cc: "Joe Lawrence" <joe.lawrence@redhat.com>, linux-arm-kernel@lists.infradead.org, "Mark
 Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, "Miroslav
 Benes" <mbenes@suse.cz>, "Ard Biesheuvel" <ardb@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Song
 Liu" <song@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:00:13 +0000
Message-Id: <20260807220014.55FCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Direct assignment to read-only memory in `module_emit_plt_entry()`=
 and `module_emit_veneer_for_adrp()` causes a Data Abort kernel panic when =
resolving livepatch delayed relocations, and misses instruction cache flush=
ing.
--

--- Patch [1]: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clan=
g 21+ ---
commit b15500d2c41dfd08d4a46e3f6cffc977c910f40a
Author: Josh Poimboeuf <jpoimboe@kernel.org>

arm64/module: Fix livepatch BTI exceptions with Clang 21+

This commit fixes a BTI exception during livepatch module loading by using
RET instead of BR when branching to static functions that lack a BTI landing
pad. It introduces a check for landing pads and adjusts the branch
instruction emitted by get_plt_entry().

> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-p=
lts.c
> index 7afd370da9f48..4249b477daa8b 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c

[ ... ]

> @@ -23,14 +26,45 @@ static struct plt_entry __get_adrp_add_pair(u64 dst, =
u64 pc,
>  	return (struct plt_entry){ cpu_to_le32(adrp), cpu_to_le32(add) };
>  }
> =20
> +static bool plt_target_has_landing_pad(u64 dst)
> +{

[Severity: High]
This is a pre-existing issue, but does direct assignment to the PLT memory
region cause a Data Abort when livepatch resolves delayed relocations?

When a target module is loaded after a livepatch is active,
apply_relocate_add() calls module_emit_plt_entry() on the livepatch module.
Because the livepatch module is already in a live state, its .plt section
has been marked read-only via strict_module_rwx().

Looking at module_emit_plt_entry() in arch/arm64/kernel/module-plts.c:

module_emit_plt_entry() {
    ...
    plt[i] =3D get_plt_entry(val, &plt[i]);
    ...
}

And similarly in module_emit_veneer_for_adrp():

module_emit_veneer_for_adrp() {
    ...
    plt[i] =3D __get_adrp_add_pair(val, (u64)&plt[i], rd);
    plt[i].br =3D cpu_to_le32(br);
    ...
}

Since this direct assignment bypasses __text_poke() or aarch64_insn_copy(),
does it trigger a panic due to writing to read-only memory, and also fail
to flush the instruction cache for the newly emitted PLT entry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ed4fe1f95071897859e=
c7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org?part=3D1
