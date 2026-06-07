Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E63A960F
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838274; cv=none; b=G51+bDC6vuzn1x3fMN+xC1+Y5DNDtRrFUtGokEwZPv5dfx8oXmQMjn6Au470HD9U34UOKnJwDnyJwRvm7LNxj0VluMaweVG4ESH1R9LhmmgNHQXk3em+K6dALZ14qxCLiGiyT/tQz1bPPfHxP32Vk1xMIebIaTvfD2rjDenPHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838274; c=relaxed/simple;
	bh=XNOcSJg2vMhUSEIVHD8ETAmAbLEQKIP7G39Ve47BRto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiCDPFceQQXr/0btB6dHYZdBHGAn2H0vAk6rFZmn4095E4V8uUSRTxoH+hfy0VUzqBHz82fgs8Vj/OJL7YOK4lmnq4sgvJ+r1jJpsQO3lyokQIfAsvFA5HUHB08EKZ/UB4VOLw1llaMJATLHNGw7QiOfXjKEkw2F+fJ2xjQ9DDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlXDQxpA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlXDQxpA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c3184c71so25614355ad.1
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838272; x=1781443072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqC2rDZqUsqnqCL+HTtHJLNGvWxW4IxK4900eHaUrEU=;
        b=IlXDQxpANxTwswGljN3g0MdWdm8dJgv6gv6wYaNErcMBVhQPqQJmVFXXW4mxS1K+Fn
         LDBZfMC6tQ/GnmJjpwmQhSYHkVjhRJPfKeT3oPFCMh1bs7L1Nc2ryePS8c+h7xwiSqYP
         JYuwDaT0gggAJr1pojKbwn3YuneVfUJKzWx5VjpM0vExAiYMGlMSYpkq/vo6w3yicl63
         M6ByhfPGnxYabuUSRxNA6pCsPtBj7vN0w+7NUlfGf5zoUdhSwBaz3eNWYGiwOF5gHKBR
         SlpAT1HJBjOBeCJL2xxr6G/1hC2tNd3HHa7hD1WmZfywpqw3w8qkHZy7WIAy5JQZ7PV0
         ZGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838272; x=1781443072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqC2rDZqUsqnqCL+HTtHJLNGvWxW4IxK4900eHaUrEU=;
        b=gFmlfwg1+s4Ec8KNxUKu96c16RTHdwpzka4mPGpFYutX2MtxVljaRxBW/8Xz0JsygV
         TyYM125r9Hukjgxaig8++Y3PUNY+hz3Ea4O2am9WDzJf66qimhN9BKfU/lZQPetb5o0P
         cGpleYnyKwWjK0fX/UdRoGpSAEoHJ7zgHiL8kAm+nRfn+Eg6Uq/Gj7Yr/jM9LJgsZhuy
         7QB3s8ifcEBe3Jd2zlucCz2IrEN9S0ji+xN0wb3FY0902lpg/v57+iOGYQ0C02uAnBtE
         Q6wjcDM3Ze7aYV50ULKswhg2DlYPo2AVFBtvX8L+EKYsy5JUyEtWf8DrJvDR6RNH3+sk
         +e2g==
X-Gm-Message-State: AOJu0Yxf4YHk/8FZbqpyCZdS4GPrDoeVEyvi7HOVOJwW+aR5b8U2KBqt
	pQZ5EedDkGfPHMFfPpLx0sky8wvnVX/iHH4QF8ei5K9PswLzk0ZYIC0M
X-Gm-Gg: Acq92OE7DsWEXSR3jEcxvlzQ71TZgxWZoguKKptVgHM/6leD/rehjxSkvlRrl4F8LvI
	O+qKYtlQO4DSzNr0xQe3NgYgG9Ps6N66YcdMabY90DE9RR2IIHZxAEa/oRmuw52OaMQGoboOJTd
	Wa4wgUViuKCCe00OovCKQg59yPAr84LFTnypqc2gqUsWVVFapeYKqzdiVYRZK7eMVxCxyQa43rX
	D3j5y3qlHLN2LwrRJmMGjMfrwRL+UdMVcotnWLtFWTXlFNi+rBxuT7nNSN52TF1PSL/9+JhXfkY
	K6JPMRWvvYF1vPo8DTL3UfQNnTDH8RbbfX7Av5jztByIQQfglDNzr7vBkgXJlonEvLb9ZRpzs/H
	e6dNmniGRbid3nK5hAvhDccvajbrPWAjOfGmWmYoVD6BJMq9Pnp2ufW43t3GmFGh7anfAyWyhRg
	3+GZyB+vBfYLdDlJA7E0LdLRuYXAcF28wl+WCJNpJr/b7JI8YbD0AVd1FwP+T1YI4ik9I5lNix0
	fViUfN37j2r
X-Received: by 2002:a17:903:1a70:b0:2c2:245a:3366 with SMTP id d9443c01a7336-2c2245a35b5mr75927785ad.27.1780838272450;
        Sun, 07 Jun 2026 06:17:52 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:52 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 7/7] selftests/livepatch: Add test for function conflict across replace_sets
Date: Sun,  7 Jun 2026 21:16:59 +0800
Message-ID: <20260607131659.29281-8-laoar.shao@gmail.com>
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

Livepatches with different replace_sets must not modify the same
function. If a second livepatch attempts to modify a function that
has already been modified by a loaded livepatch with a different
replace_set, the loading will fail. if the second livepatch
shares the same replace_set, it will load successfully.

