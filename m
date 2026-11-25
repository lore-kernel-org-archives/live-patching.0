Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580367;
	b=3FbkVqS/jBZOrSuu+kjvS8rxSfSxQ2QA4F2bmMherWyFxRglX4RrYNjefuOKdBCotaGd
	 zxAYIdKiBWtyULL1yNmoGcJpQW8kqOXzy8AGxGUBp+8a5a4QOLZBGgW6p9qGp5LoP9Itc
	 YyaZ7bd5aN3nMvocrnqVztWL96B3IEGDvHPDZOw/JV/YrMxP7EW4o9PhytWPa51Tdp7Xu
	 GnalFhW3/BYJeRKZ61Dh6M08ry0A3At6k2kJIBbpFEM8lZ2gESVNqRwVJx9Pwvf8fKKfM
	 FCnZXa585WcuetbRvcGJ6RjElwyQWrqlccwqrZEufSUzMnA14odAgUH1WxSjiIvFmIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Oens5qXCsD8jpfBNXUvH4+dKgq/K5SeSAeCwMcB/zwc=;
	b=baqhMKH8eAD9JNNpx0T936RjfUEFf/SvOpSrucaeTZxoc95NbfE0sokHXHL3kGK5ewYz
	 w8aH77evOGLlzgpowC77tF3I7OZJ7XimhaQbEMeCV2T/8sBm/Mtx7qXO98fStv6o0QNw+
	 lReLdz/QP81EtL4wFUEMvNa4LMeqVIrt+3QfVkvZSsRd+94Dd2WpyAamwobopb1oVSEg4
	 R6zJks8a1NdQwZqODSFnjnNHUrsHItj7uzJeW68EvVr760IC5jaF7qhAcq0L/IwArVHfh
	 yVvdW6ok0NRxlxCjPhqrWNF9Hp9Y550nr8847PwS9LWEC2cU/ecvyKuXSH/YSkXbWVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fm6Zl6+A;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BC606A339
	for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 04:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2BC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fm6Zl6+A
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b6463f95a4so4466605b3a.2
        for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 20:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795580366; x=1796185166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oens5qXCsD8jpfBNXUvH4+dKgq/K5SeSAeCwMcB/zwc=;
        b=fm6Zl6+AQCgULwpDzN3QamZ2OiVTRubCTK034RobimYX7H/c2D5iaWj9P5i6TtdtKp
         dVcLqyi+rpr9W5HuNFp5lzz4OVaGcdk/wMqS6YzQLcqim1XLhCAgs6UrWv5uSxIDPWJH
         OzUH/erYkN6HdQAfWrk5DFmVoseCnYyRQh2VbFziG2nDqJgW7tVm8UkKkmx6WeyTO5vY
         SeqcHzIgOPyxbG1NIru5cXl3u0QnCoH1kpmntze+EXZZ/A/iWylb8ZGgFi4/7Ky+EFCt
         PQfqK/9f69dbjiEvuc1i1vKgCSv2CXaBDJ1SnX/3JRQ2zYuVCafp8Um8LLjvaB9pqsAj
         dvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580366; x=1796185166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oens5qXCsD8jpfBNXUvH4+dKgq/K5SeSAeCwMcB/zwc=;
        b=jRTB8AxwfPk+DF2KGgp9CopF8cG0WemMmzq3N4ThGPUdXgOMkEW4BnU25HIQseNDel
         P2Pn7riA84B2zqT/E81zOymJxvAeuzatktzhbTctfn0fODJKWrzdWH+MA7+5VoH7TkTo
         pMgsm2ij1Q6x+ygY8Ei0icJLTnhfichvHBrcJ5UqB+Tg05NvX9z8wxT2KD076h1ONDU1
         mC82PfRPVcay/eqD4WrkwvJuEznbbddJWJs24QFX/NCybPqywu3jLIny+DrGENNYuDQT
         5K4wF8K7lrRGrdkzWwvfbCymZ1VEkQIk13fzy5BHymaMnEt6htzeJiw1boghIfK4Tf6i
         FxQw==
