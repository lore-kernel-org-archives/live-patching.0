Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50E3CCFAF
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788111244; cv=none; b=tObOFQMPlogqSw4qZmMmwdiQGMzFfiIDimvpHE4xhkZ2lDQ9OISVs8+Cw0DSgWPbWAVfB8DPX/HYcm6iL+wLh9aV3cxS68cM9jBMFmdiPMO2ji0Qqd1u+wpQQatHes4N2oxZY3OY1jDEjKRsGoJJC/MJQyJbHvGgZpFHeMoNoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788111244; c=relaxed/simple;
	bh=350E+24cgIQPrkNeuQvH0zUzV5ibQBMEBZPP3eO8cUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kujsl+2Y8HC54tNhq/ZEoKwOijlhf1l9UXwT6u/6u2ccIMQpcbXF6f8AZWSCgXJ9PcDTJT52qmZmFtJY7oNQqWUyo9IcWa2STRIw/paJKra6zXgyoA1Iy1A3FVJMasbEvyQRZIHstSzUSOKOuQn5gIEfSaze0RlRHVQ+khm/V2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=megOhzs1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="megOhzs1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2124589a12.0
        for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788111242; x=1788716042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ns3vlUtF6VYFQyrrstAS/BpbWDETkTxgnU62R5+4dgY=;
        b=megOhzs1jqFkuowHlEtJod5YHZ0uGjw31R+j4yx5IbMDZxc6fuSJqMOES2pb4FR7rg
         I44IoD+UX1VSKdx1lJNQMs5zZkzRK0yPB/KkC+EsdIk4t9Dm+2wQf8AM/sjBMAmHYirC
         dRESoGIb8/juTskpFbQ92xWvReUPU23RqXnjYygwZoBeabijX9b+uSqKoGjJnW+Jm9Dq
         Crlp4VCj0UalE6/l+n52zSnAjfXYfisWO6/Xon3JQ3Op/G0p/v8VJW6OnqttHfmT0dG0
         6FSKLKGcxXFpxY8JuZ9i8F7YFicyvnvRR9eIUuHyq8rDq2JEt1R4BFrHfEp9T4i/NyEe
         MmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788111242; x=1788716042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ns3vlUtF6VYFQyrrstAS/BpbWDETkTxgnU62R5+4dgY=;
        b=Kc/rh3V6t/a9tqaUWqWXBpzJ7RSkLPyDrfTB1aWSpGgpcedSUPXvzsmH6Ffa6F/6Lb
         cXgHpB7+iFHqzm5yvxJpGjnc26CAYcsPvllEyemaHE9l19RVOdymmGmmkDQgjn+G8cZV
         QYMMsVA4ZzkL26yPsbrvUoYkUgE3LlK/H1KzW9GaoYGB8HGkL8aw53IO8WjSk9k+/+a2
         LCcplVCjYwjbwOiYmhcjwfTEaKI7sKgeDJPU+khvJRoxiQHSoy7Ni/BQmlZKZfw9gMUO
         sGEFYn+c5pMBteHKLuGNoRpgIGTXWAGoXyC7bOQ7dQVoPLyP6vgV6ZmyOFG2jhKXNslG
         Z7ag==
X-Forwarded-Encrypted: i=1; AKwUvBxY9g/QG3t6WASloDKd7GtrYQgxnR+Jukzohmat8rv9YYuPNP1f/t5QGcjoweoGG4Y/BOeCfnJXkMg14F09@vger.kernel.org
X-Gm-Message-State: AFuF++kzROZclcUAus9BoI4ufOHVtW7FDRhmbHL9zCCpteM4M1bkjSX9
	FsX/fHK+PL9qKd3vYSpTLgdECtP3vxtnjx+0xr08mPZKfV50PZ5XQxZi
X-Gm-Gg: AYBFou1BSU1itnPIeD3H2AFT7hDuYR8u3aWFZESMWdPQHh2YSOfU9eMRCAe5guxqmV0
	8FPOSNouYcvNOz0ZnJlrLD6lwvAVqcrLmMuVLUDc0SwfwaXUj+umQIURmUQW1Ob25UKOdmGoMyO
	A22wOdPzqNcJRuAAaQYWG2YhuBRmMCK/YO4eUfJEkdx3KLoSqu0/Kvz+rkENUGKY1IPv/ju4lu+
	k2EneG6QYV8xDxtpDAXdBiLseg2LqwXyuLJyzTzNTNb0MtHJi0k/8DFTRH9pG+X6lhygHSRdUsx
	1dn56vU4cz1tRa5KdVnBracnY4mDb14Pu5Y09Z4CXSImhImvOYVLNJ9CnHnkrgr0p54x2EaUv1Q
	9sFK4BnrVLUQaaYxmzwmzQC5P/4eQKdkkZgJjUT46uQaFE7igVpuWuJUMhM/KsXZmbFrs7PlNmw
	AQuLtfWe6Xptv8d/LsdtCcIrXEJ6WGjaOz0cVYbnCg7dWSsOzJd3YLlS1YblsdQjdUnsVcMPFyk
	gpY/jOZIr1JxmQLFKv6SA==
