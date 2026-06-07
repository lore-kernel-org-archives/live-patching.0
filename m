Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539442BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838268; cv=none; b=JOrWah59q3WezW21ts/C7Mmzi3mMaWN2hEEmfrj4D41cHw1RWMi7iNKjqzkNGfgnqkEQGa/Q4YbL1p+290V8auc8h+xWKsl4nAYjE09CEDO2HBy0pNyc0CbLJPiRXJ25zmZLLcYZkSlLDxewBFYPahRDAWPmkfT9o+25rkLEs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838268; c=relaxed/simple;
	bh=aYCw3Dlw8MeIVAPUSsVjjaywJzu7cOFOWBPn+BiK6mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ3H4y2ctNT9jt2DtDCGCRqbqbQ57xMglPS+iw817M/wnMFeixIkNa8akVJB1mxqzFUKEYG9V9GYnXJ4L2JfMebXcmdTa2pp0X669ezZIZpeqE4Yl8i2M3xLju8btxENrkUkL3dVlrQ0DT68m2C91AHqRugZmWrmkUU1J0PuX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwLUqpdG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwLUqpdG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bea7176c72so21759705ad.0
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838266; x=1781443066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A94/YZvddhw9JtMjCS+6+Kt4CwqtoWaKOzaU8jPqeKg=;
        b=VwLUqpdGqwwwlIPvYChGl3JrNJAyM5mkkc/ZI8FC2+6XT35ih+m7/o9CnTllKVhNe5
         kF/zYxyzskDxulbBHTpEz7JcnX3oYG1Tx2T7KYFC8Fcup+I+tKCh0QOnCdv2kKH9SDdO
         prqgVcdgBQHO1vK5i/RFpHpaC9OvZ+FFQ4ELUTCq3gGhw3AWlyfzArFtCwryOY8J6P0g
         pBaf9EuE+DNjDc0u4GQLyPWEGGw3tsut10NtExxXiCvGoWhpjjaXVPbXpncozE8EHhCC
         QcqCP7p2cR6emvdT019hghp5/Nf/2W1pRomwRBhhmnbHZOCEyvCipU8TC6deo5Id+2/B
         g7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838266; x=1781443066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A94/YZvddhw9JtMjCS+6+Kt4CwqtoWaKOzaU8jPqeKg=;
        b=AFyrFsExxJMDdOF5YGutig0WFcZEHQg8Mfr614Y6y/qZAaSeu6rplzC5f9TYdNaHCf
         B+c4Vsf2w1lpFm4FXrm6pO2B3r1Rnj74N1RHRyprEHwJEn4xJ2ZIOQoPAsbsMS4z5jM4
         rJ3nTAF+rXEHSR7D5/yB2X+LTxiob0IkqsQp4ky1N74IdqamSPOXMtoVJK6Nrhw4lAsN
         OXr53GO5AqBHQCVy9O6+nP/e5Q127JXAX4uEDvMqA8d1w8QDooLlbLWst4nsTDy6I79f
         UWR6b8yhdnoLUTw41NACHLqc429opBZfCI5LyuxsgWgKjYBXNUvzfdjoOb9Me19HVmkv
         zyyg==
X-Gm-Message-State: AOJu0Yyy0UE8AVOurX9TNTjleFQwQ62VWBi9wjgPQdFaT3rDLAfsSLkN
	Ss1tta16CVoRfcbYhQEWMyq+J15+MaYGraItjNXDUuzbNjXqUSg/h3lr
