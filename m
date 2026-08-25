Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CE3955C9
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658460; cv=none; b=EHKT574y747xc0xjU2zS0q2KHYDQPTAVWHNo9fGIOiNEGFwsHFjgX7eY9VGzw0L0YCqdWYzjNYLVV6o91ooRhqwRJLqMtikbKJTFH+mVUasaP7pHDIwXqp86dsbP8djJW/POxoS+Re+aZfCGnGCw8sf3gA6fOyN8RVagePS2R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658460; c=relaxed/simple;
	bh=u4x1jQBAeKkMC3tZ23TwgbTv1atL9CH5ZKD7m/OpmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhcPdIm6YTpGX1beK1S9Pykb2C2P8qvFkKLzPPtayBICtPb38wVx5W8PURpnEkAwXkVxIOGg4tuJkGZJzZ6ReyqUskXDCkoBG2ys8kIPoZdINjTO4fyPnmrAwczXnAOphgKTAeKwL+doKiUkiilVAjJ+l6ZGl68AVX+5BJoI+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcmT7ctH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcmT7ctH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4500389a12.0
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658458; x=1788263258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jkF+mTos7/OYMfCffMPEPG7ZC3vKCzXZIxmIWlrIJ0=;
        b=XcmT7ctHll9Uctw5ss3YawkPyWQ2kgRQM+hfXFMCgdA5XQGdELDSGdQoVihIz4yHg1
         mHIVg0abYc28CGNCTVEOzh8fgJYtvV8aaZ/mfzGkYhOVW641aSuS06Z4ZDQVYq0Dz6y7
         w3QGe4lpF3jkVTsFppFvyH7gDUvZEZtH5ta8Kot0ggXmz92PpgmyBbVciJfk41dk5tfd
         /eaB+xA8XoL7MbhCuLR+QrYFkdz4asKoA7mbNpGYlrKrq0RbieswoyyYVTaN9dOjX++I
         khKNSVMcg3H+99xdmP6ar5CgKycAvqrgJRunL8es5N+dYIYqc6OowAQIF1O2ZwOBvKzD
         5JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658458; x=1788263258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/jkF+mTos7/OYMfCffMPEPG7ZC3vKCzXZIxmIWlrIJ0=;
        b=FtcKp1kMoF9B3JdPgrqtJkgGpiCtPSEWM8p6GFoWwtvktydu4UiZ0k588bi3urNLgU
         SnK59AiIOXIOAlp2T+yEYh+XcOn05DziyaDMZLDN0vZS0O80nbyGYT/J58QDtqo6aVP9
         EKeS0LXj4iqFePopQYgAr3thKwCnfZpWQHX0jjwBc2+bFqu44NPbyrW3sDbhA6GYZsyU
         7yaHdUgJr4KUP5BcXfRDH5BA9RWTQ1YCtkPlGuVUtcIzuMJzrGOGE7cn8/1I1Trg5Uy0
         bWt4F4Ourqd3QvaSzYqh0K3KZL4vmxxdXcVGZO2PnMua00ZN8RkLeuiJ+RwWReiyyKWR
         U5kw==
X-Gm-Message-State: AFuF++nQNLafHXY3DdTjRUABnsif+ywop/Rz3pACLsg0sUmLV9Mr01y9
	HzrrVDq6g3hYuYxlXT2qoRJzs0jBpM/u2ALlJtNYbr1TYtIDztSTTvKZ
X-Gm-Gg: AR+sD13apmhQ8HfiISXIpcghwA0sRWktMUSyj89SD7/JSGE4v5c+tRP9zynbEe5JEW1
	rSUJ3SOtYDyX48Of++cNM2KlcCTzVJ5atAvZo7LimZeO3L18WJIFNftnXNKYCc09PKvkA97XxlY
	9AKDPPxz8dhFvtty+XXassSHdLlTDNVZCvsxnQRVLChLaRRHHco29eXDIMY2WJYeSaxc1JWi4Ci
	sYPj8yvlBKdwEvbcYQmCx1s69Ns4wCUXwk7RNtqW44n6iCu8nLdtRU+GgRMR+xN5yWFpwP1q34D
	D7lfT7vKI+ulvqq1dBhBtWW9FLQ+KjABPmyWbUs/PmFyZtDLvhiGDNbbdPp2CwMNgkRIT2RBONY
	Jtq5/HyiiwiXSeBXLF9mGemYYSTw8Pl9+P+MlNrgftdtvgpX9mezbN5KdEz9otVX1q2++xHOnHv
	ddnMsy/zCrxBhHXDvmX9Q/zejoxBT/rnT1ngKiDLBwMg4PIqpthNL/hNbWkJ/XxndZjcV2EfTUI
	du6um0xWKqFrLKuxD6vQ8eCkmdJC7ge555QvTY=
