Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992FC433C1
	for <live-patching@archiver.kernel.org>; Tue, 30 Mar 2021 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F2E61957
	for <live-patching@archiver.kernel.org>; Tue, 30 Mar 2021 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhC3Hm3 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhC3Hl6 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 30 Mar 2021 03:41:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F408561883;
        Tue, 30 Mar 2021 07:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617090118;
        bh=1U/9qxlDVdNrHyppMWZvNJxzfUK7wV+Ymcv7XAS5pUI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PnxrPG/fzEtfcKByH6yy3Lsq7yfKTxl3EZdWvyBWM38THzpC/qWllrFGord0sjxdl
         VIx5+O5OWzkUBKXH+JD757XQIxt7+NPlRYeCjFvQAYuGDyQ0fl6OKeISXz9Y2hsXBg
         90O0JOkf8CoOB9QjKZiiky/9Q4JIrVPlRUSVkI+FeoucS5vknDfg3SWFq7ASydeGRH
         BBRST3yxgYiMNnHIa+H3q2gjaYeCabPsv98oAvKEwf1tDDmSU+d4sBC/8Rbwij3Rk8
         SRUaPRnITAdyzc3kwt1/0EhcJSePthH4bh0x8KRdOjx0KrPJSpOwN4WYDFbLBrcfLr
         QWaM5eSVxa7uQ==
Date:   Tue, 30 Mar 2021 09:41:55 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
cc:     jpoimboe@redhat.com, pmladek@suse.com, joe.lawrence@redhat.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2] livepatch: Replace the fake signal sending with
 TIF_NOTIFY_SIGNAL infrastructure
In-Reply-To: <20210329132815.10035-1-mbenes@suse.cz>
Message-ID: <nycvar.YFH.7.76.2103300940510.12405@cbobk.fhfr.pm>
References: <20210329132815.10035-1-mbenes@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon, 29 Mar 2021, Miroslav Benes wrote:

> Livepatch sends a fake signal to all remaining blocking tasks of a
> running transition after a set period of time. It uses TIF_SIGPENDING
> flag for the purpose. Commit 12db8b690010 ("entry: Add support for
> TIF_NOTIFY_SIGNAL") added a generic infrastructure to achieve the same.
> Replace our bespoke solution with the generic one.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Pushed out to livepatching#for-5.13/signal.

-- 
Jiri Kosina
SUSE Labs

