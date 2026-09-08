Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF2554086
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874173; cv=none; b=SNCZXQFn8TSrvZ6nyW2fFXt8mhf1iH8b7k+2ANbh2l3MiFxGlNZpAwvLhLReMnJUYBVScH+zzYn8KABQ8qhRv2AitG2pFaJy/AHO5gsAB7+OoFT9K3hoCCrL33E3taAkKgddwqtaPbfKAZkdITUyclZo+1fiKUofk7qWdpkydqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874173; c=relaxed/simple;
	bh=ilMIv23jDI2om5QXhKraazCHucV6pJlWdlh4viYTMaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivtCs4vvGo4l4hSfjDH+r4VEL/UnHsiHDCcueQEOOKomfnr2cbsj7svL5DjskzpVWDuz5qto5ClIIH1I4xAexT59HjWYIi3B+B4qnoh+kvOAd9jpAqIyK0baGu6cgs/7etr5GiSyHioT/4n3sUgugV6lOGLt77AYsgWLTpUfJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LKk5vrAM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LKk5vrAM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f96c5b722so3277123f8f.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788874164; x=1789478964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSgzUdR3sqoyk/gUrIXmjoEFUchlJ3rVBgk6ATmeKIw=;
        b=LKk5vrAMirwsRBoQ1AIBrFsSQOsmLowcPgn1wJ7cIxVDp0zrDWADp03ZaT5Etmscoy
         kby7oDNQuW5n6GyqNgklJLOtXjWCGxAXEwGHYz5QDST1PHf+SKdG/1HxWm8sFMzMS1GX
         L2VlCweH4l7a7HaDcSFPJp49daOSCM1NbHI7FRMVrxo6j/UUwHuIPEpWWqmCeNwyDCoh
         vTMWWs/k5NAhu3OpCcvrAHyA4inHyBUJBw0YDtZVGhZ8qccl3v6r7m4B1U7FV0Sx7qrX
         EW0mzcVL1XLqpk9qhvWVXCceY6PDKqc8WcatLUojy3+/aADoUVd85hI0rtsTxpZ0AWAs
         b9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874164; x=1789478964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YSgzUdR3sqoyk/gUrIXmjoEFUchlJ3rVBgk6ATmeKIw=;
        b=Ivf8yFIIKsEryQHiHMKw/YSCaYWYw4fIYuo1SeUqH9Q034Lq2vaFszwYvTWqK7yk4I
         sZkhPTjFbGdLMX2ys881oL6q8yDrRW2bCXwCLuX4ICZfQiLWBMLPCB8blsO9Z0l0CRMe
         3UVva3fsZtwX/j3UGKoPB/6uINJ+8LbtbpUzh/zqEg0YgI3NYHNhMD99a0bVyWkno/yf
         dC1v1iOayHTTqkulQklyzBT6KdPZA9ygu02EWWQ0fLjggSG+BC+z2W322nlHx3YDztNA
         8qrS2X8+R/eu05dX6EAozsPKrFeLV3Kc1Q7eevhfPWGoEbEjrJoefUR4ICcTWUFTAK2l
         Xtww==
X-Forwarded-Encrypted: i=1; AKwUvBxdMc2migBzoHZgIIAAjully69sD77303MllR1OsSUusKCWplrFOhRqAJF4Em5FxH+P6LwEKtjdjn2oWFCY@vger.kernel.org
X-Gm-Message-State: AFuF++kN06DPi8UB87jtpIBGYpWv55JesQdivIJj0NAB+G+W0fEUibfA
	yxwcaR7bOVliR6dukPScnEwpYa4cpkeRIYR67fyPIplxtCpmt+thcvB3Dx+gni/cxBQ=
X-Gm-Gg: AYBFou3BuB46TE2cTpx7nsCWkJGxNTu5LkF2hDDOwbFSa9fKYEBdITgEqzBqdzwe4Fb
	eo3YtWnhxq/UNMFqmyw1YaHKvNrs8ouTj/7lVnEdTSWCwcaZqaawycI5L4U8TzKCDDnpi+yP1d4
	7KJzMKuf4c6RMLLKrvOfg+RqAfuDyaEPDCtKi1uxb5RPpncPKnH8A4sTBdw8mjXxd25CC8Rz7QG
	OD4tBhb9exhBLXZ7u/9nencw0rRW1/4zzf71uj5UJ/6k95UhXeDehwU77tqeOoDztpDiioNw1G1
	/I8XNOIq3bBcy+dSyfUpIJChvX6d7x0ydIpLGaZH47ci7tHJfmtn+/Te7rGgdE1THvww2dgfuw2
	AkLkY0u7H83MUU8LM3Bb555XbP+IMV+PiGLyS5Ryn3kSHs3nPPXaEutTbsRPNp81/YEHltdCTZT
	Ol3RbOCQdW7z02TT5OtSW5/GBiEK+7OhLObCeeoIJWssmED1lvGFI=
