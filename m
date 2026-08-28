Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB53375F6C
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921599; cv=none; b=MFN9Yl+KRleaJUeVT49IFKTwL84whX37+aQvVyG7+aEQqRTwfPtXbyutzqUrRSvL8UYoZLn7Z+yQaPYWwk6kMaWbfW+9J2cg8w8dBixLnn/EDwZ4quwAjZZYiUI30RvF5qGHYvqAA2mbDkmdb6rGqpPgKOi+crEi7j+Z4PW9kD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921599; c=relaxed/simple;
	bh=V0ipTN+VU79Og/6q2/gAEwUlzAwaDu/FYOvOr67v5xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/h5xV1oOZyEQhbM/HAIJ3+Wobdjk6oWZwpK1g6W5HDlrPh4ikzv66kGv7o/X5MrWkJtXaTsYmvVwdfGncJ56WK2I5OgLqMg9wTNPOwHg0IuASerw+c2SKwC3EuvDPZMF/xEO0EtBZXhpwL9nFobvjKkAUcnBMZuGlGIZYCGixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QDiIl5d3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QDiIl5d3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482e4998d28so662045f8f.2
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787921596; x=1788526396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uR95rA1nKl1NfVCak0CwmavJwAucCU+eKCmA3x7lsk=;
        b=QDiIl5d3rLxm2pd43bIh2D9mf/2Znq2xvaraH1J+WrDVfcNYCWbrAWEb1N15dQkjNK
         Ckq1wHhfK4PH6+JH/jrNJ6CgxQqYXvlUK4PBbLIPeAZfNa8pVKnMpIfb902H7EI74p9X
         EcxJC8NtBL9Gmxvc17Bw5YL6t4o0H9jhee9JKN21ensUw4riwDEAD3y3z7GjrVBVteoJ
         1kORkmpO2B1bCkF7Hya9MH4DpV9FgulmP/SFkV1CDdqWiBhYzuFkOiHA0B/NWZ5nQ/94
         O8yrhdTypZUo/1CMv/Tck/CEJpnaktOPydKZIQZhwpJK5Ngb0b03i8TWK6kDpb3C+toW
         Kb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921596; x=1788526396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uR95rA1nKl1NfVCak0CwmavJwAucCU+eKCmA3x7lsk=;
        b=JLA1AXCxyBEgbIc6VmOJ7ZLagFvlrVBbjcVxOvcvRiviGd/RScHEu+rkhKrixD/lHW
         PvVihHFVW5ZZMpTjOwVfrWImSZDD1iHbeJe7KXJrzto535VUKNX7qKQ87bax8co1iEw3
         Vh+BmVsK71hqPQWO9SDhwn9DBgZJBw/ltAowLKo6HkNkl14zG3iCDliy5GGITIbTyVTE
         0FI4wZNqaKYYbeHpL5RwDLfK232fdIKkOxsAJLM6hdG3PvUZx3sbTEXeYr0lmc+9PkfD
         XTAJ4hOR817bWBLtENJL7fdqCZC/Q7ikz7KIV7xI7rb3w7l2ENGAATGzKusdemrGqYoK
         NiFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaXwlxbGSlJVb8s9F9937IGMKQRr5qGoJ4eDdFFNuNv5PBRMHbQH1epVWojxKuLtE/qaot49vDdWVD2wgR@vger.kernel.org
X-Gm-Message-State: AFuF++lESvGS3GwwXOZGBaB7V0YPr+gIytpVoTOp78OuvUaBFBSLdCb9
	Ya379pmyes3XR0NlareyqKzoKqFCNpwPh7UafRYfv9eHHBoI41eTz1DhpQq0VzTL37I=
X-Gm-Gg: AR+sD13dup9Hf6WBpdXOUSimI50aC2vWnfsr4wRp/bioCMGOhkQwr9dSLBKa7PuObpP
	a6pysxzbun5kavdFcaR3jmDa1laDDjr1iRMAEt5/FEnYTdpKV0EzeQ5wqrR1NSDAnsTykM+4gMD
	ULT8mP0GLCgy2hj1MeOg1wYTHHYowO3TVyjR0ECyvowcOSTPvYp/2viwwlfeUS4PXRj1NKlf2zt
	kDuNqE3Wc3ovRBNUZvkB7KXdXcUOtZjlzXEVnRkT/k8tC/cJAXuLvx8ZlT0BGkLXJQ5xT4YGyeT
	EJx7BfhjR5NuSOACwLdv3fxnOvRfwkq6CBmGeGzDpRCEYTDiXWQoqimF89YClg9HV69pUXDiSqL
	KDxMUG4s8Elf8bQ/p+RZ2nb5nHDDfYP+oYDixLAtpCJU0oZGY+LYei1mZfHEYw+EqEQJYRVRQrt
	lbgdlomn0osCXgOjLXUs+Enkt+mX4IMj10DotLEHS1+KoRwuIT+ityHmSuzxVNZg==
X-Received: by 2002:a05:600d:8449:b0:49b:96a0:5c00 with SMTP id 5b1f17b1804b1-49b96a05caemr58644285e9.13.1787921595899;
        Fri, 28 Aug 2026 05:53:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92695e52sm41405875e9.3.2026.08.28.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:53:15 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] livepatch: Move code for updating livepatch object relocations
Date: Fri, 28 Aug 2026 14:52:43 +0200
Message-ID: <20260828125244.509977-2-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828125244.509977-1-pmladek@suse.com>
References: <apBbjoEHJ98DWN_W@pathway.suse.cz>
 <20260828125244.509977-1-pmladek@suse.com>
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
index a3b377a3f47c..cdb25949f73b 100644
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