Add a test case to verify this behavior. The test result is as follows:

$ ./test-livepatch.sh
TEST: basic function patching ... ok
TEST: multiple livepatches ... ok
TEST: module function patching ... ok
TEST: module function patching (livepatch first) ... ok
TEST: function conflict: different replace_sets ... ok  <<<<
TEST: function conflict: the same replace_set ... ok    <<<<

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/livepatch/test-livepatch.sh     | 59 +++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  1 +
 .../test_modules/test_klp_atomic_replace2.c   | 55 +++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace2.c

diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 4f8fb5620c6e..9cdfc048d71c 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -6,6 +6,7 @@
 
 MOD_LIVEPATCH1=test_klp_livepatch
 MOD_REPLACE=test_klp_atomic_replace
+MOD_REPLACE2=test_klp_atomic_replace2
 MOD_TARGET=test_klp_mod_target
 MOD_TARGET_PATCH=test_klp_mod_patch
 
@@ -203,5 +204,63 @@ livepatch: '$MOD_TARGET_PATCH': unpatching complete
 % rmmod $MOD_TARGET
 $MOD_TARGET: test_klp_mod_target_exit"
 
+# - load a livepatch that modifies function A
+# - loading another livepatch with a different replace_set that modifies
+#   the same function will fail
+
+start_test "function conflict: different replace_sets"
+
+load_lp $MOD_REPLACE replace_set=0
+load_failing_mod $MOD_REPLACE2 replace_set=1
+disable_lp $MOD_REPLACE
+unload_lp $MOD_REPLACE
+
+check_result "% insmod test_modules/$MOD_REPLACE.ko replace_set=0
+livepatch: enabling patch '$MOD_REPLACE'
+livepatch: '$MOD_REPLACE': initializing patching transition
+livepatch: '$MOD_REPLACE': starting patching transition
+livepatch: '$MOD_REPLACE': completing patching transition
+livepatch: '$MOD_REPLACE': patching complete
+% insmod test_modules/$MOD_REPLACE2.ko replace_set=1
+livepatch: Livepatch patch ($MOD_REPLACE2) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_REPLACE2.ko: Invalid parameters
+% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
+livepatch: '$MOD_REPLACE': initializing unpatching transition
+livepatch: '$MOD_REPLACE': starting unpatching transition
+livepatch: '$MOD_REPLACE': completing unpatching transition
+livepatch: '$MOD_REPLACE': unpatching complete
+% rmmod $MOD_REPLACE"
+
+# - load a livepatch that modifies function A
+# - loading another livepatch with the same replace_set that modifies
+#   the same function will succeed
+
+start_test "function conflict: the same replace_set"
+
+load_lp $MOD_REPLACE replace_set=0
+load_lp $MOD_REPLACE2 replace_set=0
+disable_lp $MOD_REPLACE2
+unload_lp $MOD_REPLACE2
+unload_lp $MOD_REPLACE
+
+check_result "% insmod test_modules/$MOD_REPLACE.ko replace_set=0
+livepatch: enabling patch '$MOD_REPLACE'
+livepatch: '$MOD_REPLACE': initializing patching transition
+livepatch: '$MOD_REPLACE': starting patching transition
+livepatch: '$MOD_REPLACE': completing patching transition
+livepatch: '$MOD_REPLACE': patching complete
+% insmod test_modules/$MOD_REPLACE2.ko replace_set=0
+livepatch: enabling patch '$MOD_REPLACE2'
+livepatch: '$MOD_REPLACE2': initializing patching transition
+livepatch: '$MOD_REPLACE2': starting patching transition
+livepatch: '$MOD_REPLACE2': completing patching transition
+livepatch: '$MOD_REPLACE2': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE2/enabled
+livepatch: '$MOD_REPLACE2': initializing unpatching transition
+livepatch: '$MOD_REPLACE2': starting unpatching transition
+livepatch: '$MOD_REPLACE2': completing unpatching transition
+livepatch: '$MOD_REPLACE2': unpatching complete
+% rmmod $MOD_REPLACE2
+% rmmod $MOD_REPLACE"
 
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index bdc5ae37311e..f7111d500cab 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -2,6 +2,7 @@ TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
 KDIR ?= /lib/modules/$(shell uname -r)/build
 
 obj-m += test_klp_atomic_replace.o \
+	test_klp_atomic_replace2.o \
 	test_klp_callbacks_busy.o \
 	test_klp_callbacks_demo.o \
 	test_klp_callbacks_demo2.o \
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace2.c
new file mode 100644
index 000000000000..1dff8b6d45ab
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace2.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int replace_set;
+module_param(replace_set, int, 0644);
+MODULE_PARM_DESC(replace_set, "replace_set (default=0)");
+
+#include <linux/seq_file.h>
+static int livepatch_meminfo_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
+		   "this has been live patched");
+	return 0;
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "meminfo_proc_show",
+		.new_func = livepatch_meminfo_proc_show,
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+	/* set .replace_set in the init function below for demo purposes */
+};
+
+static int test_klp_atomic_replace_init(void)
+{
+	patch.replace_set = replace_set;
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_atomic_replace_exit(void)
+{
+}
+
+module_init(test_klp_atomic_replace_init);
+module_exit(test_klp_atomic_replace_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_DESCRIPTION("Livepatch test: modified function compatibility verification");
-- 
2.52.0

