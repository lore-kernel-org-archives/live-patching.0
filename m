Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4736EABE
	for <live-patching@vger.kernel.org>; Sat,  5 Sep 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623721; cv=none; b=ascX4r2bFASPFavqzEfY63+D8IsBC0QK7yIdGmWwltJmQRAgyaPds8RPp4MtdP4VM3L/vHJCL8uZMIw3iN7yEdbQ8O+MUS1ZbgRsi7B5j7Zm9K0uud4ZQ/WfjF3tfHFacqKesx8kwnGugc8E/JLoeIHOjhvN+crbkV2obibjO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623721; c=relaxed/simple;
	bh=pV+5IwkMLFn8Fx7djk9Yp6iUxrqGZmoFgCFV9E+GkBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdLrMx9BxZcC3xmXt0vq1ElaL04oePenJsZy6PQoqM+AE+uqS3YTC7DPf/6TjlP68teUhBbvCaEPZdWfX7I8kR0kQ+x/tGPDfy3KqbqQ0qORREe8pN4odruuKsgJx+VKrk+/iDfqsrqpqEVAMXGg+B4Vm0u6YjP/qJAvmQwg/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFeq9kiS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFeq9kiS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1583300b3a.1
        for <live-patching@vger.kernel.org>; Sat, 05 Sep 2026 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788623715; x=1789228515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2dEMJL1vhZK8124yTxwhBFPgoAwEv2z5aul9rIHN7w=;
        b=PFeq9kiSaw+J5qTIcXskZ+geHKAbNgPJFhwy4EtTIXOL08y1nJHI0u3njprFtSXEPK
         8V2skKdyhBC2P3rtgvPMeBBTwt5oeGZcqKP835z+gkEfV/QHtO18JjqF+p0dM7HVLhN4
         +jyeRUSfqsuc520bNSKpEbjvYHhLwGXczS6uKSUcUaAZp/Q/pIvJ8YcuqDZFmt+0DJOV
         8dQICAtYVeeKfo983hbZ4ND0lcVpjQWNRjKwnKKDrWTco2lKLnZx+86VuaEOTXDIL1/4
         f2TuZoKClrZRE96fzAZURcmZ0JZ8HivYs1pjgscek5aDIjBjgK4APAtL4b5dOSc58MtM
         pA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623715; x=1789228515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F2dEMJL1vhZK8124yTxwhBFPgoAwEv2z5aul9rIHN7w=;
        b=inPIrXIJZdll2neA2RCOKEwaJ+r/UiRmuJW07/YihEwGfcOirifvSizPqLhhd58BeW
         yA/vpRjwCHDv9ae/sqgZHrssil6WxgVaPujE9LdsRRCd1wbMCGh/IGGoVeWvil6YQraa
         vAZM3mjO5v+eSLVQ8w6qIh1muaPvD/tr+LPDiEvO2u9TIASb+ZjZAXCd0rSKa4mOePfF
         P5ube3VYpEJ4p+feCQfmrfWQVD8Q9MlAN2QpaYEL9s2K0EoYZRQ6cbmJO6Cds+L4gO2H
         5P+51xqi/D4XBU3wG0Nq4sH8cBHiqvf52Lp23MIaXP961rqftEdspSci06ZbMU5/7m8k
         IBtw==
X-Gm-Message-State: AFuF++lEb/f9V79gsDgNCzdaftoNywE5d3g3L0hZl3tvUexFPRlK6cUW
	Cq+GjEC7nTa0fI2f1uBk6UkETLapvvgfpO4jzmB3WF+wbpKU5iRAvPfE
X-Gm-Gg: AYBFou2zclIyJC+KYKbdMQAthChLfVDGYYTBZb10OKH5XzVqZ6K+wWX4qaenaFRn6KP
	YyC0bWMo9v54pMs19fyEor/6gXHop00RdAHqSkKtHR/udU84UPk1Mvw4k5FzRwfENkHtojVnIEv
	NZ4ojhyt6XgdgX9WrG0K7DxQok5wyG6F4wLGrp2HvYSpw5ZqY6stv6uzW4i3/+062RPRW7Yowan
	YfZnMcp+R3SJyEybxRCf7n4zS9KgtVsMXPm/F9GOE4dRbZfUVE2rjyN0l7oNhCGN3WPXj5vVOaU
	r5aZDr+/j1MfoTc4JByZW8PueXZsaiMUt7+jWngphVcLxGlvkB7H3lZjBFt56wuwC9attI55n8T
	JilajuZg6WOHPTrrCc17TaA7AVeJv50zU+ur5b43P8blaEfBYJYucdpGhbFYsuxWQ7PCo6gTdOF
	08XBKZ5d+sjI/Lha0d4bt8P/iro7RjLzVA9GHBWd5OXHC5weldlow/YjZ2+qlu6hkWwAN+gaccC
	skZnZ4Ayjj1TmTjj8xhWK0UcmmACOduhykgi4NRXj7uepLNRtQwQbL4eqSaRem//zkK+7s2aQ==
