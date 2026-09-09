Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F30315D5D
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921828; cv=none; b=qUaVKvjWqASEepGUWRvCV3+eOLv5c66Z6iyL+LXnFnv4aJTMTMROgxDkKL/jiaKsd2xYPnSCaKmTreVtMCR53IzTgcSkyteBq21VYwJzXoW+WUWh9c2fabYKZCwYlYVpCyblMqbexQ5Cjik9BaDQdytq9bvFnuDzCGEJI8cP1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921828; c=relaxed/simple;
	bh=fAltR5DtBqGWuQGSyctVvnHWlFGd10Frmfe9SM8eiiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtI5SvJpC8XW3Amx/rby/E5kGp+qHdghtfVUx3Jw4sc5rh5pzpfy/IL+ZXztRFNPvil+HcH5aAb/QD7e4tiBjg+h1CD/B9B7zVaM63PMwW0YCRO7nCoUNytvuqugeqCoWAbuMNvIomPiMFAZFtgge9Z5zzer8TvHWDkROUkGN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cynaxqux; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cynaxqux"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so5033257a91.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921827; x=1789526627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oh3IvpbapmdRGmXzuEr7nZHNlbz1qnRuifz+XMGQoL8=;
        b=cynaxquxyab8JFx5rzWCnaJfEuLysWPm3+sV+IYM87jbtzM2x525LS/RgYYJQ59VFh
         5wfTj4hedLT5lwRqljTNXTOuUvP6ADVrY3CnOY6g+9YxkBAgN4983U+BEsBD+HDF3K1G
         MOScO1Av9EtxIputGqnmtQO3yqokdPuUWFYNLRQCQ07WUh8weKJzRSU560qrHYKE4JFV
         JOY0/33EegzK2L+llEwPhfW+zY3I/Aqqsju4mXe2XqujLxXB8O9rF4C7hldIgwnqsPLn
         zC8/IbV4AqUALbu3oLQNTvmGbkLYAdnOr5qgsBQ5P51PspfQtA6WYeetD3JBMpQaX5OX
         hVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921827; x=1789526627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oh3IvpbapmdRGmXzuEr7nZHNlbz1qnRuifz+XMGQoL8=;
        b=pxJls8wgAtVC01eob4Bf3fQbEx0g/piKMk89F1k53SFiecMIjipX1zTkN091IinXBJ
         qNI2fcpnq9QzbVF5UqghGu4Loq9A8kco1y3smabsqtP+7hL2iAduqbI5dNGNe4tsMmEe
         yAV1hovbwyw1ZXQGi4+vGSZNxVQOI+2ZakXufdJdvsRyZUwijXqKEmZ6kxFln6UtiSrm
         +7VWY3pNxE4VJp6NZHAI63xkQ3apTryrJZKr33DU4OzAInKKt5YTHVuShJwaRR6pIu78
         2DV2JcHjFUPRmw+1aaC9r+3BjTF9tQPaqfw8AuatEM0WaZmr6WYP92r5ujfXie+eq79m
         T6UQ==
X-Gm-Message-State: AFuF++lbaBsMVZPB8j+uJZ3irW19oLi3DuoIb8REQ+MMAwMmt0BlDnUe
	0I/azCSNHv2W2VBZI+OauqkslElTcwr+AO8Oq++fOfScOmrj5fyzvzBG8XQNJeQRsReaaA==
X-Gm-Gg: AYBFou1lZsGTXHnstvDMCmRUjoOfmWB8jzT0pPJPvmcn85b31oeYwLQpcXhdE5IAJnF
	Jxh2G6hWSMkybnCz4GBP8a1CBJBAocQFZLT0/Dhv1r2hHQMRx7azWwKOnTeR6inbnjHHijXRZdk
	dVobCQaWRz+gQXXw+oBRcrm7wt4EW5uULai7VyyjTqRkayHBKDMiZSiIhUKjWlk/7PdWvajeWg7
	irWganBk32EQJpWKE3mMWsR/xfrcU2Aa9lqPqa4E3tLqNlGp85QB1+aOkiBCi9JEo97SkN2GZj6
	THPYEDH83j4UDm2XuFeAIBgsoOOUaifAUoxVoF9MnkEqpcJTp2qsgCK1UukPe6xFTmWPVZ/vSLa
	17HPOsuibJai6DReeYIXu/hzobpfJlcvyKghD6/1YKMdjsVlEaP6QIL3iqlV4k8xfr2+7XS15tt
	rXSlzGWQhJRI2Zo8E3gB+JPwBqI55SK3kCz8ehf0zwFrjRHFhpfjMpT24r7FFTw6Tavftd2F73E
	QmTet9szsLTN8dAu3cAcyYDqwnB4yv40M8UXKOLp8iRF09EPDpwfdpK7XhC1/ST1NVuzQ==
X-Received: by 2002:a17:90b:2542:b0:398:9beb:a2be with SMTP id 98e67ed59e1d1-39b08969b5dmr42575251a91.32.1788921826548;
        Tue, 08 Sep 2026 19:43:46 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.43.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:43:46 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 1/9] selftests/livepatch: Clarify test module file names
