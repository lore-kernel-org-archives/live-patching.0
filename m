Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D74C77B78
	for <live-patching@archiver.kernel.org>; Mon, 24 Apr 2023 16:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjDXQev (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDXQen (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 24 Apr 2023 12:34:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834493D9;
        Mon, 24 Apr 2023 09:34:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DD9C021940;
        Mon, 24 Apr 2023 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682354078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MDpzWRcrbqAUpyocmU4HQzm2y3pg6rIhhQfP9I2eGw4=;
        b=HA8r+QcsTO6umNdlPZ28XZBArETDhRBOOLCSPWk7MjOcVuerZ69e+kGxN2L+DXLRR/4qr1
        YNX1+8hsaTyqeRIA3Qr96Ne/09+lebeJlkYCI4SAfUtxyDM0Vm1FOYaaOawg3ZCYPR0vmx
        eH2AXDrI/ItxYHTi2Bi0UD9q6oBz3iE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 903402C141;
        Mon, 24 Apr 2023 16:34:38 +0000 (UTC)
Date:   Mon, 24 Apr 2023 18:34:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 6.4
Message-ID: <ZEavnK8VfIXr-jsP@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-6.4

=======================================

+ Code and documentation cleanup.

----------------------------------------------------------------
Alexey Dobriyan (1):
      livepatch: fix ELF typos

Petr Mladek (1):
      Merge branch 'for-6.4/doc' into for-linus

Thomas Weiﬂschuh (1):
      livepatch: Make kobj_type structures constant

 Documentation/livepatch/module-elf-format.rst | 20 ++++++++++----------
 include/linux/module.h                        |  6 +++---
 kernel/livepatch/core.c                       |  6 +++---
 kernel/module/livepatch.c                     | 10 +++++-----
 4 files changed, 21 insertions(+), 21 deletions(-)
