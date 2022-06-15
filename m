Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EACC43334
	for <live-patching@archiver.kernel.org>; Wed, 15 Jun 2022 19:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiFOTTE (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiFOTTD (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 15 Jun 2022 15:19:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACC7B3A1A0;
        Wed, 15 Jun 2022 12:19:02 -0700 (PDT)
Received: from [192.168.254.32] (unknown [47.189.24.195])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0FE6A20C3239;
        Wed, 15 Jun 2022 12:19:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FE6A20C3239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655320741;
        bh=P855J7pf3ewIUtrhK1hWBmF29lom3t1KgcuEvkxebuc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pOmKYo3IPTir0+5ozXAufh+VdyvmhMdSCspGc9BfccOXahk5hUqc43WF7dg49miGc
         0Nx6OZVNweibfIAqrrW1kbrtZwaTM8by7akWeMkZpSfXq2GxI0G3wksWJpe962+QZp
         w0XRyd9dLrUCTkpWiwl01XdG6XObLHde1r3nEPGc=
Message-ID: <8d890e05-f22f-8165-72db-d96b51d9589a@linux.microsoft.com>
Date:   Wed, 15 Jun 2022 14:19:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v14 0/7] arm64: Reorganize the unwinder and implement
 stack trace reliability checks
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     mark.rutland@arm.com, jpoimboe@redhat.com, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460a35f88195413bcf7305e5083480aab3ca858>
 <20220413140528.3815-1-madvenka@linux.microsoft.com>
 <YqjKBF1dNKbTZrpY@sirena.org.uk>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <YqjKBF1dNKbTZrpY@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 6/14/22 12:48, Mark Brown wrote:
> On Wed, Apr 13, 2022 at 09:05:21AM -0500, madvenka@linux.microsoft.com wrote:
>> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>
>> I have rebased this patch series on top of this branch:
>>
>> 	arm64/stacktrace/cleanups
>>
>> in Mark Rutland's fork of Linux. The branch contains a set of patches
>> from Mark and me for reliable stack trace.
> 
> Do you have any plans to resend this based on v5.19-rcN?  I know you
> were waiting for some more review feedback but everyone's review queues
> will most likely have been flushed with the new release so it'll need a
> resend.  I was half thinking about some related stuff so I went to apply
> these but saw there's some small conflicts.

I will look at resending based on v5.19-rcN ASAP.

Madhavan