X-Received: by 2002:a05:6a00:4c8f:b0:84f:5cd7:e3c6 with SMTP id d2e1a72fcca58-861662d4ce4mr18597533b3a.5.1788623715142;
        Sat, 05 Sep 2026 08:55:15 -0700 (PDT)
Received: from lima-arm64-dev.hitronhub.home (180-176-144-38.dynamic.kbronet.com.tw. [180.176.144.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455448d54sm2101674a12.17.2026.09.05.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:55:14 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harry Hsu <x90613@gmail.com>
Subject: [PATCH] selftests/livepatch: Test rejection of aliased symbols in one object
Date: Sat,  5 Sep 2026 23:55:07 +0800
Message-ID: <20260905155507.273262-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830173343.52759-1-x90613@gmail.com>
References: <20260830173343.52759-1-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp_init_object_loaded() now rejects an object whose klp_funcs resolve to
the same address, because aliased symbols would push two klp_funcs of one
livepatch onto a single ops->func_stack and leave the redirection
ambiguous.

Add a target module providing test_klp_alias_show() together with its
__alias() sibling, and a livepatch naming both of them.  Two test cases
cover both callers of klp_init_object_loaded(): the klp_enable_patch()
path, where the target module is loaded before the livepatch, and the
klp_module_coming() path, where the livepatch is loaded first and the
module loader has to refuse the target module.

Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: Harry Hsu <x90613@gmail.com>
---
This is the selftest I promised in the v2 thread [1].

It applies on top of patch 1/3 of the series [2] and does not touch the
rest of it.  Petr, since you are going to post v4 of the whole patchset
anyway, please feel free to fold this in as the last patch.  Otherwise I
am happy to resend it as a separate follow-up once the series lands --
whichever is less work for you.

Tested on arm64 with CONFIG_LIVEPATCH=y:

  # ./test-alias.sh
  TEST: livepatch of two aliased symbols in one object ... ok
  TEST: aliased symbols in a module coming after the livepatch ... ok

[1] https://lore.kernel.org/all/CAPhsuW70RpkZ1ciioSjt6qkQePWyeic_L+98d0h-Ao3ze-TmkA@mail.gmail.com/
[2] https://lore.kernel.org/all/20260830173343.52759-1-x90613@gmail.com/

 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/test-alias.sh | 81 +++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  4 +-
 .../test_modules/test_klp_alias_patch.c       | 62 ++++++++++++++
 .../test_modules/test_klp_alias_target.c      | 48 +++++++++++
 5 files changed, 196 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-alias.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215..ddbeff4cb53d 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	test-ftrace.sh \
 	test-sysfs.sh \
 	test-syscall.sh \
-	test-kprobe.sh
+	test-kprobe.sh \
+	test-alias.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-alias.sh b/tools/testing/selftests/livepatch/test-alias.sh
new file mode 100755
index 000000000000..4ae701de0dbf
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-alias.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Harry Hsu <x90613@gmail.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_TARGET=test_klp_alias_target
+MOD_LIVEPATCH=test_klp_alias_patch
+
+setup_config
+
+
+# $MOD_TARGET provides two symbols that share a single address.  A
+# livepatch naming both of them would push two klp_funcs of the same
+# patch onto one ops->func_stack, leaving the redirection ambiguous, so
+# klp_init_object_loaded() has to reject the object.
+#
+# - load the target module and verify it produces the original output
+# - verify that a livepatch naming both aliases fails to load
+# - verify that the target module has been left unpatched
+
+start_test "livepatch of two aliased symbols in one object"
+
+load_mod $MOD_TARGET
+
+if [[ "$(cat /proc/$MOD_TARGET)" != "$MOD_TARGET: original output" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+load_failing_mod $MOD_LIVEPATCH
+
+if [[ "$(cat /proc/$MOD_TARGET)" != "$MOD_TARGET: original output" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+unload_mod $MOD_TARGET
+
+check_result "% insmod test_modules/$MOD_TARGET.ko
+$MOD_TARGET: ${MOD_TARGET}_init
+% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: 'test_klp_alias_show' and 'test_klp_alias_show_alias' resolve to the same address, aliased symbols are not supported
+insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Invalid parameters
+% rmmod $MOD_TARGET
+$MOD_TARGET: ${MOD_TARGET}_exit"
+
+
+# The same object is initialized from klp_module_coming() when the
+# livepatch is loaded while the target module is still absent.  There
+# the error has to be propagated to the module loader instead.
+#
+# - load the livepatch, it is accepted because the object is not loaded
+# - verify that loading the target module is refused afterwards
+
+start_test "aliased symbols in a module coming after the livepatch"
+
+load_lp $MOD_LIVEPATCH
+load_failing_mod $MOD_TARGET
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% insmod test_modules/$MOD_TARGET.ko
+livepatch: 'test_klp_alias_show' and 'test_klp_alias_show_alias' resolve to the same address, aliased symbols are not supported
+livepatch: failed to initialize patch '$MOD_LIVEPATCH' for module '$MOD_TARGET' (-22)
+livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
+insmod: ERROR: could not insert module test_modules/$MOD_TARGET.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a13d398585dc..532403e2b5ff 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -1,7 +1,9 @@
 TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
 KDIR ?= /lib/modules/$(shell uname -r)/build
 
-obj-m += test_klp_atomic_replace.o \
+obj-m += test_klp_alias_patch.o \
+	test_klp_alias_target.o \
+	test_klp_atomic_replace.o \
 	test_klp_callbacks_busy.o \
 	test_klp_callbacks_demo.o \
 	test_klp_callbacks_demo2.o \
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c
new file mode 100644
index 000000000000..1b50088bc92d
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Harry Hsu <x90613@gmail.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+#include <linux/seq_file.h>
+
+static int livepatch_alias_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
+		   "this has been live patched");
+	return 0;
+}
+
+/*
+ * Both names resolve to one address, so they end up on a single
+ * ops->func_stack and the redirection would be ambiguous.  Loading this
+ * livepatch is expected to fail.
+ */
+static struct klp_func funcs[] = {
+	{
+		.old_name = "test_klp_alias_show",
+		.new_func = livepatch_alias_show,
+	},
+	{
+		.old_name = "test_klp_alias_show_alias",
+		.new_func = livepatch_alias_show,
+	},
+	{},
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = "test_klp_alias_target",
+		.funcs = funcs,
+	},
+	{},
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_alias_patch_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_alias_patch_exit(void)
+{
+}
+
+module_init(test_klp_alias_patch_init);
+module_exit(test_klp_alias_patch_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Harry Hsu <x90613@gmail.com>");
+MODULE_DESCRIPTION("Livepatch test: patch two aliased symbols of one object");
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c b/tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c
new file mode 100644
index 000000000000..b0f5fc35adf8
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Harry Hsu <x90613@gmail.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+static struct proc_dir_entry *pde;
+
+static noinline int test_klp_alias_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name, "original output");
+	return 0;
+}
+
+/*
+ * Alias the function above so that both names resolve to one address, the
+ * way __do_sys_fork(), __ia32_sys_fork() and __x64_sys_fork() do in vmlinux.
+ * Nothing calls the alias, it only has to show up in the module's symbol
+ * table for the livepatch to name it.
+ */
+static int test_klp_alias_show_alias(struct seq_file *m, void *v)
+	__used __alias(test_klp_alias_show);
+
+static int test_klp_alias_target_init(void)
+{
+	pr_info("%s\n", __func__);
+	pde = proc_create_single("test_klp_alias_target", 0, NULL,
+				 test_klp_alias_show);
+	if (!pde)
+		return -ENOMEM;
+	return 0;
+}
+
+static void test_klp_alias_target_exit(void)
+{
+	pr_info("%s\n", __func__);
+	proc_remove(pde);
+}
+
+module_init(test_klp_alias_target_init);
+module_exit(test_klp_alias_target_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Harry Hsu <x90613@gmail.com>");
+MODULE_DESCRIPTION("Livepatch test: target module with two aliased symbols");
-- 
2.43.0

