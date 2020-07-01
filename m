Return-Path: <SRS0=q++l=AM=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF1AC433E0
	for <live-patching@archiver.kernel.org>; Wed,  1 Jul 2020 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FB620772
	for <live-patching@archiver.kernel.org>; Wed,  1 Jul 2020 13:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGANNk (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgGANNk (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 1 Jul 2020 09:13:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FCDDAF69;
        Wed,  1 Jul 2020 13:13:38 +0000 (UTC)
Date:   Wed, 1 Jul 2020 13:13:38 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Gabriel Gomes <gagomes@suse.com>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        ulp-devel@opensuse.org, live-patching@vger.kernel.org
Subject: Re: Live patching MC at LPC2020?
In-Reply-To: <20200630214550.cbli6oex4xskwdjp@treble>
Message-ID: <alpine.LSU.2.20.2007011304210.9982@wotan.suse.de>
References: <nycvar.YFH.7.76.2003271409380.19500@cbobk.fhfr.pm> <20200331205204.GA7388@redhat.com> <20200625065943.GB6156@alley> <20200630214550.cbli6oex4xskwdjp@treble>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hello,

On Tue, 30 Jun 2020, Josh Poimboeuf wrote:

> On Thu, Jun 25, 2020 at 08:59:43AM +0200, Petr Mladek wrote:
> > On Tue 2020-03-31 16:52:04, Joe Lawrence wrote:
> > It seems that there is interest into sharing/discussing some topics.
> > The question is whether is has to be under the LPC even umbrella.
> > 
> > Advantages of LPC:
> > 
> >    + well defined date
> >    + more attendees (ARM people, Steven Rostedt ;-)
> >    + access to some powerful video conference tool
> >    + access to another LPC content
> >    + support for the conference in the long term
> > 
> > 
> > Advantages of self-organized event:
> > 
> >    + less paperwork?
> >    + cheaper?
> >    + only interested people invited
> >    + date after summer holidays
> >    + more time for the discussion
> > 
> > I am in the favor of self organized event. For me, LPC is much less
> > interesting without the personal contact and hallway conversations.
> > All the LPC date is not ideal for me.
> 
> I'd prefer LPC proper, as it would be easier (infrastructure is already
> taken care of) and more inclusive (in the past we often got good
> feedback from outside the direct livepatch community).  And it's only
> $50 US.

Yeah, I think having more attendees would be valuable.

> But to be honest I have doubts about the usefulness of any online 
> conference, so either way may be equally useless ;-)

Indeed.  OTOH our fellow openSUSE guys seemed to have held a fairly 
successful virtual summit earlier this year with some in-development 
virtual-conferencing software that does more than just video/audio 
streaming ( https://requiredmagic.com/roundtable/ ).  In particular the 
possibility to have interactive Q&A with the presenter during and after 
the allotted talk slot seemed to have made up for hallway discussions.

Maybe that's a viable way.  (I personally wasn't at the virtual summit to 
know for sure, but the experience report from some of them was quite 
positive; I know nothing about the conferencing software of LPC)


Ciao,
Michael.
