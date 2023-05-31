Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C54C77B7A
	for <live-patching@archiver.kernel.org>; Wed, 31 May 2023 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjEaIHz (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 31 May 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjEaIHb (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 31 May 2023 04:07:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599D10F;
        Wed, 31 May 2023 01:07:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 20F361FD5E;
        Wed, 31 May 2023 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685520449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUM5AZGuzh3NA3hPMl+xr64doRXqlNamY5Vlyreigp8=;
        b=i9MfnUbWPMzf0Q/bd4d6ADEpxR++Irdlm1Ilr5C2XJa6P0MddW1M5EgSog+6UxBa4L2WlP
        XVngHaXTs3GE694ZyL7CZiek8rz91k3aCy6kZr1Da3ZavuIVRw51xx1Z1vNsWGYZOfZjGT
        Epo162RzLDTQon1jSQ9XlnwbHK1yTs4=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E9A932C141;
        Wed, 31 May 2023 08:07:28 +0000 (UTC)
Date:   Wed, 31 May 2023 10:07:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] livepatch: Make 'klp_stack_entries' static
Message-ID: <ZHcAPpcb937tQ-cG@alley>
References: <5115752fca6537720700f4bf5b178959dfbca41a.1685488550.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5115752fca6537720700f4bf5b178959dfbca41a.1685488550.git.jpoimboe@kernel.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue 2023-05-30 16:15:58, Josh Poimboeuf wrote:
> The 'klp_stack_entries' percpu array is only used in transition.c.  Make
> it static.
> 
> Fixes: e92606fa172f ("livepatch: Convert stack entries array to percpu")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305171329.i0UQ4TJa-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
