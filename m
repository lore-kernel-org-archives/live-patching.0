Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83440BCA1
	for <live-patching@vger.kernel.org>; Mon, 31 Aug 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181032; cv=none; b=WDdwJ3Db3Br7H/hZVhAUG9TRBB3gfu9GPS5RLpQA2kTUgkB8w2BN/fmJF7iyhjbOaMaOwX0Q7ghsNRSaqzP+j7xBGStn87+lztc6EZ1JsIoRVrD0FcLcmb2TXtmmqNlYJ8sRAxW6VE5D/l56z/1Fox6lMlQ21YQxmOHTlDTLjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181032; c=relaxed/simple;
	bh=8Osa2PuSG7NB9dJZI5amIi1Tsefo0mCPT5lN1eFX25U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZmAg31eHfX/m0zVflntHk0L9bq2xCPuYHucQxYZIi+qUikbB/Eqw3iR9uUw4w38h852hgOhbaIQTehtNJmbgER4cmKLakPImpTSWVofIevx1JP35qyxcWOXidIjOut143v5u2Za7j3s/ieZWLtvDkNXzK9/uoXAP4zQGGIH0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e7VwsVw6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e7VwsVw6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso188855e9.2
        for <live-patching@vger.kernel.org>; Mon, 31 Aug 2026 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788181027; x=1788785827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZQJDQy5rb/uJP6b6BKCnJ/LPglbNUPImqzRgdlzJPKA=;
        b=e7VwsVw6YW9hM9Q9Npzl4F+lCMok2uPPT3J1GAQdfAaTpw0H1736zHM2KduWETisHY
         mXdvD62fzvP5n/BaSCJruM4wXXVH1P28BG/UiTg3ybyynu8HncwQAkeLn6OD0GoPbMjL
         ImXDNknJnPuRmIilSS+Acra5jjc7n+gI3DjTMf5KzdwWNeKtME5SVs+Gpps8CJJzsC5O
         5Hw15Bu75THxSOmiUYipy5EC7gQ5i1VtVcY0o6G86vrnToI3Jr87OyZeSQnEu7RTN5yD
         B7Zp01jQPQO0JHWyGJkK7ekwjcntqqlTHFct1yyPKQP0YloX6ZPSIT0p1l/yLAu2yMe4
         bz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181027; x=1788785827;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQJDQy5rb/uJP6b6BKCnJ/LPglbNUPImqzRgdlzJPKA=;
        b=fQqT2kRSquGna3/tqu9JZqomcHqHpRTzRFqYl0noCK6FsJBvc6HVr2ecSC//MPb8Vd
         Ss/+gKjF9nf4Q97Pol9ixPkOoIlSgWVqFtd4x6Jy4rO53HB91uNLpcz6nIUTfrSdhlE2
         0HGzt52klq7m9XjLshh+G3xf6xxDoHs6ESyM+JSu2dG1S0GlzVeYJOkg6ph2rfZIALEU
         XrLneNM8sjO2gblUNUwm2PiAMI4PFGKZKZnCRO8RzBdGqpa4hy/1JZNnJQ5w5IxXwN9t
         QYDwYo8+3wfsDzd7giNmYEwtuETBKDDXynwLVl9gJEGZxIb3X0YBcipTWKN+G+aOe0E8
         J8EQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDGvCS8urWLl6XnOleIPBh5Ch7PpZzex4IZY+/iEhUqUUtQVuCO3eVR+vHT7qTuqcNy2W0iOR2gDQ1tHMW@vger.kernel.org
X-Gm-Message-State: AFuF++mmcgW4iofxtbhb6JyUiLWII9jlYVKz+cWu3PoNbqtN+vDjtf4O
	Kl1w1Qjn1FWSQiIgWWV+aDAPmjlvCQ62aZY9/rfizq5JJCwTgr6CYwfFuNJ/ImPN1g/9YRHpSUd
	Ez9rDc6I=
X-Gm-Gg: AR+sD11B0/3ieB0LlRDZ2A+xDt4hTb8Lbb+Zdo2c1WbN6wxIKLi7+12lmo9ukg90tm6
	PFWkdUfVeuTamx6M67P0J4ic43oagnOB+8QqCNwKGVP6s/H7nfRAWQZaLQkJvr77Mihhxtxdi08
	UsQxob/nLDPjc39HGOJUvPyIf0ykJLjVvpWCq0yfEg5J1jgWwe6ca9bSr9WrL9QuFEbl0Tz+U3R
	rrSCvXZimdex4zitAc3q0kLalbNr/hG2xeyOiqZFWLwDPpI7tci3XSjWN5IjDahm4NX9P9I0CPt
	lwZgKBLIojG4aAXTxcwIOaRN4kRUGp/qa9jUwuQRpt4o5SnWlKIhW5iB63WhiW9CUxlm0eJClr/
	1Be5NCNBN0rbCm4CNSOz1mvmAQm6xsaSz55mMVz9n8iYJ1t2stDzC2p4oqcf+SAlzhxb8FLczTS
	iDmXeoNH89W2dr9lX7s7jKP0EjdBpdwBnU36BJUwiyFCOprXwvUsHvK8jdH8JdDA==
