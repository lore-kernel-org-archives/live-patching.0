Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147ECC4167B
	for <live-patching@archiver.kernel.org>; Fri,  9 Dec 2022 11:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLILaC (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 9 Dec 2022 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLILaB (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 9 Dec 2022 06:30:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58861D64E;
        Fri,  9 Dec 2022 03:29:59 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NT81F3NsLzmW6v;
        Fri,  9 Dec 2022 19:29:05 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 19:29:57 +0800
Subject: Re: [PATCH] livepatch: Call klp_match_callback() in
 klp_find_callback() to avoid code duplication
To:     Petr Mladek <pmladek@suse.com>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
References: <20221207032304.2017-1-thunder.leizhen@huawei.com>
 <Y5L75x+W1NrWCOcm@alley>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <aed3ca41-0f27-b44e-b95c-f7ed0a8ef468@huawei.com>
Date:   Fri, 9 Dec 2022 19:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y5L75x+W1NrWCOcm@alley>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 2022/12/9 17:12, Petr Mladek wrote:
> On Wed 2022-12-07 11:23:04, Zhen Lei wrote:
>> The implementation of function klp_match_callback() is identical to the
>> partial implementation of function klp_find_callback(). So call function
>> klp_match_callback() in function klp_find_callback() instead of the
>> duplicated code.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Thanks for cleaning this.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Oh, sorry, I realized that I had forgotten to add:
Suggested-by: Petr Mladek <pmladek@suse.com>

Hi Luis:
  Can you help me add it?

> 
> Best Regards,
> Petr
> .
> 

-- 
Regards,
  Zhen Lei
