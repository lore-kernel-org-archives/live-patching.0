Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E93955C9
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658456; cv=none; b=j3nX4/DOnuZR2XH0fH5ag2DWEEfpUhwd3tMSe+UzrgE4carriY+TDNRAqnmLY7RWSe7X2o0GYSShpPF/rr0OeHVV1M/yCnlIrqcY5wkz7vBgYVi93ASztZOze2WyHlg4m4Uc7uafK5xyXuCNk7fMC4H575RXq5VTSQtSSfdYp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658456; c=relaxed/simple;
	bh=FoBEKp73/gZ0DUsoh7j0N2cF7paIVuNJwH6oXBAQDag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6DzkITPV5lZPSnkZxGSTOT1NGE5/KAIQz8bXTWRvdWyonbVEj3Vuw9LNVl3nAIAeeWfu9p5oIaUi6Q/POdsU+YCS/UmGLtjPjB84zMoW7HTRBL9cin0jvuKxYOGmgJYrAWPtaep8XkeYhNNLrG+xAXQC3sAozO51oohzTNpebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6UCUJmd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6UCUJmd"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2819001a12.3
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658454; x=1788263254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcMcG32p8bulUE4dx/JoaTesLzDx8MbIlnPJmlaiFZI=;
        b=f6UCUJmdYVCwyUlue5eI6OyuzZyDacTwzpwRcyiu+CpjM2kA7FWDlgozQW5pU0ucPm
         dm0bb38jBKVrrW8Ahw3O3RXK7ljDUWS4AcvNWemprSOZ0vsesJcsesZTq+LxOSVU+mDY
         u6OWdV/c+WOL6L4w8xEIijWZ5r0EIrCXYsZmhs/md9CIsbKrCRNK2XqGmdAXox2hqy0M
         lo3BW36CkW+w/eX8M6+3nnVbixSdevxrgMj/n7CBQjJVqdbi4zlU/RAWiHNskveO7vYx
         8HW+hQsl9u942B5NUibuykr5tbFHrNQ5an1W17NgLfvAvj8NBaUb5wiJUQjLPwfc6WRh
         GKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658454; x=1788263254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcMcG32p8bulUE4dx/JoaTesLzDx8MbIlnPJmlaiFZI=;
        b=c5Lg3rYmUxy/25iRhjhVeA1qRnNz1I/AfeBPUF2z01mTh1wGGAq3pHvDlTTZfPI9sS
         gFSyJKPiUFixYSjx0A2Y1Q16EvCzyOSlETz/AHblRixW1vbJd4ExqByeDGsbhQDy7unV
         aTqIzT+UwZP/VtIi3QedTJS0GNJDTHbWeoybe/OAglD7Lesi17b/G3cTsTXDFFVy77o5
         GvasusgX3ipF8IzsAwVTH+y+xLTcLGI/h3DXb7FhG5uKH07B7etSm1uDxC85onKETbmq
         Zzs5wPNKSQzpADyafJ1FdhjU9/1mjFwoEFHKpQEDC6FbqcKGVtjdkp4/z72JdFGhLd58
         +T+A==
X-Gm-Message-State: AFuF++nhrmuNdM4gRfs67g0yi3dZx1tZxAnI8sF+fdBCLCgNK3+wcwHm
	XZBzn/GUHE1kGLgtWtBnDmUlt4Lju2X5fbzTWJhTWKkkLfPWzV/GWkToZDm24oy9cYw=
X-Gm-Gg: AR+sD10JlkUPMP5LJ8nRImF7Gu+parITEozmPByscgB5RhLEwEcdm6tce0o+LGcbBBi
	9JtLaDs0PMRbNRLQ8oqbWVATP8o226a1fUxNOMcHb+p6rmGayoK7z9jvarrX2nF0Np6tHYrwNt7
	kLMrU5FNlem6jkorWrcHx1filJg7HtEauJCrXJGuxUqzDgtgEU+EvLIAKRAQ5P6+in9K3VLd2Bg
	rCUNN30SWqRDoN1Q7m+9+XStaAv7KZtqE34+FVHdTWCpCiXhJcZjy1lSeTLJO9Wr4b7N4Dp3Kz5
	05wcwd5znxGTxsi53tKd9Oxycnyi8gaCwrlzi3PNLEWb5x75IM0mLuax6igiiQwNRhr31O1Bmpv
	jqHfP31F9TDIDnIqXY/+1k1HqIZGiHRBIqd+tsmey5KGVZzefVVU+LElSQfbeElPspGh4Y+wYMA
	q40838cvTbhFH1sB1apinI2wwgTvRhJBkL2jfNRzuEkPTWEG5zG1MqHkp+iIZSZPpsR2Tmh0Dqz
	LPMWNPELQILiAzBq2s8KyqWzgHvvPQKFqwXiEc=
X-Received: by 2002:a05:6a21:3383:b0:3cc:4d86:389c with SMTP id adf61e73a8af0-3cd3015fb43mr63614033637.13.1787658453925;
        Tue, 25 Aug 2026 04:47:33 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.47.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:47:33 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 for-next 7/8] selftests/livepatch: Add test for state ID conflict across provides
Date: Tue, 25 Aug 2026 19:46:40 +0800
Message-ID: <20260825114641.80452-8-laoar.shao@gmail.com>
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