X-Received: by 2002:a05:6000:4710:b0:485:8a47:5b83 with SMTP id ffacd0b85a97d-4858a475c60mr26306825f8f.32.1788874163604;
        Tue, 08 Sep 2026 06:29:23 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b7bfasm36856922f8f.29.2026.09.08.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:29:22 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:29:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: joe.lawrence@redhat.com, Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org, mbenes@suse.cz, shuah@kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	jikos@kernel.org, song@kernel.org
Subject: Re: [PATCH v4 4/5] livepatch: Clear relocations when
 klp_apply_object_relocs() fails
Message-ID: <aqANsLgTIOy44sDg@pathway>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-5-pmladek@suse.com>
 <20260908121810.9577A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908121810.9577A1F00A3A@smtp.kernel.org>

On Tue 2026-09-08 12:18:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Off-by-one error in the rollback loop leaves the failing section's partially applied relocations uncleared.
> --
> 
> commit d297505bb4b1d833ec93725770d65ac1044abcad
> Author: Petr Mladek <pmladek@suse.com>
> 
> livepatch: Clear relocations when klp_apply_object_relocs() fails
> 
> This commit introduces klp_write_object_relocs_limited() to unwind and
> clear only the relocations that were successfully applied before
> klp_write_object_relocs() encountered an error. This prevents partially
> applied patches from leaving un-reverted changes that cause subsequent
> patch operations to fail validation.
> 
> Link: https://lore.kernel.org/r/20260830175608.4BABB1F000E9@smtp.kernel.org
> 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index a6796cd6b65fd..714f97fdd271a 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -342,14 +342,17 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
> [ ... ]
> > +static int klp_write_object_relocs_limited(struct klp_patch *patch,
> > +					   struct klp_object *obj,
> > +					   bool apply, int limit)
> >  {
> >  	int i, ret;
> >  	struct klp_modinfo *info = patch->mod->klp_info;
> >  
> > -	for (i = 1; i < info->hdr.e_shnum; i++) {
> > +	if (!limit || limit > info->hdr.e_shnum)
> > +		limit = info->hdr.e_shnum;
> > +
> > +	for (i = 1; i < limit; i++) {
> >  		Elf_Shdr *sec = info->sechdrs + i;
> [ ... ]
> > -		if (ret)
> > +		if (ret) {
> > +			if (apply)
> > +				klp_write_object_relocs_limited(patch, obj, false, i);
> 
> [Severity: Medium]
> When an error occurs in klp_write_section_relocs(), the rollback is triggered
> with the failing section index passed as the limit. Since the rollback loop
> iterates with a strict less-than bounds check against this limit, will this
> skip the rollback for any relocations that were successfully applied within
> the failing section itself before it encountered the error?
> 
> It looks like this could leave partially applied relocations permanently
> in memory within the failing section, causing future module loads to fail
> validation.

Sigh, I did not go deep enough. And it goes down to the arch-specific
implementations, in particular arch/x86/kernel/module.c:

static int __write_relocate_add(Elf64_Shdr *sechdrs,
		   const char *strtab,
		   unsigned int symindex,
		   unsigned int relsec,
		   struct module *me,
		   void *(*write)(void *dest, const void *src, size_t len),
		   bool apply)
{
[...]
	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
[...]
			if (memcmp(loc, &zero, size)) {
				pr_err("x86/modules: Invalid relocation target, existing value is nonzero for sec %u, idx %u, type %d, loc %lx, val %llx\n",
				       relsec, i, (int)ELF64_R_TYPE(rel[i].r_info),
				       (unsigned long)loc, val);
				return -ENOEXEC;
			}
			write(loc, &val, size);
		} else {
			if (memcmp(loc, &val, size)) {
				pr_warn("x86/modules: Invalid relocation target, existing value does not match expected value for sec %u, idx %u, type %d, loc %lx, val %llx\n",
					relsec, i, (int)ELF64_R_TYPE(rel[i].r_info),
					(unsigned long)loc, val);
				return -ENOEXEC;
			}
			write(loc, &zero, size);
		}
[...]

We would need to implement the revert at this level.
IMHO, it could be done separately.

I used Gemini LLM to check it and it seems that x86_64 is the only
architecture with these permissive checks. It seems that all other
architectures just write the new value without checking
the existing one.

Would you go this way and try to get patch into x86 code?
Should I do it in v5 or separately?

Best Regards,
Petr

PS: I would prefer to go with unless it causes regression
    and fix this "later". We could not endlessly delay
    fixes because of Sashiko finding pre-existing problems.

> >  			return ret;
> > +		}
> >  	}
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908120325.299649-1-pmladek@suse.com?part=4
