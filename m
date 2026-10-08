Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D49491596
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453546; cv=none; b=DJGo4K/ex0eKUap02PzOG0gN0n6HmKkU9uaGpIkfm/5Jo9XIY5Sh1gmA6GDf3jM65Lj+PayR+N7ZJOz1yxpKe3zpMIJCa1QPuQ2IPgZvEe54GIKFGO9DRFem3De6PtNJ/gkfTRw6NjfJFTe98J/Y92s90xpoJFYZq081IMpOnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453546; c=relaxed/simple;
	bh=EOq2xYEZ6UFTAqTG16fMrkdGuWiyuJL5xKD0kxwEOxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0iQ+npD57GRN+2BehFGDcxiY/Mt8zR8OOrCNc/EbTAbM+5MqNzUhIvw+4LzmNrmY3kbGCswN2Q1EP7m36EfukWDfSMbiJ23mvW9bXgTyRtWyHMyIy+lOtjhWoRu71BPq6vQpowT9OHnyDxIo7r1JsZRqIOJbNNbjAz1+9HNhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew6EYrwb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew6EYrwb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso2051226a91.0
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453532; x=1792058332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqEDXeLksXKLc84LK938t9OafscV1TwV8SmRhlszVcI=;
        b=ew6EYrwb0/d6PpE7AIfmvMMxvF5K0R7lJteOaHx3SGOA2FbgJM3Z0qICGSXu2CCU7b
         9fa1MxhaYW20o3LuCtJQUfa7bojrPHWogOfActKAWVB9umhhC/+G4AxpSeTlcaCvBIOf
         SR18gIE80eB0xJEdiGeC++Xh6IMJ932Gn08W7p+VAcbavzPsfg0THiNQnnS1NQxbD33U
         pLXv30ZCAoCOMghSOUzx0BKbPmjIoQFTeV2wBXpYGnrYF1oXWvfFPDbWiS5iKvmr2IgC
         LTOhceoOnd+EK1Sp41VMSAgvM+suOjZUwSEIWVgMXoMc8cIE93ryu5s7awAKi986Wgzq
         x6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453532; x=1792058332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqEDXeLksXKLc84LK938t9OafscV1TwV8SmRhlszVcI=;
        b=mNdRQRcLm6VFnjyY7kO1kXjaGCMEspfKVJPKTHQJSMV0bgBu3udARAlr5DR1DoKb8F
         NpfdD4HqY84MGnfPAILR8Pua7K14SYICGlX+SMnYqid0v6A7FAIDiBjx1MfM234FPdHN
         cPWSKmuTFnwzl1eofgd6leFSuc+GxeYFE71YacQvu9p2a449/OLgyZItNzZ6ZkTKzRDo
         ZtgSxE8TLentI53h1+z0oD+Up8CdP+H1X1CSkt3Ee7pdnWeyEDVB5pIW/Cw1417UJ9tT
         2WOR5NNp8VGTXlldAOoGXuO6phOcKF8454+vSdTABFirEMPOEFoue4gMVKLXWwErqGOV
         rzNg==
X-Gm-Message-State: AFq9FYLNHMofFPLa9zAVzKMe7fW4iigP4MR5jcQVVrYlccBXohSkKE2B
	TpNCuaIL1fRZCjvXqeNGyw6DlYpf19Vva6AvZbP1zjuIAKtQ2eNSgAij
X-Gm-Gg: AYBFou0w6ld1c6KVRsviXyzBRyalRsipWaOyAEy4P3g7/Jxq1BgwrKJ029TzhU/5uKR
	nb4bhxFrFJTqADoclcpBOEIsodaIXjX/819jkhdp6qLFnea3PRmkAc4pCBFQUmIAF95AxPVGsCZ
	fCylBoj+CEGRmJgTERtzu2kFZx6w52AJg7GPYK81tzDiKk4I8A09T5dhGfqNa1sMx21rI256oIR
	RvKLLrxi9sxWhEmchh/3VkDu8wc4kx/8/uVz6phLL6hUdMiul4EB5feuagLdlM+PeDJlJh5BmSd
	e6BBPdb7XuTJnoBXX3/kz/VrH9yLtYxlDIL68gpBQFwsaJxAmFp7OlX0wpo/tRdlnmVqxokXXnG
	v1BJ3VAWj+PGNWiZiDNMazRvhDEWe5WG2oedvD8kuXWRuW+sUNqBPwHQaz7bH49pB53/xYFOLgx
	12g5m/3h8kuS3ESRd2zTCm76KMwmZkJpa4kOIAWOQpOxplxwVylxtOvKx6jU2KxeWMSY+FVhmxF
	opJ1CtYcQ1r7wQwx6Ii1wQqwLZHoUQdEoiAirA9vAJl9ZMIWxGxS6io
