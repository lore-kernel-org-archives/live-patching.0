Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C921D3F5;
	Mon, 17 Aug 2026 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965113; cv=none; b=nkZQANOvOdE339X8Y7/hSB+ZDltPTDjda4W+42id6Ebl487/mwrjhn2Z8BILKMMacEOJps3bB96rocFCiRFxgrYOumGEM1DQ3BWkbMjuMxdQ5XgMW6kwDHn2DzJnX+UVQpSM7RJLCr16itWHqZDPlsAe82U1nfRsbreANH0Q7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965113; c=relaxed/simple;
	bh=0L+zncxedB41N/GspeoVOW4P3bpxNMWnwD0AcDqkR38=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YzsUYG6CdQ4E/Z5U8n8brsYyaobw3BwDNL68PoTA3IUFBDUPP0b+Z+Hu5+yzDPGNyMgDgUvYvKL27Ozd5j7sSG7HC9tRskr2xNL7OM09FQhGMnOKybCb3fqriC7qMP0Hjq8NtuWVYc9qFiW0lN2Vlh6lYwBYil6fh1DD04ywruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXUTRKW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXUTRKW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4AB1F00A3A;
	Mon, 17 Aug 2026 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786965112;
	bh=hKHmE7HFsnKiN9x/NA7Ar8WwUxdcYL2GtFDwkU9a3nI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DXUTRKW7VSa9/1ECiVxOjFqPhxxM2/Y+R3nnXRCdzCxaBMSSw+3YKf/8lXpC//tTP
	 oATEDKsoDK59M0AxkNjTi/xhmjG5pesPMIWLIAuAxF4110DmoOyVx/s7XQv+0pkX2X
	 wRIgM+wKB9PExikewM9iQ9Tyk+JDo3zOZ0tKdUSIecZSJY1n74m7It1JdcOhWlpXIQ
	 Z/k3bKKrU9Hafs56n/87uWOWufMHxArZ48nRNt22hjK0jjkgASgwYLJWJTKPLFy8yR
	 oGXe8lmIv1p68swgToX/vuxrLDjaxxJs0cLWvTAUpSyq39skNLc2EDoS/gloivHSq6
	 0niqzgw73MbhA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 68C5E198005C;
	Mon, 17 Aug 2026 07:11:50 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 17 Aug 2026 07:11:50 -0400
X-ME-Sender: <xms:c-yCagqHF_GL7una0AQT0iWWh3YLZPKirKR336weVeMSA5ciBUPKuw>
    <xme:c-yCahdPHs_Scb1GQs1yO2mS7gn9M5CrLjGdOvYc-YTVoDdFo41gzz-ItKGVJQAbs
    FDB67CrC5gq5liI6ymsfD-ygjjpb6Iuyik-9Kntk9l0sFLF2KxSY_o>
X-ME-Proxy-Cause: dmFkZTFi9nOk09DVxdl5FlNkGc8vg6SDda7HLe1KMtgLAPjgdCHbnF2Ou2YGV4kiMEGSaj
    Jfh4fmBdAfggRip8FVSbc6Vm6x0xEcL6l2YfCwn/IXhwSXL/vENLdVC1URhdnwUgYKJ+3P
    Qg2E2WqaoDfxBXtR4xJ0QhRJJz3rOviPFu9JslRYnYBVN2iJtSVfUsJOjmUPEwHVL1eSIy
    COEKAeygEi2OHJ+lz8unrCbQZG2HQ1XA0v9uCiZvZ/qNf8B7BOm1J6gnz6DpjlUu5C30Rq
    H8dT+OfI1RWvtRJBoLkZvU+niMPfc9WPA/4gj4Kq0nAe7WlVlvGqwIiBJ3LUvgL4W2H8Hp
    2k9R2CRLxOIdWB3YyV2Yv6wiO+6VH2Syqe+Na3aFe/8RI7/OfiEhwksCbakdcucpxqetYv
    UCt901wCFHdczPTuR0cXLIeqelwbJRBI52+NUwZMLVrDre/iL5wtewbDy2ogrh2FgrHhrX
    w6kyeQVkVLvecAWhnqA+JRn2pxLjRl8X94CH+fjXMVbqgvt2yB0gHICzB5JEi+64qKx0k+
    5Xgqjph+0w3hTSMLMsK0zw4HxTPD7MSy4qCKLWix9QbI5JhpAXpJ3yafnBOi1/YLgJhVn3
    x381QnBKQxZ/eU2hJif6BmWMbqOTtM0iTLJZ3o64tj0rsl5f+JH8pyjlSS0Q
