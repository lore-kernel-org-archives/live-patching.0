Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172D399365
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267227; cv=none; b=NNcVERGPv52sMZYbfJQplJRmN55NWqdd9XSM5D5OSPb8RzP7aVQPE5WzZPdfQEZkPwVwde5XL2hI+XpImxT0D4Dg4JZsUaknowoKDsNKJmyT6h+We+RDUO0eTpN/+GQmWcwPZck2ETId01xiouDAex0UEGeK0lNKaxuHPypia1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267227; c=relaxed/simple;
	bh=33qNAlWZv9RKYGwU8rVp2q2UT9E2KH591OUUGXYpMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq7X6CbO+bYbes8gZ5APcpJI3m6qnSppBuDiWAtahaQb2EuFcdkeVAO+N1ge1+0WOorgn8anSu3OZuaO0Yo5iE4WQwu5U7QcjOREL4CFc5h+yed53zGyjbbYbvWLPn1HLpcCYQoCtHBKqcSg4kAEF2khvK0l4yhSVoHa1/xxVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhnJauVj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhnJauVj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc61541f8cso37361575ad.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267225; x=1786872025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/bkl9UNFzLYCbGiehrRwat7Eb4I7UxPvg1O2eojtCg=;
        b=FhnJauVj6mQ6XRLDVpof4Y+qkzm6lrd0fJlSj11fxAHvKf4oJPBlaei3hHb0rqCnnv
         VTmraF2/XWJ2kdKxO0KNUt4KAgT0tlWq7TRx8LHBVMSznIEqfl98teHuK3kKRZHnjXWW
         WRTkiwbhSJ97ylWYYVqLUtewAu3nDwRvtdsaGWbTIvFCYz/ofLbI9zsFd1eDEjlzPcaF
         5Zab8lLxMBC00r0METy4DCHxf1RkdS6zQ5eam5CSmlV+d+7qG4vI4LaOpokDSCzSLc1q
         PGwOwJwOm/rhDojFDaMAv2+lWZaazh03jvTNEKbbQsv850WrVxMYi26C8GNzgGSoony2
         GESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267225; x=1786872025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/bkl9UNFzLYCbGiehrRwat7Eb4I7UxPvg1O2eojtCg=;
        b=sAACJ6DfQge3SG6hsQpvM9XubipqCgAz0Wc0C8KJF7HCrCohU4E2molhmt+rlAEaVG
         7kR3HNUWlATnwj83AsPCSUSE04o3+v0N0l5MNek+yGVcIVO4zH5cLf6G5cw5aLtk9XRO
         j/CU4Rz2PS94kwB+ai7vcPf6xnAdTzPEF2cQmXI7SJwoCWCw2wO9I2ulXTKGyQP5J30k
         pzu2NtPpAGNuCGEX7UpYn8STVChGopZF02P5fsnWXjHAoQ37TaW1GEJ1u4wWTM4vWRuT
         ZFMjyE9GeoNXZoOVcE0dPU+TJZbNAnUFphl2R1wCBP+yLomTj+DzFayWL2B2Af6HePMw
         pumA==
X-Gm-Message-State: AOJu0Yz2BjnZ8v9Zgw9mrklnrTpH1fT3NLrXEXkbYKV7THTztZaw2m0C
	UoVF8zcFfEr00xT+WbivH6zwDgE7QGx0vbdpD3f76reHgWqQZTpxcIDT
X-Gm-Gg: AR+sD13YkCWYxjrgv6bKMR+skmmgFUoqDCvbary+YsC16eU8No+Myn08opjTjXfv/Ji
	GX7FfoG2zowhLaqpmoK+8vKZwts5USKVYcLbhsumt4k/d7HSPeRiJedq+X/obq6YeIh6M0WGbkx
	sWrutJ6M6pW05BV1lWupqJ9Ru+v3eTp8g/cAzZ4C8NuH+yqrHYz6no12jNYR4ob7dilGnFgp26j
	x9DzH5exL3Meas4jwzl1KV64j+m0FbLZWyWY5/VqDdDLIItk1mmch2oVljtqxuI0o86d8Z1N/Gu
	t+gE4MJYlft3G/jZNTLK51lEtykyOn9Mgj+ACdgBZxDHA/Bv50c9dqh3h9l3q/BBiRBzWO1BBhw
	tBIq5d7gh54N3PEsS08nknQTZki+XxJDJXRV+mW8IDVQLvz/2I4l8LcmRYyKFIK+JS5xOhkqDNA
	XBKKoLx2s3m4u19233i8VjG/GDpwP9K1stqLkjCRJQwnAf/bU9Kz5eU/T0nb+FzflzBGmpznrRo
	CC5hv/J4NWqBrybuP4YM8lNkJ9QPflzD0AmssbFtmvVZkf4O/60bpteF4wED4lrNY/4rg==
