Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808436F419
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737458; cv=none; b=Ez7Ct7XYkYrTivYzeQ9fpkqurCPxDXrht0aYyGns7HThE1oTBsk+8V/W20YuzmikfR/djWxsrPHgOUDZLZPodRyTKiUAw9vT5EWev811EPLKGOmjxhTZ8w4GIki2SWMvCsvob2qVdQ7NMLVlMggs6o4k8bRrfnLl+kIFvLEgXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737458; c=relaxed/simple;
	bh=u67CwaogEto7Q8FTxNfbgzPFJGFz3n2Da8llLAXjyZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBRTKVLakAQwIUhGUYoiBdYKtf/v7dHvnEYtPEOqSPwMq98k+jAw5hjucElCYF9AwrROzWzS9tlNFSHpsWnosUeVCWJrwaifK6FZKac9Qegsmn+mk6rr7Dz85ZFR5Pt9KPvu/9z7Cs+Cr1f2NinYIBBa8dzOkIxImU+jeqTBT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAPq8Edh; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAPq8Edh"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so2655522a91.2
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737456; x=1791342256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLnx8PTGXH0BdCGM6WbYmUvnd58GIqLEd9arALQbc6k=;
        b=HAPq8EdhOzhzRlfDE4YyA6fSUVi39rhyT5lZKQX4wRtHMsFdc10UCQSBH9xBrUvlRN
         Y8jRNNN3VswV9Kyo7BvNauNs1yWoRKxwHFeHioxa15JFVRVW4MMPYHD+dEaD8XUe9WQq
         1ghOAg3EKRpfzyfFECIjQys64rTR2GCx+Zu6nyrjF9JONEQFfUGIoeByMbYhTINfHusQ
         Whvd+Lttsm7RW1UO6P+Yiz9CRSjR7baYdFV0tZ+ESyR1wM42lHBJNZ11E7IPKr5uQGPg
         J4WuLyGetVh4CIO3/A+v7KAr0n2c6h3rGeE3/0yJmwSKUDCjmfVv/d7OsI0sBUJLiILZ
         +CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737456; x=1791342256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLnx8PTGXH0BdCGM6WbYmUvnd58GIqLEd9arALQbc6k=;
        b=uRNQ21d17uY3EVWqOKJGZaPzL6h36CjNox3hejbYMHxwyjsMmvB+7/lsnbzSnW5KQB
         x+6nNvRWb268B7p9AEzZ91D4f+hWGzTBNJMtKWfjBypkMikm6Bn4jzsJ97rfUcZKR5aW
         GL0Cb9RVVcrBsyklV27slag/MtaocdhPMunEKaC1F3hWVYRnYQdpJY0Bapx5DMeAaAen
         r3wLz4ZIUdeLewdbxjVeB0fGyeyhaXuUyD0mK96m0XLIgaC/QXLjqhz9CpGdV8TFILK/
         iZ1mJFfz7SgN3SH8yw0UwcHXGpjjgHAeLtO6zn+beYvVWO2ul0zw4eZoRIq4sQakB0U+
         XwqQ==
X-Gm-Message-State: AFq9FYJCrMT+bBAyKI2TmAUXqv2YJtg4JTlAdge5nmQ4guWgphrUREeE
	Jq6eEaiXw4T93EcLtOOC1XyqDtocTfMUbcP5qhFBB5k78x5kUTUy9gJdoJh+fQ==
