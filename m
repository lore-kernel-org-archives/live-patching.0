Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D1355048
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267234; cv=none; b=TSdB9sRodBuP9WphcORZ0CiXAVprANUUY4FJx4tXO2jjQpBJaalgijmu6WunmQzkPIjW1NnAAcsqn4LTYiyMFJkDVaLbCM4L+D9NPZeDufrxTcsytlLKNSpSqmWvTuzR0bXJ+MrFpwNR/m4VtFEujmtMlrotejSYxDAMpQ/CLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267234; c=relaxed/simple;
	bh=ZA+TNW4B/AY4CMOBk0AajfQukqsnIYhjI4m1piVjS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnf6uV1I0qOJs+wI6WXR6vEa4h2kloaAQ36T5emenFtxHYtVk10RdzdxEOeDrZFJrdclHfgic7bn1qIklksfyDRPxc+vU+E5+3qXOHocv1gXkoIsbdUcAxDXkbtOg8o8q+mwZ+Jx9JufjL4b/an3dnjBz/lYwFFGmCs1E5R9ZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf5d3hkM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf5d3hkM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso762624a91.1
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267232; x=1786872032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tI48Hbiffjdwcl03iq2L0CkM6NOSgzrhcPFUbr7gNGw=;
        b=Yf5d3hkM8Xn2LE1dG6BswMmzY7NzH8S/FXbaRmftc9b3mJK78tNSt+dS7dy/Iy7ev4
         cvkp2MB8ylUOgdoBbrSrcC7If08iIAIWDVewGtsyP9iS8+qzg9jTgbiLCua3gpwonJUx
         Wl0XFao2IEMBR9WubZlO/yFm4odhjOaZKOuMdGK4sTsDI1xRdbqM/91bbsYZ93RGVpq+
         qrCtr9GSLlQPZSqIt47De9aLIebdNv6XI9E460YEhErTuuD/OI4Zbw8WO3+VcSs8nfn7
         q3J+hHPg5x87T5qU92e8wXBLp/A6+VPCkOJ8q6JbkHELy1UPIkgfzJ1mLNdbS7UvKJ4+
         DOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267232; x=1786872032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tI48Hbiffjdwcl03iq2L0CkM6NOSgzrhcPFUbr7gNGw=;
        b=ZE5x8P2lfoMDec2xe1M1AdXujSketbIEr377+RtAZbidKwyUKtV0XuPWKrPPqzk0n4
         cuNmWk4wtiH/VCBK7v/ABtY0dYWBWVLvMm5JR6tiim2lYEdKrhAXmjxyHCY9+mRxEY9Q
         sBD95ZwOAneixYqdDU8js9liyMKpg6Yi7rjd8/YIDbx7XDGlFI9npbAcdBII+epgEXMt
         5L0IRm6RUVO4iZ9y5OPxvBCuxQHlho8UMwGsA3KGf82MHmfolkNm0Cz903V7yBI+ss0D
         aZT+RBecynBsD+CeMWpkhEGs5X4b2oTWjgNduZIHZRG0/8zISx5Ljek3aWkFmo9E8p0B
         n69Q==
X-Gm-Message-State: AOJu0Yz4WMRJOAqGFd1kTzEpY55USUka3xQ3++GyhaM5yJdOIiV4P2um
	GwQ1CFONg7ZRSs0xtHwjj0AWmdQZzJB5JklRpaxYiq6nAxT/20nZ+kW3
X-Gm-Gg: AR+sD11CnNggyN+UCWilyoHo+fGaySNWyck6XEx3Ddj78HNCz0F1MUtk/J53dngQ7yl
	WTFAnX2QSrmQE4p+nwIhkjeUuIQRKvKnPAQW17Ebe7OUajAO8yTMsNRLpndiMv6kS5G0MjAI9cX
	mD2kcFena+AIy4TZ0Y1loNICx9mcFSKl7WJbkIVBa6BP09bHi6YGRyleIbbVIHvR4IiAdJ+eHHN
	OT3OPyYDDc7iSUrs0y34obGCm4sNa/j90hbQvJblyQmpc6zOR2YkbxiGVCYem140SKf7qkImvW/
	hHAKrVgtRm+hQKBsPz7n7IL3YYoWSpNeOKRC4OnkVlGmLwnhp1VWAIn18z776aRPvHDiKTCaOtt
	/5gw65QFbC/6AIpNKkuBUY4KlE8T3T863K/9XLcmofmlvP1Rh6wDfOZgtOQrIE1XzZ6YFnGz90k
	OSzFzRMt+aETusVGTn6EeYYOOBw8uPHewQNYBZaYCNJyhYzJQfNE9hUCd+gb14nK1bA2r7QL9ry
	GXmgp0w2JnwIc7jgMW5YdRPHywXaIhaxufYtT8XDJUsiorZGssuxhQ0cw==
X-Received: by 2002:a17:90b:48c9:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3903c58f06fmr36076566a91.13.1786267231744;
        Sun, 09 Aug 2026 02:20:31 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:31 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 6/9] selftests: livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Sun,  9 Aug 2026 17:19:50 +0800
Message-ID: <20260809091954.22930-7-laoar.shao@gmail.com>
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
 .../selftests/livepatch/test_modules/Makefile    | 10 ++++++++++
 .../test_modules/test_klp_atomic_replace.c       | 16 ++++++++++++++++
 .../test_modules/test_klp_callbacks_demo2.c      | 16 ++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c      |  7 +++++++
 .../livepatch/test_modules/test_klp_state2.c     |  7 +++++++
 8 files changed, 83 insertions(+)

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
index a13d398585dc..29c55df36046 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -16,6 +16,16 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state3.o \
 	test_klp_syscall.o
 
+# The legacy "replace" field was replaced by provides/obsoletes. When the
+# kernel (KDIR) still supports "replace", pass KLP_HAS_REPLACE to the
+# modules so that they can #ifdef the legacy "replace" code. Otherwise
+# the modules are built with the provides/obsoletes based code (to be
+# added later).
+KLP_HAS_REPLACE := $(shell grep -q 'bool replace' $(KDIR)/include/linux/livepatch.h 2>/dev/null && echo y)
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

