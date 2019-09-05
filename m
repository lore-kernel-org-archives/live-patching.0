Return-Path: <SRS0=EEVa=XA=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4CDC3A5AA
	for <live-patching@archiver.kernel.org>; Thu,  5 Sep 2019 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEB4207E0
	for <live-patching@archiver.kernel.org>; Thu,  5 Sep 2019 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567690334;
	bh=bossB91Qr/I/rrAXVwyYUS2cPZeySQqaMDIW3hBDvTA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=uleeNomdVNfiq2krpw78qgLsUI/NuOm1A9X1HzoeKdyEdF6FY1Xn0sGurojsX3t6z
	 BSqmptcEUA+2PJksB5mmjNLUjH64wmpe1Y80HGRPAgqJUtyf1k6XK0JDa8X3EdStWp
	 jQwmnYnwO5G/g4GT1q4LOJiqHU6ufYmXRZjzF5Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfIENcO (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfIENcN (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 5 Sep 2019 09:32:13 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 742F32070C;
        Thu,  5 Sep 2019 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567690332;
        bh=bossB91Qr/I/rrAXVwyYUS2cPZeySQqaMDIW3hBDvTA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AUwwQvbBlItiebXY3KcPib073goVxzF1Qceij7XJwl2KMptZp0UBmomx/E/rKZ5R0
         q/CpTg3Okauld295J7hG/u2c3KEwI4RMwTWZ4aJGDrH3AyRIveEXp7myjCr8J0y21m
         ttVis7KGcESZTucRgdw/+/G08UxJd+cHd7sEVXf0=
Date:   Thu, 5 Sep 2019 15:31:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] livepatch: Clear relocation targets on a module
 removal
In-Reply-To: <20190905132344.byfybt6s42cajtfz@treble>
Message-ID: <nycvar.YFH.7.76.1909051531020.31470@cbobk.fhfr.pm>
References: <20190822223649.ptg6e7qyvosrljqx@treble> <20190823081306.kbkm7b4deqrare2v@pathway.suse.cz> <20190826145449.wyo7avwpqyriem46@treble> <alpine.LSU.2.21.1909021802180.29987@pobox.suse.cz> <5c649320-a9bf-ae7f-5102-483bc34d219f@redhat.com>
 <alpine.LSU.2.21.1909031447140.3872@pobox.suse.cz> <20190904084932.gndrtewubqiaxmzy@pathway.suse.cz> <20190905025055.36loaatxtkhdo4q5@treble> <20190905110955.wl4lwjbnpqybhkcn@pathway.suse.cz> <nycvar.YFH.7.76.1909051317550.31470@cbobk.fhfr.pm>
 <20190905132344.byfybt6s42cajtfz@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 5 Sep 2019, Josh Poimboeuf wrote:

> > All the indirect jumps are turned into alternatives when retpolines 
> > are in place.
> 
> Actually in C code those are done by the compiler as calls/jumps to
> __x86_indirect_thunk_*.

Sure, and the thunks do the redirection via JMP_NOSPEC / CALL_NOSPEC, 
which has alternative in it.

-- 
Jiri Kosina
SUSE Labs

