Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021860;
	b=CZ47zuPoooAvn3fmiLOsQSW9EObvepITgZkHxwBJ3RfLPjdlpkqQZQez/M+PWifIgCgU
	 eulekCJ9V2WWYcLYRGR7B90ZfP6up5+FJ7HpamSms9tjSoEppkEHA/CmPKVeC4Z/tjnUz
	 jfk+HsZ2GunL9cQ+RIWII28HyifmeLKotEuUIHcDOyk9BiNzb5T1KoyqVCNJ+YH0Sovv5
	 pYLu6RrRrAxaZ/bBZr2RZc17TkdIVegppiZ1QcVV7MH6t0mZDaH2x+4LjeOpt8wD4M0KB
	 9iXkNqhnUNll/D2v/hV95N3NbkpVCU64pCe1gPKj/W1BA11sozsyeaYwIlNdr+FbauQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a2mwYTImKyBQcjHFxDCAJTCyu3Srzw0Gxbg5v06dIu4=;
	b=dmatsuxy+N0myVY55LtMIRseokWdM6eZYb9jfmBRY2rAmKBrAfy5ceiFbMqYSq+UDuGK
	 0q2l1NRkUZuaarcGNX8sufL5vrPmNPtyf0L6+9mMlqBmk/S2K508Swmv7thRrVzl5CTdN
	 H972WQMvbVDSDU5wLdd63Y9ue6+eUmIKxgevPH/pRHzR8upiOOuaNT252xM3Rbgbdp9ex
	 YsYWUo4dPGv566iq9QgWJRqmZ6pAbbzxJJLAYdUI+AVdnnx+afnhc2b+j8I9rRYM1U7kE
	 XB/3QZRnYY87F9r0pD8po23PErILRynh+1c9QJib7/6M4gQuhFG3HfK+q/6O8wojCoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UvHu/gr4";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC660A6F45
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DC660A6F45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UvHu/gr4
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9ae391a05so20919365ad.1
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021858; x=1793626658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2mwYTImKyBQcjHFxDCAJTCyu3Srzw0Gxbg5v06dIu4=;
        b=UvHu/gr4c2972qXzI+3QPdVKg1nsG5NaJJSHru0LGrKXfxv0NBca8kLg/XYw4nVmo7
         GJOU0o3KG9nFNhH3JoFIMdfofRGR9MtkLGW68Z1DLYjkVyguiNJkuH/gJPToAL+SviJC
         mR+UjscqV8OZFVFOQzhIqlXtqA+883RjH5+w0MkiOQL969NZL4R3KuSsJjHtn7YN21jc
         rs6ebnZwZzlRsFIp1laCkyiUgpXbrrGtiKcvj/CWNp8BddKBvbDSynXYob7n/hU0AHkp
         qC5xUl0z5pV/2UJhvhvV9zT4IB2sSFVOCCr2CrYn+qtsmWF4PfBHMj35OfglYgGR624L
         Wj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021858; x=1793626658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a2mwYTImKyBQcjHFxDCAJTCyu3Srzw0Gxbg5v06dIu4=;
        b=Jm2pHSIu+JL3SeWbbd22hNiF4fgigh6s9/ZXgzhwp8+6dWHhaCrMlGh4NP/RIWUox1
         GjVyad+exJIzOyjrLhS0JGnm0NWktCd50E24vdALJGjPePLjGCwJEPeGvvul7QFKEJfz
         fMNfIbIaiyt7Ou2sVggzBJOs/7fZq6mn9aTO/HP/ZrnHQgc3uk17O80jSxYo8XU9P7wq
         MllqryHIqzdMEse5GEriXs8dfjdy5H1f418hSVINwaEqN0tWVOuZiqmwzHnVAnY8A7OJ
         BAvIq7C2OASH22XcnnfXmYfV7E7G/YvtlMemophIijIStBb+6fM2+G8y6h/LUkqcvpSX
         gjDA==
