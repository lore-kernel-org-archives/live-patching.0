Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021844;
	b=o8Qo2V5wjTQPgmpftMvi+zHoQ/kl7E6PzEdu7y2qdWhsLAbqg/eYknhO4W5kXgZuOpr1
	 NebhfXQiUHv1nvtsvT1VniB8Z0BGToQRGDXYynz6avfFq3NnlYmFaahrnqQOpe+IanheU
	 NsZ0D/ytk8oOieI1nozhITRD4/o6RjNqEaxZIecNzZNJK7jQQ1NFevkGE+G7ca7GR2xAw
	 1uhiW533TFFxnXMu0BAzshJdn5pbvhssVCnUurC46qaEinNJwbYb0Z3B94AMnn2WBEOKI
	 QaQtKGEFW0dZf142/I8OHFNUYXlbAY61LRi4utYeIaNdAkH/vrJ1SsHBPFA1Hc+XSyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VTYcLitAMiXtwWLq5RpovRZ53xkxF5kQKd62tbj7cto=;
	b=T3N5FPmOVbV5uEVLuHLq1VWzaD90rtqr4Dgl55hhzsS8fKdGcHu+0hRlM697P4WPL/3Y
	 ocPqkjD6ZmdRTo6LdWhVRBouerMaICIVixGxAkNHCDVH/3SQYPyawlxe8T1+yLTfWhMb4
	 S1mq9/p84W/DpDsy5FdTWouW4saIE0zu1YMZ69eMgZ8cn0FB0cxLMXCF/CkalcnU+1tUG
	 yayDQ5dWcWkqoaYCSZMPimXCpWtz/SPiKYECMjgwOmD301z2rzikN+p6dwjCwn5BZd4na
	 5Si90zka5TDoN7J8Vmy1f4TV7P/uduuO9RNP5lh3wBgaCjZur6hgkJXEMI78frGKo4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMT9vM3X;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695960A2615
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3695960A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMT9vM3X
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e946155442so25339915ad.3
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021842; x=1793626642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTYcLitAMiXtwWLq5RpovRZ53xkxF5kQKd62tbj7cto=;
        b=QMT9vM3XL2pI41yLw+ZH5kjYNq4W5wcfBqKx2Z0+mwfP3B/rVNtqLLhiEezNkd9ycq
         dfCM0+DI4VIzS7uXYVzUFwp34mRDZGoFyxVqNf+U1Iid6WY4RqOZhWOXT+NjXxUIhHKa
         UTlM0rPAIS/nJKsVeeFdNol8/oxNCp3BiTyPFhJGncqo+5ERiVFbx7qi/oZgdRore7oK
         U0lLPLaW+advqP9q3DnTAZ5y14oqRPrJbnb/TMCGnp8hzQ9UYMPqtPURqQkECpQ0NVNU
         kC3D7Br91b/XRzkqgPs96Yk8jBt6Bcy0P4g5ECj471zgAXBbt4Zwbzi+N8C6nVcPU4O+
         BFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021842; x=1793626642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTYcLitAMiXtwWLq5RpovRZ53xkxF5kQKd62tbj7cto=;
        b=HSAnv9M4IPgz9Q1bnyUqljZ0ir9D36rOAxK+C25aBY5/7NI8BXC+K44KI7v8tBQTHA
         Cn0zzMA3rnisiiX2MqxjMQRgxy3zkC8uuIEDxCsS6Qa1JwU7oCEa/tztRDRd5lXu0I42
         TpNPbyOpHdC5x4Vy2EFUPPIWYZK9IBwM+WMSn5YoU7kzYUZlV/Lq0g1R1flOtGzFAfr/
         0nDi1iL9hIut5/nRYi/cuNH9zMLiMbS5r4pkXkq+t8yKG/2p3gkiJwsDOZhX0W97GFJc
         Sb5d/3lWgL8T/bAHzhVlaHJuGTmP+HAejf1fFU4cMXA4IGJHVrsK3xigkWgxxUGbbVb2
         W9wQ==
X-Gm-Message-State: AFq9FYK7t85UZPLcS8AuAhn4BpUNQo04AtbU6YI86sRhd5CdSgS5nrQh
	Zy0BQYw55wm6z9GJNCgHKCs0UKJ+p9fAN5VR0M3E5S0anP+LXMUNk3Ic
