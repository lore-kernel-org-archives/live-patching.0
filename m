Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD923FBB6D
	for <live-patching@vger.kernel.org>; Thu, 11 Jun 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182726; cv=none; b=feWNsiNFzOiysnSXC1Y3dqNQJ+BtoQg7KuluJAZXuASMtTYjvOKP97RnBRV1MC8QOG5PrNw1rkG2lnorUb7mvY/0SB1xlzGADLYYCd7gv1qbCInm6nqnSZMyW20Jj+2JwEkqSQ93+SigRZ65Hp645M2mUay1Is6JrWmC1FMEjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182726; c=relaxed/simple;
	bh=DiAmNazkXDZnbVA0JaVfjVSYxU9/VeS8x5P+BpE6LmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkjuES7o1bWcgfMnrOKN35HJUIltNlTIolJgVQA33o8ALS+c5sTtBAB9zKPlNOv20JP2LgnQpMt7q19GJ6KLojVjTLvNtVynobzrcTDdkrIYX8DBCwWGj5JRufevIlCNkwn2wcxO4x/0Jiwo4PqFJ1feJNbKs31ta96eaqDkrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hsn1Q5Zi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hsn1Q5Zi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso67893125e9.1
        for <live-patching@vger.kernel.org>; Thu, 11 Jun 2026 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781182722; x=1781787522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJkomeAcdbVrG8c2ONtTeWplM8dlpQFUUP6GpRBZtf4=;
        b=Hsn1Q5Zi88v0jPHIPjwPUMyclixfCBARRb8gNllbEIcw1cyUqw1cV2zItlOxkS9kfN
         mUGtEbyHhiC2nO6xi0u+n2IVDtMSIk5Kbu2sxw5qCXkW6Iu/r97Nx710xW3O44G1y7K7
         dQ8SKzcPQdg1lwd95rvBfdU7U4FHnEVhGgTKZXkQvFLSPiqzEt4mNK59z1I0q6Xj/VbD
         RyM2CRipSI1lkdn9c0d9w4pjOLp0k6asiJ08Iw7/OlbdeO1iUWMQbuUwWjnfq3TT1r5a
         gXT0d+fRE+y10AqHEwMqAIfMuGqvPLi/EvLnV1IQVI81enKXE2PoNAK58ej6JVYcP2UG
         NV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182722; x=1781787522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJkomeAcdbVrG8c2ONtTeWplM8dlpQFUUP6GpRBZtf4=;
        b=qxkcDGLHuwJI7zSFrCZjqNxb8+31+3ITnWGjbErcxSQsZ+QZ+wfv9YMrn+916yqp6g
         1jEBv7rri47D1hJ50joozbNIGAl/HnmuTfnSvwjVwXPjx2UABxD2lrt2obaHzOCYy7Pm
         1INyKVG+s85Ij7Nect06BChS/B9GWEOoy0sbt3OS7GOa5TyMhpw+wtktSudJu+zm8sUY
         y0RD3KRfDRkcWxKTHQ+g/hy3Hju/k0IWZiTWSVp8pVag4i4H7Q3AwayNRw3/aKL2v9NS
         Fch4+MchK5IYlSNuJvAbaen55IdgtR2gwZqK9XVMn+WreC+J6c3wddxKY+y5qK5KyIAc
         e6Aw==
X-Forwarded-Encrypted: i=1; AFNElJ+tVX01M+gIWGoTPBPjncqEJczzeeyc4eaewm5CfS8bJvYAX+u1QnmXFOYrriC2m9nKRSW4jMv9wvb2azQF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7temc+XdUoEt07hC0cJ1hmQhbsjKEP223RJJIy1LWWrKLpmPM
	A6SnsMAeBwnoRqgt7hw/LA9IwqLKDIRgDUQFTujyLx6NyeAIUq906xcMGvS+d82Ll7w=
X-Gm-Gg: Acq92OEbhcbxe5kErJ8qzssHu4PHJmlsQDuUnYygzLOYvuwo1+r+nW99ufFc8N0vI9k
	LswrccLBPTmcXWFQp1Q9JDgbPDCPTebc25kYMh633pdOsI5B2wdjI6AT7j1J+nsNI4qqfOA6hXw
	oyTR4vY99dHSCAYu1Mb0oZmQE9s3J1oP5hFlGTZilsV9RuJbt+TALt6Ueeg11G1d1aTwNdvQjqr
	aI/1ZPmLUwYHe+QxS9YnxCwhftjgBAcYa7bxKtW9fBQJ1sG+xJEzXseE+XDl0zqkmwJnQDQNTn/
	Gs2mJeZvUGx4iQsPTgldVpwrn/hljlzhOkU7x6A/d/3sdvTTEKU91cR2nm0rLNajcx1kdFLcj3g
	BQyrpFOcbjKO8aV5lDqXt0qDPKjLf9OEy45uQcxGZYahbsNx1p31KL2Plho9wkw2bl34DGOKfyO
	ptPiAMmkbNuT2OZL1HKAah1iso5HnU7HqTadEe
