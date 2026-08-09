Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91446399365
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267247; cv=none; b=Pq3jmBhMIvxlDwB5Tm0fv+MEQ7gyfD0vF+Ht5RKbUTIatluINQxIBtaVYTNMaCEvY/K1CPBcdlbIYCykbWXImBTmj9I173V1bTjUuB2y36bUB/IzyE1u5c9SZ2+JxpYOnr+SMN+HjzYb2VBNRNdWSo84CRHcPU7RyGaHTgYYpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267247; c=relaxed/simple;
	bh=rjjTwvKy4t2NGHapJLajo1+gBZKBkf3P1RMKdVJJ3BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxQ4EQI8C3zwF2BbAbyBKhXq4Ot+ZgwLshFmwXGn7SVmdVRzgO2jclPClSeNNrcBO0u7xZE3YnqG58kl5kiYomck5X/rFit0GQsnqHLSEMy+fKB6jK9OyYv/9OtVXk3dBA3EoR/bAgqebNGP2PiSOAN7/nJE5szBKCyrtAuxeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKgEVzcj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKgEVzcj"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39266382df6so931747a91.3
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267245; x=1786872045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBS11YxXiKc8p6JAh9VOjoG2uL0DDFWNhqFXtGPtHiU=;
        b=AKgEVzcjLKI0w3BJ/hr6NkcHK848XkBnyfZpWEZQldZKvnunAz+0V0wtGnndj7A3QV
         xx7nttR3OEA+jDxNcO3U8/JHGWuPTPTM0iWRQzvCzdlE1vOz3+IaB0BYb2NGgGYW2674
         cQK9pQp2f3i4uauOXrAJX7aCU/Vo+memhPLa/KpiGvqX1UMWv5zuYcPEZNidc2WNUw7c
         zWkdwpwG73COiihJktEBneRWitCON83ZUDeT5Lo6F576vWYohMI6IAJ6RBk4aXsP5kRL
         ZuwXjXYsSex8ezdDlIuRdIilJbsNLAhT2wM1PSN2gkzNKySDV+eyZeb96HHtR2glzs9g
         1hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267245; x=1786872045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBS11YxXiKc8p6JAh9VOjoG2uL0DDFWNhqFXtGPtHiU=;
        b=QZKfNlEvdzZ0EOHybjN9bHEpuhdiekoJuLtHvrmEm4rHcg54zxZXKpQizWwg9xSnoN
         NuWD/MrLCc5YpjXt9mErcstbfkzzNOX7BXPmfOduAcQS42f9uXcb27n6lBlf0NFa5/7F
         FSD0r0ONrM4gtYo+JBiIIa2JjEPrMU+k5O/bmgx3YRebQiNCBUT8/6mFYR2w++07grot
         spy+Bc9a+a4C4aPrJ0y2XjXOYP16o01xet2ZWa7pOTk1vLYA7p+3Di7IefLGKLaq7tqL
         1oCclzc/WbuOMDX5MSXHI00Azd2rDFZUfb+RwCVIVJUTlL7JURxrL3sXQnuDWnG/6whj
         1iLQ==
X-Gm-Message-State: AOJu0YxAfoe8pOZCmh+xK9NfH8LWcuONgjZTNxEA2GnWfC8wMCaCes36
	M30BTuyLll7rkLKx77U4FLN3j05k/3yfgRanfd6EbPlOPwciktUBNrrj
X-Gm-Gg: AR+sD12AmJcqb2gDRbXAceRetl7SXgxUo6LjNzIoetMQ6M6mXucW4AWtvLqxL7cuWTR
	YIuDRNEF49GtdwCmn8/CFnw8BkIj61g15vBX8CLCovhMummm402ux+u3vj944IIgaT5pjioyqNo
	+Z0Ye/qHjqsYYUaccpx+PXdT9bQUJf2Wtm/eVt0WG+GTWu7ixbQXX7G0/fKfHOXI1mSqRj1zSgi
	3nPSXdAUFrEwzZOGoG4OB+4I7diQU2Sc4OaxCf6G1C33ggRUs63kwqCxdIEw5ob99ug4Ii2WD70
	F9VNxaOSa7x+WgVZmBfgDjjLe1gVngkqh3Qk2KuSP5eALrS+NT+0juzDyns3O65ZMt6hxcIc1Og
	LgtsWmhwskMUXCPdl2hNTn36+KOd5A+9togmfI+CH9H/9BXBLSbpQ7VfcRCvDHvgUN52E6NYda2
	tOP/XMCsIZ6XRfnYOrzGu2G5JpqDZoGQfrVNkzgzCzrtdGn4qmeqTJPOBrTtf7aI0wYPaRgVfW9
	A+7Hnp2q4VEt8Xj6Ti1y6xIMsxWSlgBI9KPj95K4LWguQeO86M30z8bRL5mX7VBVj7q
X-Received: by 2002:a17:90b:1d02:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3903c599356mr35753473a91.2.1786267244628;
        Sun, 09 Aug 2026 02:20:44 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 9/9] selftests: livepatch: Add test for function conflict across provides
Date: Sun,  9 Aug 2026 17:19:53 +0800
Message-ID: <20260809091954.22930-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260809091954.22930-1-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
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
 .../livepatch/test-provides-obsoletes.sh      | 120 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../test_modules/test_klp_provides.c          |  72 +++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_provides.c

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index 1b2c73bdd50b..32885625401d 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -8,6 +8,7 @@ MOD_ATOMIC=test_klp_atomic_replace
 MOD_LIVEPATCH=test_klp_livepatch
 MOD_STATE=test_klp_state
 MOD_STATE2=test_klp_state2
+MOD_PROVIDES=test_klp_provides
 
 setup_config
 
@@ -278,4 +279,123 @@ $MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
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
+mods=($SYSFS_KLP_DIR/*)
+nmods=${#mods[@]}
+if [[ "$nmods" -ne 1 ]]; then
+	die "Expecting one module listed, found $nmods"
+fi
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
+mods=($SYSFS_KLP_DIR/*)
+nmods=${#mods[@]}
+if [[ "$nmods" -ne 1 ]]; then
+	die "Expecting one module listed, found $nmods"
+fi
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
index 29c55df36046..9f5ea09c55f7 100644
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

