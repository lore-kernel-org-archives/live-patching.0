Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CF33B96B
	for <live-patching@vger.kernel.org>; Thu, 13 Aug 2026 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590272; cv=none; b=RmSApCCrOtnaJdu7D2i8xVuEC1c5BZvZtb87sXZaPgAFjI5xaYZEE3nqtgULdaPlSKgqZY7Gv07M4S5ocg6uYnQwcPcO4T8/Ktafbiw3KoL/iUSwVrOMxWOhn5ltrp4AiBasTwceQquwwubK1ysrl/7fFOeuj74AJnjcCrOWQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590272; c=relaxed/simple;
	bh=SqIOwa83isXOhrJCRzg7OGNpe3vEsLpfPHtcH/DCkws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkDmgyumVH302qipcr44gjqCqkWSnNe0cHmGmW9yDlcrOes+LMIMXO8b66TZgX6L1DfnvOGfZdiV83eucN7mqprj47SqLrzCThuCCqAg1Fv/Y+QIsmnWvQ+z1z2RTlFE7uM5SKO0sEEhVLBXWPHNIhj6rbt8/ljNFBg0PAXDpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5dHaoQ6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5dHaoQ6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc61541f8cso7166435ad.0
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786590270; x=1787195070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fyPLMz4nppQHDLTt+xuikWcIm7X/fUAp7WzPw2Ka+cs=;
        b=n5dHaoQ66Wu1VVHZ35iHsFXkaTr9Dk/MoqWD0oQ4MzpkZVQ00pm5bLAs6m/H7DmJxc
         sZ/3HWR28XhAY2z9ieiVtU2abesynGgFDJofW5wffP0luNYdFZe/NPwkex9ZND9d/Ix6
         zFpbfgU44qGJRn10YA1GJ4W+uSGIpJk8Gy31WtMWJx560BvLyiJXvH6Fmrfl/JH7uPyw
         Tzd+sHTxOL/vGz4VwyX1oqLjsRGAhpoaZqlInFkbnuzltesWPOAiREXCGmLny2lkYRB3
         5Sbnm65sIOmM8qnT3HfJBF/LW4UfTa4bux2ZdTMxuQYPO/gwetntDrRQmPQnCP0S/rV6
         WOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786590270; x=1787195070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fyPLMz4nppQHDLTt+xuikWcIm7X/fUAp7WzPw2Ka+cs=;
        b=XXNYzdDWwoLSLOIV/J67VSjzbMdMG3fsd9jqhsn4KIOV8tMtLNfRMhXZlm8iosf9IC
         JWjP/sGzO3ldqPq2to6GnfAjok6oYyng90WrHxVBv8cAsXuCqaK+v5i1GcBTQvkNxRdR
         ZxV8ZbVfpV2X52IiKMiH3VN8IHlUPOfmY2EDWiCOFLx56y2ruFtFMv6NNgB75oDU2wke
         kc6gs/761zCdvyZbA5SUTWDgoFjT+1Qbp6N0N430MZRbTxxwkXpYti0JNAeEV8/wuCq8
         yyk8gwy2qXDgCc+KkLZ/ixrc8Rd6eRyodSSCOM0dK6Y38WVUjrxMzc1xs2eWdKpooRT9
         FHHQ==
X-Gm-Message-State: AOJu0YysHTzSoR6t6K91IJr3A0EpwzPTnTnEP1Tdb5zljccV8OtvU8cC
	agabxkzS4Zg8v0Tga0YfHjQA4hzD81r2dETXLDt29jB7i2aFP9R79QMr
X-Gm-Gg: AR+sD13X4X54jfXX5m+m8Vy8+0XkkN/ifuZRolxGAIR69nzys450HuKLm/wApuEOpeD
	5ma7cILpoP8pllMGzVmQapeANg5odIB/002KoBgaGPnJ9yUW4ivulfy4zOYAQlRt+7lRMrR94Ve
	hQgCJr42qmWYya7XAVIMbks2LZjmhe49+Pm0SOrSXre0rOpMvSsFDOgmp/ueOh4kDGO49Ne+W58
	0BJBLbJ+FCYc0SNJ/ROXXDioyMXxg4sxLs/o9xTdVvMNP10IpGQdoL5ZWf0J/a5CvypM+HFW6E4
	wIHq13l+VigoOOskeEZ6EmAZB/XLME2It4pAcDvy6i94mEalTze/faHcKAz1p8aZKa4BTTkxdHx
	am+PIqrF0B2Ir93ShbN4AegNBeq6oqkPUTbVxm9qd5Y3oGoltRjFUnwVW4Gei7G7iFhsKtfpl+M
	S0hQVrr7qE5B6m1mP939zh5PhNGGnnLz0TlY1xqXGw0SN4Tnc0KYi/kbYCM5cqcv5KRckZoVSkW
	8tGRJVzS4ohcPREeSd2d3Ky/bADSt3X0cLDYPZ1k2Y51ctVFr1O0C3ikhQ=
