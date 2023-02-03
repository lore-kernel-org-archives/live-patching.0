Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F4DC05027
	for <live-patching@archiver.kernel.org>; Fri,  3 Feb 2023 13:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBCNe0 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBCNeZ (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 3 Feb 2023 08:34:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F51E1C2;
        Fri,  3 Feb 2023 05:33:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 69527347ED;
        Fri,  3 Feb 2023 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675431232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wTC7Bms8cbQ0n7iinvRyXy78NStbsiv0gi6XzEH9iqM=;
        b=FY397H6NkF22fbvzgLjwwGc73MWQDbovI58jJqkOhKIaKyUcyO+NctvitzHqr96P8EV63k
        dSUfZbnA1sLX9/Rpri+nCmNmL7Nk9e4fMYe/6xT5ua7E/V1vNihcWy1E1icXOrMU8keAD/
        3sWPc7Mx81ILtvxqsumkxWlanMsYQtk=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 38D962C141;
        Fri,  3 Feb 2023 13:33:51 +0000 (UTC)
Date:   Fri, 3 Feb 2023 14:33:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v11 1/2] x86/module: remove unused code in
 __apply_relocate_add
Message-ID: <Y90NPGBRan67ejf7@alley>
References: <20230125185401.279042-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125185401.279042-1-song@kernel.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed 2023-01-25 10:54:00, Song Liu wrote:
> This "#if 0" block has been untouched for many years. Remove it to clean
> up the code.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Song Liu <song@kernel.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, I have pushed the patchset into livepatching.git,
branch for-6.3/cleanup-relocations.

It has got quite a lot review and testing. And I consider Josh's ack
to be enough from the x86 maintainers side.

Best Regards,
Petr
