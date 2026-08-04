Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7E4195C8
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826243; cv=none; b=b8mG6zsSST4YyvPxXcRNdca2POlEU1aHhCFiIg4HDHw1p+6V5wFSqROvhB65EecdGyPY/Nl7aJXPnqd2/lBxX5oI29QaKlnMIsidiYcBXWLif3/fvp6mMDNxij0f0Ur6PchyPz0kOlLmdAVRHoAjlL8VpeC6/p/tmV9qDBLq+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826243; c=relaxed/simple;
	bh=97XIMo2753e+XiFYHxGQu41owQXLhCLhnluYADtWk4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyerLS0La7xc3awzdNUwP98ht+Be2M1hOU+fpRSQ/V+cMf4zfu9bMy0xnz2MBxJmQe3EAz6q6sctQxnH+CNX9ltj16Iw0X6K3v3d0WbX3N1Tuf0QRPWPCMAS6G3gJg4GDssdFglPWTt/+VMiS5Pu0/xCaCCB1n0TyusRELMYNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvpiR4Mq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvpiR4Mq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cea3004256so46988155ad.0
        for <live-patching@vger.kernel.org>; Mon, 03 Aug 2026 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785826241; x=1786431041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBCI9g+/CFDz9a5VncSRJByGBWdEcRayBZKH1Uv0e4Q=;
        b=bvpiR4MqV31QXivx6loo+MGw9o9B3a6vzIH9PxcNepz2QAk3VcuP633B6gjLyNtSg8
         KCMkw/imdM2QzzW86g5QVU7BvYZJ5zHcnqAkwJOd5CldbsY4z6WRbge015rHGixP8RR2
         Uh90LmfHYpr+ByINJDGGPzkWuiALLmlyvgYvm4A8zIlnazVcjs3AdkJGEVkvolXnXzYs
         N4In/5ULertN7DFgjofLSY012DfPyGtUKDkQJ1na+Sh2dprGcVMidHRM6p2WNNuO7gcI
         +JMaWSNq80CnzLpzaM01OHCYRX0fVjEGAiIQEsI9n3TXlGzAnNmDWPx/cY73w7Tnss0S
         grzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826241; x=1786431041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBCI9g+/CFDz9a5VncSRJByGBWdEcRayBZKH1Uv0e4Q=;
        b=gpmmligk4978sLm2A4e5UBqZsAQELulnB6UzFbiygqgg87InULXr+XUkxMxsQl9tG0
         KJ1/RG0omdV42CjvAEz1YTdrtg+v1ytJbP8td9V5k0Ap/DiRJzXB3DOBLoh3hidTTEqr
         gHigCb8+mGLG1xpQbLN9qWmvL5RhBb2BB8mLheUy0FEWgzWvhNFc7hZJO0L0S4BgHRlz
         8z1cBMDnoYAg56hVGiWDfL1E1v+2gxpxeV42yD/it9doHTyd1rBLpoo65CrYgseZyjTg
         b/gbx03BmvDkSYYQL317I5pKX32dMXH7J4vtxetA07HMzs4IQXITID2f0YMkG8rIMMuY
         lBpA==
X-Gm-Message-State: AOJu0YyGh0IyYM5CWt3iQ0L+X0P0ugtm/z61dUrMyxlHZtQOY6vfFQy8
	8/PRE2YjZm43SFbFCj7xfFmnI7mX5/N4XA4RKBh/vWlmmPByLyyVhlkF6nU5R1ElPpE=
X-Gm-Gg: AR+sD13smPUf20gBscXVbG/+7D+D8Krqg4C1f9x8xZcs0u1LKIwHmu7PmfXoK2TuSOQ
	bKKOGthwKf13yhzqRg3jVcXd+wNSu4B2ry9F8HBK5Vs3d2qfFvaC+Lu0HrSBkHkhFvfnf8b7FSn
	6WnjBWAO1cY2W18wBYN9q57Hl2QDAoOf8WS90kCEEB+AOolT9Ndlbm0d49zEGi0e0Z9ojn54s4Q
	CZyoIKB6P2SOOA+dcWLucUfc+qyLFQVNfQLur0NWNd6ZNql8tdi0BOCeD9Xt1tS+09vv+guPH3B
	+RQnTC+wY8T0gpnk4kGVPc/rC0vITApfgNOr6h8xiG9eAP7zM7OJBmy2xucdTL5GE3VudSZH5Ab
	DkkRfiSNZ4COxJpOuhBNclLwWk5w6tCax4ezxOrKuRCEyf/hdK2y7KPJLROIrCZCsMcD51DSQNM
	CYt3VEc7cfp9ZmblgmX8tEjPazMvBGgpfRTaBfWS+OuDNB7DsZr6Kvmzba/opOLPw5h03BzThov
	T2qpywe4lMqZqxtp8bDsnd9ZZzpoU7f3s0=
X-Received: by 2002:a17:902:f602:b0:2cf:9cf2:3533 with SMTP id d9443c01a7336-2d0522510a0mr126941175ad.18.1785826241381;
        Mon, 03 Aug 2026 23:50:41 -0700 (PDT)
Received: from yafangs-Air ([101.90.159.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa01af84sm1066085ad.36.2026.08.03.23.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 23:50:41 -0700 (PDT)
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
Subject: [RFC PATCH v4 4/4] livepatch: Deprecate stack_order
Date: Tue,  4 Aug 2026 14:50:10 +0800
Message-ID: <20260804065010.44922-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804065010.44922-1-laoar.shao@gmail.com>
References: <20260804065010.44922-1-laoar.shao@gmail.com>
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
index bd37ed99814e..5cadced61d2d 100644
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

