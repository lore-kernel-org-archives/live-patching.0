Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021863;
	b=XOK4FMaVbBS4O/7Es5Xy7lXqmN57Rs4et0uTuIO+LUhe73+Rb9xuFb3teAKu50VMdtdT
	 ADW+gkUhToruGbGXVIc3MqVWQPLxgVkDdBbnkzs+qYtUkoHCI5NQh2TLkC+9jXCszrMEl
	 ds8Nznx2y9i+Z2A3+Ks7OHoLh358J9NKab6wrLZsF/+ez9Qg4/mdoGm4xdXi+Y7uYvNI0
	 dTbJj53VOGLQcZafjqbmER+a3l7B1GQCsBHBKgQVLpEGWczjA2OzOxi5Vk50Z6S1nuFng
	 urgoNzgTY6Uf1mH4KpJOFnh6+hZ9eQpsJgp7kOBz7PhsUD+Wlc7qcKwZyPhNrApwlHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zj/SBhcU/0vQOmGdEfKAA4zUgU2LezMwuTeWXZs3f3g=;
	b=VFM6ClAk3D7Tf5ZrAZM1QCA9gFr9EVIVNt3d7ukr8dM6M9go9oHgNBc1xTmsJNw4Ca5S
	 9bLRcRBg60B3w9SOYbdDu0KwZpoADT0+jr6HkYdsh79aoD4zIVsLm/vzR3ZSdWjwEqw9T
	 kyx7/smlXr1Es+11OuhM0kEB2dlI9/9+/RTjFPGXqa5d9cmjMHA2jg89UIzCoh6VzzQwx
	 SrHJsWL3F0FNofNeSsWzxyAPi3WPHtCQ7pNnEWBD+kj7Lfc6S6DvmUnoJdLJcE+tmxR7J
	 G4mU28lGDfrPgSwXnOthnJ38cbfdDvXrQpLnZpY066PL7rXwrK7Gko/uosRiR3JKWIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T4sUtB9k;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C56072CF0
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 694C56072CF0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T4sUtB9k
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e977109392so17383105ad.0
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021863; x=1793626663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zj/SBhcU/0vQOmGdEfKAA4zUgU2LezMwuTeWXZs3f3g=;
        b=T4sUtB9kLzkCZ15+d9BcQMFQ72oayD3YrxwYB5DvTqMOkgURlyiatbwjaa2q33NP0y
         d3aWlFPdZ+7mqB/D7K3i46mAVHFH90QaP9WgCtBoJ1HiedD8jlp780Z2uhQcZq7CJkqV
         tYUzr9KRQkaTUJPeI6DCKe8cjOj2mtQs7cg91Ey1WTLmsfr9LMS8cLUStbyVeO6Ha+eR
         nA1X9mmdL/xgi/v8XtjPlSK+vuwDgatxWQCYeRlFBhy+xxxlqy4tXpeRzY5SA65zX4jI
         KGp7oDyFB4pdJhrxKIC5m9/jzIJ8Vmq0j3jjDGWZUkG17eb4PYknYiLmOeR1Wd6Pp/Cv
         HCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021863; x=1793626663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zj/SBhcU/0vQOmGdEfKAA4zUgU2LezMwuTeWXZs3f3g=;
        b=dm4SV9BhHI47M0ppGAgMWdqItBmOnJqYuY9Vq2JDUysW1lRWk3MdeiBJ4K85foYl5i
         1mvVEcLJLuFWfQejEx81NBPzIN3Bzu9uyj5hwShSS49EvuxQqV3wO17779IFJZDZE/ZH
         V9pcGrxmnbI8MZXkJZf1+zV04ey9KwQH4Pu8+ieJHPZ0zmEstDKRGfeCr4x+4+nw4CW3
         X98ahqYU7JEZM5R0NaiOKCiGJOHLxcRSs9wQVekgPe36do+MxxNPRv4Uu+Uecxz+dAVh
         SBqeoc2iveHG2eK8bVEzMN+HIcESq02rB0EEoPtdUs77dgsXeTQutYjk3J6M04e7EqZT
         kimg==
