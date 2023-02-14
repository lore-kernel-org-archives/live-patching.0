Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6ACC6379F
	for <live-patching@archiver.kernel.org>; Tue, 14 Feb 2023 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBNQRA (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBNQQ7 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 14 Feb 2023 11:16:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137261BD5;
        Tue, 14 Feb 2023 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dpIV7HFvTBptLxvYA+cbtlV6RfJtdlRwQOAHw+6iYNE=; b=T81iqSdlOp17Qfz2KOT4fZinQu
        5G+uqKuA0p0kmG5n9XZMva1mnHYTMsEXHGoWriilj0+j8XO9uIjt7CGTs01WrifhFi1VW2pqsGxwu
        Wf9MH4VgHubs1QS9kEyXBxLeof7t+g24nIFE/ut765wkf5SPMZBVWhye+n5+NCOiMbBNKeHL1b1oa
        P16ZnafZPhcbknMCkZ/psAdG1760j8mHbvf3sd+DlstzfDRX4pp9tx8BPzPwYVWi0ZOqLmHEQitPo
        iIBjp1Z80c2MWjmb0HhI8qw86sIadsKWTsutSj4MokM8XnIAcmyTEhFuM3LlxZ4a8c6MBkKBrhPxM
        kyRKVw3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRxyQ-009gLN-2s;
        Tue, 14 Feb 2023 16:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A131302E5E;
        Tue, 14 Feb 2023 13:08:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5967123BDB60B; Tue, 14 Feb 2023 13:08:22 +0100 (CET)
Date:   Tue, 14 Feb 2023 13:08:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Song Liu <song@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/3] livepatch,sched: Add livepatch task switching to
 cond_resched()
Message-ID: <Y+t5tmbmKaUwNzdJ@hirez.programming.kicks-ass.net>
References: <cover.1675969869.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675969869.git.jpoimboe@kernel.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, Feb 09, 2023 at 11:17:46AM -0800, Josh Poimboeuf wrote:
> Fix patching stalls caused by busy kthreads.
> 
> Josh Poimboeuf (3):
>   livepatch: Skip task_call_func() for current task
>   livepatch,sched: Add livepatch task switching to cond_resched()
>   vhost: Fix livepatch timeouts in vhost_worker()

Seems reasonable, you want me to take them through the sched tree?
