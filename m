Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088092F39C2
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542082; cv=none; b=GYfEuEgnEuF39re8UHtf1JunIC9/8iy5tD/CTprKJg+w+30Ndr8LZonq+ck3erzel8HDnUGJbCHGkO32UvSZUQQnFwjKSrY24uJN5PWyv3V1CLk/OKUj7RB4eEFxQPp5lCML8ctSrTEn0MGDelhKkMA+GKFGxojyoTu8sMHoB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542082; c=relaxed/simple;
	bh=KxpzzI4SQnPvl7cl/haBHv+As6zlSxSDdkqfr9kVNdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXOyt2hfoNsPvntXICn9p536u8JmURmkHckL07tRxKlc8xvafO1HvB5uwrLApKQEFiWvTlb/stwmW3mCQcKl7km59b/jfqrU+ZHdTfLsr/D88uG6ZImUSgJGRbY95NiruRD3C+7+M4yoz8DXQnlNg+OjdHJpWfXGtkL9uIuZvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN+9Od2s; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN+9Od2s"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3278296a91.0
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542080; x=1788146880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAnng/GwWEqtgFivgcA9XIjWS0NWeWt3Qm2TCfjnUpM=;
        b=YN+9Od2sBMv5uolwOEfRf+HKvLmoZmcEqSEZuGcVeWAAivqXjKB5UbgiAPLoOEU4sf
         o1+DmdQyMYv0oGppJU8RBUi8ZqkJgZCsbw1OT44HFWQCaskQcy42jzwVbpxOwxEsLhEE
         QJDsv/EqHyag4+0hIVnSYwKaZCjiUvtA+jemK7svyWFUMXpNpwUOjY2SEW3lJLbFXZZp
         Abyk2zUdT6QLZCI3T/bcVghqh4nI+7rKrWqfaHSFyG7PyzcL0qehaLounV1O0FkRJLGF
         v31MSvcLw35ePVZ6n8SCKVEI3C/9th/pXzPAWSzW8mos8t8zkF0T/JKsaaQva0tJ5OmU
         sTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542080; x=1788146880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAnng/GwWEqtgFivgcA9XIjWS0NWeWt3Qm2TCfjnUpM=;
        b=Ui/IVN0NLjA2c06muwgh+PhkG2zWesRV8f84Ec5fWL8o/3+LSsUVEYHE69MWow2+vQ
         0CgYIGGIuaKZ6IKc/jTzDWmPvMCUG8xVZ40h9y0unVqopRER4wqdO0Qli9scmqY46lwq
         NymH1VUjZacv7UHhUz/E0DIqBJy/1u6uWPsVMdMhDYCuQ1I3yZ8ZnV8gMk99cRIwQVy6
         5DoRTOCcsd/wP2uNCFEvJgxBG0lTZcTNI46dFWtX3PDqriAahFl+RGQOIpauutg+O4Dl
         HOEYc1oqH8sSNEY4Pwwf0ZOUmgPN3846wAD/CSDXaXCK4qBxVZSobH8Y0FXHDWF3vNj1
         itCA==
X-Gm-Message-State: AFuF++lXJtVTLC8tBOQ6C0yHngTMcAVZxvuU0CNr79OyqaQep5Z0OYBp
	8PJwIKZv0eyH+QWE3LY2k3e6dxCEgb73+gbVFbewZSLIM2AzHeO5hDI+
X-Gm-Gg: AR+sD11TjP79eDRE7PpEBbBsVEcJMk1sV9AZAcPSGGDj0smWiCG0oMGEBnlSMXwvXin
	0d0R848QsEoljvBut4DJeCvMSC+gdzsK+/Za/GRAdhcjAjzPKPsQNXtB/pCDl+Q0rcIMFw4aHtq
	84+EA8SeaacUs8M8mx48QwnoM5LoK67KdEOGAWIunfaT/fpue5/5lGArTBOxphW+IRdsNBaMSpQ
	tZaSWt4B6EE7W4DFxebf7ZrK8NeKBc048GihEkNR285gdedyfrzpyYGxOMuUaHo5uuQFC2RDaTR
	3wAINpGSJeo7jH7FoPlJXgkI01mt2R2iL0SCxYt+OjVvqugZb/1ccj9ty+N8FffcKeH9ZUp/PHM
	hSJw2GQkM4SvE9lNJeR8fXPgtDRyLLTrM4IsbjFOR0ClhKrohwtcE3kMbFCl5HdNJhq/v1Nu/71
	u7jLDgYR4qgxpcxVsSdNTPm/BqKax770TpZ8FB1ACMEcHit0I+YXmzbs0tAl3wfBTZ+8RVuKr7b
	a2KQaIE95cWevn+8IBrp0ccviiqKqNTxIfs4B+ZB40=
