Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021839;
	b=rCSFEanNKCQ4VzTDz65ai5L2LzoGM0ffaJWGyeLE+QZAup8gIT2G5KZezadHrzTNTlts
	 z8eB21/hbfdCmu5dnPn6GbJal6baYl+tM3XITWr5SSnv3P2pNX2yo2E2SWL3ZC70UhmYZ
	 RB6ay6ZTt94+BvXaHoeeH1q1yrW2Q1GImszr6xv5Rb2awdTwYy2Iv68m8+XcVIOhs9INS
	 /P5n24Y6aEDZAuQenQhfbItOXv5hm3s0ZCrrFdHgq8vXEcv2EPMikhqrxNZUyAmQlD38z
	 eG1lnwGKukpMgZWU0SNrXn+HzlTh5gLkzH/gSPB3g5h+gViMOZXnhKv9jK6U9LMDfig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MEArrPy2C1lXPwHH/g6fRZ72r1oGwvn3o0x5jEkAZS8=;
	b=h0TrcK9QRtnaujPcFQZuJQz72wSESOYjdAtYJUr/5T8/YgtDiKntfwNwgmaIx02zI1ac
	 O7wLY1cxHMMjNkQwTnJbnVbUfOYWAW0xxWPU76Ib2oHFqFizGGLSKN+kWOiT9dp9bJYAW
	 dRFpO4YGHVb5UBNOGiwnrVLCFObskdqbQcF5O1tTHIRk89WbipMAqJJ8xp5SLSY8DqFMM
	 LcqTm3F0d1S/6ZV4A7vusXzamC1xDqolV0XhJ49XfDIempdNve3ns69gnMKMcNLmANgnc
	 RUTH8q6TUK8SPA5ES+pXmdrefjV3baId8gateJOgPFWowyjPz506yPSDiFLOC27632w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hb7DFZWK;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018D606A328
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7018D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hb7DFZWK
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso16231765ad.0
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021838; x=1793626638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MEArrPy2C1lXPwHH/g6fRZ72r1oGwvn3o0x5jEkAZS8=;
        b=Hb7DFZWKqMLK8oRV+meeKrbVYIUnEZszDVm2nEVcxrI/i9dnz/BGLnjHL9rCCPvA9u
         qM60cIRdCpIL0dHS3tTc9rgxKaAMUCy81fDtM4xEvpvXjqfCAtgi85qdFCslZrW2ks9i
         6NjBq8FITLZp3BwTbbLYOESuVIlTLTre9x7G0eoMsygxGoWlacQ4UoMOCvCF1SE7nWcb
         MuxTAKUoyVVKtzGRpij1NX+GsWBXS+p1VE3rQY+B/Kf4uznVdrIxtGm2yoAJ+uyOCUwL
         VMyxnQHIy3ZZxXy1Wn4CBbnw38nw2ntYRX/NtbhKnUgj5edKVGpGJh86/aUKSHtZ4Cb0
         dXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021838; x=1793626638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MEArrPy2C1lXPwHH/g6fRZ72r1oGwvn3o0x5jEkAZS8=;
        b=yY8IuHaWDDT6Y9XDrl9tfUQ6yvCF0auV7dx7zVJPrlWBhsfLYGEUU9Z1u86c6Moj5/
         EVszdDtmEBhZQtXlhG73sq4hH2k5oNDPVP3PuaIVeWAdEckx+ac7gmJhKuIpDSaQbDoE
         j28XNgJE+XeFd0ejzmgHQNgz3/GyPLQ9n56ZXsIG1WxuGIhGOJDV2RYdFMBJRoKSrxjL
         FcPWQHkdxf0MclPfoEEktNOc2CO+ivf7+gb4subkyordz9JGL6Ee+ZWcoqw0Eu015SZg
         le06979xbF+ESf0uvpeFWmkJCuM0WfyzPk1ZWzfZYrJLb7qsOct3TX5ohVCOU470E626
         70tQ==
X-Gm-Message-State: AFq9FYK+TwBvpnSHdPykGuQtXSbIW4gL7zCKWwdb6pOo/daWEJ7rAG05
	2ZMaaDkCkkjv2FlHki5YnQre/YLxcYG5zXDdGPtUClcsNkhSNaZBDsoD
