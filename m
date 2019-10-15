Return-Path: <SRS0=jwLI=YI=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2DEECE587
	for <live-patching@archiver.kernel.org>; Tue, 15 Oct 2019 07:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39F02086A
	for <live-patching@archiver.kernel.org>; Tue, 15 Oct 2019 07:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfJOHpm (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:45:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfJOHpm (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 15 Oct 2019 03:45:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB419AC59;
        Tue, 15 Oct 2019 07:45:40 +0000 (UTC)
Date:   Tue, 15 Oct 2019 09:45:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, jikos@kernel.org,
        joe.lawrence@redhat.com, jpoimboe@redhat.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191015074540.bxehllisibls3kk7@pathway.suse.cz>
References: <20191014105923.29607-1-mbenes@suse.cz>
 <20191014111719.141bd4fa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014111719.141bd4fa@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon 2019-10-14 11:17:19, Steven Rostedt wrote:
> On Mon, 14 Oct 2019 12:59:23 +0200
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
> >  int
> >  ftrace_enable_sysctl(struct ctl_table *table, int write,
> >  		     void __user *buffer, size_t *lenp,
> > @@ -6740,8 +6754,6 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
> >  	if (ret || !write || (last_ftrace_enabled == !!ftrace_enabled))
> >  		goto out;
> >  
> > -	last_ftrace_enabled = !!ftrace_enabled;
> > -
> >  	if (ftrace_enabled) {
> >  
> >  		/* we are starting ftrace again */
> > @@ -6752,12 +6764,19 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
> >  		ftrace_startup_sysctl();
> >  
> >  	} else {
> > +		if (is_permanent_ops_registered()) {
> > +			ftrace_enabled = last_ftrace_enabled;
> 
> Although this is not incorrect, but may be somewhat confusing.
> 
> At this location, last_ftrace_enabled is always true.
> 
> I'm thinking this would be better to simply set it to false here.

IMHO, we want to set ftrace_enabled = true here.

It was set to "false" by writing to the sysfs file. But the change
gets rejected. ftrace will stay enabled. So, we should set
the value back to "true".


> > +			ret = -EBUSY;
> > +			goto out;
> > +		}
> > +
> >  		/* stopping ftrace calls (just send to ftrace_stub) */
> >  		ftrace_trace_function = ftrace_stub;
> >  
> >  		ftrace_shutdown_sysctl();
> >  	}
> >  
> > +	last_ftrace_enabled = !!ftrace_enabled;
> >   out:
> 
> And move the assignment of last_ftrace_enabled to after the "out:"
> label.

This change might make sense anyway. But it is not strictly necessary
from my POV.

Best Regards,
Petr
