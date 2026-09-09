Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23E2F3621
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921834; cv=none; b=Jmt6nUtDFgbt8uAV5I+I6D58nAoh0456wuarsxaKFfXLvgONJdMhvJyUuM40o+9D4RYoaj1W8xH+qzK+ki+YeoBY+p+UPQyJA30jAeb4TBqM3IlAtQOj6sFiYlSNFQem9b1AKKkYEe36sx/DDB8jDwsla8yAvWff3WS+Y7E4zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921834; c=relaxed/simple;
	bh=ONBKCVeSfig5Q2j6Il7Pi4GaSfm1OZyhEszQoSFF1YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P93N8fgyq48EboYzR4/z7QxHoEffubScpiu1pIyzdd+IjxYCnZXx9NXczYtwmKbyLPfczl4UMt/NsCwfBGT1Dz06aXlphuh67HzzpCmoqAeUKKEp05jm5s7AzMVWgd0VZM7KpWCKfE6tYnTIwnRy49XGJwPpRswwz5bldNr5o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDphoOus; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDphoOus"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso3999981a91.1
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921831; x=1789526631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3Jg+Er/sIdItQPvzwYC5I6GQS+CGRIR8Qiqjy++5VM=;
        b=YDphoOusqVRxCJYO8lhwJJnCAXMoZh71LGm2RycE7ieHfnzh7epbRWa4hWLoRO/L8c
         qaa0q3CsCsiA8dA6WWtlZfIuc/lIDxNLdLiNs56ZbX23RGQ9D85hvpPGXWcZVdmX/r4z
         L+IrRio67dVrZRxxl1xFpC3xQIj0Jw/ORZ7HhLrXbruO6bGOhEV4ySOfaTRXUUfeb/+0
         UKz/wJ2OyX4XZiCIJEO12IKore0AP8AkcuWdYS/t/fV6dFftZRPlRfii+gA6fxeOCSqM
         MA5nCu1dRgABTf4B/bmAYElMgE9oi6e0enQicOKkW+dqFnwzD1qe3LXqKAfKv8xmELvW
         r/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921831; x=1789526631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o3Jg+Er/sIdItQPvzwYC5I6GQS+CGRIR8Qiqjy++5VM=;
        b=TjiqL1YPDxBaCLDIqje8+CB245N8iftfIKjep2M8g83AnKc3oxyGM4ZzSTMC4ELvbD
         uVmDJZKwAnrSof8id2nLb+TBEve0EqAlaavwX7gmP9Nt/nZ7C27nEs4/hCpHqifvRVMJ
         UC53FQXW0uBxVOMF9R+FhADniLOXFZtKWmWNTDYBL90QYFvjcpGbzKK25xj0VKS2AJ3e
         //EbSQlR0P9wSb14W3b1j8mLMrBTFKSB/cbGS5t7rr7XG+tg7PjAcLJC+I7G5W0of+YL
         l2S8/jFQb1lorB61hxVTQey/rN9e34PEaAU7IbaND6I8QnuHawPy6Rl3Hovio/F7e+Tn
         esHw==
X-Gm-Message-State: AFuF++ka6enGY2z7gNAdPDc35wX4IsZdbYQr88VsI7YxAVJmRvzttBDs
	+NpDgJ+15f/ZsoFYPB/fBvlEPO/3oXVMmpDiZ64rh7i+t9m4MF+ydHn2