X-Gm-Message-State: AFq9FYKQkDhofVY44C6E/8hn2pT6lk8Wd0w/o2b2tCpM9RXrIZQArw0U
	IGbGTUIPXo+vjxcMO7VCTxFsx/k/wmaOUoPDJvyDeSgnysBOH5rwhmES
X-Gm-Gg: AYBFou2cxm/i1GKkjdhQjyAMZDkTnB4sA3laoMZ//KANHwEaaNhkVCPXeEwymWKuiei
	GKNb8z3Quu5gVLPqahfQs/aaSF5YXmzv2YcSuuan222g/2nv7iS46lOFRypiPlJ7+ucS69hpjBR
	dBt0rEA/s3hK+j2ByLD5pAkBLa/8cO/30Hax255UsM93ch46sF4Cdt+dSTZTbcuFAIu00jfNnDO
	uGBrYkVKpgV6Ciwn3txf6hSXjPcv+xpeCvZFyn0uATflE6rd2EF4BC5F6qUsZBs7/V/xEjEyEqi
	6BTnDqbzG3f52iWe42Ndxxwq7JWZXaM9OcgVg+DJtjgge8KYYWgwyvi2pSysC1v7pwev7J5Hht7
	PUcI9xPIZmtcPvp9ozsyvI6OI4ojSNE6vCmiAzjLsihedv5VwhqiqWNfWFzcRRx7E+R7MyVXV17
	wlA3VblxoXmxxKiYaF7GQLJDlIujdn3LxldToNIUNE24wbH6joc8kHtJGh7aFpi0/DOVIIuYlG0
	RCVWPFyAUyzUiI0lBz8Oq5DBoGn5cquUDIc4AjbQpHrEKPe5rhNxyepsN3raLG3rwgz+PtKXLH7
	MBx6NYa4NY06whEyYkAFGpYZHpcggYHbFkFzjdrS0nujJobq72S7bL2qwDk=
X-Received: by 2002:a17:903:3c2c:b0:2e9:5178:4e83 with SMTP id d9443c01a7336-2ea9cc69844mr39991655ad.38.1793021858183;
        Mon, 26 Oct 2026 06:37:38 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:37 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 5/9] livepatch: Implement provides and obsoletes for scoped atomic replace
Date: Mon, 26 Oct 2026 21:36:47 +0800
Message-ID: <20261026133651.40061-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bool replace flag is too coarse: it is either all or
nothing. A livepatch with .replace=true replaces ALL existing
livepatches, which is safe but inflexible. There is no way to have
multiple independent livepatch sets coexist on the same system.

Replace it with a more flexible model using two new fields in
struct klp_patch:

- provides: an unsigned int id identifying the changes made by
  the related livepatch. Where the changes are a set
  of modified objects, functions, and used callbacks,
  shadow variable ids, and state ids.

- obsoletes: an optional array of unsigned int ids specifying
  additional provides ids to be replaced. This allows a new patch
  to explicitly obsolete patches from different scopes.

A new livepatch atomically replaces any existing livepatch that
meets either of the following conditions:

1. It has the same provides id as the new patch,
2. Its provides id is listed in the new patch's obsoletes list.

A new livepatch that does not replace an existing one can coexist
with it. In this case, the two livepatches must not modify the same
function, or use the state with the same id. Any attempt to load an
incompatible livepatch will be rejected by the kernel.

klp-build gains -p/--provides and -r/--obsoletes options.  The two
parameters are not validated in klp-build, since the compiler and the
kernel handle invalid values.

Enable the CONFIG_KLP_HAS_PROVIDES compile-time marker now that the
provides/obsoletes interface is implemented.