X-Forwarded-Encrypted: i=1; AL+hErE+mt/w7eaP7eeD8jlDtPwt+vnKE25a06tu22tW+nNUOaGDt0DONWQpC8P6gFiHg9IA0sZ9jeXKC3pKzvEd@vger.kernel.org
X-Gm-Message-State: APuU4Z/GH5274jta4OkwdDJ2pBorddvHwEuID9WolrCaBPSc1bHRxIZQ
	S1fSB5oG/BS1C/u7Hd+nUWY5uXHU33448KZcl5sHf9fuFc6wZEKhafRU9wbZvhnM7Mh79LrlQC4
	Jjbkti/Mn1ycFXl7nH3IjoGcIxg==
X-Received: from pgam23.prod.google.com ([2002:a05:6a02:2b57:b0:cc7:492f:3ac1])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:218b:b0:3f9:cc40:dcb with SMTP id adf61e73a8af0-4014ce517bbmr15339624637.33.1795580365500;
 Tue, 24 Nov 2026 20:19:25 -0800 (PST)
Date: Wed, 25 Nov 2026 04:19:00 +0000
In-Reply-To: <20261125041900.3243569-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125041900.3243569-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125041900.3243569-3-dylanbhatch@google.com>
Subject: [PATCH v2 2/2] selftests/livepatch: Add cond_resched() transition tests
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, live-patching@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a livepatch kselftest (test-cond-resched.sh) and helper module
(test_klp_cond_resched) to verify that livepatch transitions complete
when sole-runnable CPU-bound tasks spin in kernel cpu_relax() +
cond_resched_tasks_rcu_qs() loops and are kicked via klp_send_signals():

1. './test-cond-resched.sh kthread' pins a SCHED_FIFO kthread spinning
   in cond_resched_tasks_rcu_qs() on an isolated target CPU (while
   enabling the RV sched:opid monitor via tracefs when available) and
   verifies that klp_send_signals() reschedules and transitions it.
2. './test-cond-resched.sh usertask' spins a normal userspace task
   (!(PF_KTHREAD | PF_USER_WORKER)) inside a kernel cond_resched() loop
   via /proc/test_klp_cond_resched without checking signal_pending(),
   verifying that klp_send_signals() forces it through __schedule() as
   well.

Note that because _cond_resched() is a no-op under CONFIG_PREEMPTION=y,
a sole runnable spinning task enters __schedule(SM_PREEMPT) via
preempt_schedule_irq() with an in-kernel interrupt pt_regs frame on the
stack. Passing these tests without another runnable task on the CPU
therefore requires arch_stack_walk_reliable() to support unwinding
across in-kernel exception frames (such as x86_64 with
CONFIG_UNWINDER_ORC=y); on architectures or configs where
arch_stack_walk_reliable() currently rejects in-kernel exception frames
(arm64, powerpc, s390, or x86 with CONFIG_FRAME_POINTER=y), these tests
expose the lack of exception-boundary reliable unwinding.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../selftests/livepatch/test-cond-resched.sh  | 204 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../test_modules/test_klp_cond_resched.c      | 141 ++++++++++++
 4 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test-cond-resched.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_cond_resched.c

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215d..14741d8da4209 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -11,7 +11,8 @@ TEST_PROGS := \
 	test-ftrace.sh \
 	test-sysfs.sh \
 	test-syscall.sh \
