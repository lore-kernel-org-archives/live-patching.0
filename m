Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B06C433EF
	for <live-patching@archiver.kernel.org>; Mon, 27 Jun 2022 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiF0RGX (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiF0RGW (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 27 Jun 2022 13:06:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D080C18B23;
        Mon, 27 Jun 2022 10:06:21 -0700 (PDT)
Received: from [192.168.254.32] (unknown [47.189.24.195])
        by linux.microsoft.com (Postfix) with ESMTPSA id D5D4020CD15E;
        Mon, 27 Jun 2022 10:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5D4020CD15E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656349581;
        bh=5zYBrlNIUudUdqQqiRpxFOq8tdUweJZQW6d/b/T6x2s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zt6t15rkvzx3wKjGM6F5N/ExJs15T9HqLE5L6XwX3ZtMcDoor/c16k9dECQWThedH
         TQLWVo68I0VVeghqY4Kw+g4x6o6eDzPD3MUoffkiYmiXmK+ShdOrBcJ+aL/WXAaG6x
         GPwAGZgCKugsgtmeUiKgfcIhimpWsiq8HY8b+OZA=
Message-ID: <af83e538-fc7c-03d7-a11e-a5b257b65837@linux.microsoft.com>
Date:   Mon, 27 Jun 2022 12:06:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v15 0/6] arm64: Reorganize the unwinder and implement
 stack trace reliability checks
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, ardb@kernel.org, mark.rutland@arm.com,
        jamorris@linux.microsoft.com, jpoimboe@redhat.com,
        nobuta.keiya@fujitsu.com, live-patching@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
References: <ff68fb850d42e1adaa6a0a6c9c258acabb898b24>
 <20220617180219.20352-1-madvenka@linux.microsoft.com>
 <165632350271.638103.10773612881829908260.b4-ty@kernel.org>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <165632350271.638103.10773612881829908260.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 6/27/22 08:00, Will Deacon wrote:
> On Fri, 17 Jun 2022 13:02:13 -0500, madvenka@linux.microsoft.com wrote:
>> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>
>> I have synced this patch series to v5.19-rc2.
>> I have also removed the following patch.
>>
>> 	[PATCH v14 7/7] arm64: Select HAVE_RELIABLE_STACKTRACE
>>
>> [...]
> 
> Applied first two patches to arm64 (for-next/stacktrace), thanks!
> 
> [1/6] arm64: Split unwind_init()
>       https://git.kernel.org/arm64/c/a019d8a2cc82
> [2/6] arm64: Copy the task argument to unwind_state
>       https://git.kernel.org/arm64/c/82a592c13b0a
> 
> Cheers,

Great!

Thanks!

Madhavan
