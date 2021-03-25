Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7382C433DB
	for <live-patching@archiver.kernel.org>; Thu, 25 Mar 2021 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7395361962
	for <live-patching@archiver.kernel.org>; Thu, 25 Mar 2021 09:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCYJFy (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:41220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCYJFr (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 25 Mar 2021 05:05:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BBCEAC6A;
        Thu, 25 Mar 2021 09:05:46 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:05:46 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, corbet@lwn.net,
        live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: livepatch: Fix a typo
In-Reply-To: <20210325065646.7467-1-unixbhaskar@gmail.com>
Message-ID: <alpine.LSU.2.21.2103250956530.30447@pobox.suse.cz>
References: <20210325065646.7467-1-unixbhaskar@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi,

On Thu, 25 Mar 2021, Bhaskar Chowdhury wrote:

> 
> s/varibles/variables/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/livepatch/shadow-vars.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/livepatch/shadow-vars.rst b/Documentation/livepatch/shadow-vars.rst
> index c05715aeafa4..8464866d18ba 100644
> --- a/Documentation/livepatch/shadow-vars.rst
> +++ b/Documentation/livepatch/shadow-vars.rst
> @@ -165,7 +165,7 @@ In-flight parent objects
> 
>  Sometimes it may not be convenient or possible to allocate shadow
>  variables alongside their parent objects.  Or a livepatch fix may
> -require shadow varibles to only a subset of parent object instances.  In
> +require shadow variables to only a subset of parent object instances.  In
>  these cases, the klp_shadow_get_or_alloc() call can be used to attach
>  shadow variables to parents already in-flight.

you sent the same fix a couple of weeks ago and Jon applied it.

Miroslav
