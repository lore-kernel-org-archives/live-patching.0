Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594474;
	b=zeJ7VCmq+s/IvCD9UjWZtVQoeC/gcP1+rLro54WiNOrpbVLVoFMPgJvxQYCeJ4Q2/w3Z
	 wKY0K0DJXTp0aS1F58P5IpTpTUk46J4YZWdcjfXUs2F80gCOZlj7y0x0Jk6Lz7J3Kp4wW
	 X0B89XhX6ChWVTDyOxj0zz24BMW8oHRF/ykTJGG465jXMr1AzZPDP0hZLKuJWptRusLK/
	 KXkRVfT6sd/V7DG8U8eTXsyespZAUc8tX13PZPVYT/f1da8LGJuIhtjEPuLLzxA+rsXGs
	 a/ZK6nx164XRRC29eu8/8hXDVRRiHh46YLSO0C2JRKQZTrfQ93LvRKIjnDAFMZXNaXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594474;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XgiL43Tq6jpJoDdSXDyRa25ecfhsKUOXQPW5HWxvCUs=;
	b=jYTPAl6CLwzePJMx3znskQEmAz+zIYH7Fk3KJ/eHcrQLqkNc/1cbANZ3yd/3MB/At/iI
	 IP/lCAtPFmhxZu7aEXnodXtILHXlfaPegFu61XvjnGHVtAN8NLG2u0Rjt/ydPmqjPqSUm
	 6zjoJU9EbxYiWyWOLm4Esd+L275RTm7PMXJry1irum6X6eAuq59kxYrHT7ELl9U/aEIrH
	 frqcAHDjozuMVSgZzmytLFVYsgIsFvnN9bDfNVB6+EiUyfJcmpyvdrN0itCm0WR0PWyQ/
	 iJSRzlesrUuIu7sJINHKWMD0aMLltnXptSLX14StGrCEnxTIBOWN1bJBthAIR8Logbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZW+kC2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D4606A323;
	Fri, 13 Nov 2026 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZW+kC2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C051F000C4;
	Fri, 13 Nov 2026 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594473;
	bh=XgiL43Tq6jpJoDdSXDyRa25ecfhsKUOXQPW5HWxvCUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NZW+kC2aqaTRO+1mDk1qvHG3VrZfRzQx7JBMREQSnofe8qIQP2Mo+1VuL2F45WnsE
	 H0d/drhYGkJbwuJWov3qabhQIKlXcHqZDF9afj2CzxojiusGCL3MH42MFwR9T3THmI
	 vWUOMXwS1D6XFN7xANBi4xQ40h62L1vizgItg0U804ItXM0ouviUOM7BlE92BidgY/
	 037sIgf4+7uYWnTfRk+QxaQJgEUl0Dz6/uLP+I+Vc9+0zkGX94ypnHbERzm/9nLj/E
	 pGi5nn7T9ryxXpO/mTnlnNLg2n+liXzWOZGVkRRrceUzvvSO+eA2UtCIzm+ZQ8ZaDi
	 c2avZq7muWZrg==
Date: Fri, 13 Nov 2026 10:27:51 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/11] objtool/klp: Fix checksums and copying of
 wide strings
Message-ID: <avdWaZboJeDyyOMs@jpoimboe>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-2-luolongjuna@gmail.com>
 <avZ3jEbnuVu5Qv2G@jpoimboe>
 <CAKL4jwX=ctyjXmm=Oz_+HXe89vOHWHgT_-KGyL47fOBEQTYJiQ@mail.gmail.com>
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
In-Reply-To: <CAKL4jwX=ctyjXmm=Oz_+HXe89vOHWHgT_-KGyL47fOBEQTYJiQ@mail.gmail.com>

On Fri, Nov 13, 2026 at 12:32:20PM +0800, Longjun Luo wrote:
> Sorry, I left out the debugging context here. Both comments refer to
> specific kernel build artifacts:
> 
> On Thu, Nov 12, 2026 at 06:42:36PM -0800, Josh Poimboeuf wrote:
> > Please give example(s) of such "wide strings" in the changelog.
> >
> > > +/* Wide strings, such as the u16 PSR setup table, end at an all-zero element. */
> > > +ssize_t elf_string_len(struct section *sec, unsigned long offset)
> >
> > What is the "u16 PSR setup table"?
> 
> PSR stands for Panel Self Refresh.
> 
> Source    : drivers/gpu/drm/display/drm_dp_helper.c: drm_dp_psr_setup_time()
>             /* macros expanded */
>             static const u16 psr_setup_time_us[] = { 330, 275, 220,
> 165, 110, 55, 0 };
> Section   : .rodata.str2.2 (SHF_STRINGS, sh_entsize = 2, Clang ThinLTO)
> Bytes     : 4a 01 13 01 dc 00 a5 00 6e 00 37 00 00 00
>                         ^^^^^
>                         220 (0x00dc) contains a zero byte at offset +5
> 
> objtool   : strlen() returns 5. The checksum hashes only 5 bytes, and
>             the copy includes only 6 of the table's 14 bytes.
> 
> > > + /*
> > > + * FIXME: GCC's range_string() uses a one-past-end string pointer.
> > > + * strlen() reads past the section; preserve the string base and addend.
> > > + */
> > > + if (entsize == 1)
> > > + return strlen(sec->data->d_buf + offset);
> >
> > I don't understand what this comment means either.  Please make sure all
> > comments and changelogs are written by humans, as LLMs tend to write
> > nonsensically.
> 
> Source    : lib/vsprintf.c: range_string()
>             p = string_nocheck(p, pend, "[range ", default_str_spec);
> Section   : .rodata.range_string.isra.0.str1.1 (8 bytes: "[range \0")
> Reloc     : range_string.isra.0+0x9a: R_X86_64_32S .LC22+8
> 
> GCC note  : Uses .LC22+8 (one-past-the-end pointer) as a loop bound without
>             dereferencing it.
> objtool   : Passes offset = 8 to strlen(sec->data->d_buf + 8), reading past
>             the 8-byte section. Fixing this requires tracking the base
>             string (.LC22) and the +8 addend separately (left as a FIXME).
> 
> I came across both while testing on full kernel builds rather than in
> production livepatching, so I'll leave it to you whether they are worth
> addressing in practice.

It's probably worth fixing, just the comments and commit log need to be
clear about what exactly we're fixing.

-- 
Josh
