Return-Path: <SRS0=W3Ma=7R=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A25C433DF
	for <live-patching@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE3D206C3
	for <live-patching@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFDI5P (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:57:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgFDI5P (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 4 Jun 2020 04:57:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D93B1ACF1;
        Thu,  4 Jun 2020 08:57:16 +0000 (UTC)
Date:   Thu, 4 Jun 2020 10:57:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        chenwandun@huawei.com, xiexiuqi@huawei.com,
        bobo.shaobowang@huawei.com, huawei.libin@huawei.com,
        jeyu@kernel.org, jikos@kernel.org
Subject: Re: [PATCH] module: make module symbols visible after init
Message-ID: <20200604085712.GD22497@linux-b0ei>
References: <20200603141200.17745-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603141200.17745-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed 2020-06-03 14:12:00, Cheng Jian wrote:
> When lookup the symbols of module by module_kallsyms_lookup_name(),
> the symbols address is visible only if the module's status isn't
> MODULE_STATE_UNFORMED, This is problematic.
> 
> When complete_formation is done, the state of the module is modified
> to MODULE_STATE_COMING, and the symbol of module is visible to the
> outside.
> 
> At this time, the init function of the module has not been called,
> so if the address of the function symbol has been found and called,
> it may cause some exceptions.

It is really handful that module symbols can be found already when
the module is MODULE_STATE_COMING state. It is used by livepatching,
ftrace, and maybe some other subsystems.

The problem is that nobody is allowed to use (call) module symbols
before mod->init() is called and the module is moved to
MODULE_STATE_LIVE.

By other words. Any code that calls module symbols before the module
is fully initialized is buggy. The caller should get fixed,
not the kallsyms side.

Have you seen such a problem in the real life, please?

Best Regards,
Petr
