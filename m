Return-Path: <SRS0=l7hJ=YH=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D460ECE587
	for <live-patching@archiver.kernel.org>; Mon, 14 Oct 2019 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE521835
	for <live-patching@archiver.kernel.org>; Mon, 14 Oct 2019 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfJNO0Y (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:26:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732262AbfJNO0Y (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 14 Oct 2019 10:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDACCB8F7;
        Mon, 14 Oct 2019 14:26:20 +0000 (UTC)
Date:   Mon, 14 Oct 2019 16:26:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     rostedt@goodmis.org, jikos@kernel.org, joe.lawrence@redhat.com,
        jpoimboe@redhat.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191014142620.dg3oiush5twd26ly@pathway.suse.cz>
References: <20191014105923.29607-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014105923.29607-1-mbenes@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon 2019-10-14 12:59:23, Miroslav Benes wrote:
> Livepatch uses ftrace for redirection to new patched functions. It means
> that if ftrace is disabled, all live patched functions are disabled as
> well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
> It is not a problem per se, because only administrator can set sysctl
> values, but it still may be surprising.
> 
> Introduce PERMANENT ftrace_ops flag to amend this. If the
> FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
> disabled by disabling ftrace_enabled. Equally, a callback with the flag
> set cannot be registered if ftrace_enabled is disabled.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Looks fine to me. I finally understand which ftrace_enabled toggle
we are talking about ;-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

> ---
> - return codes. I chose EBUSY, because it seemed the least
>   inappropriate. I usually pick the wrong one, so suggestions are
>   welcome.

-EBUSY is perfectly fine in ftrace_enable_sysctl(). It is not ideal
in __register_ftrace_function(). But it still looks better than
-ENODEV there.

Best Regards,
Petr