X-Received: by 2002:a05:600c:8b88:b0:49b:4d64:bbc4 with SMTP id 5b1f17b1804b1-49cdc4403e4mr7292785e9.8.1788181027219;
        Mon, 31 Aug 2026 05:57:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdb13f094sm31431385e9.3.2026.08.31.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:57:06 -0700 (PDT)
Date: Mon, 31 Aug 2026 14:57:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	mbenes@suse.cz
Subject: Re: [PATCH 3/3] livepatch: Clean up klp_init_object_loaded() when
 fails
Message-ID: <apV6IPGhqhK7cGeh@pathway.suse.cz>
References: <20260830173343.52759-1-x90613@gmail.com>
 <20260830173343.52759-4-x90613@gmail.com>
 <20260830175608.4BABB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830175608.4BABB1F000E9@smtp.kernel.org>

On Sun 2026-08-30 17:56:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Failing `klp_apply_object_relocs()` triggers spurious architectural warnings due to unconditional clearing of unapplied relocations in the newly added error path.
> 
> Pre-existing issues:
> - [High] If `klp_pre_patch_callback()` or `klp_patch_object()` fails during `klp_module_coming()`, the successfully initialized state from `klp_init_object_loaded()` is leaked. The cleanup function `klp_cleanup_module_patches_limited()` intentionally skips the currently failing patch, leaving applied relocations in the livepatch module uncleared and causing subsequent load attempts of the target module to persistently fail.
> --
> 
> commit a90c142b7a6f2c5551f83382ec1fcf15614ffbac
> Author: Petr Mladek <pmladek@suse.com>
> 
> livepatch: Clean up klp_init_object_loaded() when fails
> 
> When a module is loaded, klp_module_coming() iterates over patches and
> calls klp_init_object_loaded(). If initialization fails, it delegates
> cleanup to klp_cleanup_module_patches_limited(). This commit updates
> klp_free_object_loaded() to revert all and only changes made by
> klp_init_object_loaded().
> 
> Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.org
> 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index a6796cd6b65fd..706a4a7193514 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> 
> [ ... ]
> 
> > @@ -916,11 +920,17 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  		if (!ret) {
> >  			pr_err("kallsyms size lookup failed for '%s' replacement\n",
> >  			       func->old_name);
> > -			return -ENOENT;
> > +			ret = -ENOENT;
> > +			goto err;
> >  		}
> >  	}
> >  
> >  	return 0;
> > +
> > +err:
> > +	klp_free_object_loaded(patch, obj);
> > +
> > +	return ret;
> >  }
> 
> [Severity: Medium]
> Does this unconditionally clear unapplied relocations?

Ah, I thought that this should be OK.

> When klp_init_object_loaded() fails (for example, if a symbol lookup fails
> after klp_apply_object_relocs() succeeds, or if klp_apply_object_relocs()
> itself fails), this newly added error path calls klp_free_object_loaded().
> 
> This unconditionally invokes klp_clear_object_relocs(), which iterates over
> all .klp.rela sections and attempts to un-apply them via
> clear_relocate_add().
> 
> However, for sections that were never applied, the target memory remains
> unmodified (zeroed). On architectures like x86, clear_relocate_add() uses
> memcmp() to verify that the memory contains the expected relocated value.
> Since it does not, it prints an "Invalid relocation target" warning for
> every unapplied relocation entry, resulting in significant spurious warning
> spam in the kernel log.

Sashiko is right. __write_relocate_add() really checks the original
value even when clearing relocation at least on x86_64.

Only klp_write_object_relocs() knows which relocations were updated.
So it has to clear its own mess.

I am going to do the following changes on top of this patch
(just compile tested at the moment):

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 1c217ac49d2b..b6ae3a518ca9 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -342,14 +342,17 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
 					secndx, objname, true);
 }
 
