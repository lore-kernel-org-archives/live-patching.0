Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49154374170
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267411; cv=none; b=QQX0E0mHq3CzgmgEDu/YZU0hlx2seEn4i+j/v0fYDzKwU3p1Ug3Ycq8z3x8mOPobcx+hmeneK13L+mA7wsMUXncjq9lLgDPBZmGy864q7xq12F+Z3j2fh1BqkDo1tTUhPt7LzquW/NNUs3X1oXCrp0Or7M7my8meqsSkgjI8t70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267411; c=relaxed/simple;
	bh=RMa+DDRFt/yQjJVVIrQ5u2fz2BnMfQXT56MrqfNVdY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk8ut+BQV1toD07VR+s9zakqLvf8gYLoc+Sc68M8Q+QEAMP1v94xPQo3PdvOwrlrIZ44OeLf3RWzBM3tVRd68UuE3mdwltoWoCX7tPt7SvvJpV9bhA/pKlhAfAGjc8hqCi6bjzKyR6l4UDDwsX5WUonNDaeoWwV+nAF1FAivEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3gLwXF0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3gLwXF0"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1976225a91.0
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789267409; x=1789872209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZgejVXH84zDc5+k1DS+opd8Pl3u7lMCY7qlM/d6M7k=;
        b=f3gLwXF0e3SiD3P9IHGFgt+awPPL/I9Ao4jZD/b/maW6N8hk0kEgtEdqWNdVm4SSVA
         COm4WC8pRtv7z9IzyyBMhUoBJ5DZ78B5/gZ5zjl5Fkn9GdGJ+8MDThFcXWFg5SSyPs7o
         FHHbT0Hll+g/zYKFbBjJU3JHpwEjL6OwoIna8EjVARHSS5Ugo2GtxEaL3zgyQBYzdreI
         iYeTmtjJt1HXgK1OlLhpHfY5R2R6NZXCYOv8HyhIVlfSGOJqAIVmjPfhwHl+1A8b/z/i
         fBvS/QxTgNlN2HiJQf4Kue8rKD3ILzH81X2XUiI5rltKFtNcczMkNJVnxkJb5Ps3iYZf
         u5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267409; x=1789872209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZgejVXH84zDc5+k1DS+opd8Pl3u7lMCY7qlM/d6M7k=;
        b=UhEJKr3Grcf9GW4FmyW1H7MB/ZB4QaHAoW1/Xqjfyqk4x8Rh/vBeeHYSaNybc9wK9Z
         gD6NnDpMYG7LV+IIt/d0qUqnX2O3dA9+On4aCOKuRR22bcEeKeFf2AfQhtvREJSUH+h9
         7fKUWVP+SOU2prnu8atCgJg5Ro/0nI/h2Y0Vjr15nBA7PrXq1Dkyx+xyEB7y9Uye0E9Z
         PHTQaGZTOih1PDAevjZpUBM5Wb/m3HKnCfXdXWNhue8xVeu9qDryDQZuYmzEhk5orpyB
         cFyZTabCmfaQR/WlnCoOlh+LEkVReSJ7KYFYcTcJv98xljd4u7mfsfKeNJTFvISrDGj7
         2JCQ==
X-Gm-Message-State: AFuF++khOh28y99pQyau1xKmYeNtXUJbEH/b8KItSqsomlTAB/2LGjEP
	WgwlxyU0QLJ77On9qusABgR8TKcxdC5V1jyaPLSiggKXLrvgnjbiFzhB
X-Gm-Gg: AYBFou1ZOclfTH7GdUhmRqfEMlq5fNV0OHBOSWrl9lyMNKCzafqCO3Sty6QjvDwcfJP
	idi72IPhufwNsX2OQxLQGqw69ItpoDI1CmGwsB5lVA8VI/z/f1y6W5Ej2mXWnD3/In9hZb7xQwF
	WdQu+kG4AamvleZoZRE4ProXMxAZH40rOiiLPhg0c6g1daRvDOCNum8aNlicwplug0Shffk79yk
	yjfJSAUAg1RZh0IEm0WNfKFIY2RkgzTgboU52p+DzZD3pGWMfab/Og7bXLrbuQUjP8ImB7gEqCA
	HiCy22y/RkBvEPACpKKSLUqWaVfWksbsdzvCEtpt7NgbjxTL2NsfTjVWmSxmSxD3+eT3zStei7l
	REvyuMoleKTr7G9l3MFwx1U9XqN6wHhHHASYm+ChEgoXsfR+YOYPDVZopOvVrS0v0lY5WC+IZM2
	QrrFcCpmOnwXWj5YPDx30tSymoK7LneS0n1u9eN2SUQynD9WXmKPM654497vXwAtYOHlqSm0SYh
	xLtx/WBdQq77TJrN6MjlL4yHJ7dNtI1lU6cMNGhY8ptXDzOReZa7+VNWg7d1pmLHH3A1Q==
X-Received: by 2002:a17:90b:5605:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39d9bbc9177mr18482649a91.4.1789267409527;
        Sat, 12 Sep 2026 19:43:29 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:1e66:594b:84e9:394f:396d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm12730756a91.9.2026.09.12.19.43.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:43:28 -0700 (PDT)
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
Subject: [PATCH v9 6/9] livepatch: Deprecate stack_order
Date: Sun, 13 Sep 2026 10:42:25 +0800
Message-ID: <20260913024228.72317-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260913024228.72317-1-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
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
Cc: Wardenjohn <zhangwarden@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
---
 .../ABI/removed/sysfs-kernel-livepatch        |  9 +++++++
 .../ABI/testing/sysfs-kernel-livepatch        |  9 -------
 kernel/livepatch/core.c                       | 24 -------------------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
index 87d57ba27326..fb6ff9c3b43e 100644
--- a/Documentation/ABI/removed/sysfs-kernel-livepatch
+++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
@@ -5,3 +5,12 @@ Contact:	live-patching@vger.kernel.org
 Description:
 		An attribute which indicates whether the patch supports
 		atomic-replace.
+
+What:          /sys/kernel/livepatch/<patch>/stack_order
+Date:          Jan 2025
+KernelVersion: 6.14.0
+Description:
+		This attribute specifies the sequence in which live patch modules
+		are applied to the system. If multiple live patches modify the same
+		function, the implementation with the biggest 'stack_order' number
+		is used, unless a transition is currently in progress.
diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index 7ccfe5414ac3..8229348e74a3 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -70,15 +70,6 @@ Description:
 		livepatch that obsoletes this patch's provides id will
 		also be atomically replaced by this patch.
 
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
index a4616a6d9932..905b90b8b525 100644
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

