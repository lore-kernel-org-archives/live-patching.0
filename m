Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABC2BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838264; cv=none; b=HYXxCY3fd5pdxdWMaEr9U7hBxQZ/ZPxPOiU8Y+ok0qPeJTsAfdI51ck0GOFeRuYB7Qc9XTwpVMvuLLK8G6nwf7Hj1dzPUAD72ClusAJzA03BQtmfBfPgSjKf5UhefHxvWZakwi1uOV1bkrGtezCEdszKfNf85XRbEOoqKBqXVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838264; c=relaxed/simple;
	bh=83Z60zmpSksRaFw5TEiDtg+x7VUdYioyWnyBymAP/X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O625/8huYospoP8Z+o/b66ivN3ckW5HmGyKXgHJ/jFWGY7OwbpYC7e+BAG4BaMLfbdR4nEPlJlQLhC887s7XA/z6qfu+BZyNb41bGOXb/41jaBehBgekl49R557cyOJ9QioRWcqHA2reAo2BU9SWBkTFm5PWcNICid6af6aaErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqAMmMrT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqAMmMrT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bea7176c72so21759555ad.0
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838261; x=1781443061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxjEruDISpi6flTQfm47ZYo0nkBHxmAshnb/5/NL7fc=;
        b=DqAMmMrTeDjnDC4j3dhWnqhoIRDCp8OYX7Z3ZJcVonhJurpG3O1qzkfRr0Rga0uAMt
         WGsibbPYiIpez32zteXPyiIKdj6wrFkGTExPbtuL2SuF5w6JPD9e0s4Ed34LpRIHxqjy
         48fHDIjm4xuRL+GaLME474o021VkMFfCESuWSUSqAjp73Jf/SlPTIaLp9JLd9sD/HJTx
         zyX3vBkANzk2gWmmBOvV9GiTwtNb1vRd36KEEeJ6MItmADvSkqVY0wNY0PL06nZEYzjX
         SWJOsAIil09Th0CKmyCoMglFopv4vRkK/843MLXpy/LMzKKqGIihYXI0uOw/tEoYxIRO
         rS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838261; x=1781443061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxjEruDISpi6flTQfm47ZYo0nkBHxmAshnb/5/NL7fc=;
        b=ARKZk4HBUBjA63EtybL5H/E1hO+jITipkQ7Nv742K4q5pn9Bcpzwev3mue1MAe6rq4
         ftDFxm5Z2OqwLFvevX5rMwgk01LamIkcY2Hfq+XYTf9u8IS2IcJWJlrG64pjWB/Zx9vP
         dZhXp3dHhKTOFVDJDutwfrX4S1xbz0LGo7aLq5ojoV+wDp6h3utMwiDoI+rzz2k9DEZz
         5FyWZfc42RgBv2Z4YMzLMjk1DmgdJ8kQxfHAPeLJGpypvUhxvxNPFT/+yDPZa16tiAWb
         Br/2mQ+HZT/ltJwgHh1ZCL3Sl1i5ZpnofuYWRuFDMe4/ChIvvLgHab95VFAfB7jW0v4q
         HIxA==
X-Gm-Message-State: AOJu0YwVJ0BSlJqu7JEgYxDfKgLwafKWs2fPFEYaWogDBPtm2eg25pCD
	n0KHK3q5pv1LXNPh93BH9uau3a6zBFlwMLq+TLluIGV/+XzsEzSzvtcv
X-Gm-Gg: Acq92OGO4c3SyPYxOTYorx+niEVBLFL4wY7ls5Nt9Mlax7dfQ5aiLtw2ddU/0UpOiDh
	ty32DQL58vo84DSd0IjngnsZOnh/VgMTZI2mw1mgwoQ+YGOpNkYpMOnfzzAN+E636+8xdK1qj+v
	bVdt97vrI/N/shcxiWWqPJ3pP2vRcPl6s5YSSB1rzf0uWs8KVvG/Lxfg9aY3OplM1ol8Or7iy+V
	eyfZf65JQ9LkuwXPF4E7EcSr7NMAF2w+Hc27D+KJY/uZg6j9R38Codz7K+xYswuX+4taLqzQcfg
	E94cO1obwS9Td/4o9s0L2l8gtBimZZ93rM2pp/ftY5Q0fWPAT9nBeTe4+BQm1LljrSznIarWL9T
	7Act19Ql0AjXS7/IrHuNM9VAnxlAmHew+YNZqAaugInoBvNOKGcFJw8i+cR/zj7tEALc3EwFLsr
	08O4LoLQYs0bibT/LSVfDiPEjdFdGNlvPs+JDsN+wS3qnVjj45T8P48qzQGDEpCxdNEMV7l1mGU
	Zpqmae72ABM
