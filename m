Return-Path: <SRS0=RpYj=UT=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20191C43613
	for <live-patching@archiver.kernel.org>; Thu, 20 Jun 2019 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF037208CB
	for <live-patching@archiver.kernel.org>; Thu, 20 Jun 2019 08:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfFTIdd (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:33:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:35564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTIdd (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 20 Jun 2019 04:33:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 521A5AF22;
        Thu, 20 Jun 2019 08:33:32 +0000 (UTC)
Date:   Thu, 20 Jun 2019 10:33:31 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Cheng Jian <cj.chengjian@huawei.com>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] Revert "x86/module: Detect and skip invalid
 relocations"
In-Reply-To: <1561019068-132672-1-git-send-email-cj.chengjian@huawei.com>
Message-ID: <alpine.LSU.2.21.1906201028490.25778@pobox.suse.cz>
References: <1561019068-132672-1-git-send-email-cj.chengjian@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 20 Jun 2019, Cheng Jian wrote:

> This reverts commit eda9cec4c9a12208a6f69fbe68f72a6311d50032.
> 
> Since commit (eda9cec4c9a1 'x86/module: Detect and skip invalid
> relocations') add some sanity check in apply_relocate_add, borke
> re-insmod a kernel module which has been patched before,
> 
> The relocation informations of the livepatch module have been
> overwritten since first patched, so if we rmmod and insmod the
> kernel module, these values are not zero anymore, when
> klp_module_coming doing, and that commit marks them as invalid
> invalid_relocation.
> 
> Then the following error occurs:
> 
> 	module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 2, loc (____ptrval____), val ffffffffc000236c
> 	livepatch: failed to initialize patch 'livepatch_0001_test' for module 'test' (-8)
> 	livepatch: patch 'livepatch_0001_test' failed for module 'test', refusing to load module 'test'

Oh yeah. First reported here 20180602161151.apuhs2dygsexmcg2@treble (LP ML 
only and there is no archive on lore.kernel.org yet. Sorry about that.). I 
posted v1 here 
https://lore.kernel.org/lkml/20180607092949.1706-1-mbenes@suse.cz/ and 
even started to work on v2 in March with arch-specific nullifying, but 
then I got sidetracked again. I'll move it up my todo list a bit.

Miroslav