X-Received: by 2002:a17:90b:534b:b0:398:ceef:edbd with SMTP id 98e67ed59e1d1-398ceefee8emr6899772a91.18.1788111242577;
        Sun, 30 Aug 2026 10:34:02 -0700 (PDT)
Received: from localhost.localdomain ([2407:4d00:6c05:13e8:a91f:d3ab:5c4:f6ed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186809dsm17237749a91.10.2026.08.30.10.34.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 10:34:02 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harry Hsu <x90613@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH 3/3] livepatch: Clean up klp_init_object_loaded() when fails
Date: Mon, 31 Aug 2026 01:33:08 +0800
Message-ID: <20260830173343.52759-4-x90613@gmail.com>
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

When a module is loaded, klp_module_coming() iterates over patches and
calls klp_init_object_loaded(). If initialization fails, it delegates
cleanup to klp_cleanup_module_patches_limited().

However, the cleanup loop skips the failing patch. Each function called
in klp_init_object_loaded() is supposed to clean its own changes. This
works except for the changes done by klp_init_object_loaded().

The current code is a bit messy. The changes done by
klp_init_object_loaded() should get cleared by klp_free_object_loaded().
But this function also clears obj->mod which is set by
klp_module_coming(). And relocations are cleared separately.

Fix the situations by updating klp_free_object_loaded(). It should
revert all and only changes made by klp_init_object_loaded().
This requires some shuffling:

 + Clear obj->mod explicitly in klp_cleanup_module_patches_limited()
   and do not rely on klp_free_object_loaded().

 + Clear relocations in klp_free_object_loaded(). Remove the explicit
   call from klp_cleanup_module_patches_limited(). This requires
   adding the @patch parameter.

Finally, call klp_free_object_loaded() in the error path in
klp_init_object_loaded().

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.org
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index aa895e8259b0..4fff00a40d88 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -725,18 +725,20 @@ static void __klp_free_funcs(struct klp_object *obj, bool nops_only)
 }
 
 /* Clean up when a patched object is unloaded */
-static void klp_free_object_loaded(struct klp_object *obj)
+static void klp_free_object_loaded(struct klp_patch *patch,
+				   struct klp_object *obj)
 {
 	struct klp_func *func;
 
-	obj->mod = NULL;
-
 	klp_for_each_func(obj, func) {
 		func->old_func = NULL;
 
 		if (func->nop)
 			func->new_func = NULL;
 	}
+
+	if (klp_is_module(obj))
+		klp_clear_object_relocs(patch, obj);
 }
 
 static void __klp_free_objects(struct klp_patch *patch, bool nops_only)
@@ -878,7 +880,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		 */
 		ret = klp_apply_object_relocs(patch, obj);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	klp_for_each_func(obj, func) {
@@ -886,7 +888,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 					     func->old_sympos,
 					     (unsigned long *)&func->old_func);
 		if (ret)
-			return ret;
+			goto err;
 
 		/*
 		 * Aliased symbols share one address, so they would resolve to
@@ -899,7 +901,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			if (prev_func->old_func == func->old_func) {
 				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
 				       prev_func->old_name, func->old_name);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err;
 			}
 		}
 
@@ -908,7 +911,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		if (!ret) {
 			pr_err("kallsyms size lookup failed for '%s'\n",
 			       func->old_name);
-			return -ENOENT;
+			ret = -ENOENT;
+			goto err;
 		}
 
 		if (func->nop)
@@ -919,11 +923,17 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		if (!ret) {
 			pr_err("kallsyms size lookup failed for '%s' replacement\n",
 			       func->old_name);
-			return -ENOENT;
+			ret = -ENOENT;
+			goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	klp_free_object_loaded(patch, obj);
+
+	return ret;
 }
 
 static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
@@ -1264,8 +1274,8 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 			klp_unpatch_object(obj);
 
 			klp_post_unpatch_callback(obj);
-			klp_clear_object_relocs(patch, obj);
-			klp_free_object_loaded(obj);
+			klp_free_object_loaded(patch, obj);
+			obj->mod = NULL;
 			break;
 		}
 	}
-- 
2.43.0