Suggested-by: Song Liu <song@kernel.org>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/ABI/removed/sysfs-kernel-livepatch |   7 ++
 Documentation/ABI/testing/sysfs-kernel-livepatch |  21 +++-
 Documentation/livepatch/cumulative-patches.rst   | 127 ++++++++++++++++++-----
 Documentation/livepatch/livepatch.rst            |  29 ++++--
 Documentation/livepatch/system-state.rst         |  22 ++--
 MAINTAINERS                                      |   1 +
 include/linux/livepatch.h                        |   8 +-
 kernel/livepatch/Kconfig                         |   3 +-
 kernel/livepatch/core.c                          |  82 ++++++++++++---
 kernel/livepatch/core.h                          |   1 +
 kernel/livepatch/state.c                         |  70 ++++++++++---
 kernel/livepatch/transition.c                    |  15 +--
 scripts/livepatch/init.c                         |  18 ++--
 scripts/livepatch/klp-build                      |  23 ++--
 14 files changed, 321 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch

diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
new file mode 100644
index 0000000..87d57ba
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
@@ -0,0 +1,7 @@
+What:		/sys/kernel/livepatch/<patch>/replace
+Date:		Jun 2024
+KernelVersion:	6.11.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		An attribute which indicates whether the patch supports
+		atomic-replace.
diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index 3c3f36b..a9d4893 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -47,13 +47,24 @@ Description:
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
+		Livepatches with the same provides id replace each other.
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
+		an id in the obsoletes list will be atomically replaced.
 
 What:		/sys/kernel/livepatch/<patch>/stack_order
 Date:		Jan 2025
diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
index 1931f31..5553362 100644
--- a/Documentation/livepatch/cumulative-patches.rst
+++ b/Documentation/livepatch/cumulative-patches.rst
@@ -2,33 +2,71 @@
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
+The second part of the solution are ``provides`` and ``obsoletes`` fields in
+``struct klp_patch``, which allow the installation of multiple livepatches in
+parallel. A livepatch will atomically replace any already installed livepatch
+whose ``provides`` id is the same as the new patch's ``provides`` id, or is
+listed in the new patch's ``obsoletes`` list. This might be used to fix
+independent problems separately, for example, the livepatches might be prepared
+by separate teams focusing on particular functionality or a subsystem.
+
+It should be emphasized that the preferred and most secure way is to always use
+the default ``provides = 0``. As long as all livepatches use the same default
+id, any livepatch replaces any other livepatch, preventing any unexpected
+interactions between incompatible livepatches.
+
+Installing more livepatches in parallel is dangerous, especially
+when they are provided by different teams or vendors. The built-in
+checks for possible conflicts do not prevent potential
+incompatibilities and breakages. For example, two livepatches might
+modify different functions but still affect each other via shared
+data structures or global variables.
+
+Provides and Obsoletes
+-----------------------
+
+The ``provides`` field in ``struct klp_patch`` is an unsigned integer that
+identifies the livepatch. By default, it is 0.
+
+The ``obsoletes`` field is an optional array of unsigned integers that
+specifies additional ``provides`` ids to be replaced when this patch is
+loaded.
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
+On the contrary, a new livepatch that does not replace an existing one can
+coexist with it. In this case, the two livepatches must not modify the same
+function, or use the state with the same ID. Any attempt to load an incompatible
+livepatch will be rejected by the kernel.
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
@@ -64,7 +102,11 @@ Limitations:
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
@@ -74,6 +116,35 @@ Limitations:
     only when the transition was not forced.
 
 
