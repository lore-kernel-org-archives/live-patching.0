Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB030374A1B
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542089; cv=none; b=Daukmfk1QG83th74EPvoMJlQhF8zPWQ9fYn81ole8EkCZjWsrE+dqWA2iezaalURhoBDgGYgWUO684hunf5lch7cLB3avqeZlGW22AdNCoe+LHoku5Mye0/qHHGcQ6IjEafEWvC6AMGyVwFJVAuhCYt258pduUQMmOBKN4lv2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542089; c=relaxed/simple;
	bh=FoBEKp73/gZ0DUsoh7j0N2cF7paIVuNJwH6oXBAQDag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGeyEAmp7ZZsn1qakiXB7GCC+UNBTpVNlb2Vc/odUAk/Uztx918Vz1CJXYAiVLe2k4RqH3ViHGX/aFUSRMrS9IzdPk58FlVF7O4cQQjwFFRd1tt51JgIA5gaeAis4onTshuvGr2pk8O5sBXuwKC/5trpFvWR8TlVQJZX/D49/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu1lF/BX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu1lF/BX"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso4440608a91.1
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542087; x=1788146887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcMcG32p8bulUE4dx/JoaTesLzDx8MbIlnPJmlaiFZI=;
        b=Nu1lF/BXIeuMIaejhcw72kKZjsDDEpqC4nXd0VvSyXK4st+P4sA1b8Smi108+x+aBo
         oZYGHFQ+bgzLRBj3a2I4IBW7RHXGmrzn8n4QRn0n7P+TkJ9bROk7TxwRz5G6iM9EBgdE
         ArmQzPLottsuJINf7hhI0n2dkOjLr6nS/utFN2C8qogVmAS+t9hllll1RlNv21E05rqO
         9UI/WucUgKZpjT0J6Til8w4l/sFP5TvjuDWCCoIiqsS09l5WGgY6Nph9XKJ5Hquw9BaH
         u1+kpdFcrfOBt4RTOpskmR3ByQqmwVJN2LQFrt0wMwjpR270J143RscbXD3FlfcVSwNN
         PK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542087; x=1788146887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcMcG32p8bulUE4dx/JoaTesLzDx8MbIlnPJmlaiFZI=;
        b=AB0tKQbd5FYt7YKpQ0GpbyP5OCfqXxI0itVd9Ze6SJzxq+mevYaKFbx0URIQ1HSYe4
         nL+oO0/T0qgqwUQnLcdnTflGUvRF6vPSr+N7K7aDHZUX+naTjVtq1bg++4utuOlmx5rd
         3Q49bK2dLrSsFlEeYmZMiApa+NCBOWT+RfZ4XZAlrWPzTohJAOycbqjptp1nqMyjMwRu
         qdjFOefxGFLFDEudVakC/8xBSTjidyPpZbJbQ6WDAffUaX/oFlPyfomG84qvIJb9utl0
         ShDh1t7an6PpwUBSimiQuqlspnVoB/XjdbihJYdLw2eLix2Z7KURxgiBMBXOlBtDvNv/
         HksQ==
X-Gm-Message-State: AFuF++mEGVxOhZlfjZ9q4tE6LJmhQpy0M+mTiBLqUJKos0QPVxD9UvLY
	0NN22UY20r2XBJAElVx9liMaeKACnNoX+zmxy833mWPuRAApOCiE8LS7OHm0FtxIlpg=
X-Gm-Gg: AR+sD10aMLrcZjtRgN+0GgXu58Ryl2yfUptpeqySZGnqMlSfUZK0qUfQsoRa/5n1aGZ
	uqZmbQllrSSfhrCcDZnPxMHsFCr6S0/+QK8NH85y9DAxTTafgBidp3BCmOC3c9ZEyHwwZcE9PpX
	4yx1w0xA5FR/qwziIZDWh/mnwq2MGDkcj8BoSPdjEWdz/vCDpNzKthnzujQPKtRE1Lxk3xgqu3V
	79c+PiGTCtdRL2IB+VG/OvHzF0i8djelzUabVY23dXoP6I48FC2v9ysEpgzLuTEQOwl1JoymPYR
	qKlXupZ24U1XZNGAqkr/yNuH7tIQ8+IJXNUNwbisfSlPlpv5U/Qt8kiO/nU/kwDohg3dCvW5/aP
	j7CchtHGs+NUNJ+BNJE7dQU4ohHnobsfJEY/2m8Vo7e56lvEAg/IHz/YAh8TDwCUE9p9UnjUxc7
	4hDsV3cvloiYmFe3Fg7OwOVCdJmRM9BQ3j1TLsYE8NXJuaRGtQZdqb0ZiXvu/APwNmWEFlGQRyv
	5zjxntZWZq4o1pfO3UGLPJr+P42yYfjMlPOgqV33GU6Fyxruquiew==
X-Received: by 2002:a17:90b:54d0:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-395c35188fcmr45524262a91.1.1787542087052;
        Sun, 23 Aug 2026 20:28:07 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.28.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:28:06 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 7/8] selftests: livepatch: Add test for state ID conflict across provides
