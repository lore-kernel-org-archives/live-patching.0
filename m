Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68799C433DB
	for <live-patching@archiver.kernel.org>; Fri,  5 Mar 2021 09:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3428A64F44
	for <live-patching@archiver.kernel.org>; Fri,  5 Mar 2021 09:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEJBz (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:01:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCEJBs (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 5 Mar 2021 04:01:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614934907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Kp30uytmsNg2Mw/3nPTHC1DxKSNiJbeiTKU1HVR+PA=;
        b=dDGdUCaHS9xbO1Fr8N4/mWoeXqRxknl3FwhIcF3TyxOCsRNtGP+EiFZ2EMSDacQjUoFuom
        +29xXz3bx4R5Bw8B6DZxoVrv9QVEBPYbZnhwZfgQgABcVoM+Uxa9NQ9xBjKWZF6TqRIgRc
        9UAfPXFFi2jKUVC9KEhBT38QIq3ka8w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06B3FAEB3;
        Fri,  5 Mar 2021 09:01:47 +0000 (UTC)
Date:   Fri, 5 Mar 2021 10:01:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, corbet@lwn.net,
        live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: livepatch: Fix a typo in the file shadow-vars.rst
Message-ID: <YEHzevqbmZg8kZ+7@alley>
References: <20210305021720.21874-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305021720.21874-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri 2021-03-05 07:47:20, Bhaskar Chowdhury wrote:
> 
> s/ varibles/variables/
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

It might make sense to move the "In" to the next line. It sticks out
even more now.

Eitherway:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
