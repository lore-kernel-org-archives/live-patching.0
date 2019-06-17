Return-Path: <SRS0=wi0d=UQ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E9C31E57
	for <live-patching@archiver.kernel.org>; Mon, 17 Jun 2019 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5907A208E4
	for <live-patching@archiver.kernel.org>; Mon, 17 Jun 2019 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfFQL6v (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:58:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43504 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQL6v (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 17 Jun 2019 07:58:51 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcqHY-0006Ld-Kj; Mon, 17 Jun 2019 13:58:40 +0200
Date:   Mon, 17 Jun 2019 13:58:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
cc:     Miroslav Benes <mbenes@suse.cz>, jpoimboe@redhat.com,
        jikos@kernel.org, joe.lawrence@redhat.com,
        kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] stacktrace: Remove weak version of
 save_stack_trace_tsk_reliable()
In-Reply-To: <20190617111626.vkqayqf3tvleff37@pathway.suse.cz>
Message-ID: <alpine.DEB.2.21.1906171357160.1854@nanos.tec.linutronix.de>
References: <20190611141320.25359-1-mbenes@suse.cz> <20190611141320.25359-2-mbenes@suse.cz> <alpine.DEB.2.21.1906161044490.1760@nanos.tec.linutronix.de> <20190617111626.vkqayqf3tvleff37@pathway.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon, 17 Jun 2019, Petr Mladek wrote:
> On Sun 2019-06-16 10:44:59, Thomas Gleixner wrote:
> > On Tue, 11 Jun 2019, Miroslav Benes wrote:
> > 
> > > Recent rework of stack trace infrastructure introduced a new set of
> > > helpers for common stack trace operations (commit e9b98e162aa5
> > > ("stacktrace: Provide helpers for common stack trace operations") and
> > > related). As a result, save_stack_trace_tsk_reliable() is not directly
> > > called anywhere. Livepatch, currently the only user of the reliable
> > > stack trace feature, now calls stack_trace_save_tsk_reliable().
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Would you like to push this patch via your tree?
> Or is it OK to push it via the livepatch tree for 5.3?

Just pick it up. I don't think we have anything conflicting.

Thanks,

	tglx

