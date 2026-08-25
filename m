Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7DE38399C
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658441; cv=none; b=Wb99WytzxYoZhavU685pDFvIM8197imF5/vua03/OL00C64LRGLSQAEN+cLDZIuxKDf8xwPMNBQhc/qKB81fYy9FyMsbgorJ7uMfgJyToGJt+js/pPTYmelj1L5U6ew8AlSJgqwFoSl6UKouZVVRsYilvH1In3VkQosrAZgPnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658441; c=relaxed/simple;
	bh=lx5vQPWBSAJhVC6yBk8p9BEpHzLXJANQxxpF2E/rVfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svsNqXJYgC55I5h8+LOFGgsFb9NHkQmm3uDm+PVRBdhaeCUVyaW8FSY3S/xX8k8Mhq+fquXkBOac/IXAWirYgfqNqY5drs7w322sB5iXs6cqHthrXEtgau4c90SGQT7OVHn4mjCl3nJEK+mtdjDoTPa2nR4xb7IgNSL20xddDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY1UGVGv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY1UGVGv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so4748710a12.3
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658440; x=1788263240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fuFxsTTJ6Eo5Y3SMXP8pC9EUozannRuQ8du9LVvD3HE=;
        b=SY1UGVGvHS6rE5AW9NvaaXW7D8UK01rQLxdu4XBnyR0zrbc/pyrAqw3Vvu+J1KjIoD
         k0/Wmn0NcrF+bfmh+9lk/pQq00YguM8+0Lc6qCI0+/q/XxMJtbQDlcKgY8gnoW7s4n1B
         b8BHAMnKaTHhJHgUVVd/gzYp9SwwE90GdBTn32PEzBiSijbobsvULrrYDUnAIOblfFR/
         2L+rjkQPyDJ9yIPbGnysTZqdSWzDBaCsDZnw38//tR2NYiY9mDX+rs93iun99ilcbQ1F
         +XlnmdRkRxs4KE84VTscf1upMyS7b6bqCdeDZO24wSlLQTl+Jx3BV4RWEbr3sAF2wt04
         ezhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658440; x=1788263240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fuFxsTTJ6Eo5Y3SMXP8pC9EUozannRuQ8du9LVvD3HE=;
        b=eh43B02duM0vHZRFwhCM5sYrx0+oK+uoSbiHTDHgoR/ytO2HbxDuslifJkEmH3lbIa
         xPtCVHqjM7Cz7q83bBS6wfSa9OrG2Cpn/ZUUV3dLeFLOAib1smTBPq6JqNDqZrHlfUdf
         PQVCO5qP9KjFw1+35BK+CrTFrT8oiE7xwq1CeL+j8VEBBkHhflHYg+3xwWp6F4Igm44I
         mreva4pS1j4vR0HvqDaDBGsvZulMHRdXnx/rXPDEcQpoetzjcVTraPc4q9HEilKWtO0Y
         TnjVLSI+ia8dKICkWEq4baDQIh97GwL3LRbCLCsuAtHTydpMGzAMy9Hv7fZMLwQtzcwf
         8Meg==
X-Gm-Message-State: AFuF++kTKo4huNizkHPtpqAbvqpc7ttkDY9Ycg+JKuzPdYG7NxZzUM+J
	jeLAIyJfHEWceeiOLRQNx6GgOIHZeSk7omXvZaoCl8PYPEbzUVMqxGYR
X-Gm-Gg: AR+sD1008H7U3TkwZaG0xeIsanf5AiyHBZIiFIQcYQS4xjajXPhlrPUCpTqulhMqVDp
	Ampo6g6eAgw+8XY8MraRx2nNN69c9/x76DrEqQRWupsh04/SFSxp2h490tl4CdUvuFeN9Jfd59A
	zLztSkk2rv0NoKQ30DBtAeFd47cNIuucqoN+qa1ApFIo2RZAGOGQ1an6FZguX5W2QO+Afcb7rQy
	eTQRMqZhXvA5w1UKvMyA+TRuY7EPvpMqY0Bhn69XaxvQ8FRqj5qaW6x3JQVCOri0IeVopMPpUWE
	muH1FwwDdj1G4wrHTZO6OgqHjDYBsu5YY1ceuV0ldQAW3wRBQwLeC7nyDlGn7dzi5ZNRdR40APz
	ITS4rj23wivcbFG2PIbvj0lfq8zXEYyhb0E6snYRKfeIbxZX4dYZNFprJXA6t+QGd4hR9NY6gKj
	lz6BIY84KdSg+ink5JJ2fAOtVJLjc8B/5cK5qtBgkLL8ECQWXNP6cAxP3JWL0fGcdIkuisX5wiB
	QedE96B42M9XcVj6H1H1bE4hZCYtBh6GySfTwv8
X-Received: by 2002:a05:6300:6bce:20b0:3cd:99d2:d534 with SMTP id adf61e73a8af0-3cd99d2e64dmr4454240637.3.1787658439742;
        Tue, 25 Aug 2026 04:47:19 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.47.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:47:17 -0700 (PDT)
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
Subject: [PATCH v7 for-next 4/8] livepatch: Deprecate stack_order
Date: Tue, 25 Aug 2026 19:46:37 +0800
Message-ID: <20260825114641.80452-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825114641.80452-1-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
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
Acked-by: Song Liu <song@kernel.org>
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
index 81e9d7aa1de7..27f3891176dd 100644
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

