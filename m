Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88163C63697
	for <live-patching@archiver.kernel.org>; Thu, 19 Nov 2020 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37451246D1
	for <live-patching@archiver.kernel.org>; Thu, 19 Nov 2020 14:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKSOMk (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 19 Nov 2020 09:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgKSOMj (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 19 Nov 2020 09:12:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DE224655;
        Thu, 19 Nov 2020 14:12:37 +0000 (UTC)
Date:   Thu, 19 Nov 2020 09:12:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org
Subject: Re: [PATCH 3/3 v7] livepatch: Use the default ftrace_ops instead of
 REGS when ARGS is available
Message-ID: <20201119091235.60be696e@gandalf.local.home>
In-Reply-To: <X7ZcYIWJEPXW6Z9s@alley>
References: <20201113171811.288150055@goodmis.org>
        <20201113171939.455339580@goodmis.org>
        <X7ZcYIWJEPXW6Z9s@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 19 Nov 2020 12:52:00 +0100
Petr Mladek <pmladek@suse.com> wrote:

> >  #ifdef CONFIG_LIVEPATCH
> > -static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> > +static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
> >  {
> > +	struct pt_regs *regs = ftrace_get_regs(fregs);  
> 
> Should we check for NULL pointer here?

As mentioned in my last email. regs could have been NULL for the same
reasons before this patch, and we didn't check it then. Why should we check
it now?

The ftrace_get_regs() only makes sure that a ftrace_ops that set
FL_SAVE_REGS gets it, and those that did not, don't.

But that's not entirely true either. If there's two callbacks to the same
function, and one has FL_SAVE_REGS set, they both can have access to the
regs (before and after this patch). It's just that the one that did not
have FL_SAVE_REGS set, isn't guaranteed to have it.

-- Steve


> 
> > +
> >  	regs->nip = ip;
> >  }
