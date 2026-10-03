Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515635C6A7
	for <live-patching@vger.kernel.org>; Sat,  3 Oct 2026 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065084; cv=none; b=nITTCKrE39BzuivrwsaYlC4sy2mbq2JrHTGKz32EfxdJzfIfQHfCun0E/EGOW5sf7Cz58HRoI0h7fIVhzDlhhgnGyqc13GJZ74igLtDn8GabMvYQ9ji9IDPvcdVSqSRk02Ftt+cNS1JXp9Txl63P6MUIvOKJClb3qUOtdjUMP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065084; c=relaxed/simple;
	bh=FWaHWZB/f+11kiSB3xnJXtPW1a9usqXA6Vowe9cI8jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9t96gB8PI0glZo14vbwbXgOJJrdJbiMXuURAbt69WK9Rfqz/WZybWOPIJgoj9/O8wkLxMoJ/dpzhXg2t7LsH6irYb9UCw8psmgUXW8/kRal/ALT8pkpvFVf2sztZ3c4VEzvFIyF4I0WtwBy+wzRRxgojoVZFd2priXNiITCBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho6F6ehc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho6F6ehc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCFB1F0089B;
	Sat,  3 Oct 2026 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791065082;
	bh=ybIIwRZ+HLDRytmTWSmXoG+wVh3jYbKEM/DCp55DDE0=;
	h=From:To:Cc:Subject:Date;
	b=ho6F6ehcLNo36QfA71egmI30qjY/BRUNlNUWEJx9dIQXBzOMEsst+77blla/W1Slg
	 8kwY5x6fsHCVs4zyIVvkUhu3LqWiSaHkQ0LN88G9NUrqUR1arzrALGrUwB39E9MSkp
	 hX2xJw7I2Sx/GEnLk36jeCj2dYl6hkVAZ3Oek+DNgTc2rGAWEG+D/quFWFi1lS+l3l
	 AD4j1D9pw2VJsZXvpGe1g5S440n2dLIMqBIQNEgvqawo51apR/rUV0VkmoESQcVuKu
	 kPPsCvANbodUSLA/aFesK4YEaam9dvV/ziA+EZktmMk4vsrnUb4NX0C6zseHKLTMaw
	 bGZVhNPT5bIJQ==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	Song Liu <song@kernel.org>
Subject: [RFC] livepatch: Add integration tests for klp-build toolchain
Date: Sat,  3 Oct 2026 15:04:33 -0700
Message-ID: <20261003220433.1539629-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add integration tests for the klp-build toolchain. This includes kernel
side test code and .patch files. The tests cover both livepatch to vmlinux
and kernel modules.

The test target code lives in lib/livepatch/: klp_test_vmlinux.c and
klp_test_vmlinux_aux.c are built into vmlinux (CONFIG_KLP_TEST), while
klp_test_module.c builds as a loadable module (CONFIG_KLP_TEST_MODULE).
klp_test_vmlinux_aux.c carries its own static __helper() so that ThinLTO
.llvm.<hash> suffix handling is exercised.

klp-build rejects patches to anything under lib/.  The blanket rule is
there for two reasons: lib-y objects are archived into lib/lib.a and are
only linked into vmlinux when referenced, so a patched member may not end
up in the kernel at all; and several lib/ sources are compiled a second
time into images which can't be livepatched, such as purgatory, the boot
decompressor and the arm64/riscv early position-independent code.
lib/livepatch/ has neither property, it holds ordinary obj-y/obj-m test
code used by nothing else, so exempt it from the check.

Check tools/testing/selftests/livepatch/test_patches/README for
instructions to run these tests.

Signed-off-by: Song Liu <song@kernel.org>

---

This is a slightly changed version of [1]. The major change here to move is
to move the test target code to lib/livepatch.

Sending this again so that we can discuss this in the upcoming live
patching MC at LPC 2026

[1] https://lore.kernel.org/live-patching/20260226005436.379303-9-song@kernel.org/

