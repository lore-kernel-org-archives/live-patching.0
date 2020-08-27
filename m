Return-Path: <SRS0=dKsm=CF=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AA9C433E1
	for <live-patching@archiver.kernel.org>; Thu, 27 Aug 2020 13:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2199F2177B
	for <live-patching@archiver.kernel.org>; Thu, 27 Aug 2020 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598534938;
	bh=pF2o0POSsU7imyLcH0vtSo+ed4TXKt5GQq2260FQqSg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=YdAMgTgs8f12KIaxwa5lW2Vt5a09RQ6qirJfyU4doQbFcMteutJhc2/PcptmDJKAt
	 YeqT0AKWGHxSaT5Y7nF+caWj5QKb2XfC/yEieC7Qvz3FS1AgBtVpyJiBL2hqEorRpq
	 ifScBvFWkwX7sHye6yO/CjyVY6Uajd/OpjJW4thc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgH0N2v (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgH0N2e (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 27 Aug 2020 09:28:34 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0FA207CD;
        Thu, 27 Aug 2020 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598534914;
        bh=pF2o0POSsU7imyLcH0vtSo+ed4TXKt5GQq2260FQqSg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BdYMyBJ0iiC1xM4Ul+Oj5kFajdhnLacX38jXP2sGP9OlaN2l4Ww3zno8E3wIuc/gy
         Hl4R3Aj7SJcuXpOv2KKXV8gXzhuZTi5z2WriQfP8VXEelUyNcqzyLKwPZeDbhPrBwa
         vBy+44SVMGPiuJHnc8IK05kgM0bjcYCeWsK5OYTg=
Date:   Thu, 27 Aug 2020 15:28:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Miroslav Benes <mbenes@suse.cz>, jpoimboe@redhat.com,
        pmladek@suse.com, shuah@kernel.org, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: Do not check order when using "comm"
 for dmesg checking
In-Reply-To: <20200827132058.GA24622@redhat.com>
Message-ID: <nycvar.YFH.7.76.2008271528000.27422@cbobk.fhfr.pm>
References: <20200827110709.26824-1-mbenes@suse.cz> <20200827132058.GA24622@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 27 Aug 2020, Joe Lawrence wrote:

> > , "comm" fails with "comm: file 2 is not in sorted order". Suppress the
> > order checking with --nocheck-order option.
> > 
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> 
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> 
> And not so important for selftests, but helpful for backporting efforts:
> 
> Fixes: 2f3f651f3756 ("selftests/livepatch: Use "comm" instead of "diff" for dmesg")

I've added the Fixes: tag and applied to for-5.9/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

