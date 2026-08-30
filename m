Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6281AA8
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068958; cv=none; b=AXjDBnsD9a4cwPO7pK/piREIbEEQxBCkJmFvQ9fZACxJ9PyH6C5601Ne0ylVYk92MhnoId+AdQn7XYvN/gciae9P7qtDFaADtPfCuwjaUVBhFPxkDFU0u15Lq1XOh75IJcEfpcoYVtmPQm7E+FK+6skOnbG4+TjEe1AAb+mZcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068958; c=relaxed/simple;
	bh=w/UKqRbloXxtYB0AxYolU8jH7z554P3oR+PJKXU9us8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaNAwcH4WSASBywYR5JlKR/R6pmlQFFfFpEBo2rW7rORDEvB4nwCfLVo4cMFPSDB7G3J0kTHPd2aeoqSRH/ytCkQxnGExf5fK3dCfW2BzzQxG+MbD/qTkdi9fI3fLYKyDQ7gMpHmg4nnsdaZ/RM3yZsBBnwLCXMkZeVCHxFE0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F10uQjB7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F10uQjB7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2368598a91.0
        for <live-patching@vger.kernel.org>; Sat, 29 Aug 2026 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788068955; x=1788673755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYV9HV7mnsV6N31udgxsZU3Y/1IafY1OtkJi9nfNkxA=;
        b=F10uQjB7PffCtPkwbs9BAxA1QfToFIq+xfVepp2nQgD1TTa9LFqx7v0wXEyAuSQdLf
         9YIssIizHXp4tP4tpoKd+kkxK6501Me//0q9jBCSVJgONh/j6T+0jeATU+LMCrBvEB6r
         ZiMkMrIAf9nokiogk373ZUBk1rf0Yq0gLrncw8SWfBWGEPyhvgo+A9LJAyvXrVt1xVR1
         +OU9L8QxE29xkW7gStUyjMOT3FqwkeJER/68M2gn6ovVjwq4hqlBkyNh9Ghbg0U5J8el
         HGDc/Pxs8HYl0IG3iz9R59wmK59wEjzL9Nbt4Bx8twFpJLyO1PXZXOLmI5qrL8kS7GhK
         6cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788068955; x=1788673755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NYV9HV7mnsV6N31udgxsZU3Y/1IafY1OtkJi9nfNkxA=;
        b=EZj18r+1uOk/MZ3ICedcyK4Eotp3nWRZL+1D2SnWlqn4xWzw6dMmlvNxQhQHsva9Pl
         +gzUwJSWRg+bTsmbcAYA1JL5EkBT3cf2f130OqAt4oSKmRiQrB03TFW8l0YzySN1CXgo
         15zzCOsugxJJEtpvbpsjCRmcqH1zfV23Pn6R5wpfYXUSSJyb8pM7VLTlQICJ40RXowxI
         YjGODYxpZZ+nLCWjv5IdeciD1Il56ytGeybOy31LXoJYfvb2F7KdWaREvn2Sv2H9DsY9
         W19P0381nmWvU+9Rxcndv6hlPMnLJvFR0pCY25idIi9gP8gq6ai7eyEQPUSv68On15bj
         UIzA==
X-Gm-Message-State: AFuF++mvw5w110tLLdN7GHEy0D+ky+8iNXPQhxL+D6f+SbSoWJjLSDcP
	6s9mR+CiHKoejJWDP1W57p6FxQ81x7Sb+X7ASKA3pjOAVCaVwJaj9PZDihjmmlZ9Q30=
X-Gm-Gg: AYBFou1IL/M3tCdsJ4lRqNpGynjTeGJacu94+t2FGPoDbO3p6bt7dqBMtaEjQG7llf5
	mcO5Q84DiLA+n/9uJCt83TyGekwgxo6VL32I48eeIRun4sV6eJywtOWWaCRcGKpGbIvRTWtp7S5
	PXjbwbcPyKbN8Ym4Oce6p7kAC5a6jxL4ZvkQoqhwWkH2hmaglMHmJOZHZOggoXHmHotz9ocrJ1J
	5yUBbAzJtIfOfW89kGr+GuGdozzNl7lBtqhbzXH/6cp6ZNnDR4fp2qE1B04omlOMH0yRiQpQ5eL
	dPg3qzu18vFA/iJWig0oMqcbxzgcwVSOceDuNlp4vfIRplAe2PVbmVvuFuNQunN3hztqDJ2V1Y5
	b2ZcikaADpbGyGczfk37oJ0XMy6aLdMRDteJiPzfigT5BZEUwqCL8WOCT0OfMbFSjLLc9xsDfKH
	NE8k9RqTQqY3VP/Igv6RYsoVRozPsYbivMHJ4grz72Jx9V0RivM2RbkuQ4GNXy3Fta7G7Hk53Dp
	cP7rsQGzOvSXfSZnP7almBBJ2Ww0OxMYc7LthP0oTNmgFyWmF+2Hl0Hb3s=
X-Received: by 2002:a17:90a:110:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-3989be6fad3mr10021185a91.24.1788068955527;
        Sat, 29 Aug 2026 22:49:15 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2510:761:2de1:2bab:6d79:724b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc555b0sm9742569a91.13.2026.08.29.22.49.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:49:14 -0700 (PDT)
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
Subject: [PATCH v4 1/2] livepatch: Fix UAF of unregistered patch kobjects
Date: Sun, 30 Aug 2026 13:48:56 +0800
Message-ID: <20260830054857.64758-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260830054857.64758-1-laoar.shao@gmail.com>
References: <20260830054857.64758-1-laoar.shao@gmail.com>
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
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
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

