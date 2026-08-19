Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62245041B
	for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138322; cv=none; b=bx34XaH2D7eaaoiXD6dOV/EaAyyCxZwqA0R90rKjHoTuy8T9mcMGI3qSEMMSQ1bceEpx/w7IhZXrGzUdJGhKbbUAe7s9OU9cZYHzgsbHy7mOvp8gPNBYgX2PXUuUHKfZeCAeBK4kPcVa4WMhDPJ0jPkZ22VlxD1XKy0wsOVe9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138322; c=relaxed/simple;
	bh=eMnNBEYWCuqZgDzZVnDgQfo+nBGtWlR2Jl1+0onb1RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlS3CY0p+HU6IwZvrhqmUXIyfscLx+WTCViPstM9dgwmK2VPastQeyTQvfleyL8MM8ZgJ5YfOa70/Srl7IvsK8Br1Slr1vc6S4il9LEXP1lkq8i4sJI7w/xl6u/mAAStnquTBIJIQrTwl7MvjFvM/hrkj+gPh1paGDPCCHpUNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e5xh40bx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e5xh40bx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4980dc26022so9312875e9.1
        for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 04:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787138319; x=1787743119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPRh85V6HAq2gVCJkrKbEufbFek3yN9NA+JJzdRKfoI=;
        b=e5xh40bxG9MIKsO7RfENHN3y2i70dG6BmGBMGjw2mcE+MrV9fAmj7wmHJLuH0Bo+QQ
         VQEtIVIVAHlKTzdrgGD7VGqxX36cowXM7gkRqQfPvWulpei+M3z8Pk+JHdOBtv0n6ky+
         oA5gqp/Tnfqs8QtEzpgIqlHB2Vjdc8fPVDH/jkhImdRD/x1ly4yn561IFFbgB0yg7tDm
         yabkgNug1lmkie7iU4P0KFsTeu6HjgGnruelnGf4ltJA+LUx5pf2AjA5Wo3MZDEkVuRK
         g7TH5OdMJfTHfGPptrDcGHtfYngQ8s2WS8taCaXcj52ycwOtDXmX+psA/eiDh6g5kD5r
         CTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787138319; x=1787743119;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPRh85V6HAq2gVCJkrKbEufbFek3yN9NA+JJzdRKfoI=;
        b=LcbXbrYNkXEGhw9TE77g/J47jWY8ao7coAYzIgaeRaqXGiEpnw+zzvkiUTb4Cd/VMq
         1sOa4w04gYzvUkqaHFa6YlvxJ1iUwkaHnmyD2BO/3PkehUJxg3Rskq6dJPISW2n3whKe
         9dXgL1nVVfds0IYOtRdsBO4GT4QOogrTPB+r88ZC3m4Ct6goNNFGIzqRCwGq23tUQ0Jd
         hGOo+odjo2BONN2lShFwGAHAOpzcsABup4IgrY2b4yN2QiCPuh399n2rXy+EaI/ZK/Ua
         RyioJ3eEjQJFKJaaz9ys+PMtaYlg/CoVVRnvqlSA3VUeW+Nydseu+3o5602uU259dhqP
         x9SQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrbp6VT8QOC60Q+htX2ayhalwG0dZMg0fKl5HYags3Fv8mu8fNjyb9bEmkIyuzoU1vaRSQUbDjJ81VwSW7f@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9omi7p3dA8bJiMLb5vWk8ubiWn3voFkGooeXamTkVvXkEn8X
	NZOoN8mqqUKj0vl0CFyQTbdp+a8ivtmIcVT9qFo37rCpuiFXk6+OnLD/O1fMOeI9zSo=
X-Gm-Gg: AR+sD129srIwCk1NlWW7VpD3QUOVgZQlO/8bAmx6v1TDmagkPkMIGe16/0Gr1b6Fzes
	SYAMiVmkR99Qk9yvF9l3pzxQgmF8vpYm++I/iBGeMJpTrlC21zTfPCy/ikKTyL+XABYePpTa2kc
	hYBfBZHIi3NuXFnZVM5NvnHEPLRMbFloYY0Jl+YMsouHfjfZWn5Dx2I4G5i6W+ZhbdQwgx8g4wE
	y7iqE13lsH9BKuYROa0WubzySlj06tPCZbkoG5lsQ2HCCI1Gyvnn1yUguvLC1feWZiVZ7Ui9wvl
	5kZWg6zxjo1WK9M8z7MAxujNwoqGrwJ/IQwBxoTDcYk8hnDCyoPNJQlvj/NQhFA4xmZ8uDE6tKX
	PC2LoEdwVw8ctkrfkv1gnFqdjKiQowEHdWlNMd5ubELoPBZ4scpAVI0SNTdmDr2SLFIRYqSA4Ma
	jE2Mza/bit8X1QuYfkBTSlVh/EOaIDkP3ERFv3eGRK1VOVs7gRYQfs3KTTrNwxDj+M3UF2DQhf
