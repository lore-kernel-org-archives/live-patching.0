Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23577C432BE
	for <live-patching@archiver.kernel.org>; Thu, 26 Aug 2021 23:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031B560FE6
	for <live-patching@archiver.kernel.org>; Thu, 26 Aug 2021 23:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbhHZXT6 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:19:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36022 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhHZXT5 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 26 Aug 2021 19:19:57 -0400
Received: from [192.168.254.32] (unknown [47.187.212.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A5A420B861E;
        Thu, 26 Aug 2021 16:19:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A5A420B861E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1630019949;
        bh=TNk71oULKpnJVXpIAkpW4dxCRZZFfi0WY/GV0rQ4Blw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sDrPH0DIYqzWljDeynFQ2cHN8Shft6uXuyS4L8KXZr4/VtcLamVAxWh5cQW0bRTzZ
         jRY4voAsLQE2MfrL7Lxe/Oqs/DQ0JxZFajO2NvhnOok99Bv9D9JJvywU8FT7g7p6vD
         vtYq3ii0I1E1jMYUrrV4jbhwRbx90qfjp7fFyjq4=
Subject: Re: [RFC PATCH v8 2/4] arm64: Reorganize the unwinder code for better
 consistency and maintenance
To:     Mark Brown <broonie@kernel.org>
Cc:     mark.rutland@arm.com, jpoimboe@redhat.com, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        pasha.tatashin@soleen.com, jthierry@redhat.com,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b45aac2843f16ca759e065ea547ab0afff8c0f01>
 <20210812190603.25326-1-madvenka@linux.microsoft.com>
 <20210812190603.25326-3-madvenka@linux.microsoft.com>
 <YSe3WogpFIu97i/7@sirena.org.uk>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <ecf0e4d1-7c47-426e-1350-fe5dc8bd88a5@linux.microsoft.com>
Date:   Thu, 26 Aug 2021 18:19:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSe3WogpFIu97i/7@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 8/26/21 10:46 AM, Mark Brown wrote:
> On Thu, Aug 12, 2021 at 02:06:01PM -0500, madvenka@linux.microsoft.com wrote:
> 
>> Renaming of unwinder functions
>> ==============================
> 
>> Rename unwinder functions to unwind_*() similar to other architectures
>> for naming consistency. More on this below.
> 
> This feels like it could probably do with splitting up a bit for
> reviewability, several of these headers you've got in the commit
> logs look like they could be separate commits.  Splitting things
> up does help with reviewability, having only one change to keep
> in mind at once is a lot less cognative load.
> 
>> Replace walk_stackframe() with unwind()
>> =======================================
>>
>> walk_stackframe() contains the unwinder loop that walks the stack
>> frames. Currently, start_backtrace() and walk_stackframe() are called
>> separately. They should be combined in the same function. Also, the
>> loop in walk_stackframe() should be simplified and should look like
>> the unwind loops in other architectures such as X86 and S390.
> 
> This definitely seems like a separate change.
> 

OK. I will take a look at splitting the patch.

I am also requesting a review of the sym_code special section approach.
I know that you have already approved it. I wanted one more vote. Then,
I can remove the "RFC" word from the title and then it will be just a
code review of the patch series.

Mark Rutland,

Do you also approve the idea of placing unreliable functions (from an unwind
perspective) in a special section and using that in the unwinder for
reliable stack trace?

Thanks.

Madhavan
