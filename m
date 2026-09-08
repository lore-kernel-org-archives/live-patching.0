Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497F559301
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874352; cv=none; b=mRUvLTkewyUHqy8nkbcxddkSLer/QSLpBISihYbIiFvjwANIm8bvKRa0qVT147qfbCDrXavxYM+/n+rIWTlr7QkvaQ9G+ceqMmhLcMe18kASA0yNAwuvxrZPSXQYnb0pDpT4n1rfLUFeJO7ehW98RXl5kN1xht7qGaStKqo0SSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874352; c=relaxed/simple;
	bh=WkJJWZ4SaxJF/zyHzYEhTuM+Mb9yokH8po4OGhCk8uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC7gOIcLl9tl24XN8xhzutdN9dF5D+DgtGcTS2ISXzxOs07Iqv7t5JX/ZebHb2xp6fPgwiugTWAy0loUn/HW493BAoifaxpJjrojQBYS3+NFgioNShG07czxXhe4p4tiqmDmEBN+D6fALloHCBUdT5UesPzQ04fSowjVuPFdnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SSAFH46W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SSAFH46W"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so66061435e9.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788874334; x=1789479134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mzA37jUw1zDr0CBMAEx16zABWeBDZswZOBHILRhm0ZI=;
        b=SSAFH46Wc+tnRKi/RlRlGjt4dqFT80tRzWBvl4lbx9tVjvyjaUSpA95KM880CkktGT
         hPz+5JVQVxsj4FzWzmNY0P/UDTzwgbPPqdoOmtkroc6bLBbWkxYRQ5oTf+MXMP8xkWyc
         TNoQt5yVqu/YdBx69Z8bo3ZGCBjES7vO0Ayjl13TIGtKOJN3cyaGVmA9oA/fghGPq2p0
         79H0MIXRptvXiP6P8WaHgKiIKj6lrVUc0lELsNsikc7CjVoKfhx1vIaw2kIdnaSY0/Z5
         H2xYQJiGwJoDGQ2P5i32QUHs0YvNgQ+s8SnsTGejvsHpKawoQBFSrKXf3sA98rErs0Nt
         cq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874334; x=1789479134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzA37jUw1zDr0CBMAEx16zABWeBDZswZOBHILRhm0ZI=;
        b=bdWpUtqXb8gvDi/Qr4WK6CmA1X3d/VTjLdpbqaVmFzimUJImdGYv7x1DuSeiXrW5Zk
         7U6xTgMTowX1Oq9lG+MieTXzbXomxSebRFoVtCdOjp6f7rhey0pFgPm6P715qFwe63dm
         0GpMRFCAxlNiP+0JUxXLVG44Xuvm7Uft5yatarjnjYszn+/7HQIker156PjYl8pbJert
         IAyh4dcGgdlXj2/m8s40as5cHN/mgc0SqLarmD5JlugpIjuVZyMLQqQC0CqqkFVLtGAN
         FIxHpSOjTj0H72hDl7o2GzWcPhT0GEd3JCQN7e48FpawI/wD+QelP65FtRXOnJxrl+fd
         bcEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcRSpqyj6x9yLB0M/ykcMZ1fYbMO8xK91A/7QKwp2MgWsBgsQXrHmoYEo6O5f6NSi88n4sQXC29fpgPtMr@vger.kernel.org
X-Gm-Message-State: AFuF++ksIvuYd7zuSGOlNMGxqLPDrDFf8Lbuv6NrVvJfcSwpE1m99WiX
	pHCaeZcTN13muFbxuJ/Zw6G2P+MRuqMX+JqeTP3ZrTFvXeAy0Q7A+xBRIj+nFc08P2A=