X-Gm-Gg: AYBFou3CWYHLzVVEIJbD9DEYpcADGGNyzVMFwf4geJFSMzNLfwMYgFBzC8eMVBNAAhN
	5aNIiZIrkhu47UcteeE3gK2koC3NQtXFfUsxKCWBNtuGUwrQdX1kJKqrpfDZMnSdhh9K2PWNdHv
	31jLmb2zOTJSps1eeIJXm8Jh31CxdzJjbyaSRX8+E54CwYvvMGChAdFoj2lSQLjtVR0xrPcdh6n
	ovUW687eAZoHNZjV5FTe5YcGIZrDHMnr5emCPKbl7UX74CXxl9f9Ov9UhbDqGrHqPXtL12E5fhX
	tapm7YJLoGJQb4z1EaVFlcGV1orqOGnixQJ05J+UGxuSTJYTzFjK8o60FpeGunswuiaLMXsd8wB
	biV4ffyB2aCgxjq2lgOChDn8Lqjtfoday4DcKH6m7r+a7wjb1hnMiz2Ajdz3ntQlg5mxeqlLuqa
	51RCcFSbshvlvWpu72LRJhMkcnmpkyfj9pEtmrI6NJ+UfTpQCft+vSq8DC25Jj4DVkctg9NGysN
	B38/f/jVBTWAS+xXGuVUdPZpFxtfAvR0Du1TsZsI8g62eknVm7nEPiI2/vSpJvr1DTN5Q==
X-Received: by 2002:a17:90b:3852:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39b26272d69mr49018577a91.16.1788921831395;
        Tue, 08 Sep 2026 19:43:51 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.43.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:43:51 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Wed,  9 Sep 2026 10:43:17 +0800
Message-ID: <20260909024324.16002-3-laoar.shao@gmail.com>
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

The legacy "replace" field in struct klp_patch will be replaced by the
provides/obsoletes mechanism. As a result, the atomic replace
selftests fail to build against kernels that only support
provides/obsoletes.

Adapt the selftests so that they build and run on both old and new
kernels.  On kernels without the legacy "replace" support, the
replace-related test cases are skipped with a SKIP message instead
of being run.

The provides/obsoletes based selftests will be added later after the
provides/obsoletes are substituted.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../testing/selftests/livepatch/functions.sh  |  30 ++
 .../selftests/livepatch/test-callbacks.sh     | 209 ++++++------
 .../selftests/livepatch/test-livepatch.sh     | 303 +++++++++---------
 .../test_modules/test_klp_callbacks_demo2.c   |  16 +
 .../test_modules/test_klp_meminfo_lp.c        |  16 +
 .../livepatch/test_modules/test_klp_state.c   |   7 +
 .../livepatch/test_modules/test_klp_state2.c  |   7 +
 7 files changed, 347 insertions(+), 241 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 8352c8d509a5..11f3b87cae4c 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -314,6 +314,15 @@ function start_test {
 	log "===== TEST: $test ====="
 }
 