X-Gm-Gg: AYBFou1JseFqee8sxU+JPudGmNpELy9IzG1xK2Z42oTkprUF6Q0UvyEwiO8rIfVHpNo
	I+SSaATBtl4MRgFc15XVIMFdAP4UJwUw9GFQADvfzCHDJ5m3k9PtXaa+qPTWjHv/oZM5bdK52Or
	Of0j9k9jAlW94s57OfRBlYQMz7p6MQp8RScXBEdcSKmF4fqlzvkXH2qG8j/A3GlMzjEDXSxsVzn
	OFkxJb6mfxhdRmsbnHAkzicTHJ24tmti3yQ3qSNPUAU70DBiL0NLRMm+MVlo4NF9lBxnN7wTTQ5
	YQRWzAQD6gnL3JpFmXByb/cJp2FNA0UFRJJhxDyypBKMRX06AEi7SfU1/lDb2cqnHC7yzzrHIRf
	7TUFIJMgOI5RnZajFVXPvRInXFK32tDjqZZHaxCE+AudWGXhyrYyNAESKOSmqdheJCtNyeLvTnV
	ighsYUOkYS8qIAtC/SwDhElENEZ9wE9eCB4j187sylKncO6/E05BErvJk2qPuOfVWWLTni7AflI
	cp/LhW1Qt81QcUOx7JqSCQOn/xB9vhBw0eElNbCbWoDnbDXfybV3quPVEWJAD+brCGsqQ==
X-Received: by 2002:a17:90b:2885:b0:3a4:c52e:8126 with SMTP id 98e67ed59e1d1-3a4d1b17cc6mr39560a91.40.1790737455922;
        Tue, 29 Sep 2026 20:04:15 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.04.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:04:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 7/9] selftests/livepatch: Add provides/obsoletes test scenarios
Date: Wed, 30 Sep 2026 11:03:21 +0800
Message-ID: <20260930030323.14396-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930030323.14396-1-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the legacy "replace" field has been replaced by the
provides/obsoletes mechanism, add test scenarios to verify the new
behavior.

The test modules gain provides/obsoletes module parameters, and
test-provides-obsoletes.sh covers the new replace semantics: provides=0
replacement, same-provides replacement, obsoletes-based replacement
and coexistence of different provides ids.

These tests are skipped on kernels that still support the legacy
"replace" attribute.

Assisted-by: LLM
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../livepatch/test-provides-obsoletes.sh      | 221 ++++++++++++++++++
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +-
 .../test_modules/test_klp_cmdline_lp.c        |  11 +-
 .../test_modules/test_klp_meminfo_lp.c        |  22 +-
 .../livepatch/test_modules/test_klp_state.c   |   5 +-
 .../livepatch/test_modules/test_klp_state2.c  |   5 +-
 7 files changed, 253 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215..38f98594d883 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	test-ftrace.sh \
 	test-sysfs.sh \
 	test-syscall.sh \