X-Received: by 2002:a17:903:4407:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c1e78df934mr130708145ad.8.1780838261401;
        Sun, 07 Jun 2026 06:17:41 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 5/7] selftests/livepatch: Update tests for replace_set
Date: Sun,  7 Jun 2026 21:16:57 +0800
Message-ID: <20260607131659.29281-6-laoar.shao@gmail.com>
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

The changes are as follows:
- Replace "replace" with "replace_set"
- For atomic-replace test cases, we configure two different livepatches
  that share the same replace_set.
- For non-atomic-replace test cases, we configure multiple livepatches,
  each with a different replace_set.
- Remove the test case that an atomic replace livepatch disables
  multiple existing livepatches

The result are as follows,

$ ./test-callbacks.sh
TEST: target module before livepatch ... ok
TEST: module_coming notifier ... ok
TEST: module_going notifier ... ok
TEST: module_coming and module_going notifiers ... ok
TEST: target module not present ... ok
TEST: pre-patch callback -ENODEV ... ok
TEST: module_coming + pre-patch callback -ENODEV ... ok
TEST: multiple target modules ... ok
TEST: busy target module ... ok
TEST: multiple livepatches ... ok
TEST: atomic replace ... ok

$ ./test-ftrace.sh
TEST: livepatch interaction with ftrace_enabled sysctl ... ok
TEST: trace livepatched function and check that the live patch remains in effect ... ok
TEST: livepatch a traced function and check that the live patch remains in effect ... ok

$ ./test-kprobe.sh
TEST: livepatch interaction with kprobed function with post_handler ... ok
TEST: livepatch interaction with kprobed function without post_handler ... ok

$ ./test-livepatch.sh
TEST: basic function patching ... ok
TEST: multiple livepatches ... ok
TEST: module function patching ... ok
TEST: module function patching (livepatch first) ... ok

$ ./test-shadow-vars.sh
TEST: basic shadow variable API ... ok

$ ./test-state.sh
TEST: system state modification ... ok
TEST: taking over system state modification ... ok
TEST: compatible cumulative livepatches ... ok
TEST: incompatible cumulative livepatches ... ok

$ ./test-syscall.sh
TEST: patch getpid syscall while being heavily hammered ... ok

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/livepatch/test-callbacks.sh     |  33 +++---
 .../selftests/livepatch/test-livepatch.sh     | 100 +-----------------
 .../testing/selftests/livepatch/test-sysfs.sh |  22 ++--
 .../test_modules/test_klp_atomic_replace.c    |  10 +-
 .../test_modules/test_klp_callbacks_demo.c    |   6 ++
 .../test_modules/test_klp_callbacks_demo2.c   |  10 +-
 .../test_modules/test_klp_livepatch.c         |   6 ++
 .../livepatch/test_modules/test_klp_state.c   |   2 +-
 .../livepatch/test_modules/test_klp_state2.c  |   2 +-
 9 files changed, 55 insertions(+), 136 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 2a03deb26a12..692da8ea4c25 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -451,8 +451,8 @@ $MOD_TARGET_BUSY: busymod_work_func exit
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-# Test loading multiple livepatches.  This test-case is mainly for comparing
-# with the next test-case.
+# Test loading multiple livepatches sharing different replace_set.
+# This test-case is mainly for comparing with the next test-case.
 #
 # - Load and unload two livepatches, pre and post (un)patch callbacks
 #   execute as each patch progresses through its (un)patching
@@ -460,14 +460,14 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 start_test "multiple livepatches"
 
