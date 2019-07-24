Return-Path: <SRS0=KNr2=VV=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D6C7618F
	for <live-patching@archiver.kernel.org>; Wed, 24 Jul 2019 20:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9242820693
	for <live-patching@archiver.kernel.org>; Wed, 24 Jul 2019 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999592;
	bh=NR2+6PT7l3YN8pNusq+j1LBpWGnRCt7/+N+k65V7US8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xdtucaAqiPOVx9gBLAno8MYHaaidgmy3p8E0K6cs7asOPuIZq7q9rnaolPa36x8PV
	 Iror4qUx/2IuM3Wk0rggps7CrXE0xQW9BAMWnj++P2niNrVbGl1q9DNLc4tbHcS/UU
	 wsriD67AYeMih9u06+kr5JikYJ/7EMPt0qrqA55E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbfGXUTv (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391140AbfGXUTv (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 24 Jul 2019 16:19:51 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D529220693;
        Wed, 24 Jul 2019 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563999590;
        bh=NR2+6PT7l3YN8pNusq+j1LBpWGnRCt7/+N+k65V7US8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DDV+DcxKuXsVa3MSEGmOwt0irQqsM00CrbJnW+Qe2d5OgU2BICykVYzDALIOtGv4e
         9bDdAX5uFLWUBsQ/FALahWsA0uxuVLKpaEVyHWdEymDHl+VkJ8Af4TgVGpjoFwDv4v
         qLemdY/dw02HOtJijYY8fMp/Z7SEoQA10XJAK8w4=
Subject: Re: [PATCH v4] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>
References: <e450e2ec-b683-f712-c8d5-ef1c2e2dee7c@kernel.org>
 <20190724200558.6412-1-joe.lawrence@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <92c4941a-e1cc-4933-9cc0-610f9ec349c5@kernel.org>
Date:   Wed, 24 Jul 2019 14:19:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724200558.6412-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On 7/24/19 2:05 PM, Joe Lawrence wrote:
> Add a skip() message function that stops the test, logs an explanation,
> and sets the "skip" return code (4).
> 
> Before loading a livepatch self-test kernel module, first verify that
> we've built and installed it by running a 'modprobe --dry-run'.  This
> should catch a few environment issues, including !CONFIG_LIVEPATCH and
> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
> skip() function.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
> 
> v4: s/unable load/unable to load/ in user visible skip message. [shuah]
> 

Thanks. Applied to linux-ksefktest fixes for 5.3-rc2 with Petr's Ack

thanks,
-- Shuah
