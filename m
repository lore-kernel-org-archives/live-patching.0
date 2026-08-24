Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF92F39C2
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542079; cv=none; b=RZQGjHEdH9wvTzY5GoGdJlXxgR7PxLAMx5nn22Z54eqJKhLU4YM2KHWX+uDwcpm99wr6m24I8rlQ4bRoM28aY7XRQ/d6xh1siIm25wbaDek+sWPVHtTLKtxzsbwBj4Jo3mN6XMKQP8UI8gWYo01su543zu9yFhaLkHc7h/2LRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542079; c=relaxed/simple;
	bh=6GctvsY3YhdW9SlRymI3H/v5NDABJp1KDD160LSOyso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpzZ52UKT/WgmXQF6joGPl0UrAcMjMIOnkHCsbk9/2dsBWHAN19IeiX60mredevCfK6R/mzJQyuE6zo5QLWP3v7W2BnRsQE4ouqyIPaJlyZ7iZBLhngbmQZ9E39DMSChXPKJOBaX1WavVGxaQwjyfyaEQ4XddFWkZUJA+gblca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyqJeDfg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyqJeDfg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2264874a91.3
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542077; x=1788146877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZA1Q8/A6CNoGcobPXs5TwDWzTq4ToK09E/NAOLQUJg=;
        b=JyqJeDfgDrVZRp0iiXlHN1pQi34pPEtg53f41LUiujrKl3BXs+jckgWjVbyObtHCke
         mVqUa7IVhbwIDZQ28ngOWd8RwljH4gjJfFwpHDhJ4My7Fv69hKaqT/+deEUVOEyayoaL
         6/mT5XsBoZ+mmzwpy/K62WnWJbMkYVRULh4NR0lOpMafpkFx3IL0OBQK4/U18UxPdHP/
         x2AXHQ2wqTUGELrK572tFExmjCgsnF9zcMoSc04xYH6LGEveI83N2ENivhbCorLcRK4K
         JEkIbFhDVsSUrgB4zphkIjsCVrDg0Pjl+qqTARq2GhfU9puojF3JtrD7FLOmT3pwpguc
         p3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542077; x=1788146877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZA1Q8/A6CNoGcobPXs5TwDWzTq4ToK09E/NAOLQUJg=;
        b=Oxv9S2nar7tiPkT7W1v8nV7OMYzPFmsYbcGYHlqJLZ3HoytHezMUPPM24lO9ZppgKL
         eKTQxGvpjfQidKANcgY9FZBUswCtdxjQm+HFzN1shy44Ewpp2wswXVIQrY0Aw721jKUw
         4rTgyutrQso/C1sDibPsUvzf8DmwD6H4m4Ss3y2t+cgOBaCxkSOXi0fYIvtNHAJfO0Xs
         Nw2GUJx1v4eUFO9o1U+EG9lcxLAVzeUfMPKAo6GbKJztm2SbbVkdKLSfVMNRKezN01xA
         gk15Ql28usr8ABK8wU5wcBi2tqkm69iSnC3nPj+xgyOD40fKXyLg9ZszUCq2te3GHbSd
         nfyA==
X-Gm-Message-State: AFuF++k3uaSotL6INhNF3IhHVSR/FTorkWZZrfeFAzLtbknMuXkboy3z
	BXqrNwpgGVWsaFeWHhlrLBkyW8UmBlFfsntnEq/W9MyIC3uvC+UfEYcJ
X-Gm-Gg: AR+sD13QxbjUj5tVweOEXNilEtmKHXHSwgSbhQ9XVV4bEzKZSh61zVHPr1WAxiY8Apq
	qH2Kg+VaaLJunyCBKaXA1aqSQcOsjrv7iE2sIEYWncCrzZrk831V57tPn/kNLH0x4PMq6DhXa3d
	jQBgQJcSA6Lk98X5ZjZfgpZE20WxL/Tzd9AbuE+2W+49rdw/fifL1a8Ep2hpX/ANybwe0UL6tXq
	dvESw4BKP48ClJTK6Ds5bEcLmt2MfyMX8ozP4psLLhj3cGKZI37f3Kkb90yfDa5R3mfeOgQ8e6y
	K7Nk6oxtzMMetzmU4v8jPREK/xQy63YdMGKEEt/sZoWcMV0hvHqgnZYvZK5eyqH2Qxfx1paazLs
	1opAShqRwCTrBQq6pY99aagfEYt+3P/fDxWW9vj2SLFN8Vr5IwOYonlY/POm+4W0CeNsHap7aGA
	B9rAmDidl4vgIvp3ErwWRn+Tct/+c3RP4pLp/V0gJE5JOek4wRbuv8Kz0EptaxbRL6B5Mr2x7Ph
	TBARdVL1YgYxf7FrOx5Oo1xiJKc9ZPYuSjddySqlP+EzJrwBCnxDw==
X-Received: by 2002:a17:90b:4a82:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-395dee5610fmr23527150a91.2.1787542076875;
        Sun, 23 Aug 2026 20:27:56 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.27.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:27:56 -0700 (PDT)
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
Subject: [PATCH v6 4/8] livepatch: Deprecate stack_order
Date: Mon, 24 Aug 2026 11:27:28 +0800
Message-ID: <20260824032732.56686-5-laoar.shao@gmail.com>
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
index 18d11d30016e..135be49708c6 100644
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

