Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276223655C7
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282236; cv=none; b=bj/TCEGka8XSJJ32tXFrYM/DBIvvT9le89826cY392xYpPaRdR8KaWVItNfjlRO1ESNXT2oZAKc+l1OHKhYucw4H+dbOhDb+B/EypjlnouDov1xytJM1WQ8iplEgR+P5No3rNkonKkWuvbXVh48+unk4yY+r6fZUGf7yaU5Fpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282236; c=relaxed/simple;
	bh=SWSa4TyE/Qkc1uLKTirYXufhiQ/MuIxpYkHKy0/Igpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5tvgEGDmb+HCLXWSbhpmr5fo/oNW28uK0wOjsumJCdCxLaNGtcPvSN9hIANPhp7qeqWQ1xr/kWSheuGfkKIlcpZnIJ4DV9HgnJx5n4/y1mesDZNPrYzSuz8epuVuRj0M+sj+z4MzOFHTkAkxoKoxB4bAMhIlKfkkubSriZ2Hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiTiNwmm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiTiNwmm"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e7391839cso570431a12.0
        for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282230; x=1787887030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RjRNp2SsxDDp1vuD5snaAnKL6aoh9Ju4iFTytYYNYZw=;
        b=WiTiNwmmHiZFyc8jLeuz+XSvjGxpLmv0CgGMKpEfEFLMTZ9MWfPVtnQHRzRk222Rlj
         GDr3pXbfmh4h2yTCG2rg7z+NhWF3LieYfSkCGlr8d/lw0bxXJwqJEhtVZWo5hPBVNIBS
         7faYUD21HArdsMt8fo6XqrEy9lE+g7jhglfT7oFYiRHB0lhdU6tV36155y9SGbmlpeza
         ARI/AZzMLG2xgVzGbXyUwWqWKMytB6O0Kada1aartVfGviQl5Ev5/umHJNYBqITrgskb
         ySGcQap5umjqrP+yDULFlApQjZcWRJft2/3rv71sB6Gtg9vt3S/oQj+eaS/GaUOr8EtF
         nA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282230; x=1787887030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RjRNp2SsxDDp1vuD5snaAnKL6aoh9Ju4iFTytYYNYZw=;
        b=LBjFzzK4qs7PjKGgRGJlvBf+XJTE4H1hUG1/4PMUg65kpXiiNDEnDmigplJP6lZi8Y
         SdTGWdZ9QPY4R/YHE6sXM0ygomy0xMnJSx2jK5vl5bwFlYvpb13A1m3KJ8mMxli089qk
         LOvwpM4b/BLBckQx8keMyhC56aoW9S9IR3mV2A580Gcqb0zTtlpdJrTtvTRC8Bdslgqv
         bWKx27zXDdS8WNhSXqYbdu7pvJmzUvONJOIRgi00rVGREJaQmcf6S67guC9KZGXuDAQO
         JB4sDjUWd5S2nZiXJmk7kIKKV7g2/Rt7WV3g59aekcY+YzamVATVFuC0Q+tc6k2vIIvx
         7FOg==
X-Gm-Message-State: AOJu0Ywy8Zn/c/d0KF4u0ov7U2As23khjxnTt4fo5JHlpYzKWwWbY89L
	E3dEcPYV6Rvx7ADlZAOAa2eb7ETrDVIzXLLE0z77P1hAnGb7ORF3F+d7xFGyQMXJ
X-Gm-Gg: AR+sD11q4A/uOakDYMLmEgJzBv9voO4fspaml7K3MWvXUlp6N/kZNe/ZUggH38R3n6B
	lNHaHPZ/WABEgECtvNAwypajZ92NVrfcubKoYHGNOuNnNXDEKyKNIdDtIeuyC+89iQg6Bvk+OD8
	Ne7JDTOZ8cSRTp/IAyXWizUyGvyfvF02HODLh++AKRHVY8j31bJUlhiRrTQUpPNJN2X4UCLOsfx
	YOTH3m55lkVWyyoFIGeq3TIDr/qfLoNfrLRAmXysNJHHqytyHUcxCX3qaLmwo5l9xZG5sQSKuw1
	ISsB+SfGTLlTIaDerQpKvzw7J63oc8vn2WXNfnyQPG4FUJh7TIrFOpbV3/HZI816qc1nEow/uBL
	65w22TQlu2yNu3L4+5I2ztoKMlm2CP2x9INFvKzbGM8ic/8IZzulBLv/sjkTx6bOFq/xoUHZ8L1
	cgVORsYB+c83cvnb4dYIVapoGpjf+yqYcT3hgWKN1j2NK8mpHOWghIxE8AMMJdrQ1uvy+XbXo52
	UtcDkztEzdX8fOCQBy7WT2rrMKyntQTa+emVjB3KJYwuVvz+j/0F0z0w31SWf+nbZ5w
X-Received: by 2002:a05:6a21:1786:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3cd2ffc3d9emr6975141637.9.1787282229890;
        Thu, 20 Aug 2026 20:17:09 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:1d00:6f7:10c9:b208:aa96:517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15543ec0fsm2346460a12.9.2026.08.20.20.17.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 20:17:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/2] livepatch: Fix UAF of unregistered patch kobjects
