Return-Path: <SRS0=8nqK=VW=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA8C76186
	for <live-patching@archiver.kernel.org>; Thu, 25 Jul 2019 00:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7B521911
	for <live-patching@archiver.kernel.org>; Thu, 25 Jul 2019 00:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564015400;
	bh=K8suSIkZbvT0UfyneKMgJFCJCtS7yG8oOJLvoqvjUxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WdhQZXWTm2O6FnDVW/74IXQeOeyWhUotglfs7dvOiyKmj8HYufigm7Fli259SOqWS
	 2mSIxpXqBnlleHt0m56mV81WZ/xTRJ8jnXyfX2SLrDljFmekNkCZnsGc32+ic65VJn
	 NmK8hJW1FX6JI8c+lEtwN4+zJ5Fyd8NvKVyMj0uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfGYAnU (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 24 Jul 2019 20:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387913AbfGYAnU (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 24 Jul 2019 20:43:20 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC4521901;
        Thu, 25 Jul 2019 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564015399;
        bh=K8suSIkZbvT0UfyneKMgJFCJCtS7yG8oOJLvoqvjUxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0SM0Rbw5qI6IKvksMncpNpSmkg3vyt+kn7m4AS5hdVepz+V0YFkVrB+PgbWS9Zaq
         3gEPAo/wJz3KPL+NYSKAwbXPKlco7lXaaHydtVfFBTEwUZAp/dBiyZIgyUpM8YXNUp
         EOv2wk5AcbNxxqvFi4kgXZqWK0DmsfcvAcCVi2mY=
Date:   Thu, 25 Jul 2019 09:43:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kprobes, livepatch and FTRACE_OPS_FL_IPMODIFY
Message-Id: <20190725094316.c6bf2524e4e925d9cc5937d1@kernel.org>
In-Reply-To: <20190725093208.343db9d54f6a0f5abc99af7b@kernel.org>
References: <20190724151942.GA7205@redhat.com>
        <20190725093208.343db9d54f6a0f5abc99af7b@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Joe,

On Thu, 25 Jul 2019 09:32:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> NO, that flag has been shared among all ftrace-based kprobes, and checked
> when registering. So what we need is to introduce a new kprobe flag which
> states that this kprobe doesn't modify regs->ip. And kprobe prepare 2 ftrace_ops
> 1 is for IPMODIFY and 1 is for !IPMODIFY.

Ah, OK. We don't even need the new flag.

-----
The jump optimization changes the kprobe's pre_handler behavior.
Without optimization, the pre_handler can change the kernel's execution
path by changing regs->ip and returning 1.  However, when the probe
is optimized, that modification is ignored.  Thus, if you want to
tweak the kernel's execution path, you need to suppress optimization,
using one of the following techniques:

- Specify an empty function for the kprobe's post_handler.

or

- Execute 'sysctl -w debug.kprobes_optimization=n'
-----

So if we remove latter one, all kprobes which change regs->ip must
set a dummy post_handler. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