X-Received: by 2002:a17:90b:4f91:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-395c33a6e92mr39214895a91.6.1787542080157;
        Sun, 23 Aug 2026 20:28:00 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.27.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:27:59 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 5/8] selftests: livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Mon, 24 Aug 2026 11:27:29 +0800
Message-ID: <20260824032732.56686-6-laoar.shao@gmail.com>
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

The legacy "replace" field in struct klp_patch was replaced by the
provides/obsoletes mechanism. As a result, the atomic replace
selftests fail to build against kernels that only support
provides/obsoletes.

Adapt the selftests so that they build and run on both old and new
kernels:

- test_modules/Makefile detects whether the kernel header still
  declares the "replace" field. If so, it passes KLP_HAS_REPLACE to
  the modules via ccflags-y.

- test_klp_atomic_replace.c and other source files using .replace guard
  their replace module parameter and .replace assignment with
  #ifdef KLP_HAS_REPLACE. The #else branches are left as TODO
  placeholders for the upcoming provides/obsoletes based tests.

- functions.sh adds detect_replace_attr(), which loads a temporary
  livepatch and checks for the /sys/kernel/livepatch/<patch>/replace
  attribute, setting HAS_REPLACE_ATTR accordingly.

- test-livepatch.sh and test-callbacks.sh run the tests that depend
  on multiple livepatches coexisting or on the atomic replace
  behavior ("multiple livepatches" and "atomic replace") only when
  HAS_REPLACE_ATTR is set. These scenarios do not apply to the new
  kernel, where provides=0 replaces any other livepatch by default.

The provides/obsoletes based selftests will be added later.

