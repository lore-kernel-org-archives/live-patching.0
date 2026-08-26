Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC327144B
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730777; cv=none; b=Y4M8qUTapBZlihSPVlr/pSSBiTKcmYMvOlHzChbAEVNrhf9rdv8zQarlHoJBeAdG6KIAX/7EIRHHlPoSNcZ9+GNN5ffwOknbRa2mRBJQ0erEExGmQCRb4Yk556utgYFllMXoiYvL/hbzEemZH/Q80gf7T0mvMkI8i6vJd5fi7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730777; c=relaxed/simple;
	bh=zZziZKiOtSvJEVq/938wD4cKtgh6R8r8kbzdCV47VeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8ZHmeoWUnINBskgrqQAOnpTiV2v1g5Ot3Iszoa4+dY2A/3pyaKJ37KjELKTkHFmadp/uXS6ryq1L3mS0ASd2aUUZH6VIaVubMoTsnO3J2+q270V/J59ITIqAfttXmQxIJXBlGqOmuYgO/Sql9Mb4SmHtdaQywjD1olX6U5AG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M8PPcN6n; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M8PPcN6n"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a5e329c0f2so625574a12.3
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787730774; x=1788335574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H2y9wahIeBKWXB4nMFLUi7r7DccgjoF9f326ihfWb4c=;
        b=M8PPcN6nCnxBuyroM3Y192xWqKwaTCEJLbtY4eX0woYM/D9pKbAPt9T5B61TKv3F76
         VJeDC+meO12nLLdRS+f0HMpm436G2UY3DR9X2qSHIrMq+vxWAgEm8LbT8xYLRa1t7bHx
         Cl9tqfx1H8NAkXjXy38OsI8R/s4+d7d+Vp8QwZ+qFBqKkMw43s134uyj+Rx/f77RU7Av
         fOjUVGjpWtEtIqUoSvh5GsVEatOKqot2caVCKBNA8HhJmZvGz+I9gjsacU6PVtNxg9nY
         VajJ3/ra1UdXMSZ2DcBevLrIsFnGhz8x4tTi6GyvnKMSiccc1RA9Nt1VjvYbL4Xgixhc
         +e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730774; x=1788335574;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2y9wahIeBKWXB4nMFLUi7r7DccgjoF9f326ihfWb4c=;
        b=oow6n9wJYxiI1tRFUocXaInLpSKWN7U8VmrzTgv31kGd7GedNkhDtfxlKEUbgfBUGN
         OKghj1bHgYQ9QJ0GtiRHq43FMGdL5d3R3fDoD9ImEOXrpjWuIc1ElobhYw4qaA1737gg
         lkG19fo2F0/Y3d3M734t5XCcyTbbykATtXDzfzJxdyqjDsImSM/YuqpyAzZV6+E4ZeW7
         GAP4MoXCS3add6dZXY0jHIbO4Dq9Uhq6bMhMpQl+TyY/ROv7O+x32lFuwVBTxu5BATCy
         IzLunp72AxBi8xsodpARvlLwuyvt4p1Xjt+hUP5JfmFA23gADr3cI/TxVoou4TU0P8Zu
         zSRA==
X-Forwarded-Encrypted: i=1; AHgh+RpYTngnJT7Fm/sh5tb2+KVCU8heIxU3xyT1jW/Kw3L1S3LxzPJBRvoaxADIr5FDUG88P/cfgeZ72JgrUtAP@vger.kernel.org
X-Gm-Message-State: AFuF++nTCfgJhGhX1RaHVEBdNsX1578vKRVTep49u2da8QgLeSUa5+D6
	OgwVDuo+ysIhzhSIvJRzf1OqkbQXHfMO3PgpnzUjG60bso0v2DMzKd2zC60JlfOn2tY=
X-Gm-Gg: AR+sD13RHngVyZ7wzmOgG0/0PpmPbYELrkfPoQZC47KjWAXzwm56wdiDgk/EEIeVBqS
	saELwBH6elWsu3tOtJfLiqLw9S1G+BCNIXPPOeBpyFTj+cbffTsgHVa6r/AEYIR+Q89IF5Vp7pV
	BJAyjidSJNc3/2upeiBSgyMsjH6c6+zMt6uslGBQQbN9pFur4arCYb9oKJ2cKGEDHXyWYiaDbf5
	GhYcKiWO6E3FPQC+toKhOjN5gd5gTPDCXd8CrJWb1a3WscjLDmuHf5Gi6dfPftiPmBlB8GepY+W
	mWxIDURgATYihSIQl9VJqosAk+7jh33wjEMH28PypvN/FCf+/RNT1JxmYJqQnpYN+WW1ZrnRuYB
	PlicEfkoZ/HiQlqQZ/2RxmzNBTSX5MEizr48VBlV22hewhyJlvj4X9OEie05Rv+OM9mT16BevMe
	8hj7tQH41q1QIaJgj+8ZAahFLjSpBNj3lk4fQAeeb2OPn4W64u/og2jMHLB+meFw==
X-Received: by 2002:a17:907:9451:b0:c1f:b883:ed3b with SMTP id a640c23a62f3a-c250bb571cemr547445166b.4.1787730773748;
        Wed, 26 Aug 2026 00:52:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88a928sm382559666b.33.2026.08.26.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:52:53 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:52:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/2] livepatch: Fix UAF of unregistered patch kobjects
Message-ID: <ao6bU6PI2gkE5c0M@pathway.suse.cz>
References: <20260821031648.48195-1-laoar.shao@gmail.com>
 <20260821031648.48195-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821031648.48195-2-laoar.shao@gmail.com>

On Fri 2026-08-21 11:16:47, Yafang Shao wrote:
> The kobjects of a livepatch are released via kobject_put().  When
> CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() does not release
> the kobject synchronously but schedules a delayed release with a random
> delay of up to 4 seconds (see kobject_release() in lib/kobject.c).
> 
> klp_free_patch_finish() only waits for the release of the patch kobject:
> 
>   klp_free_patch_finish():
>     kobject_put(&patch->kobj);
>     wait_for_completion(&patch->finish);
> 
> patch->finish is completed by the patch kobject's release callback.  If
> the patch kobject was never added to sysfs, or if some child kobjects
> were initialized but never added to sysfs (e.g. when klp_enable_patch()
> fails after klp_init_patch_early()), those un-added children do not hold
> a reference on the patch kobject.  kobject_add() is what takes the parent
> reference, so the patch kobject can be released first, completing
> patch->finish while the child releases are still pending.
> 
> The caller then unloads the livepatch module, which destroys the static
> klp_object and klp_func structures.  The delayed child release callbacks
> later access this freed memory, causing a use-after-free.
> 
> Fix it by making every child kobject hold an explicit reference on its
> parent from the moment the object is initialized: klp_init_object_early()
> takes a reference on the patch kobject and klp_init_func_early() takes a
> reference on the object kobject.  Unlike the reference taken by
> kobject_add(), these references also exist for objects that are never
> added to sysfs, and the release callbacks drop them unconditionally.
> This guarantees the patch kobject is released only after all child
> kobjects have been released, so patch->finish cannot be completed before
> the static structures are safe to free.
> 
> Because kobj->parent is set only by kobject_add(), add explicit
> back-pointers, obj->patch and func->obj, so the release callbacks can
> find the parent.  Dynamic objects and nop functions are freed by their
> release callbacks; save the parent pointer before freeing and drop the
> parent reference afterwards.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260809094046.50ED31F000E9@smtp.kernel.org/
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Looks good and selftests passed:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