-	test-kprobe.sh
+	test-kprobe.sh \
+	test-cond-resched.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-cond-resched.sh b/tools/testing/selftests/livepatch/test-cond-resched.sh
new file mode 100755
index 0000000000000..800a783df94e0
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-cond-resched.sh
@@ -0,0 +1,204 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. $(dirname $0)/functions.sh
+
+MOD_LIVEPATCH=test_klp_livepatch
+MOD_RESCHED=test_klp_cond_resched
+SUBTEST="${1:-all}"
+
+case "$SUBTEST" in
+	all|kthread|usertask) ;;
+	*)
+		echo "Usage: $0 [all|kthread|usertask]" >&2
+		exit 1
+		;;
+esac
+
+setup_config
+
+if [[ $(nproc) -lt 2 ]]; then
+	skip "test-cond-resched requires at least 2 online CPUs"
+fi
+
+# Pin the test runner (and a userspace busy-loop so global timers such as
+# klp_transition_work stay on CPU 0) to CPU 0, and disable RT bandwidth
+# throttling and the DL fair_server on TARGET_CPU so our SCHED_FIFO spinner
+# remains the sole runnable task until klp_send_signals() fires at
+# SIGNALS_TIMEOUT (15s).
+TARGET_CPU=$(($(nproc) - 1))
+FAIR_RUNTIME_FILE="$SYSFS_DEBUG_DIR/sched/fair_server/cpu$TARGET_CPU/runtime"
+if [[ ! -w "$FAIR_RUNTIME_FILE" ]]; then
+	skip "fair_server debugfs control ($FAIR_RUNTIME_FILE) not available"
+fi
+
+taskset -cp 0 $$ >/dev/null
+
+ORIG_RT_RUNTIME=$(sysctl -n kernel.sched_rt_runtime_us)
+ORIG_FAIR_RUNTIME=$(cat "$FAIR_RUNTIME_FILE")
+RV_DIR="$SYSFS_TRACING_DIR/rv"
+ENABLED_OPID=0
+USER_SPIN_PID=""
+BG_BUSY_PID=""
+
+function cleanup_cond_resched() {
+	if [[ -e /proc/test_klp_cond_resched ]]; then
+		echo 1 > /proc/test_klp_cond_resched 2>/dev/null || true
+	fi
+	if [[ -n "$USER_SPIN_PID" ]]; then
+		wait "$USER_SPIN_PID" 2>/dev/null || true
+	fi
+	if [[ -n "$BG_BUSY_PID" ]]; then
+		kill "$BG_BUSY_PID" 2>/dev/null || true
+		wait "$BG_BUSY_PID" 2>/dev/null || true
+	fi
+	rmmod $MOD_RESCHED 2>/dev/null || true
+	if [[ -e "$SYSFS_KLP_DIR/$MOD_LIVEPATCH" ]]; then
+		echo 0 > "$SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled" 2>/dev/null || true
+		loop_until '[[ ! -e "$SYSFS_KLP_DIR/$MOD_LIVEPATCH" ]]' || true
+	fi
+	rmmod $MOD_LIVEPATCH 2>/dev/null || true
+	if [[ "$ENABLED_OPID" -eq 1 ]]; then
+		echo "!sched:opid" > "$RV_DIR/enabled_monitors" 2>/dev/null || true
+		echo nop > "$RV_DIR/monitors/sched/opid/reactors" 2>/dev/null || true
+	fi
+	echo "$ORIG_FAIR_RUNTIME" > "$FAIR_RUNTIME_FILE" 2>/dev/null || true
+	sysctl -q kernel.sched_rt_runtime_us="$ORIG_RT_RUNTIME" 2>/dev/null || true
+	cleanup
+}
+trap cleanup_cond_resched EXIT INT TERM HUP
+
+sysctl -q kernel.sched_rt_runtime_us=-1
+echo 0 > "$FAIR_RUNTIME_FILE"
+
+taskset -c 0 bash -c 'while :; do :; done' &
+BG_BUSY_PID=$!
+
+if [[ -f "$RV_DIR/available_monitors" ]] &&
+   grep -q '^sched:opid$' "$RV_DIR/available_monitors"; then
+	echo printk > "$RV_DIR/monitors/sched/opid/reactors" 2>/dev/null || true
+	if ! grep -q '^sched:opid$' "$RV_DIR/enabled_monitors"; then
+		echo sched:opid > "$RV_DIR/enabled_monitors" && ENABLED_OPID=1
+	fi
+fi
+
+function check_rv_opid() {
+	local opid_err
+
+	opid_err=$(dmesg -r | awk -v last="$LAST_DMESG" 'p { print } $0 == last { p = 1 }' |
+		   grep 'rv: monitor opid does not allow' || true)
+	if [[ -n "$opid_err" ]]; then
+		echo -e "\n$opid_err" >&2
+		return 1
+	fi
+	return 0
+}
+
+function user_spin_started() {
+	dmesg -r | awk -v last="$LAST_DMESG" 'p { print } $0 == last { p = 1 }' |
+		grep -q "$MOD_RESCHED: user_spin_read: spinning"
+}
+
+# Test 1: Verify a sole-runnable CPU-bound kthread spinning in cond_resched()
+# transitions cleanly via klp_send_signals() -> __schedule().
+if [[ "$SUBTEST" == "all" || "$SUBTEST" == "kthread" ]]; then
+	start_test "CPU-bound kthread spinning in cond_resched() transition"
+
+	load_mod $MOD_RESCHED target_cpu=$TARGET_CPU spawn_kthread=1
+	load_lp $MOD_LIVEPATCH
+
+	if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]]; then
+		echo -e "FAIL\n\n"
+		die "livepatch kselftest(s) failed"
+	fi
+
+	disable_lp $MOD_LIVEPATCH
+	unload_lp $MOD_LIVEPATCH
+
+	if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]]; then
+		echo -e "FAIL\n\n"
+		die "livepatch kselftest(s) failed"
+	fi
+
+	unload_mod $MOD_RESCHED
+
+	OPID_RC=0
+	check_rv_opid || OPID_RC=1
+
+	check_result "% insmod test_modules/$MOD_RESCHED.ko target_cpu=$TARGET_CPU spawn_kthread=1
+$MOD_RESCHED: cond_resched_kthread_fn: spinning in cond_resched()
+% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: signaling remaining tasks
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_RESCHED
+$MOD_RESCHED: stopped"
+
+	if [[ "$OPID_RC" -ne 0 ]]; then
+		die "RV sched:opid violation detected during klp_send_signals()"
+	fi
+fi
+
+# Test 2: Verify a normal userspace task (!(PF_KTHREAD | PF_USER_WORKER))
+# spinning inside a kernel cond_resched() loop (without checking
+# signal_pending()) transitions cleanly via klp_send_signals() -> __schedule().
+if [[ "$SUBTEST" == "all" || "$SUBTEST" == "usertask" ]]; then
+	start_test "CPU-bound user task spinning in kernel cond_resched() transition"
+
+	load_mod $MOD_RESCHED target_cpu=$TARGET_CPU
+
+	cat /proc/test_klp_cond_resched >/dev/null &
+	USER_SPIN_PID=$!
+	loop_until 'user_spin_started' ||
+		die "user task failed to enter kernel spin"
+
+	load_lp $MOD_LIVEPATCH
+
+	wait "$USER_SPIN_PID"
+	USER_SPIN_PID=""
+
+	if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]]; then
+		echo -e "FAIL\n\n"
+		die "livepatch kselftest(s) failed"
+	fi
+
+	disable_lp $MOD_LIVEPATCH
+	unload_lp $MOD_LIVEPATCH
+	unload_mod $MOD_RESCHED
+
+	OPID_RC=0
+	check_rv_opid || OPID_RC=1
+
+	check_result "% insmod test_modules/$MOD_RESCHED.ko target_cpu=$TARGET_CPU
+$MOD_RESCHED: user_spin_read: spinning in cond_resched()
+% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: signaling remaining tasks
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_RESCHED
+$MOD_RESCHED: stopped"
+
+	if [[ "$OPID_RC" -ne 0 ]]; then
+		die "RV sched:opid violation detected during klp_send_signals()"
+	fi
+fi
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a13d398585dcb..1502ff9070b88 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -6,6 +6,7 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_callbacks_demo.o \
 	test_klp_callbacks_demo2.o \
 	test_klp_callbacks_mod.o \
