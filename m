Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166A329E5D
	for <live-patching@vger.kernel.org>; Mon,  3 Aug 2026 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726325; cv=none; b=Xlw4vqVdfrK5Tnuo4SGybQ0bC9wRTnx5WODOsbJru6e72OZN+RPLUAtBwbyx62eDbIKBH1q1g52y6pxoANrMz/+/mSc4LEm5qLnn0duwon8AE+czkP5uemciF17ft9XI5rV29Dq+xcczleLyW59uJ+7RvXHpHQO0NzxrIpAdMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726325; c=relaxed/simple;
	bh=CvqhaJOMzp7noYaEgzEmw/TC3TEhWPgVF/4BmeuCk/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyogBxLN40nOulgSLlGfbOdiGDqXKDUq3EO7TbN17IBUvgz7CxDRoHYMKpmCXd/cFxgsrykd+m8qZ+YHiHgVIja/OjC5LXhtl0RHOEMUQfipbPOaKDriEeJIARPZOWgzF4Uwi/AtEfwyKg/pTIk6fHJQ4pLfOHLe5rEgq7Dsm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY0on4H0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nfaCKKcP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY0on4H0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nfaCKKcP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785726322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3jjpiniO3TLp8NKn3IV3oXA3rMsPuR4g8mzmo0i6UQ=;
	b=CY0on4H0yYpMO4+ohqexxmzptuE2rmgABOjaUCkoJeyCmi8zIQ2iNbmJhIc6U19MiV2FnX
	oIrg6TziubLmE8Ra1lxwIzaltgSZMErEKmAs1OYDRykIdNM1d88i1u3mCpxBximsu8EP3K
	0qhVbXt9dy6blKfmZbxKOq/fVBh4p9g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-926J6hOYNTqeK8j3S_5Gqg-1; Sun, 02 Aug 2026 23:05:21 -0400
X-MC-Unique: 926J6hOYNTqeK8j3S_5Gqg-1
X-Mimecast-MFC-AGG-ID: 926J6hOYNTqeK8j3S_5Gqg_1785726321
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8eec6acbe21so62969216d6.3
        for <live-patching@vger.kernel.org>; Sun, 02 Aug 2026 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785726321; x=1786331121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P3jjpiniO3TLp8NKn3IV3oXA3rMsPuR4g8mzmo0i6UQ=;
        b=nfaCKKcPaVJQ3nxdu3hQ5teWDr1hzawTAHXOPmoxIZn/szxz1VltKdtYLR8ZQKYy+K
         +4n3sklQ2+xfofGKcPYdo2xWsX+K7D2RoGuXF0r23UU8oG+cdoXwj7XM9ndC03LlUP/7
         h2cBfu6rQ7yvhYPYE7jk8MopiPSFyP1cJUeZnnZ6jSOyni9+ELQvfqofUiAsvZG6ditd
         GjJdpxJ05Gk0/hZxsTv0wA5hL1B025FjSEXlpdB6lRDC/L3j5oM1EFRjkU+rYYJz99fZ
         iqovWMQsfTHXH1bim/QqeRI/TkDLOZ4qNharzizrIImnoxw3FXE0UlXIRiLejugvi5il
         UcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726321; x=1786331121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3jjpiniO3TLp8NKn3IV3oXA3rMsPuR4g8mzmo0i6UQ=;
        b=p0R78pxoeEKO2ZGj2qdx+o5WxxP/rQ3WrmSIkif8syojmw1YupjLmKsFxdaNy/lNW3
         cC76eBpXaob4b4ix+r44fDnJnn1G/b4rUCBWbJENJ/CFw+rs2GO3SGndpXfqer+iW7cR
         mXRl11fsKsaBqxOKwj+htJyNNAuvKzbM/dPIaJtUR66ZmmQ0nDTiW0CoBPVELQBvwTNS
         r3d6xoH549xrWUo6UkPQkxzbkvNqRBThehm421f5KYa7Bm9uvqiYhxMb+lTO4oUTODgL
         UMTlICPy+nMmvJQ7Q+1Bz7zOBDih4qjDFHjl2J/+Mw59c1PuiiXGI77A64j/qmeVZUtD
         v2NQ==
