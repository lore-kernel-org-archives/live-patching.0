Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF02FB084
	for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871103; cv=none; b=dE8qqIXYs7kIotjMDMLjgo9BynUb+U3P5aOL1toHb53dn97uJX9kjpIDbRQCNcXC6ofH9iN56xY7UVgr7jQGEAacUKtOZ3QxW6XjoQCgjjJpfwp0nLAcvD0UlQUv6/AAx7ZQ4TpFbx+EDJY3+d62YwNXLgB64fTXtgTMNE0BUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871103; c=relaxed/simple;
	bh=+K4DcmYyr2oB/qyZ0zkTmb3PYpUq1wxdFdE5dh2SwiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Euof8P4JsGlOY2j7nfHfDE5z85d4vOo2wtedtxEZEMP4SRuSucB6JYKB6yV5J7Bnwdp25y3jfZ9hK1jYhS0xbVPYAA71Js1q2sUFkk5OjEKW2T+mQeq2g87c8W5HMRS+tCykF1NIZ1kVc8+9P6vxuNIFHp+z529iL3RviYAKPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKKPkqES; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKKPkqES"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d049069377so24881655ad.0
        for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786871102; x=1787475902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=feSpm1eQkq5bNCxDvtp4/FpvezlbdmTK2Pd0m5OeCLg=;
        b=SKKPkqES7GRuzDSPXWw8lFTtzAKriTczSPdFB6eOLs03YZzHFxtsdS36tSKV6bcszY
         ASxlNPYtjly+BWWu4o923CuPvhPxt/YC2g3vLaOoTyZYuPS32tp7u1cB8PRCs5PHBJwn
         1bybshkl7Y7+7CutGxIK5XE8iQJGRID0OFvk288VltmJr61mg6A8JnW2MAfm/goyba0v
         UpNJljo1xeTsekGaSfGVXSSxywNh473TBrcjxSnSMmqNlH7HqAIrjzF2CJbrZ3jjURh/
         w9n9CqAaxsD15g3279RidzJ/HSP71pI1by8BcpPfaBPFSF0ZJorqmxfDAoyyQt5pdzj9
         Ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786871102; x=1787475902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=feSpm1eQkq5bNCxDvtp4/FpvezlbdmTK2Pd0m5OeCLg=;
        b=R43KpglXw0yA7xwX/PVletG8jfR7JIGYY/Wwk0USSXoRwfWZzQ/SZfy62D00IX0C5F
         GIyHrJS0wE/w7pFU/VQcvvijmi7KyHbQPpXAXzwCDuF1jI056SsW/+GOs+tFl7/LJJAk
         Cv1XMfaIE8/4w+qArgpb9MY7kjF5J1Si8DGLDypqgl+c/jNXYvAKKjxHUgNbXdCDTq9c
         c7tIkrz/xPS0xsPOsa5vCQpZGZAyX4BerHoIf9yg1kLDZbr7CfnjZ4zmHDj3tZUtQxwM
         k+Nr8QvnwskXy37BUevWrb4wFox71dRKp5yvpsrDMPMVuCI12wO2XhJhi6xX4/YqTxYW
         HXvw==
X-Gm-Message-State: AOJu0YwPgs/PUjlyHIRUv6q07xChTBu6Nm/ZrMR5ZZnCaVLpIN7XRlDD
	z7c/sSpa3SnR3YouPiwcnDvZqjRVu3IUzgNQHr9JjU4mFF+wpgHLJWeH
X-Gm-Gg: AR+sD10NqBRzDWx5D+9I3yRzwijjzixhFZkLirIldJSUSmaTL9UKJegQc8ijgUHwKeN
	vDCQshYBB8XJixQqP8MhQukp2Xd3rgvO1U5WmM5buU53uu2FEASxHnWtwBrRCDCal+3O95OZz67
	18oQkK6IsQfpbGKw/YX3hYUe+hWDu1R9qwNr6cfjOXslM6gpVPeQtW08j174Wf8CniIMa15nwsN
	4BGsAGqSKK5aXmbLx39Nwe/uW3ef5c5MoGG5qyqsnAomlmv1pnPDuVSsnQnm1ElvWTKrDQzJLxp
	Y/Rc73+je+esOBmKlh9clixsPQYUqyLfHOzFo5Lku+/bqTTmTD9OnvGr4xm0E4z2YSTeVjaQnyt
	OoDG8t/7DO7mCb59QSld8mplqRTKaxFHePkLX9EWcUjUln4+QTIVBtlmtezXvQ1G07UeGOq2irH
	hpNeWjwJAJE6yrkl419qyBa3rKf7WJgd97CO5YQSzACErA+8ruhOhk/GpfpUWem6DzHhKt8ivCh
	BEMzg8aM/e5+0oJPqCUS92SUFNxE0galKBIPHVWX/rLjuf0tfKiRY0D