-static int klp_write_object_relocs(struct klp_patch *patch,
-				   struct klp_object *obj,
-				   bool apply)
+static int klp_write_object_relocs_limited(struct klp_patch *patch,
+					   struct klp_object *obj,
+					   bool apply, int limit)
 {
 	int i, ret;
 	struct klp_modinfo *info = patch->mod->klp_info;
 
-	for (i = 1; i < info->hdr.e_shnum; i++) {
+	if (!limit || limit > info->hdr.e_shnum)
+		limit = info->hdr.e_shnum;
+
+	for (i = 1; i < limit; i++) {
 		Elf_Shdr *sec = info->sechdrs + i;
 
 		if (!(sec->sh_flags & SHF_RELA_LIVEPATCH))
@@ -359,13 +362,23 @@ static int klp_write_object_relocs(struct klp_patch *patch,
 					       info->secstrings,
 					       patch->mod->core_kallsyms.strtab,
 					       info->symndx, i, obj->name, apply);
-		if (ret)
+		if (ret) {
+			if (apply)
+				klp_write_object_relocs_limited(patch, obj, false, i);
 			return ret;
+		}
 	}
 
 	return 0;
 }
 
+static int klp_write_object_relocs(struct klp_patch *patch,
+				   struct klp_object *obj,
+				   bool apply)
+{
+	return klp_write_object_relocs_limited(patch, obj, apply, 0);
+}
+
 static int klp_apply_object_relocs(struct klp_patch *patch,
 				   struct klp_object *obj)
 {
@@ -902,7 +915,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		 */
 		ret = klp_apply_object_relocs(patch, obj);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	klp_for_each_func(obj, func) {



> [ ... ]
> 
> > @@ -1274,8 +1284,8 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
> >  			klp_unpatch_object(obj);
> >  
> >  			klp_post_unpatch_callback(obj);
> > -			klp_clear_object_relocs(patch, obj);
> > -			klp_free_object_loaded(obj);
> > +			klp_free_object_loaded(patch, obj);
> > +			obj->mod = NULL;
> >  			break;
> >  		}
> >  	}
> 
> [Severity: High]
> This is a pre-existing issue, but does this cleanup logic leak relocations
> if klp_module_coming() fails after klp_init_object_loaded() succeeds?
> 
> If klp_pre_patch_callback() or klp_patch_object() fails during
> klp_module_coming(), the successfully initialized state from
> klp_init_object_loaded() is leaked.
> 
> The cleanup function intentionally skips the currently failing patch:
> 
> kernel/livepatch/core.c:klp_cleanup_module_patches_limited() {
> 	...
> 	klp_for_each_patch(patch) {
> 		if (patch == limit)
> 			break;
> 	...
> }
> 
> This prevents its newly applied relocations from being cleared. Since these
> relocations modify the livepatch module's memory, they persist even after
> the target module's load attempt is aborted.
> 
> Upon a subsequent attempt to load the target module,
> klp_apply_object_relocs() will attempt to apply the relocations again. On
> architectures like x86, apply_relocate_add() verifies that the target
> memory is zero; finding it non-zero, it returns -ENOEXEC. This causes
> klp_module_coming() to fail, permanently preventing the target module
> from being loaded as long as the livepatch is loaded.

Sigh, I got a bit lost in all the cycles. I believe that this should
get fixed the the following changes on top of this patch:

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 1c217ac49d2b..09b6f4aa6217 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1360,7 +1373,7 @@ int klp_module_coming(struct module *mod)
 			if (ret) {
 				pr_warn("pre-patch callback failed for object '%s'\n",
 					obj->name);
-				goto err;
+				goto err_free_object;
 			}
 
 			ret = klp_patch_object(obj);
@@ -1368,8 +1381,7 @@ int klp_module_coming(struct module *mod)
 				pr_warn("failed to apply patch '%s' to module '%s' (%d)\n",
 					patch->mod->name, obj->mod->name, ret);
 
-				klp_post_unpatch_callback(obj);
-				goto err;
+				goto err_unpatch_callback;
 			}
 
 			if (patch != klp_transition_patch)
@@ -1383,6 +1395,10 @@ int klp_module_coming(struct module *mod)
 
 	return 0;
 
+err_unpatch_callback:
+	klp_post_unpatch_callback(obj);
+err_free_object:
+	klp_free_object_loaded(patch, obj);
 err:
 	/*
 	 * If a patch is unsuccessfully applied, return


Note: This is called when it fails in the middle of

		klp_for_each_object(patch, obj) {

      Naive approach would be to implement another *_limited
      variant which would revert the action for all already
      proceed "obj" structures.

      But this is called in klp_module_coming() so only one
      struct object should match. All others are skipped.
      This is why it should be enough to revert only the last "obj"
      in the err_* goto targets.

      We propably should enforce this => add another patch
      which would reject livepatches which contain two
      struct object for the same object.

Best Regards,
Petr

PS: I am going to wait few more days for a possible feedback.
    Then I would v4 of this whole patchset with the additional
    changes.

    I hope that the 1st patch from Harry won't need more changes.
    So, I will only fix my part of the patchset. /o\

Best Regards,
Petr
