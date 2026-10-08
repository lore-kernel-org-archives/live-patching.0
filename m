Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC449505D
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453576; cv=none; b=p+ysTKpfxFps2A9XtxL3lfguugGST82Z5Za7/NiapqNu1Rywotargb8S104VCMQXaH7w9oNzqEqBo2JIopZ1NgO10Ip7jG36m5gmHfct+AwSfNnr4gTZFdq+UG1+TzAK+n+T+880kQ75UKAVq6x3h6UpKXlV04IUFBYayjWUh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453576; c=relaxed/simple;
	bh=TTmm/JiwM7rex0JkiB1ropg5AYtieGpfIx6c4EeIo+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3eq/ZDsSujs6ox9UO7LDWduwER7Rd8aYUqbP9jrp21PY+5pgqx+9NCgERmvxqGR7I7JDIo6v59xIbY0b6h0zmmmqRRhbJU21JR5s0m5o0ePpQUV7OsoWfJIvKej6byNQAabN2iDRgpPC1J7fVbPQw9qGL2mCMQU0YcZImzhWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEkKd59r; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEkKd59r"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso2051464a91.0
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453567; x=1792058367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlPgHKy4wplHuzogabgKJQHpma7ybFczSL9aCnuSDNg=;
        b=pEkKd59rM8GwTAnqZaJ5nGoe2UHVfQlqK7144ULFlZwBbF4mSw3EzDPBikhz1hMhcr
         YSO6d3okudZ9UZQrX6e2/tokUvqniaI1dGTNAT5ldwIU+8nm099l5hwC2Wpo89XwdEVm
         Rtqu5+J2Dohtj3q4iLB5JrIFLdS0v/NKYMzlSUhM9jU+QVjezm+o/q3Jwmu1vgqXD9aD
         0selyD+aXtICmj9awErkNqLX4Xr2dvmPC46COyH5HRj8Yz6RGyISRiHMtXjntnxXqjnN
         HEA+EtO0XfKFmDkUqCa/yT3nt+RtA/8TPFvXdxKSGEPa0oc5Iy/HVkJB49vCRncYrugh
         Og9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453567; x=1792058367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlPgHKy4wplHuzogabgKJQHpma7ybFczSL9aCnuSDNg=;
        b=1uUKUJNiHmkwcLS0Smw7AznctDtg/HH0SmXrlz5MUkSxPOFYG0EdzDlD2kiN25jqyx
         +YQv3fo5uG9cu/TFb78dURB5AY5kCr87rhjdezKPaNyosny0yYbE/cccWt3RWHCNz3OW
         n1ZM6i8HsRSpt+b7xaU3QvOTJVXTZhgZq2vw0gr+VIgsqALd0a2q3KyIXqwJHX87K8Vt
         Gj0psOfgEpxWYdbbCEz+e4HtGkiywPQ5g9Yo8VDFyS0EH22t/e8T2uPagLcxsUfvVs3s
         r1WFPbQBI4yMKJingdlShMVolQfEfEMNmOH8jB11OyCiWCQ/RrnHUaLiOodv9/lLruNQ
         ckHw==
X-Gm-Message-State: AFq9FYKB1r9+lF2ltjoSkMESW4BKyZzcfBQJRuitvhICDLIj7evFJGji
	i7l+vOixRQEh6oS/s/MbQye2HBAWUFb6HigB0CemgpiwLZHsiQqxDlo5
X-Gm-Gg: AYBFou0BfVxDOjEvHFIZCjeO4KpxpID5hfmEfw/KKIwpBWd/xnG0D+Zut8bbUupsIur
	N75Xja9WSvYHmT+h8Z4g9XDW0Y5A5t+H/yQ7ORqM21R+if12dyzkIZYvhfu1rUiV4202WU3eWpg
	VW6RmVgOAU46+2Y6291WnbkTVVc4aKXTR2cZrT9sFL4vlXFUbZR5tRhg088nRr0i0Ubt7JBObIt
	hoEoeatnTHu+nkzmzpj4rYm/Mxuwtj77qOIP/5YUBaQEsrRgI0pUVFoYPC0QhClyjr7BCLsorKz
	c4D0BV9jwdeOM+m2eGQZNNsFXOwm0BKFrwggervg3OJpO/XD39OTPnTgBFGDlplsQmnH9ZQ8ddv
	Vdbc8G4CtQtGhpzGXSIrfVl7mTw4wf6nW+sPByEDFZsJbQpanqNpJpngEuBYqA2nhG4RNZHFcXJ
	lcVLeCX/+7oAK++4mJl4LkIhCgOBBPTSBJfPIiW81MhawXPVB2iGwV+BMk6hKhDc/8h3rMyr6pi
	sIJ7ZJYG4bXyxQfcpSZY/xlLgrvFnAvPehaXNZgI8aTUq1X8ehEmbs22fE8HKK1RVM=