+  - The rollback is even more complicated when the new livepatch
+    obsoletes more livepatches. For example, livepatch A (provides 1)
+    and livepatch B (provides 2) are independent. Livepatch C
+    (provides 3, obsoletes 1 and 2) replaces both A and B. A proper
+    rollback from C would require loading A and B synchronously.
+    It would need special support in the module loader and
+    the livepatch core code. This is not supported.
+
+    Instead, the rollback has to be done in more steps, for example::
+
+      echo 0 > /sys/kernel/livepatch/livepatch_C/enabled
+      modprobe livepatch_A
+      modprobe livepatch_B
+
+    Note that the replaced livepatches stay loaded but disabled.
+    They have to be removed before they can be loaded again.
+    The example above assumes that they were removed in
+    the meantime.
+
+    Also, the older livepatches can be loaded only when they do
+    not conflict with the still enabled ones, see the conflict
+    rules above. The newer livepatch is expected to include the
+    fixes from the obsoleted livepatches. As a result, the
+    rollback usually has to start by disabling the newer
+    livepatch. The rollback is not atomic. The affected
+    functions run the original code until all the older
+    livepatches get loaded again.
+
+
   - Only the (un)patching callbacks from the _new_ cumulative livepatch are
     executed. Any callbacks from the replaced patches are ignored.
 
diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
index acb9016..2567e09 100644
--- a/Documentation/livepatch/livepatch.rst
+++ b/Documentation/livepatch/livepatch.rst
@@ -347,15 +347,26 @@ to '0'.
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
+A new livepatch that does not replace an existing one can coexist with it.
+In this case, the two livepatches must not modify the same function, or use
+the state with the same id. Any attempt to load an incompatible livepatch
+will be rejected by the kernel.
+
+Installing more livepatches in parallel is dangerous, especially
+when they are provided by different teams or vendors. The built-in
+checks for possible conflicts do not prevent potential
+incompatibilities and breakages.
+
+Once the transition is complete, all functions (``struct klp_func``)
+associated with the matching replaced patches are removed from the
+corresponding ``struct klp_ops``. If a function is no longer modified by
+the new patch and its ``func_stack`` list becomes empty, the ftrace
+handler is unregistered and the ``struct klp_ops`` is freed.
 
 See Documentation/livepatch/cumulative-patches.rst for more details.
 
diff --git a/Documentation/livepatch/system-state.rst b/Documentation/livepatch/system-state.rst
index 7a3935f..42b06ca 100644
--- a/Documentation/livepatch/system-state.rst
+++ b/Documentation/livepatch/system-state.rst
@@ -6,9 +6,10 @@ Some users are really reluctant to reboot a system. This brings the need
 to provide more livepatches and maintain some compatibility between them.
 
 Maintaining more livepatches is much easier with cumulative livepatches.
-Each new livepatch completely replaces any older one. It can keep,
-add, and even remove fixes. And it is typically safe to replace any version
-of the livepatch with any other one thanks to the atomic replace feature.
+A new version of a cumulative livepatch with the same ``provides`` id
+completely replaces the older one. It can keep, add, and even remove fixes.
+And it is typically safe to replace any version of the livepatch with any
+other one thanks to the atomic replace feature.
 
 The problems might come with shadow variables and callbacks. They might
 change the system behavior or state so that it is no longer safe to
@@ -70,14 +71,15 @@ The check is done when the livepatch is enabled. The rules are:
 
   - Any completely new system state modification is allowed.
 
-  - System state modifications with the same or higher version are allowed
-    for already modified system states.
+  - A livepatch that replaces an existing one must handle all system
+    state modifications from the livepatches that are being replaced.
+    The version of the state must be the same or higher than the
+    version of the state that is being replaced.
 
-  - Cumulative livepatches must handle all system state modifications from
-    already installed livepatches.
-
-  - Non-cumulative livepatches are allowed to touch already modified
-    system states.
+  - A livepatch that does not replace any existing one must not touch
+    already modified system states. It would conflict with the already
+    installed livepatches and the load would get rejected, see
+    the conflict rules in Documentation/livepatch/cumulative-patches.rst.
 
 3. Supported scenarios
 ======================
diff --git a/MAINTAINERS b/MAINTAINERS
index efa1e8e..133b1fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15237,6 +15237,7 @@ M:	Song Liu <song@kernel.org>
 L:	live-patching@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
