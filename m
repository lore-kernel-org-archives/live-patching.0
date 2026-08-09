Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF48399365
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267229; cv=none; b=r7TuSNGotQOraywHs0e5eWu7J0Y8Ye9S4Oj2vmuvHHIpPI5BtQeoDxEjSBcI5LnD3MC7kw/PMvRccWN+tazJ+FRndVpFPdGnXjCKhbINus5QP4tFocFJJedrOP27HA5kZpxu6q+PYYqZZoJrMjSi/7cp5kiS46WNJH95JmJqq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267229; c=relaxed/simple;
	bh=p3MBb5h/td64XsVfTHYmMV0sALj821AC5c+hmwdCySg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiGU5GrtjvufoVO5KmRNZPpZN22G1yZ3XszipLBtQQZF4vx+MFixYz4SiT65B5TE6dDWSFmlsUgnmEhgj17XXoT6hmTrl6e0QX+4C9RzR04JEgo0/PZCXH/wk/ZtBzQDHbCrPMc8ZEPS7jEyq7khwphsFyF5sHvygt8l7i9YOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG5ToGOs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG5ToGOs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf452def93so26720125ad.1
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267227; x=1786872027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0849R8gNCMeyfF/FIXV9GbJaUFBBitnPd1hhNQC+Y+8=;
        b=mG5ToGOsqfZOiBgBGmwenySYH+okbWNrODtR1Q/tVj4pnegQTe9N4rP33pJJszT57Z
         lWOHYxgXrM0KwWa/Gnf+yLSAJ3z+SgE4u6oa9ghV1nc9qTt+CBwLLe6Cfo7S+6Mb7Jtz
         yoRHYybAzQXbTzC7b8onBHUs6X3QHLKfUjdGhlHEnudovCNT7EzEuauvrJyHU59ziiFl
         i7RF5tHXgdBfJM3iRwUcPg/81dNYlIrSfiJKOZXlk9U4aicNV/72znA2MCGcmopWs9Kr
         smQpAWonKX3zTlY8cILiIDS8jwsUYojt9parUuuZ3aJ8rlsj6RqACSK3ieAjbx1yBgOz
         UkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267227; x=1786872027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0849R8gNCMeyfF/FIXV9GbJaUFBBitnPd1hhNQC+Y+8=;
        b=dtvfVYqyDLqrhrXY8J49Uy5PG5QtYfSuwBDLal15BrrzdLhxDMS4ausYDlUjdM9gia
         BUpW7AXJRv9LN/9nw1F3ungXaw16MmpRJqNoveSZ0nU9p6emJOX8bQJ6wGTgaMbgtcy8
         /IajaGyq3cXC+NfJ53aWzRbo/3iImAsk5cYKqNVwJObgF58yajQhBqQjCvHOl56zIswv
         YZ1P/qOyyLpgzKqDAFhg0oLNMzq4dFmQzazXnBZSmr541+gYN1zsjAZrfuKsDWhcOaBD
         uAFZoWNyLaC4lTT/5iuceBxb0gTL3Wq7EHvWNRxZ54zUKFRKBr39a0hYRj6D5jyKX5/U
         44+A==
X-Gm-Message-State: AOJu0YycF/h9x49e8WJGMYUP3swHWbzqqbs7WfFMYbmFhfXCOEm4x2c3
	qQ61NkmtzO9I4RrMHsOC4218b9TvAbj3WttlL1+xbci9+dFGhA+gcbge
X-Gm-Gg: AR+sD116P6M2+GneT3AD5G/N25OMyGhbaSny61eIA8k4oj41aHiC/r4BFrVvVTCC50l
	FEmKzk5AtiMex9qaipntptailO7o7LkTK32gdogY2NfrVtsexLmCN1nj623LHEE6tF7dVY6jXRX
	COwvAIgoYhDOYVqWs6X6QY92NB4HZDzBOKSQz/j36iAradB1gyvgnH8OZQ3D0ei6bbC2kJDnNJE
	zyOnoHLzBUK/9/pVdqioNX4NbH+kLQgPXS2ozIIR0Ji+ifSlstPBzirgwrQ7AvYeBL0rgFZB0Ly
	LZP+86sng1+3xGP9d4wGr/DDqs1B4IRPTH3bIKEZib0mOSb0UQe24jSWRnL4egn/fw/wtroPw12
	T4bd/HCpyLmWNSILb6ik7a+zOoO82O1zFzIFE6yeRxb6REBUuS90f30Z+X8/49HytGl7Pqq7sYz
	A1oM5oQyty92p3jrkfMSyrlT+VWQr5lKmeOfizXBRKMOd1pbKKqtLlZ8DOJtASB8EqDb8mQdp4p
	qrT44Ucw1veBRHPeUNVVaEbGeHTZ24HZ/rYuh89yc4dUGFTpUiSTd4tJg==
X-Received: by 2002:a17:90b:33c6:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-392845e20b2mr5049070a91.1.1786267227402;
        Sun, 09 Aug 2026 02:20:27 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:27 -0700 (PDT)
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
Subject: [PATCH v5 5/9] livepatch: Deprecate stack_order
Date: Sun,  9 Aug 2026 17:19:49 +0800
Message-ID: <20260809091954.22930-6-laoar.shao@gmail.com>
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

stack_order is no longer needed for atomic-replace livepatches, as a
single function can only be modified by a unique replace_set.
Since this livepatch sysfs interface is mainly intended for kernel
developers, backward compatibility does not need to be maintained.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Wardenjohn <zhangwarden@gmail.com>
---
 .../ABI/removed/sysfs-kernel-livepatch        | 16 +++++++++++++
 .../ABI/testing/sysfs-kernel-livepatch        |  9 -------
 kernel/livepatch/core.c                       | 24 -------------------
 3 files changed, 16 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch

diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
new file mode 100644
index 000000000000..fb6ff9c3b43e
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
@@ -0,0 +1,16 @@
+What:		/sys/kernel/livepatch/<patch>/replace
+Date:		Jun 2024
+KernelVersion:	6.11.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		An attribute which indicates whether the patch supports
+		atomic-replace.
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
index 2588f676deb1..3564b3e4385f 100644
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
index 922aa00a6329..171e689fdbcb 100644
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

