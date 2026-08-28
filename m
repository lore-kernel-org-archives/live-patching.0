Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879703DAACF
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921614; cv=none; b=qsBUUJT7QUWe6tlM4afjyL3A1NK3sP/RNHXACs1VfbxZZgvainsMn6K7Y40BESi7+ziNo+y8kpfoUKfgLrKgVbbbJMC8pkZpwrzlyp6mRalKUMbKbFHcX4G856TW3fCTJNTGLFSVpSlB96L5onuV9xH+dlLHF9BgY9/ZlVYU+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921614; c=relaxed/simple;
	bh=Pb/gciTKGoofZUoKkdXhObAbA+m5MBrcbU+c7IppeHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSTAN71IPQ8GLeZXD8LZvLjk9y8KhnU32gQqSZdonddk9bJXrQVsprTUuCV5ybOMWztvfqPIMNWw9rskHOf8d0LsQbVQtkRuKzL+pfsERlaivHl8MSmvPMpAsYEeWXqc9ZPAwcio+vP5Coa3sOE9lxd8nV03xL0JMNLX8oUlweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X6POB/+Q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X6POB/+Q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so834099f8f.1
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787921611; x=1788526411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZ8dylnrUObvfw1K00N+19HMufBS4kkgfzkPvNd7cQA=;
        b=X6POB/+QAReYYOcjeyjpkT+yuKxs+2Srbeeuo3+cEKGWaV6vqdXeCkdLounMBu6N5V
         V8rZk/uO19hFNMPfwb6WK4oINmqAk4WdvMSvUVjnj2Bn+63r2BXt6davr3Mbl/d9S5sW
         zZwmuYgs9JvowjZxvymoXYmvRXtzS2rwCSZTsTPf/hreLvaQDj7UROeOtL++57roDR1V
         WyGuKNrzmgjYkuANXOWXw5TqbfN6W7u+Woaf2agC7lmYsVekqLKIwENFqFI+NjZ244fW
         ZHg5ghBWX0uzbVceo7/j2GJZu/WhpLAd+TF1UndBFXAQdBUgl5fFyvk06daT6zmLDGtN
         68ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921611; x=1788526411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZ8dylnrUObvfw1K00N+19HMufBS4kkgfzkPvNd7cQA=;
        b=Gc+RosrBZ/BY5k+9s6IqQJv5uNMdI4sPeu9Ou6qRcwCpGCRwRzEOPPlB3B+LPzoZ0J
         aHRcj5kuRP+IBg1+DKTN0e2eBAZEzN0b5DbGeMpPefVZxyyNeUYuvebnkWsRcPImERZs
         td7unBR+Wuhj1FHvFPHImjuV6nB4NTNlKJD8hINWmUAJIH7Y1mFqwfkCoGuLbqTX5Zi+
         9sQq6I6pDDGe72+Wazfe6QZCT5u/PRc73DAx24WY5ev749OW0fEJjM2hjA89f8B0D1KI
         nZy0fWe2geGQpV1lwlN6VR9h3U6Ofqg0Bw/SO7a/jn52GAk2GDR9CiUN8QmwZlOve6n4
         SWzg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5tZHfYwjIEO72vNGCBol4Qzd9omV3ElwjoYPPLols7bDemXORb/hn7vYxzeSQd9RlUO8dUoAGqDdn78Aq@vger.kernel.org
X-Gm-Message-State: AFuF++nl/oAZ6R7XV4Q+yjwqidTgwdrjFkr2I6ro3NcxKkZt5IJ0t6ly
	YnNZ19rx7KmHauHdrqmiMIvRKoPHhwLa4b00z1W4p/PDC9z/MvnFpLgKfq8SF3Gnkr0=
X-Gm-Gg: AR+sD121DvXZI6wqwL8HtCqoIStRlcflxjz/77qgJPIt0sClVoTToon5bxkmBOm9R8d
	77pFUlqoXVwOgRM0rtULaUqgbgjEbYZVSsxwkcn3W19R+s24H6VOi6Wipd86uAhvVRacg1n7OmV
	th9ZNvNjLe9RDh134HILCoJoTUpO+818ZJXiKC5MuIg5saLB3ObdPG9ie94VL2ntdrrib3Vw1Me
	MO9UzPZrsL0j2o1WgqMu71EvVmVAYRAomodnxJI7+lf5lKqLnLy9stY3/KLZ6Z29Z6eNSbXbHq7
	DpbfJQ4D8vzfTIh2PnBy5/oToEGpAjdilKwSChi8kAw27ai8jttW3o9GmrWpWA6lrajwFVf/fTV
	/K7TIqKXgBxZtYfCZYmEAih1/ClGdgbcsOlxKYbtAlxLKs7PtzuhtX+RDu/Wq3ptXqJTHQdPQL9
	87ImqroseeXtcmXS9z4F3vGuJGYxxxTZJZLwZl2YauSj8DOY54GWDdyArp7QEIDw==
X-Received: by 2002:a05:600c:3546:b0:499:dbc0:370d with SMTP id 5b1f17b1804b1-49b91c1dad9mr101978175e9.2.1787921610839;
        Fri, 28 Aug 2026 05:53:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92671c0esm39958905e9.2.2026.08.28.05.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:53:30 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	sashiko-bot@kernel.org
Subject: [PATCH 2/2] livepatch: Clean up klp_init_object_loaded() when fails
Date: Fri, 28 Aug 2026 14:52:44 +0200
Message-ID: <20260828125244.509977-3-pmladek@suse.com>
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
index cdb25949f73b..1e59a3cc0895 100644
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
@@ -875,7 +877,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		 */
 		ret = klp_apply_object_relocs(patch, obj);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	klp_for_each_func(obj, func) {
@@ -883,7 +885,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 					     func->old_sympos,
 					     (unsigned long *)&func->old_func);
 		if (ret)
-			return ret;
+			goto err;
 
 		/*
 		 * Aliased symbols share one address, so they would resolve to
@@ -896,7 +898,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			if (prev_func->old_func == func->old_func) {
 				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
 				       prev_func->old_name, func->old_name);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err;
 			}
 		}
 
@@ -905,7 +908,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		if (!ret) {
 			pr_err("kallsyms size lookup failed for '%s'\n",
 			       func->old_name);
-			return -ENOENT;
+			ret = -ENOENT;
+			goto err;
 		}
 
 		if (func->nop)
@@ -916,11 +920,17 @@ static int klp_init_object_loaded(struct klp_patch *patch,
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
@@ -1274,8 +1284,8 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
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
2.55.0

