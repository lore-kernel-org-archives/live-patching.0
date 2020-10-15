Return-Path: <SRS0=ks2W=DW=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE7AC433DF
	for <live-patching@archiver.kernel.org>; Thu, 15 Oct 2020 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440E920760
	for <live-patching@archiver.kernel.org>; Thu, 15 Oct 2020 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgJOS17 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:27:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbgJOS16 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 15 Oct 2020 14:27:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66955AC4C
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2020 18:27:57 +0000 (UTC)
Date:   Thu, 15 Oct 2020 20:27:57 +0200 (CEST)
From:   Jiri Kosina <jkosina@suse.cz>
To:     live-patching@vger.kernel.org
Subject: livepatching.git#for-linus rebased
Message-ID: <nycvar.YFH.7.76.2010152005130.18859@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi,

JFYI I decided to rebase for-linus branch, due to slight confusion, that'd 
result in for-linus be just one commit and one merge commit, which is 
pointless (it's not possible to do ff-merge into for-linus without 
rebasing).

As this is just an integration branch, this should be fine for everybody I 
hope.

Thanks,

-- 
Jiri Kosina
SUSE Labs
