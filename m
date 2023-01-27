Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D9DC38142
	for <live-patching@archiver.kernel.org>; Fri, 27 Jan 2023 12:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjA0Mko (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 27 Jan 2023 07:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjA0Mje (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 27 Jan 2023 07:39:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996167E047;
        Fri, 27 Jan 2023 04:38:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 210851FF3C;
        Fri, 27 Jan 2023 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674823103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dg/eZw9C2WEGUOLobcqz+Lpe/vuPYoV3mKnbpIUu6/Q=;
        b=Ad+cNpj/TSE9SFlIsoDZIWx9lsf197KgIpbXzFMdtjAAP08CL8GRm27Ukusg26Xi292FZv
        iIFNZhud0zPzcoH16g8IctWfqoRlN7oVJc0tjjspHjqf02EWyVJ4iXL1og3pnxg/leM7r3
        gjjcdpg+qHxCkJyJkXC5SGsoAI+2Iug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674823103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dg/eZw9C2WEGUOLobcqz+Lpe/vuPYoV3mKnbpIUu6/Q=;
        b=Odo7hPqrvOEgs4vQJva60XbLzuMONIFl3t72oFZ5rbE7h5n2Jo0e8vciALpbb3apamadxv
        2cWpHvzUzp+7F6DQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 87D2C2C141;
        Fri, 27 Jan 2023 12:38:21 +0000 (UTC)
Date:   Fri, 27 Jan 2023 13:38:26 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     Michael Ellerman <mpe@ellerman.id.au>,
        live-patching@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/2] powerpc/module_64: Improve restore_r2() return
 semantics
In-Reply-To: <15baf76c271a0ae09f7b8556e50f2b4251e7049d.1674617130.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2301271338001.7389@pobox.suse.cz>
References: <cover.1674617130.git.jpoimboe@kernel.org> <15baf76c271a0ae09f7b8556e50f2b4251e7049d.1674617130.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, 24 Jan 2023, Josh Poimboeuf wrote:

> restore_r2() returns 1 on success, which is surprising for a non-boolean
> function.  Change it to return 0 on success and -errno on error to match
> kernel coding convention.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
