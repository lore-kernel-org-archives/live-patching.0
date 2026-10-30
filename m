Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351710;
	b=oc6EXUe1EXa8ne9maqSypAsiOyw5luq1NzWHL9xLATEyKDTkEIJeHqolYWc+HO5i9BPz
	 UlAJOZ9fA4Sthbp2/XuVLP7aMIhChf1ptNUBh8d26JSoQXxkZbq9nYwFvPC+oYmHK+QCb
	 E6JNkik3D/QD5rnaAJqGK5UeOREmqdOg4ZhTFo9OeJEpcZGowSoNCQexX5ad7RmSW35QX
	 /DFILJbjUdXHq23ZwUdbYUolRydwh6pmQi/zIwrh0eUCK8qmLaLH5UGGAkjLQjGsQ/bwa
	 p/AHikEKcEyJfuEUbGJ6PovFwdYAzcYHrYLYT0Nxf0sdXDyEPpjpz3E9/c8q1c5Gk+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=19OoVAzMw0AgVIO1bk9fIbdG8XAGpIkzVZjZ1XRF4Zs=;
	b=rtRqUCitc0ELJB4mne12F8T5gk2wjQEVdl7RJhfs1jhV5YQ0UHfRkF6no+A6hrf4AEno
	 UX2UXlJDIy7NYPlTRjTKJdtON03fz2WlXvz4NJoCs+DojzqVTLxleU8lHopzF9oX8J29d
	 NaTUEw6EmyR8R1riHMw10QCTj3w9CIU6/24vczg5YtWHXxjLa2nkvqrsaFlee8w9ootpm
	 /P05P44ilBS0dzqrVTSRBfOm+JfYNdim0a5UKA5wLAe4Cz0SghjIw9kEIEON90nexlH0O
	 Cc1lEHalP6uUMlygCBAd5Lo339sjJ6jf8wVYXEyPuI92nFUU1JcmwHNV74d3VrRQ1sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ta9GbNcx;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754B606A325
	for <live-patching@vger.kernel.org>; Fri, 30 Oct 2026 09:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4754B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ta9GbNcx
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso4198835e9.3
        for <live-patching@vger.kernel.org>; Fri, 30 Oct 2026 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793351708; x=1793956508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=19OoVAzMw0AgVIO1bk9fIbdG8XAGpIkzVZjZ1XRF4Zs=;
        b=Ta9GbNcx5EFZKyrMDesXpSfPPthd7lvTShebqNnK2GzdLOEnoB9UlSWIUBhGUbEjBC
         RqnUt4GnNmq71/r7AS0+UASXJ1kv3snxFu6QfhSdCmqZrfuwoDHCdFb6zGSyI2kpmfON
         +IRF9Ls2hqqXnE/3+R02ROjwuiN2Kq3q+0bCVkblTn/zIL6hTn6fMCYKUvoFm9kjL8cL
         sZiLwOHfY2XfwtBKCazbD4etwSpGCGe8de+S4gG6taAzX7oFRPa8tqhF0ou/GjsRPza+
         FE5Vz0xgxWdipcs1+/afD6rkNwXGYa0SIldvLNVwWaTuslOnn1wyicPHODj9DFKOhFSO
         BK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351708; x=1793956508;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19OoVAzMw0AgVIO1bk9fIbdG8XAGpIkzVZjZ1XRF4Zs=;
        b=sYt5duIayxrk7TWuu/6alHuc+a0MI3KVDk2Y8sWtigEzF/mKCKjTBVodZkiilVs+yT
         vgsJ2OSLs5f+0uaKlPD9lyAQKDbaQh1EYVCdT8E+geVux4jrikhozo+wb9a2viHg8GCj
         1qyX3ZnW9P7efSeZRQzqwHmk0abWtpV3gbGHk8SGGc/2xR3PVrnp9kyC3GfVA1zJxkeS
         ew/SnHD24lQ6YIGFT61elUH6S2An5nZsfQyXeBOmNlYdCixdDsxPVpDfEAoR2fU+xEn1
         4iJ4AxWORCUiiX5G9tCqqGHRqhO2BGavdmf0NMumtvc9jV4Yh3g8dW661RRwZZIZdFD/
         WxiA==
