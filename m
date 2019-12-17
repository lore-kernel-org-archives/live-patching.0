Return-Path: <SRS0=S9Kr=2H=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C397C2D0C8
	for <live-patching@archiver.kernel.org>; Tue, 17 Dec 2019 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE9C21739
	for <live-patching@archiver.kernel.org>; Tue, 17 Dec 2019 09:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLQJCN (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:02:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:56366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfLQJCM (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 17 Dec 2019 04:02:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E81F2AE17;
        Tue, 17 Dec 2019 09:02:10 +0000 (UTC)
Date:   Tue, 17 Dec 2019 10:02:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, shuah@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Fix it to do root uid check and
 skip
Message-ID: <20191217090210.ky3il3qu4jkr2vaa@pathway.suse.cz>
References: <20191216191840.15188-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216191840.15188-1-skhan@linuxfoundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon 2019-12-16 12:18:40, Shuah Khan wrote:
> livepatch test configures the system and debug environment to run
> tests. Some of these actions fail without root access and test
> dumps several permission denied messages before it exits.
> 
> Fix test-state.sh to call setup_config instead of set_dynamic_debug
> as suggested by Petr Mladek <pmladek@suse.com>
> 
> Fix it to check root uid and exit with skip code instead.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Shuah, I assume that you will push this fix via linux-kselftest tree.
Please, tell us if you have other preference.

Best Regards,
Petr
