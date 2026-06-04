Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8A375F65
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578591; cv=none; b=WiQy1DY1493bUDna0XSaozhQFx3GF/cjJwQJ61EW+7g4s4eBV+/JkT0Xs6zeQDwYLaOEXb7U2aCEiemHBF/7sdJoab4wPrBhPrGD4SE3L8SANIgEUcDIZRNP0W/9yJikKSaEhkVgHr44r2CLhjrsMn8bkmQZbOdvzzwBSfDklqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578591; c=relaxed/simple;
	bh=Sn3lKQIudwwunx7+Nr0y3ITWmEl6iVkiYlEfVNv7FTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQspmQcPAawdovbz7k7v/YcRhlsDdWYMM+gNfW7wQbkA45kpk/24VY766/F2Fr0EsBuJoKrXGW7ScxKkTlaoaDnE9spLilz1APS7uACXp2/3j/PvVto5S9EZMV1fucqr7t1imviUKDXVqCjocuBfOFJ7Z1xCx77ogyJbUztItMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I1+C9Fhw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I1+C9Fhw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef5146b56so1204072f8f.0
        for <live-patching@vger.kernel.org>; Thu, 04 Jun 2026 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780578588; x=1781183388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oY1VKwPkVFKv4NeE5kqwicRyh8+m7qj+rD/u5rkZKI=;
        b=I1+C9FhwSKlTVgV2tmzzwiRlAQlw/v+NCgiM8nHiUPaR70V1hvY0x9TB0MN+Qh7S8g
         7NWwYVehC//64Q4mR2JTBYE7iTiFo9p5Svq4OMx3vKw7+ICtIHXgvhmXC0hhAjRK1L6c
         jB2mGWD4DBuCAWinz6TajPUlZP6KorIi0s+rFZXyKlx8PqvoNeDdpMKYjHPpX2/kcz/b
         DCY1TM7YwpBLgEXHeMDXLcD/fAkHyUldY/aMcshAWGvmH4q16wQRBGzLH3nYJRyLdZnE
         R8g2igiktfeWHEMG++8GNnkgG/TnDqY7EJ4Sr4NNb6Lonv5xbBsUCca+eHFu4U8xfcR0
         fldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578588; x=1781183388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oY1VKwPkVFKv4NeE5kqwicRyh8+m7qj+rD/u5rkZKI=;
        b=DFrrDly2REz2q7tkCGEz8p4PPOWR9fDnhyV1/b5LhdrbmygBz+duvfhtrXjpa2hArO
         gwYuP9h8bpgga+/3afwhyFnrO4eL6U7x5D2FvvDLSYA0Li+Mu3Xxcjbd559f/YWVlP5G
         3jvIKwMebhtkffybAo8HcjsseBELoKEY3DB7yo0WgGawVGJ6l2I2fE5qSLIHu7EoSpYN
         TPPW8F5uBlsTV5TS4HjAZOutiFz/a8aVO3xP9DYLeRs08jlD9/2fM4HBuUbXMH00WR/X
         /Nmadz+4zyT+08JeXNGrxztrffO04B4tpHHg1gzzBU6sgb5v+OE/jjZ6hSwxRy/x4SGN
         N8Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+Suhn30va2bMnS4K/j2PhtwQdYV6OOijGWx6WSDSEVPIZ43NPCLE9LiAxRZPz2k8IrvyHK7ywBMuH4Lzfq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5jxQooaFefgBl1R5rFbx8oNIXTX3UJI3yQH65xHnzGu49xcG
	E6uMJRxteegOt+Mpoa/l8WCgi1mPoBiGrb/Pk3V7ouy74BqaOxbGgsAi5JY51euoS3I=