X-Gm-Message-State: AFq9FYIYfZIH7JnYIDPrIbxkQt57HA6lyJ1TLWNMNBZL3LfgvVjNgGPL
	fzrAwWvyI2qlzC1jUGhsERz6TCcfi/HscCZ9e2kk0oVRnIaEnQCFSl7x
X-Gm-Gg: AYBFou0raECMPW5Fx0yf/T496QNOm6xPOdAaNRSWvnWYt2KYuXhWqRcU23zT2MdGxlC
	y0raEFZDkOPG/N1DLU6TwOJxi0m4X6qu4e3IQU+ZkFaaZj9vE+Huh342xY5pzzOuCxOfRF1CbKb
	2w9v9lFRZyWcAiDxpqXedRNf9Hacs+BL45pewuHpSb0Gl8NtmDpzwxVUOnOKUUPvfKv0OIiRWik
	nZEOu+HsvmmfDbrRN25v1QornBv1wSZXgX2fvNmuiKldPf8YFApsTpoAtFFpJskAfHzYuTrixsV
	Pnm8Xr6xJ2RBbhLFkSrHp1EqhYlmLreMAX8HfZAS+GJuiepzbdnXM8rIDTZTT2/ZlyQiaN1ifqo
	AAN+DkqAlUOXphL8aHxMwWTyEzacBZqUYMtQ713V7rm5cCqMqufSpSl+Y8VSwNhpXIkpI1NO93e
	4qoKYXOioUL390f2qCoKlUlZcq+/ncNeNUvUF7F5nVFrmD78yM7bsbEOewGrMsBYSyJOW1vf/WG
	cnkwuvoTz+i0DnKthL+gKDSThVBvltwh6zcmsThpO/sTrIHyCTMG8oNCsI0UOMCql2uV3XPFK1U
	tJdi/m70OFu0+9xLrE1FQNIj7agP7mLFb1w0uw==
X-Received: by 2002:a17:902:d551:b0:2e9:4b32:fc6c with SMTP id d9443c01a7336-2ea9c69f27dmr59088565ad.26.1793021862714;
        Mon, 26 Oct 2026 06:37:42 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:42 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Wardenjohn <zhangwarden@gmail.com>
Subject: [PATCH v13 6/9] livepatch: Deprecate stack_order
Date: Mon, 26 Oct 2026 21:36:48 +0800
Message-ID: <20261026133651.40061-7-laoar.shao@gmail.com>
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

The stack_order sysfs attribute was added to determine which active
livepatch is used for a given function. It is no longer needed because
recent changes refuse loading another livepatch which would modify
an already livepatched function unless the new livepatch would replace
the conflicting one.

[Commit message authored by Petr.]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Cc: Wardenjohn <zhangwarden@gmail.com>
---
 Documentation/ABI/removed/sysfs-kernel-livepatch |  9 +++++++++
 Documentation/ABI/testing/sysfs-kernel-livepatch |  9 ---------
 kernel/livepatch/core.c                          | 24 ------------------------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/removed/sysfs-kernel-livepatch b/Documentation/ABI/removed/sysfs-kernel-livepatch
index 87d57ba..f094bd1 100644
--- a/Documentation/ABI/removed/sysfs-kernel-livepatch
+++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
@@ -5,3 +5,12 @@ Contact:	live-patching@vger.kernel.org
 Description:
 		An attribute which indicates whether the patch supports
 		atomic-replace.
+
+What:		/sys/kernel/livepatch/<patch>/stack_order
+Date:		Jan 2025
+KernelVersion: 6.14.0
+Description:
+		This attribute specifies the sequence in which live patch modules
+		are applied to the system. If multiple live patches modify the same
+		function, the implementation with the biggest 'stack_order' number
+		is used, unless a transition is currently in progress.
diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index a9d4893..b8cf1977 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -66,15 +66,6 @@ Description:
 		loaded, any existing livepatch whose provides id matches
 		an id in the obsoletes list will be atomically replaced.
 
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
index 62fc215..e31d011 100644
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
1.8.3.1

