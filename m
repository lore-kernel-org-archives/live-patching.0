Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994D3A7D73
	for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786888230; cv=none; b=XA+1oxJDfdzdPyBAJ0tuU+ERaLvxHbZ+7HnTw+9oQskfg1aAwAYHidKyjERcZw2Gm2lunKahX3QiOrZ3kHVIuOM9SffPl9Hsf/UKAZNle0AvDNDcsj5LbAN6rq8QM3k2lLolfgqac24IE/zA8B8U/2hf+4TkCx5opZFJSJaBPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786888230; c=relaxed/simple;
	bh=DD0NKs6RNDzA42Pn2nmpZ3VSWexx+59aNO7xsNvxJnQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KhfJFyiiVtbLx0pphRq+sywAsVUAGrKL3a+an7hKwfbL/Jh5prPHvRqGBsu/fAuh8hDfmtnE8M9hHblFJUkrk70eF1mH/xXcxRYVDqOyf7SxHRZm2jRDtZce0jF2Erag0pxlZnTIi9zkYGV+FNSyX6nfdVNXKGXsq26WLKguPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT5ls6rG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT5ls6rG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226531F000E9;
	Sun, 16 Aug 2026 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786888225;
	bh=6bMpbO3p3Ie0JM1f8TUuUkmgYOGktAPmGuPKMuLa1Ak=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=lT5ls6rGDlcqWc1zcnqWLqpedjnBGMqDZdYCpqDhyBF0L4boDs2PxgqV48OP/28RV
	 OkMVpmhw3A7pDcvXLXghVWxdfXLivy+g0kFW/AqTuTM2KrGXg3yriS/uCer92lCxmY
	 ATtaEfSWslaUSIHQYJ5kjLQ5JB5NKSjP1dF8bkCttPzEHAG2BjNbMbk/DD3ezcizU8
	 94ZH+UtdtTG3rzgfBRU/yDQPZf2iTLRARvUeNB4q7m4eRlPtIFyCra7vIl39a17JqH
	 ZOuSP8xUYfBlmygzCKMTa9PauP/Ef8+VlKwVzTQOE36Nq7OdhWD+6hfN2msCg9PevG
	 GEoBJoiOhAYcQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id A31FC1980076;
	Sun, 16 Aug 2026 09:50:23 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Sun, 16 Aug 2026 09:50:23 -0400
X-ME-Sender: <xms:HMCBaj8MmMMSM58_TpHgEg_r7Q-W3boY-6Pb3O_fV8ICFKBaguNcbQ>
    <xme:HMCBaqikYKq0Jot5Qcl4cJC7bj8YiUJjBwUGNtbLNF-cSb9ddjhpclAQwFqDP46Ap
    fEqWelQenpulXCu4p_hk22L7cRnqKO-jrLbanmBOsXnyLMmYE8F5r0>
X-ME-Proxy-Cause: dmFkZTGb1X/WDK3B1kqNVZGgj/Uja1AIyRukPn9r3LxdoFoCkzeogKnu9BXt+J4uE5f6IW
    33jKuRNDYbGZ1lad8kIBDDo8kmT5yelgcZ53lgX6Fbba6LNgzIXNgO4poFZtknzTVXxT4l
    pA51DZGD0rpQIf+6zm9vJQ7BpIOTTUf+OGTmUFhChQE/OtXChK+7BrUzllPQlVg7c9EWEd
    993hVi6pYHuikNet4kyAMWu/OcesyaDBnnXe8BUazHHlFC+AY0NSuaylojhuXit5beDxcV
    RzNt0wfiQGmjoBI46hncd2GcvwVMEjaY6nqOcUGyQKtzJvkbh+R+QVHBIhApgHN6Qq4mdR
    D/RU7VnSakaRkBviGFoQKe/ZvewjP+fJl/SnFTZENgF3xo1ihweVWSq8epC4EMz8qfbopZ
    w+8D+G03l1HlrwuUdMLMmeS36zPzUeEoip96avFS2+hs4tJ2uCIgELyl+n1ej8YZWWB8Td
    UhTXGxm0jRaadZhwVFhL2kixUvoDUY1LOH/xJovO9H8JFbkrk05wx3jHOWzvp3Zh4lPUnK
    hi+Gyi7HGwpnanHLnMRKeU4Sszf0VbB39fBTvQWlnYw6e+XHVlqqwgjG0/U0in/wMPvMzB
    VR6ZmVQzMJML+i2LYQ3GV6LwA2BFMs6X+LBa1uDFBrTfNSaJ7wyV+0iWHU1Q
