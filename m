Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A4326951
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921860; cv=none; b=dDQyoXbV6/G4MeJcm1tbC0VFufbPwmrHTqES5w51cVe1b8uBTkEqT5vX1E5M7M+pqezIuT7goRV+85nvchNHjkStdGw41GNqY54JYCXuSM0H8aXd5fagY4GS1knHCAUqE8yNpDoxsdhzF+fJAaAep86xCqbTfkbUd5WTuu/31Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921860; c=relaxed/simple;
	bh=XdmWpAriI/PiJdU3ohZ2tVy/9m3llHcG7YPTDF6HaDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqzx/N5VzmpvomRYPKLC+hggc0NNRRMKElxEw+bnzAar6GxGJAi4M/7AAOEkBgIN+HunlGLqmnVSpH5zFfp6lq8RYHe6zHym0domLlPPeAOHUQ7z1sFWFwP3+DqbMDWrHp1g9C20Nvwi6TEhQSIdCmRyDYyITvMd/CFvkznnDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bapKv2T9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bapKv2T9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-382ef647e20so5683601a91.1
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921858; x=1789526658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5sdeq+73a6kaLoREoPLfzgKOeyHcW2RPyMWXoq0b9E=;
        b=bapKv2T9ufCfUVRQiX0H5wsqM3JnUB0iZ15JM/TTyN1XbYV8U1VnPUsS1j4FPWVTwk
         JDQires1MKFWFaUm1srwqsg8QL2T5HKQ6llynna8ZT/2p4olOamEwMFDBj43u2M6Tbe6
         MSDVYCX7zRnKiz9rip4fMWE/e1tvioDPrNypBRE1F4D6Z3EiBhuNeP1Dx0Zk5hhicJHN
         wYx98I9A78AybXGmSlm3vho3SBoky6feYRtBk9On4Fd8wmTsC1t3pI1QeT0No2NQvKzg
         /m6yjsfD4eMAo8RlZm6OoQL5tVempBS4BO+kxCuJYPqBKo8VkMT2HxQ70NceP1z3iHBy
         8bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921858; x=1789526658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5sdeq+73a6kaLoREoPLfzgKOeyHcW2RPyMWXoq0b9E=;
        b=bsgD1Xr2JBljC2t9ec2poRzvYEYO5lOlowwzOKoKhmoIQb/mii5TM9nHC1ByNfX8Ws
         sgHOpuioUH6w1fliQY6tWCgg204HYTmmIaLwOrFxDoVCDA6YD/cbBR+DS+IaKicBztKX
         ivKNzQF7ZPoQbyraMNPiNIjYOVQLbTMAxpSCETFizUplgPbBCCFVwDJaeDobKdHcpxNG
         PWbxgVYtLu3TPJKeeI8z5b5Rmy656lBSwmUOQ9K7wUI+cgbW5sFhTezIEjSvm3HV1v2N
         q+xOQYeUWYX7CHCGSV46PZVenOsiQ1CzK/nW4UBk9E9CudM1QicziWyfJbsTmsuKwmpp
         3rpQ==
X-Gm-Message-State: AFuF++kNaxR/bA7uINUC+YAoHXWWONzuRP+foDqRtBlp2IQfA4ZxOZdK
	oHHHkUcASepQhE8M+7tKyyDciOxglVn4R24HO10s2ZC0g+SFlxFq+9/o
X-Gm-Gg: AYBFou0RyyBnJS1Axzen5EARb7eSj45/UY2aw2a7aFFTBOFR1Ih69fEtxopOyUsLu9t
	CZxtP0aKxRC+8Hd6gEeCfN25ZLihrFjQSvDui7G7RCB2XyucdP0vRzFTuUC4BJirMjqH7vCTCIW
	Ptu6fM03EMm2Vh+MwDwPxnsXbNKOZ/n9mdVDr+xldwxH2uAyvwfPHcCz1u5an0EpPS426BjyxSo
	cxL2N/578zpmghCgpFopEcQ/L0VkY9D2jbv2ItWAxEQ0kLCE9dzigYrAa5yafhY/3kQNQThRh4B
	4sl9TxS+YDGzVtnxkvVMAgAZSYwu/kTBaOBfuHU7JPL2b2MbdCImpFRcbxHrdSKqq8w5QJvaXAm
	W77MUlPsKuE8K5S6EdzgB7TRKzrMce/OWqy80jA9QlgBtLNY1N2TuUR4dbvMPJMZPJu495mPvJr
	yZPbRq73Mghf2/fgcbHC7cR7X+nFNIlhYhNKAFKoRlGs1Kw8H6hSjhUhoLH0oHD9bZcm3/32PwA
	ADdGe3wzJQ+3g2fKt6L09EnJOloIXm2qxSz2nL3xsJieIKQdJJLUsiUY1/4gihswubIz3qTF0Ox
	cs3t
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39b261002f5mr45341337a91.6.1788921857696;
        Tue, 08 Sep 2026 19:44:17 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.44.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:44:17 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 8/9] selftests/livepatch: Add state test for provides/obsoletes
Date: Wed,  9 Sep 2026 10:43:23 +0800
Message-ID: <20260909024324.16002-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909024324.16002-1-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
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
 .../livepatch/test-provides-obsoletes.sh      | 236 ++++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c   |  41 ++-
 .../livepatch/test_modules/test_klp_state2.c  |  49 ++--
 3 files changed, 300 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index c2fbac3d0e06..8b7b5eded80c 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -6,6 +6,8 @@
 
 MOD_MEMINFO=test_klp_meminfo_lp
 MOD_CMDLINE=test_klp_cmdline_lp
+MOD_STATE=test_klp_state
+MOD_STATE2=test_klp_state2
 
 setup_config
 detect_provides_attr
@@ -213,4 +215,238 @@ livepatch: '$MOD_CMDLINE': unpatching complete
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
+disable_lp $MOD_STATE
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
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE/enabled
+livepatch: '$MOD_STATE': initializing unpatching transition
+$MOD_STATE: pre_unpatch_callback: vmlinux
+$MOD_STATE: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE': starting unpatching transition
+livepatch: '$MOD_STATE': completing unpatching transition
+$MOD_STATE: post_unpatch_callback: vmlinux
+$MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE': unpatching complete
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
index 5c5872ff2566..1de63c2438d6 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -9,10 +9,25 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
-#define CONSOLE_LOGLEVEL_STATE 1
 /* Version 1 does not support migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 1
 
+static unsigned int state = 1;
+module_param(state, uint, 0644);
+MODULE_PARM_DESC(state, "console loglevel state (default=1)");
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
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
@@ -142,15 +156,20 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
-#ifndef CONFIG_KLP_HAS_PROVIDES
-	.replace = true,
-#else
-	/* provides=0 by default, replaces all provides=0 patches */
-#endif
 };
 
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
index 4dd78bd01c61..a78ec21df733 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -9,10 +9,25 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
-#define CONSOLE_LOGLEVEL_STATE 1
 /* Version 2 supports migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 2
 
+static unsigned int state = 1;
+module_param(state, uint, 0644);
+MODULE_PARM_DESC(state, "console loglevel state (default=1)");
+
+#ifdef CONFIG_KLP_HAS_PROVIDES
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
@@ -171,15 +185,20 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
-#ifndef CONFIG_KLP_HAS_PROVIDES
-	.replace = true,
-#else
-	/* provides=0 by default, replaces all provides=0 patches */
-#endif
 };
 
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

