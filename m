Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330818;
	b=14LvX0UeckBU57DhFWy3FhqMpzEKXOcFYUBjaZqemPFJEzMcRuCAk4Iwpifrz1oe/2Q5
	 aXPO+70wiA0gWfM8nCA9ug2JW0hzOXfgu0qZLKcG3BRF0uYyqajgn/qQxms3h0/OQ03zO
	 YqXgTdRjOZ3x+xLlHVWNMXLzj/dpDczQgqnsb7ipJxPA0SAQHltU/aDSa6Cgxx7fq4Ijc
	 YoM69BeYyJTsF/AYb+P0hf/rDBNGorPMj0CC2zcEn94or6t5S+/DVC4T5TG6RGe5T1PzL
	 uIn4/zoWYWDExAuOB99mVos2rindaD0vQJvPdn8EOmkzqg1A7Os9qgVRN16rRI4AZOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330818;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nIYQf39JPVEE3EcOjZPlpobu516qhCSZcCXOowR13Ms=;
	b=zbgCcQgbue8/decbUKU1amn7GYh/mteo7GQ1vVzIYpNWbyBEKrjKDvmPZKAYvYq9NTQw
	 VYID3ZxV4xV8DLXl37L9oaeAKRH1GoG6FEP4SmSjbFupPrK73CS/D9YLH0dmo+sfG4B1k
	 v8rRQHHEH5hzCgma4YISz7UE2Obhmt6tSf8/BI5HDxBBNeBEsawoLD31VI2Or6EcMRDlE
	 Zup8AFA/drPW0+KzSXQJf9SLAj2JOwICPe2u7IWGdS5aleae+5ZZYDG/sv6SU3WoRE21Y
	 uD5AixxHrvCubpDpRTNGbbIv6R347kSKyD3o2PphNaB55pBpLuENv5Tyr/5TJ1PLgUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qj54I7x2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EF606A320;
	Sun, 22 Nov 2026 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qj54I7x2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C7B1F000C0;
	Sun, 22 Nov 2026 07:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795330818;
	bh=nIYQf39JPVEE3EcOjZPlpobu516qhCSZcCXOowR13Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qj54I7x25az/X3a05tHbr17Aed4I5kPScv1MIGn4qMCi2HfG5SGo185OVvQSa9j31
	 X1x2q9cz8MyNDaq/jGZdDfs1apiCT60O+tKGcp+dzShTNmCQERvthAiV9jPq0RsGpJ
	 JCw1/Vq91JIaRNaf6KootMZ67sdwjek27YsnWxSc2NLkPd8AkC3ySjWXzU0latwdlu
	 +nEoCj1b6r/ZT4sdfmT6YK15q9y7Rzv9271bhi3iiQaCOxZ3Vkd+CCGhDhfPuGj//n
	 pY2PDDhfRyTpf8MMW1ghy7d5n+DrRnwvOKrHCYCgdMQVqnpLWbvTogKWjG41wcOtJO
	 Oxd3m8IE016Jg==
Date: Sat, 21 Nov 2026 23:00:16 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] klp-build: Reuse the target kernel randstruct seed
Message-ID: <awKS7r98LjmecdIM@jpoimboe>
References: <20261020212341.706367-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020212341.706367-1-song@kernel.org>

On Tue, Oct 20, 2026 at 02:23:41PM -0700, Song Liu wrote:
> CONFIG_RANDSTRUCT randomizes struct layouts based on a seed which kbuild
> generates from /dev/urandom.  A livepatch has to observe the same layouts
> as the kernel it is loaded into, but klp-build runs 'make clean', after
> which kbuild generates a new seed, and the resulting module can't be
> loaded:
> 
>   module livepatch_foo: .gnu.linkonce.this_module
>   section size must match the kernel's built struct module size at run time
> 
> struct module had grown 64 bytes of padding relative to the running
> kernel (0x540 vs 0x500).  Every other randomized struct the patch touches
> would be read at the wrong offsets too, so this is not just a loader nit.
> 
> Reuse the seed of the kernel being patched, taken from --randstruct-seed
> or from scripts/basic/randstruct.seed in the tree, and refuse to build
> when CONFIG_RANDSTRUCT is on and no valid seed is available.  A wrong
> module is worse than no module.
> 
> Pin scripts/gen-randstruct-seed.sh rather than the generated seed file:
> clean_kernel() removes scripts/basic/.randstruct.seed.cmd, so kbuild's
> if_changed finds no saved command and regenerates the seed no matter what
> the file already holds.  The generator is stashed, so it is restored on
> exit like scripts/setlocalversion.
> 
> Read the seed before set_kernelversion(), but pin the generator after it.
> set_kernelversion() runs 'make listnewconfig' and 'make syncconfig', which
> build scripts/basic as well, so after a 'make clean' they would replace
> the seed before the default seed file is read.  But if the generator is
> already modified when 'make kernelrelease' runs, setlocalversion appends
> "-dirty" to the kernel release and the module's vermagic no longer
> matches the target kernel.
> 
> The Clang and GCC plugin implementations both derive their layouts only
> from scripts/basic/randstruct.seed, so pinning the seed covers
> CONFIG_GCC_PLUGIN_RANDSTRUCT too.  Drop the check that rejected it.  The
> plugin requires a 64 character seed, which is what gen-randstruct-seed.sh
> writes, so validate exactly that format.
> 
> An explicit option is needed rather than deriving the path from
> uname -r, because the build host is usually not running the kernel being
> patched.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Seems fine, can you address the Sashiko comments?

-- 
Josh
