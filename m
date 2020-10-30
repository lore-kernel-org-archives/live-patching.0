Return-Path: <SRS0=ySN2=EF=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE89C00A89
	for <live-patching@archiver.kernel.org>; Fri, 30 Oct 2020 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B3820825
	for <live-patching@archiver.kernel.org>; Fri, 30 Oct 2020 09:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJ3JtB (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:49:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgJ3JtB (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 30 Oct 2020 05:49:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51838AC77;
        Fri, 30 Oct 2020 09:48:59 +0000 (UTC)
Date:   Fri, 30 Oct 2020 10:48:58 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 6/9] livepatch/ftrace: Add recursion protection to the
 ftrace callback
In-Reply-To: <20201029142406.3c46855a@gandalf.local.home>
Message-ID: <alpine.LSU.2.21.2010301048080.22360@pobox.suse.cz>
References: <20201028115244.995788961@goodmis.org> <20201028115613.291169246@goodmis.org> <alpine.LSU.2.21.2010291443310.1688@pobox.suse.cz> <20201029145709.GD16774@alley> <20201029142406.3c46855a@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

> > > > +	bit = ftrace_test_recursion_trylock();
> > > > +	if (bit < 0)
> > > > +		return;  
> > > 
> > > This means that the original function will be called in case of recursion. 
> > > That's probably fair, but I'm wondering if we should at least WARN about 
> > > it.  
> > 
> > Yeah, the early return might break the consistency model and
> > unexpected things might happen. We should be aware of it.
> > Please use:
> > 
> > 	if (WARN_ON_ONCE(bit < 0))
> > 		return;
> > 
> > WARN_ON_ONCE() might be part of the recursion. But it should happen
> > only once. IMHO, it is worth the risk.
> > 
> > Otherwise it looks good.
> 
> Perhaps we can add that as a separate patch, because this patch doesn't add
> any real functionality change. It only moves the recursion testing from the
> helper function (which ftrace wraps all callbacks that do not have the
> RECURSION flags set, including this one) down to your callback.
> 
> In keeping with one patch to do one thing principle, the added of
> WARN_ON_ONCE() should be a separate patch, as that will change the
> functionality.
> 
> If that WARN_ON_ONCE() breaks things, I'd like it to be bisected to another
> patch other than this one.

Works for me.

Miroslav