+	test_klp_cond_resched.o \
 	test_klp_kprobe.o \
 	test_klp_livepatch.o \
 	test_klp_mod_patch.o \
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_cond_resched.c b/tools/testing/selftests/livepatch/test_modules/test_klp_cond_resched.c
new file mode 100644
index 0000000000000..19ff9dffd96bc
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_cond_resched.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * test_klp_cond_resched.c - Helper module for testing livepatch transitions
+ * while CPU-bound kthreads or user tasks spin in kernel cond_resched() loops.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/completion.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/processor.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+
+static int target_cpu = -1;
+module_param(target_cpu, int, 0444);
+MODULE_PARM_DESC(target_cpu, "CPU to pin spinner task to");
+
+static bool spawn_kthread;
+module_param(spawn_kthread, bool, 0444);
+MODULE_PARM_DESC(spawn_kthread, "Spawn a SCHED_FIFO kthread spinner on load");
+
+static struct task_struct *cond_resched_tsk;
+static struct proc_dir_entry *proc_entry;
+static DECLARE_COMPLETION(spinner_started);
+static bool stop_spin;
+
+static void spin_until_patched(void)
+{
+	bool saw_pending = false;
+
+	while (!READ_ONCE(stop_spin)) {
+		if ((current->flags & PF_KTHREAD) && kthread_should_stop())
+			break;
+		if (test_thread_flag(TIF_PATCH_PENDING))
+			saw_pending = true;
+		else if (saw_pending)
+			break;
+		cpu_relax();
+		cond_resched_tasks_rcu_qs();
+	}
+}
+
+static int cond_resched_kthread_fn(void *data)
+{
+	sched_set_fifo_low(current);
+	pr_info("%s: spinning in cond_resched()\n", __func__);
+	complete(&spinner_started);
+
+	spin_until_patched();
+
+	sched_set_normal(current, 0);
+	while (!kthread_should_stop())
+		schedule_timeout_interruptible(HZ);
+
+	return 0;
+}
+
+static ssize_t user_spin_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	int ret;
+
+	if (*ppos > 0)
+		return 0;
+
+	ret = set_cpus_allowed_ptr(current, cpumask_of(target_cpu));
+	if (ret)
+		return ret;
+
+	sched_set_fifo_low(current);
+	WRITE_ONCE(stop_spin, false);
+	pr_info("%s: spinning in cond_resched()\n", __func__);
+
+	spin_until_patched();
+
+	sched_set_normal(current, 0);
+	*ppos = 1;
+	return 0;
+}
+
+static ssize_t user_spin_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	WRITE_ONCE(stop_spin, true);
+	return count;
+}
+
+static const struct proc_ops user_spin_ops = {
+	.proc_read	= user_spin_read,
+	.proc_write	= user_spin_write,
+};
+
+static int __init test_klp_cond_resched_init(void)
+{
+	if (target_cpu < 0)
+		target_cpu = cpumask_last(cpu_online_mask);
+	if ((unsigned int)target_cpu >= nr_cpu_ids || !cpu_online(target_cpu))
+		return -EINVAL;
+
+	proc_entry = proc_create("test_klp_cond_resched", 0600, NULL,
+				 &user_spin_ops);
+	if (!proc_entry)
+		return -ENOMEM;
+
+	if (spawn_kthread) {
+		cond_resched_tsk = kthread_create_on_cpu(cond_resched_kthread_fn,
+							 NULL, target_cpu,
+							 "klp_cond_resched/%u");
+		if (IS_ERR(cond_resched_tsk)) {
+			int ret = PTR_ERR(cond_resched_tsk);
+
+			cond_resched_tsk = NULL;
+			proc_remove(proc_entry);
+			return ret;
+		}
+		wake_up_process(cond_resched_tsk);
+		wait_for_completion(&spinner_started);
+	}
+
+	return 0;
+}
+
+static void __exit test_klp_cond_resched_exit(void)
+{
+	WRITE_ONCE(stop_spin, true);
+	if (cond_resched_tsk)
+		kthread_stop(cond_resched_tsk);
+	proc_remove(proc_entry);
+	pr_info("stopped\n");
+}
+
+module_init(test_klp_cond_resched_init);
+module_exit(test_klp_cond_resched_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Livepatch test: CPU-bound cond_resched() transition");
-- 
2.56.1.839.g22a8290db9-goog

