Return-Path: <SRS0=3okm=65=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65746C433DF
	for <live-patching@archiver.kernel.org>; Fri, 15 May 2020 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4875B2054F
	for <live-patching@archiver.kernel.org>; Fri, 15 May 2020 08:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgEOIro (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 15 May 2020 04:47:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgEOIrn (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 15 May 2020 04:47:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B06CB19A;
        Fri, 15 May 2020 08:47:45 +0000 (UTC)
Date:   Fri, 15 May 2020 10:47:42 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add lib/livepatch to LIVE PATCHING
In-Reply-To: <20200515084410.67821-1-kamalesh@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.21.2005151047230.15222@pobox.suse.cz>
References: <20200515084410.67821-1-kamalesh@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, 15 May 2020, Kamalesh Babulal wrote:

> Add lib/livepatch to list of livepatching F: patterns in MAINTAINERS.
> 
> Suggested-by: Jiri Kosina <jikos@kernel.org>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
