Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924335C1AD
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267394; cv=none; b=lEaRDrniGPWOQo2QA6c0AyG0HLmicE8MQ2S/XZK6/XH1zC9eL6K89+HkT3j6geu3twSzHk45w/TEnNXNoIw3iUUUivTNunDrgJiuewjXsVdxOLYZJbXHbPJqAMTCJvr1mda+oZCwJ2rVPr7RhXt41IgEUubAx7JNLikWjzDxVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267394; c=relaxed/simple;
	bh=jyfhks8WNGeivoqRxKYVxKCf4PobqDXC+jhMRRMs2PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjyF7prj8tY2KxH9nWqzoCDgMBDRYV9Lo/RXH4uJ8zY8hsAGbRt8xpoKk3hUOy2tH5FV+rm0JL+1GJOBql8uh/+rd0SqcQ9hq8aOwpTLFTwhx0rxUnGV4QwcvNaSJBWXowHaixY1DOEQNNNY2zZVDRTns48oMizyUhVcHJ54ZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgmzOtdH; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgmzOtdH"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso603807a91.0
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789267391; x=1789872191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1FwwKrL3t51P5PfngpOTDzNUhKhomJ52blZVcZLSio=;
        b=IgmzOtdHbEThnJvZuB1LctOqh1kpitSLonXVYCSEpLrgo5zxvNaNf4XnLeOvRny6C8
         zrZDuxHpbV0E5RF9usDifP8UmoAm92fsLiTtwIhqUJC4UfTZc67PGhmGUgcpDzAr/41h
         KYKLARbwrIQaMLS6g4Tst4wUnYk/VmHtrc1n8aEc9Au62hAREHQnsoXcXxMK3W4PoFCJ
         Z9OlrmQK50FKCo2M894l5MkSLyfjdsUQ7urtudbS3nTgNZnvsHvmmUYiOBX/Da9htTPP
         Q2x/grjJnHYP8kNkCL2BcMV+E7TYD58qV5aivttBa6iq4Yb/2HXgKGNPMBJ8Nfn7xFis
         Kksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267391; x=1789872191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1FwwKrL3t51P5PfngpOTDzNUhKhomJ52blZVcZLSio=;
        b=WL3hFq6JjA8g8KqgvLSQ1RrCy+BxLVdH/v7azP/IsI53xamx07iiu7Y+eLHM0xDFhK
         L36B9e+DoSwZWK5JUZeuQBe1zHEw/JtsH81Jn20VEGoJw7THxK741hqKlr3LV750B14F
         65VTY2ewgg5c3c1rg0E3m9TPYUqZoVgEdsIUpRmk8O2jLTHjSrWvES6VUoIY6FeL1vNA
         pi2F8+X38K9kCObNqaTMeqOw4Ia4Aj5vCfjiriskUQhRxwYhgeiP+yLM9llCbzTObgFi
         IDCfoXupgYO43V95OIXhm2pXX31/oQomRVjWhp3sRJZAJTxX6p4xVStoprJk5FrROxmT
         2qBw==
X-Gm-Message-State: AFuF++n0DBgnRq1TAEyKihoZtDCloDvJJXvvmqORSK+tvYDPACxxTAMX
	JSqSOHCAGDx35i2YmQXAtUEpmzWefDh9mxBQGIg7QXzW+Ap/qCJv0MiE
