Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAD2F12DA
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737461; cv=none; b=Hw+P3VrI/EYN7yut1VcH1rNyfDhs742fYH/8ERlFc9PakwjhRs3bKaQZE2aisI7YzDMvA2Ow5y40r2KN3RjP7V8NVng5327ze9t8U4Ey9Sq9LD4ltmJKE0TMD6NHWBfvf6yZDwFGK6oA1ECqwaNJz8uRvUzPfldTV9gxVWvb8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737461; c=relaxed/simple;
	bh=R70ENHmMhH6ymB0fJBL0SxhvRdcItcFAPtbqpBVyMjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEXgR13xhWpC0nWt/4RlC3vGMAjl6T466AdXDTC710eLb82sngNB2DM/pEJCWpmc50agmcK/1YxS3XnXs6H01PSLYuNEOmAMWlE0i0IVtOlhIXiJ5c/lf+GewjmhpIuXcObhMnyoHx0po+xtq1yQ9L44sTAmvtZxwZl1NK7YYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci8SEiUW; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci8SEiUW"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so2258051a91.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737459; x=1791342259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/apqMeosiGlS+fOcdt5QIAu2WjfJIYuHyJfuq3tfSk=;
        b=Ci8SEiUWfNEb11CVhKqbI9Gm+I9N19OsKdDZ1VVlG15JcikeCGXVWqcVqodaM6whQr
         uwyQlEke+MgwtGc0AcwxgYN1U5hsastJDpi3H3BQWy8TMGoU4rzweFw5rcMzWFnLgjPR
         80q9pca7ArijQ7Kro/FT1QK4jo+yd/0jwdnP7EZhaFKLoTT6Gdn1YHbrQx7F4lEIrgYe
         zrQX30P4PAozrTy0ReCtujANJG1gKDE9imE12z7eQO3drJhUebJOKMDyIxVkPy75ksCv
         32mlo+k4w8T9Kf6Bov4CGW+L2+3MxN4Iy2k2I2odweHBUkDgvE1ZdarSgQ+kKPH/ETod
         doJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737459; x=1791342259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/apqMeosiGlS+fOcdt5QIAu2WjfJIYuHyJfuq3tfSk=;
        b=1rlWqKrwy0wFvBNVvVFYovNL3CV39yiL/mCqAmH4d9Rdvx8q6dq0d7ZBqQ5FgFfM9j
         KLbiVT4yMtn5wOnrbWm1VTj4pOz6X+8rPLLy6PsIPsfEulJt7e0iwvsaAgb7IQgCH4Zx
         UHzqijpcMGXiK4bwvLue1sMQ5xyWKDy8d5ed1TY51yugFFF5GvbeCJJA1zXsTk1SraIS
         Qcvc9OjPRN4XzWiuWibE2QpT8P0UVWXWYETc1hwhSFnksc1PVtJRV689LScZjSXzEqd8
         kkm8C/auSSmEY0gjeULMIaxTlfbdudaN54fCIIKkQSCFygAHoC+RES7a1spcc/22DL0U
         h+mw==
X-Gm-Message-State: AFq9FYInL/aQJPtfTsaEmPesjeId6q03l/hdN9dU7RtMAy7Cf4Q/rE0X
	wJ+LfBAzMFYDvw2xHWWeNnIzK34hIsgCk6e7Gdz2D4mA9uNOYaXgLMpW
