Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98715368D77;
	Mon, 10 Aug 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378357; cv=none; b=Y8+ciEuQX4K6Qt8qihuqj8Gy5DEXzxNgZpEhz0kfjxfE6pH8Ee96L1zCBy8w02y7ZvOCsX8+4Sz1jlym4OKBsX4K/UElJJm41wR/oOnD3rVQLg+QdSaBCXAYhIHSocWIZW4YQgPBLkM4bbZPcYN9zqQ1NU+CrA1YRhVmOjBIjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378357; c=relaxed/simple;
	bh=s3+30PLXx8mglS7UzJxChEd0ZExXqQEwkXskchb2hVk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I4Eu6Kx/Aev9O1/giqEJsBmaMJwh1TGU9PSRmz9RTL0AFffxoH23MkabU8SDcbrv0cceDpbAZVDR/Vf4kfQnYowa4R9aGOmyAqterYwtD2l/kfRpPfINpS24tPKPiveiAOiZ8LVn3vf5ldpTLQ3HFWgjsOccO54urRwCBSXxKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1hfZ3PZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1hfZ3PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0BC1F00A3A;
	Mon, 10 Aug 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786378356;
	bh=hxkZK5uovHSaks35B19n87r7874YO6EyPDjqLVU7ek8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=l1hfZ3PZ2Rgpuz8IpsACieNOodt1y4GhMTTsWov1o5TAZZ/BWqOfq/hFiENsDYgCe
	 UMW72fMIldvaDJjtgoSmxySouRE7YIPIlYxM0z5sEeuE5i+S82v0v7E6mzfYZ+1Ig2
	 6V0jrGxB2IA3EnHECLsF7reUjp5TAz3nAP5S0eaohdFD4cafqOvdzP+viiE8G3eljl
	 71J3Phnn77rX8EKztl6XeTjcwkn2B27E2XfAaJVTj2kOVpoBH2hCXZVrDFPskiwDtk
	 CVsaQQiN2JHzmHy3T2QcbYeAkjdRqqJJDXgOgBlmSJqhnvFqpdGH/u8p1aKUfjWZX0
	 zeGLsdD782JIQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id DEF9B198003A;
	Mon, 10 Aug 2026 12:12:33 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 10 Aug 2026 12:12:33 -0400
X-ME-Sender: <xms:bvh5ascrJuEjDDFWeCjABdVF6AyhQhlBRcsZpfgOKRXp8zQcwZUjoA>
    <xme:bvh5apBBmPHe0unnfckuNs1knL3uJRIbFAlDyfpUVhPuXhYrqFIa_E97Sc2DM_gdN
    qpDLG3RNCZN0A0FStQ-AI7RkFpFxIYt75rtNo7Gk2Q4kSeeF58_2l_u>
X-ME-Proxy-Cause: dmFkZTF+vtQORsguZ5R1UE6FOE8VwY2+nU6JVUE2bXe1AmP9bhS32q1eGCRH1/ax0V2OjV
    F8rzhKkV3ljWtTafIU2X6f3MstkkZ5wGFc4GC2BG7sDPP2l9U35EQS4MVF12wLLVKvyIBQ
    6lFYtzWyQKfpLH8KFaULfOQFiySQV1PgAaWX64gSK4HKM3H/KsKAq35A45AS/V8J9NXOcJ
    6WA8SZSzPvEU/P5gX+nQqumc2TwLTSXBG8SM0289wXBuioe9inBVO7qe6cb1MCvgVWLD/I
    v1i+9ZopGFq9fJe0R6WufFJepZYaoCYdp0Z99CjIJR8e6UeqXgMJL6lY1Ku+YQWzc18LbV
    QKFQNZvFZui1kgXmoj9uABqzZEi2B8Y0J/9lg9L6yPdA+aos1UDFiJGDVj+XNj0JocTavB
    vHtD+XNFY0cv9opiBlQS2ZnpSZAZn/tDXYn2tmAFAltJpMVYVa9r9NPX6NDVGn7kcWD2bO
    AsQzU8umWSetYiz117nkPeXmSRjeNKm5ra1qV7S8iZjQV3e46rWCqgvSppmQT5oFclp9ZX
    u1ukGnO9ySJj++iS68e1UDCG0BXVG0KM3MmlaIWzKZRBE4Yc5jnb3C0vxoxPt9AJ6D0Aas
    PmmJ3pIgYP6j5uZECM1vlQ3w38cZZy4FNuBTFuBRADM6EChPbN1rO8XFrojw