X-Gm-Gg: AYBFou2g7+sNFdZZF/xwKm7EgADbVv7+NQ7fErZ/dPHd6mU5RT5Zz28izYehSyMw2fV
	+mkteSetppNa/UbnaQJ7QVMS+pcCCCILFcuBs9lCOENOpqtV0YOUOsGF3EwmC+Wz+ubDPqQ8OFC
	IDdRZRw+YuAKk0DgHGjEDbiiwV3LK45DyroslvJ+j7Y0rsqSiKnusITg8xw6ZYLwgHbhaCrfFxQ
	BZj9iyGXw0M4IygFNHeRMY8EBbQ7qBhfufcWqVwsAslFJuKxAb184qRpmasDQPa4w8MgZ0arGya
	rjtxp9AG6iXUoM8AUOB6ELcW2ntUsys7XhivDgHFusVc8WgnQAza31DwmcGOMSQvd1pa1of1//V
	hgryYFMiRU8Ub/G7ZBbC5lIFlSCBGcM9VpqU/TsqHdGDNOAULTX4jdBKUaMQldhrMwWzow71XHZ
	flR0QouvzBE+W54+5GsdV5v3OnHtoeU9GfBvzkEZiGtLj7Ag1MYS1r3ftqCPGn6cyqD16BWW5MO
	zTPwzBlXfTcbzCmhX3rwUvsBq0UmvHxJDcEBE/9LB4utusup1h/zjouFzhNP3wSFlFfMuAaXpv/
	q6Qe
X-Received: by 2002:a17:90b:4fc1:b0:398:c3a3:dbd0 with SMTP id 98e67ed59e1d1-39dbc0c2de3mr9423746a91.8.1789267391402;
        Sat, 12 Sep 2026 19:43:11 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:1e66:594b:84e9:394f:396d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm12730756a91.9.2026.09.12.19.43.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:43:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Sun, 13 Sep 2026 10:42:21 +0800
Message-ID: <20260913024228.72317-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260913024228.72317-1-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
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
Acked-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/livepatch/functions.sh  |  30 ++++++
 .../selftests/livepatch/test-callbacks.sh     |  43 +++++---
 .../selftests/livepatch/test-livepatch.sh     | 102 ++++++++++--------
 .../test_modules/test_klp_callbacks_demo2.c   |  16 +++
 .../test_modules/test_klp_meminfo_lp.c        |  16 +++
 .../livepatch/test_modules/test_klp_state.c   |   7 ++
 .../livepatch/test_modules/test_klp_state2.c  |   7 ++
 7 files changed, 162 insertions(+), 59 deletions(-)

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
index 2a03deb26a12..346248f3488b 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -10,6 +10,7 @@ MOD_TARGET=test_klp_callbacks_mod
 MOD_TARGET_BUSY=test_klp_callbacks_busy
 
 setup_config
+detect_provides_attr
 
 
 # Test a combination of loading a kernel module and a livepatch that
@@ -458,16 +459,17 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 #   execute as each patch progresses through its (un)patching
 #   transition.
 
-start_test "multiple livepatches"
+function test_multiple_livepatches() {
+	start_test "multiple livepatches"
 
-load_lp $MOD_LIVEPATCH
-load_lp $MOD_LIVEPATCH2
-disable_lp $MOD_LIVEPATCH2
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH
+	load_lp $MOD_LIVEPATCH
+	load_lp $MOD_LIVEPATCH2
+	disable_lp $MOD_LIVEPATCH2
+	disable_lp $MOD_LIVEPATCH
+	unload_lp $MOD_LIVEPATCH2
+	unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+	check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -499,6 +501,7 @@ $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH"
+}
 
 
 # Load multiple livepatches, but the second as an 'atomic-replace'
@@ -515,15 +518,16 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 # - Once the atomic replace module is loaded, only its pre and post
 #   unpatch callbacks are executed.
 
-start_test "atomic replace"
+function test_atomic_replace() {
+	start_test "atomic replace"
 
-load_lp $MOD_LIVEPATCH
-load_lp $MOD_LIVEPATCH2 replace=1
-disable_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH
+	load_lp $MOD_LIVEPATCH
+	load_lp $MOD_LIVEPATCH2 replace=1
+	disable_lp $MOD_LIVEPATCH2
+	unload_lp $MOD_LIVEPATCH2
+	unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+	check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -548,6 +552,15 @@ $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH"
+}
+
 
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	test_multiple_livepatches
+	test_atomic_replace
+else
+	skip_test "multiple livepatches" "legacy replace attribute not present"
+	skip_test "atomic replace" "legacy replace attribute not present"
+fi
 
 exit 0
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 5380b5f174d4..0f182c364476 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -12,6 +12,7 @@ MOD_TARGET=test_klp_mod_target
 MOD_TARGET_PATCH=test_klp_mod_patch
 
 setup_config