X-Gm-Gg: Acq92OGMj6ijET8hbOZdWPzDDbj7fl8Xuk4Jm9297S18tjYexzqxL/Qdxdu6MQRC+JP
	KwwwL9Cku04x2IGv5v2VUKO/C/RsU86pdy18bE/sdj4ENX7KrUsn6/5p8Hp99I0MXAk2X6oCIVK
	kz0dZCdwuDg4AYw2d6gLsf6Q2w2KE1LGbhB2d1mkLas/IH7YAij84re0dZDtrr2Goiq6IMrN5w1
	+J2/NW4IEc2EyBlEMU+zD3uWqtXoP3s71dMCgpuUx5MID9TVQuXTGSl4/UZ7ehgwbxlZJXuK0eY
	9feVoH6xa3EOUt4Yx0ZjF6z0mURdGqlZSPymaxFMDjRCiXhV8a/a1xkX0UarXYIb79YG22+hDYK
	it4JhrQ/l1e2SwU4Q1rJRrQ1Ph1lbd0ZCKK0xdlDsqp1/uTNOGrimHCWCILvDBMznZYSi4coSla
	CT2YZ69YVSFRtwBSQOGihhZM2xtLwrZVMHYwBce9ZEbZVZ7Dk8pkpZGBprri3dHj1GskWzjFyZD
	AFKwa2g1k9q
X-Received: by 2002:a17:903:248:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2c1e7b457femr133197015ad.14.1780838266412;
        Sun, 07 Jun 2026 06:17:46 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 6/7] selftests/livepatch: Add test for state ID conflict across replace_sets
Date: Sun,  7 Jun 2026 21:16:58 +0800
Message-ID: <20260607131659.29281-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607131659.29281-1-laoar.shao@gmail.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatches with different replace_sets must not share the same state
ID. If a second livepatch attempts to reuse a state ID already
registered by a livepatch with a different replace_set, the loading
will fail.

Add a test case to verify this behavior. The test result is as follows:

$ ./test-state.sh
TEST: system state modification ... ok
TEST: taking over system state modification ... ok
TEST: compatible cumulative livepatches ... ok
TEST: incompatible cumulative livepatches ... ok
TEST: livepatches state compatibility  ... ok    <<<< This case

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../testing/selftests/livepatch/test-state.sh |  34 ++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../livepatch/test_modules/test_klp_state.c   |   2 +-
 .../livepatch/test_modules/test_klp_state2.c  |   2 +-
 .../livepatch/test_modules/test_klp_state4.c  | 163 ++++++++++++++++++
 5 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_state4.c

diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index 04b66380f8a0..934a2aa655bb 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -7,6 +7,7 @@
 MOD_LIVEPATCH=test_klp_state
 MOD_LIVEPATCH2=test_klp_state2
 MOD_LIVEPATCH3=test_klp_state3
+MOD_LIVEPATCH4=test_klp_state4
 
 setup_config
 
@@ -173,4 +174,37 @@ $MOD_LIVEPATCH2: free_loglevel_state: freeing space for the stored console_logle
 livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2"
 
+# livepatches with different replace_set sharing the same state ID
+
+start_test "livepatches state compatibility "
+
+load_lp $MOD_LIVEPATCH
+load_failing_mod $MOD_LIVEPATCH4
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+$MOD_LIVEPATCH: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+$MOD_LIVEPATCH: post_patch_callback: vmlinux
+$MOD_LIVEPATCH: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_LIVEPATCH': patching complete
+% insmod test_modules/$MOD_LIVEPATCH4.ko
+livepatch: Livepatch patch ($MOD_LIVEPATCH4) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH4.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+$MOD_LIVEPATCH: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+$MOD_LIVEPATCH: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a13d398585dc..bdc5ae37311e 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -14,6 +14,7 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state.o \
 	test_klp_state2.o \
 	test_klp_state3.o \
+	test_klp_state4.o \
 	test_klp_syscall.o
 
 # Ensure that KDIR exists, otherwise skip the compilation
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 8c8829c3ec43..6ef3059483de 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -39,7 +39,7 @@ static int allocate_loglevel_state(void)
 	if (!loglevel_state)
 		return -EINVAL;
 
-	loglevel_state->data = kzalloc(sizeof(console_loglevel), GFP_KERNEL);
+	loglevel_state->data = kzalloc_obj(console_loglevel, GFP_KERNEL);
 	if (!loglevel_state->data)
 		return -ENOMEM;
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 8a79d7dcce33..908d79bc7540 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -46,7 +46,7 @@ static int allocate_loglevel_state(void)
 	if (!loglevel_state)
 		return -EINVAL;
 