Signed-off-by: Song Liu <song@kernel.org>
---
 MAINTAINERS                                   |   1 +
 kernel/livepatch/Kconfig                      |  20 +++
 lib/Makefile                                  |   1 +
 lib/livepatch/Makefile                        |   6 +
 lib/livepatch/klp_test_module.c               | 111 ++++++++++++++
 lib/livepatch/klp_test_module.h               |   8 +
 lib/livepatch/klp_test_vmlinux.c              | 138 ++++++++++++++++++
 lib/livepatch/klp_test_vmlinux.h              |  16 ++
 lib/livepatch/klp_test_vmlinux_aux.c          |  59 ++++++++
 scripts/livepatch/klp-build                   |  10 ++
 .../selftests/livepatch/test_patches/README   |  15 ++
 .../test_patches/klp_test_hash_change.patch   |  30 ++++
 .../test_patches/klp_test_module.patch        |  18 +++
 .../klp_test_nonstatic_to_static.patch        |  40 +++++
 .../klp_test_static_to_nonstatic.patch        |  39 +++++
 .../test_patches/klp_test_vmlinux.patch       |  18 +++
 16 files changed, 530 insertions(+)
 create mode 100644 lib/livepatch/Makefile
 create mode 100644 lib/livepatch/klp_test_module.c
 create mode 100644 lib/livepatch/klp_test_module.h
 create mode 100644 lib/livepatch/klp_test_vmlinux.c
 create mode 100644 lib/livepatch/klp_test_vmlinux.h
 create mode 100644 lib/livepatch/klp_test_vmlinux_aux.c
 create mode 100644 tools/testing/selftests/livepatch/test_patches/README
 create mode 100644 tools/testing/selftests/livepatch/test_patches/klp_test_hash_change.patch
 create mode 100644 tools/testing/selftests/livepatch/test_patches/klp_test_module.patch
 create mode 100644 tools/testing/selftests/livepatch/test_patches/klp_test_nonstatic_to_static.patch
 create mode 100644 tools/testing/selftests/livepatch/test_patches/klp_test_static_to_nonstatic.patch
 create mode 100644 tools/testing/selftests/livepatch/test_patches/klp_test_vmlinux.patch

diff --git a/MAINTAINERS b/MAINTAINERS
index 7235a92ff879..67d84812f043 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15169,6 +15169,7 @@ F:	arch/powerpc/include/asm/livepatch.h
 F:	include/linux/livepatch*.h
 F:	kernel/livepatch/
 F:	kernel/module/livepatch.c
+F:	lib/livepatch/
 F:	samples/livepatch/
 F:	scripts/livepatch/
 F:	tools/testing/selftests/livepatch/
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 4c0a9c18d0b2..48262246444c 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -30,3 +30,23 @@ config KLP_BUILD
 	select OBJTOOL
 	help
 	  Enable klp-build support
