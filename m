Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9434E74B
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334646; cv=none; b=Kg6kCrB78uxpzpTR/qOxUWDD4lDtMrfC27lyj/Y8+mHJSX8nzLv5zvOaAaMBlrPFmnaMg8dWXtOGTEA75i9uu7vhIO7/TlsnLlQD9WawJeDgdmc01BwqXjXgtsVfOq7qWxyarKoMLCSm3Seo5S/zto7TQ36B4lN2rVIcAf6KhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334646; c=relaxed/simple;
	bh=p9ggblqKeG8Afl66MVp8yYE8ruS3Qz2L/lTC/2ps6I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK4EFwtWvLwumFhCkCTJryhPLD1Eb7MllcKkGCEjsWJUzo2hgTQ9bq1mDy/46DPMH5LGWMyTL3d8F/pN65cnpBJFXBh3b8FnF9deW+SVB6k4Z/cGLIAyQ0CuL48u3AcDTRrK9tx6G75nGxIymYo1wElAdXfvPT6g9wESnV+t0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ee2jsu03; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ee2jsu03"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so3863645e9.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788334643; x=1788939443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEnZNfF7qVyXipr3AMT96wZ/HcTzw2wFRpH+MA/atJk=;
        b=ee2jsu0393bjX1ORHPMDdsBG4a7hypwxV7RA1MPpy3wthryCwl/6pmg0WCV2thO6AY
         3pfeEMkQWZr0AIyvU2vY4VrB8lF5ITRHybvkDnGYINT2ZbMvi0HgWD4tgA+LOIaqH1Ep
         rC3mn/j3IH7PkSRxLCTfLeRRKGI7lZH8P/B6C/HFD7nyT8BDgu2XqcHbKwHEHyuQghC2
         COFuRmaQzFolLVkB/+hh7iphyDfdSj+Q+R8rfE2iQqgoKs3xZ0c0gDkqHJhW0GmQPwTO
         6Qv8LAs6+P8UKJTMIZ2MQdOekl9xo4rRrgIYGNwGmnwfw6ZV69hqWmk3sFcAfrGskJYi
         lUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334643; x=1788939443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEnZNfF7qVyXipr3AMT96wZ/HcTzw2wFRpH+MA/atJk=;
        b=D97PLJISe4i3m6txmuaXo1lUmObgM8rJkXGxf8kVCeCEkplKhVKmhYS+EHyAwVnFYO
         VmFB+K8CYbRZ2rGc+YKyKTX+NicXYy3d5byLGr2w6l1DHsSy+uvtmOEu7MMBD3W6Euyj
         u7kjGwWnglP0pPHV2fePA/tquWopW4xMf5BkYYFTK9IW80Ti4UBuT+sl/wtg6K3DVwH4
         1sxdLmju0xwwDjgc8JTkRk4gfa0rJI6algw9vtwNxTUcFR+8vUEMb33+Hh7LZ+GPEESl
         Al1rZbuXioGZ56mcJs/8A0zClUrXsJyFs1jCRz9+H1OiGdZilVQHxsjOMSJI5SwA1CsF
         NfVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvcCUwNUBnmbrSsikM1SS+kXHo6dq0jUnDHa7q22zzG0rFUiEOoeFw568wqqk2s4M4zPk7U4HOyfNJEAiI@vger.kernel.org
X-Gm-Message-State: AFuF++kyPxzUeRcy2eVOFPYHmoN+EEPAeDSo4yKKzOKwIGVLO9Ht048P
	RogtOgjE0wQ4olldI7WffWxqCQqlRH7zVTaXaQ5EnH13f3cs3yG/CFM7PysA+IBb3iU=
X-Gm-Gg: AR+sD10O1UlEjy/Gu9cyjkPxGSbM3lZcq09qD19JX4GMpxGdETAC/ZW8ccMQvcKQqtg
	vHPuzB+AOMN/pbk3sTR5+9rbC2PFqyCbXAc+H+u2GL7VJeKsMudc1SgHCovF3LEuUtVMlz46Fle
	YiNjQzt21XlO2dVreKNxiJ+Fbe8Xp9TxB8+K0ZO//r2iOBujegg0kC7NWyPQpdt5+jF6V7FfTuY
	LGUtt23BOM8fziTJxt6nn7/0XqsMEGi/FGntludr2zpnliG6oKYXz0hYvvDwS9/kMP9HCwS6gcs
	NZdvqcyCN8K2BAxCiQIbQStNebZp8TiWIHcCPgElttgxJaRh65hVfGtF1L4GBe3r7C/6fxe+n1w
	NOjJ4k4DyTUZ66EvN+ll8t83vWo63BLb2HZThJ3ysrRS7M/PQPKiS7PZQfC3He5MLjf6AjNX/UC
	IrEKTUp5nyqpQEv/KSaxUQyhhTC4Zx6hOJUbFHQ9KL/k08W8hD5dvF6EgQ7C7/TQ==
X-Received: by 2002:a05:600c:4f54:b0:49c:cee0:e7c0 with SMTP id 5b1f17b1804b1-49ce584ca20mr41445585e9.16.1788334643317;
        Wed, 02 Sep 2026 00:37:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce171c3sm137906495e9.8.2026.09.02.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:37:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:37:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: code cleanup: was: Re: [PATCH v7 for-next 3/8] livepatch: Implement
 replace set for scoped atomic replace
Message-ID: <apfSMN5a9PTxTTsW@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-4-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the patch replace set.
>   By default (provides=0), any livepatch replaces any other livepatch.
>
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different replace sets.

> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -448,13 +449,32 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static ssize_t replace_show(struct kobject *kobj,
> +static ssize_t provides_show(struct kobject *kobj,
>  			    struct kobj_attribute *attr, char *buf)
>  {
>  	struct klp_patch *patch;
>  
>  	patch = container_of(kobj, struct klp_patch, kobj);
> -	return sysfs_emit(buf, "%d\n", patch->replace);
> +	return sysfs_emit(buf, "%u\n", patch->provides);
> +}
> +
> +static ssize_t obsoletes_show(struct kobject *kobj,
> +			      struct kobj_attribute *attr, char *buf)
> +{
> +	struct klp_patch *patch;
> +	unsigned int i;
> +	int len = 0;
> +
> +	patch = container_of(kobj, struct klp_patch, kobj);
> +	if (!patch->obsoletes || !patch->nr_obsoletes)
> +		return sysfs_emit(buf, "\n");
> +
> +	for (i = 0; i < patch->nr_obsoletes; i++)
> +		len += sysfs_emit_at(buf, len, "%u%s", patch->obsoletes[i],
> +				     i < patch->nr_obsoletes - 1 ? "," : "");

It would be easier if we swithed the oder of %u and %s:

		len += sysfs_emit_at(buf, len, "%s%u", patch->obsoletes[i],
				     i == 0, "" : ",");

> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +	return len;
>  }
>  
>  static ssize_t stack_order_show(struct kobject *kobj,
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -498,7 +498,7 @@ void klp_try_complete_transition(void)
>  	 */
>  	if (!patch->enabled)
>  		klp_free_patch_async(patch);
> -	else if (patch->replace)
> +	else
>  		klp_free_replaced_patches_async(patch);

Nit: I would use this opportunity and invert the logic.
     Positive checks are always easier to read.
     I mean to use:

	if (patch->enabled)
		klp_free_replaced_patches_async(patch);
	else
		klp_free_patch_async(patch);

>  }
>  

Best Regards,
Petr