X-Gm-Gg: AYBFou0Msgy0rNeKeD1rZBT8Tern0DiGG+Q7B5pPslmTKqbOKkW/Y3D0puIPaRZMXQ6
	v7kPCvQUFw0oUi9SpJheppTL4uPMtkK8kfCMGU06cJCko/4z7HweSP1bP/TbMT+oGNIiyvhrMlh
	EZiWjtCjalcY3mYSS2R4HUvbMY0v3N3BHWdAWDoheYKHdqDt0Cvl8N9qKYVRmV8gjcqk46dIt69
	niJjIbPaOEmLtxx5HLjTEbmL7kVjnxActPXJBy/jsXbb7y/UayWCQGM/UzEVsF5UuxHTDij00Uy
	kNf3ovEFkFdGeSEn4sbDRnc1V6KmZCK9v8TpT76XJ9dtYoSEGIP9nMizkYNWLPN9QZe4hoqMYSl
	Vd7xUeEUaOsLKHNjwqk3Tf2qDfhVL6KI3rdTMZxoqnP7XTRvmsaHQ7CLH2nXTselG9Wj9M+Wr5m
	WNDAEcoNCMjHG/jzeugd8YMYWgOHpND5XXGF1HNc7W5l5+cDWuTmQ=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr409557115e9.5.1788874333600;
        Tue, 08 Sep 2026 06:32:13 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm518069085e9.14.2026.09.08.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:32:13 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:32:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, joe.lawrence@redhat.com,
	Harry Hsu <x90613@gmail.com>, mbenes@suse.cz,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	live-patching@vger.kernel.org, song@kernel.org, jikos@kernel.org
Subject: Re: [PATCH v4 5/5] livepatch: Clean up klp_init_object_loaded() when
 fails
Message-ID: <aqAOWrmq1YgTbgAi@pathway>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-6-pmladek@suse.com>
 <20260908122549.193F41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908122549.193F41F00A3A@smtp.kernel.org>

On Tue 2026-09-08 12:25:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Partial relocations are not reverted when apply_relocate_add() fails midway, leading to permanent state corruption.
> --
> 
> commit 3f6df1b4ed699e839abbdc8919a6c7de5d1850c8
> Author: Petr Mladek <pmladek@suse.com>
> 
> livepatch: Clean up klp_init_object_loaded() when fails
> 
> When loading a module, klp_module_coming() updates all enabled patches.
> If an error occurs, klp_cleanup_module_patches_limited() cleans up fully
> processed patches, but skips the patch that failed midway. This commit
> updates klp_free_object_loaded() to revert all and only changes made by
> klp_init_object_loaded().
> 
> Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.org
> Closes: https://lore.kernel.org/r/20260830175608.4BABB1F000E9@smtp.kernel.org
> 
> > Next, klp_init_object_loaded() has to clear its own changes on
> > failure. It just returns an error when relocations failed because
> > they clear their own mess. It could call klp_free_object_loaded()
> > in other situations because all relocations were done and other
> > values are just cleared.
> 
> [Severity: High]
> Does this actually clear its own mess completely? Looking at how relocations
> are rolled back in klp_write_object_relocs_limited(), which was introduced
> earlier in this series:
> 
> kernel/livepatch/core.c:klp_write_object_relocs_limited() {
>     ...
> 		ret = klp_write_section_relocs(patch->mod, info->sechdrs,
> 					       info->secstrings,
> 					       patch->mod->core_kallsyms.strtab,
> 					       info->symndx, i, obj->name, apply);
> 		if (ret) {
> 			if (apply)
> 				klp_write_object_relocs_limited(patch, obj, false, i);
> 			return ret;
> 		}
>     ...
> }
> 
> By passing i as the limit to the rollback function, the rollback loop:
> 
> 	for (i = 1; i < limit; i++) {
> 
> will terminate at i - 1. Doesn't this skip the rollback for the partially
> applied section i?
> 
> If apply_relocate_add succeeds on relocations 0 to k-1 in section i, but
> fails on relocation k, these partial relocations remain permanently applied
> in the livepatch module's text. 

This is the same problem which was reported for the 4th patch.
It would need to handled in the arch-code, namely
in __write_relocate_add() in arch/x86/kernel/module.c.

Best Regards,
Petr

> Subsequent attempts to load the target module will fail immediately at
> relocation 0 due to non-zero target memory, converting a potentially transient
> address-space layout failure into a permanent -ENOEXEC on retry.