X-Received: by 2002:a05:6a21:910c:b0:3cb:82de:b952 with SMTP id adf61e73a8af0-3cd2fdba21fmr67207102637.2.1787658458397;
        Tue, 25 Aug 2026 04:47:38 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.47.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:47:38 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 for-next 8/8] selftests/livepatch: Add test for function conflict across provides
Date: Tue, 25 Aug 2026 19:46:41 +0800
Message-ID: <20260825114641.80452-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825114641.80452-1-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatches with different provides ids must not modify the same
function. If a second livepatch attempts to modify a function that
has already been modified by a loaded livepatch with a different
provides id, the loading will fail. If the second livepatch shares
the same provides id, or if its obsoletes list contains the first
livepatch's provides id, it will load successfully and replace the
first one.

Add a new test module test_klp_provides.c that patches meminfo_proc_show
(the same function as test_klp_atomic_replace) so that the two modules
can be loaded with different provides ids to test the function conflict
detection.

Add three test scenarios to test-provides.sh:

1. Function conflict across provides: load test_klp_atomic_replace with
   provides=1, then attempt to load test_klp_provides with provides=2.
   The second livepatch is rejected because livepatches with different
   provides ids and no obsoletes must not modify the same function.

2. Function replace within same provides: load test_klp_atomic_replace
   with provides=1, then load test_klp_provides with provides=1. The
   second livepatch loads successfully and replaces the first one
   because they share the same provides id.

3. Function replace across provides with obsoletes: load
   test_klp_atomic_replace with provides=1, then load test_klp_provides
   with provides=2 and obsoletes=[1]. The second livepatch loads
   successfully and replaces the first one because the obsoletes list
   allows it to replace a livepatch with a different provides id.

Assisted-by: Comagic:DeepSeek-V4-Flash
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../livepatch/test-provides-obsoletes.sh      | 110 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../test_modules/test_klp_provides.c          |  72 ++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_provides.c

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index f9a9f9b28490..be54e8d2c889 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -8,6 +8,7 @@ MOD_ATOMIC=test_klp_atomic_replace
 MOD_LIVEPATCH=test_klp_livepatch
 MOD_STATE=test_klp_state
 MOD_STATE2=test_klp_state2
+MOD_PROVIDES=test_klp_provides
 
 setup_config
 
@@ -257,4 +258,113 @@ $MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
 livepatch: '$MOD_STATE2': unpatching complete
 % rmmod $MOD_STATE2"
 