X-Gm-Gg: AYBFou2WEefCbacb1HSgnNkZUp1eP/hRWgn5ls35fWPcdof4ravcXsmOCJUDsqwpuzD
	CzMlaNy/QSdOaJw7FpmjVqDsRIGoMKw8eVE8lQ6FHzdSDvO+YyKslL4DPewx8GxLmKfFVzUF+09
	wHKkXFhCz2vOGgrcjxdt6memghs/UgTGltH2FRb8/vTIJmYWmpg1hHrpM/WXWDS9oCJ5VgrYtpX
	jHhg7WhtWFg7FLPDuAYopGpitvPcODmyQC64ENs0snr40/+C2Ob2VPQAgDT7Lx3sesfVHzPLkuo
	tr/PP27xmNzU2zCyt7F3X8YQfYGCtAm4G3BY5jXYnjGudEfrBHR8AYiRfHMC/f4+0o9gaDTS3WP
	mos12wRxFHfCrSRQx9IE5Z7E7GP5ceNAw0WU2zgdKCicWcl0GM4MiMrbojDytYZnsZhcbbtd6fx
	sQNQrD3Vpnmpg9c4tdq0bueC2Nb3xBsjMm5vLX8YTFszv0fT920GZhMIYiCDkHqUKb9Ew0E0hrg
	GSsSSpedZR2WCe2P74BVYkFO0jsWvjlrRAoiuQaRIlwM2haqf5Vlrdk4w6IoGYbliewLHf/2lju
	icM8+F5UmhhwZPZQDUSSb9IJu24PDxUyz1AlewpibnpgZRxkhKVy2xjcqjw=
X-Received: by 2002:a17:902:fc84:b0:2e9:660a:793b with SMTP id d9443c01a7336-2ea9c8b974amr55266785ad.34.1793021837676;
        Mon, 26 Oct 2026 06:37:17 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:17 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 1/9] selftests/livepatch: Clarify test module file names
Date: Mon, 26 Oct 2026 21:36:43 +0800
Message-ID: <20261026133651.40061-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the test module files to be more descriptive of what they
actually test, as suggested by Petr.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
 tools/testing/selftests/livepatch/test-ftrace.sh   |   2 +-
 tools/testing/selftests/livepatch/test-kprobe.sh   |  12 +-
 .../testing/selftests/livepatch/test-livepatch.sh  |   6 +-
 tools/testing/selftests/livepatch/test-syscall.sh  |   2 +-
 tools/testing/selftests/livepatch/test-sysfs.sh    |   6 +-
 .../selftests/livepatch/test_modules/Makefile      |   8 +-
 .../test_modules/test_klp_atomic_replace.c         |  57 ---------
 .../livepatch/test_modules/test_klp_cmdline_kp.c   |  38 ++++++
 .../livepatch/test_modules/test_klp_cmdline_lp.c   |  51 ++++++++
 .../livepatch/test_modules/test_klp_kprobe.c       |  38 ------
 .../livepatch/test_modules/test_klp_livepatch.c    |  51 --------
 .../livepatch/test_modules/test_klp_meminfo_lp.c   |  57 +++++++++
 .../livepatch/test_modules/test_klp_syscall.c      | 131 ---------------------
 .../test_modules/test_klp_syscall_getpid.c         | 131 +++++++++++++++++++++
 14 files changed, 295 insertions(+), 295 deletions(-)
 delete mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
 delete mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
 delete mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
 delete mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index cd27148..e05e7b8 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_LIVEPATCH=test_klp_livepatch
+MOD_LIVEPATCH=test_klp_cmdline_lp
 
 setup_config
 
diff --git a/tools/testing/selftests/livepatch/test-kprobe.sh b/tools/testing/selftests/livepatch/test-kprobe.sh
index 7ced408..81ab6d4 100755
--- a/tools/testing/selftests/livepatch/test-kprobe.sh
+++ b/tools/testing/selftests/livepatch/test-kprobe.sh
@@ -7,8 +7,8 @@
 
 grep -q kprobe_ftrace_ops /proc/kallsyms || skip "test-kprobe requires CONFIG_KPROBES_ON_FTRACE"
 
-MOD_LIVEPATCH=test_klp_livepatch
-MOD_KPROBE=test_klp_kprobe
+MOD_LIVEPATCH=test_klp_cmdline_lp
+MOD_KPROBE=test_klp_cmdline_kp
 
 setup_config
 
