Return-Path: <SRS0=jpjQ=6L=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF6C54FD0
	for <live-patching@archiver.kernel.org>; Mon, 27 Apr 2020 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2717120575
	for <live-patching@archiver.kernel.org>; Mon, 27 Apr 2020 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0McY (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0McY (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 27 Apr 2020 08:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 40415AD93;
        Mon, 27 Apr 2020 12:32:22 +0000 (UTC)
Date:   Mon, 27 Apr 2020 14:32:22 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v3 00/10] livepatch,module: Remove .klp.arch and
 module_disable_ro()
In-Reply-To: <a566f775-4e5b-6ced-079b-4951dfd98cab@redhat.com>
Message-ID: <alpine.LSU.2.21.2004271428530.24991@pobox.suse.cz>
References: <cover.1587812518.git.jpoimboe@redhat.com> <a566f775-4e5b-6ced-079b-4951dfd98cab@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

> BTW, this may be out of scope for this patchset, but is it a large amount of
> work to support clearing klp-relocations on target module unload?  ie, this
> test case:
> 
>   - (target module and livepatch loaded)
>   - rmmod target_mod
>   - modprobe target_mod       << fails as reloc target is non-zero
> 
> IIRC, Miroslav had taken a stab at this last year, but I don't remember what
> the technical problems were then.

Yes, see 
https://lore.kernel.org/live-patching/alpine.LSU.2.21.1910031110440.9011@pobox.suse.cz/

I think the "conclusion" there still applies... but yes, it makes testing 
difficult.

Miroslav
