Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BCCC77B72
	for <live-patching@archiver.kernel.org>; Mon, 17 Apr 2023 07:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQHsd (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDQHsd (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 17 Apr 2023 03:48:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C4199F
        for <live-patching@vger.kernel.org>; Mon, 17 Apr 2023 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=16wShpQ2SZ9Pjr/snGdPBKPeyE71nS1YfqyKAcr8MCQ=; b=Qgv9m4PiJiklOuj22tOgf6Luoy
        7wZB9bA7kHfqb0YGHoVkrgCZWw7PbuRqgP6EpLi9ymEPqdKGeoHcoXZPHpHupk6mYxVuwDxyC3Hm3
        hQaaElJk3TZH4RyRpt/eKrY2cKW/GOuV5hZUz70tDmQB1S64RakqirojU9fi9iu7pETZcp+xXxV0o
        ojrYU5RdwcoTJSkthJQ+W6aw5EmOq0pYBULDnvzpUThbeSsz7EzuRRnUwejoXtJJfwJdeKOZiPGnZ
        g1oVBoSpq8tIzvlnZyeR/GrPOUImV0F1u1HYZHYIFPCHjL/HF4n0TxuNrgYRT5lBaD6xbqhD9gznD
        EAM/6vLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poJav-00B6a3-66; Mon, 17 Apr 2023 07:48:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6810300237;
        Mon, 17 Apr 2023 09:48:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4992B23EAE806; Mon, 17 Apr 2023 09:48:11 +0200 (CEST)
Date:   Mon, 17 Apr 2023 09:48:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com, nstange@suse.de,
        mpdesouza@suse.de, broonie@kernel.org,
        live-patching@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: Live Patching Microconference at Linux Plumbers
Message-ID: <20230417074811.GE83892@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.21.2303291339090.21599@pobox.suse.cz>
 <ZDkif0cu/jh/KKC+@FVFF77S0Q05N>
 <20230414171255.oylmsdizl4waao4t@treble>
 <20230414193013.GB778423@hirez.programming.kicks-ass.net>
 <20230415043949.7y4tvshe26zday3e@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415043949.7y4tvshe26zday3e@treble>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, Apr 14, 2023 at 09:39:49PM -0700, Josh Poimboeuf wrote:

> Instead, the idea is for objtool to continue to reverse-engineer the CFG
> as it does today (albeit with a little help from the compiler in
> specific problematic areas, e.g. noreturns and jump tables).

Yes, that would be best. I was merely suggesting that as a stop gap
measure -- until compilers can get us this -- we might perhaps
optionally extract this from DWARF.

But yeah, I'm not a great fan of using DWARF as input for this either.