X-Received: by 2002:a17:902:f603:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d3b0c5798cmr202523645ad.9.1786871101610;
        Sun, 16 Aug 2026 02:05:01 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2100:4077:60c3:e9ee:3774:36cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb8869asm24466485ad.60.2026.08.16.02.04.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 02:05:00 -0700 (PDT)
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
Subject: [PATCH v2 2/2] livepatch: Fix UAF of unregistered patch kobjects
Date: Sun, 16 Aug 2026 17:04:42 +0800
Message-ID: <20260816090442.18128-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260816090442.18128-1-laoar.shao@gmail.com>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When klp_enable_patch() fails after klp_init_patch_early() has run,
the error path calls klp_free_patch_start() and klp_free_patch_finish().
The former drops the references of all object and function kobjects via
klp_free_objects(), the latter drops the patch kobject reference and
waits for the patch kobject release only:

    klp_free_patch_finish():
        kobject_put(&patch->kobj);
        wait_for_completion(&patch->finish);

With CONFIG_DEBUG_KOBJECT_RELEASE enabled, kobject_put() does not
release the kobject synchronously but schedules a delayed release with
a random delay of up to 4 seconds (see kobject_release() in
lib/kobject.c). Because klp_free_patch_finish() only waits for the
patch kobject release, it may return while object and function kobject
releases are still pending. The caller can then unload the livepatch
module, which frees the klp_object and klp_func structures. The delayed
kobject release callbacks later access this freed memory in
kobject_cleanup(), resulting in a use-after-free.

This issue can occur in two scenarios:

1. The patch kobject was never added to sysfs (e.g., klp_init_patch()
   failed at kobject_add()). All child kobjects were only initialized
   via kobject_init() but never added to sysfs. They do not hold
   references to the patch kobject, so the patch kobject can be
   released independently, unblocking patch->finish before the child
   releases complete.

2. The patch kobject was added to sysfs, but a subsequent operation
   such as klp_add_nops() or klp_init_object() failed. Some child
   kobjects were initialized but not yet added to sysfs. These
   un-added children do not hold references to the patch kobject
   either, so the same race can occur.

Fix this by tracking all static kobject releases with a per-patch
atomic counter (kobj_pending). klp_free_patch_start() counts the
patch kobject plus all static object and function kobjects.
klp_free_patch_finish() waits until kobj_pending reaches zero,
ensuring all kobject releases have completed before the module is
unloaded.

Dynamic objects and nop functions are excluded from the count because
they are freed by their release callbacks (which call kfree) and only
exist when the patch kobject was successfully added to sysfs. For
patches fully added to sysfs, the kobject parent-child reference chain
ensures the patch kobject is released last, so kobj_pending naturally
reaches zero when the patch kobject is released. For patches with
partial initialization failures, kobj_pending ensures all un-added
kobject releases are tracked regardless of release order.