X-Gm-Gg: AYBFou0ym/SnPNwnQSN4goF2YM7ies1+s1uMnV/cLdAkKuFwgN6tcmMaCRrdPqV72lG
	gUG3BVqZce78h3HRlOjbU2WDEGmalobQO1ZkUrzp9BpwsYZxnbn/vsYpDYEAjtgWc4a8V85ZymK
	tn/N0D7km6fMJncBGjy4SHQZWjmDStRuBfqKZ7heo2Y0L7Zsjtr8O49sZMO9fXTjInL9EJe9eqj
	QZ5K4bEABbxnTmSCyUA+0/F+T4nqGnRi128gZ+UCms2sj/33z27t6EaXdWjvB++KAEKVszl9B+o
	MIPhFxLFu+fNHqjPrLeR4H6E9rFZcbH5MOJbYMENH+Xfcm9i5LTsBZrod/uLKl/2T5wNkvplGET
	WlNmwY/rzdv8yvVg/GcgZWVIKzfjkL1+d0qPktCFIXc1eDnp2K2kG25nReqyuqEjDjOMIDj56Kg
	qjStColEXK/srgUCn4pTxCemESfSXM+3tTgX3YfvnI1CLTXajrEFXI+froZ684JkWHUEqZWGHMy
	Pvb5GGobbwaOQ5lS4h5Zakaxba7ZPjsQqT3zIe59tRExHUuD+1j7cQ4NkWCDueT4wX/Gg==
X-Received: by 2002:a17:90b:2d07:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3a4d276f34bmr12800a91.8.1790737458957;
        Tue, 29 Sep 2026 20:04:18 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:04:18 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 8/9] selftests/livepatch: Add state test for provides/obsoletes
Date: Wed, 30 Sep 2026 11:03:22 +0800
Message-ID: <20260930030323.14396-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930030323.14396-1-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatches with different provides ids must not share the same state
id, unless the second livepatch replaces the first one via obsoletes.

Add provides/obsoletes module parameters to test_klp_state and
test_klp_state2, and cover both cases: reusing a state id across
different provides ids is rejected, while it is allowed when the new
livepatch obsoletes the old one.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../livepatch/test-provides-obsoletes.sh      | 239 ++++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c   |  36 ++-
 .../livepatch/test_modules/test_klp_state2.c  |  44 +++-
 3 files changed, 303 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index a1c0ebb9ed44..430c3a9a9d84 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -6,6 +6,8 @@
 
 MOD_MEMINFO=test_klp_meminfo_lp
 MOD_CMDLINE=test_klp_cmdline_lp
+MOD_STATE=test_klp_state
+MOD_STATE2=test_klp_state2
 
 setup_config
 detect_provides_attr
@@ -218,4 +220,241 @@ livepatch: '$MOD_CMDLINE': unpatching complete
 % rmmod $MOD_CMDLINE
 % rmmod $MOD_MEMINFO"
 
