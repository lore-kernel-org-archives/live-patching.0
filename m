Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF5C433ED
	for <live-patching@archiver.kernel.org>; Tue,  4 May 2021 23:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689C961182
	for <live-patching@archiver.kernel.org>; Tue,  4 May 2021 23:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEDXOh (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 4 May 2021 19:14:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60436 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhEDXOg (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 4 May 2021 19:14:36 -0400
Received: from [192.168.254.32] (unknown [47.187.223.33])
        by linux.microsoft.com (Postfix) with ESMTPSA id 596C820B7178;
        Tue,  4 May 2021 16:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 596C820B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620170021;
        bh=iPiRNYpjRwzimrh0K0tYcnGX1TG+68HNv8cU+qTFNlE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MHuTR0PCggMxKIWmmSaj3Dkz01I4Csml3R14Taa2MwE5x0SRFnY4FdtVQb7ULnW2d
         m+1Q7clUEvTyxL4XXv1SEZ8Qf2Ok2fgI8qBqjfxB4qeKGLDgL2gZAS+xz8O5bVjv+i
         /IknZDpVFHJpXgCGE0Z/5oFwcmKkm74n9etbKHJY=
Subject: Re: [RFC PATCH v3 1/4] arm64: Introduce stack trace reliability
 checks in the unwinder
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <65cf4dfbc439b010b50a0c46ec500432acde86d6>
 <20210503173615.21576-1-madvenka@linux.microsoft.com>
 <20210503173615.21576-2-madvenka@linux.microsoft.com>
 <20210504215248.oi3zay3memgqri33@treble>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <b000767b-26ca-01a9-a109-c9fc3357f832@linux.microsoft.com>
Date:   Tue, 4 May 2021 18:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504215248.oi3zay3memgqri33@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 5/4/21 4:52 PM, Josh Poimboeuf wrote:
> On Mon, May 03, 2021 at 12:36:12PM -0500, madvenka@linux.microsoft.com wrote:
>> @@ -44,6 +44,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>>  	unsigned long fp = frame->fp;
>>  	struct stack_info info;
>>  
>> +	frame->reliable = true;
>> +
> 
> Why set 'reliable' to true on every invocation of unwind_frame()?
> Shouldn't it be remembered across frames?
> 

This is mainly for debug purposes in case a caller wants to print the whole stack and also
print which functions are unreliable. For livepatch, it does not make any difference. It will
quit as soon as it encounters an unreliable frame.

> Also, it looks like there are several error scenarios where it returns
> -EINVAL but doesn't set 'reliable' to false.
> 

I wanted to make a distinction between an error situation (like stack corruption where unwinding
has to stop) and an unreliable situation (where unwinding can still proceed). E.g., when a
stack trace is taken for informational purposes or debug purposes, the unwinding will try to
proceed until either the stack trace ends or an error happens.

Madhavan