X-Received: by 2002:a17:90b:5486:b0:3a4:cb6d:aca9 with SMTP id 98e67ed59e1d1-3a8a153a865mr3570120a91.64.1791453532048;
        Thu, 08 Oct 2026 02:58:52 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2100:3ace:b801:9432:769f:ff9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ff13esm3422790a91.7.2026.10.08.02.58.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:58:51 -0700 (PDT)
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
Subject: [PATCH v11 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Thu,  8 Oct 2026 17:58:23 +0800
Message-ID: <20261008095830.26308-3-laoar.shao@gmail.com>
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

The legacy "replace" field in struct klp_patch will be replaced by the
provides/obsoletes mechanism. As a result, the atomic replace
selftests fail to build against kernels that only support
provides/obsoletes.

Adapt the selftests so that they build and run on both old and new
kernels. On kernels without the legacy "replace" support, the
replace-related test cases are skipped with a SKIP message instead
of being run.

Also introduce the CONFIG_KLP_HAS_PROVIDES compile-time marker in
kernel/livepatch/Kconfig. It defaults to n and will be set to y once
the provides/obsoletes support is implemented later in this series.

The provides/obsoletes-based selftests will be added later in this
series, after the legacy "replace" field has been substituted by the
new mechanism.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/Kconfig                      |  14 +++
 .../testing/selftests/livepatch/functions.sh  |  42 +++++++-
 .../selftests/livepatch/test-callbacks.sh     |  43 +++++---
 .../selftests/livepatch/test-kprobe.sh        |   2 +-
 .../selftests/livepatch/test-livepatch.sh     | 102 ++++++++++--------
 .../test_modules/test_klp_callbacks_demo2.c   |  16 +++
 .../test_modules/test_klp_meminfo_lp.c        |  16 +++
 .../livepatch/test_modules/test_klp_state.c   |   7 ++
 .../livepatch/test_modules/test_klp_state2.c  |   7 ++
 9 files changed, 186 insertions(+), 63 deletions(-)

diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 4c0a9c18d0b2..d1eb971abb1a 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -30,3 +30,17 @@ config KLP_BUILD
 	select OBJTOOL
 	help
 	  Enable klp-build support
+
+config KLP_HAS_PROVIDES
+	def_bool n
+	help
+	  Compile-time marker for the livepatch provides/obsoletes support.
+	  It is always set when the kernel is built with the scoped atomic
+	  replace model, i.e. struct klp_patch provides the "provides" and
+	  "obsoletes" fields instead of the legacy "replace" flag.
+
+	  The option itself does not enable or add any functionality; it
+	  only serves as a compile-time marker so that out-of-tree modules
+	  and tools (e.g. the livepatch kselftests) can detect kernels that
+	  speak the provides/obsoletes interface and adapt to it with
+	  #ifdef CONFIG_KLP_HAS_PROVIDES.
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 8352c8d509a5..2458db8faa64 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -27,14 +27,26 @@ function log() {
 	echo "$1" > /dev/kmsg
 }
 
-# skip(msg) - testing can't proceed
+# skip_exit(msg) - testing can't proceed
 #	msg - explanation
-function skip() {
+function skip_exit() {
 	log "SKIP: $1"
 	echo "SKIP: $1" >&2
 	exit $ksft_skip
 }
 
+# skip(test, reason) - skip the test for a specific reason
+#	test - a test case
+#	reason - reason to skip it
+function skip() {
+	local test="$1"
+	local reason="$2"
+
+	echo -n "TEST: $test ... "
+	echo "SKIP ($reason)"
+	log "===== TEST: $test SKIPPED: $reason ====="
+}
+
 # root test
 function is_root() {
 	uid=$(id -u)
@@ -120,7 +132,7 @@ function set_ftrace_enabled() {
 			return
 		fi
 
-		skip "failed to set kernel.ftrace_enabled = $1"
+		skip_exit "failed to set kernel.ftrace_enabled = $1"
 	fi
 
 	echo "livepatch: kernel.ftrace_enabled = $result" > /dev/kmsg
@@ -357,6 +369,30 @@ function does_sysfs_exist() {
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
+	# /proc/config.gz is available only when CONFIG_IKCONFIG_PROC is
+	# enabled. Fall back to probing the "provides" sysfs attribute,
+	# which requires loading and unloading a livepatch.
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
index 2a03deb26a12..210a9f938204 100755
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
 
+if [[ "$HAS_PROVIDES_ATTR" == "1" ]]; then
+	skip "multiple livepatches" "legacy replace attribute not present"
+	skip "atomic replace" "legacy replace attribute not present"
+else
+	test_multiple_livepatches
+	test_atomic_replace
+fi
 
 exit 0
diff --git a/tools/testing/selftests/livepatch/test-kprobe.sh b/tools/testing/selftests/livepatch/test-kprobe.sh
index 81ab6d4760aa..75d9093c1742 100755
--- a/tools/testing/selftests/livepatch/test-kprobe.sh
+++ b/tools/testing/selftests/livepatch/test-kprobe.sh
@@ -5,7 +5,7 @@
 
 . $(dirname $0)/functions.sh
 
-grep -q kprobe_ftrace_ops /proc/kallsyms || skip "test-kprobe requires CONFIG_KPROBES_ON_FTRACE"
+grep -q kprobe_ftrace_ops /proc/kallsyms || skip_exit "test-kprobe requires CONFIG_KPROBES_ON_FTRACE"
 
 MOD_LIVEPATCH=test_klp_cmdline_lp
 MOD_KPROBE=test_klp_cmdline_kp
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 5380b5f174d4..645fa6cd3cf5 100755
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
+if [[ "$HAS_PROVIDES_ATTR" == "1" ]]; then
+	skip "multiple livepatches" "legacy replace attribute not present"
+	skip "atomic replace livepatch" "legacy replace attribute not present"
+else
+	test_multiple_livepatches
+	test_atomic_replace_livepatch
+fi
 
 
 # - load a target module that provides /proc/test_klp_mod_target with
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573e80af..6c46ce575f5c 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -7,9 +7,16 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifdef CONFIG_KLP_HAS_PROVIDES
+/*
+ * TODO: Add provides/obsoletes module parameters for the
+ * provides/obsoletes based tests (to be added later).
+ */
+#else
 static int replace;
 module_param(replace, int, 0644);
 MODULE_PARM_DESC(replace, "replace (default=0)");
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
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	/*
+	 * TODO: Set provides/obsoletes from the module parameters
+	 * for the provides/obsoletes based tests (to be added later).
+	 */
+#else
 	patch.replace = replace;
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
index f2477b217aab..0c434a27672d 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp.c
@@ -7,9 +7,16 @@
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
 
+#ifdef CONFIG_KLP_HAS_PROVIDES
+/*
+ * TODO: Add provides/obsoletes module parameters for the
+ * provides/obsoletes based tests (to be added later).
+ */
+#else
 static int replace;
 module_param(replace, int, 0644);
 MODULE_PARM_DESC(replace, "replace (default=0)");
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
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	/*
+	 * TODO: Set provides/obsoletes from the module parameters
+	 * for the provides/obsoletes based tests (to be added later).
+	 */
+#else
 	patch.replace = replace;
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 57a4253acb01..4d419a58cf65 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -142,7 +142,14 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	/*
+	 * TODO: Add provides/obsoletes module parameters for the
+	 * provides/obsoletes based tests (to be added later).
+	 */
+#else
 	.replace = true,
+#endif
 };
 
 static int test_klp_callbacks_demo_init(void)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index c978ea4d5e67..4f70f0619967 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -171,7 +171,14 @@ static struct klp_patch patch = {
 	.mod = THIS_MODULE,
 	.objs = objs,
 	.states = states,
+#ifdef CONFIG_KLP_HAS_PROVIDES
+	/*
+	 * TODO: Add provides/obsoletes module parameters for the
+	 * provides/obsoletes based tests (to be added later).
+	 */
+#else
 	.replace = true,
+#endif
 };
 
 static int test_klp_callbacks_demo_init(void)
-- 
2.52.0

