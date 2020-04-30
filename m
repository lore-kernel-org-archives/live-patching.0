Return-Path: <SRS0=iwJ0=6O=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D9C47253
	for <live-patching@archiver.kernel.org>; Thu, 30 Apr 2020 17:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CDD206C0
	for <live-patching@archiver.kernel.org>; Thu, 30 Apr 2020 17:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGpc8uvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgD3REU (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:04:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726333AbgD3REU (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 30 Apr 2020 13:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588266258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhnGahDqQjczcKUBCMlSkJo4Ce+ioGSLMDnlvtp40tA=;
        b=PGpc8uvwuk5D+DLYN0mCkOlCYF9oKKiCzqDbj105qgJm88FCbTL1E+fk/Q+xnB466mW1h/
        wdsr+PlJfv0r6f1NJtcxr/2AjGX+4CH0wcWl72qPY9mSylYd29u0nyNUjK6dqrJyAyb8bD
        wYkKfHzPgXKe0+KH0n+dnPvXkG8B/x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-gT3uIt64M3ezpWPYQQpIXQ-1; Thu, 30 Apr 2020 13:04:16 -0400
X-MC-Unique: gT3uIt64M3ezpWPYQQpIXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 672131895A2F;
        Thu, 30 Apr 2020 17:04:14 +0000 (UTC)
Received: from [10.3.112.171] (ovpn-112-171.phx2.redhat.com [10.3.112.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC3E5D9F5;
        Thu, 30 Apr 2020 17:04:11 +0000 (UTC)
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <20200422164037.7edd21ea@thinkpad> <20200422172126.743908f5@thinkpad>
 <20200422194605.n77t2wtx5fomxpyd@treble> <20200423141834.234ed0bc@thinkpad>
 <alpine.LSU.2.21.2004231513250.6520@pobox.suse.cz>
 <20200423141228.sjvnxwdqlzoyqdwg@treble>
 <20200423181030.b5mircvgc7zmqacr@treble> <20200430143821.GA10092@redhat.com>
 <20200430164842.bvkrh5fz24ro7ye2@treble>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <691690e3-b792-bac5-2080-2abfc0beb11b@redhat.com>
Date:   Thu, 30 Apr 2020 13:04:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200430164842.bvkrh5fz24ro7ye2@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On 4/30/20 12:48 PM, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 10:38:21AM -0400, Joe Lawrence wrote:
>> On Thu, Apr 23, 2020 at 01:10:30PM -0500, Josh Poimboeuf wrote:
>> This is more of note for the future, but when/if we add livepatch
>> support on arm64 we'll need to make the very same adjustment there as
>> well.  See the following pattern:
>>
>> arch/arm64/kernel/module.c:
>>
>>    reloc_insn_movw()
>>    reloc_insn_imm()
>>    reloc_insn_adrp()
>>
>>      *place = cpu_to_le32(insn);
>>
>> maybe something like aarch64_insn_patch_text_nosync() could be used
>> there, I dunno. (It looks like ftrace and jump_labels are using that
>> interface.)
>>
>> This is outside the scope of the patchset, but I thought I'd mention it
>> as I was curious to see how other arches were currently handling their
>> relocation updates.
> 
> True... I suspect your klp-convert selftests will catch that?
> 

Indeed.  Actually I had hacked enough livepatch code support on ARM to 
see what happened when converting and loading the test patches :)

-- Joe