@@ -24,7 +24,7 @@ load_mod $MOD_KPROBE has_post_handler=y
 load_failing_mod $MOD_LIVEPATCH
 unload_mod $MOD_KPROBE
 
-check_result "% insmod test_modules/test_klp_kprobe.ko has_post_handler=y
+check_result "% insmod test_modules/$MOD_KPROBE.ko has_post_handler=y
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
@@ -35,7 +35,7 @@ livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
-% rmmod test_klp_kprobe"
+% rmmod $MOD_KPROBE"
 
 start_test "livepatch interaction with kprobed function without post_handler"
 
@@ -46,14 +46,14 @@ unload_mod $MOD_KPROBE
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/test_klp_kprobe.ko has_post_handler=n
+check_result "% insmod test_modules/$MOD_KPROBE.ko has_post_handler=n
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-% rmmod test_klp_kprobe
+% rmmod $MOD_KPROBE
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index c44c534..5380b5f 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -4,10 +4,10 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_LIVEPATCH1=test_klp_livepatch
-MOD_LIVEPATCH2=test_klp_syscall
+MOD_LIVEPATCH1=test_klp_cmdline_lp
+MOD_LIVEPATCH2=test_klp_syscall_getpid
 MOD_LIVEPATCH3=test_klp_callbacks_demo
-MOD_REPLACE=test_klp_atomic_replace
+MOD_REPLACE=test_klp_meminfo_lp
 MOD_TARGET=test_klp_mod_target
 MOD_TARGET_PATCH=test_klp_mod_patch
 
diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
index 5f93442..488207f 100755
--- a/tools/testing/selftests/livepatch/test-syscall.sh
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -5,7 +5,7 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_SYSCALL=test_klp_syscall
+MOD_SYSCALL=test_klp_syscall_getpid
 
 setup_config
 
diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 3b16285..32d3af0 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -4,9 +4,9 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_LIVEPATCH=test_klp_livepatch
+MOD_LIVEPATCH=test_klp_cmdline_lp
 MOD_LIVEPATCH2=test_klp_callbacks_demo
-MOD_LIVEPATCH3=test_klp_syscall
+MOD_LIVEPATCH3=test_klp_syscall_getpid
 
 HAS_PATCH_ATTR=0
 HAS_REPLACE_ATTR=0
@@ -108,7 +108,7 @@ fi
 if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
 	start_test "sysfs test replace enabled"
 
-	MOD_ATOMIC_REPLACE=test_klp_atomic_replace
+	MOD_ATOMIC_REPLACE=test_klp_meminfo_lp
 	load_lp $MOD_ATOMIC_REPLACE replace=1
 
 	check_sysfs_rights "$MOD_ATOMIC_REPLACE" "replace" "-r--r--r--"
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a13d398..732e000 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -1,20 +1,20 @@
 TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
 KDIR ?= /lib/modules/$(shell uname -r)/build
 
-obj-m += test_klp_atomic_replace.o \
+obj-m += test_klp_meminfo_lp.o \
 	test_klp_callbacks_busy.o \
 	test_klp_callbacks_demo.o \
 	test_klp_callbacks_demo2.o \
 	test_klp_callbacks_mod.o \
-	test_klp_kprobe.o \
-	test_klp_livepatch.o \
+	test_klp_cmdline_kp.o \
+	test_klp_cmdline_lp.o \
 	test_klp_mod_patch.o \
 	test_klp_mod_target.o \
 	test_klp_shadow_vars.o \
 	test_klp_state.o \
 	test_klp_state2.o \
 	test_klp_state3.o \
