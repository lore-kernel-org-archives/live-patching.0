Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760485328AA
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869085; cv=none; b=ALFYUc4VjqChwaKDx4ztDp9j84E2LXW4LeLRvUi1sa2KHEgF+fk+cQrIRHOzpPOnbVXfWaHCJL917Gim7vBjul2UtDtt41SirpcQNMGIFOsjfr7gqCzy1cx6qcgHj8K0k0TjuM82JDj5Yrl5DRJJQMZnyjRv8ApTrigWPsJ3l0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869085; c=relaxed/simple;
	bh=DVuuPUwXLwtT0Ymk60JQVhNGfMYWdFufX5xFsm2SN0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxhT9GEKmdUUPjMqThyRtRnX4H7kIScc6JvGp0U/k2x/JVQ4RUe0YuT2j4HjIEJNKC75d16oyEHam5I8ErJgyvwz/Jb9atsZoBfCMZzLOcguzYpa91Gc6Rz0dbok+GTvWNtAxYz9LLT+VTFFeQ+DgG8Qd37vPI2qRkUDH82J7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AE4oPbrB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AE4oPbrB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so42947195e9.2
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788869078; x=1789473878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWdRM8KWaj2QeHMO2XI9aeMbB/7rTG7L5o5/mygY1k4=;
        b=AE4oPbrBXiKJIGNuH5An6h8EXwLlG/v3FDNKEj55VhC7ysk+7ZEJqfOqjoXXHN5YmF
         fo0Vpxb7sTdPzjwxttrscfAp1Yz8L7L9BRyaz9WctV1r1u00meHO4OJZ34/+NEBl080k
         CBYaDmwESAQlBDNINM7DDBwVJvq4VOa+p4FkNoihjf/KZI2KeTMXVH9NUKRzAxMFpEg6
         in1hSy8hfGpK/YweQJe1IPkUBdCMhMwwmEvRHw9WEMK+eRqmDkGyMiMptuwO+c4lrrry
         qdDCFO8/jUQSbRk1FgKIFFpTByhMI6/JQpTG9fv73GyAb9p4Q4mph5rBe+gA0cMNaVa4
         HLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869078; x=1789473878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWdRM8KWaj2QeHMO2XI9aeMbB/7rTG7L5o5/mygY1k4=;
        b=ZkMH0pi5M+qOH77ccU9RXB5FHslypTxB4nhWyvOKJg445hUdZ5Qwez1FigifhQo+Z3
         RfzX+yQlaVo0q/p9FpAFcxGoLPk4CKgKOJd4p5sLAs2gqGCNWv74jkzdAFuzZdTg3u7c
         DGHzGbQfi8FCYcWvQCc5OwRukk+sLYzcZjEIQovWxnwQ8YwcqiLhInBFqAOkc2foLnas
         VTGmBhF8CwUk/NNGjnQRwUAJGQwYG868LBlnCnoYazDs5R4JfvRDkjFxS2HaRFumcTtx
         EN+HggpN+OY1klfGY5cHj4eLihfmGIHfODZBwPTmhwlhmXObuzdMRnHkjnZIqKnTDv7a
         T5nQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJCaYYVN9QsUrVNoxsaiJlNxdbBzbXXfF2B9SjSEPCeidedC0cKj7NIax14F4/XpE4WnwQdzt3tC2nk01q@vger.kernel.org
X-Gm-Message-State: AFuF++kURrPnQf+qAPDWyCnmc3dKEErdGYuFJE23Z4IM8YFGuNkh8px1
	uRSW7wms4DIY6rwPGqe7q9xiW/ALZwnvp8j0m8e+/3hNJXboA4zCHddBGWB1RyIUKLg=
X-Gm-Gg: AYBFou1UVufr5eEK1KtX+wTIT/MoQ91jZUvuv4DR/1SyPtu0gaUY7Ke26aZTyq1q85W
	/wfafftbj5zDrekpwVnQnLdUhG02dmHMMDXRVe/47twGCKfpPCsrPoEt878mhgEqUTCxUCrBh+j
	aeIOWikug3czJk/T5BaacCB7h77+DWeMo4UKdcPmIm/lQyMr/dwa401VJbFR/lVDGzN/DZp9k6b
	mopk+JPfBmyJz7j/OO3ozR7rlQbO99ufu7ioWiZBHl3gHYzXetW8gpXc1oS2CyPYnrBnJYlOLAO
	BWtOvdl9XwpYb/ZV6C1N+O/16txaFg4bt32A63ln9CWcSVZDW6UdyOThqFpB81p6BqktXXsLf0i
	ZWnW2GOmek2oE4MrVSrPXfq+SpHZTGh6kxtHMOfOHbOQpegs1jxTQa8ual0oK3g7NiwSyY/o1wW
	nVMBvZg5ZuaYsjuHq1dFwQrpImLb+hdaFDVBuZrTWVxnbGDIPi4FA=
