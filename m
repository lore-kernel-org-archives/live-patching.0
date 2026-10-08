Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95488493D39
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453560; cv=none; b=gfvjgmATOx4yqOEhfPRJQGSV+ynxAzRZDZXQAn4vmkkw/gvLXv99lKtU10XNAkPS4PDIyKFvT+Smhv7L3N9tt9zm6Uf24G2xYJNULhC+DrQcGQJ8Xo4dP9usBR4F+mw8yEjeQhfaxoTj5b065PoFMq3DK+1RCdT1M+JP7Rf/rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453560; c=relaxed/simple;
	bh=voQk96wKfjEQzK6ffvfGxfHHprbrWZR2CjkaCZRAIqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTeeKvwEx3e2gAoRC/H0Z950tFvfXPAijCZMdwW2VkNpLQUCNuXIxFCdgiiovz2jYVAthPnBfIDhhdzcpwCVWMlyS0dnN2gT5UUZWXRc1wmucRo4gELf+iIsncz/gS1lKBk/x9kMnTclDgeXOgge41YuS7hL5N8dAJUtuk2O1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9LH0Jkh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9LH0Jkh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a865731ee4so2513893a91.2
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453553; x=1792058353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGixU0FoqHB3DXAMrtXSEoNzgdLmkIaJMSKNAw/x9yo=;
        b=o9LH0JkhNqDPiv94BapeqzldJZLJX94816qkLdp80NMjUfUF2+X3K9izaP8/Ci3iDW
         QPCTSEOiByS34YH6nNRg04wQx5tyUx02uYJ1oopGQxHpgV0d5KaUgGnMi/yVOUrAGr8O
         EmgV/O6CAPvzEVT/sz6ZonDH9vBL0JeopyDayumMKVXkz8fxI9E/dyrKv5dqtnAT05oP
         tEbxCJTc62vPqHrW3J7Sk/Db7pB7+LmATmvEFfT07mTUWEopQcRXD/SRwDaPFrzEbFZl
         x1radzichY/AiDfi5K6PfMf22ixLsRYQDO2n6Dpezsbfw71fQOjNdWnofnm7g212NQPp
         W2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453553; x=1792058353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGixU0FoqHB3DXAMrtXSEoNzgdLmkIaJMSKNAw/x9yo=;
        b=Y/oNzePJtMu8xTijKsb25KLKojRV0BHZzSPlMImsMoo9flGjqvqUbbxS2FTnhk1YlA
         o2WlCNdV/Q4zMKMySwBez2HqfuIZqpo/47grS+dS3dSp933xxJCosjFIMWaYJvWUXOhR
         /+NRm2bfgTZozfscRYLUNvPFxiWvMR+haqH1rtDiVrqXFTUxAV1CF0C5JgWrs4PTW5Kl
         aCT/whYycJ7KmvEKfr+pmerIqW97aynaFox3p4vC2+rMKC9gSR58v4Nk81qGdLsmeMXR
         h2jzFy2t3t+V8Yy09GH5RE2dtbcgw6xQM8CAPYP8p0gMFK7GZb7aaogw+lS+Hwi57Hk5
         2/9w==
X-Gm-Message-State: AFq9FYJ84a7K0uf2jVdoXJdntDst1saO4xpzoUWdogt2adhxUFflQLXv
	gfGsP15sniM67b2qUghr6y21koKVCMYyMVh6uo4WKmT3NT9F/eLd48CzaTRAR1YDUMXodw==
