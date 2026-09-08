Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76A533592
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869047; cv=none; b=fIGBfNhWJKTAvxVHiMAYhnByzI7IRVMY+1vqxgVNEHtquXJOq5FGr3ZOZ9N5ubhCR6o8rS3OEaWjt7i8pdA/krXC7K5ZKAX4UIgJU4bqNZUJQ7NvL4IrlCLW6LoyX9o08bkypzNPofxLiDDUfL//wlyvUKm1y/a7X4ZC+dQjiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869047; c=relaxed/simple;
	bh=cH9ZFlTTwBx6gTQvUA9o+bwd6zf5Ixzxuv5rrVI8jVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0eTkSO/H1jkby6bh6DyZ8I2z+WVJojX5JqyzwXjEaAMb4czGRPOyKJjBWs3FtUz7f4Gk1mqGzhKGs/kIUot4MTLnryo63UbzkPsrE5GL34z0w+cXv64stqQlANY/DWhmXKy/kAgGbpztbC38R9kNcKYuG0LxYEzXQnOvwbUH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aLnikJAc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aLnikJAc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4843f205a5bso2787471f8f.1
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788869040; x=1789473840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKgVI4X0gmbdB8ANT43nqIe9jOqilzM5WPOV0gw6+oU=;
        b=aLnikJAcHY11kthhbcKfItP7wJ+YUosCqdSM0yUxKVZtfK/8eY904fy+73rrxvK24u
         G6rj9T5qKZwTkZbCn3vpOwMCKIUp0U2VsDhzL6zPlOd2ABWtHYWlGqcQvpfDp8A99gDJ
         VJqOGGOhCiGbAl4HzGl4Q11vSTy5uGaJ/cr2O9t8eJ9gHkXhYVB1DLLwez4hlBMPAGfZ
         7bbGusncX7YD/VW174sW0hyxcn9f8+cxIgVCUnO2Zl9ZOFeuRynJGGvzzwQKjAAxz6r1
         hGGBAigOqSdG77+CKTFStQTNgOIze7o97CdKn/fRLqMs74EfnGbCpyXSD8PEkVJcXdge
         Or7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869040; x=1789473840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKgVI4X0gmbdB8ANT43nqIe9jOqilzM5WPOV0gw6+oU=;
        b=CrxpnokuJJ6hmNJDAlwc4B4pCe7gLIc3NjDuFZWTgraqkqvlJJs9tpWE2vFZ1su0Vu
         21xMrGB0e6j4WqxWSwDPWwVExy5mkApeqXQfLFhOD4tF0mnLnCuL1/fnt1wpCaQVFo+j
         xeHcZ4BxBj5DEUK0HVcycfXwznazeKsO9Dnhkw+6cjVsurZZwHuwl/jskgavWK9wvzhq
         OIHzGyqJLywdL7XLggCh2ENSrCm5cDdzgxqrNW/hwPxdEyiX2knIgoZmpiwY610+/oZ8
         zRwkO4DX6ih/erXT5VMX8aMI6uFuulLU/IUFy2x2mc5IfPP7dRQbKKp1zceyrDg9Ynzt
         I7/g==
X-Forwarded-Encrypted: i=1; AKwUvBzNzUtHFWV4zdD6IXHCeIdMbLwy5D4T5g5ENfxTWEMEZSniO0h/z7ieqVhx9+uks1WGISjKMCIFFm9GiXTc@vger.kernel.org
X-Gm-Message-State: AFuF++lsp2sx8xNsHGxRUdky4GSb1Rw+aS6ugUwyRu7Q1X126DGdjF8o
	Xq9xbNfz/kAg/dQNg+jgDyALVSpNu/tdgtXbEjsc/Sr9sOoADR/SbBLmDcqYCk6E5oY=
X-Gm-Gg: AYBFou0POzlPvchuFXmJRlklo1ibwea1hHbZw9oUHOK1lYU/WzOG1chJrh4VRKJg6PO
	8KIqwxa4pZHogcAYscMKh1iUJ0gwMTNRTJdbo5d1ZNniXwjIP48DfeGKdGlr87U5T4haIzxXoif
	dZ+pJsL2xdRClbBOaT2gKDejewGjQiaPIwzJnD3jhEBoLqZx55VlurejPvMTi/jOJfo9PbItQml
	BayW5Qc2vKSJzXXDP3k3x+GJi6zCbtk/22B0qUkyetzNF9njguZvAlhdWQ4fmuxoNyAv7Rq0N5l
	fmj2E2VMG0XtmYHiiM6aOtx8Q8ARsqK3qfzQGeTZscz4sCJIiAlkXf96rQ5hjIGAJk42tBuPFH9
	4sYKvQHBmrNothfgWgU3460BMWgIpTnNEkG9+aCVlPeAq8fi/k6hZgAPcbiNGOoIKBKW+lIav2v
	zTUK7sQZ0aSPS9Mih3Unawt26XeCGJkPjM1Z96GGwT1R4x6yXWB5A=
X-Received: by 2002:a05:6000:2505:b0:485:8ad5:f965 with SMTP id ffacd0b85a97d-4858ad5ff97mr28316709f8f.2.1788869040340;
        Tue, 08 Sep 2026 05:04:00 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm40354754f8f.25.2026.09.08.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:03:59 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	shuah@kernel.org,
	song@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] selftests/livepatch: Test rejection of aliased symbols in one object
Date: Tue,  8 Sep 2026 14:03:22 +0200
Message-ID: <20260908120325.299649-3-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908120325.299649-1-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harry Hsu <x90613@gmail.com>

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
2.55.0

