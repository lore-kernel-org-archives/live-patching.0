Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE62BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838252; cv=none; b=dfA0xFDMxxyzgncsDe1jugnNp1rI1H4uNpCwrDnQsCa1YNz4DVZJ2U6EY2WN2HAtg1wecPejQ6+SJ+0a2sXjwk05m4rVAL/LcuU2eWJSszI7teNB0p2ow8SngExo3Q+yVmO5WZSla+YoY2IBs1OCtpt5vpD0QDIfcOOdV/ItreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838252; c=relaxed/simple;
	bh=Dkf0BwuEymXr/mkop3P7MDysA5ZBVnXR9nHJGTc+dwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEdBAKX82lvBqlT0YvEdB2cn57mo6aOqqt/R3o0BnoUKRObgxqetyrEdnLRgvvRNM/nsa6F6oUYjseZUEnnsQ+xph94/Zx3sr7yPWgjoSTej8QPvIDK7KxtZr+w8corQIaY8fSZ/Te5guB9EaVFX9EgikwVqhdstmyg4X8opiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE1WUo35; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE1WUo35"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf30d530bdso35211645ad.3
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838250; x=1781443050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IetIetpve94UCm015HRYvO5WeXKWkYhsqV0fucQvKvA=;
        b=cE1WUo35jHF29vLBeiHdru0MFRVh/wEt/p6f8EwlRkYd0n7R2gv39ZlG3FhjZJnFxH
         FR75Ksi4oib89AQqvx5OFtYjyTattf+/hLEAeITxjYtspN8PJEE9b0P2+DZoildoOBqJ
         c71s2VNm1vnoMVzsFl0fAvav8Nd/OMY3UCKHbrLztk4zW+4EpIrBOnKRJ0OtfWHuTz8O
         F9KW0gEGcm/GFX0l6IDgNLGL58IAlBzloPP9Slx8Ls6ehgIRcCilJydeB+R1k0hGbE+z
         W+RvalkTYRfn+/6wZxI1U3HE19BNn4yy0m2I6XvIPre0LNJ+ebtNm6U7G7G6fOfD9uXm
         iwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838250; x=1781443050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IetIetpve94UCm015HRYvO5WeXKWkYhsqV0fucQvKvA=;
        b=WMN39oSLo32U6jCfBW7SkG9givmgA2z1NjczWMsysH6qCf7bkO0XM2pxONs8RWu/nh
         b4TUxjox+dP0XyVAGgviy901volTFOHShSxl4hbPnRTFzf8QBwxdo1wu5xg1MsfWE2Dw
         P1d+FisNnsOo4MWAC1h2nywBxfKrLvUgy8MG4I5mj6RK9Svgi1loKkrDYOIEHxMIVSR1
         6B5247r9Jn0PKa24ROVn4TS7U+gKi9xVw5g0K4CPTaaILl4tYlEGu6CNCur6zLn2KN+o
         979sXxBHcajcld4RgeBiRW8lENpybIUm0EjVTzICjnN7bQKSWgUPkW0JyrEAyZpyVV1N
         uaCg==
X-Gm-Message-State: AOJu0YzlKPpzIhlkLvxT0YKN049t96ZNG5ALvSw3VKapp95+VOX90xlR
	xD+xdDPiJ+i8ySm4UKfUmhycXZn30h1WByt7QSxvlc0OI3tPHI3Mwh1d
