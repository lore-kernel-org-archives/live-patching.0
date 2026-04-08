Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFC37D134
	for <live-patching@vger.kernel.org>; Wed,  8 Apr 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646659; cv=none; b=C3hIQu16lgSSjkf/C+ZA8AOYx0dMzwumCw1HxLwfvRDpDTcsTgQsjVpbamFuigi0v37n7qTNIzmJnvDaPGWozWU6cEeMQRztEEqMva9h8DgJWWOzpCkankAfEH2ONSEM9/+qehn87W4k8lz8Ye6J+nEB80psglsLEWk2RbQijm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646659; c=relaxed/simple;
	bh=jFZjtktr1182f8BWsVbMJEHb9H4MNzz+xm/vLv4K1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkmVUilLTU6kbJoeuT8rtyqacqCYPQEFjJL61eiYXjr645dHB5ajNwR96xMzlmtMkyO96mj+bWJ+qsiuxi6VPxVhAdw1gxvXS3+SF86XBI+hEnA2ZAcBqhZe7KIZAHU/WSjsJcs8VU7B4gEUhOtYhVmcp6/jTQZkded0hv3vnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Scmo/EJ+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Scmo/EJ+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so5210183f8f.0
        for <live-patching@vger.kernel.org>; Wed, 08 Apr 2026 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775646656; x=1776251456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfllRBgwiwa3h1YU32+J/3Xslzo7VJyKCR+sEXLOPdc=;
        b=Scmo/EJ+ekij29gx2CQSx27ITvBa/vg71uKIqGTyxtvEoc4ODr3I/8+pVOEglOpK5I
         SdoOTFP/ha9+eVfICmbo0AzaEr19G0QV/cuuk1hpEbANdcMkGMfbx+aWtl8hzDIW4BYr
         jh3bse40AqusVWoyFJ6OXswjb3tJ+cistJiPXnDN4VH/eeSTUcUjDVAs0thGX3gj84nM
         120ormNdhG6+CXwLNBhFFxSBrOPv6HEKau4TWb+kov0R4vstoPeApF6eKOom2WziCJXg
         hIpV6UhWkn1RNLiIwElYZdwXLNDEqIapPndFCkO97e6UYivlHNWsGpcc6NfE1DxXokHM
         bd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775646656; x=1776251456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfllRBgwiwa3h1YU32+J/3Xslzo7VJyKCR+sEXLOPdc=;
        b=D4HULZJwvfGf4mnB3EkGKdX37e5g9HDDA9w07CgUIY0quJWnT4FX1mzIQXSklLuFfD
         ND69R4RW9VNR6ZV/KGLnkI2TnM4KKFVboMTFqi6ds8O88pBhw6Igze/P9KNngVT5M9KH
         3fCbVEtvS3wRByGCMhqQT5lBPwII5qsJAX52ufopPV1B2DJSAfvvUacawfksDEO+VOWC
         xaJUxQQFtQAY+OXm2IExYUtesyrvbTIYEF/TQntIxIK9ZnKBerqGM9cvFv65Xp86Nz6f
         b/86sRHX5NywjEtEzpwHamAAzqPEoMxWTuxmGWeb/wZ3Ps9WawDKNnUvoDVR2fQb+ARN
         EYAA==
X-Forwarded-Encrypted: i=1; AJvYcCWcdzzANvd9OfoKbzJsX1ZtG3VM40kGkWilyG9+KKDYc90r7xNOs8WibOJsIXvzeqluZ1yLJ7NvOjRsMkgN@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6/oeaJOZbpj8AbdGF/N9UBuz/O+PIyOdqzhPSC6Pzs2cHr+i
	HtiN3Y9BV1sWBqUsH05TxErR6MfgGYnTa930Wet/1zq+csEGmJSaT/SRge7RJJ6PBpE=
X-Gm-Gg: AeBDiet8GfaQWrRk3KUJ/FIAB0gzp9E2LEzKKrX9w9Gqaf/BKM5mp/OkZwkfBtPpKwu
	stQ2mMoDE5oL2SlZan8qpHRMfiQ5eNBQD/SwIQcWu9kbYWwTAL5AcPulHEHeqhC2U6zoEj6caCn
	ZoNFcU4u7oO2w9YAhtcUKbV5PHXsFGbftZEiQ8VV9lDSsFwz0Fo8Sreyfr/pJ1sKXqimQ1O2oa7
	h46RowbZGmapi5qDYRWmLJV8ikrUA31J5p6+75p515qSCSVI5ZAJvBjT0bEIp2FbwMs+f4VfVlM
	pPQdqz1y+YMREuFqefIt7SQc/5d1Daakt849YX7Pqqr7X/dzfwB4J14swCnp1iExYW2GlhfEedz
	NOcdeXhmWIeG+9pAZ/S1z/VI1dJNpuzK/5aLprKt9i1wm6H30wApoPD9/47N2ZZa7p5gEXFHTCz
	vvyBQXYj7K7BRVy0voSOZaSwJ5WQ==
X-Received: by 2002:a05:6000:2282:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43d292df407mr31359155f8f.39.1775646656473;
        Wed, 08 Apr 2026 04:10:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm61649889f8f.8.2026.04.08.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:10:55 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:10:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	yonghong.song@linux.dev, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to
 klp_patch
Message-ID: <adY3vej2kt5joAg4@pathway.suse.cz>
References: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com>
 <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz>
 <CAPhsuW7JhtbniZHFWGMrzeqdS=-EjCySFPgiOBv0zKJNRwzONA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7JhtbniZHFWGMrzeqdS=-EjCySFPgiOBv0zKJNRwzONA@mail.gmail.com>

On Tue 2026-04-07 16:09:39, Song Liu wrote:
> On Tue, Apr 7, 2026 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
> [...]
> > > + * @replace:   replace tag:
> > > + *             = 0: Atomic replace is disabled; however, this patch remains
> > > + *                  eligible to be superseded by others.
> >
> > This is weird semantic. Which livepatch tag would be allowed to
> > supersede it, please?
> >
> > Do we still need this category?
> >
> > > + *             > 0: Atomic replace is enabled. Only existing patches with a
> > > + *                  matching replace tag will be superseded.
> > >   * @list:      list node for global list of actively used patches
> > >   * @kobj:      kobject for sysfs resources
> > >   * @obj_list:  dynamic list of the object entries
> > > @@ -137,7 +141,7 @@ struct klp_patch {
> > >         struct module *mod;
> > >         struct klp_object *objs;
> > >         struct klp_state *states;
> > > -       bool replace;
> > > +       unsigned int replace;
> >
> > This already breaks the backward compatibility by changing the type
> > and semantic of this field.
> 
> I was thinking if replace=0 means no replace, it is still backward
> compatible. Did I miss something?

IMHO, the semantic of the no-replace mode would be strange if
we introduce the hybrid mode. Especially, it would be strange when
it can be replaced by any livepatch with random replace tag/set.
Also it would just complicate the definition and detection of conflicts.

I am going to provide more details in the reply to Yafang.

Best Regards,
Petr