-	test-kprobe.sh
+	test-kprobe.sh \
+	test-provides-obsoletes.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
new file mode 100755
index 000000000000..a1c0ebb9ed44
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -0,0 +1,221 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Yafang Shao <laoar.shao@gmail.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_MEMINFO=test_klp_meminfo_lp
+MOD_CMDLINE=test_klp_cmdline_lp
+
+setup_config
+detect_provides_attr
+
+# The provides/obsoletes based tests only run on kernels that no longer
+# support the legacy "replace" attribute.
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	skip_exit "kernel still supports the legacy replace attribute"
+fi
+
+
+# - load a livepatch with provides=0 (cmdline), then another with
+#   provides=0 (meminfo). The second replaces the first (same provides).
+# - unload the remaining livepatch
+
+start_test "provides 0 replaces provides 0"
+
+load_lp $MOD_CMDLINE provides=0
+load_lp $MOD_MEMINFO provides=0
+
+check_sysfs_value "$MOD_MEMINFO" "enabled" "1"
+
+disable_lp $MOD_MEMINFO
+unload_lp $MOD_MEMINFO
+unload_lp $MOD_CMDLINE
+
+check_result "% insmod test_modules/$MOD_CMDLINE.ko provides=0
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+% insmod test_modules/$MOD_MEMINFO.ko provides=0
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
+livepatch: '$MOD_MEMINFO': initializing unpatching transition
+livepatch: '$MOD_MEMINFO': starting unpatching transition
+livepatch: '$MOD_MEMINFO': completing unpatching transition
+livepatch: '$MOD_MEMINFO': unpatching complete
+% rmmod $MOD_MEMINFO
+% rmmod $MOD_CMDLINE"
+
+
+# - load a livepatch with provides=1 (cmdline), then another with
+#   provides=1 (meminfo). The second replaces the first (same provides).
+# - unload the remaining livepatch
+
+start_test "same provides replaces"
+
+load_lp $MOD_CMDLINE provides=1
+load_lp $MOD_MEMINFO provides=1
+
+check_sysfs_value "$MOD_MEMINFO" "enabled" "1"
+
+disable_lp $MOD_MEMINFO
+unload_lp $MOD_MEMINFO
+unload_lp $MOD_CMDLINE
+
+check_result "% insmod test_modules/$MOD_CMDLINE.ko provides=1
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
+livepatch: '$MOD_MEMINFO': initializing unpatching transition
+livepatch: '$MOD_MEMINFO': starting unpatching transition
+livepatch: '$MOD_MEMINFO': completing unpatching transition
+livepatch: '$MOD_MEMINFO': unpatching complete
+% rmmod $MOD_MEMINFO
+% rmmod $MOD_CMDLINE"
+
+
+# - load a livepatch with provides=1 (cmdline), then another with
+#   provides=2 and obsoletes=[1] (meminfo). The second replaces the
+#   first (obsoletes contains the first patch's provides id).
+# - verify the provides/obsoletes sysfs values
+# - unload the remaining livepatch
+
+start_test "obsoletes replaces"
+
+load_lp $MOD_CMDLINE provides=1
+load_lp $MOD_MEMINFO provides=2 obsoletes=1
+
+check_sysfs_value "$MOD_MEMINFO" "provides" "2"
+check_sysfs_value "$MOD_MEMINFO" "obsoletes" "1"
+
+disable_lp $MOD_MEMINFO
+unload_lp $MOD_MEMINFO
+unload_lp $MOD_CMDLINE
+
+check_result "% insmod test_modules/$MOD_CMDLINE.ko provides=1
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+% insmod test_modules/$MOD_MEMINFO.ko provides=2 obsoletes=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
+livepatch: '$MOD_MEMINFO': initializing unpatching transition
+livepatch: '$MOD_MEMINFO': starting unpatching transition
+livepatch: '$MOD_MEMINFO': completing unpatching transition
+livepatch: '$MOD_MEMINFO': unpatching complete
+% rmmod $MOD_MEMINFO
+% rmmod $MOD_CMDLINE"
+
+
+# - load two livepatches with different provides ids that modify
+#   different functions and verify that they coexist
+# - in particular, verify that provides=0 does NOT replace a patch
+#   with a different provides id
+# - unload both livepatches
+
+start_test "provides 0 coexists with provides 1"
+
+load_lp $MOD_CMDLINE provides=0
+load_lp $MOD_MEMINFO provides=1
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+disable_lp $MOD_CMDLINE
+unload_lp $MOD_CMDLINE
+disable_lp $MOD_MEMINFO
+unload_lp $MOD_MEMINFO
+
+check_result "% insmod test_modules/$MOD_CMDLINE.ko provides=0
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+$MOD_CMDLINE: this has been live patched
+$MOD_MEMINFO: this has been live patched
+% echo 0 > $SYSFS_KLP_DIR/$MOD_CMDLINE/enabled
+livepatch: '$MOD_CMDLINE': initializing unpatching transition
+livepatch: '$MOD_CMDLINE': starting unpatching transition
+livepatch: '$MOD_CMDLINE': completing unpatching transition
+livepatch: '$MOD_CMDLINE': unpatching complete
+% rmmod $MOD_CMDLINE
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
+livepatch: '$MOD_MEMINFO': initializing unpatching transition
+livepatch: '$MOD_MEMINFO': starting unpatching transition
+livepatch: '$MOD_MEMINFO': completing unpatching transition
+livepatch: '$MOD_MEMINFO': unpatching complete
+% rmmod $MOD_MEMINFO"
+
+
+# - load a livepatch with provides=2 and obsoletes=[1] (cmdline),
+#   then another with provides=1 (meminfo). Although the second patch
+#   does not list provides=2 in its own obsoletes list, it still
+#   replaces the first one, because the obsoletes relationship is
+#   symmetric: the first patch's obsoletes list contains the second
+#   patch's provides id.
+# - verify the provides sysfs value of the replacing patch
+# - unload the remaining livepatch
+#
+#   MOD_MEMINFO(provides=2, obsoletes=[1])  -- loaded first
+#   MOD_CMDLINE(provides=1)              -- loaded second, replaces above
+
+start_test "symmetric obsoletes replaces"
+
+load_lp $MOD_MEMINFO provides=2 obsoletes=1
+load_lp $MOD_CMDLINE provides=1
+
+check_sysfs_value "$MOD_CMDLINE" "provides" "1"
+
+disable_lp $MOD_CMDLINE
+unload_lp $MOD_CMDLINE
+unload_lp $MOD_MEMINFO
+
+check_result "% insmod test_modules/$MOD_MEMINFO.ko provides=2 obsoletes=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+% insmod test_modules/$MOD_CMDLINE.ko provides=1
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_CMDLINE/enabled
+livepatch: '$MOD_CMDLINE': initializing unpatching transition
+livepatch: '$MOD_CMDLINE': starting unpatching transition
+livepatch: '$MOD_CMDLINE': completing unpatching transition
+livepatch: '$MOD_CMDLINE': unpatching complete
+% rmmod $MOD_CMDLINE
+% rmmod $MOD_MEMINFO"
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 6c46ce575f5c..93789470fe18 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -8,10 +8,9 @@
 #include <linux/livepatch.h>
 
 #ifdef CONFIG_KLP_HAS_PROVIDES