X-Received: by 2002:a05:600c:c054:b0:490:4b89:5362 with SMTP id 5b1f17b1804b1-490e56146admr23634895e9.24.1781182722443;
        Thu, 11 Jun 2026 05:58:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e5314dedsm55779705e9.9.2026.06.11.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:58:41 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:58:39 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <aiqw_74v-1_2D9rJ@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
 <aig4smgme6DR8pfs@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aig4smgme6DR8pfs@pathway.suse.cz>

On Tue 2026-06-09 18:00:55, Petr Mladek wrote:
> On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> I would write something like:
> 
> <proposal>
> The practice shows that the current semantic of the patch.replace flag is
> not ideal.
> 
> The atomic replace is disabled by default. And the no-replace mode allows
> wild installation of many livepatches in parallel. The author and
> administrator are fully responsible for preventing problems caused
> by producing and installing incompatible livepatches.
> 
> The most safe atomic replace mode must be explicitly enabled by
> setting "patch.replace = true". It is all or nothing. The livepatch
> with enabled .replace will always replace all already installed
> livepatches. It makes it very safe but it might be too harsh.
> 
> Improve the situation by switching "bool .replace" flag to
> "u32 .replace_set" and and updating its semantic.
> 
> Any .replace_set value might be associated with a set of livepatched
> symbols, callbacks, shadow variable and state IDs.
> 
> A livepatch with a particular .replace_set number will atomically
> rreplace any already installed livepatch with the same .replace_set
> number. By definition, there can only ever be one active livepatch
> for a given replace_set number.
> 
> On the contrary, livepatches with a different .replace_set number
> must not modify the same function, or use the state with the same
> ID [*]. Any attempt to load an incompatible livepatch will be
> rejected.
> 
> Summary:
> 
> The most safe mode when any livepatch replaces any other livepatch
> will be the default. Note that all livepatches must keep
> .replace_set = 0.
> 
> It will be possible to install more livepatches in parallel by
> using different .replace_set numbers. The livepatches might be
> updated independently using the atomic replace feature as long
> as the new version does not break compatibility. The kernel will
> reject a livepatch from a different replace set when it would
> want to modify the same function or livepatch state from
> another replace set.
> 
> [*] The compatibility check of callbacks and shadow variables will
>     be improved later by reworking their semantic. There is a work
>     in progress, see [0]
> </proposal>
> 
> > Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]
> 
> I have realized that I actually sent "v1-iter12" to the public
> mailing list as the official v1. So we could use:
> 
> Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/ [0]
> 
> 
> New idea:
> 
> I have briefly discussed the new semantic with Miroslav when I met
> him in person. And he was a bit concerned. We as an OS distributor
> might want to be sure that our livepatches can be installed the most
> safe way. So, we still might want to preserve the "replace all"
> semantic to make sure that our livepatches will not break anything.

I thought more about it and we would need some solution to preserve
the replace_all functionality.

There were recently reported few serious 0-day vulnerabilities.
We discussed a possibility to ship a quick fix with a livepatch.
Or that customers might want to fix it themself by a livepatch.
Such a livepatch would need to be installed in parallel to
the official livepatch fixing older bugs. But the next official
cumulative livepatch would need to replace it.

The above scenario will not longer work with the current
"replace_set" handling. The hotfix would need to use another
"replace_set" so that it can be installed in parallel.
But the next cumulative livepatch won't be able to replace
it because it would need to modify the same function.

I consulted this with AI (claude-sonet-4.6) and it gave the following
feedback/ideas ;-)

> I though about 4 approaches approaches:
> 
> 1. Make .replace_set=0 special so that it will always replace
>    everything. Similar to the current .replace=true mode.
> 
>    Customers will still be able to install custom livepatches
>    later with .replace_set != 0. But the "0" livepatch will
>    always wipe them out.

This is not ideal because it is asymetric. Why is "0" special?


> 2. Use two flags in the livepatch, for example
> 
>      a. Rename .replace to .replace_all. The livepatch with this
> 	flag set will always wipe all other livepatches.
> 
>      b. Add .replace_set which will allow to install more livepatches
> 	in parallel, replace the livepatches with the same .replace_set
> 	atomically, and check the compatibility. As described above.
> 
>     It is a bit more complicated. But it is more compatible with
>     the current state. And it removes the special meaning of
>     .replace_set == 0.

This looks more straightforward. But the fact that "replace_all"
replaces everything brings back the problem with the original
"replace" flag. So, it makes this whole exercise more or less
pointless.

I had another idea with storing list of fixed bugs/CVEs in each
livepatch. Independent fixes might be fixed by independent
livepatches. Then a cumulative livepatch would replace only
the livepatches which fixed the same bugs before.

And (claude-sonnet-4.6) came with an interesting simplification.

We could add:

struct klp_patch {
[...]
      unsigned int replace_set;
      const unsigned int *supersedes;   /* Zero terminated array of replace_set IDs */
[...]
}

So that the cumulative livepatch might optionally define
another "replace_set"s which would be replaced.

This would work well when both cumulative livepatches and the hotfix
are provided by the same vendor or group.

We could also allow to change it dynamically by adding an module
option to the cumulative livepatch, .e.g supersedes=id[,id]*
We could add some support into the kernel for handling the module
parameter a standard way.

It is not trivial. But it is also not horribly complex.
It looks like a good compromise between the requirements and
code complexity.

We really need input from others here.

Best Regards,
Petr