+
+# - load a livepatch with provides=1 that modifies meminfo_proc_show
+# - try to load another livepatch with provides=2 that modifies the
+#   same function. The second one must be rejected because livepatches
+#   with different provides ids and no obsoletes must not modify
+#   the same function.
+# - disable and unload the remaining livepatch
+
+start_test "function conflict across provides"
+
+load_lp $MOD_ATOMIC provides=1
+load_failing_mod $MOD_PROVIDES provides=2
+
+disable_lp $MOD_ATOMIC
+unload_lp $MOD_ATOMIC
+
+check_result "% insmod test_modules/$MOD_ATOMIC.ko provides=1
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% insmod test_modules/$MOD_PROVIDES.ko provides=2
+livepatch: Livepatch patch ($MOD_PROVIDES) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_PROVIDES.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_ATOMIC/enabled
+livepatch: '$MOD_ATOMIC': initializing unpatching transition
+livepatch: '$MOD_ATOMIC': starting unpatching transition
+livepatch: '$MOD_ATOMIC': completing unpatching transition
+livepatch: '$MOD_ATOMIC': unpatching complete
+% rmmod $MOD_ATOMIC"
+
+
+# - load a livepatch with provides=1 that modifies meminfo_proc_show
+# - load another livepatch with provides=1 that modifies the same
+#   function. The second one loads successfully because livepatches
+#   with the same provides id replace each other.
+# - disable and unload the remaining livepatch
+
+start_test "function replace within same provides"
+
+load_lp $MOD_ATOMIC provides=1
+load_lp $MOD_PROVIDES provides=1
+
+check_sysfs_value "$MOD_PROVIDES" "enabled" "1"
+
+disable_lp $MOD_PROVIDES
+unload_lp $MOD_PROVIDES
+unload_lp $MOD_ATOMIC
+
+check_result "% insmod test_modules/$MOD_ATOMIC.ko provides=1
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% insmod test_modules/$MOD_PROVIDES.ko provides=1
+livepatch: enabling patch '$MOD_PROVIDES'
+livepatch: '$MOD_PROVIDES': initializing patching transition
+livepatch: '$MOD_PROVIDES': starting patching transition
+livepatch: '$MOD_PROVIDES': completing patching transition
+livepatch: '$MOD_PROVIDES': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_PROVIDES/enabled
+livepatch: '$MOD_PROVIDES': initializing unpatching transition
+livepatch: '$MOD_PROVIDES': starting unpatching transition
+livepatch: '$MOD_PROVIDES': completing unpatching transition
+livepatch: '$MOD_PROVIDES': unpatching complete
+% rmmod $MOD_PROVIDES
+% rmmod $MOD_ATOMIC"
+
+
+# - load a livepatch with provides=1 that modifies meminfo_proc_show
+# - load another livepatch with provides=2 and obsoletes=[1] that
+#   modifies the same function. The second one loads successfully
+#   because the obsoletes list allows it to replace the first one
+#   even though they have different provides ids.
+# - disable and unload the remaining livepatch
+
+start_test "function replace across provides with obsoletes"
+
+load_lp $MOD_ATOMIC provides=1
+load_lp $MOD_PROVIDES provides=2 obsoletes=1
+
+check_sysfs_value "$MOD_PROVIDES" "enabled" "1"
+
+disable_lp $MOD_PROVIDES
+unload_lp $MOD_PROVIDES
+unload_lp $MOD_ATOMIC
+
+check_result "% insmod test_modules/$MOD_ATOMIC.ko provides=1
+livepatch: enabling patch '$MOD_ATOMIC'
+livepatch: '$MOD_ATOMIC': initializing patching transition
+livepatch: '$MOD_ATOMIC': starting patching transition
+livepatch: '$MOD_ATOMIC': completing patching transition
+livepatch: '$MOD_ATOMIC': patching complete
+% insmod test_modules/$MOD_PROVIDES.ko provides=2 obsoletes=1
+livepatch: enabling patch '$MOD_PROVIDES'
+livepatch: '$MOD_PROVIDES': initializing patching transition
+livepatch: '$MOD_PROVIDES': starting patching transition
+livepatch: '$MOD_PROVIDES': completing patching transition
+livepatch: '$MOD_PROVIDES': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_PROVIDES/enabled
+livepatch: '$MOD_PROVIDES': initializing unpatching transition
+livepatch: '$MOD_PROVIDES': starting unpatching transition
+livepatch: '$MOD_PROVIDES': completing unpatching transition
+livepatch: '$MOD_PROVIDES': unpatching complete
+% rmmod $MOD_PROVIDES
+% rmmod $MOD_ATOMIC"
+
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a4fe469a6501..13b1344b8e89 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -10,6 +10,7 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_livepatch.o \
 	test_klp_mod_patch.o \
 	test_klp_mod_target.o \
+	test_klp_provides.o \
 	test_klp_shadow_vars.o \
 	test_klp_state.o \
 	test_klp_state2.o \
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_provides.c b/tools/testing/selftests/livepatch/test_modules/test_klp_provides.c
new file mode 100644
index 000000000000..9751a6f6c851
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_provides.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+#ifdef KLP_HAS_REPLACE
+static int replace;
+module_param(replace, int, 0644);
+MODULE_PARM_DESC(replace, "replace (default=0)");
+#else
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+
+#define KLP_MAX_OBSOLETES 16
+static unsigned int obsoletes[KLP_MAX_OBSOLETES];
+static int nr_obsoletes;
+module_param_array(obsoletes, uint, &nr_obsoletes, 0644);
+MODULE_PARM_DESC(obsoletes, "obsoletes provides ids");
+#endif
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
+};
+
+static int test_klp_provides_init(void)
+{
+#ifdef KLP_HAS_REPLACE
+	patch.replace = replace;
+#else
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#endif
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_provides_exit(void)
+{
+}
+
+module_init(test_klp_provides_init);
+module_exit(test_klp_provides_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_DESCRIPTION("Livepatch test: provides conflict");
-- 
2.52.0