+
+config KLP_TEST
+	bool "Livepatch test code"
+	depends on LIVEPATCH
+	help
+	  Dummy kernel code for testing the klp-build livepatch toolchain.
+	  Provides built-in vmlinux functions with sysfs interfaces for
+	  verifying livepatches. The code lives in lib/livepatch/.
+
+	  If unsure, say N.
+
+config KLP_TEST_MODULE
+	tristate "Livepatch test module (klp_test_module)"
+	depends on KLP_TEST && m
+	help
+	  Test module for livepatch testing. Dummy kernel module for
+	  testing the klp-build toolchain. Provides sysfs interfaces for
+	  verifying livepatches.
+
+	  If unsure, say N.
diff --git a/lib/Makefile b/lib/Makefile
index dfab958327c5..03543b2fb8ba 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_REGION_ALLOC_BENCHMARK) += region_alloc_benchmark.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) += find_bit_benchmark_rust.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
+obj-$(CONFIG_KLP_TEST) += livepatch/
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
new file mode 100644
index 000000000000..7b2748c821d5
--- /dev/null
+++ b/lib/livepatch/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y				+= klp_test_vmlinux_all.o
+obj-$(CONFIG_KLP_TEST_MODULE)	+= klp_test_module.o
+
+klp_test_vmlinux_all-y := klp_test_vmlinux.o \
+			  klp_test_vmlinux_aux.o
diff --git a/lib/livepatch/klp_test_module.c b/lib/livepatch/klp_test_module.c
new file mode 100644
index 000000000000..25cefbe36a2b
--- /dev/null
+++ b/lib/livepatch/klp_test_module.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * klp_test_module.c - Single-file test module for livepatch/klp-build testing
+ *
+ * Copyright (C) 2026 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/string.h>
+#include "klp_test_module.h"
+#include "klp_test_vmlinux.h"
+
+static int klp_test_module_var1;
+static int klp_test_module_var2;
+
+static noinline ssize_t __klp_test_module_func1(char *buf, int len)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < len; i++)
+		klp_test_module_var1 += i;
+
+	if (klp_test_module_var1 > 1000)
+		klp_test_module_var1 = 0;
+
+	ret = sysfs_emit(buf, "klp_test_module_func1 unpatched %d\n",
+			 klp_test_module_var1);
+	return ret;
+}
+
+ssize_t klp_test_module_func1(char *buf, int len)
+{
+	return __klp_test_module_func1(buf, len);
+}
+EXPORT_SYMBOL_GPL(klp_test_module_func1);
+
+static noinline ssize_t __klp_test_module_func2(char *buf, int len)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < len; i++)
+		klp_test_module_var2 += i * 2;
+
+	if (klp_test_module_var2 > 1000)
+		klp_test_module_var2 = 0;
+
+	ret = sysfs_emit(buf, "klp_test_module_func2 unpatched %d\n",
+			 klp_test_module_var2);
+	return ret;
+}
+
+ssize_t klp_test_module_func2(char *buf, int len)
+{
+	return __klp_test_module_func2(buf, len);
+}
+EXPORT_SYMBOL_GPL(klp_test_module_func2);
+
+static ssize_t func1_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	return klp_test_module_func1(buf, 5);
+}
+
+static ssize_t func2_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	return klp_test_module_func2(buf, 5);
+}
+
+static struct kobj_attribute func1_attr = __ATTR_RO(func1);
+static struct kobj_attribute func2_attr = __ATTR_RO(func2);
+
+static struct attribute *klp_test_module_attrs[] = {
+	&func1_attr.attr,
+	&func2_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group klp_test_module_attr_group = {
+	.attrs = klp_test_module_attrs,
+};
+
+static struct kobject *klp_test_module_kobj;
+
+static int __init klp_test_module_init(void)
+{
+	klp_test_module_kobj = kobject_create_and_add("module",
+						      klp_test_kobj);
+	if (!klp_test_module_kobj)
+		return -ENOMEM;
+
+	return sysfs_create_group(klp_test_module_kobj,
+				  &klp_test_module_attr_group);
+}
+
+static void __exit klp_test_module_exit(void)
+{
+	sysfs_remove_group(klp_test_module_kobj, &klp_test_module_attr_group);
+	kobject_put(klp_test_module_kobj);
+}
+
+module_init(klp_test_module_init);
+module_exit(klp_test_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Livepatch single-file test module");
diff --git a/lib/livepatch/klp_test_module.h b/lib/livepatch/klp_test_module.h
new file mode 100644
index 000000000000..56a766f4744b
--- /dev/null
+++ b/lib/livepatch/klp_test_module.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _KLP_TEST_MODULE_H
+#define _KLP_TEST_MODULE_H
+
+ssize_t klp_test_module_func1(char *buf, int len);
+ssize_t klp_test_module_func2(char *buf, int len);
+
+#endif /* _KLP_TEST_MODULE_H */
diff --git a/lib/livepatch/klp_test_vmlinux.c b/lib/livepatch/klp_test_vmlinux.c
new file mode 100644
index 000000000000..bd4157ea97c0
--- /dev/null
+++ b/lib/livepatch/klp_test_vmlinux.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * klp_test_vmlinux.c - Dummy built-in code for livepatch/klp-build testing
+ *
+ * Copyright (C) 2026 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include "klp_test_vmlinux.h"
+
+static int klp_test_vmlinux_var1;
+static int klp_test_vmlinux_var2;
+
+static noinline int __helper(int x, int len)
+{
+	int i, sum = x;
+
+	for (i = 0; i < len; i++)
+		sum += i + 5;
+	if (sum > 1000)
+		sum = 0;
+	return sum;
+}
+
+static noinline ssize_t __klp_test_vmlinux_func1(char *buf, int len)
+{
+	ssize_t ret = 0;
+
+	klp_test_vmlinux_var1 = __helper(klp_test_vmlinux_var1, len);
+
+	ret = sysfs_emit(buf, "klp_test_vmlinux_func1 unpatched %d\n",
+			 klp_test_vmlinux_var1);
+	return ret;
+}
+
+ssize_t klp_test_vmlinux_func1(char *buf, int len)
+{
+	return __klp_test_vmlinux_func1(buf, len);
+}
+EXPORT_SYMBOL_GPL(klp_test_vmlinux_func1);
+
+static noinline ssize_t __klp_test_vmlinux_func2(char *buf, int len)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < len; i++)
+		klp_test_vmlinux_var2 += i * 2;
+
+	if (klp_test_vmlinux_var2 > 1000)
+		klp_test_vmlinux_var2 = 0;
+
+	ret = sysfs_emit(buf, "klp_test_vmlinux_func2 unpatched %d\n",
+			 klp_test_vmlinux_var2);
+	return ret;
+}
+
+ssize_t klp_test_vmlinux_func2(char *buf, int len)
+{
+	return __klp_test_vmlinux_func2(buf, len);
+}
+EXPORT_SYMBOL_GPL(klp_test_vmlinux_func2);
+
+static ssize_t vmlinux_func1_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return klp_test_vmlinux_func1(buf, 5);
+}
+
+static ssize_t vmlinux_func2_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return klp_test_vmlinux_func2(buf, 5);
+}
+
+static struct kobj_attribute vmlinux_func1_attr = __ATTR_RO(vmlinux_func1);
+static struct kobj_attribute vmlinux_func2_attr = __ATTR_RO(vmlinux_func2);
+
+static struct attribute *klp_test_attrs[] = {
+	&vmlinux_func1_attr.attr,
+	&vmlinux_func2_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group klp_test_attr_group = {
+	.attrs = klp_test_attrs,
+};
+
+static struct kobject *klp_test_vmlinux_kobj;
+struct kobject *klp_test_kobj;
+EXPORT_SYMBOL_GPL(klp_test_kobj);
+
+static int __init klp_test_vmlinux_init(void)
+{
+	int ret;
+
+	klp_test_kobj = kobject_create_and_add("klp_test", kernel_kobj);
+	if (!klp_test_kobj)
+		return -ENOMEM;
+
+	klp_test_vmlinux_kobj = kobject_create_and_add("vmlinux", klp_test_kobj);
+	if (!klp_test_vmlinux_kobj) {
+		kobject_put(klp_test_kobj);
+		return -ENOMEM;
+	}
+
+	ret = sysfs_create_group(klp_test_vmlinux_kobj, &klp_test_attr_group);
+	if (ret)
+		goto err_group;
+
+	ret = klp_test_vmlinux_aux_init(klp_test_vmlinux_kobj);
+	if (ret)
+		goto err_aux;
+
+	return 0;
+
+err_aux:
+	sysfs_remove_group(klp_test_vmlinux_kobj, &klp_test_attr_group);
+err_group:
+	kobject_put(klp_test_vmlinux_kobj);
+	kobject_put(klp_test_kobj);
+	return ret;
+}
+
+static void __exit klp_test_vmlinux_exit(void)
+{
+	klp_test_vmlinux_aux_exit(klp_test_vmlinux_kobj);
+	sysfs_remove_group(klp_test_vmlinux_kobj, &klp_test_attr_group);
+	kobject_put(klp_test_vmlinux_kobj);
+	kobject_put(klp_test_kobj);
+}
+
+late_initcall(klp_test_vmlinux_init);
diff --git a/lib/livepatch/klp_test_vmlinux.h b/lib/livepatch/klp_test_vmlinux.h
new file mode 100644
index 000000000000..56d9f7b6d350
--- /dev/null
+++ b/lib/livepatch/klp_test_vmlinux.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _KLP_TEST_VMLINUX_H
+#define _KLP_TEST_VMLINUX_H
+
+#include <linux/kobject.h>
+
+extern struct kobject *klp_test_kobj;
+
+ssize_t klp_test_vmlinux_func1(char *buf, int len);
+ssize_t klp_test_vmlinux_func2(char *buf, int len);
+ssize_t klp_test_vmlinux_func3(char *buf, int len);
+
+int klp_test_vmlinux_aux_init(struct kobject *parent);
+void klp_test_vmlinux_aux_exit(struct kobject *parent);
+
+#endif /* _KLP_TEST_VMLINUX_H */
diff --git a/lib/livepatch/klp_test_vmlinux_aux.c b/lib/livepatch/klp_test_vmlinux_aux.c
new file mode 100644
index 000000000000..1d76b0308a11
--- /dev/null
+++ b/lib/livepatch/klp_test_vmlinux_aux.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * klp_test_vmlinux_aux.c - Auxiliary built-in code for livepatch/klp-build
+ *                          testing. This file has its own static __helper()
+ *                          to test ThinLTO .llvm.<hash> suffix handling.
+ *
+ * Copyright (C) 2026 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/string.h>
+#include "klp_test_vmlinux.h"
+
+static int klp_test_vmlinux_var3;
+
+static noinline int __helper(int x, int len)
+{
+	int i, sum = x;
+
+	for (i = 0; i < len; i++)
+		sum += i + 10;
+	if (sum > 1000)
+		sum = 0;
+	return sum;
+}
+
+static noinline ssize_t __klp_test_vmlinux_func3(char *buf, int len)
+{
+	klp_test_vmlinux_var3 = __helper(klp_test_vmlinux_var3, len);
+
+	return sysfs_emit(buf, "klp_test_vmlinux_func3 unpatched %d\n",
+			 klp_test_vmlinux_var3);
+}
+
+ssize_t klp_test_vmlinux_func3(char *buf, int len)
+{
+	return __klp_test_vmlinux_func3(buf, len);
+}
+EXPORT_SYMBOL_GPL(klp_test_vmlinux_func3);
+
+static ssize_t vmlinux_func3_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return klp_test_vmlinux_func3(buf, 5);
+}
+
+static struct kobj_attribute vmlinux_func3_attr = __ATTR_RO(vmlinux_func3);
+
+int klp_test_vmlinux_aux_init(struct kobject *parent)
+{
+	return sysfs_create_file(parent, &vmlinux_func3_attr.attr);
+}
+
+void klp_test_vmlinux_aux_exit(struct kobject *parent)
+{
+	sysfs_remove_file(parent, &vmlinux_func3_attr.attr);
+}
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..cdb3a9489329 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -365,6 +365,16 @@ check_unsupported_patches() {
 
 		for file in "${files[@]}"; do
 			case "$file" in
+				# lib/ is unsupported in general: lib-y objects
+				# are archived into lib/lib.a and only linked
+				# into vmlinux when referenced, and several
+				# lib/ sources are compiled a second time into
+				# images which can't be livepatched (purgatory,
+				# the boot decompressor, early PI code).
+				# lib/livepatch/ has neither property, it's
+				# ordinary obj-y/obj-m klp-build test code.
+				lib/livepatch/*)
+					;;
 				lib/*|*/vdso/*|*/realmode/rm/*|*.S)
 					die "${patch}: unsupported patch to $file"
 					;;
diff --git a/tools/testing/selftests/livepatch/test_patches/README b/tools/testing/selftests/livepatch/test_patches/README
new file mode 100644
index 000000000000..3c880f28d852
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_patches/README
@@ -0,0 +1,15 @@
+This is folder contains patches to test the klp-build toolchain.
+
+To run the test:
+
+1. Enable CONFIG_KLP_TEST and CONFIG_KLP_TEST_MODULE, and build the kernel.
+
+2. Build these patches with:
+
+  ./scripts/livepatch/klp-build tools/testing/selftests/livepatch/test_patches/*.patch
+
+3. Verify the correctness with:
+
+  modprobe klp_test_module
+  insmod livepatch-patch.ko
+  grep -q unpatched /sys/kernel/klp_test/*/* && echo FAIL || echo PASS
diff --git a/tools/testing/selftests/livepatch/test_patches/klp_test_hash_change.patch b/tools/testing/selftests/livepatch/test_patches/klp_test_hash_change.patch
new file mode 100644
index 000000000000..73420377f0e7
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_patches/klp_test_hash_change.patch
@@ -0,0 +1,30 @@
+Test ThinLTO .llvm.<hash> suffix handling.
+
+Modify a static __helper() function whose body change causes its
+.llvm.<hash> suffix to change under ThinLTO. Both klp_test_vmlinux.c
+and klp_test_vmlinux_aux.c define static __helper() with different
+bodies, so ThinLTO promotes both to globals with different hashes.
+This patch changes the __helper() in the aux file, which changes its
+hash, and klp-build must correctly match the old and new symbols.
+
+diff --git i/lib/livepatch/klp_test_vmlinux_aux.c w/lib/livepatch/klp_test_vmlinux_aux.c
+--- i/lib/livepatch/klp_test_vmlinux_aux.c
++++ w/lib/livepatch/klp_test_vmlinux_aux.c
+@@ -20,7 +20,7 @@
+ 	int i, sum = x;
+ 
+ 	for (i = 0; i < len; i++)
+-		sum += i + 10;
++		sum += i * 2 + 10;
+ 	if (sum > 1000)
+ 		sum = 0;
+ 	return sum;
+@@ -30,7 +30,7 @@
+ {
+ 	klp_test_vmlinux_var3 = __helper(klp_test_vmlinux_var3, len);
+ 
+-	return sysfs_emit(buf, "klp_test_vmlinux_func3 unpatched %d\n",
++	return sysfs_emit(buf, "klp_test_vmlinux_func3 hash_patched %d\n",
+ 			 klp_test_vmlinux_var3);
+ }
+ 
diff --git a/tools/testing/selftests/livepatch/test_patches/klp_test_module.patch b/tools/testing/selftests/livepatch/test_patches/klp_test_module.patch
new file mode 100644
index 000000000000..fae1400b063a
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_patches/klp_test_module.patch
@@ -0,0 +1,18 @@
+Test basic module patching.
+
+Patch a loadable module function to verify that klp-build can generate
+a livepatch for module code. Changes __klp_test_module_func1() output
+from "unpatched" to "patched".
+
+diff --git i/lib/livepatch/klp_test_module.c w/lib/livepatch/klp_test_module.c
+--- i/lib/livepatch/klp_test_module.c
++++ w/lib/livepatch/klp_test_module.c
+@@ -27,7 +27,7 @@
+ 	if (klp_test_module_var1 > 1000)
+ 		klp_test_module_var1 = 0;
+ 
+-	ret = sysfs_emit(buf, "klp_test_module_func1 unpatched %d\n",
++	ret = sysfs_emit(buf, "klp_test_module_func1 patched %d\n",
+ 			 klp_test_module_var1);
+ 	return ret;
+ }
diff --git a/tools/testing/selftests/livepatch/test_patches/klp_test_nonstatic_to_static.patch b/tools/testing/selftests/livepatch/test_patches/klp_test_nonstatic_to_static.patch
new file mode 100644
index 000000000000..112c93c50e6e
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_patches/klp_test_nonstatic_to_static.patch
@@ -0,0 +1,40 @@
+Test nonstatic-to-static symbol change.
+
+Change klp_test_module_func2() from nonstatic (global) to static and
+remove its EXPORT_SYMBOL_GPL. Also remove its declaration from the
+header file. This tests klp-build's ability to handle symbol visibility
+changes where a function that was originally global becomes static in
+the patched kernel.
+
+diff --git i/lib/livepatch/klp_test_module.c w/lib/livepatch/klp_test_module.c
+--- i/lib/livepatch/klp_test_module.c
++++ w/lib/livepatch/klp_test_module.c
+@@ -49,16 +49,15 @@
+ 	if (klp_test_module_var2 > 1000)
+ 		klp_test_module_var2 = 0;
+
+-	ret = sysfs_emit(buf, "klp_test_module_func2 unpatched %d\n",
++	ret = sysfs_emit(buf, "klp_test_module_func2 patched_nts %d\n",
+ 			 klp_test_module_var2);
+ 	return ret;
+ }
+
+-ssize_t klp_test_module_func2(char *buf, int len)
++static noinline ssize_t klp_test_module_func2(char *buf, int len)
+ {
+ 	return __klp_test_module_func2(buf, len);
+ }
+-EXPORT_SYMBOL_GPL(klp_test_module_func2);
+
+ static ssize_t func1_show(struct kobject *kobj,
+ 			   struct kobj_attribute *attr, char *buf)
+diff --git i/lib/livepatch/klp_test_module.h w/lib/livepatch/klp_test_module.h
+--- i/lib/livepatch/klp_test_module.h
++++ w/lib/livepatch/klp_test_module.h
+@@ -3,6 +3,5 @@
+ #define _KLP_TEST_MODULE_H
+
+ ssize_t klp_test_module_func1(char *buf, int len);
+-ssize_t klp_test_module_func2(char *buf, int len);
+
+ #endif /* _KLP_TEST_MODULE_H */
diff --git a/tools/testing/selftests/livepatch/test_patches/klp_test_static_to_nonstatic.patch b/tools/testing/selftests/livepatch/test_patches/klp_test_static_to_nonstatic.patch
new file mode 100644
index 000000000000..357c9c98189d
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_patches/klp_test_static_to_nonstatic.patch
@@ -0,0 +1,39 @@
+Test static-to-nonstatic symbol change.
+
+Change __klp_test_vmlinux_func2() from static to nonstatic (global).
+This tests klp-build's ability to handle symbol visibility changes
+where a function that was originally static becomes globally visible
+in the patched kernel.
+
+diff --git i/lib/livepatch/klp_test_vmlinux.c w/lib/livepatch/klp_test_vmlinux.c
+--- i/lib/livepatch/klp_test_vmlinux.c
++++ w/lib/livepatch/klp_test_vmlinux.c
+@@ -44,7 +44,7 @@
+ }
+ EXPORT_SYMBOL_GPL(klp_test_vmlinux_func1);
+
+-static noinline ssize_t __klp_test_vmlinux_func2(char *buf, int len)
++noinline ssize_t __klp_test_vmlinux_func2(char *buf, int len)
+ {
+ 	ssize_t ret = 0;
+ 	int i;
+@@ -55,7 +55,7 @@
+ 	if (klp_test_vmlinux_var2 > 1000)
+ 		klp_test_vmlinux_var2 = 0;
+
+-	ret = sysfs_emit(buf, "klp_test_vmlinux_func2 unpatched %d\n",
++	ret = sysfs_emit(buf, "klp_test_vmlinux_func2 patched_stn %d\n",
+ 			 klp_test_vmlinux_var2);
+ 	return ret;
+ }
+diff --git i/lib/livepatch/klp_test_vmlinux.h w/lib/livepatch/klp_test_vmlinux.h
+--- i/lib/livepatch/klp_test_vmlinux.h
++++ w/lib/livepatch/klp_test_vmlinux.h
+@@ -9,6 +9,7 @@
+ ssize_t klp_test_vmlinux_func1(char *buf, int len);
+ ssize_t klp_test_vmlinux_func2(char *buf, int len);
+ ssize_t klp_test_vmlinux_func3(char *buf, int len);
++ssize_t __klp_test_vmlinux_func2(char *buf, int len);
+
+ int klp_test_vmlinux_aux_init(struct kobject *parent);
+ void klp_test_vmlinux_aux_exit(struct kobject *parent);
diff --git a/tools/testing/selftests/livepatch/test_patches/klp_test_vmlinux.patch b/tools/testing/selftests/livepatch/test_patches/klp_test_vmlinux.patch
new file mode 100644
index 000000000000..ded12e0dade1
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_patches/klp_test_vmlinux.patch
@@ -0,0 +1,18 @@
+Test basic vmlinux patching.
+
+Patch a built-in vmlinux function to verify that klp-build can generate
+a livepatch for vmlinux code. Changes __klp_test_vmlinux_func1() output
+from "unpatched" to "patched".
+
+diff --git i/lib/livepatch/klp_test_vmlinux.c w/lib/livepatch/klp_test_vmlinux.c
+--- i/lib/livepatch/klp_test_vmlinux.c
++++ w/lib/livepatch/klp_test_vmlinux.c
+@@ -33,7 +33,7 @@
+ 
+ 	klp_test_vmlinux_var1 = __helper(klp_test_vmlinux_var1, len);
+ 
+-	ret = sysfs_emit(buf, "klp_test_vmlinux_func1 unpatched %d\n",
++	ret = sysfs_emit(buf, "klp_test_vmlinux_func1 patched %d\n",
+ 			 klp_test_vmlinux_var1);
+ 	return ret;
+ }
-- 
2.53.0-Meta

