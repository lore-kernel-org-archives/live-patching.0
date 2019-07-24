Return-Path: <SRS0=KNr2=VV=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60387C76194
	for <live-patching@archiver.kernel.org>; Wed, 24 Jul 2019 16:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE0621951
	for <live-patching@archiver.kernel.org>; Wed, 24 Jul 2019 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563986719;
	bh=k5s66pEgEBv+nR9tMAZXt6QiRx8uZOUa/8yBMLysUjw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0ARwoRKROhBOO7HmPq/DaMFAVAXBVbJHX9e67NL69NRDDoxnls9Gr53a/i8y5WGF4
	 wLb0tor7vqwgMQhest/f3FVjoDv+rbOIoMO9BN1t8G8VK7adSLT76NQbtBXJSDLiqf
	 BV2hcv1CkqIfmhNUR1bmt6UD9lwENyzajzze337U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbfGXQpS (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbfGXQpS (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 24 Jul 2019 12:45:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956ED2189F;
        Wed, 24 Jul 2019 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563986716;
        bh=k5s66pEgEBv+nR9tMAZXt6QiRx8uZOUa/8yBMLysUjw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n3Yky+YTRGgs66Y/xnADc+NfLsjRajh3fGCCqD2l2hlcUqLBKcTEgDYori4bPBGbK
         YMr67AaPU7n3f+y/DR9kDv9iKCSACSw0/NbgWgXT696BFsZsohYsvHdamp5dRH40wr
         uuwMBFW1Oep3t9+PDs341olSQti/DkfCa4X/G/Iw=
Subject: Re: [PATCH v3] selftests/livepatch: add test skip handling
To:     Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>
References: <20190722140544.29867-1-joe.lawrence@redhat.com>
 <20190724062730.xtutfqgpsr3pubv7@pathway.suse.cz>
From:   shuah <shuah@kernel.org>
Message-ID: <0aae34cf-ae82-1f80-7bc9-27708c61287a@kernel.org>
Date:   Wed, 24 Jul 2019 10:45:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724062730.xtutfqgpsr3pubv7@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On 7/24/19 12:27 AM, Petr Mladek wrote:
> On Mon 2019-07-22 10:05:44, Joe Lawrence wrote:
>> Add a skip() message function that stops the test, logs an explanation,
>> and sets the "skip" return code (4).
>>
>> Before loading a livepatch self-test kernel module, first verify that
>> we've built and installed it by running a 'modprobe --dry-run'.  This
>> should catch a few environment issues, including !CONFIG_LIVEPATCH and
>> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
>> skip() function.
>>
>> Reported-by: Jiri Benc <jbenc@redhat.com>
>> Suggested-by: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 
> PS: No need to send v4. The missing "to", suggested by Shuah, could
>      get added when pushing the patch into the repo.
> 

I can't make changes to the patch. I can adjust the commit log at times
and correct merge conflicts.

I would like to see v4 for this.

thanks,
-- Shuah
