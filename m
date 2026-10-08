Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562A494819
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453573; cv=none; b=lbmN1WtHG5c8H52QgZyHO9BsCidT6ymzpqX3UfMX7C4rtg7naALSRexVOzxHfVR9Qtvjrx8FYn9aeU+tVDxNAEz3Yt/0CLqkev8Io+X6xxf8ppSFHZrswCiV8akI1TE7aQDUMDCuHAfQJDvjNLf1pwO6RuKnMaQrlLzS/Sh0KTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453573; c=relaxed/simple;
	bh=J/nABUsAUffsgJ2bg75yJh97qdGiX04b3hTSUSKn/y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjTO7zdtkoXVW5ulS1Bu5mvqrvaXN4t1NMTHnKPaxnm6r/K054UutTk379bpWTz+cypz2zTBBu+szRB4gYvZjtMr06dxI/tvD7Y7PBTdnjQIA4ypfLzNpOCVk3Ts63PZujFRbtCTeIMlg+jEhFea/gTYml1Qa+2Mev5gv6R7dmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJc+iHOJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJc+iHOJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso1235885a91.1
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453561; x=1792058361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29WAxgrm80vcWqZ/fapUYVz0x0d94pFhtyFWqW+O8+g=;
        b=VJc+iHOJis2ljbPOeeC3c7xJKJ9V17BNEgozjwyYwA9R1f9bIA28bedsM5U0uwfxT+
         M9I2bOAbW4V4m3rUVmDnR2LFPefuysCiIjXisQlALVIdCgH4Dbp1J2wwlvlHE976Yfac
         d0zdQ2ppqKeiuXhYC9kK8Py2PHTo4OcSsKfDuMTZ38ycYbg6Bkgmc0IWjjnKNpe2oZX5
         OBTkN0qSq7PfKABe6VyrprzWO9G35WInHVWmhSwpMEDTmHJeBLKZ2rGMqBgisog66Npf
         C2jorUrU8g/phrbB4PGGQ2i0UiUkv+Y5LDvJIiRlYMFBgR32RFdL9/Pgg3V0zXuLwdK8
         2/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453561; x=1792058361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=29WAxgrm80vcWqZ/fapUYVz0x0d94pFhtyFWqW+O8+g=;
        b=ZnqvcBjdnh89uBtKyKROOIDGCQdB9cSJhMD8rzmYrjIeOBJE7gkjabEwI4XM81j8+R
         M7+vuo7UPwlhIJUHXU7aA8TbgkC+PErn8wjDtHRZdBR2imd10pLBbb3vfHqSE/2wuYYk
         bC2ICnmE3WPFsuZT1+zbtvwpaFlFm0P6I5gg6HMFod7a8N7dD2jm60aTTiYwpKT67zO3
         m3jKBfi2kPWdrwtwkn1tp5aEugSLgKgBdwYlNKHe+Nv38dfjHDPcEb4v6pbvGqv54gTX
         m8Vk/SuWHKEwhETSVQ+fgFhUpEykD7n1RS1yxupDq0VqVJYImi5xFB3dcBU7d4NA+ozk
         un/w==
X-Gm-Message-State: AFq9FYLVrcHGWyzR+0MTU+xuZpMSMCB6YJwA5mT0Uv3BvRGFqnsRRM+H
	uj5y1z+3nZpsDCeZj2/ymcR3kF3gApus5beP457lo5tHU5eSvUWUIH90
X-Gm-Gg: AYBFou2lZJe1SfdX9sH+H1yG9VuvuZRbsJM5BR88ShOLN7B1rqxElcS3XOXT4T68AHL
	LnU/wlyIG0GKBxzcPkLl1+Lr6UmvvLGQWsF9qBAHsnAO++w2+zFpEOWDG30pL2M7KwaEwcMzvz2
	uSWbhm/bGhsqTlP3xlnG/XXVXM5LSd1yqFF5ngUOzVba7CjG9GZ70pRkJGzguuAyG5GJ2WhY8Ap
	h8rLl1DPFQZaQkp3Bt52IqsrjapPDHc7pUhs1t6dppY5t4wHm7YnfyJSlS88cHkZjeuDSoSTeYm
	oPo0ZwYFhvbVLU3cucSBxbpiJ23bNuHH2ZAMkQPDIxNnnUZMYLECqvt4Vf+osnbptQsudSOCjd+
	zMrCpIbCwBg97FC3QT78gCuqHBVPRA+KrEGLoufjoKc6+Y7YtJ6F8mYoGQfbjdl+yEOCJrHe/Nt
	6iwi0RX8lD8L91S9EMVYKFxL09cTAFWxc9bVo9psOfNScKwDrlOczuodpFQyYAEzRfPW3yfL8UX
	FiiMjH7z9ExnoeuT5jb5oyP5oRJyZJKmPTHSGY4/AfC2IEVYmMg9fx3
X-Received: by 2002:a17:90b:4a89:b0:3a4:f6b0:7de with SMTP id 98e67ed59e1d1-3a8a08515acmr4473982a91.22.1791453561343;
        Thu, 08 Oct 2026 02:59:21 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2100:3ace:b801:9432:769f:ff9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ff13esm3422790a91.7.2026.10.08.02.59.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:59:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 8/9] selftests/livepatch: Add state test for provides/obsoletes
Date: Thu,  8 Oct 2026 17:58:29 +0800
Message-ID: <20261008095830.26308-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261008095830.26308-1-laoar.shao@gmail.com>
References: <20261008095830.26308-1-laoar.shao@gmail.com>
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
index 78a644f6ec56..b92188fcf45f 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -6,6 +6,8 @@
 
 MOD_MEMINFO=test_klp_meminfo_lp
 MOD_CMDLINE=test_klp_cmdline_lp
+MOD_STATE=test_klp_state
+MOD_STATE2=test_klp_state2
 
 setup_config
 detect_provides_attr
@@ -226,4 +228,241 @@ livepatch: '$MOD_MEMINFO': completing unpatching transition
 livepatch: '$MOD_MEMINFO': unpatching complete
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

