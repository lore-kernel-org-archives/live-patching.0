Return-Path: <SRS0=KyT+=UZ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9FC48BD3
	for <live-patching@archiver.kernel.org>; Wed, 26 Jun 2019 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF8720645
	for <live-patching@archiver.kernel.org>; Wed, 26 Jun 2019 14:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZO7P (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfFZO7P (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 26 Jun 2019 10:59:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1098A20663;
        Wed, 26 Jun 2019 14:59:12 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:59:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@kernel.org>, mhiramat@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/3] module: Fix livepatch/ftrace module text
 permissions race
Message-ID: <20190626105911.16b1b225@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1906261643200.32342@nanos.tec.linutronix.de>
References: <cover.1560474114.git.jpoimboe@redhat.com>
        <ab43d56ab909469ac5d2520c5d944ad6d4abd476.1560474114.git.jpoimboe@redhat.com>
        <20190614170408.1b1162dc@gandalf.local.home>
        <alpine.LSU.2.21.1906260908170.22069@pobox.suse.cz>
        <20190626133721.ea2iuqqu4to2jpbv@pathway.suse.cz>
        <alpine.DEB.2.21.1906261643200.32342@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, 26 Jun 2019 16:44:45 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > 
> > It should be enough to fix the original problem because
> > x86 is the only architecture that calls set_all_modules_text_rw()
> > in ftrace path and supports livepatching at the same time.  
> 
> Looks correct, but I've paged out all the gory details vs. lock ordering in
> that area.

I don't believe ftrace_lock and text_mutex had an order before Petr's
initial patches. Reversing them shouldn't be an issue here. They were
basically both "leaf" mutexes (not grabbing any mutexes when they are
held).

-- Steve
