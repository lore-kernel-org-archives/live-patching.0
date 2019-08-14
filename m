Return-Path: <SRS0=93NG=WK=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB9C32753
	for <live-patching@archiver.kernel.org>; Wed, 14 Aug 2019 13:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25775206C2
	for <live-patching@archiver.kernel.org>; Wed, 14 Aug 2019 13:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfHNNUv (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfHNNUv (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 14 Aug 2019 09:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CA602A09C1;
        Wed, 14 Aug 2019 13:20:51 +0000 (UTC)
Received: from [10.16.196.35] (wlan-196-35.bos.redhat.com [10.16.196.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F95C17AB7;
        Wed, 14 Aug 2019 13:20:50 +0000 (UTC)
Subject: Re: [PATCH] selftests: livepatch: add missing fragments to config
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        pmladek@suse.com, mbenes@suse.cz, jikos@kernel.org,
        jpoimboe@redhat.com
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190814111651.28433-1-anders.roxell@linaro.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <e01a1182-d9cf-b2c2-78a9-35f60861e4a9@redhat.com>
Date:   Wed, 14 Aug 2019 09:20:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814111651.28433-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 14 Aug 2019 13:20:51 +0000 (UTC)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On 8/14/19 7:16 AM, Anders Roxell wrote:
> When generating config with 'make defconfig kselftest-merge' fragment
> CONFIG_TEST_LIVEPATCH=m isn't set.
> 
> Rework to enable CONFIG_LIVEPATCH and CONFIG_DYNAMIC_DEBUG as well.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/livepatch/config | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
> index 0dd7700464a8..ad23100cb27c 100644
> --- a/tools/testing/selftests/livepatch/config
> +++ b/tools/testing/selftests/livepatch/config
> @@ -1 +1,3 @@
> +CONFIG_LIVEPATCH=y
> +CONFIG_DYNAMIC_DEBUG=y
>   CONFIG_TEST_LIVEPATCH=m
> 

Cool, I didn't know about that make target when doing commit 
bae054372aba ("selftests/livepatch: add DYNAMIC_DEBUG config dependency")

How does kselftest-merge verify dependencies?

CONFIG_LIVEPATCH has its own list of configuration dependencies (see 
kernel/livepatch/Kconfig) but we don't list all of those in this config 
file.  Just curious.

Thanks,

-- Joe
