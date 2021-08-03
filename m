Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C069C4320E
	for <live-patching@archiver.kernel.org>; Tue,  3 Aug 2021 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4927860F38
	for <live-patching@archiver.kernel.org>; Tue,  3 Aug 2021 13:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhHCNA7 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235635AbhHCNA7 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 3 Aug 2021 09:00:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B465860F58;
        Tue,  3 Aug 2021 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627995648;
        bh=x8tLKf2iqjAE25o6wOR+v32eKv+Q4BdSwsKqq405Lxg=;
        h=From:To:Cc:Subject:Date:From;
        b=diIHh1zAb2SfxUhPfEBtJYfRDuLsJzeWzc1GtKiklh4IvpncE/wx9lGeMKzdhxhal
         8dMKu/KKpARUATOmXgm8GW9EseZTgszIOfbRsYeQdysWx/t5j3pMlsnlkDXyhzAaFF
         VcNDa8ugzXY+33oRJ+ctHU4ao/5HQsu1f5YyjeEGCQG79ghagi08xZOi5DWfezJga2
         aU0+R5ZACIUXpfWcuUEEZta9uXgWgLKT/g0gTkh10sEuOB6mWMobGqkXrIqgEJSAWy
         INL8zQG8sp1exgONvGEaq4OY2KOqouzoFwG5TmVIJpOK0Y6KsyoNUfcNlnXmLEgjAy
         I0lXgLpLm314w==
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] MAINTAINERS: Add Luis Chamberlain as modules maintainer
Date:   Tue,  3 Aug 2021 14:57:13 +0200
Message-Id: <20210803125713.725-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Luis has kindly agreed to help maintain the module loader. As my
responsibilities have shifted, I've found myself with less cycles to
devote to upstream maintenance these days. Luis is already very involved
and engaged upstream, and with his experience maintaining the kmod
module loader and usermode helper, I believe he is a great fit for this
area of the kernel.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

Hi all, just a heads up that Luis will be a co-maintainer for modules.
For the most part I've CC'd subsystem lists that have interacted with
modules in the past, and should probably be aware of this change. Thanks!

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..d2bdcc8dc25f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12526,6 +12526,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/mn88473*
 
 MODULE SUPPORT
+M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Jessica Yu <jeyu@kernel.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
-- 
2.32.0

