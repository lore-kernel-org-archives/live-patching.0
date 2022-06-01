Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B701C43334
	for <live-patching@archiver.kernel.org>; Wed,  1 Jun 2022 22:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiFAWp0 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 1 Jun 2022 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiFAWpY (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 1 Jun 2022 18:45:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93DFE1D5A81;
        Wed,  1 Jun 2022 15:45:22 -0700 (PDT)
Received: from [192.168.254.32] (unknown [47.189.24.195])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6650720BE540;
        Wed,  1 Jun 2022 15:45:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6650720BE540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654123522;
        bh=M8pAiYfNyt6tZDL5lQY+5VM1wBjeicnIUXpnmkImi5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ckxOtl7BsJyVxjaoRnh5pMaaktmJ/pjDcGRl3x18qDfTBCcDwA/e6jdBoQppyv1TQ
         VBLe24/k8JkhTXXeOwB2Chi/OaMITW/W9ar2zWl79bZpILfzmO7gEvrzUGLJTGMOYj
         IBWW1HK/aiDnG1Q0S0DIxe1xPywi+l9gUqEx0IIc=
Message-ID: <38546223-7585-bfad-b553-9739d31d7fbf@linux.microsoft.com>
Date:   Wed, 1 Jun 2022 17:45:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 09/20] objtool: arm64: Implement command to invoke
 the decoder
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>, jpoimboe@redhat.com,
        chenzhongjin@huawei.com, mark.rutland@arm.com,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        jamorris@linux.microsoft.com, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e81e773678f88f7c2ff7480e2eb096973ec198db>
 <20220524001637.1707472-1-madvenka@linux.microsoft.com>
 <20220524001637.1707472-10-madvenka@linux.microsoft.com>
 <YoznLR30T+03Ea08@sirena.org.uk>
 <ff58b576-efee-276a-bfb3-11f5d258d580@linux.microsoft.com>
 <YpR3naaNCNG9ZJGC@worktop.programming.kicks-ass.net>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <YpR3naaNCNG9ZJGC@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 5/30/22 02:51, Peter Zijlstra wrote:
> On Sun, May 29, 2022 at 09:49:44AM -0500, Madhavan T. Venkataraman wrote:
>>
>>
>> On 5/24/22 09:09, Mark Brown wrote:
>>> On Mon, May 23, 2022 at 07:16:26PM -0500, madvenka@linux.microsoft.com wrote:
>>>> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>>>
>>>> Implement a built-in command called cmd_fpv() that can be invoked as
>>>> follows:
>>>>
>>>> 	objtool fpv generate file.o
>>>>
>>>> The built-in command invokes decode_instructions() to walk each function
>>>> and decode the instructions of the function.
>>>
>>> In commit b51277eb9775ce91 ("objtool: Ditch subcommands") Josh removed
>>> subcommands so this interface is going to need a rethink.
>>
>> Thanks for mentioning this. I will sync my patchset to the latest and send out version 3.
> 
> Before you do; why are you duplicating lots of validate_branch() ? Why
> can't you use the regular code to generate ORC data?
> 
> I'm really not happy about all this.

Hi Peter,

I am preparing a detailed response to this explaining why I have not used validate_branch().
The short answer is that no validation is required for my approach. But I will send my detailed
response shortly.

Thanks.

Madhavan
