Return-Path: <SRS0=jwLI=YI=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAE3C10F14
	for <live-patching@archiver.kernel.org>; Tue, 15 Oct 2019 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497E02054F
	for <live-patching@archiver.kernel.org>; Tue, 15 Oct 2019 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfJOONq (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:13:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732500AbfJOONq (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 15 Oct 2019 10:13:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30A43B450;
        Tue, 15 Oct 2019 14:13:44 +0000 (UTC)
Date:   Tue, 15 Oct 2019 16:13:41 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
In-Reply-To: <20191015135634.GK2328@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.1910151611000.13169@pobox.suse.cz>
References: <20191007081945.10951536.8@infradead.org> <20191008104335.6fcd78c9@gandalf.local.home> <20191009224135.2dcf7767@oasis.local.home> <20191010092054.GR2311@hirez.programming.kicks-ass.net> <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net> <20191010115449.22044b53@gandalf.local.home> <20191010172819.GS2328@hirez.programming.kicks-ass.net> <20191011125903.GN2359@hirez.programming.kicks-ass.net> <20191015130739.GA23565@linux-8ccs>
 <20191015135634.GK2328@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

[ live-patching ML CCed ]

On Tue, 15 Oct 2019, Peter Zijlstra wrote:

> On Tue, Oct 15, 2019 at 03:07:40PM +0200, Jessica Yu wrote:
> 
> > > The fact that it is executable; also the fact that you do it right after
> > > we mark it ro. Flipping the memory protections back and forth is just
> > > really poor everything.
> > > 
> > > Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
> > > executable (kernel) memory writable.
> > 
> > Not sure if relevant, but just thought I'd clarify: IIRC,
> > klp_module_coming() is not poking the coming module, but it calls
> > module_enable_ro() on itself (the livepatch module) so it can apply
> > relocations and such on the new code, which lives inside the livepatch
> > module, and it needs to possibly do this numerous times over the
> > lifetime of the patch module for any coming module it is responsible
> > for patching (i.e., call module_enable_ro() on the patch module, not
> > necessarily the coming module). So I am not be sure why
> > klp_module_coming() should be moved before complete_formation(). I
> > hope I'm remembering the details correctly, livepatch folks feel free
> > to chime in if I'm incorrect here.
> 
> You mean it does module_disable_ro() ? That would be broken and it needs
> to be fixed. Can some livepatch person explain what it does and why?

Yes, it does. klp_module_coming() calls module_disable_ro() on all 
patching modules which patch the coming module in order to call 
apply_relocate_add(). New (patching) code for a module can be relocated 
only when the relevant module is loaded.

Miroslav
