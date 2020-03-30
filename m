Return-Path: <SRS0=kogD=5P=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA4C43331
	for <live-patching@archiver.kernel.org>; Mon, 30 Mar 2020 14:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028232073B
	for <live-patching@archiver.kernel.org>; Mon, 30 Mar 2020 14:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgC3OBK (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:01:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgC3OBK (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 30 Mar 2020 10:01:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D741AD3C;
        Mon, 30 Mar 2020 14:01:09 +0000 (UTC)
Date:   Mon, 30 Mar 2020 14:01:09 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Nicolai Stange <nstange@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Gabriel Gomes <gagomes@suse.com>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        ulp-devel@opensuse.org, live-patching@vger.kernel.org
Subject: Re: Live patching MC at LPC2020?
In-Reply-To: <nycvar.YFH.7.76.2003271409380.19500@cbobk.fhfr.pm>
Message-ID: <alpine.LSU.2.21.2003301359490.21316@wotan.suse.de>
References: <nycvar.YFH.7.76.2003271409380.19500@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hello,

On Fri, 27 Mar 2020, Jiri Kosina wrote:

> oh well, it sounds a bit awkward to be talking about any conference plans 
> for this year given how the corona things are untangling in the world, but 
> LPC planning committee has issued (a) statement about Covid-19 (b) call 
> for papers (as originally planned) nevertheless. Please see:
> 
> 	https://linuxplumbersconf.org/
> 	https://linuxplumbersconf.org/event/7/abstracts/
> 
> for details.
> 
> Under the asumption that this Covid nuisance is over by that time and 
> travel is possible (and safe) again -- do we want to eventually submit a 
> livepatching miniconf proposal again?

I think that's very optimistic, but in case the conference really can 
happen I think it'd be useful to have such mini-conference (from the 
userspace perspective)


Ciao,
Michael.