The release callbacks use early return after kfree() for dynamic/nop
kobjects to avoid dereferencing freed memory. Static kobjects are not
freed by their release callbacks, so accessing obj->patch or
func->obj->patch is safe. Furthermore, static functions always belong
to static objects, so func->obj is never freed by a release callback.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h |  6 +++++
 kernel/livepatch/core.c   | 50 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..6375150c2369 100644
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
@@ -127,6 +131,7 @@ struct klp_state {
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
+ * @kobj_pending: number of kobjects awaiting release
  * @enabled:	the patch is enabled (but operation may be incomplete)
  * @forced:	was involved in a forced transition
  * @free_work:	patch cleanup from workqueue-context
@@ -140,6 +145,7 @@ struct klp_patch {
 	bool replace;
 
 	/* internal */
+	atomic_t kobj_pending;
 	struct list_head list;
 	struct kobject kobj;
 	struct list_head obj_list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a240d1144e89..b5e8242b0877 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -635,7 +635,8 @@ static void klp_kobj_release_patch(struct kobject *kobj)
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	complete(&patch->finish);
+	if (atomic_dec_and_test(&patch->kobj_pending))
+		complete(&patch->finish);
 }
 
 static const struct kobj_type klp_ktype_patch = {
@@ -646,12 +647,19 @@ static const struct kobj_type klp_ktype_patch = {
 
 static void klp_kobj_release_object(struct kobject *kobj)
 {
+	struct klp_patch *patch;
 	struct klp_object *obj;
 
 	obj = container_of(kobj, struct klp_object, kobj);
 
-	if (obj->dynamic)
+	if (obj->dynamic) {
 		klp_free_object_dynamic(obj);
+		return;
+	}
+
+	patch = obj->patch;
+	if (atomic_dec_and_test(&patch->kobj_pending))
+		complete(&patch->finish);
 }
 
 static const struct kobj_type klp_ktype_object = {
@@ -662,12 +670,19 @@ static const struct kobj_type klp_ktype_object = {
 
 static void klp_kobj_release_func(struct kobject *kobj)
 {
+	struct klp_patch *patch;
 	struct klp_func *func;
 
 	func = container_of(kobj, struct klp_func, kobj);
 
-	if (func->nop)
+	if (func->nop) {
 		klp_free_func_nop(func);
+		return;
+	}
+
+	patch = func->obj->patch;
+	if (atomic_dec_and_test(&patch->kobj_pending))
+		complete(&patch->finish);
 }
 
 static const struct kobj_type klp_ktype_func = {
@@ -737,9 +752,35 @@ static void klp_free_objects_dynamic(struct klp_patch *patch)
  */
 static void klp_free_patch_start(struct klp_patch *patch)
 {
+	struct klp_object *obj;
+	struct klp_func *func;
+
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
 
+	/*
+	 * Count all static kobjects (patch + objects + funcs) so that
+	 * klp_free_patch_finish() can wait for all their releases.
+	 *
+	 * Dynamic objects and nop funcs are excluded because they are
+	 * freed by their release callbacks and only exist when the patch
+	 * kobject was successfully added to sysfs.  Static kobjects may
+	 * or may not have been added to sysfs (e.g. if klp_init_object()
+	 * failed after kobject_add() for the patch succeeded).  Counting
+	 * all of them ensures delayed releases are tracked regardless.
+	 */
+	atomic_set(&patch->kobj_pending, 1);
+	klp_for_each_object(patch, obj) {
+		if (obj->dynamic)
+			continue;
+		atomic_inc(&patch->kobj_pending);
+		klp_for_each_func(obj, func) {
+			if (func->nop)
+				continue;
+			atomic_inc(&patch->kobj_pending);
+		}
+	}
+
 	klp_free_objects(patch);
 }
 
@@ -944,6 +985,7 @@ static void klp_init_func_early(struct klp_object *obj,
 {
 	kobject_init(&func->kobj, &klp_ktype_func);
 	list_add_tail(&func->node, &obj->func_list);
+	func->obj = obj;
 }
 
 static void klp_init_object_early(struct klp_patch *patch,
@@ -952,6 +994,7 @@ static void klp_init_object_early(struct klp_patch *patch,
 	INIT_LIST_HEAD(&obj->func_list);
 	kobject_init(&obj->kobj, &klp_ktype_object);
 	list_add_tail(&obj->node, &patch->obj_list);
+	obj->patch = patch;
 }
 
 static void klp_init_patch_early(struct klp_patch *patch)
@@ -962,6 +1005,7 @@ static void klp_init_patch_early(struct klp_patch *patch)
 	INIT_LIST_HEAD(&patch->list);
 	INIT_LIST_HEAD(&patch->obj_list);
 	kobject_init(&patch->kobj, &klp_ktype_patch);
+	atomic_set(&patch->kobj_pending, 0);
 	patch->enabled = false;
 	patch->forced = false;
 	INIT_WORK(&patch->free_work, klp_free_patch_work_fn);
-- 
2.52.0

