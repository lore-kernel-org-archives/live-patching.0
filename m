Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD27386424
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658447; cv=none; b=evE3W3QtfM0dzI1txP111JCFIUP5zTOX5CRA4YINIily/qIATb6c21K/pPf3eN0dSxM2mzmHo30M1ErIE6Ch+1os/7+iAYTzf0sm5iHK73hmc+kFpQIXRSvcsFfdfTNwKrBPp5Nqet8z71l1CcYe/Pe1eAGA759XQKc8tI2sBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658447; c=relaxed/simple;
	bh=w7JSStcfgDqaV4Tr76myIpBcuBymwfSn8nopkxbCqtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mro+oKNPv8zlfVBkgIYKD6Y5CVOp5lrHlJlssN8yFOHJ2DOIbQ23f1Ca2/dea31qnr0TZpZCEOOp3v1fC/vcn9mth1Wc/AXdy7rVc/7r/Q6vc/hS+Y58WL9k9EEVNmFodrAzy3B2LK0F8zKks0aeHlfIwmDouyRuSlUC9dYd1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egiT/H/q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egiT/H/q"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso3410452a12.2
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658445; x=1788263245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBKqD2PckBNK1I4NC8foeC9557dpGRTQjx0VTVADAs4=;
        b=egiT/H/qYZmrV7Nqk1RcsiJx7OaAxOx+5AxpMmzmzK0XRK2fkBpYGOQHDcK2a9NE/0
         hIV3lBxF2EDu41Lf+vU5436kTGKPRRvhh2pT4TcrcPXILvXxrBdY2MXhpaIJHJDMFD27
         b9ASgX+t/niqOya4SpGdj80N5ag6OD1LTB2eSUqgXltpC2vsTo8a89XqI9h68QhPuNtb
         UIek55DvKBSdEhR1oW61w2akaSGxQD07TJf309QR7uPVAq95NEDn50NnChO5LbUbZIKI
         69fuYPY14Cjbx3U5ttmwfXnzSP+/Okffb/2OU/6MDs+6f5MdcpJ0SrFhV3kG886o0WjQ
         3axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658445; x=1788263245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBKqD2PckBNK1I4NC8foeC9557dpGRTQjx0VTVADAs4=;
        b=qASU013wbpNL6watEwHX0lVokYrPIpMfYWckNA3WZ3RRtVcSaJ0qETL5RlfOTKFu69
         tZKcbJ3srOrVbOAoIuh3vvmOOFZrvMFk4pWBu1wi9LNOoqvpcsM+pXDYhKzfmxxn/WMR
         sNGq0WQKdte0gwL9YGkyF0z+MjoLS1zaiDqZgA5P24d3TNEnq5rOgyw7tSVxPjTzK46R
         CFO04g+ZI2tvLPsSDDM/mK/D/cdArAYnLHs4uX3miSLzeH/4NSxpBnsYhR5Er72zUrF5
         Ua0BmDaIZgDaC+jGt4IxNDOsHDdAiQ14P9U0c/DYidwh+sEHPHZ2HCA0qwnexRb3UuyW
         IQLw==
X-Gm-Message-State: AFuF++kNZEw560M9llfzMfAJqV4ZCiT4hZj7fnsRum/6tWMK/GE3Q6ZT
	S64khFWzzRgr7Y0LjHHGqhcJgPw4Yfo7b9nYJadnO6jmlN+QRRnHwMnJ
X-Gm-Gg: AR+sD135QulvmF9MBThk7s8iVpZKkDD4QrkQqHO4tbDe4UoHkv/06Q7A/hYl/XTcRns
	4gEGrrS2WVXUrT3Zkt7yyYn/17/VrsoSZoBbdoVBRgqCltSolZd9oECGdplmI4FTn8ARyMkS3Vl
	MzcuvR3mVYa+blfvItFj0065a572b8AGDLwCdx8lVvhcHTCBixDKpRC/k7ldPWWZ8Zgz4Za7+fE
	aWfBr9Z2HEEo+cX7UTP4IpwI+zLCnPBVsouztiHNqPrX+jMxT7Vg0W8d79ASJ24gSQzVzz3VYQU
	gJPtSzIJu8Mk4leQ4tzySmn8EESann+eu8COQHw/US8tAbz29Z9UItkpL2rqbD976/QvNx4oyza
	pqKAn1MhhEMgOsgCYXoPs40KTLqXWZUVtoZQtzw35wEw4vf9LR4XGZLD7eIFqPFdESaDSm2qnfA
	jMQLojw8Cmmhp53EL2zRy1coCGvOTCDrdbeX/ypLurwt4SwO+PtOS42+1ymAT7hGFNgLVoObOn1
	jh8FappSOo4m6taz9rim4Oj8ac9eASnufl6Syg=
X-Received: by 2002:a05:6a00:acc:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-8520b946107mr39744983b3a.2.1787658445285;
        Tue, 25 Aug 2026 04:47:25 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:47:23 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 for-next 5/8] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Tue, 25 Aug 2026 19:46:38 +0800
Message-ID: <20260825114641.80452-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825114641.80452-1-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
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
index 30dc677b2f45..17810521d069 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -351,6 +351,21 @@ function does_sysfs_exist() {
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