X-Received: by 2002:a05:600c:3f18:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-499aa194df0mr74641025e9.4.1787138318761;
        Wed, 19 Aug 2026 04:18:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm78881845e9.3.2026.08.19.04.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:18:38 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:18:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 2/2] livepatch: Fix UAF of unregistered patch kobjects
Message-ID: <aoWRDIjvE5jYNR9_@pathway.suse.cz>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
 <20260816090442.18128-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816090442.18128-3-laoar.shao@gmail.com>

On Sun 2026-08-16 17:04:42, Yafang Shao wrote:
> When klp_enable_patch() fails after klp_init_patch_early() has run,
> the error path calls klp_free_patch_start() and klp_free_patch_finish().
> The former drops the references of all object and function kobjects via
> klp_free_objects(), the latter drops the patch kobject reference and
> waits for the patch kobject release only:
> 
>     klp_free_patch_finish():
>         kobject_put(&patch->kobj);
>         wait_for_completion(&patch->finish);
> 
> With CONFIG_DEBUG_KOBJECT_RELEASE enabled, kobject_put() does not
> release the kobject synchronously but schedules a delayed release with
> a random delay of up to 4 seconds (see kobject_release() in
> lib/kobject.c).

Yes.

> Because klp_free_patch_finish() only waits for the
> patch kobject release, it may return while object and function kobject
> releases are still pending. The caller can then unload the livepatch
> module, which frees the klp_object and klp_func structures. The delayed
> kobject release callbacks later access this freed memory in
> kobject_cleanup(), resulting in a use-after-free.
> 
> This issue can occur in two scenarios:
> 
> 1. The patch kobject was never added to sysfs (e.g., klp_init_patch()
>    failed at kobject_add()). All child kobjects were only initialized
>    via kobject_init() but never added to sysfs. They do not hold
>    references to the patch kobject, so the patch kobject can be
>    released independently, unblocking patch->finish before the child
>    releases complete.
> 
> 2. The patch kobject was added to sysfs, but a subsequent operation
>    such as klp_add_nops() or klp_init_object() failed. Some child
>    kobjects were initialized but not yet added to sysfs. These
>    un-added children do not hold references to the patch kobject
>    either, so the same race can occur.

In short, this says that the races might happen when some kobjects
were not added into sysfs. Am I right, please?

I agree. My undestading:

The klp_kobj_release_*() callbacks are called by kobject_cleanup()
which calls kobject_put(parent) as the last step. It should make sure
that:

  + klp_kobj_release_patch() is scheduled/called only when
    klp_kobj_release_object() has been called for all patch->objs.

  + klp_kobj_release_object() is scheduled/called only when
    klp_kobj_release_func() has been called for all obj->funcs.

But it works only when "kobj->parent" is set and
"parent->kref" has been incremented for each child before.

This is true only when kobject_add() is called for all all used
kobjects. But it is not guaranteed when any klp_init_*() failed.

> Fix this by tracking all static kobject releases with a per-patch
> atomic counter (kobj_pending). klp_free_patch_start() counts the
> patch kobject plus all static object and function kobjects.
> klp_free_patch_finish() waits until kobj_pending reaches zero,
> ensuring all kobject releases have completed before the module is
> unloaded.

I think that we do not need an extra couter. We might use
the existing kobj->kref. We just need to explicitely
increment/decrement it.

I mean something like:

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..023f666ddcc4 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -652,6 +652,8 @@ static void klp_kobj_release_object(struct kobject *kobj)
 
 	if (obj->dynamic)
 		klp_free_object_dynamic(obj);
+	else
+		kobject_put(&obj->patch.kobj);
 }
 
 static const struct kobj_type klp_ktype_object = {
@@ -668,6 +670,8 @@ static void klp_kobj_release_func(struct kobject *kobj)
 
 	if (func->nop)
 		klp_free_func_nop(func);
+	else
+		kobject_put(&func->obj.kobj);
 }
 
 static const struct kobj_type klp_ktype_func = {
@@ -946,6 +950,7 @@ static void klp_init_func_early(struct klp_object *obj,
 				struct klp_func *func)
 {
 	kobject_init(&func->kobj, &klp_ktype_func);
+	kobject_get(&obj->kobj);
 	list_add_tail(&func->node, &obj->func_list);
 }
 
@@ -954,6 +959,7 @@ static void klp_init_object_early(struct klp_patch *patch,
 {
 	INIT_LIST_HEAD(&obj->func_list);
 	kobject_init(&obj->kobj, &klp_ktype_object);
+	kobject_get(&patch->kobj);
 	list_add_tail(&obj->node, &patch->obj_list);
 }

We really would need to add the back references (obj->patch,
func->obj) because we could not rely on kobj->parent. It is
set only when kobject_add() was called...

That said, I doubt that livepatching is the only subsystem using
kobjects in static structures. It might make sense to handle
this on the kobject API level. I mean to add a kobject() API
which would just set kobj->parent and increment kobj->kref
and can't fail. But it seems to be against the existing philosophy
of the kobject API. So, we might need the workaround after all.

Best Regards,
Petr