Date: Wed,  9 Sep 2026 10:43:16 +0800
Message-ID: <20260909024324.16002-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909024324.16002-1-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the test module files to be more descriptive of what they
actually test, as suggested by Petr.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/livepatch/test-ftrace.sh     |  2 +-
 tools/testing/selftests/livepatch/test-kprobe.sh     | 12 ++++++------
 tools/testing/selftests/livepatch/test-livepatch.sh  |  6 +++---
 tools/testing/selftests/livepatch/test-syscall.sh    |  2 +-
 tools/testing/selftests/livepatch/test-sysfs.sh      |  6 +++---
 .../selftests/livepatch/test_modules/Makefile        |  8 ++++----
 .../{test_klp_kprobe.c => test_klp_cmdline_kp.c}     | 10 +++++-----
 .../{test_klp_livepatch.c => test_klp_cmdline_lp.c}  | 10 +++++-----
 ...st_klp_atomic_replace.c => test_klp_meminfo_lp.c} | 10 +++++-----
 ...{test_klp_syscall.c => test_klp_syscall_getpid.c} |  4 ++--
 10 files changed, 35 insertions(+), 35 deletions(-)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_kprobe.c => test_klp_cmdline_kp.c} (78%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_livepatch.c => test_klp_cmdline_lp.c} (79%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_atomic_replace.c => test_klp_meminfo_lp.c} (82%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_syscall.c => test_klp_syscall_getpid.c} (95%)

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index d2c3dea63104..90e8fcc4d065 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_LIVEPATCH=test_klp_livepatch
+MOD_LIVEPATCH=test_klp_cmdline_lp
 
 setup_config
 
diff --git a/tools/testing/selftests/livepatch/test-kprobe.sh b/tools/testing/selftests/livepatch/test-kprobe.sh
index 7ced4082cff3..81ab6d4760aa 100755
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
index c44c5341a2f1..5380b5f174d4 100755
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
index 5f9344277b62..488207f25c50 100755
--- a/tools/testing/selftests/livepatch/test-syscall.sh
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -5,7 +5,7 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_SYSCALL=test_klp_syscall
+MOD_SYSCALL=test_klp_syscall_getpid
 
 setup_config
 
diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 3b16285c6e67..32d3af0097ac 100755
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
index a13d398585dc..732e0003930b 100644
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
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c
similarity index 78%
rename from tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c
index 67a8d29012f6..28ef7ea33fc7 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_kp.c
@@ -18,7 +18,7 @@ static struct kprobe kp = {
 	.symbol_name = "cmdline_proc_show",
 };
 
-static int __init kprobe_init(void)
+static int __init cmdline_kp_init(void)
 {
 	if (has_post_handler)
 		kp.post_handler = post_handler;
@@ -26,13 +26,13 @@ static int __init kprobe_init(void)
 	return register_kprobe(&kp);
 }
 
-static void __exit kprobe_exit(void)
+static void __exit cmdline_kp_exit(void)
 {
 	unregister_kprobe(&kp);
 }
 
-module_init(kprobe_init)
-module_exit(kprobe_exit)
+module_init(cmdline_kp_init)
+module_exit(cmdline_kp_exit)
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Vetter <mvetter@suse.com>");
-MODULE_DESCRIPTION("Livepatch test: kprobe function");
+MODULE_DESCRIPTION("Livepatch test: cmdline kprobe");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
similarity index 79%
rename from tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
index aff08199de71..88c6aed925fb 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_cmdline_lp.c
@@ -34,18 +34,18 @@ static struct klp_patch patch = {
 	.objs = objs,
 };
 
-static int test_klp_livepatch_init(void)
+static int test_klp_cmdline_lp_init(void)
 {
 	return klp_enable_patch(&patch);
 }
 
-static void test_klp_livepatch_exit(void)
+static void test_klp_cmdline_lp_exit(void)
 {
 }
 
-module_init(test_klp_livepatch_init);
-module_exit(test_klp_livepatch_exit);
+module_init(test_klp_cmdline_lp_init);
+module_exit(test_klp_cmdline_lp_exit);
 MODULE_LICENSE("GPL");
 MODULE_INFO(livepatch, "Y");
 MODULE_AUTHOR("Seth Jennings <sjenning@redhat.com>");
-MODULE_DESCRIPTION("Livepatch test: livepatch module");
+MODULE_DESCRIPTION("Livepatch test: cmdline livepatch");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
similarity index 82%
rename from tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
index 5af7093ca00c..f2477b217aab 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
@@ -39,19 +39,19 @@ static struct klp_patch patch = {
 	/* set .replace in the init function below for demo purposes */
 };
 
-static int test_klp_atomic_replace_init(void)
+static int test_klp_meminfo_lp_init(void)
 {
 	patch.replace = replace;
 	return klp_enable_patch(&patch);
 }
 
-static void test_klp_atomic_replace_exit(void)
+static void test_klp_meminfo_lp_exit(void)
 {
 }
 
-module_init(test_klp_atomic_replace_init);
-module_exit(test_klp_atomic_replace_exit);
+module_init(test_klp_meminfo_lp_init);
+module_exit(test_klp_meminfo_lp_exit);
 MODULE_LICENSE("GPL");
 MODULE_INFO(livepatch, "Y");
 MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
-MODULE_DESCRIPTION("Livepatch test: atomic replace");
+MODULE_DESCRIPTION("Livepatch test: meminfo livepatch");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c
similarity index 95%
rename from tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c
index 08aacc0e14de..5da2bc7920cc 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall_getpid.c
@@ -93,7 +93,7 @@ static int livepatch_init(void)
 {
 	int ret;
 
-	klp_kobj = kobject_create_and_add("test_klp_syscall", kernel_kobj);
+	klp_kobj = kobject_create_and_add("test_klp_syscall_getpid", kernel_kobj);
 	if (!klp_kobj)
 		return -ENOMEM;
 
@@ -128,4 +128,4 @@ MODULE_INFO(livepatch, "Y");
 MODULE_AUTHOR("Libor Pechacek <lpechacek@suse.cz>");
 MODULE_AUTHOR("Nicolai Stange <nstange@suse.de>");
 MODULE_AUTHOR("Marcos Paulo de Souza <mpdesouza@suse.com>");
-MODULE_DESCRIPTION("Livepatch test: syscall transition");
+MODULE_DESCRIPTION("Livepatch test: syscall getpid transition");
-- 
2.52.0

