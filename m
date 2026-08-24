Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549A2374A1B
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542086; cv=none; b=PnKhVDxLBS5ciquWFxwQtCyBuaDIzCLykOTxh4QN5BA+toiJmgN+v7AyHRfINvx1b/fDUvN053cbCOO2VhL2gA2AiksmmcNAUmGNKHUXneQ2qbEF7OUGH51bZuTLr5ENnL9atem+hMpNq7c4F92Yi1GregGH02h5jJWEZIdCcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542086; c=relaxed/simple;
	bh=kl0zUecAr94bgCo37/G2QYusCpUPCUTbxN5a2j+t2qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtIG5JiwlXmHaS1JtaD5AooD7XOt2YxnAvyyJP+ryaTCE5KaubxSBxflvGWNLrwjoIm1PrGNImjaPxQ8ot0o6Cj+lo4PL6IWqB/2ns1T3VFR/vHJoy5A/okr1Tn4MCdiIQqALVcPgbr4iTgiZQjXTglEm4mEzm8k6l6TxA6N+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R60Nme4u; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R60Nme4u"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2260562a12.0
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542084; x=1788146884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68t19fuRmALkACdOuuQ0dowbBW+GelOm4AkbOmUpWHo=;
        b=R60Nme4ulGKzV6LpzzA5sDzk8AqFVkG8p1DvTL+c/RtbIfSRBLvXQ/9DhNAid15J1W
         dweFi5fgWNChxCvkmn5Ff7kC4NiuZZYUkuQWIWZDuehJ9aJxb0GCtqJICHENhy1ljuzJ
         C2EFRl90D+GdDPVaNUxHO6CBL70i0W12afqLMtQlY3f7p/UjBWgTE4sXznjGXvd+AAwO
         WX7M6yD2DZdppFCp4Xxj1S5ppoFXb+wWNfTijt97HKxMu2KmtqDCD/b+93x5m8lHxtm8
         pAVF0FnE0i3t9eFqWkxJZfBc+bcjrpLbV+L7cEucmXZbPVKpPk2UjOg7IwYaNz+vmRv7
         WICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542084; x=1788146884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=68t19fuRmALkACdOuuQ0dowbBW+GelOm4AkbOmUpWHo=;
        b=PPggDqv1YbR3275COUq+DQ1r5OikIXPqD5yPMkzMexI1dvTRJFfY7XNvoEFRmuyLj3
         yT1iwJ5mB3CrHDdUUXbfEItU4AMLrI2uIm85mPKfmvLo1vPyN4AUQGmsgRCZLi9QMdEu
         qeVTrPo+fhqCX4sAjrxaSYAm7FequreCSKqQYyJyjlZ4dimEvKofw3uXuP0xN3DEKcA0
         kk+AM4YW7hB1svWKHVOQ8v9LlYHhRZTHeYyYwdO/zgxHKC7sebKrUYhT6aGP93zxY1xA
         psbTfYPd7mCoNdPwFAH7C+ew/qgemc4eN1q7x/aZ6zfN249jxiHqToAaYHojun3bGVIg
         SHJQ==
X-Gm-Message-State: AFuF++l+Q2CcdzFXJtTBAi3PZtxFPUa2LvMWG028e0kozsRVorGatxjp
	Hbih3w7xtOhhhkP3FyTl61mk5/GRky/1aq20xK8wonY6nOJmZRGwGp5e
X-Gm-Gg: AR+sD11vU7muLuvevndL0oNfL69SllKTENInaBb6wTaDCGW9T4cGxUPwfWHywuhxKoY
	wwMthl8NfYToN+6W1FWtnCJjhAy3MraP8XNhKxQnKnvYN6oNS3yAxfKn9mM++t49iISGcQSpCve
	ukh0TGpZWn5EPsJJtrFEeS3L6d+LUksfH0jbEQHliOkraA8nPVsClFsjJ75G3GYNt9NzJVYJpvo
	d6Fz9BtPrt7YMIeKf/B8oC5CIsNBgXWaMiynBqXaSzTiCnuIVCl2HOcNjvxV4T6/flHHDG5/L8Z
	tWUTJSVZgwqbif+ZxB4y/vqNd5rOf+2jh5QaxeIzuso+GBzhEZdOS5R+4Sic+FUBU/mbB+o998/
	dKF0rVUGwARGGuC9/oNDH0spXmH6uUs4DDIPjaNECdar/RqcP+fRXLllPp6RkiqA+VtSi3sm/Xa
	FKfm2jA4C9GjvJ4cSM5wtlxHVJPPYrrL35CBes8PoVtRlElgR38TURoLeHR5Y2o6lGnXo7sS+U1
	FP6k77owlGFEOq2lbIwxIzq7gkZ5BD0OBkjoh26S0w=
