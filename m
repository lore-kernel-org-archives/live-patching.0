Return-Path: <SRS0=JZhP=WX=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4036C3A5A3
	for <live-patching@archiver.kernel.org>; Tue, 27 Aug 2019 11:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1F52077B
	for <live-patching@archiver.kernel.org>; Tue, 27 Aug 2019 11:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfH0LRm (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:17:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfH0LRm (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 27 Aug 2019 07:17:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00F68AC94;
        Tue, 27 Aug 2019 11:17:40 +0000 (UTC)
Date:   Tue, 27 Aug 2019 13:17:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Nicolai Stange <nstange@suse.de>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.de>,
        Alice Ferrazzi <alicef@gentoo.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        live-patching@vger.kernel.org
Subject: Re: Live patching MC preliminary schedule
Message-ID: <20190827111740.ckb6fr5kewjip4a5@pathway.suse.cz>
References: <nycvar.YFH.7.76.1908271005260.27147@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1908271005260.27147@cbobk.fhfr.pm>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue 2019-08-27 10:08:17, Jiri Kosina wrote:
> Hi,
> 
> I've created a preliminary schedule of live patching MC at LPC; it can be 
> seen here:
> 
> 	https://linuxplumbersconf.org/event/4/sessions/47/#20190911
> 
> Please take a look, and let me know in case you'd like to request any 
> modification of the schedule.

The schedule looks reasonable to me.

I guess that "Rethinking late module patching" could cause the most
heating discussion. It is great that it is at the beginning.

On the other hand, "API for state changes made by callbacks" might
be pretty short. The v2 patchset has got positive feedback modulo
some cosmetic issues. This slot might help to catch up with
the schedule when necessary.

Best Regards,
Petr
