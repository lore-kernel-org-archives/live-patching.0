Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B45BEB64D9
	for <live-patching@archiver.kernel.org>; Wed, 14 Jun 2023 11:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjFNLe7 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 14 Jun 2023 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbjFNLev (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 14 Jun 2023 07:34:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87D199B;
        Wed, 14 Jun 2023 04:34:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E670A1FDE8;
        Wed, 14 Jun 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686742486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=XUS6LnF3QcGYPv+Pi9a6q4EMakth990haEuXywcllOE=;
        b=FqYhHe1Uv6V54jBgYPolfRKycLgOt3S0kEFiYgCnDgo68eDCEwo5Y4ZKAxcVxp0rYVfDhA
        XH1bmEek0qGf5QxBwcEJ65xc5evf59b7aP8CzLnYoWfUnGleVCYqR1FQ9KXQAy9xtjDAXN
        Z6JQSYMOQKucpancAkGGbryY3a7AfcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686742486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=XUS6LnF3QcGYPv+Pi9a6q4EMakth990haEuXywcllOE=;
        b=CE/8gvggVW8S5pJU0ZTwoouLIdWvKWIpOa+wb/LXvMoKopdiwRVUH/VIsXGWUUeeleyfGa
        JtkFiJd5n/Xyk8Dw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E46CC2C141;
        Wed, 14 Jun 2023 11:34:45 +0000 (UTC)
Date:   Wed, 14 Jun 2023 13:34:45 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
cc:     joe.lawrence@redhat.com, jpoimboe@kernel.org, jikos@kernel.org,
        pmladek@suse.com, nstange@suse.de, mpdesouza@suse.de,
        mark.rutland@arm.com, broonie@kernel.org, ndesaulniers@google.com,
        miguel.ojeda.sandonis@gmail.com, elena.zannoni@oracle.com,
        indu.bhagat@oracle.com, peterz@infradead.org, jmorris@namei.org,
        rostedt@goodmis.org, songliubraving@meta.com,
        madvenka@linux.microsoft.com, mbenes@suse.cz
Subject: [ANNOUNCE and CfP] Live Patching MC at LPC 2023
Message-ID: <alpine.LSU.2.21.2306141313530.8054@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hello,

the Live Patching Microconference for Linux Plumbers Conference 2023 has 
been accepted.

It is possible to submit topic proposals and abstracts for the 
microconference through Indico system linked at [1]. I welcome you to do 
so. Submissions should then be published at [2].

The rest still remains to be sorted out. Joe and I will share information 
as it is available.

The registration will open soon [3].

See you in Richmond!

Miroslav

[1] https://lpc.events/event/17/abstracts/
[2] https://lpc.events/event/17/contributions/1405/
[3] https://lpc.events/blog/current/index.php/2023/06/14/registration-for-lpc-2023-is-almost-here/

