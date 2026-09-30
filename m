Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C493655F0
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737455; cv=none; b=Pea9ElgluLlyLiiG4Pl2bXfFps0paE5qSzpYc2Vui0FCllbKtrZjLDIibSdZ121BFjkv6FCer6QPBfS8Jhlz481aYB93+96gDw4SA7VpTGrVRLvR7gUslRhAIYiywkOLnPAIi2tpljnY1u0l8JsezeZW7csf5M1qI02uxfq66jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737455; c=relaxed/simple;
	bh=0rByZVlrnNLUj8rO2dqGjLTks02kkwUIcVklLgZ5J3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU0arobAFocuPP1pNRNdhETJ1jOHC7I1jAZJqNRNWqAEnwb6JwF1AYzDtcBFBm4wzxhNqAjHxvhE17bHasjZnuv0iLCiKk+ThuvJ0Gm7/UJal/dxXzklVSVtzg7O+NbAwxrl13KOKw1580brUdCB81EdkUThAl0GydbZt5HYcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4rXZ22k; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4rXZ22k"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso2187109a91.3
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737453; x=1791342253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCB0MnX9eUC3vFZs6j4uUc04iVnvqznulAMBF7LvJG8=;
        b=B4rXZ22kTgZ0ZRxBLxLBM8xNCAxTULILJaY7qZ5rRFjOA26D63VbRhXRX8n2GjNFQo
         Sel9IQGBh713GPjHw1UdeimK+z7E0/acwxyX8dixUPYs/ca5oRCsRhuKrAJNp0RaSPJL
         lYVtCzLg2pEgFvNk8iro4C0Es1QbBpD850V0edXUzb7CptxxgI4q0eP+tB0iK6dh24zM
         kyizG7g2SSUszuzLvglUded+KInBvsky1attQJHw3yoYIrPANkhEFRg3Wtxg2QulCFPB
         3mZ4ULtwobv897wBvlOXSNsPzlKkqthWERP/1UyDBoE0/Xh3UlPakw3Xf6D0SUSnpOcc
         DmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737453; x=1791342253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCB0MnX9eUC3vFZs6j4uUc04iVnvqznulAMBF7LvJG8=;
        b=ZgS8t2YO6zFZWZ8rZrXjYPXGRbmsdMzS5OqPfb01B80XqA77Ufbal6XDr0bMqvZJ0I
         NyUyOub6qwSF+o3CxqEzceMnyISJRQZMswylbqO3LDCC/8ou1lnElQoQOSfG+v001CID
         oDElEokEbkz3ityaMfA2r/ij2yWGsSj1fAL0CbLUAWHz6nB80Qr2FXmTpVaPlkyIrPSI
         ArUcq6eAu8CAH8NHtTs1gF9uUZdmOLA3botm+5Zso7qbbsKj7b4RDoYa2azlCe4YH+sp
         /j1M8BlMhyXZ8pnn15RJyZwZTF296jGIu+1rl06PEz/N9OuMloUI25HD3cszhYn9TTbM
         vgvQ==
X-Gm-Message-State: AFq9FYJBVCqdF+JbRj7bxuAU81caHtlyprycROXWllVyWqWnESRSwgu1
	NqE2JG7Omgpcz2f6GXzXiGixXxnoOdi5Plm7rlh8M2HB/zA8Vdnr6i2g
X-Gm-Gg: AYBFou12dacC6n278z2k72jQJZfhKSwrGZA2ntFS5JNwfFjIBvSgI9ioOrNMOhtAuRq
	z7NL9yi+37eRvBPJU42TiZuWOzYYpqOhu532wt8G3lsL7h+CUzaXJNUfWxXE3cKlA1Yq0M+2J9K
	VPVXC3buPgUxgcYtFqO6+IJAeJwsHMcPePIMWjrKswKWLlonVHulFcl+sQr+HI4TzkxTKIbZr8J
	df+0bmcd05ZBtnXBAwWCv6iVxYv1Gy+i9gFMy2vmWoqHNE0/AwoYtaD90BZk5wBdbpJ0++yuzJP
	+z1ph1qj2En4QkNKCFeSq5v38c+BbDXkGG7G3WYBdkc51jg67d2BpmHwPioWG6ovmPfQu2f0i95
	+C0OjhIL4Y1z3RR+eHW/bZoeOcdteDHeaWrA8+X/qlO1UpiBMGxTwFsR1JZ0QrICEpASW4rW0Ol
	v+Eu32R/kc31h/eynG7nXgeacrkYko965D6Jn5lJOvsum+B/JImh4wYOvAKo1S8/qU7lc/zvWb7
	35Zj+SVfO4ozLFda/wujbnj7Sum4wRh8RaQtmPQEYyfOIjBoH1hmGWRIzT5ieNMadt71w==
X-Received: by 2002:a17:90a:e7d2:b0:3a4:b50a:1113 with SMTP id 98e67ed59e1d1-3a4d1b0653bmr51559a91.37.1790737453104;
        Tue, 29 Sep 2026 20:04:13 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.04.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:04:12 -0700 (PDT)
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
Subject: [PATCH v10 6/9] livepatch: Deprecate stack_order
Date: Wed, 30 Sep 2026 11:03:20 +0800
Message-ID: <20260930030323.14396-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930030323.14396-1-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
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
index 82f541b16ecc..b00256323317 100644
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

