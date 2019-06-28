Return-Path: <SRS0=U5CS=U3=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE5BC4321A
	for <live-patching@archiver.kernel.org>; Fri, 28 Jun 2019 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD32208E3
	for <live-patching@archiver.kernel.org>; Fri, 28 Jun 2019 10:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfF1KyQ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:54:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfF1KyQ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 28 Jun 2019 06:54:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9E76AAFD;
        Fri, 28 Jun 2019 10:54:14 +0000 (UTC)
Date:   Fri, 28 Jun 2019 12:54:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        torvalds@linux-foundation.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org
Subject: Re: [PATCH] ftrace/x86: Add a comment to why we take text_mutex in
 ftrace_arch_code_modify_prepare()
Message-ID: <20190628105414.kp5xfiss3lpmnncj@pathway.suse.cz>
References: <20190627211819.5a591f52@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627211819.5a591f52@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu 2019-06-27 21:18:19, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Taking the text_mutex in ftrace_arch_code_modify_prepare() is to fix a
> race against module loading and live kernel patching that might try to
> change the text permissions while ftrace has it as read/write. This
> really needs to be documented in the code. Add a comment that does such.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