+detect_provides_attr
 
 
 # - load a livepatch that modifies the output from /proc/cmdline and
@@ -55,31 +56,32 @@ livepatch: '$MOD_LIVEPATCH1': unpatching complete
 # - unload the second livepatch and verify that the first is still active
 # - unload the first livepatch and verify none are active
 
-start_test "multiple livepatches"
+function test_multiple_livepatches() {
+	start_test "multiple livepatches"
 
-load_lp $MOD_LIVEPATCH1
+	load_lp $MOD_LIVEPATCH1
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-load_lp $MOD_REPLACE replace=0
+	load_lp $MOD_REPLACE replace=0
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-disable_lp $MOD_REPLACE
-unload_lp $MOD_REPLACE
+	disable_lp $MOD_REPLACE
+	unload_lp $MOD_REPLACE
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-disable_lp $MOD_LIVEPATCH1
-unload_lp $MOD_LIVEPATCH1
+	disable_lp $MOD_LIVEPATCH1
+	unload_lp $MOD_LIVEPATCH1
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
+	check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
 livepatch: enabling patch '$MOD_LIVEPATCH1'
 livepatch: '$MOD_LIVEPATCH1': initializing patching transition
 livepatch: '$MOD_LIVEPATCH1': starting patching transition
@@ -107,6 +109,7 @@ livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
+}
 
 
 # - load a livepatch that modifies the output from /proc/cmdline and
@@ -119,46 +122,47 @@ livepatch: '$MOD_LIVEPATCH1': unpatching complete
 #   atomic replace livepatch is still active
 # - remove the atomic replace livepatch and verify that none are active
 
-start_test "atomic replace livepatch"
+function test_atomic_replace_livepatch() {
+	start_test "atomic replace livepatch"
 
-load_lp $MOD_LIVEPATCH1
+	load_lp $MOD_LIVEPATCH1
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-for mod in $MOD_LIVEPATCH2 $MOD_LIVEPATCH3; do
-	load_lp "$mod"
-done
+	for mod in $MOD_LIVEPATCH2 $MOD_LIVEPATCH3; do
+		load_lp "$mod"
+	done
 
-mods=($SYSFS_KLP_DIR/*)
-nmods=${#mods[@]}
-if [ "$nmods" -ne 3 ]; then
-	die "Expecting three modules listed, found $nmods"
-fi
+	mods=($SYSFS_KLP_DIR/*)
+	nmods=${#mods[@]}
+	if [ "$nmods" -ne 3 ]; then
+		die "Expecting three modules listed, found $nmods"
+	fi
 
-load_lp $MOD_REPLACE replace=1
+	load_lp $MOD_REPLACE replace=1
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-loop_until 'mods=($SYSFS_KLP_DIR/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
-        die "Expecting only one moduled listed, found $nmods"
+	loop_until 'mods=($SYSFS_KLP_DIR/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
+		die "Expecting only one moduled listed, found $nmods"
 
-# These modules were disabled by the atomic replace
-for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
-	unload_lp "$mod"
-done
+	# These modules were disabled by the atomic replace
+	for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
+		unload_lp "$mod"
+	done
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-disable_lp $MOD_REPLACE
-unload_lp $MOD_REPLACE
+	disable_lp $MOD_REPLACE
+	unload_lp $MOD_REPLACE
 
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
+	grep 'live patched' /proc/cmdline > /dev/kmsg
+	grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
+	check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
 livepatch: enabling patch '$MOD_LIVEPATCH1'
 livepatch: '$MOD_LIVEPATCH1': initializing patching transition
 livepatch: '$MOD_LIVEPATCH1': starting patching transition
@@ -196,6 +200,16 @@ livepatch: '$MOD_REPLACE': starting unpatching transition
 livepatch: '$MOD_REPLACE': completing unpatching transition
 livepatch: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE"
+}
+
+
+if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
+	test_multiple_livepatches
+	test_atomic_replace_livepatch
+else
+	skip_test "multiple livepatches" "legacy replace attribute not present"
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