X-Received: by 2002:a05:600c:3b01:b0:49c:fa21:e73b with SMTP id 5b1f17b1804b1-49cfa21e86cmr239776125e9.17.1788869078416;
        Tue, 08 Sep 2026 05:04:38 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b7bfasm36371435f8f.29.2026.09.08.05.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:04:36 -0700 (PDT)
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
	Petr Mladek <pmladek@suse.com>,
	sashiko-bot@kernel.org
Subject: [PATCH v4 5/5] livepatch: Clean up klp_init_object_loaded() when fails
Date: Tue,  8 Sep 2026 14:03:25 +0200
Message-ID: <20260908120325.299649-6-pmladek@suse.com>
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

When loading a module, klp_module_coming() updates all enabled patches.
If an error occurs, klp_cleanup_module_patches_limited() cleans up fully
processed patches, but skips the patch that failed midway.

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

Next, klp_init_object_loaded() has to clear its own changes on
failure. It just returns an error when relocations failed because
they clear their own mess. It could call klp_free_object_loaded()
in other situations because all relocations were done and other
values are just cleared.

Finally, in klp_module_coming(), avoid code duplication by goto targets.
There is no need to clear relocations for other objects in the failing
patch because klp_module_coming() operates strictly on the specific
module being loaded.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.org
Closes: https://lore.kernel.org/r/20260830175608.4BABB1F000E9@smtp.kernel.org
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 714f97fdd271..87b2331486d4 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -738,18 +738,20 @@ static void __klp_free_funcs(struct klp_object *obj, bool nops_only)
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
@@ -896,7 +898,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 					     func->old_sympos,
 					     (unsigned long *)&func->old_func);
 		if (ret)
-			return ret;
+			goto err;
 
 		/*
 		 * Aliased symbols share one address, so they would resolve to
@@ -909,7 +911,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			if (prev_func->old_func == func->old_func) {
 				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
 				       prev_func->old_name, func->old_name);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err;
 			}
 		}
 
@@ -918,7 +921,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		if (!ret) {
 			pr_err("kallsyms size lookup failed for '%s'\n",
 			       func->old_name);
-			return -ENOENT;
+			ret = -ENOENT;
+			goto err;
 		}
 
 		if (func->nop)
@@ -929,11 +933,17 @@ static int klp_init_object_loaded(struct klp_patch *patch,
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
@@ -1287,8 +1297,8 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 			klp_unpatch_object(obj);
 
 			klp_post_unpatch_callback(obj);
-			klp_clear_object_relocs(patch, obj);
-			klp_free_object_loaded(obj);
+			klp_free_object_loaded(patch, obj);
+			obj->mod = NULL;
 			break;
 		}
 	}
@@ -1337,7 +1347,7 @@ int klp_module_coming(struct module *mod)
 			if (ret) {
 				pr_warn("pre-patch callback failed for object '%s'\n",
 					obj->name);
-				goto err;
+				goto err_free_object;
 			}
 
 			ret = klp_patch_object(obj);
@@ -1345,8 +1355,7 @@ int klp_module_coming(struct module *mod)
 				pr_warn("failed to apply patch '%s' to module '%s' (%d)\n",
 					patch->mod->name, obj->mod->name, ret);
 
-				klp_post_unpatch_callback(obj);
-				goto err;
+				goto err_unpatch_callback;
 			}
 
 			if (patch != klp_transition_patch)
@@ -1360,6 +1369,10 @@ int klp_module_coming(struct module *mod)
 
 	return 0;
 
+err_unpatch_callback:
+	klp_post_unpatch_callback(obj);
+err_free_object:
+	klp_free_object_loaded(patch, obj);
 err:
 	/*
 	 * If a patch is unsuccessfully applied, return
-- 
2.55.0

