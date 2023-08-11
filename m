Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B9C001B0
	for <live-patching@archiver.kernel.org>; Fri, 11 Aug 2023 11:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjHKLrV (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKLrV (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 11 Aug 2023 07:47:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AD106;
        Fri, 11 Aug 2023 04:47:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3C9861F74A;
        Fri, 11 Aug 2023 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691754438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9YWTlichUeu8aINqlG05NyhE+73L92aorFOpFi/F+4=;
        b=0+TSNHe3LzSOP4PFsElRp8MzRbBvNkLUPau3qgoa6WIz74uXDCr8qunGspt9f9Uz8R2zcj
        YQUHB4IBf4zAhJdsI7L/IU+yJ+ZPKfeDgj8ngFXalnF0Ccvl+jzQTgfeSxDuFFR55qtg3/
        46zokviSk05O9z8aHXyr2ICA6+Uidxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691754438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9YWTlichUeu8aINqlG05NyhE+73L92aorFOpFi/F+4=;
        b=huQqXZc1Lw0RItpTUV6uBeNEywhcYAfwM2fy/0tc5+yJwAcOrYPXknQ22jESO6g0zjUHTB
        OeDb7YoGQzslwbDQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EEE5C2C143;
        Fri, 11 Aug 2023 11:47:16 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:47:16 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
cc:     joe.lawrence@redhat.com, jpoimboe@kernel.org, jikos@kernel.org,
        pmladek@suse.com, nstange@suse.de, mpdesouza@suse.de,
        mark.rutland@arm.com, broonie@kernel.org, ndesaulniers@google.com,
        miguel.ojeda.sandonis@gmail.com, elena.zannoni@oracle.com,
        indu.bhagat@oracle.com, peterz@infradead.org, jmorris@namei.org,
        rostedt@goodmis.org, songliubraving@meta.com,
        madvenka@linux.microsoft.com
Subject: Re: [ANNOUNCE and CfP] Live Patching MC at LPC 2023
In-Reply-To: <alpine.LSU.2.21.2306141313530.8054@pobox.suse.cz>
Message-ID: <alpine.LSU.2.21.2308111057120.27256@pobox.suse.cz>
References: <alpine.LSU.2.21.2306141313530.8054@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi,

On Wed, 14 Jun 2023, Miroslav Benes wrote:

> Hello,
> 
> the Live Patching Microconference for Linux Plumbers Conference 2023 has 
> been accepted.
> 
> It is possible to submit topic proposals and abstracts for the 
> microconference through Indico system linked at [1]. I welcome you to do 
> so. Submissions should then be published at [2].
> 
> The rest still remains to be sorted out. Joe and I will share information 
> as it is available.
> 
> The registration will open soon [3].
> 
> See you in Richmond!
> 
> Miroslav
> 
> [1] https://lpc.events/event/17/abstracts/
> [2] https://lpc.events/event/17/contributions/1405/
> [3] https://lpc.events/blog/current/index.php/2023/06/14/registration-for-lpc-2023-is-almost-here/

Live Patching MC CfP blog post was published at 
https://lpc.events/blog/current/index.php/2023/08/09/live-patching-mc-cfp/

Let me use the opportunity to also encourage you to submit topics for the 
MC as mentioned above.

Thank you,
Miroslav