X-Gm-Gg: AYBFou2pqPoTK5b7mV62SYvCsGa7RmvgKQ7+9lwF6T7GhI3BG/hNLlnxUD0W57uRnh9
	t08udBR5s5ZqKXJAjxNNIvpuA+ZSaBuewrrLfB2qYZJB2zgq7Bf7UTkgMLe6adgIZz1wc00muOC
	iqvnL7coFOzSnM1ns99ip3OHKPTmUFiQJmfMaXIvy1UmBgzYOuA4nHkg8rKGcr8wwj4h+3Saa/r
	K85CEXHtix75ZkbTNgImsTwUte4uuK9ttvSPydN1Y6niVUA6t9LsEZ6YRy7kxO/nsxYxfd5tM7H
	dhQNo13yHCOeyac1pWGQj5LMnSA23cRPcKEvs1iiU0xWRUgEglF/R+pwbYkDt9SWL37zNij2nby
	nY8juoqim50M3+CWKiyhLsRj/I7uTVTVlbUu3woytymi6Pp8A7rtzfX7f2tui8nlOZz2Oev1tFW
	L7/kPWHwl6Jm5pU3S/Aq/hEA1h4Yus5k2KA7KgIDOk2xKd0NWp8J0a3cmT7iVpWMH+SXg/RDYxw
	41nTzQH86O6BgzXmbmXeMcHh0Te7BwIkqfko0oAKDpu81o3/DzsNWan
X-Received: by 2002:a17:90b:3912:b0:3a4:aa26:21c7 with SMTP id 98e67ed59e1d1-3a8a1974b40mr4654664a91.25.1791453553456;
        Thu, 08 Oct 2026 02:59:13 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2100:3ace:b801:9432:769f:ff9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ff13esm3422790a91.7.2026.10.08.02.59.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:59:13 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Wardenjohn <zhangwarden@gmail.com>
Subject: [PATCH v11 6/9] livepatch: Deprecate stack_order
Date: Thu,  8 Oct 2026 17:58:27 +0800
Message-ID: <20261008095830.26308-7-laoar.shao@gmail.com>
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

The stack_order sysfs attribute was added to determine which active
livepatch is used for a given function. It is no longer needed because
recent changes refuse loading another livepatch which would modify
an already livepatched function unless the new livepatch would replace
the conflicting one.

[Commit message authored by Petr.]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Cc: Wardenjohn <zhangwarden@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
---
 .../ABI/removed/sysfs-kernel-livepatch        |  9 +++++++
 .../ABI/testing/sysfs-kernel-livepatch        |  9 -------
 kernel/livepatch/core.c                       | 24 -------------------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
index 87d57ba27326..f094bd18379f 100644
--- a/Documentation/ABI/removed/sysfs-kernel-livepatch
+++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
@@ -5,3 +5,12 @@ Contact:	live-patching@vger.kernel.org
 Description:
 		An attribute which indicates whether the patch supports
 		atomic-replace.
+
+What:		/sys/kernel/livepatch/<patch>/stack_order
+Date:		Jan 2025
+KernelVersion: 6.14.0
+Description:
+		This attribute specifies the sequence in which live patch modules
+		are applied to the system. If multiple live patches modify the same
+		function, the implementation with the biggest 'stack_order' number
+		is used, unless a transition is currently in progress.
diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index e4874205c319..bb213ea9c135 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -67,15 +67,6 @@ Description:
 		either this patch's provides id or any id in the obsoletes
 		list will be atomically replaced.
 
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
index 91e6ea53b337..e86fd092e3e5 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -352,7 +352,6 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/force
  * /sys/kernel/livepatch/<patch>/provides
  * /sys/kernel/livepatch/<patch>/obsoletes
- * /sys/kernel/livepatch/<patch>/stack_order
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/patched
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
@@ -477,40 +476,17 @@ static ssize_t obsoletes_show(struct kobject *kobj,
 	return len;
 }
 
-static ssize_t stack_order_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
-{
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
-}
-
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
 static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
 static struct kobj_attribute provides_kobj_attr = __ATTR_RO(provides);
 static struct kobj_attribute obsoletes_kobj_attr = __ATTR_RO(obsoletes);
-static struct kobj_attribute stack_order_kobj_attr = __ATTR_RO(stack_order);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
 	&force_kobj_attr.attr,
 	&provides_kobj_attr.attr,
 	&obsoletes_kobj_attr.attr,
-	&stack_order_kobj_attr.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(klp_patch);
-- 
2.52.0

