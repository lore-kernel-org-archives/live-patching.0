Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0F2C433EF
	for <live-patching@archiver.kernel.org>; Mon, 27 Jun 2022 04:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiF0Edd (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 27 Jun 2022 00:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiF0Edc (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 27 Jun 2022 00:33:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C4A2703;
        Sun, 26 Jun 2022 21:33:32 -0700 (PDT)
Received: from [192.168.254.32] (unknown [47.189.24.195])
        by linux.microsoft.com (Postfix) with ESMTPSA id B38A120CD148;
        Sun, 26 Jun 2022 21:33:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B38A120CD148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656304411;
        bh=avE7xHHELqklzPDcSt/YrOSC54CUqeqgCWJf4YeqCVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AbmNMsBTteWcN2qnNTjhnSHk3tPGG66xQvbhOJeywSKTIVS/xs1/1IUJZkFKa0O3C
         RN5sjJueloOEnAO9+foLCHUlIAFtCyuPSwtg3JONIrX+H18mNMBokugjAySLgXCAMX
         z9lYTQ5GLt3kqXGk8WbjHsa8KqM3lbw7EG3KlhLU=
Message-ID: <b7f62c2e-b2ef-1528-d126-b2e0c001a7c4@linux.microsoft.com>
Date:   Sun, 26 Jun 2022 23:33:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v15 0/6] arm64: Reorganize the unwinder and implement
 stack trace reliability checks
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, broonie@kernel.org,
        jpoimboe@redhat.com, ardb@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com,
        jamorris@linux.microsoft.com, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, Kalesh Singh <kaleshsingh@google.com>
References: <ff68fb850d42e1adaa6a0a6c9c258acabb898b24>
 <20220617210717.27126-1-madvenka@linux.microsoft.com>
 <20220623173224.GB16966@willie-the-truck>
 <66545c21-cfcf-60eb-4acf-39be99520369@linux.microsoft.com>
 <YrgkdBtbFmOvKJpX@FVFF77S0Q05N>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <YrgkdBtbFmOvKJpX@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 6/26/22 04:18, Mark Rutland wrote:
> On Fri, Jun 24, 2022 at 12:19:01AM -0500, Madhavan T. Venkataraman wrote:
>>
>>
>> On 6/23/22 12:32, Will Deacon wrote:
>>> On Fri, Jun 17, 2022 at 04:07:11PM -0500, madvenka@linux.microsoft.com wrote:
>>>> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>>>
>>>> I have synced this patch series to v5.19-rc2.
>>>> I have also removed the following patch.
>>>>
>>>> 	[PATCH v14 7/7] arm64: Select HAVE_RELIABLE_STACKTRACE
>>>>
>>>> as HAVE_RELIABLE_STACKTRACE depends on STACK_VALIDATION which is not present
>>>> yet. This patch will be added in the future once Objtool is enhanced to
>>>> provide stack validation in some form.
>>>
>>> Given that it's not at all obvious that we're going to end up using objtool
>>> for arm64, does this patch series gain us anything in isolation?
>>>
>>
>> BTW, I have synced my patchset to 5.19-rc2 and sent it as v15.
>>
>> So, to answer your question, patches 1 thru 3 in v15 are still useful even if we don't
>> consider reliable stacktrace. These patches reorganize the unwinder code based on
>> comments from both Mark Rutland and Mark Brown. Mark Brown has already OKed them.
>> If Mark Rutland OKes them, we should upstream them.
> 
> Sorry for the delay; I have been rather swamped recently and haven't had the
> time to give this the time it needs.
> 
> I'm happy with patches 1 and 2, and I've acked those in case Will wants to pick
> them.
> 
> Kalesh (cc'd) is working to share the unwinder code with hyp, and I think that
> we need to take a step back and consider how we can make the design work
> cleanly with that. I'd had a go at prototyping making the unwinder more data
> driven, but I haven't come up with something satisfactory so far.
> 
> It would be good if you could look at / comment on each others series.
> 

I will review Kalesh's unwinder changes.

Thanks.

Madhavan
