Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5B2F12DA
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737441; cv=none; b=RH7GU0Znjwe1lu5nwhHs4bFyfnlJJ3gCk3ag6wqXKaRKlKUq1qEzD80lI5rosgJAUUbn/ZdUZD3UN/1C6kXDj8u7HgZlCwf94VmxcXsYOQiGEXm2AA27tJv4ArntW9kzUlCN4vuEegZUVmAVNa6LfYZ4Unll+WCxQdRl1vb+o1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737441; c=relaxed/simple;
	bh=zJlt3zsb6HFDcXjSq2yMmOpuQvEz29bzgwsiKU/PVQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfMDhRUQR2eGLcpSNNEtrIMeUjf1obmwfmWdum+w9AacQejWiVn8qo1NUex0ReWYOESXL2TQZvkbdIIx5d3WALsiAEEaAGTmnxUi3+ea5s7/3ODy4Lk5ek6AaH1/wIyZwrc38dIi31j7+/llhubyfqHdMO8zw4c5FMN1hKOBXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1CsMJbc; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1CsMJbc"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so2509259a91.3
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737439; x=1791342239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvP5TdSmZpFbBn1URp0+exhFZie8bYkZjy8poD5a/KY=;
        b=d1CsMJbcdaUaKCEoQcjO4jq9INNBecy1xKGf73/4/EGksYTNuuZL1lNO6XihQsMCME
         fTpc+QxsFA/YD/gSAECoNQvzrRnKNKw97gYvdfEOpykwMbElhn9tRh2YjLFgnLogN1tp
         yw5Q9yKd/8RRewBjb20JTqFfHknuJtWDfn+BLKeRU0lYg1xI4hdNkyf9HgFAvNclCVSe
         qTC32t8cdHRcIeN4ayAoskkihzVpBD7ThkZSyGXipld9zkbuBGUtAIi9R7vnt9H4MXFZ
         EuXHfcyI4mteY82fRIFSizchCAVmEF1V29PcTDCQyFtnJ5NaId7NQUvpOKuzItNpOSYc
         8Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737439; x=1791342239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvP5TdSmZpFbBn1URp0+exhFZie8bYkZjy8poD5a/KY=;
        b=dkb7IZ65lmnw0SzLbEeGWTl/wvo13ZBvGdAgu92BxIMb/ix1pcJeUf0joUJBhvGwjT
         xD/m7lpMealizl2Sn5pPhwQQLKgW6WJoKQ+CL9vpSYrSM5AcYCZi6CpjrnRwSOnVPEQt
         uftB9NfFXxGqaPxiOzccU4R6Y/xfGK7JHhjcZQESm2kRsFmjkXrAl20gWc7d9Ndpz5vF
         9nanPOmS38IDZUmgSXGHt4TREu3koecpm9iHRLhXxtxihJ/whqsP1y9i04iFbGUzn3ra
         VRqZpXrcDGxctb2m8R0Tf/Gw567bevWKWwhhEtI0wIgLr3i7abxVa0rewt960JXLdnY5
         aCTA==
X-Gm-Message-State: AFq9FYITJMyRCplVIv1Q8dO5o8E6WDHwyoQpmneSHPTmQn99tya1T6hE
	5EsecpCSxq3X+oMep/mBKpI6JKlVxf193L39PjV1ZmM9H4HF2C9yW8Vk
X-Gm-Gg: AYBFou3bc/vpegb8hnLIzTETnQVZ3zstTUXosuVyVRaqdE41oBgYboZI2fPPPPg4CGA
	N5GABrupYXUhdNb5SmEDkDK7uFiV60qfnuyFyKh2igntpcK4MWk1cPSKyXNrJhGvaSWkBT+J7W/
	JKORSWJSS7fzAcBduGvI3MLLQLKas5K6aBnNImnNcg2P9ArzyOI9GRzMVsVfzckoj5dkyzhwxJH
	xjfmygLIVZnhgW6ApwCkYlDHwdhUlWqhL8wjh+amssaPpKq1dZSEQZqSA9bBRebHXv/XLUEZMzD
	tVRXYTUvM2ZrkWSE5/5L6LhkvhzaI6qB0EoPo7OlUKkEzh0DROnAG+9+yfOTBqSQGPcd+ZOgFw/
	2Jc4PeptJgzj7S0vwhM+lO86/SUUt5nyvJH2LMqr7y7wuqg4wykh5Ha6NgpIo3gt7dyWopLWDd2
	BbzzSM+3Iq3RTCD/5nQeJbt1AHIhDTDytDNUIRsk4ccFAFNIT/EX3iTsHi3O76nf5lGNbL30uXq
	NB80h3ujeLQpRKkNDsTGwoOnfMaFKyixWGqUR4XHw6+SY250h5tdNw7nf4CiqtPazqY+A==
X-Received: by 2002:a17:90b:3ec2:b0:3a2:b70b:9cc3 with SMTP id 98e67ed59e1d1-3a4d0f0247dmr82472a91.8.1790737438516;
        Tue, 29 Sep 2026 20:03:58 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.03.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:03:58 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Wed, 30 Sep 2026 11:03:16 +0800
Message-ID: <20260930030323.14396-3-laoar.shao@gmail.com>
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
index 2a03deb26a12..c6583647d2f1 100755
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
+	skip "multiple livepatches" "legacy replace attribute not present"
+	skip "atomic replace" "legacy replace attribute not present"
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
index 5380b5f174d4..2b89cba0547e 100755
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
+	skip "multiple livepatches" "legacy replace attribute not present"
+	skip "atomic replace livepatch" "legacy replace attribute not present"
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

