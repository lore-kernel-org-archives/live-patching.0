Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5949EC75
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869059; cv=none; b=ESR0BInniIGrgvbMpSbhuqDwzZgWFZCd1LWduak1DATpcGDz3lUHbyTpuWVGABx55OOpWotUob2o+mgys1d0qavNXWzhRIAS7EBrcE0K2PVgNt2hoxlevQz4Zs8bBRNih2dRyFRPiwLGtjczVE9rDMTLTr4hCS8grpH5bKkM7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869059; c=relaxed/simple;
	bh=fuQOCFjP8UkL1Qqt1zyRFi9QdF7VSvTkUwrEl2/BiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbuE4Bbl+8m3bNPeHX9pksifyKtDnceiNLtA02U5fxQYbZe+Wh65Bn+DIQamyyFBxbISi7NlbAc+eeLYw8V7n0KR/W6MvIVSGwA5ooAfY8d8x0pij4E959Lql7q/SCeiYFnWxZhWNTjCDyo4PFh/k4WULs2MkkK2fywZrd9qQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fZ3rstIX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fZ3rstIX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482e4998d28so3633810f8f.2
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788869052; x=1789473852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Sj5DuG2I5WrYzkNIww4uEg16kFBgrgPS5/z1js5sn8=;
        b=fZ3rstIXQK39bJJqeN2HNAUYyjqG5Hcalr+gps03z4PvfYpcMCxfV/sR6pyOI1EcGf
         Xc2cUml4yCG/dNg7NNA0RJs2ZKhpB75wl5Y2mPJ+qIJoU7qr11/iVXYl/wJFbgG3cbEw
         sv8xKGY18PSuh4EAxQlaYVQrraLDI/8B7uyxGr3AKtIf49A5+mpfTpbuOZwcnxzwIZp8
         dHaKpCESJuPbXmDuIcrPIHviOC30Xxo6h5Tq8lv2XQwQJQ1ktzMTeHsRB00HWZEOd3qQ
         IlsrvaQvJKiee/zU4/ozrkpLDf/R4BlKOnjVYWXPEzex81GKz67OR33CP/5e1L2fvGdC
         qm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869052; x=1789473852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Sj5DuG2I5WrYzkNIww4uEg16kFBgrgPS5/z1js5sn8=;
        b=EmVWyO1GW07vmH5rl9429YIUwCDYHF2x2pWYr8zwQb7ntKbHAQxNV3p5KL+fuHk5iO
         sMRh044pZ3blltKRO7xsrZOgtGHxFvc2zs8g0T9sVOzUZ3wq/GBPkQq8vPG/Cqg3nfJ3
         pQZaDZtAxktj995Cu1B+O4UjIzP5QICSxnU9obZyUOXrrjCcosu7S6joZWGouAxFrbrI
         nCyrbSm0Qfky/eedHIjb0Q72h7rdAssdU2f2FqZCTaRRg8+cX11EfTEhbRONBJ92ZeoT
         KCBwQuCd8Pmrnj+8g0ZvfMprsvRdsgF3LOyb9/sQr/TQ2Np9ZRcIEgWeaahr8eFb60V+
         r1og==
X-Forwarded-Encrypted: i=1; AKwUvByuG5l435oHTS9J9TjWkRP0EG9ZKf+eI7lH5U4hGNGDnOUxd0eaoS+N34zXYCSV/IGimZv5Ar/OrWgvGvY4@vger.kernel.org
X-Gm-Message-State: AFuF++mkOyTDPAAetdCXfE/ffIPU+YTEZvkIPAhOb3hen0PJmNl7n/2m
	3AFh7BCnkAS36JfZAS4kx8AFAxq39DboPxrK+rRzB6kbi6iWIIOKUCTk56QgF37ipaw=