X-Received: by 2002:a17:90b:3a84:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-392845e20bdmr4655407a91.2.1786267224537;
        Sun, 09 Aug 2026 02:20:24 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 4/9] livepatch: Implement replace set for scoped atomic replace
Date: Sun,  9 Aug 2026 17:19:48 +0800
Message-ID: <20260809091954.22930-5-laoar.shao@gmail.com>
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

The current bool replace flag is too coarse: it is either all or
nothing. A livepatch with .replace=true replaces ALL existing
livepatches, which is safe but inflexible. There is no way to have
multiple independent livepatch sets coexist on the same system.

Replace it with a more flexible model using two new fields in
struct klp_patch:

- provides: an unsigned int id identifying the patch replace set.
  By default (provides=0), any livepatch replaces any other livepatch.

- obsoletes: an optional array of unsigned int ids specifying
  additional provides ids to be replaced. This allows a new patch
  to explicitly obsolete patches from different replace sets.

A new livepatch atomically replaces any existing livepatch whose
provides id matches either:
  1. The new patch provides id (same replace set), or
  2. Any id in the new patch obsoletes list

The klp-build script is updated with -p/--provides and -r/--obsoletes
options. The obsoletes list automatically includes the provides id
and deduplicates entries. Input validation rejects malformed values
at build time.

Two helper functions are introduced:
- klp_patch_replaceable(): checks if an old patch should be replaced
  by a new patch.
- klp_has_function_conflict(): rejects loading a livepatch that would
  modify a function already patched by a livepatch with a different
  provides id.

Suggested-by: Song Liu <song@kernel.org>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../ABI/testing/sysfs-kernel-livepatch        | 22 ++++-
 .../livepatch/cumulative-patches.rst          | 93 +++++++++++++------
 Documentation/livepatch/livepatch.rst         | 23 +++--
 include/linux/livepatch.h                     |  7 +-
 kernel/livepatch/core.c                       | 69 ++++++++++++--
 kernel/livepatch/core.h                       |  1 +
 kernel/livepatch/state.c                      | 57 ++++++++++--
 kernel/livepatch/transition.c                 | 11 ++-
 scripts/livepatch/init.c                      | 71 +++++++++++++-
 scripts/livepatch/klp-build                   | 77 +++++++++++++--
 10 files changed, 350 insertions(+), 81 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index 3c3f36b32b57..2588f676deb1 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -47,13 +47,25 @@ Description:
 		disabled when the feature is used. See
 		Documentation/livepatch/livepatch.rst for more information.
 
-What:		/sys/kernel/livepatch/<patch>/replace
-Date:		Jun 2024
-KernelVersion:	6.11.0
+What:		/sys/kernel/livepatch/<patch>/provides
+Date:		Jun 2026
+KernelVersion:	7.4.0
 Contact:	live-patching@vger.kernel.org
 Description:
-		An attribute which indicates whether the patch supports
-		atomic-replace.
+		An attribute to show the provides id of this livepatch.
+		Only one active livepatch per provides id is allowed.
+
+What:		/sys/kernel/livepatch/<patch>/obsoletes
+Date:		Jun 2026
+KernelVersion:	7.4.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		An attribute to show the obsoletes ids of this livepatch.
+		The obsoletes ids are a comma-separated list of provides
+		ids that this patch obsoletes. When this livepatch is
+		loaded, any existing livepatch whose provides id matches
+		either this patch's provides id or any id in the obsoletes
+		list will be atomically replaced.
 
 What:		/sys/kernel/livepatch/<patch>/stack_order
 Date:		Jan 2025
diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
index 1931f318976a..04352ae3f0d0 100644
--- a/Documentation/livepatch/cumulative-patches.rst
+++ b/Documentation/livepatch/cumulative-patches.rst
@@ -2,33 +2,66 @@
 Atomic Replace & Cumulative Patches
 ===================================
 
-There might be dependencies between livepatches. If multiple patches need
-to do different changes to the same function(s) then we need to define
-an order in which the patches will be installed. And function implementations
-from any newer livepatch must be done on top of the older ones.
-
-This might become a maintenance nightmare. Especially when more patches
-modified the same function in different ways.
-
-An elegant solution comes with the feature called "Atomic Replace". It allows
-creation of so called "Cumulative Patches". They include all wanted changes
-from all older livepatches and completely replace them in one transition.
-
-Usage
------
-
-The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
-for example::
-
-	static struct klp_patch patch = {
-		.mod = THIS_MODULE,
-		.objs = objs,
-		.replace = true,
-	};
-
-All processes are then migrated to use the code only from the new patch.
-Once the transition is finished, all older patches are automatically
-disabled.
+Livepatches are used to fix kernel bugs. New fixes need to be added over time.
+The fixes might be independent, but they might also depend on each other. This
+brings a challenge of how to keep the livepatched system safe and consistent.
+
+Part of the solution is the "Atomic Replace" feature, which allows the kernel to
+atomically replace an existing livepatch with another one. These newer
+livepatches are designed as "Cumulative Patches". They include all wanted
+changes from all older livepatches and completely replace them in one
+transition.
+
+The second part of the solution is the newly introduced ``provides`` and
+``obsoletes`` fields in ``struct klp_patch``, which allow the installation of
+multiple livepatches in parallel. A livepatch will atomically replace any
+already installed livepatch whose ``provides`` id matches either the new
+patch's ``provides`` id or any id in the new patch's ``obsoletes`` list.
+This might be used to fix independent problems separately, for example, the
+livepatches might be prepared by separate teams focusing on particular
+functionality or a subsystem.
+
+It should be emphasized that the preferred and most secure way is to always use
+the default ``provides = 0``. In this mode, any livepatch replaces any other
+livepatch, preventing any unexpected interactions between incompatible
+livepatches.
+
+Provides and Obsoletes
+-----------------------
+
+The ``provides`` field in ``struct klp_patch`` is an unsigned integer that
+identifies the livepatch's replace set. By default, it is 0.
+
+The ``obsoletes`` field is an optional array of unsigned integers that
+specifies additional ``provides`` ids to be replaced when this patch is
+loaded. By default, it includes the patch's own ``provides`` id, ensuring
+that a new patch always replaces any existing patch with the same
+``provides`` id.
+
+For example::
+
+        static struct klp_patch patch = {
+                .mod = THIS_MODULE,
+                .objs = objs,
+                .provides = 0,
+        };
+
+Any ``provides`` value might be associated with a set of livepatched symbols,
+callbacks, shadow variables, and state IDs. By definition, there can only ever
+be one active livepatch for a given ``provides`` id.
+
+On the contrary, livepatches with a different ``provides`` id must not
+modify the same function, or use the state with the same ID. Any attempt to
+load an incompatible livepatch will be rejected by the kernel.
+
+Atomic Replace
+--------------
+
+A livepatch with a given ``provides`` id is replaced by another livepatch
+with the same ``provides`` id, or whose ``obsoletes`` list includes that id.
+All processes are migrated to use the code only from the new patch. Once
+the transition is finished, the older patch is disabled. Patches with a
+different ``provides`` id are not affected and remain active.
 
 Ftrace handlers are transparently removed from functions that are no
 longer modified by the new cumulative patch.
@@ -64,7 +97,11 @@ Limitations:
   - Once the operation finishes, there is no straightforward way
     to reverse it and restore the replaced patches atomically.
 
-    A good practice is to set .replace flag in any released livepatch.
+    A good practice is to use only one (default) ``provides`` id. It
+    makes sure that there always will be only one enabled livepatch
+    on the system. The consistency model will ensure a safe update
+    between two versions. It prevents potential problems with installing
+    two livepatches doing incompatible functional changes.
     Then re-adding an older livepatch is equivalent to downgrading
     to that patch. This is safe as long as the livepatches do _not_ do
     extra modifications in (un)patching callbacks or in the module_init()
diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
index acb90164929e..73635f9ddd91 100644
--- a/Documentation/livepatch/livepatch.rst
+++ b/Documentation/livepatch/livepatch.rst
@@ -347,15 +347,20 @@ to '0'.
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
+There can be only one active livepatch for a given ``provides`` id.
+A new livepatch atomically replaces any existing livepatch whose
+``provides`` id matches either the new patch's ``provides`` id or
+any id in the new patch's ``obsoletes`` list.
+
+Once the transition is complete, all functions (``struct klp_func``)
+associated with the matching replaced patches are removed from the
+corresponding ``struct klp_ops``. If a function is no longer modified by
+the new patch and its ``func_stack`` list becomes empty, the ftrace
+handler is unregistered and the ``struct klp_ops`` is freed.
+
+Patches with a different ``provides`` id are not affected by this
+process and remain active. This allows for the independent management
+and stacking of multiple, non-conflicting livepatch sets.
 
 See Documentation/livepatch/cumulative-patches.rst for more details.
 
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..854ed6230b96 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -123,7 +123,8 @@ struct klp_state {
  * @mod:	reference to the live patch module
  * @objs:	object entries for kernel objects to be patched
  * @states:	system states that can get modified
- * @replace:	replace all actively used patches
+ * @provides:	only one active livepatch per id
+ * @obsoletes:	replace given livepatch id(s)
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
@@ -137,7 +138,9 @@ struct klp_patch {
 	struct module *mod;
 	struct klp_object *objs;
 	struct klp_state *states;
-	bool replace;
+	unsigned int provides;
+	unsigned int *obsoletes;
+	unsigned int nr_obsoletes;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3de3940d34b2..922aa00a6329 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -350,7 +350,8 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/enabled
  * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/force
- * /sys/kernel/livepatch/<patch>/replace
+ * /sys/kernel/livepatch/<patch>/provides
+ * /sys/kernel/livepatch/<patch>/obsoletes
  * /sys/kernel/livepatch/<patch>/stack_order
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/patched
@@ -448,13 +449,32 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static ssize_t replace_show(struct kobject *kobj,
+static ssize_t provides_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
 {
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	return sysfs_emit(buf, "%d\n", patch->replace);
+	return sysfs_emit(buf, "%u\n", patch->provides);
+}
+
+static ssize_t obsoletes_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	struct klp_patch *patch;
+	unsigned int i;
+	int len = 0;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+	if (!patch->obsoletes || !patch->nr_obsoletes)
+		return sysfs_emit(buf, "\n");
+
+	for (i = 0; i < patch->nr_obsoletes; i++)
+		len += sysfs_emit_at(buf, len, "%u%s", patch->obsoletes[i],
+				     i < patch->nr_obsoletes - 1 ? "," : "");
+
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
 }
 
 static ssize_t stack_order_show(struct kobject *kobj,
@@ -481,13 +501,15 @@ static ssize_t stack_order_show(struct kobject *kobj,
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
 static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
-static struct kobj_attribute replace_kobj_attr = __ATTR_RO(replace);
+static struct kobj_attribute provides_kobj_attr = __ATTR_RO(provides);
+static struct kobj_attribute obsoletes_kobj_attr = __ATTR_RO(obsoletes);
 static struct kobj_attribute stack_order_kobj_attr = __ATTR_RO(stack_order);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
 	&force_kobj_attr.attr,
-	&replace_kobj_attr.attr,
+	&provides_kobj_attr.attr,
+	&obsoletes_kobj_attr.attr,
 	&stack_order_kobj_attr.attr,
 	NULL
 };
@@ -520,6 +542,28 @@ static void klp_init_func_early(struct klp_object *obj,
 static void klp_init_object_early(struct klp_patch *patch,
 				  struct klp_object *obj);
 
+/*
+ * Check if old_patch should be replaced by new_patch:
+ * 1. Same provides ID
+ * 2. Old provides ID is in new patch's obsoletes list
+ */
+bool klp_patch_replaceable(struct klp_patch *old_patch, struct klp_patch *new_patch)
+{
+	unsigned int i;
+
+	if (old_patch->provides == new_patch->provides)
+		return true;
+
+	if (!new_patch->obsoletes)
+		return false;
+
+	for (i = 0; i < new_patch->nr_obsoletes; i++) {
+		if (new_patch->obsoletes[i] == old_patch->provides)
+			return true;
+	}
+	return false;
+}
+
 static struct klp_object *klp_alloc_object_dynamic(const char *name,
 						   struct klp_patch *patch)
 {
@@ -618,6 +662,9 @@ static int klp_add_nops(struct klp_patch *patch)
 	struct klp_object *old_obj;
 
 	klp_for_each_patch(old_patch) {
+		if (!klp_patch_replaceable(old_patch, patch))
+			continue;
+
 		klp_for_each_object(old_patch, old_obj) {
 			int err;
 
@@ -793,6 +840,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 	klp_for_each_patch_safe(old_patch, tmp_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (!klp_patch_replaceable(old_patch, new_patch))
+			continue;
 		klp_free_patch_async(old_patch);
 	}
 }
@@ -985,11 +1034,9 @@ static int klp_init_patch(struct klp_patch *patch)
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
@@ -1205,6 +1252,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
 	klp_for_each_patch(old_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (!klp_patch_replaceable(old_patch, new_patch))
+			continue;
 
 		old_patch->enabled = false;
 		klp_unpatch_objects(old_patch);
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 361a0917a03f..558ce7b70754 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -18,6 +18,7 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch);
 void klp_unpatch_replaced_patches(struct klp_patch *new_patch);
 void klp_discard_nops(struct klp_patch *new_patch);
 struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *func);
+bool klp_patch_replaceable(struct klp_patch *old_patch, struct klp_patch *new_patch);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
index 2565d039ade0..c31746f47f71 100644
--- a/kernel/livepatch/state.c
+++ b/kernel/livepatch/state.c
@@ -85,24 +85,62 @@ EXPORT_SYMBOL_GPL(klp_get_prev_state);
 
 /* Check if the patch is able to deal with the existing system state. */
 static bool klp_is_state_compatible(struct klp_patch *patch,
+				    struct klp_patch *old_patch,
 				    struct klp_state *old_state)
 {
 	struct klp_state *state;
 
 	state = klp_get_state(patch, old_state->id);
+	if (klp_patch_replaceable(old_patch, patch)) {
+		/*
+		 * If the new livepatch will replace the old one, it must
+		 * handle all already modified states (cumulative patch).
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
+	 * Two livepatches with a different "provides" must _not_ use
+	 * the same "state->id.
+	 */
+	return !state;
 }
 
 /*
- * Check that the new livepatch will not break the existing system states.
- * Cumulative patches must handle all already modified states.
- * Non-cumulative patches can touch already modified states.
+ * Refuse loading a livepatch which would want to modify a function
+ * which is already livepatched by a patch that will not be replaced.
+ * A patch is replaced if it has the same provides id or if its
+ * provides id is in the new patch's obsoletes list.
  */
+static bool klp_has_function_conflict(struct klp_patch *patch,
+				      struct klp_patch *old_patch)
+{
+	struct klp_object *obj, *old_obj;
+	struct klp_func *func;
+
+	if (klp_patch_replaceable(old_patch, patch))
+		return false;
+
+	klp_for_each_object(patch, obj) {
+		klp_for_each_object(old_patch, old_obj) {
+			if (!!obj->name != !!old_obj->name)
+				continue;
+			if (obj->name && strcmp(obj->name, old_obj->name))
+				continue;
+
+			klp_for_each_func(obj, func) {
+				if (klp_find_func(old_obj, func))
+					return true;
+			}
+		}
+	}
+	return false;
+}
+
+/* Check that the new livepatch will not break the existing system states. */
 bool klp_is_patch_compatible(struct klp_patch *patch)
 {
 	struct klp_patch *old_patch;
@@ -110,9 +148,12 @@ bool klp_is_patch_compatible(struct klp_patch *patch)
 
 	klp_for_each_patch(old_patch) {
 		klp_for_each_state(old_patch, old_state) {
-			if (!klp_is_state_compatible(patch, old_state))
+			if (!klp_is_state_compatible(patch, old_patch, old_state))
 				return false;
 		}
+
+		if (klp_has_function_conflict(patch, old_patch))
+			return false;
 	}
 
 	return true;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..15dbc13d0341 100644
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
+			    klp_patch_replaceable(patch, klp_transition_patch))
 				patch->forced = true;
 		}
 	}
diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index 16aff8f736eb..044263191652 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/livepatch.h>
+#include <linux/string.h>
 
 static struct klp_patch *patch;
 
@@ -50,8 +51,6 @@ static int __init livepatch_mod_init(void)
 		funcs = kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
 		if (!funcs) {
 			ret = -ENOMEM;
-			for (int j = 0; j < i; j++)
-				kfree(objs[j].funcs);
 			goto err_free_objs;
 		}
 
@@ -72,15 +71,76 @@ static int __init livepatch_mod_init(void)
 
 	/* TODO patch->states */
 
-#ifdef KLP_NO_REPLACE
-	patch->replace = false;
+#ifdef KLP_PROVIDES
+	patch->provides = KLP_PROVIDES;
 #else
-	patch->replace = true;
+	patch->provides = 0;
+#endif
+
+#ifdef KLP_OBSOLETES
+	/*
+	 * Parse KLP_OBSOLETES string (format: "1,2,3") and convert to
+	 * unsigned int array for patch->obsoletes.
+	 *
+	 * Note: The provides ID is not included here; the kernel will
+	 * replace livepatch with the same provides ID.
+	 */
+	{
+		unsigned int *obs_array;
+		unsigned int count = 1;
+		char *obsoletes_str;
+		char *token, *str;
+		int i = 0;
+
+		for (str = (char *)KLP_OBSOLETES; *str; str++) {
+			if (*str == ',')
+				count++;
+		}
+
+		obsoletes_str = kstrdup(KLP_OBSOLETES, GFP_KERNEL);
+		if (!obsoletes_str) {
+			ret = -ENOMEM;
+			goto err_free_objs;
+		}
+
+		obs_array = kmalloc_array(count, sizeof(unsigned int), GFP_KERNEL);
+		if (!obs_array) {
+			kfree(obsoletes_str);
+			ret = -ENOMEM;
+			goto err_free_objs;
+		}
+
+		str = obsoletes_str;
+		while ((token = strsep(&str, ",")) != NULL) {
+			unsigned int val;
+
+			ret = kstrtouint(token, 10, &val);
+			if (ret) {
+				kfree(obsoletes_str);
+				kfree(obs_array);
+				goto err_free_objs;
+			}
+			obs_array[i++] = val;
+		}
+
+		patch->obsoletes = obs_array;
+		patch->nr_obsoletes = i;
+
+		if (i > 0)
+			pr_info("obsoletes patch ids: %s\n", KLP_OBSOLETES);
+
+		kfree(obsoletes_str);
+	}
+#else
+	patch->obsoletes = NULL;
+	patch->nr_obsoletes = 0;
 #endif
 
 	return klp_enable_patch(patch);
 
 err_free_objs:
+	for (int i = 0; i < nr_objs; i++)
+		kfree(objs[i].funcs);
 	kfree(objs);
 err_free_patch:
 	kfree(patch);
@@ -96,6 +156,7 @@ static void __exit livepatch_mod_exit(void)
 		kfree(obj->funcs);
 
 	kfree(patch->objs);
+	kfree(patch->obsoletes);
 	kfree(patch);
 }
 
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index c4a7acf8edc3..3600f93d9c1c 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -21,7 +21,8 @@ shopt -s lastpipe
 
 unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
 
-REPLACE=1
+PROVIDES=0
+OBSOLETES=""
 SHORT_CIRCUIT=0
 JOBS="$(getconf _NPROCESSORS_ONLN)"
 shopt -o xtrace | grep -q 'on' && XTRACE=1
@@ -132,7 +133,8 @@ Options:
    -f, --show-first-changed	Show address of first changed instruction
    -j, --jobs=<jobs>		Build jobs to run simultaneously [default: $JOBS]
    -o, --output=<file.ko>	Output file [default: livepatch-<patch-name>.ko]
-       --no-replace		Disable livepatch atomic replace
+   -p, --provides=<id>		Set the provides id for this livepatch
+   -r, --obsoletes=<ids>	Set the obsoletes ids array (e.g., "[0,1,2]")
    -v, --verbose		Pass V=1 to kernel/module builds
 
 Advanced Options:
@@ -147,7 +149,6 @@ Advanced Options:
 
 EOF
 }
-
 usage() {
 	__usage >&2
 }
@@ -159,8 +160,8 @@ process_args() {
 	local args
 	local patch
 
-	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	short="hfj:o:p:r:vdS:T"
+	long="help,show-first-changed,jobs:,output:,provides:,obsoletes:,verbose,debug,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -189,9 +190,26 @@ process_args() {
 				NAME="$(module_name_string "$NAME")"
 				shift 2
 				;;
-			--no-replace)
-				REPLACE=0
-				shift
+			-p | --provides)
+				PROVIDES="$2"
+				shift 2
+				;;
+			-r | --obsoletes)
+				OBSOLETES="$2"
+				local obs_val="$2"
+				[[ "$obs_val" != \[*\] ]] && die "obsoletes must be enclosed in brackets, e.g., '[0,1,2]'"
+				local obs_check="${obs_val//[\[\] ]/}"
+				[[ -z "$obs_check" ]] && shift 2 && continue
+				[[ "$obs_check" == ,* || "$obs_check" == *, || "$obs_check" == *,,* ]] && \
+					die "obsoletes has invalid comma usage: '$obs_val'"
+				local IFS=','
+				local obs_elem
+				for obs_elem in $obs_check; do
+					[[ ! "$obs_elem" =~ ^[0-9]+$ ]] && \
+						die "obsoletes contains invalid value '$obs_elem': only non-negative integers allowed"
+				done
+				unset IFS
+				shift 2
 				;;
 			-v | --verbose)
 				VERBOSE=1