X-Received: by 2002:a17:90b:5102:b0:3ab:f38:2b3c with SMTP id 98e67ed59e1d1-3ab0f385291mr458671a91.28.1791453566932;
        Thu, 08 Oct 2026 02:59:26 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2100:3ace:b801:9432:769f:ff9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ff13esm3422790a91.7.2026.10.08.02.59.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:59:26 -0700 (PDT)
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
Subject: [PATCH v11 9/9] selftests/livepatch: Add function test for provides/obsoletes
Date: Thu,  8 Oct 2026 17:58:30 +0800
Message-ID: <20261008095830.26308-10-laoar.shao@gmail.com>
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

Livepatches with different provides ids must not modify the same
function, unless they share the same provides id or the second
livepatch obsoletes the first one.

Add test scenarios that verify this rule on the combination of
patched functions and provides ids.

These tests are skipped on kernels that still support the legacy
"replace" attribute.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../livepatch/test-provides-obsoletes.sh      | 188 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../test_modules/test_klp_meminfo_lp2.c       |   2 +
 3 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index b92188fcf45f..fce421a45fdb 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -5,6 +5,7 @@
 . $(dirname $0)/functions.sh
 
 MOD_MEMINFO=test_klp_meminfo_lp
+MOD_MEMINFO2=test_klp_meminfo_lp2
 MOD_CMDLINE=test_klp_cmdline_lp
 MOD_STATE=test_klp_state
 MOD_STATE2=test_klp_state2
@@ -465,4 +466,191 @@ $MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
 livepatch: '$MOD_STATE': unpatching complete
 % rmmod $MOD_STATE"
 