X-Gm-Gg: AYBFou0C7rNBVTKBJOvmbtT70ro2ezZahFRYPH2njlK17AllnYe6NXTs/Y0TUtCQKJY
	ZMn5Jse+lJv3YovwXS0zrDcZ+jHphSxvjQsKcIuzRzcP4IbdTpO2XnuowUbeyjXNpapNjTQfFkq
	1beVQMmEoZ1nF/yFKiJgBMyttyGQyJnoi8kq6kQrpWehBTPm/hAGyKKUCdd46OXOmX6rBhcG7IE
	e+/6doDwKLtgiUfLPyw8SBa8GwfKICN5OiJWi2w6j1LdbRQjfjjsfcy3q/Vb7IM/GssaS4zrxZU
	1x/4akzFHd2q96o4s+5usVRnlP5y8JXzmjGW5upXRC5aK6bwOJQI0K5XzMfRD7OZn9wJme9TZWF
	4rXH4JBk3tfftaNzEHgsPogflQcN1mXhQrJwvZJpIpCvnWIu7TZfw9qJ1fGRZrxhdce20+sp9hV
	8wJ1/ODyVRUhfuqbHx19OHM1S+Et55Tf1wDZZvwlk2hRFq3T+7Fbs=
X-Received: by 2002:a05:6000:220f:b0:485:8c16:a350 with SMTP id ffacd0b85a97d-4858c16a62emr27247710f8f.40.1788869052365;
        Tue, 08 Sep 2026 05:04:12 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm30329290f8f.5.2026.09.08.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:04:12 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	shuah@kernel.org,
	song@kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 3/5] livepatch: Move code for updating livepatch object relocations
Date: Tue,  8 Sep 2026 14:03:23 +0200
Message-ID: <20260908120325.299649-4-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908120325.299649-1-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp_free_object_loaded() is supposed to clear changes made by
klp_init_object_loaded(). It should call klp_clear_object_relocs()
which is currently defined later.

Move the code for updating object relocations up.

This is just a preparation step. No functional changes.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 72 ++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a6762cbe74b7..a6796cd6b65f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -342,6 +342,42 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
 					secndx, objname, true);
 }
 
+static int klp_write_object_relocs(struct klp_patch *patch,
+				   struct klp_object *obj,
+				   bool apply)
+{
+	int i, ret;
+	struct klp_modinfo *info = patch->mod->klp_info;
+
+	for (i = 1; i < info->hdr.e_shnum; i++) {
+		Elf_Shdr *sec = info->sechdrs + i;
+
+		if (!(sec->sh_flags & SHF_RELA_LIVEPATCH))
+			continue;
+
+		ret = klp_write_section_relocs(patch->mod, info->sechdrs,
+					       info->secstrings,
+					       patch->mod->core_kallsyms.strtab,
+					       info->symndx, i, obj->name, apply);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int klp_apply_object_relocs(struct klp_patch *patch,
+				   struct klp_object *obj)
+{
+	return klp_write_object_relocs(patch, obj, true);
+}
+
+static void klp_clear_object_relocs(struct klp_patch *patch,
+				    struct klp_object *obj)
+{
+	klp_write_object_relocs(patch, obj, false);
+}
+
 /*
  * Sysfs Interface
  *
@@ -823,42 +859,6 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 			   func->old_sympos ? func->old_sympos : 1);
 }
 
-static int klp_write_object_relocs(struct klp_patch *patch,
-				   struct klp_object *obj,
-				   bool apply)
-{
-	int i, ret;
-	struct klp_modinfo *info = patch->mod->klp_info;
-
-	for (i = 1; i < info->hdr.e_shnum; i++) {
-		Elf_Shdr *sec = info->sechdrs + i;
-
-		if (!(sec->sh_flags & SHF_RELA_LIVEPATCH))
-			continue;
-
-		ret = klp_write_section_relocs(patch->mod, info->sechdrs,
-					       info->secstrings,
-					       patch->mod->core_kallsyms.strtab,
-					       info->symndx, i, obj->name, apply);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int klp_apply_object_relocs(struct klp_patch *patch,
-				   struct klp_object *obj)
-{
-	return klp_write_object_relocs(patch, obj, true);
-}
-
-static void klp_clear_object_relocs(struct klp_patch *patch,
-				    struct klp_object *obj)
-{
-	klp_write_object_relocs(patch, obj, false);
-}
-
 /* parts of the initialization that is done only when the object is loaded */
 static int klp_init_object_loaded(struct klp_patch *patch,
 				  struct klp_object *obj)
-- 
2.55.0

