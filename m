Return-Path: <SRS0=TObA=DA=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12DFC2D0A8
	for <live-patching@archiver.kernel.org>; Wed, 23 Sep 2020 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D94206D9
	for <live-patching@archiver.kernel.org>; Wed, 23 Sep 2020 17:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIWRlV (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:41:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:14096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgIWRlV (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 23 Sep 2020 13:41:21 -0400
IronPort-SDR: qowO+FkTDejT+9Ubivziaf2Jmx6aEAMfgUNkzWAUA7FWjEi/68qbBWm/tqFXIEhC0hgb/qnPGC
 5Fs9QhgsnKJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148629805"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="148629805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:41:20 -0700
IronPort-SDR: GZk1FRtVMnmSVB61ksssWSFNFU+xjc7kddUpaUMFeMzOTmuJTaNnLCO4Kbb4lhQ2TY/3WZNv/0
 FyFrdXKqoIKw==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="309993326"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.14.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:41:15 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        live-patching@vger.kernel.org
Subject: [PATCH v5 10/10] livepatch: only match unique symbols when using fgkaslr
Date:   Wed, 23 Sep 2020 10:39:04 -0700
Message-Id: <20200923173905.11219-11-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200923173905.11219-1-kristen@linux.intel.com>
References: <20200923173905.11219-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

If any type of function granular randomization is enabled, the sympos
algorithm will fail, as it will be impossible to resolve symbols when
there are duplicates using the previous symbol position.

Override the value of sympos to always be zero if fgkaslr is enabled for
either the core kernel or modules, forcing the algorithm
to require that only unique symbols are allowed to be patched.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 kernel/livepatch/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index f76fdb925532..da08e40f2da2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -170,6 +170,17 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 		kallsyms_on_each_symbol(klp_find_callback, &args);
 	mutex_unlock(&module_mutex);
 
+	/*
+	 * If any type of function granular randomization is enabled, it
+	 * will be impossible to resolve symbols when there are duplicates
+	 * using the previous symbol position (i.e. sympos != 0). Override
+	 * the value of sympos to always be zero in this case. This will
+	 * force the algorithm to require that only unique symbols are
+	 * allowed to be patched.
+	 */
+	if (IS_ENABLED(CONFIG_FG_KASLR) || IS_ENABLED(CONFIG_MODULE_FG_KASLR))
+		sympos = 0;
+
 	/*
 	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
 	 * otherwise ensure the symbol position count matches sympos.
-- 
2.20.1