+
+# - load two livepatches that modify the same function
+#   (meminfo_proc_show), both with provides=1. The second livepatch
+#   replaces the first one because of the same provides id, even
+#   though they share the patched function.
+# - verify that the first livepatch is gone from sysfs (replaced)
+#   and that the second one is enabled
+# - unload the replacing livepatch, then the replaced one
+
+start_test "same function, replaced by provides"
+
+load_lp $MOD_MEMINFO provides=1
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+load_lp $MOD_MEMINFO2 provides=1
+
+loop_until '[[ ! -e "$SYSFS_KLP_DIR/$MOD_MEMINFO" ]]' ||
+	die "failed to replace $MOD_MEMINFO"
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+check_sysfs_value "$MOD_MEMINFO2" "provides" "1"
+
+disable_lp $MOD_MEMINFO2
+unload_lp $MOD_MEMINFO2
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+unload_lp $MOD_MEMINFO
+
+check_result "% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+$MOD_MEMINFO: this has been live patched
+% insmod test_modules/$MOD_MEMINFO2.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO2'
+livepatch: '$MOD_MEMINFO2': initializing patching transition
+livepatch: '$MOD_MEMINFO2': starting patching transition
+livepatch: '$MOD_MEMINFO2': completing patching transition
+livepatch: '$MOD_MEMINFO2': patching complete
+$MOD_MEMINFO2: this has been live patched
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO2/enabled
+livepatch: '$MOD_MEMINFO2': initializing unpatching transition
+livepatch: '$MOD_MEMINFO2': starting unpatching transition
+livepatch: '$MOD_MEMINFO2': completing unpatching transition
+livepatch: '$MOD_MEMINFO2': unpatching complete
+% rmmod $MOD_MEMINFO2
+% rmmod $MOD_MEMINFO"
+
+
+# - load a livepatch that modifies meminfo_proc_show with provides=1,
+#   then try to load another livepatch that modifies the same
+#   function with a different provides id (provides=2).
+# - since the provides ids differ, the second livepatch would not
+#   replace the first one; the same function can not be handled by
+#   two different provides groups in parallel, so the load must fail.
+# - unload the first livepatch
+
+start_test "same function, can't be loaded in parallel"
+
+load_lp $MOD_MEMINFO provides=1
+load_failing_mod $MOD_MEMINFO2 provides=2
+
+disable_lp $MOD_MEMINFO
+unload_lp $MOD_MEMINFO
+
+check_result "% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+% insmod test_modules/$MOD_MEMINFO2.ko provides=2
+livepatch: Livepatch patch ($MOD_MEMINFO2) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_MEMINFO2.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
+livepatch: '$MOD_MEMINFO': initializing unpatching transition
+livepatch: '$MOD_MEMINFO': starting unpatching transition
+livepatch: '$MOD_MEMINFO': completing unpatching transition
+livepatch: '$MOD_MEMINFO': unpatching complete
+% rmmod $MOD_MEMINFO"
+
+
+# - load a livepatch that modifies meminfo_proc_show with provides=1,
+#   then another livepatch with provides=1 that modifies a different
+#   function (cmdline_proc_show). The second one replaces the first
+#   one because of the same provides id.
+# - since the patched functions differ, the replacement does not need
+#   to restore the old function body; the transition only switches
+#   the ftrace nops, i.e. the atomic replace (nops) path.
+# - after the replacement /proc/meminfo is no longer patched, while
+#   /proc/cmdline is patched
+# - unload the replacing livepatch, then the replaced one
+
+start_test "different functions, atomic replace works (nops)"
+
+load_lp $MOD_MEMINFO provides=1
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+load_lp $MOD_CMDLINE provides=1
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+grep 'live patched' /proc/cmdline > /dev/kmsg
+
+disable_lp $MOD_CMDLINE
+unload_lp $MOD_CMDLINE
+unload_lp $MOD_MEMINFO
+
+check_result "% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+$MOD_MEMINFO: this has been live patched
+% insmod test_modules/$MOD_CMDLINE.ko provides=1
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+$MOD_CMDLINE: this has been live patched
+% echo 0 > $SYSFS_KLP_DIR/$MOD_CMDLINE/enabled
+livepatch: '$MOD_CMDLINE': initializing unpatching transition
+livepatch: '$MOD_CMDLINE': starting unpatching transition
+livepatch: '$MOD_CMDLINE': completing unpatching transition
+livepatch: '$MOD_CMDLINE': unpatching complete
+% rmmod $MOD_CMDLINE
+% rmmod $MOD_MEMINFO"
+
+
+# - load two livepatches with different provides ids (1 and 2) that
+#   modify different functions (meminfo_proc_show and
+#   cmdline_proc_show). Neither of them replaces the other, so both
+#   livepatches must coexist.
+# - verify that both /proc/meminfo and /proc/cmdline are patched
+# - disable and unload both livepatches
+
+start_test "different functions, install in parallel"
+
+load_lp $MOD_MEMINFO provides=1
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+
+load_lp $MOD_CMDLINE provides=2
+
+grep 'live patched' /proc/meminfo > /dev/kmsg
+grep 'live patched' /proc/cmdline > /dev/kmsg
+
+disable_lp $MOD_MEMINFO
+unload_lp $MOD_MEMINFO
+disable_lp $MOD_CMDLINE
+unload_lp $MOD_CMDLINE
+
+check_result "% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+$MOD_MEMINFO: this has been live patched
+% insmod test_modules/$MOD_CMDLINE.ko provides=2
+livepatch: enabling patch '$MOD_CMDLINE'
+livepatch: '$MOD_CMDLINE': initializing patching transition
+livepatch: '$MOD_CMDLINE': starting patching transition
+livepatch: '$MOD_CMDLINE': completing patching transition
+livepatch: '$MOD_CMDLINE': patching complete
+$MOD_MEMINFO: this has been live patched
+$MOD_CMDLINE: this has been live patched
+% echo 0 > $SYSFS_KLP_DIR/$MOD_MEMINFO/enabled
+livepatch: '$MOD_MEMINFO': initializing unpatching transition
+livepatch: '$MOD_MEMINFO': starting unpatching transition
+livepatch: '$MOD_MEMINFO': completing unpatching transition
+livepatch: '$MOD_MEMINFO': unpatching complete
+% rmmod $MOD_MEMINFO
+% echo 0 > $SYSFS_KLP_DIR/$MOD_CMDLINE/enabled
+livepatch: '$MOD_CMDLINE': initializing unpatching transition
+livepatch: '$MOD_CMDLINE': starting unpatching transition
+livepatch: '$MOD_CMDLINE': completing unpatching transition
+livepatch: '$MOD_CMDLINE': unpatching complete
+% rmmod $MOD_CMDLINE"
+
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index 732e0003930b..0c17754997d2 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -2,6 +2,7 @@ TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
 KDIR ?= /lib/modules/$(shell uname -r)/build
 
 obj-m += test_klp_meminfo_lp.o \
+	test_klp_meminfo_lp2.o \
 	test_klp_callbacks_busy.o \
 	test_klp_callbacks_demo.o \
 	test_klp_callbacks_demo2.o \
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
new file mode 100644
index 000000000000..2b93c969b7ba
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "test_klp_meminfo_lp.c"
-- 
2.52.0