X-Received: by 2002:a17:902:ec83:b0:2d3:7122:833 with SMTP id d9443c01a7336-2d37f7c3e97mr27552925ad.15.1786590270236;
        Wed, 12 Aug 2026 20:04:30 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2200:5cce:f1e9:7eb6:cffe:ce35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c200cf3sm3173905ad.4.2026.08.12.20.04.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 20:04:29 -0700 (PDT)
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
Subject: [PATCH 2/2] livepatch: Fix UAF of unregistered patch kobjects
Date: Thu, 13 Aug 2026 11:04:08 +0800
Message-ID: <20260813030408.9761-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813030408.9761-1-laoar.shao@gmail.com>
References: <20260813030408.9761-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When klp_enable_patch() fails after klp_init_patch_early() has run
(e.g. when klp_init_patch() can't add the patch kobject to sysfs due
to an allocation failure), the error path calls klp_free_patch_start()
and klp_free_patch_finish(). The former drops the references of the object
and function kobjects that were only initialized but never added to sysfs,
the latter drops the patch kobject reference and waits for the patch
kobject release only:

  klp_free_patch_finish():
      kobject_put(&patch->kobj);
      wait_for_completion(&patch->finish);

With CONFIG_DEBUG_KOBJECT_RELEASE enabled, kobject_put() does not
release the kobject synchronously but schedules a delayed release with
a random delay of up to 4 seconds (see kobject_release() in
lib/kobject.c). Because klp_free_patch_finish() does not wait for the
object and function kobject releases, it may return while they are
still pending. The caller can then unload the livepatch module, which
frees the klp_object and klp_func structures (either statically
defined in the module core layout or dynamically allocated by the
module init code). The delayed kobject release callbacks later access
this freed memory in kobject_cleanup(), resulting in a use-after-free.

Fix this by making patch->finish wait for the release of all
initialized kobjects that were never added to sysfs. Track the number
of pending kobject releases in struct klp_patch and complete
patch->finish when the last one is released.

For patches whose kobject was already added to sysfs, the existing
behavior is preserved and no counting is needed. In this case, the
kobject parent-child reference chain guarantees the release order:
kobject_add() bumps the parent reference (kobject_get() in
kobject_add_internal()) and the child release drops it again
(kobject_put() in kobject_cleanup()). As a result, the patch kobject
can't be released until all object kobjects are released, which in
turn can't happen until all function kobjects are released. The patch
release therefore always happens after all its sub-kobjects, so
waiting for patch->finish alone is sufficient.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260809094046.50ED31F000E9@smtp.kernel.org/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h |  8 ++++++++
 kernel/livepatch/core.c   | 43 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..1ed0d71e965b 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -33,6 +33,7 @@
  * @kobj:	kobject for sysfs resources
  * @node:	list node for klp_object func_list
  * @stack_node:	list node for klp_ops func_stack list
+ * @obj:	back pointer to the object
  * @old_size:	size of the old function
  * @new_size:	size of the new function
  * @nop:        temporary patch to use the original code again; dyn. allocated