Assisted-by: Comagic:DeepSeek-V4-Flash
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/livepatch/functions.sh   | 15 +++++++++++++++
 .../selftests/livepatch/test-callbacks.sh        |  6 ++++++
 .../selftests/livepatch/test-livepatch.sh        |  6 ++++++
 .../selftests/livepatch/test_modules/Makefile    | 14 ++++++++++++++
 .../test_modules/test_klp_atomic_replace.c       | 16 ++++++++++++++++
 .../test_modules/test_klp_callbacks_demo2.c      | 16 ++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c      |  7 +++++++
 .../livepatch/test_modules/test_klp_state2.c     |  7 +++++++
 8 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 1eba371f9d4d..5e6ed57c3df2 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -357,6 +357,21 @@ function does_sysfs_exist() {
 	[[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
 }
 
+# detect_replace_attr() - detect whether the running kernel still exposes
+# the legacy "replace" sysfs attribute and set HAS_REPLACE_ATTR
+# accordingly. The atomic replace tests are only run when the attribute
+# is present. The provides/obsoletes based tests will be added later.
+function detect_replace_attr() {
+	HAS_REPLACE_ATTR=0
+
+	load_lp test_klp_livepatch
+	if does_sysfs_exist test_klp_livepatch "replace"; then
+		HAS_REPLACE_ATTR=1
+	fi
+	disable_lp test_klp_livepatch
+	unload_lp test_klp_livepatch
+}
+
 # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
 # path permissions
 #	modname - livepatch module creating the sysfs interface
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 2a03deb26a12..e9b2dc6ea099 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -11,6 +11,8 @@ MOD_TARGET_BUSY=test_klp_callbacks_busy
 
 setup_config
 
+detect_replace_attr
+
 
 # Test a combination of loading a kernel module and a livepatch that
 # patches a function in the first module.  Load the target module
@@ -451,6 +453,7 @@ $MOD_TARGET_BUSY: busymod_work_func exit
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
+if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
 # Test loading multiple livepatches.  This test-case is mainly for comparing
 # with the next test-case.
 #
@@ -499,8 +502,10 @@ $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH"
+fi
 
 
+if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
 # Load multiple livepatches, but the second as an 'atomic-replace'
 # patch.  When the latter loads, the original livepatch should be
 # disabled and *none* of its pre/post-unpatch callbacks executed.  On
@@ -548,6 +553,7 @@ $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH"
+fi
 
 
 exit 0
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index c44c5341a2f1..b3b7cd81e3d0 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -13,6 +13,8 @@ MOD_TARGET_PATCH=test_klp_mod_patch
 
 setup_config
 
+detect_replace_attr
+
 
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
@@ -49,6 +51,7 @@ livepatch: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
 
 
+if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - load another livepatch and verify that both livepatches are active
@@ -107,8 +110,10 @@ livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
+fi
 
 
+if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - load two additional livepatches and check the number of livepatch modules
@@ -196,6 +201,7 @@ livepatch: '$MOD_REPLACE': starting unpatching transition
 livepatch: '$MOD_REPLACE': completing unpatching transition
 livepatch: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE"
+fi
 
 
 # - load a target module that provides /proc/test_klp_mod_target with
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a13d398585dc..a4fe469a6501 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -16,6 +16,20 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state3.o \
 	test_klp_syscall.o
 
+# The legacy "replace" field was replaced by provides/obsoletes. When the
+# kernel (KDIR) still supports "replace", pass KLP_HAS_REPLACE to the
+# modules so that they can #ifdef the legacy "replace" code. Otherwise
+# the modules are built with the provides/obsoletes based code (to be
+# added later).
+KLP_SRC := $(if $(wildcard $(srctree)/include/linux/livepatch.h), \
+		 $(srctree), $(KDIR))
+KLP_HAS_REPLACE := $(shell grep -q 'bool replace' \
+		 $(KLP_SRC)/include/linux/livepatch.h 2>/dev/null \
+		 && echo y)
+ifeq ($(KLP_HAS_REPLACE),y)
+ccflags-y += -DKLP_HAS_REPLACE
+endif
+
 # Ensure that KDIR exists, otherwise skip the compilation
 modules:
 ifneq ("$(wildcard $(KDIR))", "")
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
index 5af7093ca00c..4b3ed17886e7 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
@@ -7,9 +7,16 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifdef KLP_HAS_REPLACE
 static int replace;
 module_param(replace, int, 0644);
 MODULE_PARM_DESC(replace, "replace (default=0)");
+#else
+/*
+ * TODO: Add provides/obsoletes module parameters for the
+ * provides/obsoletes based tests (to be added later).
+ */
+#endif
 
 #include <linux/seq_file.h>
 static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
@@ -36,12 +43,21 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
+#ifdef KLP_HAS_REPLACE
 	/* set .replace in the init function below for demo purposes */
+#endif
 };
 
 static int test_klp_atomic_replace_init(void)
 {
+#ifdef KLP_HAS_REPLACE
 	patch.replace = replace;
+#else
+	/*
+	 * TODO: Set provides/obsoletes from the module parameters
+	 * for the provides/obsoletes based tests (to be added later).
+	 */
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573e80af..135da6d4d882 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -7,9 +7,16 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifdef KLP_HAS_REPLACE
 static int replace;
 module_param(replace, int, 0644);
 MODULE_PARM_DESC(replace, "replace (default=0)");
+#else
+/*
+ * TODO: Add provides/obsoletes module parameters for the
+ * provides/obsoletes based tests (to be added later).
+ */
+#endif
 
 static const char *const module_state[] = {
 	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
@@ -72,12 +79,21 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
+#ifdef KLP_HAS_REPLACE
 	/* set .replace in the init function below for demo purposes */
+#endif
 };
 
 static int test_klp_callbacks_demo2_init(void)
 {
+#ifdef KLP_HAS_REPLACE
 	patch.replace = replace;
+#else
+	/*
+	 * TODO: Set provides/obsoletes from the module parameters
+	 * for the provides/obsoletes based tests (to be added later).
+	 */
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 57a4253acb01..3492472e5d07 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -142,7 +142,14 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
+#ifdef KLP_HAS_REPLACE
 	.replace = true,
+#else
+/*
+ * TODO: Add provides/obsoletes module parameters for the
+ * provides/obsoletes based tests (to be added later).
+ */
+#endif
 };
 
 static int test_klp_callbacks_demo_init(void)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index c978ea4d5e67..8160b565a659 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -171,7 +171,14 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
+#ifdef KLP_HAS_REPLACE
 	.replace = true,
+#else
+/*
+ * TODO: Add provides/obsoletes module parameters for the
+ * provides/obsoletes based tests (to be added later).
+ */
+#endif
 };
 
 static int test_klp_callbacks_demo_init(void)
-- 
2.52.0