X-ME-Proxy: <xmx:cfh5ajvTqzrJZ8OAOpYrJ9Y2hkIVMLYit2LbQY4K69TaPrS4ausoTA>
    <xmx:cfh5ag1yNIBnS4Gjtsw3zEQidxd1E8dTfYS6TuCp5UGXIH3fsKgBUQ>
    <xmx:cfh5arPOg2EwAk34Askj7INV6JWZAXSO04BorJr8XQnJfQUyjLAtcw>
    <xmx:cfh5agXpDD_I8mGsmNKIUlbo0obvRnkMFEffZDNJPI2KyWeQa_ni3Q>
    <xmx:cfh5agZVPEWBPpGoP4v3uFEdv8u8HMIeqvJ7bd65MmD-0jG9TBZ3lLkx>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B4FECF8006E; Mon, 10 Aug 2026 12:12:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 18:12:10 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>, "Will Deacon" <will@kernel.org>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Kees Cook" <kees@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>
Message-Id: <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
In-Reply-To: 
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
References: 
 <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


(cc Kees, Nick)

On Mon, 10 Aug 2026, at 17:48, Josh Poimboeuf wrote:
> On Mon, Aug 10, 2026 at 11:31:10AM +0100, Will Deacon wrote:
>> On Fri, Aug 07, 2026 at 02:46:11PM -0700, Josh Poimboeuf wrote:
>> > The following BTI exception was seen when loading a livepatch module:
>> > 
>> >   Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
>> >   pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
>> >   pc : kill_orphaned_pgrp+0x0/0x150
>> >   lr : do_exit+0x498/0xaf0 [livepatch_combined]
>> > 
>> > The problem is that the patch module's do_exit() is branching to a
>> > static function in vmlinux using a module PLT veneer (indirect branch),
>> > but the target function doesn't have a BTI landing pad.
>> > 
>> > Clang 21+ omits the landing pad for static functions which can only be
>> > reached by a direct branch.  That's fine for ordinary modules which only
>> > branch to global exported functions.  But livepatch modules use klp
>> > relocations to reference arbitrary kernel symbols, and with
>> > CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough from the
>> > kernel that every R_AARCH64_CALL26 needs a PLT.
>> > 
>> > RET is exempt from BTI checking, so use it instead of BR when the target
>> > has no landing pad, similar to what ftrace and BPF do.
>> 
>> Hmm, doesn't that somewhat undermine the purpose of using BTI in the
>> kernel? Now we're going to create PLTs that can branch to arbitrary
>> addresses.
>
> Yes, but just to clarify:
>
> - Only with livepatch modules loaded (and we can add an
>   is_livepatch_module() check).
>
> - Only a small minority of livepatch klp relocations need it.
>
> - There are already other instances of "ret <reg>" in the kernel in
>   ftrace, BPF, and kvm.
>
>> > This was found by testing with klp-build and Clang 21, but the issue is
>> > not specific to klp-build.  It's inherent to any livepatch module use of
>> > klp relocations.
>> > 
>> > Previous tests with Clang 20 did not show this problem, as older Clang
>> > unconditionally emits "bti c" for every C function.
>> 
>> Is there an option to restore that behaviour if CONFIG_LIVEPATCH=y?
>> Otherwise, I think I'd be more inclined to add yet-another dependency
>> to CONFIG_ARM64_BTI_KERNEL so it's disabled if LIVEPATCH is selected.
>
> Hm, looking deeper, is BTI just fundamentally broken now, independent of
> livepatch?
>
> config ARM64_BTI_KERNEL
> 	...
> 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
> 	depends on !CC_IS_GCC
> 	...
>
> AFAICT, the reason for the "depends on !CC_IS_GCC" is that GCC was
> already doing the exact same thing Clang is now doing: namely, omitting
> BTI for static functions that don't have a pointer taken to them.
>
> So Clang 21+ now has the original GCC edge case: an .init.text direct
> branching to a .text function which happens to be allocated >= 128MB
> away and which doesn't have BTI.
>
> In which case I think to properly support BTI going forward we would
> need two "veneers"?  Either that or remove BTI kernel support
> altogether.
>

Yeah, it seems we did not argue our case convincingly: their assumption
that veneers/PLTs can be placed within -/+ 128M of their target does not
hold for us. But I don't think it holds for .text sections larger than
128M either, so I'm not convinced their reasoning is sound even for the
general case.

I suppose we could special-case the PLT logic to use direct branches
where possible, which would probably catch most of these (assuming
.text and .init.text tend to end up close to each other also for KLP
modules)

For the remaining cases, we'd indeed need a second veneer at the callee
end (i.e., inside .text in this case) that is emitted when resolving a
cross-section indirect call to a function that lacks the BTI landing
pad. But that would be its sole purpose, so I don't think we should go
down this route. Instead, the 'address taken' check should include 'called
directly from a different section'. Emitting veneers to work around a
compiler optimization is just plain silly.

I'll try and poke people on the Clang side of things to revisit this.
I guess that leaves kernel BTI broken for the foreseeable future but so
be it.


