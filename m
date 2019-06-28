Return-Path: <SRS0=U5CS=U3=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64376C4321A
	for <live-patching@archiver.kernel.org>; Fri, 28 Jun 2019 10:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81E208E3
	for <live-patching@archiver.kernel.org>; Fri, 28 Jun 2019 10:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF1Kwe (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfF1Kwe (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 28 Jun 2019 06:52:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D15AB14C;
        Fri, 28 Jun 2019 10:52:33 +0000 (UTC)
Date:   Fri, 28 Jun 2019 12:52:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Johannes Erdfelt <johannes@erdfelt.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] ftrace: Remove possible deadlock between
 register_kprobe() and ftrace_run_update_code()
Message-ID: <20190628105232.6arwis5u33li6twr@pathway.suse.cz>
References: <20190627081334.12793-1-pmladek@suse.com>
 <alpine.LSU.2.21.1906280928410.17146@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1906280928410.17146@pobox.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri 2019-06-28 09:32:03, Miroslav Benes wrote:
> On Thu, 27 Jun 2019, Petr Mladek wrote:
> > @@ -2611,12 +2610,10 @@ static void ftrace_run_update_code(int command)
> >  {
> >  	int ret;
> >  
> > -	mutex_lock(&text_mutex);
> > -
> >  	ret = ftrace_arch_code_modify_prepare();
> >  	FTRACE_WARN_ON(ret);
> >  	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> 
> Should be just "return;", because the function is "static void".

Grr, I usually check compiler warnings but I evidently skipped it
in this case :-(

Steven, should I send a fixed/folloup patch or will you just
fix it when pushing?

Best Regards,
Petr
