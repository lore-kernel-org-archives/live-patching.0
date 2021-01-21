Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9920C433DB
	for <live-patching@archiver.kernel.org>; Thu, 21 Jan 2021 20:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810DF23A54
	for <live-patching@archiver.kernel.org>; Thu, 21 Jan 2021 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbhAUUWn (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbhAUHyY (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 21 Jan 2021 02:54:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB9C061575;
        Wed, 20 Jan 2021 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ONID8gyRp4D9LboqpnEB5JYovGYChIbNg2MDOx4Yqrs=; b=T6cm3ehW9rEwrCZeH7coydp9rd
        OywS7RMVA+H/yjIPo3Pbc5aU94bgMFH/85dZrDUn2R91HDRElis1VQSFCF4A94flMwa7f4J2Kacop
        lZsl7aKgDr+nhZHQytsIu2GpzY6eXIZkNnQaakRBRpoQUTkmhWhrNullFS7owS//1+1xpAI2m3jWK
        ANEjDej31QQM3eUYwZOCpVNHDEzDkykwcjyHVQ+K6eS/l0yQ72S9CIZg65akaCu74Tgpx88mq26ln
        Ly3kQ48c2/5Lgk70JRsBHASD17utaXqjVbEuV3IlxoEzh70Q055ozUNYF/o/xMbgmTTILtRCwERHo
        ouNoDBPA==;
Received: from [2001:4bb8:188:1954:d5b3:2657:287:e45f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Uld-00Gm2M-4T; Thu, 21 Jan 2021 07:52:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 01/13] powerpc/powernv: remove get_cxl_module
Date:   Thu, 21 Jan 2021 08:49:47 +0100
Message-Id: <20210121074959.313333-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121074959.313333-1-hch@lst.de>
References: <20210121074959.313333-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The static inline get_cxl_module function is entirely unused,
remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-cxl.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index 8c739c94ed28d6..53172862d23bd3 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -150,25 +150,3 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 	return 0;
 }
 EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
-
-#if IS_MODULE(CONFIG_CXL)
-static inline int get_cxl_module(void)
-{
-	struct module *cxl_module;
-
-	mutex_lock(&module_mutex);
-
-	cxl_module = find_module("cxl");
-	if (cxl_module)
-		__module_get(cxl_module);
-
-	mutex_unlock(&module_mutex);
-
-	if (!cxl_module)
-		return -ENODEV;
-
-	return 0;
-}
-#else
-static inline int get_cxl_module(void) { return 0; }
-#endif
-- 
2.29.2