X-Gm-Gg: Acq92OEf6EJIjC3Li320dHfoDyk6iIe53q/ucP1S9dzcglcoPscHrLtAbxObjvxEgTv
	7kjYTURzzLNOJCxOj1LrdUku02mVPPLHNWc5AspMOaYY5i2i1/ZBLY8DhY8JhEIK9WjtdXDSuhw
	Sv0y4M0+9VoySO4/JRzqnULpTWsrfPo1scicwAyT1cpY+lnPlJkSGcS3NCUbG/EfLSstt4cNgqL
	P5TXZFaKoJnoW1FR8bpUtLUQlXtcCECO4cE5gBeqaJj94xjT/HZ0PWVYBYnYs0RbzQvB5lloVPb
	MrqF13vpMIFYN1iDJOf0zHjzFincfA9V/1G9PjATB1lYIxMpy9zmFxSSNjpkgMf+7NQiry7PpEZ
	3/lMxxwy6ylIplBWMs3iFCNOGv9O26fA7+qwpuT/Xr2ng/QT9ps6TXbQvfcksUvzeG6OaHpoaJC
	ttZcBiTLOCo3BzZ1k8VSx6Z8pyVs1ZREvB6QQTe7HxgqsSyLk=
X-Received: by 2002:a05:6000:2082:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-4602743465dmr5736255f8f.20.1780578588549;
        Thu, 04 Jun 2026 06:09:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16351006f8f.0.2026.06.04.06.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:09:48 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:09:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: mbenes@suse.cz, live-patching@vger.kernel.org, jpoimboe@kernel.org,
	Rui Qi <qirui.001@bytedance.com>, joe.lawrence@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	jikos@kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: fix resource leak in
 test_klp_syscall init error path
Message-ID: <aiF5GjePTYmLrpg0@pathway.suse.cz>
References: <20260604083208.1071428-1-qirui.001@bytedance.com>
 <20260604084214.4F9751F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604084214.4F9751F00893@smtp.kernel.org>

On Thu 2026-06-04 08:42:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Relying exclusively on kobject_put() to clean up sysfs attributes backed by module memory introduces a use-after-free window during module unload if CONFIG_DEBUG_KOBJECT_RELEASE is enabled.
> --
> 
> commit 89541aa9ecd8e356eaf4884fa2b111bc605a7933
> Author: Rui Qi <qirui.001@bytedance.com>
> 
> selftests/livepatch: fix resource leak in test_klp_syscall init error path
> 
> This commit attempts to fix a resource leak in livepatch_init() by calling
> kobject_put() on the error path if klp_enable_patch() fails.
> 
> > --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> [ ... ]
> > @@ -98,7 +98,11 @@ static int livepatch_init(void)
> >  	 */
> >  	npids = npids_pending;
> >  
> > -	return klp_enable_patch(&patch);
> > +	ret = klp_enable_patch(&patch);
> > +	if (ret)
> > +		kobject_put(klp_kobj);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it replicates a pre-existing
> issue into the error path.
> 
> Does relying exclusively on kobject_put() here create a use-after-free window
> during module unload?

Sigh, I always get lost when looking at kobject-related API.

> If CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() drops the refcount
> but schedules kobject_cleanup() (and thus sysfs_remove_dir()) to run
> asynchronously via a workqueue after a 1 to 4 second delay. Because klp_attr
> and its show callback are allocated in the module's memory, returning an error
> here causes the module loader to free that memory immediately.
>
> During this delay, the sysfs file remains fully accessible. If a user reads
> this file, would sysfs_kf_seq_show() dereference the attribute and callback
> that now point to unmapped module memory?

This sounds correct.

> Should kobject_del(klp_kobj) be called prior to kobject_put() to
> synchronously remove the sysfs entries?

I am not sure if this would be a complete solution. I do not see
anywhere that kobject_del() would be synchronous. I think that
the file still might stay opened.

> > +
> > +	return ret;
> >  }
> >  
> >  static void livepatch_exit(void)
> >  {
> >  	kobject_put(klp_kobj);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but the exact same vulnerability exists here in
> the unmodified module exit path where kobject_put() is the only cleanup
> mechanism before the module unloads.
> 
> Could we also add kobject_del(klp_kobj) before kobject_put() in
> livepatch_exit() to ensure sysfs entries are synchronously removed before
> module memory is freed?

I would ignore this. The same code (just kobject_put()) is used in
samples/kobject/kobject-example.c which is supposed to show how
the API should be used.

It is just a test module. The interface is used only by the selftest.

I believe that this is a problem of the kobject API and should
be fixed there.

Best Regards,
Petr
