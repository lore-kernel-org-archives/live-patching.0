Return-Path: <SRS0=v7hF=5C=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDABEC10F29
	for <live-patching@archiver.kernel.org>; Tue, 17 Mar 2020 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C887320663
	for <live-patching@archiver.kernel.org>; Tue, 17 Mar 2020 09:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgCQJOB (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgCQJOB (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 17 Mar 2020 05:14:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D09CAB7F;
        Tue, 17 Mar 2020 09:13:59 +0000 (UTC)
Date:   Tue, 17 Mar 2020 10:13:57 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jslaby@suse.cz
Subject: Re: [PATCH 1/2] x86/xen: Make the boot CPU idle task reliable
In-Reply-To: <1b98d601-d9d9-879c-918c-737830d80ac5@oracle.com>
Message-ID: <alpine.LSU.2.21.2003171013420.21109@pobox.suse.cz>
References: <20200312142007.11488-1-mbenes@suse.cz> <20200312142007.11488-2-mbenes@suse.cz> <1b98d601-d9d9-879c-918c-737830d80ac5@oracle.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon, 16 Mar 2020, Boris Ostrovsky wrote:

> 
> 
> On 3/12/20 10:20 AM, Miroslav Benes wrote:
> > --- a/arch/x86/xen/xen-head.S
> > +++ b/arch/x86/xen/xen-head.S
> > @@ -35,7 +35,7 @@ SYM_CODE_START(startup_xen)
> >  	rep __ASM_SIZE(stos)
> >  
> >  	mov %_ASM_SI, xen_start_info
> > -	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
> > +	mov $init_thread_union+THREAD_SIZE-SIZEOF_PTREGS, %_ASM_SP
> 
> This is initial_stack, isn't it?

It is. I'll change it.

Thanks
Miroslav
