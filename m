Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E66355048
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267238; cv=none; b=pUWv7iqZ1W0xOAwTp31f4o+w9EJheuvgcXbD7kcTeMfsNW78ykLnI4QCAW57H5Q392wU8fs4mUABRObRYKkXZ7kbD4NjE7KG8oGSF2cDlevLtlo43ChU/pXXpgdR3E7EuE8bhdcs2uJFFMYG/2/4SVsE4nkwcMOo4VAgJFAoYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267238; c=relaxed/simple;
	bh=RmDSUoc9BEpdrK1BR3ucHvr4duLFOKVBZ31e7MD1Pzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R81/0oRYaS+u977TYkEGUbthWhsQV2shAXEMNpXPjTEp+EaE7pihZ0GCggD52glx0dTf3cfDReREDmF2ufXayCvyVZbViY8g4PNum54YYeiQ0Rbp+N6smXFIDfal54pcimbjko76aHVN3NS3Hil6RSVQLjTlTrzu3cCGS34l9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDc14cDA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDc14cDA"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so610340a91.2
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267236; x=1786872036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+cULMGZW2xz0RltQzFxLNbefMP5shktdMef8+CdSbE=;
        b=MDc14cDA2fAkS02N8rhMrSQ47JHRDbT69JmH4Er7+o8xB9Ue9aZzOw/pVsFNriMNUS
         agr3wG2H2FPK79ynqBstJjVrBlCQF3zxyYQRrR06A0VHbya+4b+u3zdGki3VpmWcg3OC
         DFDMF3iAQ46t5FgUsiTmOgvFfgeTkrDeL12azDEvo/V+bdOqgDj8i3/SLgCALVmSQMWJ
         JCH6vcKqAIkjplX0p8F/vaEfrhynl2wMGpj2elt+Qtkg2p/Aw1JQTX2aYXTTx16hZdur
         jM6Zixwr2OUqAaWeUvC5X+VbM2hUKzGpoD3k1wV1x2mexqmp4VxfY2MWZkWT3NOE+85V
         IPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267236; x=1786872036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z+cULMGZW2xz0RltQzFxLNbefMP5shktdMef8+CdSbE=;
        b=OiiSNXktrWZYjWRqbvGXxTz98bJNubFuvPe8QtBwjo4UuMzi7Vwm300LOeMnaRcKZ8
         djE/bdGvTKzNnnnH8beQV8Cs78kRmkCMdCTLNjBRk83vWxiGp3WG/Fr+kAjcNW5IXNGV
         Ggw0OFvK+1AfjhpurQMksucEcrzKuOPDyk+G+9p6/Ipj+ZM7y4+q2ze+LVZKn/SnRW8x
         mHY9yDMoK2znX19K4joloMiaLIwFhf8wDE3W8qMCmEF3rmOr5KausvOkxixyZ0M5xXkx
         70UbNz0E0jgFkdQQaC+pSwVGLxOVe8lIQyOmQ7gh2/+v2KwLHFQXy0bzR5G3S0J+T8xK
         2ZsA==
X-Gm-Message-State: AOJu0Yxd0pvYc6aU4r8Uvo5VQJ0v7OksOxEw90cO20SAOSWJYE9LoPRw
	XQbY3AOQLNmWMTqvFHvWLLo570GO5SM/5unlwYbuqzKERYVV1JBYMvMa
X-Gm-Gg: AR+sD13Y/bazCfU/3E/02kK3i0gd/uBX2RpZabw+hPMKAGXpN2UjDCt4oYpZDLQwdUw
	1SpgO54R86V65B3r2ys/c3CKF4ycE/NmdCRzCEe1UfP9alJvpuS77+m9TGK2iErz7CO+0w6Obgn
	cHe9IjvYMmC2COxndfPwvIi01VY5kkk0DUwKqUlwRAqxAn/b95E/EpMZdshwjqYimWBBbL5cViH
	4T9eLRK0yXCEbxZOYmk+BE4Zm0jaQHOdNCRo/kMsTO7yeh9XlORR+y2aeayf6fVt33oZt6T5YLS
	PBNkMaWnWeV6nOjzYIUb6oETIgE82xR+6Lxeu0CAUOtIXrndwLM1j1VU8SQnseEvic87SqMTaZ8
	r5OE0xVBMAVpoNi/QaxH/HB4jv7U5viYWwEJIX4dAkebbLYe6/5Pu3FvLBCP7vfIXW2ARDfE4I+
	QaRoMNQwwWcWQU+MmL4yi1ISG3sfPGdf1Z+NvYQjvBSRr79QrSs7sUIeWE/eceRHO2j5Qz4UMZj
	V35NJGW4pwiJdDjXI0HbRSvfqgcInLP9js7b0G9owibpTjfRngdgGoUgg==
X-Received: by 2002:a17:90a:dfd0:b0:38e:5ab7:ce9b with SMTP id 98e67ed59e1d1-3909d928d54mr22762999a91.21.1786267236170;
        Sun, 09 Aug 2026 02:20:36 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 7/9] selftests: livepatch: Add provides/obsoletes test scenarios
Date: Sun,  9 Aug 2026 17:19:51 +0800
Message-ID: <20260809091954.22930-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260809091954.22930-1-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
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
 .../livepatch/test-provides-obsoletes.sh      | 195 ++++++++++++++++++
 .../test_modules/test_klp_atomic_replace.c    |  22 +-
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +-
 .../test_modules/test_klp_livepatch.c         |   9 +
 .../livepatch/test_modules/test_klp_state.c   |   5 +-
 .../livepatch/test_modules/test_klp_state2.c  |   5 +-
 7 files changed, 226 insertions(+), 25 deletions(-)
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
index 000000000000..c740d463f556
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -0,0 +1,195 @@
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
+mods=($SYSFS_KLP_DIR/*)
+nmods=${#mods[@]}
+if [[ "$nmods" -ne 1 ]]; then
+	die "Expecting one module listed, found $nmods"
+fi
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
+mods=($SYSFS_KLP_DIR/*)
+nmods=${#mods[@]}
+if [[ "$nmods" -ne 1 ]]; then
+	die "Expecting one module listed, found $nmods"
+fi
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
+mods=($SYSFS_KLP_DIR/*)
+nmods=${#mods[@]}
+if [[ "$nmods" -ne 1 ]]; then
+	die "Expecting one module listed, found $nmods"
+fi
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
+mods=($SYSFS_KLP_DIR/*)
+nmods=${#mods[@]}
+if [[ "$nmods" -ne 2 ]]; then
+	die "Expecting two modules listed, found $nmods"
+fi
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