X-ME-Proxy: <xmx:H8CBarB1K6QZX9hNSZOzbVwQ_ZEJuZrRIIIvms9oOVwP7gCP6Zpgyw>
    <xmx:H8CBaq6H4-FWY6Ow6kWIdR7Eb_55AWDcIygFTBiOi_GWhR2eVAmlLA>
    <xmx:H8CBavFWLmJ7YizIYEbIKAvgHrHk5d3VYpB67D-H-p1LwNZy5hgOgA>
    <xmx:H8CBatQIPNBcSZiEHxmRZdyg3gDXNi88QDevf1Gbvl35kHgL-m2uwg>
    <xmx:H8CBahdAm3MwCJb5BWJya7mpu4UU81ztFnMSHSkz5SFRvmnMNdKSeedi>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B6073F80070; Sun, 16 Aug 2026 09:50:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 16:49:59 +0300
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Will Deacon" <will@kernel.org>
Cc: "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
 "Song Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>, "Kees Cook" <kees@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, linux-toolchains@vger.kernel.org
Message-Id: <6c7153d7-67d1-46ce-afb0-688fca871c66@app.fastmail.com>
In-Reply-To: <aoGFxycNrA0p-H4T@willie-the-truck>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
 <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>
 <aoGFxycNrA0p-H4T@willie-the-truck>
Subject: Re: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted landing
 pads in Clang 21
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, 16 Aug 2026, at 12:41, Will Deacon wrote:
> Hi Josh, Ard,
>
> On Sat, Aug 15, 2026 at 12:56:11PM +0300, Ard Biesheuvel wrote:
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
> Sorry to jump in here, but I couldn't figure out a better place to get
> involved as we have a few threads on this now.
>
> Overall, it seems to me like there are three cases we need to consider
> for re-enabling BTI in the kernel:
>
> 1. A cross-section call that spans beyond the 128M range and therefore
>    needs a veneer. I think the static linker should resolve this, probably
>    by emitting a second veneer with the landing pad. Do we know if LLD
>    gets this right?
>

There are two variants here:

A cross-section call .init.text to .text that spans beyond the 128M range:

1a. inside vmlinux, which should be dealt with by the linker, but which might
be unreliable in practice due to the lack of BTI annotations in asm files,
missing exec permissions on ELF sections etc. This is addressed by this series,
but is only an issue for unusually large kernel images (e.g., allyesconfig).

1b. inside a module, which the toolchains's static linker cannot be expected to
deal with, given that modules are not fully linked executables. Therefore, the
module loader should deal with this, which is what my patch [0] implements. Note
that this only occurs when .init.text ends up far away from the .text section of
the same module, which occurs rarely in practice.

> 2. Calls from modules to exported symbols that end up going via a PLT
>    due to module placement. Exported symbols shouldn't be static, so we
>    should have the correct BTI landing pad in this case (and if we don't,
>    we should fix EXPORT_SYMBOL() to add it).
>

This is not an issue today as far as I am aware.

> 3. The livepatch case where a module appears to branch directly to
>    static functions in the kernel. For this, I frankly think we should
>    either make in-kernel BTI depend on !LIVEPATCH _or_ pass some compiler
>    option (tbd) when livepatch is enabled so that we get landing pads
>    for static functions (which is what I believe Clang/GCC used to do?).
>

The livepatch practice of lifting code out of vmlinux at function
granularity and copying it into KLP modules in order to patch a running
kernel is so far removed from the typical usage expected by the toolchain
that it is justified to treat it as a separate case. Working with the
compiler folks to allow this optimization to be disabled would be one way
to deal with this (and disabling kernel mode BTI for compilers that do
not implement it)

That said, my patch [0] only fixes case 1b., which is quite rare in 
practice, and could perhaps be eliminated entirely if we manage to tweak
the module loader so that it always allocates .text and .init.text from
the same region. (I haven't checked whether this is feasible at all tbh)

If we decide that the KLP case is worth fixing too, and tweaking the module
loader is impractical, I think we should rely on the same logic for case 1b
(I mistakenly thought that it doesn't work for that case but Josh pointed
out that the 256M allocation window around the branch target should be
large enough to ensure that a veneer can be allocated within direct
branching range)

Whatever we end up doing, we might still consider my approach as a temp
solution that can be backported if desired.


[0] https://lore.kernel.org/linux-arm-kernel/20260812162058.612202-4-ardb@kernel.org/
