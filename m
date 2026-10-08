Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B5490BF6
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453532; cv=none; b=D5l0bHtycL2d07nZHln6XSzLYFZYXnxRqvr/+sXPz3fCuwuBqyHQETjqj1Mat5xCa3ZGxRDhyZwisWrUixpIk6bDQEJ7RnXbXSh5MQO/bDN5Bx9NDfIZ1IQ/1z3mUye2KgQIpBRZHnIPOxSXbNj5CfVEiB/3jV7ttB9jEag1UE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453532; c=relaxed/simple;
	bh=pQXp6a0dHdnvBhtSOfw/ld4Laklanoe7Z7SfzuSi96Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyUY8gb1JJf01UJmyCU5bTKTPvvx+RuJzPKT6CGlo7jFgv/NnlZSvAID3vuhUcyRZ5A4uU+4lRwmfQ4TIzlsVIa9oIz1n5ZeTV4QYVyl9D/oXyIIXrhdFBDkGbC/zt05QmeeXnZR8FiPy02cVTI4rbVZNIU9H2pS2axI/CQ9baI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF76ZkGN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF76ZkGN"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab066bef7dso236278a91.1
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453526; x=1792058326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsMRbr3IEb8FzOtWgrSlhatPcpb9DMkHXuDMbvY31VM=;
        b=ZF76ZkGNBD4t88OQvXM1a3h9+7mw4JqH+9q8v+clgqbQPXFfgcQBXmZOckuOPmz4MD
         1oH3IpLv3mUD9aVOcoPDoZ3mBFGWTZoQDr5azbTexGjG9qv2f+kYUSg20SKuNSTNqVGd
         8aY2As9s+1ZBpVnFsnrDwPd4+BAjATFBbAIXOk/nKH9DmAUDd/0a7m/JBFObhqWA1j41
         dnDEcqJbSK3cxZn7jpuVjuRHLc+btikWZpaVnjQsQTY2pgBggDMIPTAgICmI8XcRsZGR
         Cvva1vq3aoKE7boMgj4JATfQcGG/lPIlbuLG1NtEJoNce98WaPqZlCTGFWx8LMbQYBU5
         4NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453526; x=1792058326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FsMRbr3IEb8FzOtWgrSlhatPcpb9DMkHXuDMbvY31VM=;
        b=jPx4XLVER3S2jaIfo/1fD41tr/ZvN2x7HVrLfzjUyEIPGL4bW1iUo5kzqoZUlOXlzz
         +uCfMbf3p+XdsXMlMlpiTUTkE8ifA2M/5GE+wOde+qZ2nViaCOdABCm9tYzfNei0oQhA
         WkOz0eq+XmeOHQ0TQctpwV9JzFvo42hBJ90b675yH6i9xMZy9+dpsqhC4yhQHEd4F865
         VGzRIy/Ockn7OBaCayxHcCai+QfCV6ORsBctGExwX2EcNkWxCPSiLoPqUQ9T/1NQE0IL
         1pAaVepKi/47oHoJwbPtc8zwCgaBIU5srlPA97wlkYUrFfcChB6d1bJhMDGqbDFosc76
         iW8w==
X-Gm-Message-State: AFq9FYKCt7sAFcL1jZVNHNDe06tlYKXtPGqel0D3RKkZniK29PS4nABH
	zlPaXpgAjINjNccufnqMG5fD8e1pS7ULu9+LBXi8KWNgUSoqhsviZ8si
X-Gm-Gg: AYBFou3CoW1DCoORMMKgUCGwV3YffJnUuiOIYQOIpHdCzI97OAseABavq8JTjNibYVP
	2PxsQNxwabqgi5QMV8HJal2xxGX0/dcUjedMEA5BeJtmV/MYPQLKBCfb8NQh7EuxM4S43fhpA5S
	oozvLAyoSuGbWOWsdDZr+so1lC5qHmSXP6ed0hywVioXeBfYjZMFywmpDr5jL1kcjkaxrLQ6zJ7
	PhpJZyMB821UkbOy4Ekz/bUL8F3nFF4+BXMw2IrQXOvS1Aeofe+o5JEXysB+pH9qRTYRUvFJkGb
	DrmEl6ASgwOMIvK0+9vgQiFSGirS0BiQxiavdn+pplGibxKR5uUvySlVcgtntAjOgejYZn19IK9
	4xfWlHCWG5ZhpkELkshUyOwAVG3dRGAs0O8ON3470f8ZphKzwGpmicH3pTS6cI380qkEGhl18ZP
	pUYrwJTRV2BQ4ayjpPVOvkAcaUPYI6hLqPovadSx979sG6OssTLoeETTGoiOXlz+D2uVDan1uYd
	SQHKM8nD76vrUQIfb+lFaSmT+LF7DZxvg6+ck3Hz3/7No6SXkn9GlHW
X-Received: by 2002:a17:90b:4b8d:b0:3a5:25e:85fc with SMTP id 98e67ed59e1d1-3a8a1ce5d6cmr4476771a91.63.1791453526106;
        Thu, 08 Oct 2026 02:58:46 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2100:3ace:b801:9432:769f:ff9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ff13esm3422790a91.7.2026.10.08.02.58.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:58:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 1/9] selftests/livepatch: Clarify test module file names
Date: Thu,  8 Oct 2026 17:58:22 +0800
Message-ID: <20261008095830.26308-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261008095830.26308-1-laoar.shao@gmail.com>
References: <20261008095830.26308-1-laoar.shao@gmail.com>
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
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
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

