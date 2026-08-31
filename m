Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B083CC7EC
	for <live-patching@vger.kernel.org>; Mon, 31 Aug 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165856; cv=none; b=LDsRPqHz7+IrJL451wSH8gMH97cAN587xYAH+LlDTT2HaR9hOpta6UrgpAIXqMIXeLBC7rD+FWQG/3tm6K1G8c0Wan8y3wm3cdHUmgEe3Ez5/pO76O5AaMN8ZlfrNdEgejVlsZQDQmCaKIRC2vvbLFpD4WzEpGPJ5ygzuGfuoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165856; c=relaxed/simple;
	bh=EPXi/i8/cLIOytc/4g/nQ5+sJUy3gys8AWpUeJuA7tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZj46YA9LWrxj9owZUjzSwdIgS9N0fhSf0CReFPrfvSD86J/pMIANKdHA8RPH0hmo/PzbvMfQt6KGjWFyb5/OVo83ydqgFC1avkEAkATAVvxYGNS0SEDOVCtgx5uJV+amaMGKGFE9cPw9Sm5NI3ls5bfPNnOnklZGud3GidgW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FgFH8d5U; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FgFH8d5U"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48433f36a21so1065105f8f.1
        for <live-patching@vger.kernel.org>; Mon, 31 Aug 2026 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788165851; x=1788770651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/IdgWJ9SyaxkF+z2j2vaf53j2K61APsWhXnC/i9sVbU=;
        b=FgFH8d5UVfQoQeiuITU/VAtc7XVKlGdSbOhxhunVuyw6LlUog9ng7y5gXW+Uyt0SsK
         u4/cAgIUZ+Rkpolz2kDKzxV5gG8FUgekS2ZU0PJ2HN+9ccX7y/Sy8uqIK5FInfadaqd4
         RcVuhgZa48uokEtEcJIKyRLjnmMWE3znAI/u7d0bHR3pVAhzpS9l3KJPtZMfZu7EUocl
         QBuopjEy2zOENnAjkNPZlgj1oib00RQzQMXNWu/ybIn8W/PQT5JnDSUVt+1dYJIJPgGS
         y6llxvvOI2jgXoL2uKkQQpacnOG/NI+EV3wmt3GuwILKZPkcdyHrqSWk1s0K5Oz93POI
         wn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788165851; x=1788770651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/IdgWJ9SyaxkF+z2j2vaf53j2K61APsWhXnC/i9sVbU=;
        b=TOvoO0R8io6wiDD5HPeyI28xYhgiCz39zPgltimygfnk3RRqJqVYs8tyH3gQ5P0+R9
         soOE6JZuaqv3wz5rWdC0lX4Ej6jvtRMlFS5cNq2pte3MmqNA3h+5PUEnO9QcWSlL7MtB
         TL13zFcZjQCmVjMEJ3fUsGdMWC4fhE81aAWHs7QlAcQlGcZycRudiPeB0TSd+L1inB8o
         ePCYCzT8pGZ3VPzLwi/nti+gzlb2udt8TS0OUkoeJow6cGWmoJSRk/vqQeTvGlUKIj8I
         MCiK/oS7yR0I+osUMW/qclZAX7KGbgaIoHn/6M8i0dolrnjdS+VY/Qw4oaHRTDiGva4n
         rwFA==
X-Forwarded-Encrypted: i=1; AKwUvBzmxFxzGCvaqbf2tCuR5EeQqJU7xnPBRv6xBhXvtEpas73vDpa7ZHV7rAZOTOlp8/rJctruoR0r2W8tcvop@vger.kernel.org
X-Gm-Message-State: AFuF++nIvD7srguzyAmG0mZ0e1VIxF1K+VBHa1FQyVRUUclan9g2KtQg
	cmS0S0+yVPUPL4jVT8j7ESGnOyJQMq4M4klKmLQtOs6QftLSzUKu8pGbASSxoHqTbo3HzOlW0FT
	oUToTLvM=