X-Gm-Message-State: AOJu0Yx6fmYbZctolGgjQ3Fj6EjWshK+tdgkmpz/szWY8JaOIfN3u9sS
	otD4/ii00/IeZWJJ3i6gPgH5dAEVQi+sChZbJOv3mwu7bpNq67u0Sy69BpoPHSK8wwhIB6JjrAj
	mXNseMxx+ig2HBFCSBLKi/MrpNlVjJ25Y8+y+RdjbtYSDTZG5BLX65J4YdsR1MAP3x2CcOMBn0u
	c=
X-Gm-Gg: AR+sD11WHqepKOieYAbSpbMoqWe94s6cZNcO6B0sv+/7NhYoj/W/GncCN6zFPhUOspT
	aSN/9BCJs4Mmt5MaSUJSqFx2uMo9HY/f1peYKCkatQNcG3kPq3rx8zeiZK90Q6/A7uW4xSBtRen
	vPDBEAXXgDcIQjlWLI5Ob5T4kksEyyFC0uo38RqueOoZdnHaYr3bE7Bugiv83/79la0hfWlOGIs
	cIl0dgCUnEiaD9SBzUb7Gn/BciKulpRIAIFeM5H5Od8yjqhqb+mDXMfn6V4nZ1GtlNRNa8eRwty
	BmhJCC6x2z+t4RjpLHOmAoi6w6X87biXT7KljDTA3q7foIKICSXCWu0+hdgjBqj3KAyyfVM=
X-Received: by 2002:a05:6214:84d4:b0:908:4a89:587 with SMTP id 6a1803df08f44-9084a8905acmr167260786d6.25.1785726320690;
        Sun, 02 Aug 2026 20:05:20 -0700 (PDT)
X-Received: by 2002:a05:6214:84d4:b0:908:4a89:587 with SMTP id 6a1803df08f44-9084a8905acmr167260486d6.25.1785726320234;
        Sun, 02 Aug 2026 20:05:20 -0700 (PDT)
Received: from jpoimboe ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908436072edsm65322056d6.46.2026.08.02.20.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:05:19 -0700 (PDT)
Date: Sun, 2 Aug 2026 20:05:16 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 3/4] objtool/klp: reject new cross-module references
 without existing dependency
Message-ID: <vmtvk7v2nehsiudwkvsjf3fqa6l2ejmkmx3jftmmuosif23qdm@4ivl2segtrgw>
References: <20260720145658.1103243-1-joe.lawrence@redhat.com>
 <20260720145658.1103243-4-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720145658.1103243-4-joe.lawrence@redhat.com>

On Mon, Jul 20, 2026 at 10:56:57AM -0400, Joe Lawrence wrote:
> When a livepatch introduces a new reference to a module-exported symbol,
> the resulting klp-relocation will only be resolved at patch-enable time
> if the exporting module is loaded.
> 
> A future commit will remove livepatch module dependency references to
> facilitate late-module patching, that is, the pre-loading of the
> livepatch before target modules are loaded.
> 
> If the original (unpatched) module already depends on the exporting
> module, the dependency is safe: the module loader ensures the dependency
> is satisfied before the patched module can be loaded, so the
> klp-relocation target will exist.
> 
> However, if the patch introduces a reference to a module that the
> original doesn't depend on, there is no such guarantee.  The exporting
> module could be absent or could be unloaded at any time, leading to a
> relocation failure or use-after-free.
> 
> Add a build-time check: when a new symbol reference (no twin) targets a
> module export, verify that the original module already has at least one
> UNDEF symbol resolving to that same exporting module.  If not, error out
> with a diagnostic message.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

I think the previous patch exposed this bug, so I combined them into a
single patch and massaged the code a bit.

-- 
Josh

