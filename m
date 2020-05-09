Return-Path: <SRS0=66Cv=6X=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40730C47247
	for <live-patching@archiver.kernel.org>; Sat,  9 May 2020 00:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2159521473
	for <live-patching@archiver.kernel.org>; Sat,  9 May 2020 00:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgEIAio (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 8 May 2020 20:38:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727984AbgEIAio (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 8 May 2020 20:38:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7528D12D30C88EFBFCE;
        Sat,  9 May 2020 08:38:41 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.180) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 08:38:40 +0800
Subject: Re: [PATCH -next] livepatch: Make klp_apply_object_relocs static
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <jikos@kernel.org>, <mbenes@suse.cz>, <pmladek@suse.com>,
        <joe.lawrence@redhat.com>, <live-patching@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1588939594-58255-1-git-send-email-zou_wei@huawei.com>
 <20200508155335.jyfo4rhdvbyoq5kl@treble>
 <20200508155511.462d6pnbebcryi2j@treble>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <b06688df-787e-4b60-6707-cf26426627d1@huawei.com>
Date:   Sat, 9 May 2020 08:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508155511.462d6pnbebcryi2j@treble>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.212.180]
X-CFilter-Loop: Reflected
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Josh,

Thanks for your review and reply.

Yes, I just copied and pasted the warning message, so I brought a 
question mark.

I will modify the description and add the fixes tag which introduced the 
issue, then will send the v2 soon.

On 2020/5/8 23:55, Josh Poimboeuf wrote:
> On Fri, May 08, 2020 at 10:53:41AM -0500, Josh Poimboeuf wrote:
>> On Fri, May 08, 2020 at 08:06:34PM +0800, Samuel Zou wrote:
>>> Fix the following sparse warning:
>>>
>>> kernel/livepatch/core.c:748:5: warning: symbol 'klp_apply_object_relocs'
>>> was not declared. Should it be static?
>>
>> Yes, it should :-)
>>
>> So instead of the question, the patch description should probably state
>> that it should be static because its only caller is in the file.
> 
> ... and it probably should also have a Fixes tag which references the
> commit which introduced this issue.
> 
>> With that change:
>>
>> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 