+F:	Documentation/ABI/removed/sysfs-kernel-livepatch
 F:	Documentation/ABI/testing/sysfs-kernel-livepatch
 F:	Documentation/livepatch/
 F:	arch/powerpc/include/asm/livepatch.h
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 5f74f79..1e3a09e 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -127,7 +127,9 @@ struct klp_state {
  * @mod:	reference to the live patch module
  * @objs:	object entries for kernel objects to be patched
  * @states:	system states that can get modified
- * @replace:	replace all actively used patches
+ * @provides:	only one active livepatch per id
+ * @obsoletes:	replace given livepatch id(s)
+ * @nr_obsoletes: number of entries in the @obsoletes array
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
@@ -141,7 +143,9 @@ struct klp_patch {
 	struct module *mod;
 	struct klp_object *objs;
 	struct klp_state *states;
-	bool replace;
+	unsigned int provides;
+	unsigned int *obsoletes;
+	unsigned int nr_obsoletes;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index d1eb971..97cee78 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -32,7 +32,8 @@ config KLP_BUILD
 	  Enable klp-build support
 
 config KLP_HAS_PROVIDES
-	def_bool n
+	def_bool y
+	depends on LIVEPATCH
 	help
 	  Compile-time marker for the livepatch provides/obsoletes support.
 	  It is always set when the kernel is built with the scoped atomic
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 7240e72..62fc215 100644
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
-			    struct kobj_attribute *attr, char *buf)
+static ssize_t provides_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	struct klp_patch *patch;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+	return sysfs_emit(buf, "%u\n", patch->provides);
+}
+
+static ssize_t obsoletes_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
 {
 	struct klp_patch *patch;
+	unsigned int i;
+	int len = 0;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
-	return sysfs_emit(buf, "%d\n", patch->replace);
+	if (!patch->obsoletes || !patch->nr_obsoletes)
+		return sysfs_emit(buf, "\n");
+
+	for (i = 0; i < patch->nr_obsoletes; i++)
+		len += sysfs_emit_at(buf, len, "%s%u", i == 0 ? "" : ",",
+				     patch->obsoletes[i]);
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
@@ -520,6 +542,27 @@ static void klp_init_func_early(struct klp_object *obj,
 static void klp_init_object_early(struct klp_patch *patch,
 				  struct klp_object *obj);
 
+/*
+ * Check if @new_patch will replace @old_patch:
+ * 1. Same provides ID
+ * 2. Old provides ID is in new patch's obsoletes list
+ */
+bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch *old_patch)
+{
+	unsigned int i;
+
+	if (old_patch->provides == new_patch->provides)
+		return true;
+
+	if (new_patch->obsoletes) {
+		for (i = 0; i < new_patch->nr_obsoletes; i++) {
+			if (new_patch->obsoletes[i] == old_patch->provides)
+				return true;
+		}
+	}
+	return false;
+}
+
 static struct klp_object *klp_alloc_object_dynamic(const char *name,
 						   struct klp_patch *patch)
 {
@@ -608,9 +651,10 @@ static int klp_add_object_nops(struct klp_patch *patch,
  * Add 'nop' functions which simply return to the caller to run the
  * original function.
  *
- * They are added only when the atomic replace mode is used and only for
- * functions which are currently livepatched but are no longer included
- * in the new livepatch.
+ * They are added only when the new livepatch replaces an older one,
+ * see klp_patch_replaces(), and only for functions which are
+ * currently livepatched but are no longer included in the new
+ * livepatch.
  */
 static int klp_add_nops(struct klp_patch *patch)
 {
@@ -618,6 +662,9 @@ static int klp_add_nops(struct klp_patch *patch)
 	struct klp_object *old_obj;
 
 	klp_for_each_patch(old_patch) {
+		if (!klp_patch_replaces(patch, old_patch))
+			continue;
+
 		klp_for_each_object(old_patch, old_obj) {
 			int err;
 
@@ -799,6 +846,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 	klp_for_each_patch_safe(old_patch, tmp_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (!klp_patch_replaces(new_patch, old_patch))
+			continue;
 		klp_free_patch_async(old_patch);
 	}
 }
@@ -995,11 +1044,9 @@ static int klp_init_patch(struct klp_patch *patch)
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
@@ -1193,11 +1240,12 @@ int klp_enable_patch(struct klp_patch *patch)
 EXPORT_SYMBOL_GPL(klp_enable_patch);
 
 /*
- * This function unpatches objects from the replaced livepatches.
+ * This function unpatches objects from the livepatches that are replaced
+ * by the new one, see klp_patch_replaces().
  *
  * We could be pretty aggressive here. It is called in the situation where
  * these structures are no longer accessed from the ftrace handler.
- * All functions are redirected by the klp_transition_patch. They
+ * All their functions are redirected by the klp_transition_patch. They
  * use either a new code or they are in the original code because
  * of the special nop function patches.
  *
@@ -1214,6 +1262,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
 	klp_for_each_patch(old_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (!klp_patch_replaces(new_patch, old_patch))
+			continue;
 
 		old_patch->enabled = false;
 		klp_unpatch_objects(old_patch);
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 361a091..b03cfc58 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -18,6 +18,7 @@
 void klp_unpatch_replaced_patches(struct klp_patch *new_patch);
 void klp_discard_nops(struct klp_patch *new_patch);
 struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *func);
+bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch *old_patch);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
index 2565d03..fb75fb6 100644
--- a/kernel/livepatch/state.c
+++ b/kernel/livepatch/state.c
@@ -49,17 +49,13 @@ struct klp_state *klp_get_state(struct klp_patch *patch, unsigned long id)
  * Checks whether already installed livepatches modify the given
  * system state.
  *
- * The same system state can be modified by more non-cumulative
- * livepatches. It is expected that the latest livepatch has
- * the most up-to-date information.
- *
  * The function can be called only during transition when a new
  * livepatch is being enabled or when such a transition is reverted.
  * It is typically called only from pre/post (un)patch
  * callbacks.
  *
- * Return: pointer to the latest struct klp_state from already
- *	installed livepatches, NULL when not found.
+ * Return: pointer to the struct klp_state from already installed
+ *	livepatches, NULL when not found.
  */
 struct klp_state *klp_get_prev_state(unsigned long id)
 {
@@ -85,23 +81,66 @@ struct klp_state *klp_get_prev_state(unsigned long id)
 
 /* Check if the patch is able to deal with the existing system state. */
 static bool klp_is_state_compatible(struct klp_patch *patch,
+				    struct klp_patch *old_patch,
 				    struct klp_state *old_state)
 {
 	struct klp_state *state;
 
 	state = klp_get_state(patch, old_state->id);
+	if (klp_patch_replaces(patch, old_patch)) {
+		/*
+		 * If the new livepatch will replace the old one, it must
+		 * handle all already modified states (cumulative patch).
+		 */
+		if (!state)
+			return false;
+		return state->version >= old_state->version;
+	}
 
-	/* A cumulative livepatch must handle all already modified states. */
-	if (!state)
-		return !patch->replace;
+	/*
+	 * Two livepatches with a different "provides" must _not_ use
+	 * the same "state->id".
+	 */
+	return !state;
+}
 
-	return state->version >= old_state->version;
+/*
+ * Refuse loading a livepatch which would want to modify a function
+ * which is already livepatched by a patch that will not be replaced.
+ * A patch is replaced if it has the same provides id or if its
+ * provides id is in the new patch's obsoletes list.
+ */
+static bool klp_has_function_conflict(struct klp_patch *patch,
+				      struct klp_patch *old_patch)
+{
+	struct klp_object *obj, *old_obj;
+	struct klp_func *func;
+
+	if (klp_patch_replaces(patch, old_patch))
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
 }
 
 /*
- * Check that the new livepatch will not break the existing system states.
- * Cumulative patches must handle all already modified states.
- * Non-cumulative patches can touch already modified states.
+ * Check that the new livepatch is compatible with the already installed
+ * livepatches. It must not modify the same function or use the same system
+ * state id as another livepatch, unless that livepatch is going to be
+ * replaced. A replacing livepatch must also handle all system states of the
+ * replaced livepatches.
  */
 bool klp_is_patch_compatible(struct klp_patch *patch)
 {
@@ -110,9 +149,12 @@ bool klp_is_patch_compatible(struct klp_patch *patch)
 
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
index 2351a19..ef70ff5 100644
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
@@ -496,10 +496,10 @@ void klp_try_complete_transition(void)
 	 * klp_complete_transition() but it is called also
 	 * from klp_cancel_transition().
 	 */
-	if (!patch->enabled)
-		klp_free_patch_async(patch);
-	else if (patch->replace)
+	if (patch->enabled)
 		klp_free_replaced_patches_async(patch);
+	else
+		klp_free_patch_async(patch);
 }
 
 /*
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
+			    klp_patch_replaces(klp_transition_patch, patch))
 				patch->forced = true;
 		}
 	}
diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index 16aff8f..69e5a69 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -9,6 +9,10 @@
 #include <linux/slab.h>
 #include <linux/livepatch.h>
 
+#ifdef KLP_OBSOLETES
+static unsigned int klp_obsoletes[] = { KLP_OBSOLETES };
+#endif
+
 static struct klp_patch *patch;
 
 static int __init livepatch_mod_init(void)
@@ -50,8 +54,6 @@ static int __init livepatch_mod_init(void)
 		funcs = kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
 		if (!funcs) {
 			ret = -ENOMEM;
-			for (int j = 0; j < i; j++)
-				kfree(objs[j].funcs);
 			goto err_free_objs;
 		}
 
@@ -72,15 +74,19 @@ static int __init livepatch_mod_init(void)
 
 	/* TODO patch->states */
 
-#ifdef KLP_NO_REPLACE
-	patch->replace = false;
-#else
-	patch->replace = true;
+#ifdef KLP_PROVIDES
+	patch->provides = KLP_PROVIDES;
+#endif
+#ifdef KLP_OBSOLETES
+	patch->obsoletes = klp_obsoletes;
+	patch->nr_obsoletes = ARRAY_SIZE(klp_obsoletes);
 #endif
 
 	return klp_enable_patch(patch);
 
 err_free_objs:
+	for (int i = 0; i < nr_objs; i++)
+		kfree(objs[i].funcs);
 	kfree(objs);
 err_free_patch:
 	kfree(patch);
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a848..9aa1a02 100755
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
+   -r, --obsoletes=<ids>	Set the obsoletes ids array (e.g., "0,1,2")
    -v, --verbose		Pass V=1 to kernel/module builds
 
 Advanced Options:
@@ -159,8 +161,8 @@ process_args() {
 	local args
 	local patch
 
-	short="hfj:o:vdS:T"
-	long="help,show-first-changed,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	short="hfj:o:p:r:vdS:T"
+	long="help,show-first-changed,jobs:,output:,provides:,obsoletes:,verbose,debug,short-circuit:,keep-tmp"
 
 	args=$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -189,9 +191,13 @@ process_args() {
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
+				shift 2
 				;;
 			-v | --verbose)
 				VERBOSE=1
@@ -857,7 +863,8 @@ build_patch_module() {
 
 	cflags=("-ffunction-sections")
 	cflags+=("-fdata-sections")
-	[[ $REPLACE -eq 0 ]] && cflags+=("-DKLP_NO_REPLACE")
+	cflags+=("-DKLP_PROVIDES=$PROVIDES")
+	[[ -n "$OBSOLETES" ]] && cflags+=("-DKLP_OBSOLETES=$OBSOLETES")
 
 	cmd=("make")
 	if [[ -v VERBOSE ]]; then
-- 
1.8.3.1

