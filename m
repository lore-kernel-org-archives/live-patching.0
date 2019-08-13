Return-Path: <SRS0=avim=WJ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0522CC433FF
	for <live-patching@archiver.kernel.org>; Tue, 13 Aug 2019 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D627520679
	for <live-patching@archiver.kernel.org>; Tue, 13 Aug 2019 10:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfHMK0Y (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:26:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727416AbfHMK0Y (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 13 Aug 2019 06:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE3C4ACEC;
        Tue, 13 Aug 2019 10:26:22 +0000 (UTC)
Date:   Tue, 13 Aug 2019 12:26:17 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] modpost: Add modinfo flag to livepatch
 modules
In-Reply-To: <CAK7LNAQuS-YcXecfJ21BGzc0CimzWxQcYST5-1xRgnCQGtcL4A@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.1908131224330.10477@pobox.suse.cz>
References: <20190509143859.9050-1-joe.lawrence@redhat.com> <20190509143859.9050-7-joe.lawrence@redhat.com> <CAK7LNAQuS-YcXecfJ21BGzc0CimzWxQcYST5-1xRgnCQGtcL4A@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, 31 Jul 2019, Masahiro Yamada wrote:

> Hi Joe,
> 
> 
> On Thu, May 9, 2019 at 11:39 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >
> > From: Miroslav Benes <mbenes@suse.cz>
> >
> > Currently, livepatch infrastructure in the kernel relies on
> > MODULE_INFO(livepatch, "Y") statement in a livepatch module. Then the
> > kernel module loader knows a module is indeed livepatch module and can
> > behave accordingly.
> >
> > klp-convert, on the other hand relies on LIVEPATCH_* statement in the
> > module's Makefile for exactly the same reason.
> >
> > Remove dependency on modinfo and generate MODULE_INFO flag
> > automatically in modpost when LIVEPATCH_* is defined in the module's
> > Makefile. Generate a list of all built livepatch modules based on
> > the .livepatch file and store it in (MODVERDIR)/livepatchmods. Give
> > this list as an argument for modpost which will use it to identify
> > livepatch modules.
> >
> > As MODULE_INFO is no longer needed, remove it.
> 
> 
> I do not understand this patch.
> This makes the implementation so complicated.
> 
> I think MODULE_INFO(livepatch, "Y") is cleaner than
> LIVEPATCH_* in Makefile.
> 
> 
> How about this approach?
> 
> 
> [1] Make modpost generate the list of livepatch modules.
>     (livepatch-modules)
> 
> [2] Generate Symbols.list in scripts/Makefile.modpost
>     (vmlinux + modules excluding livepatch-modules)
> 
> [3] Run klp-convert for modules in livepatch-modules.
> 
> 
> If you do this, you can remove most of the build system hacks
> can't you?
> 
> 
> I attached an example implementation for [1].
> 
> Please check whether this works.

Yes, it sounds like a better approach. I've never liked LIVEPATCH_* in 
Makefile much, so I'm all for dropping it.

Thanks
Miroslav
