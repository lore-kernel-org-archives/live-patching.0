Return-Path: <SRS0=4WRz=56=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C01C2BA19
	for <live-patching@archiver.kernel.org>; Tue, 14 Apr 2020 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352E32063A
	for <live-patching@archiver.kernel.org>; Tue, 14 Apr 2020 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CzGrac61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502186AbgDNRoe (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:44:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502164AbgDNRod (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 14 Apr 2020 13:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Af8lJ0Q2s1M3sb97EdyeWvWIG/dElM2CzH7yymWGsh0=; b=CzGrac61uE2SZOlx/djVUAq2cb
        TelWTgDV4XsyQXfPmf/hj9f+Qf8eaZ3WwCcXJW8aAE+E2bVmHg1rFwUS+OWk5CtlZGn2b04YYgNZI
        PNUPpqkSQp+d8K3l+R7jrZdsjLIZZ5KDobAVPMJsTy1c0j1lVyYffKsKqRk5Jm3C8pAAuJr0vppY3
        wZ+Frk1DgBPEGp7LKtBhl75zvay0KKZoT87SwYva3mwgDJk4mS6bIs9havJXN9yBXGI4h8bOhR4Zg
        2WEO4xgdcAZQk/ciMrSwg3vtOgUY9b5iM0HNw1M17HKtNkLiNhNlIYSDEDV2Z0vTEnX6nkSw79tzN
        UYL1J2xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOPbW-0001gA-Mw; Tue, 14 Apr 2020 17:44:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7E59981086; Tue, 14 Apr 2020 19:44:06 +0200 (CEST)
Date:   Tue, 14 Apr 2020 19:44:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 1/7] livepatch: Apply vmlinux-specific KLP relocations
 early
Message-ID: <20200414174406.GC2483@worktop.programming.kicks-ass.net>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <8c3af42719fe0add37605ede634c7035a90f9acc.1586881704.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3af42719fe0add37605ede634c7035a90f9acc.1586881704.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, Apr 14, 2020 at 11:28:37AM -0500, Josh Poimboeuf wrote:
> KLP relocations are livepatch-specific relocations which are applied to
>   1) vmlinux-specific KLP relocation sections
> 
>      .klp.rela.vmlinux.{sec}
> 
>      These are relocations (applied to the KLP module) which reference
>      unexported vmlinux symbols.
> 
>   2) module-specific KLP relocation sections
> 
>      .klp.rela.{module}.{sec}:
> 
>      These are relocations (applied to the KLP module) which reference
>      unexported or exported module symbols.

Is there something that disallows a module from being called 'vmlinux' ?
If not, we might want to enforce this somewhere.
