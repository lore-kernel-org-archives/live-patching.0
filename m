Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C700348C7D
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129082; cv=none; b=pqDb2y0UrxJBtZcYXgOvHuXlkdGQT2I3oEVxHSBChOyrHtDyDMoxiNMjSJVOYbnOmlnHLe/0BSxWrOGHHsUTFeJFkxt8ffaTHvleK3Lv0p2Us/yAnLfSWQr8qX/gj+aguZgJ3/OjTbwJVedUyLA43lRuIqKK/jQH6cb1OmP2D8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129082; c=relaxed/simple;
	bh=voQk96wKfjEQzK6ffvfGxfHHprbrWZR2CjkaCZRAIqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irGyppYVsOIJp+BxABflCdlQPE7wF++qSme22tzriNunZhR9inRAquumBZfaYa+t52xxErTEfuhg+M9t3cUKvu906DDRkjq4K89oGt9/0gFDgu9zSAT69e9dV7GwWPBNT7HdqSNHSA78XNiLUGsp+YT95ymPGhM5ZkjjSUmXlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5MwDxfm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5MwDxfm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db80fcdf8bso35510015ad.2
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2026 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129080; x=1792733880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGixU0FoqHB3DXAMrtXSEoNzgdLmkIaJMSKNAw/x9yo=;
        b=E5MwDxfmgSQMfhCIExc8pUJnqiqjeY5UaNw4c13KcSBCtlTNMpHI3d5Bf6U1Zkj6R6
         Z5nQhFchJ1VzuJdNOKlxMgeXzanr9QYCEelGz16k32ZXgJIJJl86xH3bxoETW/CUPG16
         B0JrVjihXjTbn8Er5oO/LZsSjONjRJYOd9h8cTth5PYs0s8CAdsUsKFceThvPE8Tmudt
         wGqQA6NbzmfPjIPEoBBHJrq/cUKiyC8Pv8aHe40D/4BxJCFF8LD1Dh5aK3E6f1YumJoj
         mRX9B7a5NnpoH7fIGvbh5LRbA1AiBwtLed5WX1JdsPbq92PizvtjThUGK/JQQwOorBxX
         Bjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129080; x=1792733880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGixU0FoqHB3DXAMrtXSEoNzgdLmkIaJMSKNAw/x9yo=;
        b=wKhXAAnQoTof7K/xjPIcrWVgTnUmPmmY7Y2bCAPD/C6Dtcbc3idRseSvUOWBSi2FnV
         D5k3GK/MfabUcbRj+Z2QyfvUQRzDpSHglzxNex6wOr2FdmIe00/Ea+QE3N/3Qkfdg9w/
         E+g0bgj8sEsVLzOIqgH1oc04Q2kwunqezFEAf1viUF5W/Srh31kohYQlKt5nD6HsOgDt
         jn11GQRz0w3r3+n9n3wvPKkLJbaQFBwld2jR+i98Dzf2ZMVAs+rdRUPCiD1/JYFaj2Ga
         Z74Y0kFlfwI2kRrCymp5hbKTZ4i4tnv+nwhknZEWPIb/6tTwj7IYzCMWdeP0R1S1kOPl
         w5bQ==
X-Gm-Message-State: AFq9FYKQekky2i8Cg+kyOdP/ZeMTXNnx+G66Uni62N/QUoMbDLwI2+ae
	yUGbmQqDFLhwnje+ZrmUZ5rMIpJk7+I7CrGU8BdAeM1lBNrXAoo5OUHk
X-Gm-Gg: AYBFou1AAfIoQHzZSKhhCc82xYLhQ9q24XegOP4RKWawOZ8bCKR+0RW7bdwdGII/ezc
	7TDSItUW5TncR/oFZmorhBgkZ7qvOq7KH1TgQq9tzNJUKmKA0FdLloB41ccVsjz/Y8+R2Lk4Hac
	d7+YKAiJaZqWf3I1e+hmKp+JmrykIYFS79az1pVLjOyfYTAS9DNQKdRq41j+d5UvWmOUHYvEMEf
	k30eTMjUP3UGxXWZURvhx8fdkvXfW/fcT2UPdkdWLm3Zn4PTkOXk0oSAUIJz2HOuMTZmHOPXWdZ
	C+F6Wqyxc386gFtke1/whc9e5ptLj5+41nKAiGFWE0N8cINgi7mdl8ILf4DiqrvL5ZrCQ1zonF/
	/pLlikpIoE8COkq7yPad0GV9fI2J2HUBkMt0a84qmn9gJRHZAeN28Ni1WVo7SP6IGfipZ0SHxFd
	LoJQ4lSSR47tlkEU6E9xlitUBH3UdL8V1L8JyOBH464leT7KPSYEoyPb/1ZxZZwm/qu4MBSCc00
	iKbWQzgnhGUU8YYmi2JB1poz4HTC90iaxFuWKcYLYwI5lLyyQh0/ZdPHSAse9zCfSTa
X-Received: by 2002:a17:902:ce07:b0:2dd:ad73:5b6c with SMTP id d9443c01a7336-2e8429ad1d4mr186253505ad.28.1792129080298;
        Thu, 15 Oct 2026 22:38:00 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:5700:24f:f979:e84b:46de:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm4724115ad.17.2026.10.15.22.37.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 22:37:59 -0700 (PDT)
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
Subject: [PATCH v12 6/9] livepatch: Deprecate stack_order
Date: Fri, 16 Oct 2026 13:37:05 +0800
Message-ID: <20261016053708.47089-7-laoar.shao@gmail.com>
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