X-Gm-Gg: Acq92OEnYr2qaPZIp4M9tnGkzDmkyUlzc0sm8K6rRdQd00QcGCfUmVuadZlcdCl5O+i
	pPSsynn/Hg/jwZKEXmuQH/0EClknqUNejmacgw31YdSDU9iwfXaJ/ot5l/l/Uszfh1uDkKx3gn/
	jHhYmyltMaBeAkuJptN10sCmcpTWNaU+/W4Fh8kFLxOai0bxMdJI6ob9HLwsy+sr4UPTvmcYG7M
	N3sOvEHdkle5PZtmBjFcvbe5dOuGNyIvDv/qaxn7Vz1BHj2L9CvfeTjGn4lBicOJ42svQm8j18D
	lI17fou/vE8CQi3ybKkyu3vkdMc9N4akwunWNy+4eaPjoOZmC9eH2pSzHYoaM0sTTytzEZ7Z8Cm
	8DgkobGVYesY7IKCejYTxXlC9UBz12lTsrAHfMjNesRzMoUja1JrH8XrgnaMXS+vs3/HWNRkyjn
	RAFrV9kCt9TJZD7AmvMNv2jq7rb6G512ybz3H5dQyEbvvcFLHymnvu1p9iXCGRiUcwUu+HuTRpa
	E51GT0h9B31
X-Received: by 2002:a17:902:d2c4:b0:2c1:a19:839b with SMTP id d9443c01a7336-2c1e8225c2emr138913675ad.27.1780838250324;
        Sun, 07 Jun 2026 06:17:30 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:29 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 3/7] livepatch: Support scoped atomic replace using replace_set
Date: Sun,  7 Jun 2026 21:16:55 +0800
Message-ID: <20260607131659.29281-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607131659.29281-1-laoar.shao@gmail.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the replace attribute from a boolean to a u32 to function as a
"replace set." A newly loaded livepatch will now atomically replace any
existing patch belonging to the same set. There can only ever be one active
livepatch for a given replace_set number.

This change currently supports function replacement only. Livepatches that
belong to different replace sets cannot modify the same function. If a new
livepatch attempts to modify a function already modified by an older
livepatch from a different replace_set, the loading of the new livepatch
will be refused.

Similarly, for the KLP state, livepatches belonging to different replace
sets cannot use the same state ID. The system will refuse to load a new
livepatch if it uses a state ID already in use by an older livepatch from
a different replace_set.

For the KLP shadow variable mechanism, developers must assign unique shadow
IDs to livepatches that belong to different replace sets.

Support for replace_set compatibility with KLP state and shadow variables
will be implemented after Petr's KLP state transfer work is completed [0].

Other user-visible changes include:
- The non-replace model is now deprecated
- /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
  /sys/kernel/livepatch/livepatch_XXX/replace_set

Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]
Suggested-by: Song Liu <song@kernel.org>
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../ABI/testing/sysfs-kernel-livepatch        |  5 +-
 .../livepatch/cumulative-patches.rst          | 23 ++++++---
 Documentation/livepatch/livepatch.rst         | 21 ++++----
 include/linux/livepatch.h                     |  5 +-
 kernel/livepatch/core.c                       | 24 +++++----
 kernel/livepatch/state.c                      | 51 +++++++++++++++----
 kernel/livepatch/transition.c                 | 11 ++--
 scripts/livepatch/init.c                      |  6 +--
 scripts/livepatch/klp-build                   | 16 +++---
 9 files changed, 104 insertions(+), 58 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index 3c3f36b32b57..6d75235a6a2e 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -47,13 +47,12 @@ Description:
 		disabled when the feature is used. See
 		Documentation/livepatch/livepatch.rst for more information.
 
-What:		/sys/kernel/livepatch/<patch>/replace
+What:		/sys/kernel/livepatch/<patch>/replace_set
 Date:		Jun 2024
 KernelVersion:	6.11.0
 Contact:	live-patching@vger.kernel.org
 Description:
-		An attribute which indicates whether the patch supports
-		atomic-replace.
+		An attribute to show the replace_set of this livepatch.
 
 What:		/sys/kernel/livepatch/<patch>/stack_order
 Date:		Jan 2025
diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
index 1931f318976a..0361adb12f6d 100644
--- a/Documentation/livepatch/cumulative-patches.rst
+++ b/Documentation/livepatch/cumulative-patches.rst
@@ -17,18 +17,20 @@ from all older livepatches and completely replace them in one transition.
 Usage
 -----
 