X-Forwarded-Encrypted: i=1; AKwUvBxxLN5cEFZ25xUJC0I1AKk6OOzHxE7MUdX6K2mIS9DPkvlwKx8LEF5P16TyrQuu9DRM3gd19HWTsZRl5amQ@vger.kernel.org
X-Gm-Message-State: AFq9FYIOwCH4QzEdBKXdPxlnhGQOjHw64l07k5o3EWVPVUQj8rON3tM8
	I49kLaeMdR01/sDEALXyoPmVrNsxroyukQuWuASWQCRNjsWDQfbpJpaXS0O4re26ieM=
X-Gm-Gg: AYBFou39kR+0bAq1BDflhRDjvOj2u0rICalgDs0OaSEoxbhRk/hmOZ67pPCInnwX8sl
	8Jv3YMy35tB/h3SwoNAfyWIZeK6UOOzIaxWm0hHE049CRcqKO5pcV21x9JuxsXmjGV0hOAxL7XW
	BLc6SMSqEsB0KrMyZSodFeZGpfvLKFnW2UzvJljlOwEHPRul8ebkPEfpWlfO0YvkGVVQUNPL78W
	T4nIwNgfxac42xPva3q+lymv8RoyvTZ/4M/F8LjBkBo1AQ2E75RGieBOEBo+dSK6nmXz35TjB6U
	FsJXG/VtZ7eRO5JEoF6bVBCWbLFKJxVimWrccqzpRGqyUmKTvdai3CPKuA0HwHpK0RmnAcqpgOE
	TBI9DrLmO5mIvjAYKjRTeG+x/y2cDQK58lkcdQScWncly8PsGC/cSZZAoW0MOXCKFr8JzeHPRq6
	93YpGsfsPrg7jjrtO7q/5BPwh19sv42d/51uI3J4JmgVMA6xPTYOxjWfi8H3QOjSwMHCRRWD077
	fHtp/3rL3kFISp3Yc9m44kdw3O/p/1d0MCfy09tIcwXJJM8PIt1CjWhHrYDO/DImkIqf3ztWRyI
	ibcidNPHnr/L0O77rh4hAJquQkVt2Jk=
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4ac17ffaf95mr34072735e9.18.1793351707675;
        Fri, 30 Oct 2026 02:15:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf396dfdbsm48931045e9.1.2026.10.30.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:15:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:15:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	jikos@kernel.org, live-patching@vger.kernel.org, shuah@kernel.org,
	song@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] livepatch: Fail object initialization on
 duplicate patched function
Message-ID: <auRgGK3aQyv7tF9J@pathway.suse.cz>
References: <att7GJXA7hK7Ic64@pathway.suse.cz>
 <20261028164649.337479-1-x90613@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164649.337479-1-x90613@gmail.com>

On Thu 2026-10-29 00:46:49, Harry Hsu wrote:
> On Fri 2026-10-23, Petr Mladek wrote:
> > I wonder how to move forward with this patchset. There seems to be
> > three unresolved problems:
> >
> >   1. How to handle aliased functions when replacing two livepatches
> >      with aliased symbols, aka two NOPs on the same stack [1].
> >
> >      My take: I would fix this later on top of scoped atomic replace.
> >               The aliased symbols should conflict.
> >   2. Fix the low-level __write_relocate_add() to clean its own
> >      mess on failure.
> >
> >      My take: I would fix this a follow up patch.
> >
> >   3. Better describe the purpose of klp_write_object_relocs_limited().
> >      Or clean its own mess a better way (code duplication)?
> >
> >      My take:  This requires v5.
> 
> For 1, I have a proposal to create only one NOP in the first place,
> as in your solution 1 from the earlier mail.
> 
> 
> Recap: The problem
> -----------
> 
> Take two livepatches that are already loaded:
>   A patches __do_sys_fork
>   B patches __x64_sys_fork        (same address as __do_sys_fork)
> 
> and an atomic replace livepatch C that patches neither of them.
> klp_add_nops() finds the functions by name and sympos only, so C
> inherits two NOPs. Both resolve to the same address and end up on
> the same ops->func_stack: [A, B, nop1, nop2]. When the transition
> is reverted, the stack goes from nop2 to nop1 instead of back to B.
> 
> 
> Proposal
> --------
> 
> klp_add_nops() runs from klp_init_patch() before klp_init_object(),
> so the new NOPs have no address yet. But func->old_func of the old
> livepatches is already resolved when their object is loaded.

Hmm, this is not good. It would be better to have an universal
solution which would work even when the livepatched object (module)
gets loaded later.

A solution might be to detect this in klp_init_object_loaded()
and free the duplicated NOP there. I am not 100% sure that this
would work but it might be worth investigating.

Best Regards,
Petr
