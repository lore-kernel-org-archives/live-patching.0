Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792D2BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838259; cv=none; b=W0a2++Z/bOSlkEo1lnnrNidyprpJ7gP2mXhUA8H4l298/wnybM70ccRR6zuYQbmqWkJBqswag619Do/s6qj0oCMCTGrVFuDdjYqruJ5wgQf2wmIKTmdu5Y9M9LHUrmOQK2TjddwLG0PmNdM8mo9QLt4Qk0EHrLcMMj0OuIXUDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838259; c=relaxed/simple;
	bh=XeQ3hUk2s7/f2NL9g+colL2/Q2wac2+sIfySkVbGfMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8nSRt6RT7GABKoKdO5bjgu3fOZwni7GoSy3+MYINPqVVuL7ilw/482EqsXo61peD7XM+VO/CiCDobjye2XRMZGMBJjy4hAZoTi18juEJH/M/qBQ9i+qE7ey9xgbfBrEIVeRlvtmSO1UBWtr0iM4Q20dAOg8bH8h785ksAXmIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2sY31lb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2sY31lb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf125989f2so24274885ad.3
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838257; x=1781443057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAwPbBXdlArjB04xajcWdI1Qit+xp99MYVbAi5ctmfA=;
        b=P2sY31lbAJTRt22Wf47McD7w6m6mkBMYxhEOP37KQPhDzGsOKOCcFNa71FXA2H6xPx
         C0/JjDlgfDjwOBoMwVayn/2S+FhvszVbbKOUpivuf1x4oeVexYvFnIsdk4v0t8kt9VwB
         5fAOBPMb5oY9G3szox6NYyYC1M+SRlmije1N8sqPAezP1iw3K/2mZRk7r38YnkYsPWdD
         5vFfNAstpiz5UMEJKbiupGOjH7Oi5UWx8tOm+5f29eyfJ7tQvjRF0IrjZm0GhCvcyZiM
         pC1kOEBxyanHnzOkfrmvFUhatAJH0kz+cksbdHue3SMqWOF8/zafGoBZRJg2cUD3Audv
         NUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838257; x=1781443057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAwPbBXdlArjB04xajcWdI1Qit+xp99MYVbAi5ctmfA=;
        b=iUrzB7RS329k2uC/au/Wd9pHyK0KEh4GiW0mk8gZRutgeksrv7OLQ2TWY4q3jcrrUU
         OvoUcCaU8j/kqSCWhWI2y2zx7HSr6QS1YBz4OHabyrtm9WaoiW2qoFVcJGukBA9Mt7xl
         y+4JPPqca3UqLISB6thOJeJiF5zO6cc/Hga+zS3HzfUDtCLKHmxYyRNTG4Rfj2ZLiJPO
         8fWo/fwmVTRurJ2drMiRExI3S/fz5O+Zicin/zPOqTxPffr7XRMXuEfey+tglIlNVrzD
         qm66bPwOvTn6QRLTcNK16QDxUzJqEBTQVipDS8m2r8vk0D6u3pJwb2zgsqyGJi1Dq8AY
         Rl1A==
X-Gm-Message-State: AOJu0YztUyizDP7Csr/MwTH04jNw2si69QsAUBIEW9uhw4UJXhcXBhjZ
	NKaTd7KbZgaIK69e7hulIMBU1H5qnc1FpzohtKPrw9LpgRJGazcmbC4m
X-Gm-Gg: Acq92OHNePjFb+lAPoJXY7jtaMcQWG9NtnNYWENEn46pzOZ3bT1AjkqUPoNuiNG1VQk
	Sq0iYFHv8HrFKNhdHSgDLFvZxXyvbaTJzkaY1ABe86DT0wsVN2++0RE/k1xI8DFHz2u1762wf+k
	w5uzq1jQh0zKyJCq9ZcJJ+Qkr/xOn0XwGTjlNTGARODQww8Blh2JIcwsxlPbTpmqbzu8SEhhDIO
	s0VA1pKs2pCoWOg+shnrbZGumdA65kdI5wgFB2VQ+xYkDlpUm+8d8468BdJ+uGfy5sb2QXxWzg4
	VDfTGNT/xfqm09/Q05wPom64taN/DOBLPG5umgmvlMUFacr5YtNLXnU0TCqT6gtc7KDRZ+AOTzY
	TZkpOCgTKecH1gvKm2bS/RbVzo5yQesRhYalF/Grr3PKlZHdpuhCxIQfOthFoDdXQshAuzffD9t
	e03VT5OWEOPHANd1czSGU+W+uRSK5h+h1CiLadGg4Z3YaGo8j/MZr4k82xxLh7rHFP7T5E91oYY
	k6lfAPp9yg/LJAcvZp/xLY=
X-Received: by 2002:a17:903:1252:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c1e8102377mr126178175ad.32.1780838256978;
        Sun, 07 Jun 2026 06:17:36 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:36 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Wardenjohn <zhangwarden@gmail.com>
Subject: [PATCH v3 4/7] livepatch: Deprecate stack_order
Date: Sun,  7 Jun 2026 21:16:56 +0800
Message-ID: <20260607131659.29281-5-laoar.shao@gmail.com>
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

