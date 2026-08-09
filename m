Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59418342CB0
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267241; cv=none; b=TpTIncw6fZ0kauofqtd2TP09rRy13AzaoxwZBwZafe94MPrKEoQkI6W8WwvK8NSXLLUPt51q7OfUUtBUYuxWz/vKIZg9v8fiIgBje3Ru8pzBqqDWWK38egVc5cTA+TIzR9osdD8mofRIuq4EcnAj8jvB5pcVWNW6HBe5FnskHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267241; c=relaxed/simple;
	bh=kDQlMJShJBO3O1qZp3Fym29Z9SL6pEhfAXB+VKolh1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDsZikSsveivNd0nAaydWes0+jsTlU87ujtMKXbAdeaCGzMgroGhfmmuREJXq/A1MHLX4G2+yTXhJh6aevZF4vluMftmf8gyH5loMErikfuycgP/nf3BqgSJftcOCWmCB6dgq+HMAklWdRo8WNbRbILFaGt3uuCJFAwICw7PoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrDDYegL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrDDYegL"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so663493a91.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267240; x=1786872040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qe20G6+OsmcSI5TkL9eLgWXo/QsVz29J7OCLswVcZcA=;
        b=IrDDYegLGnt0WTI+BSdT+U4r+s1JTkYVQyc2zYBcfsSS8+QCov+ad2Qs254Cb0g6cr
         0g357KW7NRhaLa631zoRONIKUY0rrzl65XHKi9Do79OCCkavCL8E/xjAZLvfNfqPaCqh
         x/lc98zeul5v7Fg6/mJoSY7cZ+BPMHbmJ4SDM4o6dmktSCptK9MUZj7GIj3o5b+4JGXj
         +8YdUvGESoeaILpcAzO+w4Q+VmRKDbC+9Fmx03dkGWxs4RSau5Qj13tf8cuPIehHCnE3
         5gAnW/uCpe+Tptcl66kjEOgHDeORf3pzmT+8VkYWxkYJ9BftO+vRlsr1BYF2CTO/0SgV
         rO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267240; x=1786872040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qe20G6+OsmcSI5TkL9eLgWXo/QsVz29J7OCLswVcZcA=;
        b=O3zhBibeb/+vqOuq5SIxj0zTIW/tKBZaqyUddAHeGmBdxI8ZvGbP4GUMToEx/z9SO1
         P63AoMeq/6ENLZfZpX2HnuJRwfA7C3SkKHKQZZgmhgBE0L8D+zoVAT8EQWHzkdzLeL9Y
         OCxy252zBKkwmxa8p1dnNJh4F19nI89MdzhZKlq0CSzy0mqOzNov5QKzovt00IFC95Rz
         EfuwWqWcXKY2dTG5bcnhLRB9aGXJJZVD6XWsNXq2ZeQUGHKpT9V9p3kX+SmjDPsO0fQi
         7dg1RuARApxWHevvgdKFvFJxKQktqmjnaU5TKFDHpQRVioxuetY5m7IfOGRE/cLpjZkP
         Q1Mw==
X-Gm-Message-State: AOJu0Yz73irM1V50aAvN5YBhtZs71XTfZOEv9GvG6sRKu4mSmlWTxtT7
	rkQ/m21pzK+zjG5Fe809nG6LQsYCGneT99kAoA28sIbOUzhuScFBWwjy
X-Gm-Gg: AR+sD13zpqZMjSjFsTAqb8MwjNNPGX4yd9xAPcxY5kt/UFDm/gRsBvFj2lxzkVdhqvR
	na9rIFXSTH1npQTP2MRxexE+pmKUzFQ3fxU+fYACBYBxOhSosniSug9bo8iKxLZb3f++5FHiYyJ
	OzRcqeefbcdczysXysP9yNu+KdTNxDOo+Li2XXKcU8yYlWtB89nGW8G06n6sxM2HN583e2kj3PM
	M/Wq3LTl5mJizNIHm/LjN8aAxgYmTCcKit+aw1mo7tA2W912SyMjTY3uJJ6OQF0TZoEbiTTbxys
	zqV3XWhlp1ZF8VDA3hp5XwCoIW4M8gh+e0pVgGrtmD+igj4+sEJNGtVHXOGJtFc0iswdXIaUwmV
	PZbV/BOhhgo2KKlNkptYgDzzh22k5H4nWWp7wGBVfRdao1xeEnIKREwTWMSRMFW9GPYgSjyu9Nu
	hdg8W6Gc0wqsUWiVnEmQ1ZHFaxhwoXyg0stbyRxGYsibc49u7zhjGrCJj2N2mryaNvbIDSZop7e
	VeDVubdye1SUpmDYdGcbZgRukMX5hEKvDV0fdOE7PFzCgw4HtcXifB9cQ==
