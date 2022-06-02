Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3D8C43334
	for <live-patching@archiver.kernel.org>; Thu,  2 Jun 2022 13:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiFBNIi (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiFBNIh (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 2 Jun 2022 09:08:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDABE13C4DA;
        Thu,  2 Jun 2022 06:08:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0362721A07;
        Thu,  2 Jun 2022 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654175314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=l+rihViyzRHLYe5pHXuIcrWv2arO+I700S1clVGq4Ag=;
        b=LN4YX7poFEiKnuV9loE3mWA+oPKWrL8oXxADPXNYp4HYNG91XJToKj7kZg8TRBRQgaCqWE
        9mrq/2tX6rsyaKGZjPp0JOz+2jT5crEgozDraYQ8W0hgCEnA/cunvJz2ajD/1vL4c9HjLD
        ndJrHnyfQqmuHbfuxGuvIHJRqcfFNTQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6E082C141;
        Thu,  2 Jun 2022 13:08:33 +0000 (UTC)
Date:   Thu, 2 Jun 2022 15:08:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 5.19
Message-ID: <Ypi2UYFKG9ilflSh@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Linus,

please pull the latest livepatching changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-5.19

====================================

- Remove duplicated livepatch code. [Christophe]

----------------------------------------------------------------
Christophe Leroy (1):
      livepatch: Remove klp_arch_set_pc() and asm/livepatch.h

 MAINTAINERS                          |  2 --
 arch/powerpc/include/asm/livepatch.h | 10 +---------
 arch/powerpc/kernel/irq.c            |  1 -
 arch/powerpc/kernel/setup_64.c       |  2 +-
 arch/s390/include/asm/livepatch.h    | 22 ----------------------
 arch/x86/include/asm/livepatch.h     | 20 --------------------
 include/linux/livepatch.h            |  2 --
 kernel/livepatch/patch.c             |  2 +-
 8 files changed, 3 insertions(+), 58 deletions(-)
 delete mode 100644 arch/s390/include/asm/livepatch.h
 delete mode 100644 arch/x86/include/asm/livepatch.h
