Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9AC47076
	for <live-patching@archiver.kernel.org>; Fri, 21 May 2021 17:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4733D61176
	for <live-patching@archiver.kernel.org>; Fri, 21 May 2021 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhEURZS (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 21 May 2021 13:25:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58268 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhEURZR (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 21 May 2021 13:25:17 -0400
Received: from [192.168.254.32] (unknown [47.187.214.213])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8EB9020B7188;
        Fri, 21 May 2021 10:23:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EB9020B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1621617834;
        bh=dsmQpGSpViASu2Lm8EpJourdT7RJuov0nXLCLji8uHw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iX33lxGgvBIWRLXPXT/y9uGoHbgKy27qqVfF/Y/wnHBeBjXJNYIeos5+GVAWP3c4Q
         +gy1NyQCSS/ip7vrI55Xbbx8vG19EyFK/FVXpzD08oKct5vo063qKdHzmLdR3FrefY
         H5O2mLHz3Ic11/fRCT5wM/jo4OLE5+vlG5gjbtIc=
Subject: Re: [RFC PATCH v4 1/2] arm64: Introduce stack trace reliability
 checks in the unwinder
To:     Mark Brown <broonie@kernel.org>
Cc:     mark.rutland@arm.com, jpoimboe@redhat.com, ardb@kernel.org,
        jthierry@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        jmorris@namei.org, pasha.tatashin@soleen.com,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <68eeda61b3e9579d65698a884b26c8632025e503>
 <20210516040018.128105-1-madvenka@linux.microsoft.com>
 <20210516040018.128105-2-madvenka@linux.microsoft.com>
 <20210521161117.GB5825@sirena.org.uk>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <a2a32666-c27e-3a0f-06b2-b7a2baa7e0f1@linux.microsoft.com>
Date:   Fri, 21 May 2021 12:23:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521161117.GB5825@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org



On 5/21/21 11:11 AM, Mark Brown wrote:
> On Sat, May 15, 2021 at 11:00:17PM -0500, madvenka@linux.microsoft.com wrote:
> 
>> Other reliability checks will be added in the future.
> 
> ...
> 
>> +	frame->reliable = true;
>> +
> 
> All these checks are good checks but as you say there's more stuff that
> we need to add (like your patch 2 here) so I'm slightly nervous about
> actually setting the reliable flag here without even a comment.  Equally
> well there's no actual use of this until arch_stack_walk_reliable() gets
> implemented so it's not like it's causing any problems and it gives us
> the structure to start building up the rest of the checks.
> 

OK. So how about changing the field from a flag to an enum that says exactly
what happened with the frame?

enum {
	FRAME_NORMAL = 0,
	FRAME_UNALIGNED,
	FRAME_NOT_ACCESSIBLE,
	FRAME_RECURSION,
	FRAME_GRAPH_ERROR,
	FRAME_INVALID_TEXT_ADDRESS,
	FRAME_UNRELIABLE_FUNCTION,
	FRAME_NUM_STATUS,
} frame_status;

struct stackframe {
	...
	enum frame_status status;
};

unwind_frame()
{
	frame->status = FRAME_NORMAL;

	Then, for each situation, change the status appropriately.
}

Eventually, arch_stack_walk_reliable() could just declare the stack trace
as unreliable if status != FRAME_NORMAL.

Also, the caller can get an exact idea of why the stack trace failed.

Is that acceptable?

> The other thing I guess is the question of if we want to bother flagging
> frames as unrelaible when we return an error; I don't see an issue with
> it and it may turn out to make it easier to do something in the future
> so I'm fine with that
Initially, I thought that there is no need to flag it for errors. But Josh
had a comment that the stack trace is indeed unreliable on errors. Again, the
word unreliable is the one causing the problem.

The above enum-based solution addresses Josh's comment as well.

Let me know if this is good.

Thanks!

Madhavan