X-Received: by 2002:a17:90a:ec85:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3909d8075eamr23829028a91.7.1786267239679;
        Sun, 09 Aug 2026 02:20:39 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 8/9] selftests: livepatch: Add test for state ID conflict across provides
Date: Sun,  9 Aug 2026 17:19:52 +0800
Message-ID: <20260809091954.22930-9-laoar.shao@gmail.com>
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

Livepatches with different provides ids must not share the same state
id. If a second livepatch attempts to reuse a state id already
registered by a livepatch with a different provides id, the loading
will fail. However, if the second livepatch's obsoletes list includes
the first livepatch's provides id, the second livepatch replaces the
first one and may reuse the same state id.

Add provides and obsoletes module parameters to test_klp_state.c and
test_klp_state2.c (guarded by #ifndef KLP_HAS_REPLACE) so that they
can be loaded with different provides ids and obsoletes ids.

Add a "state id conflict across provides" test scenario to
test-provides.sh:

  - Load test_klp_state with provides=1, which registers state ID 1.
  - Attempt to load test_klp_state2 with provides=2, which reuses the
    same state ID 1. The second livepatch is rejected because
    livepatches with different provides ids must not share the same
    state id.
  - Disable and unload the remaining livepatch.

Add a "taking over system state via obsoletes" test scenario to
test-state.sh:

  - Load test_klp_state with provides=10, which registers state ID 1.
  - Load test_klp_state2 with provides=20 obsoletes=10, which reuses the
    same state ID 1. Although the provides ids differ, the second livepatch
    replaces the first one because its obsoletes list includes the first
    livepatch's provides id (10). The state is taken over successfully.
  - Unload the replaced livepatch, then disable and unload the second
    livepatch.

Assisted-by: Comagic:DeepSeek-V4-Flash
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../livepatch/test-provides-obsoletes.sh      | 86 +++++++++++++++++++
 .../livepatch/test_modules/test_klp_state.c   |  9 ++
 .../livepatch/test_modules/test_klp_state2.c  | 19 ++++
 3 files changed, 114 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
index c740d463f556..1b2c73bdd50b 100755
--- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
+++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
@@ -6,6 +6,8 @@
 
 MOD_ATOMIC=test_klp_atomic_replace
 MOD_LIVEPATCH=test_klp_livepatch
+MOD_STATE=test_klp_state
+MOD_STATE2=test_klp_state2
 
 setup_config
 
@@ -192,4 +194,88 @@ livepatch: '$MOD_ATOMIC': completing unpatching transition
 livepatch: '$MOD_ATOMIC': unpatching complete
 % rmmod $MOD_ATOMIC"
 
+# - load a livepatch with provides=1 that registers state ID 1
+# - try to load another livepatch with provides=2 that reuses the same
+#   state ID. The second one must be rejected because livepatches with
+#   different provides ids must not share the same state id.
+# - disable and unload the remaining livepatch
+
+start_test "state id conflict across provides"
+
+load_lp $MOD_STATE provides=1
+load_failing_mod $MOD_STATE2 provides=2
+
+disable_lp $MOD_STATE
+unload_lp $MOD_STATE
+
+check_result "% insmod test_modules/$MOD_STATE.ko provides=1
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko provides=2
+livepatch: Livepatch patch ($MOD_STATE2) is not compatible with the already installed livepatches.
+insmod: ERROR: could not insert module test_modules/$MOD_STATE2.ko: Invalid parameters
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE/enabled
+livepatch: '$MOD_STATE': initializing unpatching transition
+$MOD_STATE: pre_unpatch_callback: vmlinux
+$MOD_STATE: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE': starting unpatching transition
+livepatch: '$MOD_STATE': completing unpatching transition
+$MOD_STATE: post_unpatch_callback: vmlinux
+$MOD_STATE: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE': unpatching complete
+% rmmod $MOD_STATE"
+
+
+# Take over system state change by a patch that obsoletes the old one.
+# Although the provides IDs are different, the second patch's obsoletes
+# list includes the first patch's provides ID, so it can replace the
+# first patch and reuse the same state ID.
+
+start_test "taking over system state via obsoletes"
+
+load_lp $MOD_STATE provides=10
+load_lp $MOD_STATE2 provides=20 obsoletes=10
+unload_lp $MOD_STATE
+disable_lp $MOD_STATE2
+unload_lp $MOD_STATE2
+
+check_result "% insmod test_modules/$MOD_STATE.ko provides=10
+livepatch: enabling patch '$MOD_STATE'
+livepatch: '$MOD_STATE': initializing patching transition
+$MOD_STATE: pre_patch_callback: vmlinux
+$MOD_STATE: allocate_loglevel_state: allocating space to store console_loglevel
+livepatch: '$MOD_STATE': starting patching transition
+livepatch: '$MOD_STATE': completing patching transition
+$MOD_STATE: post_patch_callback: vmlinux
+$MOD_STATE: fix_console_loglevel: fixing console_loglevel
+livepatch: '$MOD_STATE': patching complete
+% insmod test_modules/$MOD_STATE2.ko provides=20 obsoletes=10
+livepatch: enabling patch '$MOD_STATE2'
+livepatch: '$MOD_STATE2': initializing patching transition
+$MOD_STATE2: pre_patch_callback: vmlinux
+$MOD_STATE2: allocate_loglevel_state: space to store console_loglevel already allocated
+livepatch: '$MOD_STATE2': starting patching transition
+livepatch: '$MOD_STATE2': completing patching transition
+$MOD_STATE2: post_patch_callback: vmlinux
+$MOD_STATE2: fix_console_loglevel: taking over the console_loglevel change
+livepatch: '$MOD_STATE2': patching complete
+% rmmod $MOD_STATE
+% echo 0 > $SYSFS_KLP_DIR/$MOD_STATE2/enabled
+livepatch: '$MOD_STATE2': initializing unpatching transition
+$MOD_STATE2: pre_unpatch_callback: vmlinux
+$MOD_STATE2: restore_console_loglevel: restoring console_loglevel
+livepatch: '$MOD_STATE2': starting unpatching transition
+livepatch: '$MOD_STATE2': completing unpatching transition
+$MOD_STATE2: post_unpatch_callback: vmlinux
+$MOD_STATE2: free_loglevel_state: freeing space for the stored console_loglevel
+livepatch: '$MOD_STATE2': unpatching complete
+% rmmod $MOD_STATE2"
+
 exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 313401a5506e..77a5511d9d69 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -9,6 +9,12 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
+#ifndef KLP_HAS_REPLACE
+static unsigned int provides;
+module_param(provides, uint, 0644);
+MODULE_PARM_DESC(provides, "provides id (default=0)");
+#endif
+
 #define CONSOLE_LOGLEVEL_STATE 1
 /* Version 1 does not support migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 1
@@ -151,6 +157,9 @@ static struct klp_patch patch = {
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifndef KLP_HAS_REPLACE
+	patch.provides = provides;
+#endif
 	return klp_enable_patch(&patch);
 }
 
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index 1afc2cabc39d..53ff6e793952 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -9,6 +9,18 @@
 #include <linux/printk.h>
 #include <linux/livepatch.h>
 
+#ifndef KLP_HAS_REPLACE
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
 #define CONSOLE_LOGLEVEL_STATE 1
 /* Version 2 supports migration. */
 #define CONSOLE_LOGLEVEL_STATE_VERSION 2
@@ -180,6 +192,13 @@ static struct klp_patch patch = {
 
 static int test_klp_callbacks_demo_init(void)
 {
+#ifndef KLP_HAS_REPLACE
+	patch.provides = provides;
+	if (nr_obsoletes > 0) {
+		patch.obsoletes = obsoletes;
+		patch.nr_obsoletes = nr_obsoletes;
+	}
+#endif
 	return klp_enable_patch(&patch);
 }
 
-- 
2.52.0

