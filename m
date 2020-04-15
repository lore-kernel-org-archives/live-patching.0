Return-Path: <SRS0=H1Pz=57=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FBDC2BA19
	for <live-patching@archiver.kernel.org>; Wed, 15 Apr 2020 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140C42076D
	for <live-patching@archiver.kernel.org>; Wed, 15 Apr 2020 14:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbgDOOaV (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:30:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgDOOaT (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 15 Apr 2020 10:30:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 241A6AA7C;
        Wed, 15 Apr 2020 14:30:15 +0000 (UTC)
Date:   Wed, 15 Apr 2020 16:30:15 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 1/7] livepatch: Apply vmlinux-specific KLP relocations
 early
In-Reply-To: <20200414193150.iqw224itgpedpltm@treble>
Message-ID: <alpine.LSU.2.21.2004151627100.13470@pobox.suse.cz>
References: <cover.1586881704.git.jpoimboe@redhat.com> <8c3af42719fe0add37605ede634c7035a90f9acc.1586881704.git.jpoimboe@redhat.com> <20200414174406.GC2483@worktop.programming.kicks-ass.net> <20200414180109.da4v2b4ifpixuzn3@treble>
 <20200414193150.iqw224itgpedpltm@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, 14 Apr 2020, Josh Poimboeuf wrote:

> On Tue, Apr 14, 2020 at 01:01:09PM -0500, Josh Poimboeuf wrote:
> > On Tue, Apr 14, 2020 at 07:44:06PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 14, 2020 at 11:28:37AM -0500, Josh Poimboeuf wrote:
> > > > KLP relocations are livepatch-specific relocations which are applied to
> > > >   1) vmlinux-specific KLP relocation sections
> > > > 
> > > >      .klp.rela.vmlinux.{sec}
> > > > 
> > > >      These are relocations (applied to the KLP module) which reference
> > > >      unexported vmlinux symbols.
> > > > 
> > > >   2) module-specific KLP relocation sections
> > > > 
> > > >      .klp.rela.{module}.{sec}:
> > > > 
> > > >      These are relocations (applied to the KLP module) which reference
> > > >      unexported or exported module symbols.
> > > 
> > > Is there something that disallows a module from being called 'vmlinux' ?
> > > If not, we might want to enforce this somewhere.
> > 
> > I'm pretty sure we don't have a check for that anywhere, though the KLP
> > module would almost certainly fail during the module load when it
> > couldn't find the vmlinux.ko symbols it needed.
> > 
> > It wouldn't hurt to add a check somewhere though.  Maybe in
> > klp_module_coming() since the restriction only applies to
> > CONFIG_LIVEPATCH...
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] livepatch: Disallow vmlinux.ko
> 
> This is purely a theoretical issue, but if there were a module named

OT: "if there were"... subjunctive?

> vmlinux.ko, the livepatch relocation code wouldn't be able to
> distinguish between vmlinux-specific and vmlinux.o-specific KLP
> relocations.
> 
> If CONFIG_LIVEPATCH is enabled, don't allow a module named vmlinux.ko.

Yup, there is no such check nowadays. I always struggle to find the right 
balance between being overprotective and letting the user shoot themselves 
in their foot if they want to. But it does not hurt, so ack to that.

Miroslav
