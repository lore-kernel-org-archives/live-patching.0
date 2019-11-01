Return-Path: <SRS0=8zDU=YZ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC5ECA9ECF
	for <live-patching@archiver.kernel.org>; Fri,  1 Nov 2019 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491B7208E3
	for <live-patching@archiver.kernel.org>; Fri,  1 Nov 2019 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKAMOn (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:14:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfKAMOn (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 1 Nov 2019 08:14:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB7F2AC8B;
        Fri,  1 Nov 2019 12:14:41 +0000 (UTC)
Date:   Fri, 1 Nov 2019 13:14:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] livepatch: new API to track system state changes
Message-ID: <20191101121440.kpvtont5mrmet2mq@pathway.suse.cz>
References: <20191030154313.13263-1-pmladek@suse.com>
 <20191031180650.g4tss4wfksg2bs6a@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031180650.g4tss4wfksg2bs6a@treble>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu 2019-10-31 13:06:50, Josh Poimboeuf wrote:
> On Wed, Oct 30, 2019 at 04:43:08PM +0100, Petr Mladek wrote:
> > Hi,
> > 
> > this is another piece in the puzzle that helps to maintain more
> > livepatches.
> > 
> > Especially pre/post (un)patch callbacks might change a system state.
> > Any newly installed livepatch has to somehow deal with system state
> > modifications done be already installed livepatches.
> > 
> > This patchset provides a simple and generic API that
> > helps to keep and pass information between the livepatches.
> > It is also usable to prevent loading incompatible livepatches.
> > 
> > Changes since v3:
> > 
> >   + selftests compilation error [kbuild test robot]	
> >   + fix copyright in selftests [Joe]
> >   + used macros for the module names in selftests [Joe]
> >   + allow zero state version [Josh]
> >   + slightly refactor the code for checking state version [Josh]
> >   + fix few typos reported by checkpatch.pl [Petr]
> >   + added Acks [Joe]
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

The patchset has been commited into livepatch.git, branch
for-5.5/system-state.

Best Regards,
Petr
