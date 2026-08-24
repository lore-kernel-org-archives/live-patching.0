Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25768374A1B
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542092; cv=none; b=P0/hLGgwygE90bVAd+uFwYw0DGuWvNr0rutrAHF6YH6H+32WT+OM3j391lX4QDZBzDxJcKYXj8SD+jA0EbPzpcZp2TGwzPy22n9XzCVvD38wWGnslFQ1NtSxtIb9D1+FA5Fir7feaTCRUGlU8JLyn6TLW5iT9ThG1PEe3Vj8YjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542092; c=relaxed/simple;
	bh=u4x1jQBAeKkMC3tZ23TwgbTv1atL9CH5ZKD7m/OpmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaPVekFxUwgT4BoWxi1DwMOX7u/ITxGhCO3nucY/lPyQcygUNiSg7aX10Uc6txy7Gj5Wr6hlD/CP7wQRBMiVfHP2mZcfG5XDTeJjdugGwjlqXGN65+nJXmDoRj/sACxH959G/V+/A+5qKJ8aBO3StswunhT56g68OTHYXjiYqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1UqUVow; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1UqUVow"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39266382df6so2315979a91.3
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542090; x=1788146890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jkF+mTos7/OYMfCffMPEPG7ZC3vKCzXZIxmIWlrIJ0=;
        b=j1UqUVowpnfCFwGZ6R8UkYIaEr+HGvtxukcDuA5Y/Q5MUlmfNk+cZ8dEenLOAfgfLF
         bw1b5JtcQnQ88T00yb65f4s97lF8x1Z8f0GsW1Lw0jPAnu8EwB54J+bs4OHDa3Fe7i/2
         f3N2OijedQJfa6lKOrU/EO6sZO67AHhIa6Z4YJgwRkW1PASNeEHmHzGTbeMlpi/zs9Yn
         xyr5j1GgHro1wFnMJmsf6daRCjm20EpqRR/erleIcDuz48FRHq5/ZP65oa9IEmXnn5XE
         DQnYHbR+yV01zgK+6eQHd7qdO4ei4YNwRsqiW1Pfe+7Yb5qx0pojQ6pUtqW2HTEOCltt
         I5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542090; x=1788146890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/jkF+mTos7/OYMfCffMPEPG7ZC3vKCzXZIxmIWlrIJ0=;
        b=IltmvjIEepT/YivrT8ib21D7GPnNHDcOzp4bJgT+84UhZC99NgTmGK0340Qp3ZsMSs
         cY0gqbpAodVE5KPgZIyT6hV3+q9pr4xg6qULOts5ak9ZMQWslpgYTjrghbfv2qwj8yBr
         ig6H+R9X10j4Zor/r7Jp2QhCquATfcgle0dzSJKhjQPKLWoFCJ6a5UlD9Pjxky+44S3C
         mfj9lBS9V0WzpKRz9gq2j0T4UkFWSpT2vgqmf7T3Qt47ys/MzZPEn/f6PiVrQU+ap9kp
         512g4Hr0Z69Cc8x+neHCAgX4cy+YaO0SRDGa0AslhetgCpOYKAMu50RX1CVwoXsz8NCt
         S60Q==
X-Gm-Message-State: AFuF++kphzpG6DD49XQE48sqEETRpA+PHpQHqz2IKfGT3bTB3OrtZu5B
	WuhtsFGdCS4ceLFlN7K5mV1MqkLRRHJZSsFcBXyF5NqUFUSHXTWVjAJm
X-Gm-Gg: AR+sD133s6rMkxmDF9UL6uTRIfVesv8MoH845sSG0xXdgvg58Noq4thoXimr8KPLPzp
	vskl15PiKZtZhvXCUGIMPiKx5tPORyUXjv/XOfScWrWfAn+5rNGK71ebkBDEfxCddOrMyc1fqRr
	0wvgRUPv9pMKlWBNT/thrHSNkyuZJV3vFMxoKx0SmIOchoVK92MxrN9WOU4xE0LXCn3Wix0agid
	du8mtgHo7c+HvQydo3VmmsH0g8m7idabjRXIOVIujzs6DJQ/0AgbG+3jZUZqEN4IPo3nLFqjy8k
	Ts7T55E6JQmdPyC5UlSO7Sl5HZ/lGxjIPQcoDdb+IyEwZHWbvhdixzj/V6JmbwdbPVCBGhfjM0p
	Ey6++qlR7ni24b/2zbj/snwdALv3JI12uMI0owTtDbHHClv+TAaOfRDf1YWL6vLFFjJB0CdwBBm
	47y48IAHuDNshkGClLne9dQNmBDVjEL44uht7rZoXlzI+isV5rCsi4eKKH2CNxzUv1qcScrqQi5
	L32SoZ6E+NfSLvNrH3bndE/DSwtQUxzOeZpwNOkSDg=
X-Received: by 2002:a17:90b:3bc6:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-395c354da4fmr42464555a91.10.1787542090322;
        Sun, 23 Aug 2026 20:28:10 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.28.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:28:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 8/8] selftests: livepatch: Add test for function conflict across provides
Date: Mon, 24 Aug 2026 11:27:32 +0800
Message-ID: <20260824032732.56686-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260824032732.56686-1-laoar.shao@gmail.com>
References: <20260824032732.56686-1-laoar.shao@gmail.com>
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