X-Gm-Gg: AYBFou1j0c6iPzA/SZ8R5F77I9KYOj0Z+etNZ5jOHUq2VUvVtcp8Fehy0Eh3T/o1tRD
	GL5+H0UMylgVA2dvWwfgQAKJ52c/lkNeEEL0I9+MwyxJFCaIZ7Hn20RbtsSiaPnJ4TBzKkc1JB4
	luKPZhkPZxIu5GSr3Fw+aaGekIa2RQXvXmMwkv5UDcQpJA0PFgYK21M8E2meBhVrfAKVzMdfqd2
	n8AiyqMrtiAkwgDNLtXARNt/DnfE6yED+jO4qox4yowXo+VFdFuQfmGEtO7GF9sUAnwPARKYSDy
	ghYK0iz38QZe0T9g1nk7rarsN9BdsHGMXRVQxhAZrlO2CCMZLTUK72niJnaD2feHpm5uALRAmrv
	XjyoMUL8QZCZzj8JvWkPOxIE0uBbrMZ9lAQMFoq+mP6RKTKWxKzyChw2tNwWNFwHzqv+gH9O4+M
	cv7+mqkLlEEuppM9ZnbgO06+fmqH41cZ0YRZ52j+fBgNUszINe3uWW/JbLrI4gOsooxmgqmLxZo
	3w1Mj2YmXqOcmfd0S1xF27u+yba1AXbCESmtGCZxKivbkemGW9YP1nRad2nXQO4qxi/tSRDue3T
	q6OV8ZMii0t/xDsQiVW4PbWsn0umJ2Zhi1ZvhGdoFC+KNsuJVuOH1uYJRgE=
X-Received: by 2002:a17:903:1d1:b0:2e9:776c:d52e with SMTP id d9443c01a7336-2ea9c873c48mr57006975ad.52.1793021842362;
        Mon, 26 Oct 2026 06:37:22 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
Date: Mon, 26 Oct 2026 21:36:44 +0800
Message-ID: <20261026133651.40061-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
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
 kernel/livepatch/Kconfig                           |  14 +++
 tools/testing/selftests/livepatch/functions.sh     |  42 ++++++++-
 .../testing/selftests/livepatch/test-callbacks.sh  |  43 ++++++---
 tools/testing/selftests/livepatch/test-kprobe.sh   |   3 +-
 .../testing/selftests/livepatch/test-livepatch.sh  | 102 ++++++++++++---------
 tools/testing/selftests/livepatch/test-sysfs.sh    |   3 +-
 .../test_modules/test_klp_callbacks_demo2.c        |  16 ++++
 .../livepatch/test_modules/test_klp_meminfo_lp.c   |  16 ++++
 .../livepatch/test_modules/test_klp_state.c        |   7 ++
 .../livepatch/test_modules/test_klp_state2.c       |   7 ++
 10 files changed, 189 insertions(+), 64 deletions(-)

diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 4c0a9c1..d1eb971 100644
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
index 429fce1..3d85575 100644
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
@@ -371,6 +383,30 @@ function does_sysfs_exist() {
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
index 2a03deb..210a9f9 100755
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
index 81ab6d4..dea62ce 100755
--- a/tools/testing/selftests/livepatch/test-kprobe.sh
+++ b/tools/testing/selftests/livepatch/test-kprobe.sh
@@ -5,7 +5,8 @@
 
 . $(dirname $0)/functions.sh
 
-grep -q kprobe_ftrace_ops /proc/kallsyms || skip "test-kprobe requires CONFIG_KPROBES_ON_FTRACE"
+grep -q kprobe_ftrace_ops /proc/kallsyms ||
+	skip_exit "test-kprobe requires CONFIG_KPROBES_ON_FTRACE"
 
 MOD_LIVEPATCH=test_klp_cmdline_lp
 MOD_KPROBE=test_klp_cmdline_kp
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 5380b5f..645fa6c 100755
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
diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 32d3af0..e48bf33 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -13,6 +13,7 @@ HAS_REPLACE_ATTR=0
 HAS_STACK_ORDER_ATTR=0
 
 setup_config
+detect_provides_attr
 
 # - load a livepatch and verifies the sysfs entries work as expected
 
@@ -154,7 +155,7 @@ livepatch: '$MOD_ATOMIC_REPLACE': unpatching complete
 % rmmod $MOD_ATOMIC_REPLACE"
 fi
 
-if [[ "$HAS_STACK_ORDER_ATTR" == "1" ]]; then
+if [[ "$HAS_STACK_ORDER_ATTR" == "1" && "$HAS_PROVIDES_ATTR" != "1" ]]; then
 	start_test "sysfs test stack_order value"
 
 	load_lp $MOD_LIVEPATCH
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573..6c46ce5 100644
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
@@ -72,12 +79,21 @@ static void post_unpatch_callback(struct klp_object *obj)
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
index f2477b2..0c434a2 100644
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
@@ -36,12 +43,21 @@ static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
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
index 57a4253..4d419a5 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -142,7 +142,14 @@ static void post_unpatch_callback(struct klp_object *obj)
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
index c978ea4..4f70f06 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -171,7 +171,14 @@ static void post_unpatch_callback(struct klp_object *obj)
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
1.8.3.1