-load_lp $MOD_LIVEPATCH
-load_lp $MOD_LIVEPATCH2
+load_lp $MOD_LIVEPATCH replace_set=0
+load_lp $MOD_LIVEPATCH2 replace_set=1
 disable_lp $MOD_LIVEPATCH2
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko replace_set=0
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -475,7 +475,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% insmod test_modules/$MOD_LIVEPATCH2.ko
+% insmod test_modules/$MOD_LIVEPATCH2.ko replace_set=1
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
@@ -501,14 +501,13 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# Load multiple livepatches, but the second as an 'atomic-replace'
-# patch.  When the latter loads, the original livepatch should be
-# disabled and *none* of its pre/post-unpatch callbacks executed.  On
-# the other hand, when the atomic-replace livepatch is disabled, its
-# pre/post-unpatch callbacks *should* be executed.
+# Load multiple livepatches sharing the same replace_set.
+# When the latter loads, the original livepatch should be disabled and
+# *none* of its pre/post-unpatch callbacks executed.  On the other hand,
+# when the atomic-replace livepatch is disabled, its pre/post-unpatch
+# callbacks *should* be executed.
 #
-# - Load and unload two livepatches, the second of which has its
-#   .replace flag set true.
+# - Load and unload two livepatches sharing the same replace_set
 #
 # - Pre and post patch callbacks are executed for both livepatches.
 #
@@ -517,13 +516,13 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 
 start_test "atomic replace"
 
-load_lp $MOD_LIVEPATCH
-load_lp $MOD_LIVEPATCH2 replace=1
+load_lp $MOD_LIVEPATCH replace_set=0
+load_lp $MOD_LIVEPATCH2 replace_set=0
 disable_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko replace_set=0
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -531,7 +530,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% insmod test_modules/$MOD_LIVEPATCH2.ko replace=1
+% insmod test_modules/$MOD_LIVEPATCH2.ko replace_set=0
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index c44c5341a2f1..4f8fb5620c6e 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -5,8 +5,6 @@
 . $(dirname $0)/functions.sh
 
 MOD_LIVEPATCH1=test_klp_livepatch
-MOD_LIVEPATCH2=test_klp_syscall
-MOD_LIVEPATCH3=test_klp_callbacks_demo
 MOD_REPLACE=test_klp_atomic_replace
 MOD_TARGET=test_klp_mod_target
 MOD_TARGET_PATCH=test_klp_mod_patch
@@ -57,12 +55,12 @@ livepatch: '$MOD_LIVEPATCH1': unpatching complete
 
 start_test "multiple livepatches"
 
-load_lp $MOD_LIVEPATCH1
+load_lp $MOD_LIVEPATCH1 replace_set=0
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-load_lp $MOD_REPLACE replace=0
+load_lp $MOD_REPLACE replace_set=1
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
@@ -79,14 +77,14 @@ unload_lp $MOD_LIVEPATCH1
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
+check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko replace_set=0
 livepatch: enabling patch '$MOD_LIVEPATCH1'
 livepatch: '$MOD_LIVEPATCH1': initializing patching transition
 livepatch: '$MOD_LIVEPATCH1': starting patching transition
 livepatch: '$MOD_LIVEPATCH1': completing patching transition
 livepatch: '$MOD_LIVEPATCH1': patching complete
 $MOD_LIVEPATCH1: this has been live patched
-% insmod test_modules/$MOD_REPLACE.ko replace=0
+% insmod test_modules/$MOD_REPLACE.ko replace_set=1
 livepatch: enabling patch '$MOD_REPLACE'
 livepatch: '$MOD_REPLACE': initializing patching transition
 livepatch: '$MOD_REPLACE': starting patching transition
@@ -108,96 +106,6 @@ livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
 
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
-fi
-
-load_lp $MOD_REPLACE replace=1
-
-grep 'live patched' /proc/cmdline > /dev/kmsg
-grep 'live patched' /proc/meminfo > /dev/kmsg
-
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
-
-
 # - load a target module that provides /proc/test_klp_mod_target with
 #   original output
 # - load a livepatch that patches the target module's show function
diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 0c31759f34f6..37425ad89f58 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -20,7 +20,7 @@ check_sysfs_rights "$MOD_LIVEPATCH" "" "drwxr-xr-x"
 check_sysfs_rights "$MOD_LIVEPATCH" "enabled" "-rw-r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "enabled" "1"
 check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
-check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
+check_sysfs_rights "$MOD_LIVEPATCH" "replace_set" "-r--r--r--"
 check_sysfs_rights "$MOD_LIVEPATCH" "transition" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "transition" "0"
 check_sysfs_rights "$MOD_LIVEPATCH" "vmlinux/patched" "-r--r--r--"