Date: Fri, 21 Aug 2026 11:16:47 +0800
Message-ID: <20260821031648.48195-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821031648.48195-1-laoar.shao@gmail.com>
References: <20260821031648.48195-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kobjects of a livepatch are released via kobject_put().  When
CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() does not release
the kobject synchronously but schedules a delayed release with a random
delay of up to 4 seconds (see kobject_release() in lib/kobject.c).

klp_free_patch_finish() only waits for the release of the patch kobject:

  klp_free_patch_finish():
    kobject_put(&patch->kobj);
    wait_for_completion(&patch->finish);

patch->finish is completed by the patch kobject's release callback.  If
the patch kobject was never added to sysfs, or if some child kobjects
were initialized but never added to sysfs (e.g. when klp_enable_patch()
fails after klp_init_patch_early()), those un-added children do not hold
a reference on the patch kobject.  kobject_add() is what takes the parent
reference, so the patch kobject can be released first, completing
patch->finish while the child releases are still pending.

The caller then unloads the livepatch module, which destroys the static
klp_object and klp_func structures.  The delayed child release callbacks
later access this freed memory, causing a use-after-free.

Fix it by making every child kobject hold an explicit reference on its
parent from the moment the object is initialized: klp_init_object_early()
takes a reference on the patch kobject and klp_init_func_early() takes a
reference on the object kobject.  Unlike the reference taken by
kobject_add(), these references also exist for objects that are never
added to sysfs, and the release callbacks drop them unconditionally.
This guarantees the patch kobject is released only after all child
kobjects have been released, so patch->finish cannot be completed before
the static structures are safe to free.

Because kobj->parent is set only by kobject_add(), add explicit
back-pointers, obj->patch and func->obj, so the release callbacks can
find the parent.  Dynamic objects and nop functions are freed by their
release callbacks; save the parent pointer before freeing and drop the
parent reference afterwards.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260809094046.50ED31F000E9@smtp.kernel.org/
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h |  4 ++++
 kernel/livepatch/core.c   | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..5f74f79c22b4 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -33,6 +33,7 @@
  * @kobj:	kobject for sysfs resources
  * @node:	list node for klp_object func_list
  * @stack_node:	list node for klp_ops func_stack list
+ * @obj:	back pointer to the owning object
  * @old_size:	size of the old function
  * @new_size:	size of the new function
  * @nop:        temporary patch to use the original code again; dyn. allocated
@@ -72,6 +73,7 @@ struct klp_func {
 	struct kobject kobj;
 	struct list_head node;
 	struct list_head stack_node;
+	struct klp_object *obj;
 	unsigned long old_size, new_size;
 	bool nop;
 	bool patched;
@@ -86,6 +88,7 @@ struct klp_func {
  * @kobj:	kobject for sysfs resources
  * @func_list:	dynamic list of the function entries
  * @node:	list node for klp_patch obj_list
+ * @patch:	back pointer to the owning patch
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
  * @dynamic:    temporary object for nop functions; dynamically allocated
@@ -101,6 +104,7 @@ struct klp_object {
 	struct kobject kobj;
 	struct list_head func_list;
 	struct list_head node;
+	struct klp_patch *patch;
 	struct module *mod;
 	bool dynamic;
 	bool patched;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a240d1144e89..517fe427ff92 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -646,12 +646,15 @@ static const struct kobj_type klp_ktype_patch = {
 
 static void klp_kobj_release_object(struct kobject *kobj)
 {
+	struct klp_patch *patch;
 	struct klp_object *obj;
 
 	obj = container_of(kobj, struct klp_object, kobj);
+	patch = obj->patch;
 
 	if (obj->dynamic)
 		klp_free_object_dynamic(obj);
+	kobject_put(&patch->kobj);
 }
 
 static const struct kobj_type klp_ktype_object = {
@@ -662,12 +665,15 @@ static const struct kobj_type klp_ktype_object = {
 
 static void klp_kobj_release_func(struct kobject *kobj)
 {
+	struct klp_object *obj;
 	struct klp_func *func;
 
 	func = container_of(kobj, struct klp_func, kobj);
+	obj = func->obj;
 
 	if (func->nop)
 		klp_free_func_nop(func);
+	kobject_put(&obj->kobj);
 }
 
 static const struct kobj_type klp_ktype_func = {
@@ -943,7 +949,9 @@ static void klp_init_func_early(struct klp_object *obj,
 				struct klp_func *func)
 {
 	kobject_init(&func->kobj, &klp_ktype_func);
+	kobject_get(&obj->kobj);
 	list_add_tail(&func->node, &obj->func_list);
+	func->obj = obj;
 }
 
 static void klp_init_object_early(struct klp_patch *patch,
@@ -951,7 +959,9 @@ static void klp_init_object_early(struct klp_patch *patch,
 {
 	INIT_LIST_HEAD(&obj->func_list);
 	kobject_init(&obj->kobj, &klp_ktype_object);
+	kobject_get(&patch->kobj);
 	list_add_tail(&obj->node, &patch->obj_list);
+	obj->patch = patch;
 }
 
 static void klp_init_patch_early(struct klp_patch *patch)
-- 
2.52.0

