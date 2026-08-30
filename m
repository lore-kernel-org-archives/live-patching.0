Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FA2EC0A7
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788111241; cv=none; b=rO6zLJxjsmT57KonwmpFypZB2d6/pbQVrdcwuRXe2ShhRH4/6SdkdoP+I1ey5T4EB456p5eh5CpBKdJZOvsQOGQb5+KWSCRwlDslcmv5Aj2OTDDaTzB8EmImDw2A3o2pS+o+V9TEHx8kGa3V5mZA2LQFqLEWNxchYHs7jkaUhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788111241; c=relaxed/simple;
	bh=JQtLJ4B4xGi9RbJQfiBzfWbJpI1166z6juWdKP7ddh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv8W/6NISFqSLoTUiRo5fEjhkXi7ESx8MtSWrZcfzx08pXQfrvzw8oi334y0xDUmRRF9VylXi26n/s0ThUUyj2dJuPmpNjd5UEqtsSxvi4wNCCdpRxLf33yTIphibPxSO9/36jukk5g40hltMSY2LmnCBvy5NpoXwrGMBl8JoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqbD3NIv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqbD3NIv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2181114a91.2
        for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788111239; x=1788716039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KElhGwb7qyJUiQrdOeMIsu3TKGiuI6DnUOH7u1OvrE=;
        b=YqbD3NIvXvoA3UKeI7aXgjvdt0NkrUObpTm1cmIa04Bz/VeE05EHSLA1N6K3+1gfYH
         t8I4izSscfj+ZIvbH++2nUC4yLTVPTm5qyTm8Y9q2S99fT31uzN+FdFhMKoYk/HOpH0B
         ZQK9tnixQzH9seK6yNxeNXdc4R3YI62GqRYBKmVq1nbMkWQXM9GuG1fzAHw0lbFEW6EX
         Wghuj5XzxcKf5R/vPlycXX91AxYDoJoryudLgSOpVGnXTea4L7+qxLMrWPiM3WXBBqq0
         H1cuRRmxN+yleALWQPIz3kk4lo07o6Pg2npMGovwW2lxbeECny8VYqVgi+zZKBT/E+dp
         Zgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788111239; x=1788716039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4KElhGwb7qyJUiQrdOeMIsu3TKGiuI6DnUOH7u1OvrE=;
        b=MEEkf6eqjzTMJMGdedzKwWM0M3tHxbm7v2NDcOT2xiZ+hjBfYLiKdQ4YjmBvcECM9e
         bLAy/+ktrFxi3R5zUgLG/NVWvcfULZApDYQHG3bzilWOJS4r8WeTE2h+DJfL0kzvfNt1
         Lsqv8uEF9SAI/iC/HgWdbasOuJm6h2EhG+QpIbUd3ChhrhRU11P8yxXqCigRCZi74NZK
         zcTi8fK7f0LiTbsPeG+KNHXYGM5GJk/SBExzjU8xmSufAUAwkhAJsIV5vhG3rtak6jDS
         r+hlvfitRbkgNmo0Jj6qKaGpx3NO7TFff+7mVUY1M3o8C5pGqDYT4IIipzmhZURbA8al
         9t0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxVMhJVQ3fE7AIaWAnSyF7pQUU4xtLaQMqKMjz2Ve0LgNLUrgMxqKjvcCsQOAe/i+usF5bcynFYAZFC+mh3@vger.kernel.org
X-Gm-Message-State: AFuF++ngBZPFYib8RKwz2E5bqP/LcGa/V4DZGk3EDoYkFC5cSG0HnP54
	gNFmtDXWWAgbmz0gBOCn7WQeQDTgQbL1kCEGaFuREOGdnn5aTgpcOvg0
X-Gm-Gg: AYBFou2Fi+MKl/UZm27a51dmShAt/Dg50UGpUBRNdTiT+r9e2gwfQE9XnAdIABgjWr7
	uq+pi3qKxmZKG06C8ddZgzwx2jmsiSAitf+SUvch9lvuUVojOAoTSZLicW1eFv5BnvDFCQLKLDM
	Q4oPJ3Atu+ZaPMUNeBQkYox1pyDtp9yTppKysv4iA3Ibcel0JxssbfX2uPQ//GA5WiULGbtgtkF
	38HCz+iWo3+CJ4oFRIxEy7BEBjfVlVu2CxZM0FxM19IudW+qS+zz0StKtpjR7LrSinIt7AZMtKm
	x89VGxwnnTGwDe1w0UYsq5v+gr0XSkgVbdvtVo0FdvW/hSi65TBDzKsfsA5GY2In/LA7CPVBtev
	eNffJ9pTaHEc5Pf3SgfqzaQCebPfVNTHAsu+Oj7wWUOyguOIsFcrCSzolLjVdKsxhmTsUHmPzUR
	XHYA5i+GtnPFIW37u2qcEDIZZ01J09ueIMVOnhKmYTWuXSI5cfBYkKcHuwoELF3bCl5OedBzK/t
	Qathn5b6oE2erXjApXf5XIhc7Nn5Io=
X-Received: by 2002:a17:90b:1d83:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-396d1023217mr27801427a91.14.1788111239411;
        Sun, 30 Aug 2026 10:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2407:4d00:6c05:13e8:a91f:d3ab:5c4:f6ed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186809dsm17237749a91.10.2026.08.30.10.33.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 10:33:59 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harry Hsu <x90613@gmail.com>
Subject: [PATCH 2/3] livepatch: Move code for updating livepatch object relocations
Date: Mon, 31 Aug 2026 01:33:07 +0800
Message-ID: <20260830173343.52759-3-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830173343.52759-1-x90613@gmail.com>
References: <20260830173343.52759-1-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Mladek <pmladek@suse.com>

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
index 0dd8cda5c9b8..aa895e8259b0 100644
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
@@ -826,42 +862,6 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
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
2.43.0