+function skip_test {
+	local test="$1"
+	local reason="$2"
+
+	echo -n "TEST: $test ... "
+	echo "SKIP ($reason)"
+	log "===== TEST: $test SKIPPED: $reason ====="
+}
+
 # check_result() - verify dmesg output
 #	TODO - better filter, out of order msgs, etc?
 function check_result {
@@ -357,6 +366,27 @@ function does_sysfs_exist() {
 	[[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
 }
 
+# detect_provides_attr() - detect whether the running kernel supports the
+# livepatch "provides" attribute and set HAS_PROVIDES_ATTR accordingly.
+# The provides/obsoletes based tests are only run when HAS_PROVIDES_ATTR
+# is set.
+function detect_provides_attr() {
+	HAS_PROVIDES_ATTR=0
+
+	if [[ -r /proc/config.gz ]] &&
+	   zgrep -q "CONFIG_KLP_HAS_PROVIDES=y" /proc/config.gz 2>/dev/null; then
+		HAS_PROVIDES_ATTR=1
+		return 0
+	fi
+
+	load_lp test_klp_cmdline_lp
+	if does_sysfs_exist test_klp_cmdline_lp "provides"; then
+		HAS_PROVIDES_ATTR=1
+	fi
+	disable_lp test_klp_cmdline_lp
+	unload_lp test_klp_cmdline_lp
+}
+
 # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
 # path permissions
 #	modname - livepatch module creating the sysfs interface
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 2a03deb26a12..bda73853d2d1 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -10,6 +10,7 @@ MOD_TARGET=test_klp_callbacks_mod
 MOD_TARGET_BUSY=test_klp_callbacks_busy
 
 setup_config
+detect_provides_attr
 
 
 # Test a combination of loading a kernel module and a livepatch that
@@ -451,103 +452,117 @@ $MOD_TARGET_BUSY: busymod_work_func exit
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-# Test loading multiple livepatches.  This test-case is mainly for comparing
-# with the next test-case.
-#
-# - Load and unload two livepatches, pre and post (un)patch callbacks
-#   execute as each patch progresses through its (un)patching
-#   transition.
-
-start_test "multiple livepatches"
-
-load_lp $MOD_LIVEPATCH
-load_lp $MOD_LIVEPATCH2
-disable_lp $MOD_LIVEPATCH2
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH
-
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-$MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-$MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
-% insmod test_modules/$MOD_LIVEPATCH2.ko
-livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
-$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
-$MOD_LIVEPATCH2: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': patching complete
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
-$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
-$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
-$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': unpatching complete
-% rmmod $MOD_LIVEPATCH2
-% rmmod $MOD_LIVEPATCH"
-
-
-# Load multiple livepatches, but the second as an 'atomic-replace'
-# patch.  When the latter loads, the original livepatch should be
-# disabled and *none* of its pre/post-unpatch callbacks executed.  On
-# the other hand, when the atomic-replace livepatch is disabled, its
-# pre/post-unpatch callbacks *should* be executed.
-#
-# - Load and unload two livepatches, the second of which has its
-#   .replace flag set true.
-#
-# - Pre and post patch callbacks are executed for both livepatches.
-#
-# - Once the atomic replace module is loaded, only its pre and post
-#   unpatch callbacks are executed.
-
-start_test "atomic replace"
-
-load_lp $MOD_LIVEPATCH
-load_lp $MOD_LIVEPATCH2 replace=1
-disable_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH
-
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-$MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-$MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
-% insmod test_modules/$MOD_LIVEPATCH2.ko replace=1
-livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
-$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
-$MOD_LIVEPATCH2: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': patching complete
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
-$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
-$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
-% rmmod $MOD_LIVEPATCH2
-% rmmod $MOD_LIVEPATCH"
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	# Test loading multiple livepatches.  This test-case is mainly for comparing
+	# with the next test-case.
+	#
+	# - Load and unload two livepatches, pre and post (un)patch callbacks
+	#   execute as each patch progresses through its (un)patching
+	#   transition.
+
+	start_test "multiple livepatches"
+
+	load_lp $MOD_LIVEPATCH
+	load_lp $MOD_LIVEPATCH2
+	disable_lp $MOD_LIVEPATCH2
+	disable_lp $MOD_LIVEPATCH
+	unload_lp $MOD_LIVEPATCH2
+	unload_lp $MOD_LIVEPATCH
+
+	check_result "$(cat <<EOF | sed 's/^[[:space:]]*//'
+	% insmod test_modules/$MOD_LIVEPATCH.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH'
+	livepatch: '$MOD_LIVEPATCH': initializing patching transition
+	$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH': starting patching transition
+	livepatch: '$MOD_LIVEPATCH': completing patching transition
+	$MOD_LIVEPATCH: post_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH': patching complete
+	% insmod test_modules/$MOD_LIVEPATCH2.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH2'
+	livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+	$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': starting patching transition
+	livepatch: '$MOD_LIVEPATCH2': completing patching transition
+	$MOD_LIVEPATCH2: post_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': patching complete
+	% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
+	livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+	$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
+	livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+	$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': unpatching complete
+	% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+	livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+	$MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+	livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+	$MOD_LIVEPATCH: post_unpatch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH': unpatching complete
+	% rmmod $MOD_LIVEPATCH2
+	% rmmod $MOD_LIVEPATCH
+EOF
+	)"
+else
+	skip_test "multiple livepatches" "legacy replace attribute not present"
+fi
+
+
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	# Load multiple livepatches, but the second as an 'atomic-replace'
+	# patch.  When the latter loads, the original livepatch should be
+	# disabled and *none* of its pre/post-unpatch callbacks executed.  On
+	# the other hand, when the atomic-replace livepatch is disabled, its
+	# pre/post-unpatch callbacks *should* be executed.
+	#
+	# - Load and unload two livepatches, the second of which has its
+	#   .replace flag set true.
+	#
+	# - Pre and post patch callbacks are executed for both livepatches.
+	#
+	# - Once the atomic replace module is loaded, only its pre and post
+	#   unpatch callbacks are executed.
+
+	start_test "atomic replace"
+
+	load_lp $MOD_LIVEPATCH
+	load_lp $MOD_LIVEPATCH2 replace=1
+	disable_lp $MOD_LIVEPATCH2
+	unload_lp $MOD_LIVEPATCH2
+	unload_lp $MOD_LIVEPATCH
+
+	check_result "$(cat <<EOF | sed 's/^[[:space:]]*//'
+	% insmod test_modules/$MOD_LIVEPATCH.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH'
+	livepatch: '$MOD_LIVEPATCH': initializing patching transition
+	$MOD_LIVEPATCH: pre_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH': starting patching transition
+	livepatch: '$MOD_LIVEPATCH': completing patching transition
+	$MOD_LIVEPATCH: post_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH': patching complete
+	% insmod test_modules/$MOD_LIVEPATCH2.ko replace=1
+	livepatch: enabling patch '$MOD_LIVEPATCH2'
+	livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+	$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': starting patching transition
+	livepatch: '$MOD_LIVEPATCH2': completing patching transition
+	$MOD_LIVEPATCH2: post_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': patching complete
+	% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
+	livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+	$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
+	livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+	$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH2': unpatching complete
+	% rmmod $MOD_LIVEPATCH2
+	% rmmod $MOD_LIVEPATCH
+EOF
+	)"
+else
+	skip_test "atomic replace" "legacy replace attribute not present"
+fi
 
 
 exit 0
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 5380b5f174d4..e6a278646ed0 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -12,6 +12,7 @@ MOD_TARGET=test_klp_mod_target
 MOD_TARGET_PATCH=test_klp_mod_patch
 
 setup_config
+detect_provides_attr
 
 
 # - load a livepatch that modifies the output from /proc/cmdline and
@@ -49,153 +50,167 @@ livepatch: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
 
 
-# - load a livepatch that modifies the output from /proc/cmdline and
-#   verify correct behavior
-# - load another livepatch and verify that both livepatches are active
-# - unload the second livepatch and verify that the first is still active
-# - unload the first livepatch and verify none are active
-
-start_test "multiple livepatches"
-
-load_lp $MOD_LIVEPATCH1
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-load_lp $MOD_REPLACE replace=0
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-disable_lp $MOD_REPLACE
-unload_lp $MOD_REPLACE
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-disable_lp $MOD_LIVEPATCH1
-unload_lp $MOD_LIVEPATCH1
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
-livepatch: enabling patch '$MOD_LIVEPATCH1'
-livepatch: '$MOD_LIVEPATCH1': initializing patching transition
-livepatch: '$MOD_LIVEPATCH1': starting patching transition
-livepatch: '$MOD_LIVEPATCH1': completing patching transition
-livepatch: '$MOD_LIVEPATCH1': patching complete
-$MOD_LIVEPATCH1: this has been live patched
-% insmod test_modules/$MOD_REPLACE.ko replace=0
-livepatch: enabling patch '$MOD_REPLACE'
-livepatch: '$MOD_REPLACE': initializing patching transition
-livepatch: '$MOD_REPLACE': starting patching transition
-livepatch: '$MOD_REPLACE': completing patching transition
-livepatch: '$MOD_REPLACE': patching complete
-$MOD_LIVEPATCH1: this has been live patched
-$MOD_REPLACE: this has been live patched
-% echo 0 > $SYSFS_KLP_DIR/$MOD_REPLACE/enabled
-livepatch: '$MOD_REPLACE': initializing unpatching transition
-livepatch: '$MOD_REPLACE': starting unpatching transition
-livepatch: '$MOD_REPLACE': completing unpatching transition
-livepatch: '$MOD_REPLACE': unpatching complete
-% rmmod $MOD_REPLACE
-$MOD_LIVEPATCH1: this has been live patched
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH1/enabled
-livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH1': unpatching complete
-% rmmod $MOD_LIVEPATCH1"
-
-
-# - load a livepatch that modifies the output from /proc/cmdline and
-#   verify correct behavior
-# - load two additional livepatches and check the number of livepatch modules
-#   applied
-# - load an atomic replace livepatch and check that the other three modules were
-#   disabled
-# - remove all livepatches besides the atomic replace one and verify that the
-#   atomic replace livepatch is still active
-# - remove the atomic replace livepatch and verify that none are active
-
-start_test "atomic replace livepatch"
-
-load_lp $MOD_LIVEPATCH1
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-for mod in $MOD_LIVEPATCH2 $MOD_LIVEPATCH3; do
-	load_lp "$mod"
-done
-
-mods=($SYSFS_KLP_DIR/*)
-nmods=${#mods[@]}
-if [ "$nmods" -ne 3 ]; then
-	die "Expecting three modules listed, found $nmods"
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	# - load a livepatch that modifies the output from /proc/cmdline and
+	#   verify correct behavior
+	# - load another livepatch and verify that both livepatches are active
+	# - unload the second livepatch and verify that the first is still active
+	# - unload the first livepatch and verify none are active
+
+	start_test "multiple livepatches"
+
+	load_lp $MOD_LIVEPATCH1
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	load_lp $MOD_REPLACE replace=0
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	disable_lp $MOD_REPLACE
+	unload_lp $MOD_REPLACE
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	disable_lp $MOD_LIVEPATCH1
+	unload_lp $MOD_LIVEPATCH1
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	check_result "$(cat <<-EOF | sed 's/^[[:space:]]*//'
+	% insmod test_modules/$MOD_LIVEPATCH1.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH1'
+	livepatch: '$MOD_LIVEPATCH1': initializing patching transition
+	livepatch: '$MOD_LIVEPATCH1': starting patching transition
+	livepatch: '$MOD_LIVEPATCH1': completing patching transition
+	livepatch: '$MOD_LIVEPATCH1': patching complete
+	$MOD_LIVEPATCH1: this has been live patched
+	% insmod test_modules/$MOD_REPLACE.ko replace=0
+	livepatch: enabling patch '$MOD_REPLACE'
+	livepatch: '$MOD_REPLACE': initializing patching transition
+	livepatch: '$MOD_REPLACE': starting patching transition
+	livepatch: '$MOD_REPLACE': completing patching transition
+	livepatch: '$MOD_REPLACE': patching complete
+	$MOD_LIVEPATCH1: this has been live patched
+	$MOD_REPLACE: this has been live patched
+	% echo 0 > $SYSFS_KLP_DIR/$MOD_REPLACE/enabled
+	livepatch: '$MOD_REPLACE': initializing unpatching transition
+	livepatch: '$MOD_REPLACE': starting unpatching transition
+	livepatch: '$MOD_REPLACE': completing unpatching transition
+	livepatch: '$MOD_REPLACE': unpatching complete
+	% rmmod $MOD_REPLACE
+	$MOD_LIVEPATCH1: this has been live patched
+	% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH1/enabled
+	livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
+	livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
+	livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
+	livepatch: '$MOD_LIVEPATCH1': unpatching complete
+	% rmmod $MOD_LIVEPATCH1
+EOF
+	)"
+else
+	skip_test "multiple livepatches" "legacy replace attribute not present"
 fi
 
-load_lp $MOD_REPLACE replace=1
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
 
-loop_until 'mods=($SYSFS_KLP_DIR/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
-        die "Expecting only one moduled listed, found $nmods"
-
-# These modules were disabled by the atomic replace
-for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
-	unload_lp "$mod"
-done
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-disable_lp $MOD_REPLACE
-unload_lp $MOD_REPLACE
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
-check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
-livepatch: enabling patch '$MOD_LIVEPATCH1'
-livepatch: '$MOD_LIVEPATCH1': initializing patching transition
-livepatch: '$MOD_LIVEPATCH1': starting patching transition
-livepatch: '$MOD_LIVEPATCH1': completing patching transition
-livepatch: '$MOD_LIVEPATCH1': patching complete
-$MOD_LIVEPATCH1: this has been live patched
-% insmod test_modules/$MOD_LIVEPATCH2.ko
-livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
-livepatch: '$MOD_LIVEPATCH2': patching complete
-% insmod test_modules/$MOD_LIVEPATCH3.ko
-livepatch: enabling patch '$MOD_LIVEPATCH3'
-livepatch: '$MOD_LIVEPATCH3': initializing patching transition
-$MOD_LIVEPATCH3: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH3': starting patching transition
-livepatch: '$MOD_LIVEPATCH3': completing patching transition
-$MOD_LIVEPATCH3: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH3': patching complete
-% insmod test_modules/$MOD_REPLACE.ko replace=1
-livepatch: enabling patch '$MOD_REPLACE'
-livepatch: '$MOD_REPLACE': initializing patching transition
-livepatch: '$MOD_REPLACE': starting patching transition
-livepatch: '$MOD_REPLACE': completing patching transition
-livepatch: '$MOD_REPLACE': patching complete
-$MOD_REPLACE: this has been live patched
-% rmmod $MOD_LIVEPATCH3
-% rmmod $MOD_LIVEPATCH2
-% rmmod $MOD_LIVEPATCH1
-$MOD_REPLACE: this has been live patched
-% echo 0 > $SYSFS_KLP_DIR/$MOD_REPLACE/enabled
-livepatch: '$MOD_REPLACE': initializing unpatching transition
-livepatch: '$MOD_REPLACE': starting unpatching transition
-livepatch: '$MOD_REPLACE': completing unpatching transition
-livepatch: '$MOD_REPLACE': unpatching complete
-% rmmod $MOD_REPLACE"
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	# - load a livepatch that modifies the output from /proc/cmdline and
+	#   verify correct behavior
+	# - load two additional livepatches and check the number of livepatch modules
+	#   applied
+	# - load an atomic replace livepatch and check that the other three modules were
+	#   disabled
+	# - remove all livepatches besides the atomic replace one and verify that the
+	#   atomic replace livepatch is still active
+	# - remove the atomic replace livepatch and verify that none are active
+
+	start_test "atomic replace livepatch"
+
+	load_lp $MOD_LIVEPATCH1
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	for mod in $MOD_LIVEPATCH2 $MOD_LIVEPATCH3; do
+		load_lp "$mod"
+	done
+
+	mods=($SYSFS_KLP_DIR/*)
+	nmods=${#mods[@]}
+	if [ "$nmods" -ne 3 ]; then
+		die "Expecting three modules listed, found $nmods"
+	fi
+
+	load_lp $MOD_REPLACE replace=1
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	loop_until 'mods=($SYSFS_KLP_DIR/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
+		die "Expecting only one moduled listed, found $nmods"
+
+	# These modules were disabled by the atomic replace
+	for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
+		unload_lp "$mod"
+	done
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	disable_lp $MOD_REPLACE
+	unload_lp $MOD_REPLACE
+
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
+
+	check_result "$(cat <<EOF | sed 's/^[[:space:]]*//'
+	% insmod test_modules/$MOD_LIVEPATCH1.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH1'
+	livepatch: '$MOD_LIVEPATCH1': initializing patching transition
+	livepatch: '$MOD_LIVEPATCH1': starting patching transition
+	livepatch: '$MOD_LIVEPATCH1': completing patching transition
+	livepatch: '$MOD_LIVEPATCH1': patching complete
+	$MOD_LIVEPATCH1: this has been live patched
+	% insmod test_modules/$MOD_LIVEPATCH2.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH2'
+	livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+	livepatch: '$MOD_LIVEPATCH2': starting patching transition
+	livepatch: '$MOD_LIVEPATCH2': completing patching transition
+	livepatch: '$MOD_LIVEPATCH2': patching complete
+	% insmod test_modules/$MOD_LIVEPATCH3.ko
+	livepatch: enabling patch '$MOD_LIVEPATCH3'
+	livepatch: '$MOD_LIVEPATCH3': initializing patching transition
+	$MOD_LIVEPATCH3: pre_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH3': starting patching transition
+	livepatch: '$MOD_LIVEPATCH3': completing patching transition
+	$MOD_LIVEPATCH3: post_patch_callback: vmlinux
+	livepatch: '$MOD_LIVEPATCH3': patching complete
+	% insmod test_modules/$MOD_REPLACE.ko replace=1
+	livepatch: enabling patch '$MOD_REPLACE'
+	livepatch: '$MOD_REPLACE': initializing patching transition
+	livepatch: '$MOD_REPLACE': starting patching transition
+	livepatch: '$MOD_REPLACE': completing patching transition
+	livepatch: '$MOD_REPLACE': patching complete
+	$MOD_REPLACE: this has been live patched
+	% rmmod $MOD_LIVEPATCH3
+	% rmmod $MOD_LIVEPATCH2
+	% rmmod $MOD_LIVEPATCH1
+	$MOD_REPLACE: this has been live patched
+	% echo 0 > $SYSFS_KLP_DIR/$MOD_REPLACE/enabled
+	livepatch: '$MOD_REPLACE': initializing unpatching transition
+	livepatch: '$MOD_REPLACE': starting unpatching transition
+	livepatch: '$MOD_REPLACE': completing unpatching transition
+	livepatch: '$MOD_REPLACE': unpatching complete
+	% rmmod $MOD_REPLACE
+EOF
+	)"
+else
+	skip_test "atomic replace livepatch" "legacy replace attribute not present"
+fi
 
 
 # - load a target module that provides /proc/test_klp_mod_target with
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573e80af..de4eabd4b924 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -7,9 +7,16 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifndef CONFIG_KLP_HAS_PROVIDES
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
+#ifndef CONFIG_KLP_HAS_PROVIDES
 	/* set .replace in the init function below for demo purposes */
+#endif
 };
 
 static int test_klp_callbacks_demo2_init(void)
 {
+#ifndef CONFIG_KLP_HAS_PROVIDES
 	patch.replace = replace;
+#else
+	/*
+	 * TODO: Set provides/obsoletes from the module parameters
+	 * for the provides/obsoletes based tests (to be added later).
+	 */
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
index f2477b217aab..842efa5b22db 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
@@ -7,9 +7,16 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifndef CONFIG_KLP_HAS_PROVIDES
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
+#ifndef CONFIG_KLP_HAS_PROVIDES
 	/* set .replace in the init function below for demo purposes */
+#endif
 };
 
 static int test_klp_meminfo_lp_init(void)
 {
+#ifndef CONFIG_KLP_HAS_PROVIDES
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
index 57a4253acb01..69825ea8d65d 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -142,7 +142,14 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
+#ifndef CONFIG_KLP_HAS_PROVIDES
 	.replace = true,
+#else
+	/*
+	 * TODO: Add provides/obsoletes module parameters for the
+	 * provides/obsoletes based tests (to be added later).
+	 */
+#endif
 };
 
 static int test_klp_callbacks_demo_init(void)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index c978ea4d5e67..3274f084b035 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -171,7 +171,14 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
+#ifndef CONFIG_KLP_HAS_PROVIDES
 	.replace = true,
+#else
+	/*
+	 * TODO: Add provides/obsoletes module parameters for the
+	 * provides/obsoletes based tests (to be added later).
+	 */
+#endif
 };
 
 static int test_klp_callbacks_demo_init(void)
-- 
2.52.0