Date: Mon, 24 Aug 2026 11:27:31 +0800
Message-ID: <20260824032732.56686-8-laoar.shao@gmail.com>
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

Livepatches with different provides ids must not share the same state
id. If a second livepatch attempts to reuse a state id already
registered by a livepatch with a different provides id, the loading
will fail. However, if the second livepatch's obsoletes list includes
the first livepatch's provides id, the second livepatch replaces the
first one and may reuse the same state id.

Add provides and obsoletes module parameters to test_klp_state.c and
test_klp_state2.c (guarded by #ifndef KLP_HAS_REPLACE) so that they
can be loaded with different provides ids and obsoletes ids.

Add a "state id conflict across provides" test scenario to
test-provides.sh:

  - Load test_klp_state with provides=1, which registers state ID 1.
  - Attempt to load test_klp_state2 with provides=2, which reuses the
    same state ID 1. The second livepatch is rejected because
    livepatches with different provides ids must not share the same
    state id.
  - Disable and unload the remaining livepatch.

Add a "taking over system state via obsoletes" test scenario to
test-state.sh:

  - Load test_klp_state with provides=10, which registers state ID 1.
  - Load test_klp_state2 with provides=20 obsoletes=10, which reuses the
    same state ID 1. Although the provides ids differ, the second livepatch
    replaces the first one because its obsoletes list includes the first
    livepatch's provides id (10). The state is taken over successfully.
  - Unload the replaced livepatch, then disable and unload the second
    livepatch.

Assisted-by: Comagic:DeepSeek-V4-Flash
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../livepatch/test-provides-obsoletes.sh      | 86 +++++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c   |  9 ++
 .../livepatch/test_modules/test_klp_state2.c  | 19 ++++
 3 files changed, 114 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index 2707457b9133..f9a9f9b28490 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -6,6 +6,8 @@
 
 MOD_ATOMIC=test_klp_atomic_replace
 MOD_LIVEPATCH=test_klp_livepatch
+MOD_STATE=test_klp_state
+MOD_STATE2=test_klp_state2
 
 setup_config
 
@@ -171,4 +173,88 @@ livepatch: '$MOD_ATOMIC': completing unpatching transition
 livepatch: '$MOD_ATOMIC': unpatching complete
 % rmmod $MOD_ATOMIC"
 
+# - load a livepatch with provides=1 that registers state ID 1
+# - try to load another livepatch with provides=2 that reuses the same
+#   state ID. The second one must be rejected because livepatches with
+#   different provides ids must not share the same state id.
+# - disable and unload the remaining livepatch
+
+start_test "state id conflict across provides"
+
+load_lp $MOD_STATE provides=1
+load_failing_mod $MOD_STATE2 provides=2
+
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko provides=2
+livepatch: Livepatch patch ($MOD_STATE2) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_STATE2.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE/enabled
+livepatch: '$MOD_STATE': initializing unpatching transition
+$MOD_STATE: pre_unpatch_callback: vmlinux
+$MOD_STATE: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE': starting unpatching transition
+livepatch: '$MOD_STATE': completing unpatching transition
+$MOD_STATE: post_unpatch_callback: vmlinux
+$MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE': unpatching complete
+% rmmod $MOD_STATE"
+
+
+# Take over system state change by a patch that obsoletes the old one.
+# Although the provides IDs are different, the second patch's obsoletes
+# list includes the first patch's provides ID, so it can replace the
+# first patch and reuse the same state ID.
+
+start_test "taking over system state via obsoletes"
+
+load_lp $MOD_STATE provides=10
+load_lp $MOD_STATE2 provides=20 obsoletes=10
+unload_lp $MOD_STATE
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+
+check_result "% insmod test_modules/$MOD_STATE.ko provides=10
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko provides=20 obsoletes=10
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: space to store console_loglevel already allocated
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: taking over the console_loglevel change
+livepatch: '$MOD_STATE2': patching complete
+% rmmod $MOD_STATE
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2"
+
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 313401a5506e..77a5511d9d69 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -9,6 +9,12 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
+#ifndef KLP_HAS_REPLACE
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+#endif
+
 #define CONSOLE_LOGLEVEL_STATE 1
 /* Version 1 does not support migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 1
@@ -151,6 +157,9 @@ static struct klp_patch patch = {
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifndef KLP_HAS_REPLACE
+	patch.provides = provides;
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 1afc2cabc39d..53ff6e793952 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -9,6 +9,18 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
+#ifndef KLP_HAS_REPLACE
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0644);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
+#endif
+
 #define CONSOLE_LOGLEVEL_STATE 1
 /* Version 2 supports migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 2
@@ -180,6 +192,13 @@ static struct klp_patch patch = {
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifndef KLP_HAS_REPLACE
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#endif
 	return klp_enable_patch(&patch);
 }
 
-- 
2.52.0