-The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
-for example::
+The "replace_set" attribute in ``struct klp_patch`` acts as a **replace_set**,
+defining the scope of the replacement. By default, the replace_set is 0.
+
+For example::
 
 	static struct klp_patch patch = {
 		.mod = THIS_MODULE,
 		.objs = objs,
-		.replace = true,
+		.replace_set = 0,
 	};
 
 All processes are then migrated to use the code only from the new patch.
-Once the transition is finished, all older patches are automatically
-disabled.
+Once the transition is finished, all older patches with the same replace
+set are automatically disabled. Patches with different tags remain active.
 
 Ftrace handlers are transparently removed from functions that are no
 longer modified by the new cumulative patch.
@@ -62,9 +64,14 @@ Limitations:
 ------------
 
   - Once the operation finishes, there is no straightforward way
-    to reverse it and restore the replaced patches atomically.
-
-    A good practice is to set .replace flag in any released livepatch.
+    to reverse it and restore the replaced patches (with the same set)
+    atomically.
+
+    A good practice is to use only one (default) "replace_set". It
+    makes sure that there always will be only one enabled livepatch
+    on the system. The consistency model will ensure a safe update
+    between two versions. It prevents potential problems with installing
+    two livepatches doing incompatible functional changes.
     Then re-adding an older livepatch is equivalent to downgrading
     to that patch. This is safe as long as the livepatches do _not_ do
     extra modifications in (un)patching callbacks or in the module_init()
diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
index acb90164929e..221d8f1e91c4 100644
--- a/Documentation/livepatch/livepatch.rst
+++ b/Documentation/livepatch/livepatch.rst
@@ -347,15 +347,18 @@ to '0'.
 5.3. Replacing
 --------------
 
