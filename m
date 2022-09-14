Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AEFC6FA8A
	for <live-patching@archiver.kernel.org>; Wed, 14 Sep 2022 14:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiINO4P (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiINO4K (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 14 Sep 2022 10:56:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B995549B53;
        Wed, 14 Sep 2022 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lALMKmdqPOn863q1KH2GHJFtFLSUGddYczxk7N3aI/M=; b=czTvweMUYoYEwwLa37VQmFT4n6
        yngz7eFZe9tSr77iA5R23q4p3rOTQ0tUEDmwtQ865Anxjj0hRK5lCOyoI41DeAX4Sbp0G9PJvf5zS
        kUJ7fsgOMtvDUbenfkNBESLno0UFnzzWqf0WZ3jEAlzoJvMpfFRsvfIXWaXHofc84YUdstmAeGSt/
        /VWUkFerFuOp0vVfysvRP+QjT2l4QLw4nudPPSkuUDuGF9Obnk9Ndpm8X5umKT9achMkhU35jb+Wg
        UfejWRl74GzEaZ36dbnwK0cWBDzKeijaPAWBD+mILYlVXI9R0o32CkIs7xdslXQJw8XtBhQDUzoLM
        AM/bI/KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYTnX-000GUH-OT; Wed, 14 Sep 2022 14:55:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A75AE3002AE;
        Wed, 14 Sep 2022 16:55:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BDA8201B3981; Wed, 14 Sep 2022 16:55:27 +0200 (CEST)
Date:   Wed, 14 Sep 2022 16:55:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Matz <matz@suse.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        linux-toolchains@vger.kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, "Jose E. Marchesi" <jemarch@gnu.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] Objtool toolchain proposal:
 -fannotate-{jump-table,noreturn}
Message-ID: <YyHrX/fTMwfv24W7@hirez.programming.kicks-ass.net>
References: <20220909180704.jwwed4zhwvin7uyi@treble>
 <Yx8PcldkdOLN8eaw@nazgul.tnic>
 <alpine.LSU.2.20.2209121200120.8265@wotan.suse.de>
 <20220914000416.daxbgccbxwpknn2q@treble>
 <YyHecBM8D0i1lRu8@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.20.2209141415340.8265@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2209141415340.8265@wotan.suse.de>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, Sep 14, 2022 at 02:28:26PM +0000, Michael Matz wrote:
> Hello,
> 
> On Wed, 14 Sep 2022, Peter Zijlstra wrote:
> 
> > > Maybe this is semantics, but I wouldn't characterize objtool's existence
> > > as being based on the mistrust of tools.  It's main motivation is to
> > > fill in the toolchain's blind spots in asm and inline-asm, which exist
> > > by design.
> > 
> > That and a fairly deep seated loathing for the regular CFI annotations
> > and DWARF in general. Linus was fairly firm he didn't want anything to
> > do with DWARF for in-kernel unwinding.
> 
> I was referring only to the check-stuff functionality of objtool, not to 
> its other parts.  Altough, of course, "deep seated loathing" is a special 
> form of mistrust as well ;-)

Those were born out the DWARF unwinder itself crashing the kernel due to
it's inherent complexity (tracking the whole DWARF state machine and not
being quite robust itself).

That, and the manual CFI annotations were 'always' wrong, due to humans
and no tooling verifying them.

That said; objtool does do have a number of annotations as well; mostly
things telling what kind of stackframe stuff starts with.

> > That left us in a spot that we needed unwind information in a 'better'
> > format than DWARF.
> > 
> > Objtool was born out of those contraints. ORC not needing the CFI
> > annotations and ORC being *much* faster at unwiding and generation
> > (debug builds are slow) were all good.
> 
> Don't mix DWARF debug info with DWARF-based unwinding info, the latter 
> doesn't imply the former.  Out of interest: how does ORC get around the 
> need for CFI annotations (or equivalents to restore registers) and what 

Objtool 'interprets' the stackops. So it follows the call-graph and is
an interpreter for all instructions that modify the stack. Doing that it
konws what the stackframe is at 'most' places.

> makes it fast?  I want faster unwinding for DWARF as well, when there's 
> feature parity :-)  Maybe something can be learned for integration into 
> dwarf-unwind.

I think we have some details here:

 https://www.kernel.org/doc/html/latest/x86/orc-unwinder.html
