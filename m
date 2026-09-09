Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAF329E4B
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921851; cv=none; b=ASGED2WtbW0tEcxQ8NMrLHtS9h15njvNiRXc7m9gcHA3063Wd6nsbFJ1GqWOqgYXu47DTy98jtb/ttU3rEOS1lbY9LoKsGL/AYoQZkm/GP6wpbwbxFJZv89w6olbkERM+Q1T0qpXQ9DXymnNoRX4Cqy/1hgMYwQ4j+M+QNAsoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921851; c=relaxed/simple;
	bh=RMa+DDRFt/yQjJVVIrQ5u2fz2BnMfQXT56MrqfNVdY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpZzza8zFLvGu1HU6flMynppJtY9mFAQGUtHDgUDTLE9AYdDjmz27poTZyCag3gxoJiwn++sPxHERdnrxRGXsLHU31wKKBRWhB/p7vRmrpdw0kF16RTMj3xaLgt6/a/kJN7kzB4eSOxGLAEMvd+ptCnzS9Tcd/WvR7R8ybI+Pu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx8cj2OU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx8cj2OU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso1298498a91.3
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921849; x=1789526649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZgejVXH84zDc5+k1DS+opd8Pl3u7lMCY7qlM/d6M7k=;
        b=Jx8cj2OUJloxtRCDvho0vM15lQjvNaKbYORQiiZvpHHg6SKbob+b3xlcFHR7jnDWT6
         5jgIYq7P7l6P9+QnlD3chbQkrCvnKlJc3dATiYISpTzzS2jH+3raLV6FgBdJgdsDDDLZ
         cdKoHeArq2Y22FpfrQPQptr6MHvizUHi5SG6T3RAt9SIkfKa26cAdHxMK/6c0PKBENSK
         dvvzcgaG+19oVQGyzqRtLm6N2LbD1jcQtYuWupW06vkKHUCkXIPeSdIbodj5fdRkRIpX
         IWPlx/+ikZ88R9ow7/2pdnjlpNtPKc5NloCLoPJFqbCIlmXmciQCjVYCFhFGZcJiAA9e
         QAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921849; x=1789526649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZgejVXH84zDc5+k1DS+opd8Pl3u7lMCY7qlM/d6M7k=;
        b=br/aygMl64NyHhwG8J1vBc1k+OBmkM2g3LqqFabrGTZsVg50ugeeo7Q2RqBAQuwhWf
         qshZkWHBWOvYrkqd9fpL6L4yife90EH/nWtbrwNzJ9UiP9KeEz9/7C0fXk0jiq+GdHac
         U/dJglzbgvI9mWv4UP0IWWKBUAVpAiBjLCNhL3M9owltIuQSb2g1h1vS5iCPCqlY5cWb
         gB7cBYLjVUBilOwv2DUzj5oowHciAyrBvJTc8WYeyi24j4oxfWmbGAUxU1B8pQBnetjO
         sGCsVa5OaBbEAR32qVKmfsmp9Etc8JvGeg4XjOFxCXwXNjik5F/1Jxg/YQQsruJWCoZo
         Dnsw==
X-Gm-Message-State: AFuF++lFXRh+fYHK5qAzePLeR0PnpqaKQtrQ1PUEzpUn0tGfhDo7+z8w
	qWLq15+MLjwu4GU7l3+Pzll7gX4ANDjfCKRRhr12+XZzas7d+5UaQEds
X-Gm-Gg: AYBFou1LLkFzWuOHEmd6P3aQNbiSvL9MUIwds94Oz8elQml0e9qjetzjQeecI2wXbed
	b2XI5+6i9Zkd5yL8hKqG9LeKO9+bMg+Dh35+zGRxGaZUGzmrNI9AW1lFOalkebmfYLKM1OWwZoW
	kR1vOiBbi/E7htScOrUq/GrvT1iQmSz2vsAsOyhEqgpW1zVKY71MKCNNU1CH4D/HSZk1L2JbB9U
	uLBs7ixSaaPIElWjsxsSwduCPxciis0lMRTqMWQDugndr6kW1y21P1VP8U3qw/7vUvUrM4JAJT/
	+egRvi7fEM03br2/DO5yrodvKcTCZsBaHK3R4kj6TSzadVHquTx4RX7T0wu+Y7tKTQVGbWysWsD
	f0HnJ28w8ZJE9aSVsb1foBzM+PkeVyROJ5r3QKzHqovnB3KanZ3vysBVPpaYSOf2OZiasURHuHu
	FfZfS6nzlZBJFPAiTnX/dwD89H4Sf7XEe8+/4z+mMPMVmZ3gArPoROOxlpGCzqGcpcGkLAATpBU
	rJvAVEkJJyUX/uxb4HMPieFfKX3EVmeDk+UceGUPEDNo0VeVaSnIoXr7b6PFMadqrd7mQ==
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39b261d0d8emr50117604a91.15.1788921849105;
        Tue, 08 Sep 2026 19:44:09 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.44.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:44:08 -0700 (PDT)
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
Subject: [PATCH v8 6/9] livepatch: Deprecate stack_order
Date: Wed,  9 Sep 2026 10:43:21 +0800
Message-ID: <20260909024324.16002-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909024324.16002-1-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
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