-/*
- * TODO: Add provides/obsoletes module parameters for the
- * provides/obsoletes based tests (to be added later).
- */
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
 #else
 static int replace;
 module_param(replace, int, 0644);
@@ -87,10 +86,7 @@ static struct klp_patch patch = {
 static int test_klp_callbacks_demo2_init(void)
 {
 #ifdef CONFIG_KLP_HAS_PROVIDES
-	/*
-	 * TODO: Set provides/obsoletes from the module parameters
-	 * for the provides/obsoletes based tests (to be added later).
-	 */
+	patch.provides = provides;
 #else
 	patch.replace = replace;
 #endif
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
index 88c6aed925fb..8a93f005a383 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
@@ -6,8 +6,14 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
-
 #include <linux/seq_file.h>
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+#endif
+
 static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
@@ -36,6 +42,9 @@ static struct klp_patch patch = {
 
 static int test_klp_cmdline_lp_init(void)
 {
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	patch.provides = provides;
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
index 0c434a27672d..a3b433385148 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
@@ -8,10 +8,15 @@
 #include <linux/livepatch.h>
 
 #ifdef CONFIG_KLP_HAS_PROVIDES
-/*
- * TODO: Add provides/obsoletes module parameters for the
- * provides/obsoletes based tests (to be added later).
- */
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0444);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
 #else
 static int replace;
 module_param(replace, int, 0644);
@@ -51,10 +56,11 @@ static struct klp_patch patch = {
 static int test_klp_meminfo_lp_init(void)
 {
 #ifdef CONFIG_KLP_HAS_PROVIDES
-	/*
-	 * TODO: Set provides/obsoletes from the module parameters
-	 * for the provides/obsoletes based tests (to be added later).
-	 */
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
 #else
 	patch.replace = replace;
 #endif
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 4d419a58cf65..f53eead9d55b 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -143,10 +143,7 @@ static struct klp_patch patch = {
 	.objs = objs,
 	.states = states,
 #ifdef CONFIG_KLP_HAS_PROVIDES
-	/*
-	 * TODO: Add provides/obsoletes module parameters for the
-	 * provides/obsoletes based tests (to be added later).
-	 */
+	/* provides=0 by default, replaces all provides=0 patches */
 #else
 	.replace = true,
 #endif
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 4f70f0619967..5f07fe1be2b9 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -172,10 +172,7 @@ static struct klp_patch patch = {
 	.objs = objs,
 	.states = states,
 #ifdef CONFIG_KLP_HAS_PROVIDES
-	/*
-	 * TODO: Add provides/obsoletes module parameters for the
-	 * provides/obsoletes based tests (to be added later).
-	 */
+	/* provides=0 by default, replaces all provides=0 patches */
 #else
 	.replace = true,
 #endif
-- 
2.52.0