X-ME-Proxy: <xmx:duyCatMuqheohB2LNK9roIZmx2rTtG4x0g0aFo9BbgQuYecbmrAA5Q>
    <xmx:duyCapXNce8qe8NIcH6BPnYQ3W2rl7MHiSpd7_g2c_gD-ITDru0PhA>
    <xmx:duyCakykg70vPPgJp1eBX8XIPHR8CkGS5xl01ZGcGv6BVOwhQdi9Rw>
    <xmx:duyCapO68ZAxDYnBbevG5KGHWEh5kMe6ORXIx9gHdRgvLdor2mKrUg>
    <xmx:duyCamqIvTzpNwpO0ThhdlK39AsUHsv69a0A1f3HDeAJBpu4qjtwj8rg>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3E2C2F80070; Mon, 17 Aug 2026 07:11:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 14:11:26 +0300
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>, "Kees Cook" <kees@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, linux-toolchains@vger.kernel.org
Message-Id: <b32fc053-6f1f-481e-9872-ab3cf22534e6@app.fastmail.com>
In-Reply-To: <aoCu66bx1Qg14-uD@jpoimboe>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
 <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>
 <aoCu66bx1Qg14-uD@jpoimboe>
Subject: Re: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted landing
 pads in Clang 21
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, 15 Aug 2026, at 21:57, Josh Poimboeuf wrote:
> On Sat, Aug 15, 2026 at 12:56:11PM +0300, Ard Biesheuvel wrote:
>> Hi Josh,
>> 
>> On Sat, 15 Aug 2026, at 07:45, Josh Poimboeuf wrote:
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
>> > reached by a direct branch.  But livepatch modules use klp relocations
>> > to reference arbitrary kernel symbols, and with
>> > CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough away that
>> > every call to vmlinux needs a PLT.
>> >
>> > Note this problem is actually not specific to livepatch.  It's possible
>> > for any module's .init section to be allocated > 128MB away from its
>> > .text section.  So calls from .init to .text via a PLT can trigger a BTI
>> > exception when the target function doesn't have a landing pad.
>> >
>> > GCC has always omitted the landing pad when possible, so kernel BTI is
>> > already considered incompatible with GCC since commit c0a454b9044f
>> > ("arm64/bti: Disable in kernel BTI when cross section thunks are
>> > broken").
>> >
>> > When missing landing pads are detected, allocate a page close to the
>> > target which can be used to hold BTI veneers which receive PLT veneer
>> > indirect branches and direct branch to the final target:
>> >
>> 
>> This does not work for cross-section calls from .init.text to .text.
>> 
>> If .init.text is far away from .text, it is likely because .text
>> ended up in the 128M 'near' module region, and .init.text did not.
>> (They tend to end up in direct branching range of each otherwise.)
>> 
>> Given that the module init code is typically small, I don't think
>> it is safe to assume that allocating a single page close enough to
>> .text is going to be possible if allocating the space for .init.*
>> was not.
>> 
>> IOW, the fix I proposed for cross-section calls is still needed
>> with this approach.
>
> But the BTI veneer page is allocated from a *256MB* window, of which the
> near region is only a 128MB subset.
>

OK, so this window would be [_etext - 128M, _text + 128M), right? Or
whichever the equivalent is for a kernel module?

I agree that this considerably reduces the likelihood of running out
of veneer space within direct branching range.

> There is a theoretical case where the 256MB window around the target is
> completely full without any fragmentation, but I would think that there
> would almost always be some fragmentation.  If that window is modules
> stacked together, most modules have at least .init.plt and .init.text,
> and many have .init.data.
>

Are you saying these are freed again once the module is initialized, and
therefore there is fragmentation? Not sure if it works like that if modules
are loaded one after the other.

> Right now it needs two pages (because of the default guard page) but we
> could maybe fall back to VM_NO_GUARD in case of emergency.
>

I like the advantage of only allocating veneers if they are really needed,
as opposed to allocating the space unconditionally, which is what my
solution does. But I need more convincing that this will actually cover
all these cases, given that the cross-section call issue only occurs when
running out of direct branching space to begin with.