@@ -86,18 +86,18 @@ test_klp_callbacks_demo: post_unpatch_callback: vmlinux
 livepatch: 'test_klp_callbacks_demo': unpatching complete
 % rmmod test_klp_callbacks_demo"
 
-start_test "sysfs test replace enabled"
+start_test "sysfs test replace_set 0"
 
 MOD_LIVEPATCH=test_klp_atomic_replace
-load_lp $MOD_LIVEPATCH replace=1
+load_lp $MOD_LIVEPATCH replace_set=0
 
-check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
-check_sysfs_value  "$MOD_LIVEPATCH" "replace" "1"
+check_sysfs_rights "$MOD_LIVEPATCH" "replace_set" "-r--r--r--"
+check_sysfs_value  "$MOD_LIVEPATCH" "replace_set" "0"
 
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko replace=1
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko replace_set=0
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
@@ -110,17 +110,17 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
-start_test "sysfs test replace disabled"
+start_test "sysfs test replace_set 1234"
 
-load_lp $MOD_LIVEPATCH replace=0
+load_lp $MOD_LIVEPATCH replace_set=1234
 
-check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
-check_sysfs_value  "$MOD_LIVEPATCH" "replace" "0"
+check_sysfs_rights "$MOD_LIVEPATCH" "replace_set" "-r--r--r--"
+check_sysfs_value  "$MOD_LIVEPATCH" "replace_set" "1234"
 
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko replace=0
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko replace_set=1234
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
index 5af7093ca00c..5333503f193a 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
@@ -7,9 +7,9 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
-static int replace;
-module_param(replace, int, 0644);
-MODULE_PARM_DESC(replace, "replace (default=0)");
+static int replace_set;
+module_param(replace_set, int, 0644);
+MODULE_PARM_DESC(replace_set, "replace_set (default=0)");
 
 #include <linux/seq_file.h>
 static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
@@ -36,12 +36,12 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
-	/* set .replace in the init function below for demo purposes */
+	/* set .replace_set in the init function below for demo purposes */
 };
 
 static int test_klp_atomic_replace_init(void)
 {
-	patch.replace = replace;
+	patch.replace_set = replace_set;
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
index 3fd8fe1cd1cc..5c3324aa4d75 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
@@ -7,6 +7,10 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+static int replace_set;
+module_param(replace_set, int, 0644);
+MODULE_PARM_DESC(replace_set, "replace_set (default=0)");
+
 static int pre_patch_ret;
 module_param(pre_patch_ret, int, 0644);
 MODULE_PARM_DESC(pre_patch_ret, "pre_patch_ret (default=0)");
@@ -102,10 +106,12 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
+	/* set .replace_set in the init function below for demo purposes */
 };
 
 static int test_klp_callbacks_demo_init(void)
 {
+	patch.replace_set = replace_set;
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573e80af..31347e2131a7 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -7,9 +7,9 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
-static int replace;
-module_param(replace, int, 0644);
-MODULE_PARM_DESC(replace, "replace (default=0)");
+static int replace_set;
+module_param(replace_set, int, 0644);
+MODULE_PARM_DESC(replace_set, "replace_set (default=0)");
 
 static const char *const module_state[] = {
 	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",
@@ -72,12 +72,12 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
-	/* set .replace in the init function below for demo purposes */
+	/* set .replace_set in the init function below for demo purposes */
 };
 
 static int test_klp_callbacks_demo2_init(void)
 {
-	patch.replace = replace;
+	patch.replace_set = replace_set;
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
index aff08199de71..fedd2494d187 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
@@ -15,6 +15,10 @@ static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int replace_set;
+module_param(replace_set, int, 0644);
+MODULE_PARM_DESC(replace_set, "replace_set (default=0)");
+
 static struct klp_func funcs[] = {
 	{
 		.old_name = "cmdline_proc_show",
@@ -32,10 +36,12 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
+	/* set .replace_set in the init function below for demo purposes */
 };
 
 static int test_klp_livepatch_init(void)
 {
+	patch.replace_set = replace_set;
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 57a4253acb01..8c8829c3ec43 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -142,7 +142,7 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
-	.replace = true,
+	.replace_set = 0,
 };
 
 static int test_klp_callbacks_demo_init(void)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index c978ea4d5e67..8a79d7dcce33 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -171,7 +171,7 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
-	.replace = true,
+	.replace_set = 0,
 };
 
 static int test_klp_callbacks_demo_init(void)
-- 
2.52.0

