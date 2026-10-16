Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111838C2A7
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129102; cv=none; b=P0ySCUZzSVJEYvv7mmSv8Pmc+32pdonP8LhZvufmr7/KAOO2UMsI34QGEWTLIjRC0El/VXz/PQ3ierr9j7k2ZJY3iq9YbgCekNQFJp3ectJeGMKTine/FDVWRs8F1xgKgQnU2TuOq3ru9aK1eEj+Fdr7vqBNPYNYBCga0lHqPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129102; c=relaxed/simple;
	bh=TTmm/JiwM7rex0JkiB1ropg5AYtieGpfIx6c4EeIo+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibw+3IOR/OZMOivmuwIVH+rbjKSH9GrOk5VTiP80mPth5hCaJ76qhkAM+yQOgoGGlvXZc1DLrsPndfzTxbOJor8KHJsoAMmhAXkyKA3B5f1yMwMU1WpXMOPKhmOff+zeoJr3P4hIMWbMeciDEq5tCV4PDbfm2ig8klR9E5QVoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA27/qE6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA27/qE6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5fb79ce82so34889525ad.0
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2026 22:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129100; x=1792733900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlPgHKy4wplHuzogabgKJQHpma7ybFczSL9aCnuSDNg=;
        b=IA27/qE6/LM+6FtzW7ezh6dy7gRI9W4ugw9Z0ID0+JOk9wmSnCk9TX1qZqv9Sri5ep
         ez1Lg1aw998TNUP4bxazIdgSJQBM128JvaxejtuWoD9aUXA86kWVI8Yvsw9AVs5Yitil
         YitRIn7edJ6dt3PLWtYfwXUivsaryMDM4Rq6EMcnHziZUVWx3RhwN4/ZjNUO0ko9fzPz
         wxOe/f/cmaLRon6jUwA9IPdmDPOlPyH06oD8emyiQzc/vz60DilTek8x88ZchepwsE25
         DCJxaYYGQ24FvuNoVlvzenZpVeFjzaiu0ZbansVAPlgrOaSveHavsgHI5fkHWuU9MKE9
         PQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129100; x=1792733900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlPgHKy4wplHuzogabgKJQHpma7ybFczSL9aCnuSDNg=;
        b=C/Gys+PZTsticU22xNtuaVbfNpThZ9DICjSuCu6Bn+5TLm/1YbpWIJXRMaWBSL2fLY
         KDc3KCp+Jc3Ma9rniNxBZG32fyJqgLV3HU8ZUHul5iuUgGjC5S7fdErVnaYrJMvQgwI2
         XRilkEA5IcZfmQnUIozjZRYc41YmoIiyNM756XB8WptcU1uGTLvMMFa4KZ47ZuRKVrGq
         Imo2gcf3RzoXcV1t+OWr2PNiyRXqjlJ7J3dGSX/GvCsQbSs245sGHdNoGw32/Frk85tV
         qiJc9hAZnayyVhTP93JUYdPvMrBKNdrlrvdDJ9vgTiA0AT/FXph2GTdJuD5hnXcEOJRV
         VxxQ==
X-Gm-Message-State: AFq9FYIWpkzFoQCUaVMwKkWs3ZzKUE8IcQpOtB3NuUy7FhpKgjaqY/br
	5o+W4YVVdshU8ybh28P2fxz21YZbjOlv8HeIwI+DSDk+kMujMHOTHGVO
X-Gm-Gg: AYBFou0pIHCuOADktCdLgQ5COP0otcm5T0fbFZxb9YqhJqCPF2iI8YgAv2JKNLltQqp
	Ln8OHaFwcAtxNLiam8nbSYe2/Sl3kPSGeg6+AeYmj1mvDyP6sA/BIe3NXrOXTPHOdSdlJwR1NQh
	sZ6xZy09oxtjdlpt9IRlOLE3qBJIQTMobzKRKRzfofTcRn4L+57haotzzELynJCWP4k5RpCN294
	jM4ctyXlT6Nz+UXa/c8rmmytziaaoBVXvojJMG10Q7eGRBLiy63XtFEH0uPHwDPkbfhMO/GDBWN
	FGoJ18g14khuRkGGW3kfBEGn+aDBgk7f/7smeuzVo7w5DeL2/vQgVMBEEWtG9MH/K7GyFv+1Bkv
	a2fU5dy3qFRGM3oCHwWgWdDRkeF8oOceOyxU1T0dmEnMfmga2CcyotbJV8ZTMXgKyXTaHGGJfw5
	B3SxsikUy18ehF158ZBAwoG6J35jSkgfpMe3uQI2FABbCVXXcFa+d7LzI7ipQHVzTt7MoLhRNCf
	MVUKMwfL4PSTIE55CTaFYdxiehPiTne60EAtqy/8sqpZkPknhsjDYwhJ/9HW1Ssmgyav/uGhzlc
	+kk=
X-Received: by 2002:a17:902:dad2:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2e964b9a8admr38801455ad.11.1792129100363;
        Thu, 15 Oct 2026 22:38:20 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:5700:24f:f979:e84b:46de:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm4724115ad.17.2026.10.15.22.38.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 22:38:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 9/9] selftests/livepatch: Add function test for provides/obsoletes
Date: Fri, 16 Oct 2026 13:37:08 +0800
Message-ID: <20261016053708.47089-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016053708.47089-1-laoar.shao@gmail.com>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
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

