Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428CC77B71
	for <live-patching@archiver.kernel.org>; Fri, 14 Apr 2023 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDNVKl (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNVKk (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 14 Apr 2023 17:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC0849F3
        for <live-patching@vger.kernel.org>; Fri, 14 Apr 2023 14:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549CF64A5E
        for <live-patching@vger.kernel.org>; Fri, 14 Apr 2023 21:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22881C433EF;
        Fri, 14 Apr 2023 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681506638;
        bh=Yj74lMMQLMA8qZwcvcuOHrNUvWKpTKkemcoLYCT64dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7pjzvrJl1tvYeosb1aEsU+BevyAMTWTSL2MQy5Ev3aMoYi8Trh6msYQIINh5wt4J
         LM0fBUHhFhGLBD88M2nqnumG57Tt9fLuqrix8t+3wEYzRsBW1BO5ufFH4oYNYDlftr
         cD0lQWI+/HKFFfE9giO+7Ol2FJGVRMxqlGTSnqJu36hnBEuaAW5JKDTvUmJ+WKU6f5
         6Ih/a/NQUwjEu9XIa3GBK1U6viyyAzH8H7nlUsTEuliktXawJg9RB6jE8+EqJ4IJPK
         BVUFOBgxGozkKrTB+YReftLcd8oUluvJJz59VHzPiodahTNrmPUued7KtLyAbKy+A7
         gL+xF939IsYbQ==
Date:   Fri, 14 Apr 2023 14:10:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com, nstange@suse.de,
        mpdesouza@suse.de, broonie@kernel.org,
        live-patching@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Live Patching Microconference at Linux Plumbers
Message-ID: <20230414211036.n7bqag3n5s7szz3i@treble>
References: <alpine.LSU.2.21.2303291339090.21599@pobox.suse.cz>
 <ZDkif0cu/jh/KKC+@FVFF77S0Q05N>
 <20230414171255.oylmsdizl4waao4t@treble>
 <CANiq72mWVwNfbCiKWdyyX=LXMrXsndO6gnwz_0tgVRt9Nk1KzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mWVwNfbCiKWdyyX=LXMrXsndO6gnwz_0tgVRt9Nk1KzA@mail.gmail.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Apr 14, 2023 at 09:04:36PM +0200, Miguel Ojeda wrote:
> On Fri, Apr 14, 2023 at 7:12 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > Not to mention how objtool will react to compiled rust code (has it
> > already been tried?)
> 
> Rust uses LLVM, so it should be generally fine -- at least some of the
> checks appear to work. For instance, I can trigger:
> 
>       RUSTC L rust/kernel.o
>     rust/kernel.o: warning: objtool: .text+0x0: unreachable instruction
> 
>       RUSTC [M] samples/rust/rust_minimal.o
>     samples/rust/rust_minimal.o: warning: objtool:
> _R..._6kernel6Module4init+0x172: unreachable instruction
> 
> via a random instruction in the middle of nowhere in the former (with
> `global_asm!`) and a jumped-over instruction in the latter (with
> `asm!`).
> 
> Moreover, we were already getting warnings when rethunk / x86 IBT is
> enabled (since we got `objtool` called for `vmlinux.o`), e.g.
> 
>     vmlinux.o: warning: objtool: .rodata+0x18c58: data relocation to
> !ENDBR: _R...IsWhitespaceEEB4_+0x0
> 
>     vmlinux.o: warning: objtool: _R...into_foreign+0x5: 'naked' return
> found in RETHUNK build
> 
> I can send the patch to run it for all Rust object files via
> `$(cmd_objtool)`, unless you think it is a bad idea.

That's good to hear that it seems to just work.  Feel free to send a
patch to enable it for Rust objects, though I may need your help if we
see any odd warnings ;-)

-- 
Josh
