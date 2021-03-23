Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BCFC433C1
	for <live-patching@archiver.kernel.org>; Tue, 23 Mar 2021 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA5661585
	for <live-patching@archiver.kernel.org>; Tue, 23 Mar 2021 14:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhCWOPp (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:15:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35476 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhCWOPi (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 23 Mar 2021 10:15:38 -0400
Received: from [192.168.254.32] (unknown [47.187.194.202])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1AB2920B5680;
        Tue, 23 Mar 2021 07:15:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1AB2920B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616508937;
        bh=xgH5742pf9m8cPa2AZwpL/Wba0dOvxATlNgx0Syu1uY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=dd74ytk9ub/9O/tG2Uc0luCp0AuFiMdkHXYkoCQ9PD7OQmA+zDSONc2/U6D+ULydO
         YFRRHcUZWyDVvBOZfzqobW0AyhOCGO2uG7dwt2KIFDluc07ftHfwW9q/w9efBYr5sv
         MbCvwDCoI+7N+ghkk2JlZ6JpgYUnso6TdZxiS044=
Subject: Re: [RFC PATCH v2 5/8] arm64: Detect an FTRACE frame and mark a stack
 trace unreliable
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     broonie@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5997dfe8d261a3a543667b83c902883c1e4bd270>
 <20210315165800.5948-1-madvenka@linux.microsoft.com>
 <20210315165800.5948-6-madvenka@linux.microsoft.com>
 <20210323105118.GE95840@C02TD0UTHF1T.local>
 <2167f3c5-e7d0-40c8-99e3-ae89ceb2d60e@linux.microsoft.com>
 <20210323133611.GB98545@C02TD0UTHF1T.local>
 <ccd5ee66-6444-fac9-4c7b-b3bdabf1b149@linux.microsoft.com>
Message-ID: <f9e21fe1-e646-bb36-c711-94cbbc60af8a@linux.microsoft.com>
Date:   Tue, 23 Mar 2021 09:15:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ccd5ee66-6444-fac9-4c7b-b3bdabf1b149@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Mark,

I have a general question. When exceptions are nested, how does it work? Let us consider 2 cases:

1. Exception in a page fault handler itself. In this case, I guess one more pt_regs will get
   established in the task stack for the second exception.

2. Exception in an interrupt handler. Here the interrupt handler is running on the IRQ stack.
   Will the pt_regs get created on the IRQ stack?

Also, is there a maximum nesting for exceptions?

Madhavan