X-Gm-Gg: AYBFou3iGIFfkYlY5xtcLiFzDVRI85LPdtyu4RBkwUpNWgs1Ht4QQRMVLL3rXRZONTR
	WmkG8ZuotzvOLb2NtAwPHT7Phj+2UbgnN3z4nthgAhl9lzsX3L/2qpAwCFi9IhtLsPqv0mUXizK
	Ci7iSHZ4dbcIX+ag4InPOBOkIfj9dTlDBEXaFcdAHFKXUDSXFN59rjG/E9NdfZEVjMT70Fc25wu
	Y6emfW6/D1XjbOsaNhAI7DFvywusLGy1JrkMRQV3VbOMxZ8ZN4zfVPHDZkO5iWxnl5vEtrJ0di9
	MVz4bln1J9OTN0wVRbQ8fGD7WvyDZrFNj/gG+M4SJ0NguNYZCSt+VN0nzkaEbCoenMNDjm/Gg8z
	I3tMqJ8q52cbfvHaiKI2VRIozNmWGOlZrmM4yrlmrk9uuWANgWSzztnmH6ry1+MNJIAA9Y+tuGk
	gDWZ4OLyFXbeyWNwD+W0Oww6RlSaTyq5f2doy9DIM7bFhSbRKpsj1Mvd0DffzXjw==
X-Received: by 2002:a05:6000:481b:b0:484:3600:35a9 with SMTP id ffacd0b85a97d-4843978e680mr12471515f8f.3.1788165851386;
        Mon, 31 Aug 2026 01:44:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48435b024fbsm12215795f8f.29.2026.08.31.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:44:10 -0700 (PDT)
Date: Mon, 31 Aug 2026 10:44:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, jikos@kernel.org,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] livepatch: Clean up klp_init_object_loaded() when
 fails
Message-ID: <apU-2f7rffaTUKWC@pathway.suse.cz>
References: <apBbjoEHJ98DWN_W@pathway.suse.cz>
 <20260828125244.509977-1-pmladek@suse.com>
 <20260828125244.509977-3-pmladek@suse.com>
 <CAPhsuW7Jr16Wyd4oEXKEwJPwX=p7HWLZTA63uNeu=13GYf+=Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7Jr16Wyd4oEXKEwJPwX=p7HWLZTA63uNeu=13GYf+=Uw@mail.gmail.com>

On Fri 2026-08-28 10:44:38, Song Liu wrote:
> On Fri, Aug 28, 2026 at 5:53 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > When a module is loaded, klp_module_coming() iterates over patches and
> > calls klp_init_object_loaded(). If initialization fails, it delegates
> > cleanup to klp_cleanup_module_patches_limited().
> >
> > However, the cleanup loop skips the failing patch. Each function called
> > in klp_init_object_loaded() is supposed to clean its own changes. This
> > works except for the changes done by klp_init_object_loaded().
> >
> > The current code is a bit messy. The changes done by
> > klp_init_object_loaded() should get cleared by klp_free_object_loaded().
> > But this function also clears obj->mod which is set by
> > klp_module_coming(). And relocations are cleared separately.
> >
> > Fix the situations by updating klp_free_object_loaded(). It should
> > revert all and only changes made by klp_init_object_loaded().
> > This requires some shuffling:
> >
> >  + Clear obj->mod explicitly in klp_cleanup_module_patches_limited()
> >    and do not rely on klp_free_object_loaded().
> >
> >  + Clear relocations in klp_free_object_loaded(). Remove the explicit
> >    call from klp_cleanup_module_patches_limited(). This requires
> >    adding the @patch parameter.
> >
> > Finally, call klp_free_object_loaded() in the error path in
> > klp_init_object_loaded().
> >
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://lore.kernel.org/r/20260823062313.1321B1F000E9@smtp.kernel.org
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> With one nitpick

> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -725,18 +725,20 @@ static void __klp_free_funcs(struct klp_object *obj, bool nops_only)
> >  }
> >
> >  /* Clean up when a patched object is unloaded */
> > -static void klp_free_object_loaded(struct klp_object *obj)
> > +static void klp_free_object_loaded(struct klp_patch *patch, struct klp_object *obj)
> 
> nit: Do we still need to fit every line in 80 characters? checkpatch.pl
> only enforce 100 characters these days.

I do not have strong opinion about it. My editor highlights characters
which are over the 80 lines limit so I automatically fix it. I haven't
found a courage to change it yet. And my eyes are getting worse over
the years so I use big fonts. 80 characters per line look good
on my monitor ;-)

Best Regards,
Petr