@@ -73,6 +74,7 @@ struct klp_func {
 	struct list_head node;
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
+	struct klp_object *obj;
 	bool nop;
 	bool patched;
 	bool transition;
@@ -86,6 +88,7 @@ struct klp_func {
  * @kobj:	kobject for sysfs resources
  * @func_list:	dynamic list of the function entries
  * @node:	list node for klp_patch obj_list
+ * @patch:	back pointer to the patch
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
@@ -127,6 +131,8 @@ struct klp_state {
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
+ * @kobj_pending:	number of kobjects awaiting release
+ * @kobj_added:	the patch kobject was added to sysfs
  * @enabled:	the patch is enabled (but operation may be incomplete)
  * @forced:	was involved in a forced transition
  * @free_work:	patch cleanup from workqueue-context
@@ -140,6 +146,8 @@ struct klp_patch {
 	bool replace;
 
 	/* internal */
+	atomic_t kobj_pending;
+	bool kobj_added;
 	struct list_head list;
 	struct kobject kobj;
 	struct list_head obj_list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a240d1144e89..e0b0ef7aeb29 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -635,7 +635,8 @@ static void klp_kobj_release_patch(struct kobject *kobj)
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	complete(&patch->finish);
+	if (patch->kobj_added || atomic_dec_and_test(&patch->kobj_pending))
+		complete(&patch->finish);
 }
 
 static const struct kobj_type klp_ktype_patch = {
@@ -652,6 +653,14 @@ static void klp_kobj_release_object(struct kobject *kobj)
 
 	if (obj->dynamic)
 		klp_free_object_dynamic(obj);
+
+	/*
+	 * The object kobject was initialized but never added to sysfs.
+	 * Signal the release to the owning patch.
+	 */
+	if (!obj->patch->kobj_added &&
+	    atomic_dec_and_test(&obj->patch->kobj_pending))
+		complete(&obj->patch->finish);
 }
 
 static const struct kobj_type klp_ktype_object = {
@@ -668,6 +677,13 @@ static void klp_kobj_release_func(struct kobject *kobj)
 
 	if (func->nop)
 		klp_free_func_nop(func);
+	/*
+	 * The function kobject was initialized but never added to sysfs.
+	 * Signal the release to the owning patch.
+	 */
+	if (!func->obj->patch->kobj_added &&
+	    atomic_dec_and_test(&func->obj->patch->kobj_pending))
+		complete(&func->obj->patch->finish);
 }
 
 static const struct kobj_type klp_ktype_func = {
@@ -737,9 +753,29 @@ static void klp_free_objects_dynamic(struct klp_patch *patch)
  */
 static void klp_free_patch_start(struct klp_patch *patch)
 {
+	struct klp_object *obj;
+	struct klp_func *func;
+
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
 
+	if (!patch->kobj_added) {
+		/*
+		 * The kobjects were only initialized and never added to
+		 * sysfs. Count them so that klp_free_patch_finish() can
+		 * wait for all their releases before the patch module is
+		 * unloaded. Without this, a delayed kobject release
+		 * (CONFIG_DEBUG_KOBJECT_RELEASE) could access the freed
+		 * module memory.
+		 */
+		atomic_set(&patch->kobj_pending, 1); /* the patch kobject */
+		klp_for_each_object(patch, obj) {
+			atomic_inc(&patch->kobj_pending);
+			klp_for_each_func(obj, func)
+				atomic_inc(&patch->kobj_pending);
+		}
+	}
+
 	klp_free_objects(patch);
 }
 
@@ -944,6 +980,7 @@ static void klp_init_func_early(struct klp_object *obj,
 {
 	kobject_init(&func->kobj, &klp_ktype_func);
 	list_add_tail(&func->node, &obj->func_list);
+	func->obj = obj;
 }
 
 static void klp_init_object_early(struct klp_patch *patch,
@@ -952,6 +989,7 @@ static void klp_init_object_early(struct klp_patch *patch,
 	INIT_LIST_HEAD(&obj->func_list);
 	kobject_init(&obj->kobj, &klp_ktype_object);
 	list_add_tail(&obj->node, &patch->obj_list);
+	obj->patch = patch;
 }
 
 static void klp_init_patch_early(struct klp_patch *patch)
@@ -966,6 +1004,8 @@ static void klp_init_patch_early(struct klp_patch *patch)
 	patch->forced = false;
 	INIT_WORK(&patch->free_work, klp_free_patch_work_fn);
 	init_completion(&patch->finish);
+	atomic_set(&patch->kobj_pending, 0);
+	patch->kobj_added = false;
 
 	klp_for_each_object_static(patch, obj) {
 		klp_init_object_early(patch, obj);
@@ -984,6 +1024,7 @@ static int klp_init_patch(struct klp_patch *patch)
 	ret = kobject_add(&patch->kobj, klp_root_kobj, "%s", patch->mod->name);
 	if (ret)
 		return ret;
+	patch->kobj_added = true;
 
 	if (patch->replace) {
 		ret = klp_add_nops(patch);
-- 
2.52.0

