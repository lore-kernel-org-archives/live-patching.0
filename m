Return-Path: <SRS0=U5CS=U3=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFAC4321A
	for <live-patching@archiver.kernel.org>; Fri, 28 Jun 2019 13:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13C2083B
	for <live-patching@archiver.kernel.org>; Fri, 28 Jun 2019 13:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1Ny2 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfF1Ny2 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 28 Jun 2019 09:54:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C68B208E3;
        Fri, 28 Jun 2019 13:54:26 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:54:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] ftrace: Remove possible deadlock between
 register_kprobe() and ftrace_run_update_code()
Message-ID: <20190628095424.1be42e21@gandalf.local.home>
In-Reply-To: <20190628105232.6arwis5u33li6twr@pathway.suse.cz>
References: <20190627081334.12793-1-pmladek@suse.com>
        <alpine.LSU.2.21.1906280928410.17146@pobox.suse.cz>
        <20190628105232.6arwis5u33li6twr@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, 28 Jun 2019 12:52:32 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Fri 2019-06-28 09:32:03, Miroslav Benes wrote:
> > On Thu, 27 Jun 2019, Petr Mladek wrote:  
> > > @@ -2611,12 +2610,10 @@ static void ftrace_run_update_code(int command)
> > >  {
> > >  	int ret;
> > >  
> > > -	mutex_lock(&text_mutex);
> > > -
> > >  	ret = ftrace_arch_code_modify_prepare();
> > >  	FTRACE_WARN_ON(ret);
> > >  	if (ret)
> > > -		goto out_unlock;
> > > +		return ret;  
> > 
> > Should be just "return;", because the function is "static void".  
> 
> Grr, I usually check compiler warnings but I evidently skipped it
> in this case :-(
> 
> Steven, should I send a fixed/folloup patch or will you just
> fix it when pushing?
> 

I'll fix it up.

-- Steve