X-Received: by 2002:a17:90a:e70f:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-395df3c6026mr29398728a91.14.1787542083521;
        Sun, 23 Aug 2026 20:28:03 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.28.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:28:03 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 6/8] selftests: livepatch: Add provides/obsoletes test scenarios
Date: Mon, 24 Aug 2026 11:27:30 +0800
Message-ID: <20260824032732.56686-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260824032732.56686-1-laoar.shao@gmail.com>
References: <20260824032732.56686-1-laoar.shao@gmail.com>
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

Fill in the #else branches of the test modules that were left as
TODO placeholders in the previous patch:

- test_klp_atomic_replace.c gains provides and obsoletes module
  parameters for the provides/obsoletes based tests.

- test_klp_callbacks_demo2.c gains a provides module parameter.

- test_klp_livepatch.c gains a provides module parameter so that it
  can be loaded with a specific provides id for coexistence tests.

- test_klp_state.c and test_klp_state2.c add a comment in the #else
  branch noting that provides=0 (the default) is equivalent to the
  previous .replace=true behavior.

Add test-provides.sh with four test scenarios:

1. provides=0 replaces provides=0: two livepatches with provides=0
   that modify different functions; the second replaces the first.

2. Same provides replaces: two livepatches with provides=1 that
   modify different functions; the second replaces the first.

3. Obsoletes replaces: a livepatch with provides=2 and obsoletes=[1]
   replaces a livepatch with provides=1. The provides/obsoletes sysfs
   values are verified.

4. provides=0 coexists with provides=1: two livepatches with
   different provides ids that modify different functions coexist,
   verifying that provides=0 does not replace a patch with a
   different provides id.

The provides/obsoletes based tests only run on kernels that no longer
support the legacy "replace" attribute.

Assisted-by: Comagic:DeepSeek-V4-Flash
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../livepatch/test-provides-obsoletes.sh      | 174 ++++++++++++++++++
 .../test_modules/test_klp_atomic_replace.c    |  22 ++-
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +-
 .../test_modules/test_klp_livepatch.c         |   9 +
 .../livepatch/test_modules/test_klp_state.c   |   5 +-
 .../livepatch/test_modules/test_klp_state2.c  |   5 +-
 7 files changed, 205 insertions(+), 25 deletions(-)
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
index 000000000000..2707457b9133
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -0,0 +1,174 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Yafang Shao <laoar.shao@gmail.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_ATOMIC=test_klp_atomic_replace
+MOD_LIVEPATCH=test_klp_livepatch
+
+setup_config
+
+detect_replace_attr
+
+# The provides/obsoletes based tests only run on kernels that no longer
+# support the legacy "replace" attribute.
+if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
+	echo "SKIP: kernel still supports the legacy replace attribute"
+	exit $ksft_skip
+fi
+
+
+# - load a livepatch with provides=0 (cmdline), then another with
+#   provides=0 (meminfo). The second replaces the first (same provides).
+# - unload the remaining livepatch
+
+start_test "provides 0 replaces provides 0"
+
+load_lp $MOD_LIVEPATCH provides=0
+load_lp $MOD_ATOMIC provides=0
+
+check_sysfs_value "$MOD_ATOMIC" "enabled" "1"
+
+disable_lp $MOD_ATOMIC
+unload_lp $MOD_ATOMIC
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko provides=0
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% insmod test_modules/$MOD_ATOMIC.ko provides=0
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_ATOMIC/enabled
+livepatch: '$MOD_ATOMIC': initializing unpatching transition
+livepatch: '$MOD_ATOMIC': starting unpatching transition
+livepatch: '$MOD_ATOMIC': completing unpatching transition
+livepatch: '$MOD_ATOMIC': unpatching complete
+% rmmod $MOD_ATOMIC
+% rmmod $MOD_LIVEPATCH"
+
+
+# - load a livepatch with provides=1 (cmdline), then another with
+#   provides=1 (meminfo). The second replaces the first (same provides).
+# - unload the remaining livepatch
+
+start_test "same provides replaces"
+
+load_lp $MOD_LIVEPATCH provides=1
+load_lp $MOD_ATOMIC provides=1
+
+check_sysfs_value "$MOD_ATOMIC" "enabled" "1"
+
+disable_lp $MOD_ATOMIC
+unload_lp $MOD_ATOMIC
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko provides=1
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% insmod test_modules/$MOD_ATOMIC.ko provides=1
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_ATOMIC/enabled
+livepatch: '$MOD_ATOMIC': initializing unpatching transition
+livepatch: '$MOD_ATOMIC': starting unpatching transition
+livepatch: '$MOD_ATOMIC': completing unpatching transition
+livepatch: '$MOD_ATOMIC': unpatching complete
+% rmmod $MOD_ATOMIC
+% rmmod $MOD_LIVEPATCH"
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
+load_lp $MOD_LIVEPATCH provides=1
+load_lp $MOD_ATOMIC provides=2 obsoletes=1
+
+check_sysfs_value "$MOD_ATOMIC" "provides" "2"
+check_sysfs_value "$MOD_ATOMIC" "obsoletes" "1"
+
+disable_lp $MOD_ATOMIC
+unload_lp $MOD_ATOMIC
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko provides=1
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% insmod test_modules/$MOD_ATOMIC.ko provides=2 obsoletes=1
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_ATOMIC/enabled
+livepatch: '$MOD_ATOMIC': initializing unpatching transition
+livepatch: '$MOD_ATOMIC': starting unpatching transition
+livepatch: '$MOD_ATOMIC': completing unpatching transition
+livepatch: '$MOD_ATOMIC': unpatching complete
+% rmmod $MOD_ATOMIC
+% rmmod $MOD_LIVEPATCH"
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
+load_lp $MOD_LIVEPATCH provides=0
+load_lp $MOD_ATOMIC provides=1
+
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+disable_lp $MOD_ATOMIC
+unload_lp $MOD_ATOMIC
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko provides=0
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% insmod test_modules/$MOD_ATOMIC.ko provides=1
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% echo 0 > /sys/kernel/livepatch/$MOD_ATOMIC/enabled
+livepatch: '$MOD_ATOMIC': initializing unpatching transition
+livepatch: '$MOD_ATOMIC': starting unpatching transition
+livepatch: '$MOD_ATOMIC': completing unpatching transition
+livepatch: '$MOD_ATOMIC': unpatching complete
+% rmmod $MOD_ATOMIC"
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
index 4b3ed17886e7..b0ed924eeeed 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
@@ -12,10 +12,15 @@ static int replace;
 module_param(replace, int, 0644);
 MODULE_PARM_DESC(replace, "replace (default=0)");
 #else