-All enabled patches might get replaced by a cumulative patch that
-has the .replace flag set.
-
-Once the new patch is enabled and the 'transition' finishes then
-all the functions (struct klp_func) associated with the replaced
-patches are removed from the corresponding struct klp_ops. Also
-the ftrace handler is unregistered and the struct klp_ops is
-freed when the related function is not modified by the new patch
-and func_stack list becomes empty.
+There always can be only one livepatch with a given "replace_set" number.
+They always replace each other.
+
+Once the transition is complete, all functions (``struct klp_func``)
+associated with the matching replaced patches are removed from the
+corresponding ``struct klp_ops``. If a function is no longer modified by
+the new patch and its ``func_stack`` list becomes empty, the ftrace
+handler is unregistered and the ``struct klp_ops`` is freed.
+
+Patches with a different replace set are not affected by this process
+and remain active. This allows for the independent management and
+stacking of multiple, non-conflicting livepatch sets.
 
 See Documentation/livepatch/cumulative-patches.rst for more details.
 
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..171c08328299 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -123,7 +123,8 @@ struct klp_state {
  * @mod:	reference to the live patch module
  * @objs:	object entries for kernel objects to be patched
  * @states:	system states that can get modified
- * @replace:	replace all actively used patches
+ * @replace_set:Livepatch using the same @replace_set will get atomically
+ *		replaced.
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
@@ -137,7 +138,7 @@ struct klp_patch {
 	struct module *mod;
 	struct klp_object *objs;
 	struct klp_state *states;
-	bool replace;
+	unsigned int replace_set;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 6e15ae96a0a7..361999e5ce3d 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -329,7 +329,7 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/enabled
  * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/force
- * /sys/kernel/livepatch/<patch>/replace
+ * /sys/kernel/livepatch/<patch>/replace_set
  * /sys/kernel/livepatch/<patch>/stack_order
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/patched
@@ -427,13 +427,13 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static ssize_t replace_show(struct kobject *kobj,
+static ssize_t replace_set_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
 {
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	return sysfs_emit(buf, "%d\n", patch->replace);
+	return sysfs_emit(buf, "%u\n", patch->replace_set);
 }
 
 static ssize_t stack_order_show(struct kobject *kobj,
@@ -460,13 +460,13 @@ static ssize_t stack_order_show(struct kobject *kobj,
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
 static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
-static struct kobj_attribute replace_kobj_attr = __ATTR_RO(replace);
+static struct kobj_attribute replace_set_kobj_attr = __ATTR_RO(replace_set);
 static struct kobj_attribute stack_order_kobj_attr = __ATTR_RO(stack_order);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
 	&force_kobj_attr.attr,
-	&replace_kobj_attr.attr,
+	&replace_set_kobj_attr.attr,
 	&stack_order_kobj_attr.attr,
 	NULL
 };
@@ -600,6 +600,8 @@ static int klp_add_nops(struct klp_patch *patch)
 		klp_for_each_object(old_patch, old_obj) {
 			int err;
 
+			if (patch->replace_set != old_patch->replace_set)
+				continue;
 			err = klp_add_object_nops(patch, old_obj);
 			if (err)
 				return err;
@@ -772,6 +774,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 	klp_for_each_patch_safe(old_patch, tmp_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (old_patch->replace_set != new_patch->replace_set)
+			continue;
 		klp_free_patch_async(old_patch);
 	}
 }
@@ -967,11 +971,9 @@ static int klp_init_patch(struct klp_patch *patch)
 	if (ret)
 		return ret;
 
-	if (patch->replace) {
-		ret = klp_add_nops(patch);
-		if (ret)
-			return ret;
-	}
+	ret = klp_add_nops(patch);
+	if (ret)
+		return ret;
 
 	klp_for_each_object(patch, obj) {
 		ret = klp_init_object(patch, obj);
@@ -1174,6 +1176,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
 		if (old_patch == new_patch)
 			return;
 
+		if (old_patch->replace_set != new_patch->replace_set)
+			continue;
 		old_patch->enabled = false;
 		klp_unpatch_objects(old_patch);
 	}
diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
index 2565d039ade0..a1ac46637336 100644
--- a/kernel/livepatch/state.c
+++ b/kernel/livepatch/state.c
@@ -85,34 +85,65 @@ EXPORT_SYMBOL_GPL(klp_get_prev_state);
 
 /* Check if the patch is able to deal with the existing system state. */
 static bool klp_is_state_compatible(struct klp_patch *patch,
+				    struct klp_patch *old_patch,
 				    struct klp_state *old_state)
 {
 	struct klp_state *state;
 
 	state = klp_get_state(patch, old_state->id);
+	if (patch->replace_set == old_patch->replace_set) {
+		/*
+		 * If the new livepatch shares a state set with an existing
+		 * one, it must maintain compatibility with all states
+		 * modified by the old patch.
+		 */
+		if (!state)
+			return false;
+		return state->version >= old_state->version;
 
-	/* A cumulative livepatch must handle all already modified states. */
-	if (!state)
-		return !patch->replace;
+	}
 
-	return state->version >= old_state->version;
+	/*
+	 * Two livepatches with a different "replace_set" must _not_ use
+	 * the same "state->id.
+	 */
+	return !state;
 }
 
-/*
- * Check that the new livepatch will not break the existing system states.
- * Cumulative patches must handle all already modified states.
- * Non-cumulative patches can touch already modified states.
- */
+/* Check that the new livepatch will not break the existing system states. */
 bool klp_is_patch_compatible(struct klp_patch *patch)
 {
+	struct klp_object *obj, *old_obj;
 	struct klp_patch *old_patch;
 	struct klp_state *old_state;
+	struct klp_func *func;
 
 	klp_for_each_patch(old_patch) {
 		klp_for_each_state(old_patch, old_state) {
-			if (!klp_is_state_compatible(patch, old_state))
+			if (!klp_is_state_compatible(patch, old_patch, old_state))
 				return false;
 		}
+
+		if (old_patch->replace_set == patch->replace_set)
+			continue;
+
+		/*
+		 * Refuse loading a livepatch which would want to modify a
+		 * function which is already livepatched with the livepatch
+		 * with another "replace_set".
+		 */
+		klp_for_each_object_static(patch, obj) {
+			klp_for_each_object(old_patch, old_obj) {
+				if (!!obj->name != !!old_obj->name)
+					continue;
+				if (obj->name && strcmp(obj->name, old_obj->name))
+					continue;
+				klp_for_each_func_static(obj, func) {
+					if (klp_find_func(old_obj, func))
+						return false;
+				}
+			}
+		}
 	}
 
 	return true;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..8b756dbaa57e 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -89,7 +89,7 @@ static void klp_complete_transition(void)
 		 klp_transition_patch->mod->name,
 		 klp_target_state == KLP_TRANSITION_PATCHED ? "patching" : "unpatching");
 
-	if (klp_transition_patch->replace && klp_target_state == KLP_TRANSITION_PATCHED) {
+	if (klp_target_state == KLP_TRANSITION_PATCHED) {
 		klp_unpatch_replaced_patches(klp_transition_patch);
 		klp_discard_nops(klp_transition_patch);
 	}
@@ -498,7 +498,7 @@ void klp_try_complete_transition(void)
 	 */
 	if (!patch->enabled)
 		klp_free_patch_async(patch);
-	else if (patch->replace)
+	else
 		klp_free_replaced_patches_async(patch);
 }
 
@@ -720,11 +720,12 @@ void klp_force_transition(void)
 		klp_update_patch_state(idle_task(cpu));
 
 	/* Set forced flag for patches being removed. */
-	if (klp_target_state == KLP_TRANSITION_UNPATCHED)
+	if (klp_target_state == KLP_TRANSITION_UNPATCHED) {
 		klp_transition_patch->forced = true;
-	else if (klp_transition_patch->replace) {
+	} else {
 		klp_for_each_patch(patch) {
-			if (patch != klp_transition_patch)
+			if (patch != klp_transition_patch &&
+			    patch->replace_set == klp_transition_patch->replace_set)
 				patch->forced = true;
 		}
 	}
diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index f14d8c8fb35f..df4fbcaf4c12 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -72,10 +72,10 @@ static int __init livepatch_mod_init(void)
 
 	/* TODO patch->states */
 
-#ifdef KLP_NO_REPLACE
-	patch->replace = false;
+#ifdef KLP_REPLACE_SET
+	patch->replace_set = KLP_REPLACE_SET;
 #else
-	patch->replace = true;
+	patch->replace_set = 0;
 #endif
 
 	return klp_enable_patch(patch);
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 0ad7e6631314..1c6c1c4f3190 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -22,7 +22,7 @@ shopt -s lastpipe
 
 unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP XTRACE
 
-REPLACE=1
+REPLACE_SET=0
 SHORT_CIRCUIT=0
 JOBS="$(getconf _NPROCESSORS_ONLN)"
 VERBOSE="-s"
@@ -134,7 +134,7 @@ Options:
    -f, --show-first-changed	Show address of first changed instruction
    -j, --jobs=<jobs>		Build jobs to run simultaneously [default: $JOBS]
    -o, --output=<file.ko>	Output file [default: livepatch-<patch-name>.ko]
-       --no-replace		Disable livepatch atomic replace
+   -s, --replace-set=<set>	Set the atomic replace set for this livepatch
    -v, --verbose		Pass V=1 to kernel/module builds
 
 Advanced Options:
@@ -159,8 +159,8 @@ process_args() {
 	local long
 	local args
 
-	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	short="hfj:o:s:vdS:T"
+	long="help,show-first-changed,jobs:,output:,replace-set:,verbose,debug,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -189,9 +189,9 @@ process_args() {
 				NAME="$(module_name_string "$NAME")"
 				shift 2
 				;;
-			--no-replace)
-				REPLACE=0
-				shift
+			-s | --replace-set)
+				REPLACE_SET="$2"
+				shift 2
 				;;
 			-v | --verbose)
 				VERBOSE="V=1"
@@ -777,7 +777,7 @@ build_patch_module() {
 
 	cflags=("-ffunction-sections")
 	cflags+=("-fdata-sections")
-	[[ $REPLACE -eq 0 ]] && cflags+=("-DKLP_NO_REPLACE")
+	cflags+=("-DKLP_REPLACE_SET=$REPLACE_SET")
 
 	cmd=("make")
 	cmd+=("$VERBOSE")
-- 
2.52.0