-	loglevel_state->data = kzalloc(sizeof(console_loglevel), GFP_KERNEL);
+	loglevel_state->data = kzalloc_obj(console_loglevel, GFP_KERNEL);
 	if (!loglevel_state->data)
 		return -ENOMEM;
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state4.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state4.c
new file mode 100644
index 000000000000..010d1e13f6ec
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state4.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test is identical to test_klp_state4.c, except that replace_set is
+ * set to 4 instead of 0.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/livepatch.h>
+
+#define CONSOLE_LOGLEVEL_STATE 1
+#define CONSOLE_LOGLEVEL_STATE_VERSION 4
+
+static const char *const module_state[] = {
+	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
+	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
+	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
+	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+};
+
+static void callback_info(const char *callback, struct klp_object *obj)
+{
+	if (obj->mod)
+		pr_info("%s: %s -> %s\n", callback, obj->mod->name,
+			module_state[obj->mod->state]);
+	else
+		pr_info("%s: vmlinux\n", callback);
+}
+
+static struct klp_patch patch;
+
+static int allocate_loglevel_state(void)
+{
+	struct klp_state *loglevel_state;
+
+	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	if (!loglevel_state)
+		return -EINVAL;
+
+	loglevel_state->data = kzalloc_obj(console_loglevel, GFP_KERNEL);
+	if (!loglevel_state->data)
+		return -ENOMEM;
+
+	pr_info("%s: allocating space to store console_loglevel\n",
+		__func__);
+	return 0;
+}
+
+static void fix_console_loglevel(void)
+{
+	struct klp_state *loglevel_state;
+
+	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	if (!loglevel_state)
+		return;
+
+	pr_info("%s: fixing console_loglevel\n", __func__);
+	*(int *)loglevel_state->data = console_loglevel;
+	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+}
+
+static void restore_console_loglevel(void)
+{
+	struct klp_state *loglevel_state;
+
+	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	if (!loglevel_state)
+		return;
+
+	pr_info("%s: restoring console_loglevel\n", __func__);
+	console_loglevel = *(int *)loglevel_state->data;
+}
+
+static void free_loglevel_state(void)
+{
+	struct klp_state *loglevel_state;
+
+	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	if (!loglevel_state)
+		return;
+
+	pr_info("%s: freeing space for the stored console_loglevel\n",
+		__func__);
+	kfree(loglevel_state->data);
+}
+
+/* Executed on object patching (ie, patch enablement) */
+static int pre_patch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+	return allocate_loglevel_state();
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void post_patch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+	fix_console_loglevel();
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void pre_unpatch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+	restore_console_loglevel();
+}
+
+/* Executed on object unpatching (ie, patch disablement) */
+static void post_unpatch_callback(struct klp_object *obj)
+{
+	callback_info(__func__, obj);
+	free_loglevel_state();
+}
+
+static struct klp_func no_funcs[] = {
+	{}
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = NULL,	/* vmlinux */
+		.funcs = no_funcs,
+		.callbacks = {
+			.pre_patch = pre_patch_callback,
+			.post_patch = post_patch_callback,
+			.pre_unpatch = pre_unpatch_callback,
+			.post_unpatch = post_unpatch_callback,
+		},
+	}, { }
+};
+
+static struct klp_state states[] = {
+	{
+		.id = CONSOLE_LOGLEVEL_STATE,
+		.version = CONSOLE_LOGLEVEL_STATE_VERSION,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+	.states = states,
+	.replace_set = 4,
+};
+
+static int test_klp_callbacks_demo_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_callbacks_demo_exit(void)
+{
+}
+
+module_init(test_klp_callbacks_demo_init);
+module_exit(test_klp_callbacks_demo_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_DESCRIPTION("Livepatch test: system state compatibility verification");
-- 
2.52.0

