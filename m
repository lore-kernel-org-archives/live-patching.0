Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3C2D0629
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921863; cv=none; b=LI3Guh87YPa75nrlPwuG0xr7LUF8vVobinOsuH//Tup0aIIihU+APoU1olaD5FQlVp+13ldchP56fF+dBMsJa7YOCTGJr/dSHJbFIEpn+9jQt3COZudAovb5pmaSdJSZQ4Afbwjl2Gh++pzGoPhsL7lCRXOKg4AUKI0NTdJdtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921863; c=relaxed/simple;
	bh=saAZueVylEC6PyD7WNocNZbYQJp4SUpkrSSr6JI4rtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmRgpdMNe427seMUhmMLryK7J5hddZSvjnw+40yxwe9pOKlI8BZElA2wByRjR9UBFqk+dp02tRB1j2DXXisdfxdPQrSaHzju3ZAqQH8D0VNip4BOQ3qJNn6KyaZ+gOgMngieyEDjAO4XXuvzEm766LfgKNBG3mmPG+eO+jW5L6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4hDa1pJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4hDa1pJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2db3305f94fso42065365ad.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921861; x=1789526661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4NJ6fv/HsaKac+8ECuBuBx9wPI/vxbpYT8d8jlLkWCA=;
        b=c4hDa1pJ2d7hkEvzWD1QR1DhsX3vdZwbVjEbm3OGMzdwmixXAJMT5n6wgOJ5ftv2Z4
         IFtvVbbckxZVMoyY2zm2ke75zWT6DlpIORPyXC7Bm1K0MDKAOboWtq3nYYFLyeU1QPY6
         mMpFL6vRNlvwhFdUF/Q9GBnLK9/x5kVwFSZmG8VeqdAm3t3J4qn4sClzYFsv6q5dfUZO
         uAQ+0e/HA1dgeitM7PHbiF0MLFWmQeK4f+KJ0kx/QbK0xGCq3citCRukLojwwN0qoQCw
         r1pJKlwKfrDegA9Aw1xI5/LbeyM+83lfedcxNFdkYYT2f9vA29oVqAjhdWkIqBZOgN7v
         EBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921861; x=1789526661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4NJ6fv/HsaKac+8ECuBuBx9wPI/vxbpYT8d8jlLkWCA=;
        b=bc04l84W/GA6p6yyvvwVLq35rjFUiTpA/Rcoyou7XeyCRCPoQmL2rT46s+N42nQ9hu
         feZzEneh74CtjdvpTxQ2UtxAqlubRHZRMuJeCwLOfNiOsVUlyfL7giTJsTfANlUliNEG
         pFqg3qyu5ukEYkSG0V+Zn1hioEY0zYmqcu+FJpqoDqdn6Zh1CN9Qf5N5SWtYeW5d8dOl
         e9zouLCA+9xHiQ1cn9AONulVmY1WbEkoOsir/yaV/PJ8OExt3TW3ngLFjJJM+Z5+6K2m
         Gsjtwm3EBq616NKgVKeNY3METCZRtUED6XPPYYRSkKCejeIFBe/vwcODxlzRLGPd4Dx/
         Allg==
X-Gm-Message-State: AFuF++kjviecjwZZKoSheQGiURfY3j2fDsVOXdbMzeqYLvB74E5epIvY
	TxPgwVGdNjkLd3rxlXevkyhaW8OPdvt9GGOMxGqJA3+VmvX6io7IFaQK
X-Gm-Gg: AYBFou3IyjiwDGGkLVrBJhyCRmncZEJJEKduFdd5LAvOvwEh78Wk2MnVePl45omUzGl
	y0Z4aJUitxPdL0d9q8E4zWvIkPEi8JwjWCgD7ix829hAFDzSz0XseYuccluRsDhEi/yY/xdxsfb
	1nrSLNPTGxcd/SutCUFNSrozI6+YitZSwVAbZNrFYqTAZOsaTxEAyDM4IENf0JUoK4q1kA1UzsP
	nVGNiVRcb0LjbATjKM4MXhAoXkdflhHYj5dp2cxsA9UM2WVw166z8iYcCOXqpm7ZMyJeAQ14OwE
	njlqnp8rEpRM72qaAMA995zPK+Nei5A9hB/IsFxjqNy9HIpDHlEAnGcbkpb5hSfb1minYatQ0E9
	xSKH4dVXviBss4+ysTGBqdVBLLtGVkl7jzEW863GMtbmMAX5KgHmPM6T5ugXzBjKfbDNAgmUE2V
	nu+fmvXtdQGrVvhSgLHCc8NWmVFW8Uz7lVpqJTlWGfhl5wadVleE2mDZhe5+Bq2LlTETxgRoS+/
	jrMi0UsQ4d4VTDDF+Y6SHqLAeZoeEiqh5aWuntBP1FHQINLuQLHfGRSCqxcyqBAkTa/oWQVZJoW
	tQS9
X-Received: by 2002:a17:90b:570b:b0:398:deed:6e1d with SMTP id 98e67ed59e1d1-39b260de5bbmr49890189a91.5.1788921861427;
        Tue, 08 Sep 2026 19:44:21 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.44.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:44:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 9/9] selftests/livepatch: Add function test for provides/obsoletes
Date: Wed,  9 Sep 2026 10:43:24 +0800
Message-ID: <20260909024324.16002-10-laoar.shao@gmail.com>
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
 .../livepatch/test-provides-obsoletes.sh      | 176 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../test_modules/test_klp_meminfo_lp2.c       |   1 +
 3 files changed, 178 insertions(+)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index 8b7b5eded80c..d4443cb81e90 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -5,6 +5,7 @@
 . $(dirname $0)/functions.sh
 
 MOD_MEMINFO=test_klp_meminfo_lp
+MOD_MEMINFO2=test_klp_meminfo_lp2
 MOD_CMDLINE=test_klp_cmdline_lp
 MOD_STATE=test_klp_state
 MOD_STATE2=test_klp_state2
@@ -449,4 +450,179 @@ $MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
 livepatch: '$MOD_STATE2': unpatching complete
 % rmmod $MOD_STATE2"
 
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
+load_lp $MOD_MEMINFO2 provides=1
+
+loop_until '[[ ! -e "$SYSFS_KLP_DIR/$MOD_MEMINFO" ]]' ||
+	die "failed to replace $MOD_MEMINFO"
+check_sysfs_value "$MOD_MEMINFO2" "provides" "1"
+
+disable_lp $MOD_MEMINFO2
+unload_lp $MOD_MEMINFO2
+unload_lp $MOD_MEMINFO
+
+check_result "% insmod test_modules/$MOD_MEMINFO.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO'
+livepatch: '$MOD_MEMINFO': initializing patching transition
+livepatch: '$MOD_MEMINFO': starting patching transition
+livepatch: '$MOD_MEMINFO': completing patching transition
+livepatch: '$MOD_MEMINFO': patching complete
+% insmod test_modules/$MOD_MEMINFO2.ko provides=1
+livepatch: enabling patch '$MOD_MEMINFO2'
+livepatch: '$MOD_MEMINFO2': initializing patching transition
+livepatch: '$MOD_MEMINFO2': starting patching transition
+livepatch: '$MOD_MEMINFO2': completing patching transition
+livepatch: '$MOD_MEMINFO2': patching complete
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
index 000000000000..c82827207f10
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
@@ -0,0 +1 @@
+#include "test_klp_meminfo_lp.c"
-- 
2.52.0

