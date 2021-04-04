Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DEC433B4
	for <live-patching@archiver.kernel.org>; Sun,  4 Apr 2021 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2421161364
	for <live-patching@archiver.kernel.org>; Sun,  4 Apr 2021 16:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDDQaE (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Sun, 4 Apr 2021 12:30:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51116 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDQaD (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Sun, 4 Apr 2021 12:30:03 -0400
Received: from [192.168.254.32] (unknown [47.187.194.202])
        by linux.microsoft.com (Postfix) with ESMTPSA id 201D720B5680;
        Sun,  4 Apr 2021 09:29:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 201D720B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617553798;
        bh=EMioY04pU+D+ZOCAg4RgxdfPlW4mRKUBYkz6Ted+8mo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=kbHcFgH60ILcMw84IrcFZs0krTP+dTpgXUV5wA5THxe8pwckS9PXuNUqAtZX2wUcm
         +chctHHova0cUapP9XsY/VZOKsBl0gzViXoL+aAjXq3Oy40wovYfiijs0cHTB+YdB5
         qaiZq44uVC2oarDeKTawBrmAnkrjGG63iEyMFkDU=
Subject: Re: [RFC PATCH v2 1/1] arm64: Implement stack trace termination
 record
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <659f3d5cc025896ba4c49aea431aa8b1abc2b741>
 <20210402032404.47239-1-madvenka@linux.microsoft.com>
 <20210402032404.47239-2-madvenka@linux.microsoft.com>
 <20210403155948.ubbgtwmlsdyar7yp@treble>
 <171fef08-17d3-2c2e-dad8-6caf4c0c7f15@linux.microsoft.com>
 <49790505-f611-b4a2-c804-b779060601a9@linux.microsoft.com>
Message-ID: <74475382-9482-48ac-e9a3-00073cb721ea@linux.microsoft.com>
Date:   Sun, 4 Apr 2021 11:29:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <49790505-f611-b4a2-c804-b779060601a9@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 4/3/21 11:40 PM, Madhavan T. Venkataraman wrote:
> 
> 
> On 4/3/21 10:46 PM, Madhavan T. Venkataraman wrote:
>>> I'm somewhat arm-ignorant, so take the following comments with a grain
>>> of salt.
>>>
>>>
>>> I don't think changing these to 'bl' is necessary, unless you wanted
>>> __primary_switched() and __secondary_switched() to show up in the
>>> stacktrace for some reason?  If so, that seems like a separate patch.
>>>
>> The problem is with __secondary_switched. If you trace the code back to where
>> a secondary CPU is started, I don't see any calls anywhere. There are only
>> branches if I am not mistaken. So, the return address register never gets
>> set up with a proper address. The stack trace shows some hexadecimal value
>> instead of a symbol name.
>>
> 
> Actually, I take that back. There are calls in that code path. But I did only
> see some hexadecimal value instead of a proper address in the stack trace.
> Sorry about that confusion.
> 

Again, I apologize. I had this confused with something else in my notes.

So, the stack trace looks like this without my changes to convert the branch to
secondary_start_kernel() to a call:

		 ...
[    0.022492]   secondary_start_kernel+0x188/0x1e0
[    0.022503]   0xf8689e1cc

It looks like the code calls __enable_mmu before reaching the place where it
branches to secondary_start_kernel().

	bl      __enable_mmu

The return address register should be set to the next instruction address. I am
guessing that the return address is 0xf8689e1cc because of the idmap stuff.

Madhavan
