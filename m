Return-Path: <SRS0=NDcy=3U=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B58C33CB2
	for <live-patching@archiver.kernel.org>; Fri, 31 Jan 2020 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0040206F0
	for <live-patching@archiver.kernel.org>; Fri, 31 Jan 2020 07:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgAaHRU (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 31 Jan 2020 02:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:42644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbgAaHRU (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 31 Jan 2020 02:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D096FAB6D;
        Fri, 31 Jan 2020 07:17:17 +0000 (UTC)
Date:   Fri, 31 Jan 2020 08:17:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, live-patching@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>, nstange@suse.de
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20200131071716.GA9569@linux-b0ei>
References: <alpine.LSU.2.21.2001221052331.15957@pobox.suse.cz>
 <20200122214239.ivnebi7hiabi5tbs@treble>
 <alpine.LSU.2.21.2001281014280.14030@pobox.suse.cz>
 <20200128150014.juaxfgivneiv6lje@treble>
 <20200128154046.trkpkdaz7qeovhii@pathway.suse.cz>
 <20200128170254.igb72ib5n7lvn3ds@treble>
 <alpine.LSU.2.21.2001291249430.28615@pobox.suse.cz>
 <20200129155951.qvf3tjsv2qvswciw@treble>
 <20200130095346.6buhb3reehijbamz@pathway.suse.cz>
 <20200130141733.krfdmirathscgkkp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130141733.krfdmirathscgkkp@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu 2020-01-30 08:17:33, Josh Poimboeuf wrote:
> On Thu, Jan 30, 2020 at 10:53:46AM +0100, Petr Mladek wrote:
> > On Wed 2020-01-29 09:59:51, Josh Poimboeuf wrote:
> > > In retrospect, the prerequisites for merging it should have been:
> > 
> > OK, let me do one more move in this game.
> > 
> > 
> > > 1) Document how source-based patches can be safely generated;
> > 
> > I agree that the information are really scattered over many files
> > in Documentation/livepatch/.
> 
> Once again you're blithely ignoring my point and pretending I'm saying
> something else.  And you did that again further down in the email, but
> what's the point of arguing if you're not going to listen.

I have exactly the same feeling but the opposite way.

> I would ask that you please put on your upstream hats and stop playing
> politics.  If the patch creation process is a secret, then by all means,
> keep it secret.  But then keep your GCC flag to yourself.

The thing is that we do not have any magic secret.

Best Regards,
Petr