@@ -235,6 +253,37 @@ process_args() {
 		exit 1
 	fi
 
+	# Remove duplicates from obsoletes (if specified)
+	# Note: provides ID is not added here; the kernel will replace
+	# livepatch with the same provides ID.
+	if [[ -n "$OBSOLETES" && "$OBSOLETES" != "[]" ]]; then
+		local obsoletes_clean="${OBSOLETES//[\[\] ]/}"
+		local IFS=','
+		local -a obs_array=()
+		local obs_id
+		local already_exists
+
+		for obs_id in $obsoletes_clean; do
+			if [[ -n "$obs_id" ]]; then
+				already_exists=0
+				for existing in "${obs_array[@]}"; do
+					if [[ "$existing" -eq "$obs_id" ]]; then
+						already_exists=1
+						break
+					fi
+				done
+
+				if [[ "$already_exists" -eq 0 ]]; then
+					obs_array+=("$obs_id")
+				fi
+			fi
+		done
+
+		local IFS=','
+		OBSOLETES="[${obs_array[*]}]"
+		unset IFS
+	fi
+
 	KEEP_TMP="$keep_tmp"
 	PATCHES=("$@")
 
@@ -847,7 +896,17 @@ build_patch_module() {
 
 	cflags=("-ffunction-sections")
 	cflags+=("-fdata-sections")
-	[[ $REPLACE -eq 0 ]] && cflags+=("-DKLP_NO_REPLACE")
+	cflags+=("-DKLP_PROVIDES=$PROVIDES")
+
+	# Process OBSOLETES: remove brackets and spaces, convert to comma-separated string
+	# Input: "[0, 1, 2]" or "[]" or "" -> Output: "0,1,2" or empty
+	if [[ -n "$OBSOLETES" && "$OBSOLETES" != "[]" ]]; then
+		# Remove '[', ']', and spaces, keep commas
+		local obsoletes_clean="${OBSOLETES//[\[\] ]/}"
+		# Escape quotes properly for C string macro
+		cflags+=("-DKLP_OBSOLETES=\\\"$obsoletes_clean\\\"")
+		[[ -v VERBOSE ]] && echo "  KLP_OBSOLETES=$obsoletes_clean (from OBSOLETES=$OBSOLETES, PROVIDES=$PROVIDES)" >&2
+	fi
 
 	cmd=("make")
 	if [[ -v VERBOSE ]]; then
-- 
2.52.0