+
+# - load a livepatch with provides=1 that registers state ID 1
+# - try to load another livepatch with provides=1 that reuses the same
+#   state ID. The second one will replace the first one.
+# - disable and unload the remaining livepatch
+
+start_test "same state, same provides"
+
+load_lp $MOD_STATE state=1 provides=1
+load_lp $MOD_STATE2 state=1 provides=1
+
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: space to store console_loglevel already allocated
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: taking over the console_loglevel change
+livepatch: '$MOD_STATE2': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2
+% rmmod $MOD_STATE"
+
+
+# - load a livepatch with provides=1 that registers state ID 1
+# - try to load another livepatch with provides=2 that reuses the same
+#   state ID. The second one must be rejected because livepatches with
+#   different provides ids must not share the same state id.
+# - disable and unload the remaining livepatch
+
+start_test "same state, misc provides"
+
+load_lp $MOD_STATE state=1 provides=1
+load_failing_mod $MOD_STATE2 state=1 provides=2
+
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=1 provides=2
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
+start_test "same states, replaced by obsoletes"
+
+load_lp $MOD_STATE state=1 provides=1
+load_lp $MOD_STATE2 state=1 provides=2 obsoletes=1
+unload_lp $MOD_STATE
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=1 provides=2 obsoletes=1
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
+
+# - load a livepatch that modifies system state (state=1) with
+#   provides=1, then another livepatch with the same provides id=1 that declares
+#   a different system state (state=2)
+# - the second livepatch would replace the first one due to the same
+#   provides id, but it does not handle the system state modified by
+#   the first one, therefore it is rejected as incompatible and the
+#   insmod must fail.
+# - verify the first livepatch is still alive, then disable and
+#   unload it.
+
+start_test "misc states, same provides"
+load_lp $MOD_STATE state=1 provides=1
+load_failing_mod $MOD_STATE2 state=2 provides=1
+
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=2 provides=1
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
+# - load two livepatches with different provides ids (provides=1 and
+#   provides=2) that modify different system states (state=1 and
+#   state=2). Neither of them replaces the other, because their
+#   provides ids differ (and the obsoletes lists are empty), so they
+#   can coexist.
+# - verify the provides sysfs value of both livepatches
+# - disable and unload both livepatches
+
+start_test "misc states, misc provides"
+
+load_lp $MOD_STATE state=1 provides=1
+load_lp $MOD_STATE2 state=2 provides=2
+
+check_sysfs_value "$MOD_STATE" "provides" "1"
+check_sysfs_value "$MOD_STATE2" "provides" "2"
+
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko state=1 provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko state=2 provides=2
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE2': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2
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
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index f53eead9d55b..3511cf081fef 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -9,10 +9,25 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
-#define CONSOLE_LOGLEVEL_STATE 1
 /* Version 1 does not support migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 1
 
+static unsigned int state = 1;
+module_param(state, uint, 0444);
+MODULE_PARM_DESC(state, "console loglevel state (default=1)");
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0444);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
+#endif
+
 static const char *const module_state[] = {
 	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
@@ -35,7 +50,7 @@ static int allocate_loglevel_state(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return -EINVAL;
 
@@ -52,7 +67,7 @@ static void fix_console_loglevel(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -65,7 +80,7 @@ static void restore_console_loglevel(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -77,7 +92,7 @@ static void free_loglevel_state(void)
 {
 	struct klp_state *loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -133,7 +148,6 @@ static struct klp_object objs[] = {
 
 static struct klp_state states[] = {
 	{
-		.id = CONSOLE_LOGLEVEL_STATE,
 		.version = CONSOLE_LOGLEVEL_STATE_VERSION,
 	}, { }
 };
@@ -151,6 +165,16 @@ static struct klp_patch patch = {
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#else
+	patch.replace = true;
+#endif
+	states[0].id = state;
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 5f07fe1be2b9..aeb911b87d37 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -9,10 +9,25 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
-#define CONSOLE_LOGLEVEL_STATE 1
 /* Version 2 supports migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 2
 
+static unsigned int state = 1;
+module_param(state, uint, 0444);
+MODULE_PARM_DESC(state, "console loglevel state (default=1)");
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
+static unsigned int provides;
+module_param(provides, uint, 0444);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0444);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
+#endif
+
 static const char *const module_state[] = {
 	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
@@ -35,14 +50,14 @@ static int allocate_loglevel_state(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: space to store console_loglevel already allocated\n",
 		__func__);
 		return 0;
 	}
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return -EINVAL;
 
@@ -59,11 +74,11 @@ static void fix_console_loglevel(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: taking over the console_loglevel change\n",
 		__func__);
@@ -80,14 +95,14 @@ static void restore_console_loglevel(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: passing the console_loglevel change back to the old livepatch\n",
 		__func__);
 		return;
 	}
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -99,14 +114,14 @@ static void free_loglevel_state(void)
 {
 	struct klp_state *loglevel_state, *prev_loglevel_state;
 
-	prev_loglevel_state = klp_get_prev_state(CONSOLE_LOGLEVEL_STATE);
+	prev_loglevel_state = klp_get_prev_state(state);
 	if (prev_loglevel_state) {
 		pr_info("%s: keeping space to store console_loglevel\n",
 		__func__);
 		return;
 	}
 
-	loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
+	loglevel_state = klp_get_state(&patch, state);
 	if (!loglevel_state)
 		return;
 
@@ -162,7 +177,6 @@ static struct klp_object objs[] = {
 
 static struct klp_state states[] = {
 	{
-		.id = CONSOLE_LOGLEVEL_STATE,
 		.version = CONSOLE_LOGLEVEL_STATE_VERSION,
 	}, { }
 };
@@ -180,6 +194,16 @@ static struct klp_patch patch = {
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#else
+	patch.replace = true;
+#endif
+	states[0].id = state;
 	return klp_enable_patch(&patch);
 }
 
-- 
2.52.0

