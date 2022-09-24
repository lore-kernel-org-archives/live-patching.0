Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3504C6FA83
	for <live-patching@archiver.kernel.org>; Sat, 24 Sep 2022 12:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiIXMXB (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Sat, 24 Sep 2022 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiIXMW5 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Sat, 24 Sep 2022 08:22:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A1E171E;
        Sat, 24 Sep 2022 05:22:56 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZSjZ6ppxzlWhP;
        Sat, 24 Sep 2022 20:18:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 20:22:54 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 20:22:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v6 08/11] livepatch: Use kallsyms_on_each_match_symbol() to improve performance
Date:   Sat, 24 Sep 2022 20:20:48 +0800
Message-ID: <20220924122051.362-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220924122051.362-1-thunder.leizhen@huawei.com>
References: <20220924122051.362-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Based on the test results of kallsyms_on_each_match_symbol() and
kallsyms_on_each_symbol(), the average performance can be improved by 20
to 30 times.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/livepatch/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 42f7e716d56bf72..31b57ccf908017e 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -153,6 +153,24 @@ static int klp_find_callback(void *data, const char *name,
 	return 0;
 }
 
+static int klp_match_callback(void *data, unsigned long addr)
+{
+	struct klp_find_arg *args = data;
+
+	args->addr = addr;
+	args->count++;
+
+	/*
+	 * Finish the search when the symbol is found for the desired position
+	 * or the position is not defined for a non-unique symbol.
+	 */
+	if ((args->pos && (args->count == args->pos)) ||
+	    (!args->pos && (args->count > 1)))
+		return 1;
+
+	return 0;
+}
+
 static int klp_find_object_symbol(const char *objname, const char *name,
 				  unsigned long sympos, unsigned long *addr)
 {
@@ -167,7 +185,7 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 	if (objname)
 		module_kallsyms_on_each_symbol(klp_find_callback, &args);
 	else
-		kallsyms_on_each_symbol(klp_find_callback, &args);
+		kallsyms_on_each_match_symbol(klp_match_callback, name, &args);
 
 	/*
 	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
-- 
2.25.1