-/*
- * TODO: Add provides/obsoletes module parameters for the
- * provides/obsoletes based tests (to be added later).
- */
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0644);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
 #endif
 
 #include <linux/seq_file.h>
@@ -53,10 +58,11 @@ static int test_klp_atomic_replace_init(void)
 #ifdef KLP_HAS_REPLACE
 	patch.replace = replace;
 #else
-	/*
-	 * TODO: Set provides/obsoletes from the module parameters
-	 * for the provides/obsoletes based tests (to be added later).
-	 */
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
 #endif
 	return klp_enable_patch(&patch);
 }
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 135da6d4d882..a0e7b7d1e198 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -12,10 +12,9 @@ static int replace;
 module_param(replace, int, 0644);
 MODULE_PARM_DESC(replace, "replace (default=0)");
 #else
-/*
- * TODO: Add provides/obsoletes module parameters for the
- * provides/obsoletes based tests (to be added later).
- */
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
 #endif
 
 static const char *const module_state[] = {
@@ -89,10 +88,7 @@ static int test_klp_callbacks_demo2_init(void)
 #ifdef KLP_HAS_REPLACE
 	patch.replace = replace;
 #else
-	/*
-	 * TODO: Set provides/obsoletes from the module parameters
-	 * for the provides/obsoletes based tests (to be added later).
-	 */
+	patch.provides = provides;
 #endif
 	return klp_enable_patch(&patch);
 }
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
index aff08199de71..fa2bc6ec921d 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
@@ -7,6 +7,12 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifndef KLP_HAS_REPLACE
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+#endif
+
 #include <linux/seq_file.h>
 static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 {
@@ -36,6 +42,9 @@ static struct klp_patch patch = {
 
 static int test_klp_livepatch_init(void)
 {
+#ifndef KLP_HAS_REPLACE
+	patch.provides = provides;
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 3492472e5d07..313401a5506e 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -145,10 +145,7 @@ static struct klp_patch patch = {
 #ifdef KLP_HAS_REPLACE
 	.replace = true,
 #else
-/*
- * TODO: Add provides/obsoletes module parameters for the
- * provides/obsoletes based tests (to be added later).
- */
+	/* provides=0 by default, replaces all provides=0 patches */
 #endif
 };
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 8160b565a659..1afc2cabc39d 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -174,10 +174,7 @@ static struct klp_patch patch = {
 #ifdef KLP_HAS_REPLACE
 	.replace = true,
 #else
-/*
- * TODO: Add provides/obsoletes module parameters for the
- * provides/obsoletes based tests (to be added later).
- */
+	/* provides=0 by default, replaces all provides=0 patches */
 #endif
 };
 
-- 
2.52.0

