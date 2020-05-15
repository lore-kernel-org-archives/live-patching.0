Return-Path: <SRS0=3okm=65=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6783C433DF
	for <live-patching@archiver.kernel.org>; Fri, 15 May 2020 09:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBFA206F1
	for <live-patching@archiver.kernel.org>; Fri, 15 May 2020 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589534137;
	bh=yaqrlmYZ6yjMLlrZvFZybqiLMRW1MJGt/LMSQ8POTcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=nLgweKVb1nKQgDQkmA32hrjbUCuFbbGlFfijW5c4VoNFODl9q5p5WQm/jEkgIAy+H
	 BHIuRFpqMJ8BxZ41X67uJPgaAuEO9uTmKrBI0+7NWbN6GI4C6DgjqwaWU254BKMNsP
	 b3DyKSKXxwTO7YQu3C0i5EUNOwtBYNqINVOVuuWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEOJPh (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 15 May 2020 05:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEOJPh (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 15 May 2020 05:15:37 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71FE2065C;
        Fri, 15 May 2020 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589534136;
        bh=yaqrlmYZ6yjMLlrZvFZybqiLMRW1MJGt/LMSQ8POTcE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=U0NfGqgxuvI63L89Pc/dnwbXfLiDyCvPZ2PKy6mZEYtuzUtmfiUtLrMacAGgc3q5j
         GOj6z8DNFzwp39xbTHT3ZKZmWjDTOjZHyQ/dWZrerwFmKl2RuN73KYSlxcgO/a+z4d
         HEi18x0qvi3XmESC3DMsewKHWjv/mmHtaS5Qh6tk=
Date:   Fri, 15 May 2020 11:15:33 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: add lib/livepatch to LIVE PATCHING
In-Reply-To: <20200515084410.67821-1-kamalesh@linux.vnet.ibm.com>
Message-ID: <nycvar.YFH.7.76.2005151115130.25812@cbobk.fhfr.pm>
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

Applied, thanks Kamalesh.

-- 
Jiri Kosina
SUSE Labs

