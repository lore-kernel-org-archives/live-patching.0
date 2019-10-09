Return-Path: <SRS0=Zi6u=YC=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E0ECE58D
	for <live-patching@archiver.kernel.org>; Wed,  9 Oct 2019 11:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B45B2133F
	for <live-patching@archiver.kernel.org>; Wed,  9 Oct 2019 11:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJILWg (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:22:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbfJILWg (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 9 Oct 2019 07:22:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF103AF05;
        Wed,  9 Oct 2019 11:22:34 +0000 (UTC)
Date:   Wed, 9 Oct 2019 13:22:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, rostedt@goodmis.org,
        jikos@kernel.org, jpoimboe@redhat.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191009112234.bi7lvp4pvmna26vz@pathway.suse.cz>
References: <20191007081714.20259-1-mbenes@suse.cz>
 <20191008193534.GA16675@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008193534.GA16675@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue 2019-10-08 15:35:34, Joe Lawrence wrote:
> On Mon, Oct 07, 2019 at 10:17:11AM +0200, Miroslav Benes wrote:
> > Livepatch uses ftrace for redirection to new patched functions. It is
> > thus directly affected by ftrace sysctl knobs such as ftrace_enabled.
> > Setting ftrace_enabled to 0 also disables all live patched functions. It
> > is not a problem per se, because only administrator can set sysctl
> > values, but it still may be surprising.
> > 
> > Introduce PERMANENT ftrace_ops flag to amend this. If the
> > FTRACE_OPS_FL_PERMANENT is set, the tracing of the function is not
> > disabled. Such ftrace_ops can still be unregistered in a standard way.
> > 
> > The patch set passes ftrace and livepatch kselftests.
> > 
> > Miroslav Benes (3):
> >   ftrace: Make test_rec_ops_needs_regs() generic
> >   ftrace: Introduce PERMANENT ftrace_ops flag
> >   livepatch: Use FTRACE_OPS_FL_PERMANENT
> > 
> >  Documentation/trace/ftrace-uses.rst |  6 ++++
> >  Documentation/trace/ftrace.rst      |  2 ++
> >  include/linux/ftrace.h              |  8 +++--
> >  kernel/livepatch/patch.c            |  3 +-
> >  kernel/trace/ftrace.c               | 47 ++++++++++++++++++++++++-----
> >  5 files changed, 55 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.23.0
> > 
> 
> Hi Miroslav,
> 
> I wonder if the opposite would be more intuitive: when ftrace_enabled is
> not set, don't allow livepatches to register ftrace filters and
> likewise, don't allow ftrace_enabled to be unset if any livepatches are
> already registered.  I guess you could make an argument either way, but
> just offering another option.  Perhaps livepatches should follow similar
> behavior of other ftrace clients (like perf probes?)

I am not sure that I understand it correctly.

ftrace_enables is a global flag. My expectation is that it can be
manipulated at any time. But it should affect only ftrace handlers
without FTRACE_OPS_FL_PERMANENT flag.

By other words, the handlers with FTRACE_OPS_FL_PERMANENT flag and
only these handlers should ignore the global flag.

To be even more precise. If a function has registered more ftrace
handlers then the global ftrace_enable setting shold affect only
the handlers without the flag.

Is this the plan, please?

Best Regards,
Petr
