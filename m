Return-Path: <SRS0=wFxF=5E=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F9C4332B
	for <live-patching@archiver.kernel.org>; Thu, 19 Mar 2020 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6112120732
	for <live-patching@archiver.kernel.org>; Thu, 19 Mar 2020 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSKDQ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:03:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSKDQ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 19 Mar 2020 06:03:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2511BB14B;
        Thu, 19 Mar 2020 10:03:14 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] x86/xen: Make the secondary CPU idle tasks
 reliable
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        xen-devel@lists.xenproject.org, jslaby@suse.cz
References: <20200319095606.23627-1-mbenes@suse.cz>
 <20200319095606.23627-3-mbenes@suse.cz>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <2ca0a03c-734c-3a9e-90fd-8209046c5f01@suse.com>
Date:   Thu, 19 Mar 2020 11:03:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319095606.23627-3-mbenes@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On 19.03.2020 10:56, Miroslav Benes wrote:
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -53,6 +53,7 @@ static DEFINE_PER_CPU(struct xen_common_irq, xen_irq_work) = { .irq = -1 };
>  static DEFINE_PER_CPU(struct xen_common_irq, xen_pmu_irq) = { .irq = -1 };
>  
>  static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id);
> +extern unsigned char asm_cpu_bringup_and_idle[];

Imo this would better reflect the actual type, i.e. be a function
decl. If left as an array one, I guess you may want to add const.

Jan
