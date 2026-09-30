Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B73367B97
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737464; cv=none; b=ZYd9b8zdvh3BBQh3k+6tla6lb91t8m9NnP9FvqHNleWR7OnbF3yvNCErKf9qwoQiUzhWzEKziaYvoCCL9Z5WERIGcZke6Q3CM5DGC0LjjN5m9SwdbilBYaFqK4XC8A8KY84p3/rjrejjMN0QawWD7rOAXWPvmtnxedqc8aXrc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737464; c=relaxed/simple;
	bh=U85HLqujrVahyLPFH2IUmHdbSnsCi8Nh7SLy3G0lBdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVSPp7/5ZwDuTLUIAU8AQ2a09IKuceszjbdB1fX735UZiCullf9V8hBXw4mqAAGzmkzNWDlK3WmmwZltN6XVp7Z7Vf/1jSF00UOwCD1QXYLUNxYVFljabvM1kHTKiTyYq2r3ICdOEyx4CF03FLFCYbXN3k/vi56o81UbtDsuxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzxCf7Lc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzxCf7Lc"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so2291370a91.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737462; x=1791342262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eC/4YAjLgh//4xHRNncZqnH+G3g16tCr/5r57GgjUag=;
        b=XzxCf7LcLZeeRLggWwl4tvYDddNYOGVJ+3PqwpiYMa5XR1hJcC7hhvDyAAhiWIUh7e
         wxWKD+n36K+e+RnjlXEfz7Hcdx5T6sbr5Dw5g59wZMKf4Ss94GG9GVOqtSfW7zrsVC4l
         9WyUjn4zsYOMmwmffG5x53DHqdHtAgG1//srJ5GWHsgxIIjBuoeQbfamW63UbQmsSzcY
         /zH48WAMs+e717DTuYl+SeJyDCgtNndpamfd3txxyq5sjvmp6+5z3xvEEvb0+/x7QRJN
         SpfaIKyCwH9XuatOotZjJV+8oqwkSkam3Lm2raJw+L4ZO7X2IXJ9JyxQtMoVx/K5biRF
         qX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737462; x=1791342262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eC/4YAjLgh//4xHRNncZqnH+G3g16tCr/5r57GgjUag=;
        b=Hj0T3lvVhITGbud6n72Ouq5aFwjRfGzsR+oxsGpInTOTYp751K1oK8CaVQQ4O9whnb
         NxPXHilVaahLw2zFcBXDqjhWux9MQtVmfIZvOhI+U6ycu1WHeCxqBFTDem+oOttqJ4C9
         ZrveLUftfUa1PW3Tb/wWOill75l7Mi67OFE+vxrRT1fa/M+Nlpx2hOGPHYhVjV0PEBj6
         Tf8HN5IaoK5AnoNJBHYHMEdWe9EGXTs2Y1E5VmAtaD82gxgzDq0ESCoSE4AbL7MH4t51
         podtu+U3aKBt2PkhkkLT7vChrRgWDxs9GcuyJujUz+/ie5bnV55/4QxW9Pzq865FExWS
         Anbg==
X-Gm-Message-State: AFq9FYKA+cFYPgWw9KTbLnMv0zF+VSgy8wZ/lKC00etHyLI4owl6f7Zu
	OcsfiV42uW9N5MByCrFKpB5Yf6LphqJz0flt/UWG65JAaU2vgwNx4ysA
X-Gm-Gg: AYBFou3k3QKa/lcMDK69BiaUJIMME+7B7/C0zoA4szkRppdlz3zK6lckwEkDr82si6p
	nmKiIrITkbuCquddqCISHZgzgYN+ZxiIg6yl8p340I22DA5m0f+h9uK+3IqrF2D3068vetkwOf1
	St2oH4R+4l6fy+dITW32LUH3JFsMAk+hKa7TG6eRcDOGgYEyOOUwDhV3O8DAyNfL7t8OqxNdzGm
	c5otd14d4t6ZLEGI1KvPhnBJa4SfFaVnG05ceg/LB2bnq0Tm9EtJ0JXYKlboYantTDsV4SWRPVI
	GP/JuY9o/IL5WfgCxQGTn8agYvMEevQzOt4Offv+6GaWiNYIXIYdLeJe3oBihSQ3Vk5o1uq3AeE
	erjBBjnb1zsSGrpx//Lqu8b+DqFIzlRM+sbZLWthj8KZv4+PAZcnEuBjacr0Ep5WdgS63NNQkwI
	O9OKi6HmI9ReJXbZs50yk7WOz0O7L9soeDB5/250aOxmB4K0vAp5uBUe1E0pos6qhArZx5amXmz
	iAUODZjpFULRiRVqdfrqtnV/arhs4sNIyqwZedVSvRpXkFXo8F8bjhI7R1lwVwuvRkzGA==
X-Received: by 2002:a17:90a:dfd0:b0:3a4:cfc2:352d with SMTP id 98e67ed59e1d1-3a4d18f5981mr50066a91.53.1790737461941;
        Tue, 29 Sep 2026 20:04:21 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:04:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 9/9] selftests/livepatch: Add function test for provides/obsoletes
Date: Wed, 30 Sep 2026 11:03:23 +0800
Message-ID: <20260930030323.14396-10-laoar.shao@gmail.com>
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
index 430c3a9a9d84..69b836ed51de 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -5,6 +5,7 @@
 . $(dirname $0)/functions.sh
 
 MOD_MEMINFO=test_klp_meminfo_lp
+MOD_MEMINFO2=test_klp_meminfo_lp2
 MOD_CMDLINE=test_klp_cmdline_lp
 MOD_STATE=test_klp_state
 MOD_STATE2=test_klp_state2
@@ -457,4 +458,191 @@ $MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
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

