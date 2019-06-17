Return-Path: <SRS0=wi0d=UQ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2235C46477
	for <live-patching@archiver.kernel.org>; Mon, 17 Jun 2019 11:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7672087F
	for <live-patching@archiver.kernel.org>; Mon, 17 Jun 2019 11:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfFQLQ2 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:16:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbfFQLQ2 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 17 Jun 2019 07:16:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D9A6AEC5;
        Mon, 17 Jun 2019 11:16:27 +0000 (UTC)
Date:   Mon, 17 Jun 2019 13:16:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>, jpoimboe@redhat.com,
        jikos@kernel.org, joe.lawrence@redhat.com,
        kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] stacktrace: Remove weak version of
 save_stack_trace_tsk_reliable()
Message-ID: <20190617111626.vkqayqf3tvleff37@pathway.suse.cz>
References: <20190611141320.25359-1-mbenes@suse.cz>
 <20190611141320.25359-2-mbenes@suse.cz>
 <alpine.DEB.2.21.1906161044490.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906161044490.1760@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Thomas,

On Sun 2019-06-16 10:44:59, Thomas Gleixner wrote:
> On Tue, 11 Jun 2019, Miroslav Benes wrote:
> 
> > Recent rework of stack trace infrastructure introduced a new set of
> > helpers for common stack trace operations (commit e9b98e162aa5
> > ("stacktrace: Provide helpers for common stack trace operations") and
> > related). As a result, save_stack_trace_tsk_reliable() is not directly
> > called anywhere. Livepatch, currently the only user of the reliable
> > stack trace feature, now calls stack_trace_save_tsk_reliable().
> > 
> > When CONFIG_HAVE_RELIABLE_STACKTRACE is set and depending on
> > CONFIG_ARCH_STACKWALK, stack_trace_save_tsk_reliable() calls either
> > arch_stack_walk_reliable() or mentioned save_stack_trace_tsk_reliable().
> > x86_64 defines the former, ppc64le the latter. All other architectures
> > do not have HAVE_RELIABLE_STACKTRACE and include/linux/stacktrace.h
> > defines -ENOSYS returning version for them.
> > 
> > In short, stack_trace_save_tsk_reliable() returning -ENOSYS defined in
> > include/linux/stacktrace.h serves the same purpose as the old weak
> > version of save_stack_trace_tsk_reliable() which is therefore no longer
> > needed.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Would you like to push this patch via your tree?
Or is it OK to push it via the livepatch tree for 5.3?

Best Regards,
Petr