-	test_klp_syscall.o
+	test_klp_syscall_getpid.o
 
 # Ensure that KDIR exists, otherwise skip the compilation
 modules:
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
deleted file mode 100644
index 5af7093..0000000
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/livepatch.h>
-
-static int replace;
-module_param(replace, int, 0644);
-MODULE_PARM_DESC(replace, "replace (default=0)");
-
-#include <linux/seq_file.h>
-static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
-		   "this has been live patched");
-	return 0;
-}
-
-static struct klp_func funcs[] = {
-	{
-		.old_name = "meminfo_proc_show",
-		.new_func = livepatch_meminfo_proc_show,
-	}, {}
-};
-
-static struct klp_object objs[] = {
-	{
-		/* name being NULL means vmlinux */
-		.funcs = funcs,
-	}, {}
-};
-
-static struct klp_patch patch = {
-	.mod = THIS_MODULE,
-	.objs = objs,
-	/* set .replace in the init function below for demo purposes */
-};
-
-static int test_klp_atomic_replace_init(void)
-{
-	patch.replace = replace;
-	return klp_enable_patch(&patch);
-}
-
-static void test_klp_atomic_replace_exit(void)
-{
-}
-
-module_init(test_klp_atomic_replace_init);
-module_exit(test_klp_atomic_replace_exit);
-MODULE_LICENSE("GPL");
-MODULE_INFO(livepatch, "Y");
-MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
-MODULE_DESCRIPTION("Livepatch test: atomic replace");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c
new file mode 100644
index 0000000..28ef7ea
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Marcos Paulo de Souza <mpdesouza@suse.com>
+// Copyright (C) 2024 Michael Vetter <mvetter@suse.com>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+
+static bool has_post_handler = true;
+module_param(has_post_handler, bool, 0444);
+
+static void __kprobes post_handler(struct kprobe *p, struct pt_regs *regs,
+				unsigned long flags)
+{
+}
+
+static struct kprobe kp = {
+	.symbol_name = "cmdline_proc_show",
+};
+
+static int __init cmdline_kp_init(void)
+{
+	if (has_post_handler)
+		kp.post_handler = post_handler;
+
+	return register_kprobe(&kp);
+}
+
+static void __exit cmdline_kp_exit(void)
+{
+	unregister_kprobe(&kp);
+}
+
+module_init(cmdline_kp_init)
+module_exit(cmdline_kp_exit)
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Vetter <mvetter@suse.com>");
+MODULE_DESCRIPTION("Livepatch test: cmdline kprobe");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
new file mode 100644
index 0000000..88c6aed
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+#include <linux/seq_file.h>
+static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
+		   "this has been live patched");
+	return 0;
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "cmdline_proc_show",
+		.new_func = livepatch_cmdline_proc_show,
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_cmdline_lp_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_cmdline_lp_exit(void)
+{
+}
+
+module_init(test_klp_cmdline_lp_init);
+module_exit(test_klp_cmdline_lp_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Seth Jennings <sjenning@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: cmdline livepatch");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c b/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
deleted file mode 100644
index 67a8d29..0000000
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2024 Marcos Paulo de Souza <mpdesouza@suse.com>
-// Copyright (C) 2024 Michael Vetter <mvetter@suse.com>
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/kprobes.h>
-
-static bool has_post_handler = true;
-module_param(has_post_handler, bool, 0444);
-
-static void __kprobes post_handler(struct kprobe *p, struct pt_regs *regs,
-				unsigned long flags)
-{
-}
-
-static struct kprobe kp = {
-	.symbol_name = "cmdline_proc_show",
-};
-
-static int __init kprobe_init(void)
-{
-	if (has_post_handler)
-		kp.post_handler = post_handler;
-
-	return register_kprobe(&kp);
-}
-
-static void __exit kprobe_exit(void)
-{
-	unregister_kprobe(&kp);
-}
-
-module_init(kprobe_init)
-module_exit(kprobe_exit)
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Michael Vetter <mvetter@suse.com>");
-MODULE_DESCRIPTION("Livepatch test: kprobe function");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
deleted file mode 100644
index aff0819..0000000
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/livepatch.h>
-
-#include <linux/seq_file.h>
-static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
-		   "this has been live patched");
-	return 0;
-}
-
-static struct klp_func funcs[] = {
-	{
-		.old_name = "cmdline_proc_show",
-		.new_func = livepatch_cmdline_proc_show,
-	}, { }
-};
-
-static struct klp_object objs[] = {
-	{
-		/* name being NULL means vmlinux */
-		.funcs = funcs,
-	}, { }
-};
-
-static struct klp_patch patch = {
-	.mod = THIS_MODULE,
-	.objs = objs,
-};
-
-static int test_klp_livepatch_init(void)
-{
-	return klp_enable_patch(&patch);
-}
-
-static void test_klp_livepatch_exit(void)
-{
-}
-
-module_init(test_klp_livepatch_init);
-module_exit(test_klp_livepatch_exit);
-MODULE_LICENSE("GPL");
-MODULE_INFO(livepatch, "Y");
-MODULE_AUTHOR("Seth Jennings <sjenning@redhat.com>");
-MODULE_DESCRIPTION("Livepatch test: livepatch module");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
new file mode 100644
index 0000000..f2477b2
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int replace;
+module_param(replace, int, 0644);
+MODULE_PARM_DESC(replace, "replace (default=0)");
+
+#include <linux/seq_file.h>
+static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
+		   "this has been live patched");
+	return 0;
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "meminfo_proc_show",
+		.new_func = livepatch_meminfo_proc_show,
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+	/* set .replace in the init function below for demo purposes */
+};
+
+static int test_klp_meminfo_lp_init(void)
+{
+	patch.replace = replace;
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_meminfo_lp_exit(void)
+{
+}
+
+module_init(test_klp_meminfo_lp_init);
+module_exit(test_klp_meminfo_lp_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: meminfo livepatch");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
deleted file mode 100644
index 08aacc0..0000000
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
+++ /dev/null
@@ -1,131 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017-2023 SUSE
- * Authors: Libor Pechacek <lpechacek@suse.cz>
- *          Nicolai Stange <nstange@suse.de>
- *          Marcos Paulo de Souza <mpdesouza@suse.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/livepatch.h>
-
-/*
- * Before CONFIG_ARCH_HAS_SYSCALL_WRAPPER was introduced there were no
- * prefixes for system calls.
- * powerpc set this config based on configs, so it can be enabled or not.
- */
-#if defined(CONFIG_ARCH_HAS_SYSCALL_WRAPPER)
-  #if defined(__x86_64__)
-    #define FN_PREFIX __x64_
-  #elif defined(__s390x__)
-    #define FN_PREFIX __s390x_
-  #elif defined(__aarch64__)
-    #define FN_PREFIX __arm64_
-  #elif defined(__powerpc__)
-    #define FN_PREFIX
-  #else
-    #error "Missing syscall wrapper for the given architecture."
-  #endif
-#else
-  /* Do not set a prefix for architectures that do not enable wrappers. */
-  #define FN_PREFIX
-#endif
-
-/* Protects klp_pids */
-static DEFINE_MUTEX(kpid_mutex);
-
-static unsigned int npids, npids_pending;
-static int klp_pids[NR_CPUS];
-module_param_array(klp_pids, int, &npids_pending, 0);
-MODULE_PARM_DESC(klp_pids, "Array of pids to be transitioned to livepatched state.");
-
-static ssize_t npids_show(struct kobject *kobj, struct kobj_attribute *attr,
-			  char *buf)
-{
-	return sprintf(buf, "%u\n", npids_pending);
-}
-
-static struct kobj_attribute klp_attr = __ATTR_RO(npids);
-static struct kobject *klp_kobj;
-
-static asmlinkage long lp_sys_getpid(void)
-{
-	int i;
-
-	mutex_lock(&kpid_mutex);
-	if (npids_pending > 0) {
-		for (i = 0; i < npids; i++) {
-			if (current->pid == klp_pids[i]) {
-				klp_pids[i] = 0;
-				npids_pending--;
-				break;
-			}
-		}
-	}
-	mutex_unlock(&kpid_mutex);
-
-	return task_tgid_vnr(current);
-}
-
-static struct klp_func vmlinux_funcs[] = {
-	{
-		.old_name = __stringify(FN_PREFIX) "sys_getpid",
-		.new_func = lp_sys_getpid,
-	}, {}
-};
-
-static struct klp_object objs[] = {
-	{
-		/* name being NULL means vmlinux */
-		.funcs = vmlinux_funcs,
-	}, {}
-};
-
-static struct klp_patch patch = {
-	.mod = THIS_MODULE,
-	.objs = objs,
-};
-
-static int livepatch_init(void)
-{
-	int ret;
-
-	klp_kobj = kobject_create_and_add("test_klp_syscall", kernel_kobj);
-	if (!klp_kobj)
-		return -ENOMEM;
-
-	ret = sysfs_create_file(klp_kobj, &klp_attr.attr);
-	if (ret) {
-		kobject_put(klp_kobj);
-		return ret;
-	}
-
-	/*
-	 * Save the number pids to transition to livepatched state before the
-	 * number of pending pids is decremented.
-	 */
-	npids = npids_pending;
-
-	ret = klp_enable_patch(&patch);
-	if (ret)
-		kobject_put(klp_kobj);
-
-	return ret;
-}
-
-static void livepatch_exit(void)
-{
-	kobject_put(klp_kobj);
-}
-
-module_init(livepatch_init);
-module_exit(livepatch_exit);
-MODULE_LICENSE("GPL");
-MODULE_INFO(livepatch, "Y");
-MODULE_AUTHOR("Libor Pechacek <lpechacek@suse.cz>");
-MODULE_AUTHOR("Nicolai Stange <nstange@suse.de>");
-MODULE_AUTHOR("Marcos Paulo de Souza <mpdesouza@suse.com>");
-MODULE_DESCRIPTION("Livepatch test: syscall transition");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c
new file mode 100644
index 0000000..5da2bc7
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 SUSE
+ * Authors: Libor Pechacek <lpechacek@suse.cz>
+ *          Nicolai Stange <nstange@suse.de>
+ *          Marcos Paulo de Souza <mpdesouza@suse.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/livepatch.h>
+
+/*
+ * Before CONFIG_ARCH_HAS_SYSCALL_WRAPPER was introduced there were no
+ * prefixes for system calls.
+ * powerpc set this config based on configs, so it can be enabled or not.
+ */
+#if defined(CONFIG_ARCH_HAS_SYSCALL_WRAPPER)
+  #if defined(__x86_64__)
+    #define FN_PREFIX __x64_
+  #elif defined(__s390x__)
+    #define FN_PREFIX __s390x_
+  #elif defined(__aarch64__)
+    #define FN_PREFIX __arm64_
+  #elif defined(__powerpc__)
+    #define FN_PREFIX
+  #else
+    #error "Missing syscall wrapper for the given architecture."
+  #endif
+#else
+  /* Do not set a prefix for architectures that do not enable wrappers. */
+  #define FN_PREFIX
+#endif
+
+/* Protects klp_pids */
+static DEFINE_MUTEX(kpid_mutex);
+
+static unsigned int npids, npids_pending;
+static int klp_pids[NR_CPUS];
+module_param_array(klp_pids, int, &npids_pending, 0);
+MODULE_PARM_DESC(klp_pids, "Array of pids to be transitioned to livepatched state.");
+
+static ssize_t npids_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	return sprintf(buf, "%u\n", npids_pending);
+}
+
+static struct kobj_attribute klp_attr = __ATTR_RO(npids);
+static struct kobject *klp_kobj;
+
+static asmlinkage long lp_sys_getpid(void)
+{
+	int i;
+
+	mutex_lock(&kpid_mutex);
+	if (npids_pending > 0) {
+		for (i = 0; i < npids; i++) {
+			if (current->pid == klp_pids[i]) {
+				klp_pids[i] = 0;
+				npids_pending--;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&kpid_mutex);
+
+	return task_tgid_vnr(current);
+}
+
+static struct klp_func vmlinux_funcs[] = {
+	{
+		.old_name = __stringify(FN_PREFIX) "sys_getpid",
+		.new_func = lp_sys_getpid,
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = vmlinux_funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int livepatch_init(void)
+{
+	int ret;
+
+	klp_kobj = kobject_create_and_add("test_klp_syscall_getpid", kernel_kobj);
+	if (!klp_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_file(klp_kobj, &klp_attr.attr);
+	if (ret) {
+		kobject_put(klp_kobj);
+		return ret;
+	}
+
+	/*
+	 * Save the number pids to transition to livepatched state before the
+	 * number of pending pids is decremented.
+	 */
+	npids = npids_pending;
+
+	ret = klp_enable_patch(&patch);
+	if (ret)
+		kobject_put(klp_kobj);
+
+	return ret;
+}
+
+static void livepatch_exit(void)
+{
+	kobject_put(klp_kobj);
+}
+
+module_init(livepatch_init);
+module_exit(livepatch_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Libor Pechacek <lpechacek@suse.cz>");
+MODULE_AUTHOR("Nicolai Stange <nstange@suse.de>");
+MODULE_AUTHOR("Marcos Paulo de Souza <mpdesouza@suse.com>");
+MODULE_DESCRIPTION("Livepatch test: syscall getpid transition");
-- 
1.8.3.1

