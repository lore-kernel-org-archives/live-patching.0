Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE85C27C76
	for <live-patching@archiver.kernel.org>; Wed, 25 Jan 2023 13:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjAYNbf (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 25 Jan 2023 08:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYNbd (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 25 Jan 2023 08:31:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CB4B490;
        Wed, 25 Jan 2023 05:31:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 84ED41F854;
        Wed, 25 Jan 2023 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674653491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pkYqfHPGmzeHocvv83wx0Y3+zQ94GNdz2CdFbiQ4jVI=;
        b=g9DgVNrXVWxk1UtKhExUALjPBThgTj85mQIVnaR7pkdykdfNb7FMLGGXC6kkXB6Uk1Q8mw
        GRjko2f6olOZhKImurgGVk1uT1ihMBT7qrClyUZoetEDCz90qiRsBNbhLVe9CLOIlw+nhE
        v/9ONhDS+F2kV0RjaWrOAvcxPic12+Y=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5EFE52C141;
        Wed, 25 Jan 2023 13:31:31 +0000 (UTC)
Date:   Wed, 25 Jan 2023 14:31:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        live-patching@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH 2/2] powerpc/module_64: Fix "expected nop" error on
 module re-patching
Message-ID: <Y9EvM+uuMsE2yVWz@alley>
References: <cover.1674617130.git.jpoimboe@kernel.org>
 <2f6329ffd9674df6ff57e03edeb2ca54414770ab.1674617130.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6329ffd9674df6ff57e03edeb2ca54414770ab.1674617130.git.jpoimboe@kernel.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue 2023-01-24 19:38:05, Josh Poimboeuf wrote:
> When a module with a livepatched function is unloaded and then reloaded,
> klp attempts to dynamically re-patch it.  On ppc64, that fails with the
> following error:
> 
>   module_64: livepatch_nfsd: Expected nop after call, got e8410018 at e_show+0x60/0x548 [livepatch_nfsd]
>   livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
>   livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'
> 
> The error happens because the restore r2 instruction had already
> previously been written into the klp module's replacement function when
> the original function was patched the first time.  So the instruction
> wasn't a nop as expected.
> 
> When the restore r2 instruction has already been patched in, detect that
> and skip the warning and the instruction write.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

It seems that the function does what it says. And it seems to be the
only location where an instruction is checked before it is modified.
I am fine with this approach.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
