Return-Path: <SRS0=sHhQ=VO=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A746AC76186
	for <live-patching@archiver.kernel.org>; Wed, 17 Jul 2019 12:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836AA2182B
	for <live-patching@archiver.kernel.org>; Wed, 17 Jul 2019 12:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfGQMpa (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfGQMp3 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 17 Jul 2019 08:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 907E13093382;
        Wed, 17 Jul 2019 12:45:29 +0000 (UTC)
Received: from localhost (unknown [10.40.205.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A32600D1;
        Wed, 17 Jul 2019 12:45:25 +0000 (UTC)
Date:   Wed, 17 Jul 2019 14:45:24 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: add test skip handling
Message-ID: <20190717144524.715f46c4@redhat.com>
In-Reply-To: <20190717120055.pno2b7zczpcgaixg@pathway.suse.cz>
References: <20190716133414.20196-1-joe.lawrence@redhat.com>
        <20190717120055.pno2b7zczpcgaixg@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 17 Jul 2019 12:45:29 +0000 (UTC)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, 17 Jul 2019 14:00:55 +0200, Petr Mladek wrote:
> Adding Jiri into CC to be sure that we really solved the original problem.

The patch looks good to me, the runner expects 4 as an indication that
the test was skipped.

> I get the following output when livepatching is not configured:
> 
> $> make run_tests  
> TAP version 13
> 1..4
> # selftests: livepatch: test-livepatch.sh
> # TEST: basic function patching ... SKIP: Failed modprobe --dry-run of module: test_klp_livepatch
> not ok 1 selftests: livepatch: test-livepatch.sh # SKIP
> # selftests: livepatch: test-callbacks.sh
> # TEST: target module before livepatch ... SKIP: Failed modprobe --dry-run of module: test_klp_callbacks_mod
> not ok 2 selftests: livepatch: test-callbacks.sh # SKIP
> # selftests: livepatch: test-shadow-vars.sh
> # TEST: basic shadow variable API ... SKIP: Failed modprobe --dry-run of module: test_klp_shadow_vars
> not ok 3 selftests: livepatch: test-shadow-vars.sh # SKIP
> # selftests: livepatch: test-state.sh
> # TEST: system state modification ... SKIP: Failed modprobe --dry-run of module: test_klp_state
> not ok 4 selftests: livepatch: test-state.sh # SKIP
> 
> Jiri, is it acceptable solution for you, please?

It looks correct. My reading of the TAP 13 specification is that it
should be returned as "ok" instead of "not ok" but that is not a
problem of this patch.

> Otherwise, the patch looks fine to me. If Jiri is fine
> then feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Sure.

Acked-by: Jiri Benc <jbenc@redhat.com>

Thanks!

 Jiri
