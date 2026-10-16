Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA27389111
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129091; cv=none; b=Xcgo1jYxUx3r1etlV0BC0YxzddmAXxmjOA9TkqIxX4n1no69LFvtficPBmsC5YJnvxf9pldKm20QoE5yw7hUn/cnkLwliMU9B8/VVORxtMU5LfjaIkwNusg7GaEZH1ImUMrX+SYcVtByxbz+D44pelwOaUUCro+QDf3/rzss1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129091; c=relaxed/simple;
	bh=rgSr/Guj4GUF8wvvCOHx1p4og8x4bjpNWQ//b+9Zzu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHwd9rZ5Fgl53SS6nmP7TMfPabBvnteXygwVENmDyw/3ZLfjepRPrQ4kNJ1ifZrCd0iOwVqAu/OAKOI+r7eC1usJSwBCWbL5HDJ9OrJMdnghhciHCBnZlwX/A84aFcHYBQFYlqZeIaY0d0bcQM1Yr/HMFhF2OdWjNJdHZ4ECaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwoJuhAW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwoJuhAW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e901e114fdso26332525ad.2
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2026 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129089; x=1792733889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpRpBEaZCuebRAlGLna05hDbPxBUbWw7JtxZRFzQOJA=;
        b=VwoJuhAW9Gz6s0NrjD4c6BYkzzw8NSR5oP2RcX2TrVxDfGX5UQWYmsg2Z280DfRalc
         jgnW7qHH/YLRxqx1cPDeZPPimNj+8qhywJkZ7yGQgQIikXlpvTNFDmZmIofywY533nTF
         mNCbBr/0rQj3StJ1p7lHO5mtKaRpTD3S6bPk7HyIH9LsWZ+fVIP1cgMKeJ0w/zHEQWER
         R+ZdNKYvWMZ3aigZwZEjNrg8RVMoC64qFllgVlnbog1keaG9n4EnbAX8fswv4kxoZdFk
         eEK16/O3Ru/NClsBs+xHEki8Ra9+cRPk9xFA2XynA1lIqghQqm+nouqsWwbsjqDVm3s/
         dfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129089; x=1792733889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpRpBEaZCuebRAlGLna05hDbPxBUbWw7JtxZRFzQOJA=;
        b=jGtXV97PyVmv7gwPtyLB7liXFPaZ3gxfCX3BD3d5qNzxQMSLObh/qIpUazU/J9SfO0
         B3El5yzkASzdrmA7k8LMdIDsrL04GLzQq32mdqQjECxH0yatdDaO4K9Dgsh71fuVW1Lk
         +yQIBFarlZdChtfiH4FmMw+JIFIrqM7MArduRGcPMfue3CkP8lkQm4sewDtm4W+bOY8E
         8Wr7EWrekmHH/po0UgRh0J61SOmduERd1H/qOXc07w3bfA6lzfUpTGV2dajPZVYxOHVR
         zaXkSc9nzdsr8xuSF+sOQ0dyNQSX9UqIdyVQ2ttNKHbzsAAMUM/22VNcoSSe9dp7VGgY
         nK0Q==
X-Gm-Message-State: AFq9FYI6F1OW2jSj/Ot4uiivJjP1eVvkPhnGU1BbcNTTb/JeA6Qqwm3G
	C694ypBcVczPNT9fOByj6pIaqjUHydxytfRfgAkmZ49fTwkSB3auBXqU
X-Gm-Gg: AYBFou21t249qAnYNBxLeqx1c6ebBUeoiv3KOtAMYB6/jM0h7uKqG28joU6tGPOm8Px
	bxgI8icShVBemyAtLZumPjbwM6QfIoX79jFhDWJIl7qAG7yYduuCIXMaJqTTNVOCNpz0kmKdPHe
	x6L2vyjiuym/GYW18EK97W0nsKmC0gVfmB6faxuVlekReEi512vEzvgoNJUC/Bu4Bpv8ror62OE
	4jm/j9xd7ASWyDlpPpNYfyZI8AEiMYT1u2Lt2ao6fuK6/D7oDkWng6tQ9sYm8Mk+qHkdpgHX1Km
	UTOLN3OqfuXs0Dj2ssSMYecKRiFM1ZHtIgU2SbLP8zFkKBFMzoCb/vxZejpTk7jEDZJxdMT9O1M
	3lXlUAdOnpsBoFVRq8CQCBQw6qnCDcCwc7Bn0L8/r/dy55/vljG2glL8UuE9b75hQ2S1PmQnogD
	/DOe+8YlvebPW4pAzKrkEZjLiP086P3goqQeBkzDe0GYMwmkqJCb82bQwREgoALkyrymI0jSk/P
	VM2DymlK5Pn0yekZaQ0K/mCF8T/mVsD66UZj4TjOtRbgtbLSFeuFrHPspSxLYIqT4Ei79rWUKhP
	utg=
X-Received: by 2002:a17:903:46c8:b0:2dd:c100:b2c8 with SMTP id d9443c01a7336-2e842ce8896mr196536775ad.51.1792129088911;
        Thu, 15 Oct 2026 22:38:08 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:5700:24f:f979:e84b:46de:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm4724115ad.17.2026.10.15.22.38.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 22:38:07 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 7/9] selftests/livepatch: Add provides/obsoletes test scenarios
Date: Fri, 16 Oct 2026 13:37:06 +0800
Message-ID: <20261016053708.47089-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016053708.47089-1-laoar.shao@gmail.com>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
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
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../livepatch/test-provides-obsoletes.sh      | 229 ++++++++++++++++++
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +-
 .../test_modules/test_klp_cmdline_lp.c        |  11 +-
 .../test_modules/test_klp_meminfo_lp.c        |  22 +-
 .../livepatch/test_modules/test_klp_state.c   |   5 +-
 .../livepatch/test_modules/test_klp_state2.c  |   5 +-
 7 files changed, 261 insertions(+), 26 deletions(-)
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
index 000000000000..78a644f6ec56
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -0,0 +1,229 @@
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
+# - load a livepatch with provides=2 and obsoletes=[1] (meminfo),
+#   then another with provides=1 (cmdline). The second patch does not
+#   list provides=2 in its own obsoletes list, so it does not replace
+#   the first one: the obsoletes relationship is not symmetric and
+#   both livepatches coexist.
+# - verify that both livepatches remain active
+# - unload both livepatches
+#
+#   MOD_MEMINFO(provides=2, obsoletes=[1])  -- loaded first
+#   MOD_CMDLINE(provides=1)                 -- loaded second, coexists
+
+start_test "obsoletes is not symmetric"
+
+load_lp $MOD_MEMINFO provides=2 obsoletes=1
+load_lp $MOD_CMDLINE provides=1
+
+grep 'live patched' /proc/cmdline > /dev/kmsg
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+disable_lp $MOD_CMDLINE
+unload_lp $MOD_CMDLINE
+disable_lp $MOD_MEMINFO
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