stack_order is no longer needed for atomic-replace livepatches, as a
single function can only be modified by a unique replace_set.
To maintain backward compatibility, print a dummy value, as suggested by
sashiko-bot.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Wardenjohn <zhangwarden@gmail.com>
---
 .../ABI/removed/sysfs-kernel-livepatch        |  9 +++
 .../ABI/testing/sysfs-kernel-livepatch        |  9 ---
 kernel/livepatch/core.c                       | 20 +-----
 .../testing/selftests/livepatch/test-sysfs.sh | 69 -------------------
 4 files changed, 12 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch

diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
new file mode 100644
index 000000000000..72c1ce0ea864
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
@@ -0,0 +1,9 @@
+What:		/sys/kernel/livepatch/<patch>/stack_order
+Date:		Jan 2025
+KernelVersion:	6.14.0
+Description:
+		This attribute specifies the sequence in which live patch modules
+		are applied to the system. If multiple live patches modify the same
+		function, the implementation with the biggest 'stack_order' number
+		is used, unless a transition is currently in progress.
+
diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index 6d75235a6a2e..9d356d8b8c75 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -54,15 +54,6 @@ Contact:	live-patching@vger.kernel.org
 Description:
 		An attribute to show the replace_set of this livepatch.
 
-What:		/sys/kernel/livepatch/<patch>/stack_order
-Date:		Jan 2025
-KernelVersion:	6.14.0
-Description:
-		This attribute specifies the sequence in which live patch modules
-		are applied to the system. If multiple live patches modify the same
-		function, the implementation with the biggest 'stack_order' number
-		is used, unless a transition is currently in progress.
-
 What:		/sys/kernel/livepatch/<patch>/<object>
 Date:		Nov 2014
 KernelVersion:	3.19.0
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 361999e5ce3d..c73eccd2cd13 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -330,7 +330,7 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/force
  * /sys/kernel/livepatch/<patch>/replace_set
- * /sys/kernel/livepatch/<patch>/stack_order
+ * /sys/kernel/livepatch/<patch>/stack_order <deprecated>
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/patched
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
@@ -436,25 +436,11 @@ static ssize_t replace_set_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%u\n", patch->replace_set);
 }
 
+/* This interface is deprecated and will be removed in the next release */
 static ssize_t stack_order_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	struct klp_patch *patch, *this_patch;
-	int stack_order = 0;
-
-	this_patch = container_of(kobj, struct klp_patch, kobj);
-
-	mutex_lock(&klp_mutex);
-
-	klp_for_each_patch(patch) {
-		stack_order++;
-		if (patch == this_patch)
-			break;
-	}
-
-	mutex_unlock(&klp_mutex);
-
-	return sysfs_emit(buf, "%d\n", stack_order);
+	return sysfs_emit(buf, "-1\n");
 }
 
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 58fe1d96997c..0c31759f34f6 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -21,8 +21,6 @@ check_sysfs_rights "$MOD_LIVEPATCH" "enabled" "-rw-r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "enabled" "1"
 check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
 check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
-check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
-check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
 check_sysfs_rights "$MOD_LIVEPATCH" "transition" "-r--r--r--"
 check_sysfs_value  "$MOD_LIVEPATCH" "transition" "0"
 check_sysfs_rights "$MOD_LIVEPATCH" "vmlinux/patched" "-r--r--r--"
@@ -135,71 +133,4 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
-start_test "sysfs test stack_order value"
-
-load_lp $MOD_LIVEPATCH
-
-check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
-
-load_lp $MOD_LIVEPATCH2
-
-check_sysfs_value  "$MOD_LIVEPATCH2" "stack_order" "2"
-
-load_lp $MOD_LIVEPATCH3
-
-check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "3"
-
-disable_lp $MOD_LIVEPATCH2
-unload_lp $MOD_LIVEPATCH2
-
-check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
-check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "2"
-
-disable_lp $MOD_LIVEPATCH3
-unload_lp $MOD_LIVEPATCH3
-
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH
-
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-livepatch: '$MOD_LIVEPATCH': patching complete
-% insmod test_modules/$MOD_LIVEPATCH2.ko
-livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
-$MOD_LIVEPATCH2: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
-$MOD_LIVEPATCH2: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': patching complete
-% insmod test_modules/$MOD_LIVEPATCH3.ko
-livepatch: enabling patch '$MOD_LIVEPATCH3'
-livepatch: '$MOD_LIVEPATCH3': initializing patching transition
-livepatch: '$MOD_LIVEPATCH3': starting patching transition
-livepatch: '$MOD_LIVEPATCH3': completing patching transition
-livepatch: '$MOD_LIVEPATCH3': patching complete
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
-$MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
-$MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
-% rmmod $MOD_LIVEPATCH2
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH3/enabled
-livepatch: '$MOD_LIVEPATCH3': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH3': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH3': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH3': unpatching complete
-% rmmod $MOD_LIVEPATCH3
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
-% rmmod $MOD_LIVEPATCH"
-
 exit 0
-- 
2.52.0

