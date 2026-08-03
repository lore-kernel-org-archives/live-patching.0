Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9410332628
	for <live-patching@vger.kernel.org>; Mon,  3 Aug 2026 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726381; cv=none; b=TmvGa756nCJNcrN4jvMa7INSBy6EXutgC6sK5tI1vzfj8J6t63VdyfSA6NH85X6cleI8/6lzfkIkJ5iVGUS36zqw1q6ZgwZYD5N8Q/6CbFb0ZjQFtz9KkXHfCO+LsBOTpMGH/It90JhG5scudEjOWsEj05yUHwkRtPW0f5QYJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726381; c=relaxed/simple;
	bh=ZtwZq/kCAeMwn5NwURMZPhuNB48Wis7NnEYjFVkLA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg2cnUX0iskQogrJbzkkT/MX9r84SNwDp+I+gXIzqnRX/s5hX+RkNSDSzX80B+zHL9NehK5+UVmU19yG4m0yLq2TYw2FmIJ2yYQ7pk+UpPLbAAUCfQVxw3zPlUEPexx/Hdmip73YXgyBEONCvQN9SVMIeT5WSBT0scSDNX9oIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JL6t0zaN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ao5FoOeN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL6t0zaN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao5FoOeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785726378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2psCU+3zZ668SmM2CDNU/cclrNBYedaBPTmJ5ydt5A=;
	b=JL6t0zaNA+Cbic6yh+qz6fvTRrYOiBB4aNSafo4OTyFzouFOC7iToA5h+SeroCICjjRBT2
	w5bONV1dHbK0oD3akW5oyQChEeO1iiAvdICbXoQPlwFjFfLNEQ1xy/I1s50IZT/ixV7WST
	45uV6kSRvU6tklNcYynPpEnE3tBqwc4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-O7fFkctbNB-z1fTZtBQ-hA-1; Sun, 02 Aug 2026 23:06:17 -0400
X-MC-Unique: O7fFkctbNB-z1fTZtBQ-hA-1
X-Mimecast-MFC-AGG-ID: O7fFkctbNB-z1fTZtBQ-hA_1785726377
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0f45415cfso33157466d6.2
        for <live-patching@vger.kernel.org>; Sun, 02 Aug 2026 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785726377; x=1786331177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2psCU+3zZ668SmM2CDNU/cclrNBYedaBPTmJ5ydt5A=;
        b=ao5FoOeNHYsVeGZGjTUd0uWdRYiAKKLagavpmCuZS5rpzdHBuvkzT1pT+SNXgbYlI7
         +eTvr0eS0K/1Nauk82cBcSJzEyTu/bCN8JuQyYfl6b0K8mVxV+f3Z2ujRARE1xi5zdtK
         f4iRraNk+4FqpjrxU9bZHz6uC3Wfa4YedZtOLGpdPlJv8sY1DTnHjoQ6X6ajAsdmpWfy
         ZHK0vd3knxcoD+O8/FRiLNN2BfDG4VXqfrOVZ6n6jsszOnPONecucWvupZQMPbNpdMIc
         fdEQopapul0wFndFkHQ/wFCADDDR9GeKS3EdJudwm1i++/1F1LGYGdXI/ki8IXZ7hUXj
         YC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726377; x=1786331177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2psCU+3zZ668SmM2CDNU/cclrNBYedaBPTmJ5ydt5A=;
        b=jmPDkk+VvgTDx0d2x5FX2+4VHJbRc2WfdZ3Ma+LgIyRtj+ZXY2GVUS8nX+1WeCYIBj
         qhyNhaWocH2u03nqVSbn3GcmsSn8avTKvcMPe4H3qzZK3Pigj0EHf18J+oLHK+WORbtY
         yGuwbdO1zPceSXTWei34jsUV2m6CnqalIEMN+2IORdMxKOlfsirHlrGFOitftGRe8i7o
         FxLFv2NU+TLusl8ayJBvlJjTCPOxm6NhyecFjTGhhcGCIDE/mlgEfHmC/RLhP2GjyTGG
         RPbLnGURnnbmbY+6F8vIsQM+guPVm+F0k88uR63G1tOexRGyOdZhzC7AvDP+kDQXjW1l
         MGlQ==
X-Gm-Message-State: AOJu0Ywd7vSTU7vOAwTbz9oO4PGJppVp4raFqJR+uTzhsDW8oIJwdlxW
	8i2YtT5RQtFK6SgcKVzZMSqNI2w2G0nvL5BFZlf3Kde/sTI2WKw7XH51gCc0fqF2PnUCuf2m2lV
	DRKYEQcZRlWKKTyz8azEesDpaec8WX/dbN76utu8OQKl6hVWbd0v9Jx4cM9joVjKaLTw=
X-Gm-Gg: AR+sD11WRZ8nQx2iqD4E1cBwTiEsBJd6HBnyx5+SlkpBR6WVp/TJxvv8FGDZrzIjkAJ
	ay2LQJzIzQXe64xziUznQDXs4RQpsV2w0TTlPnjQIMD7pn0V+1ES67utgr6I/hy90BVmW5A6IeB
	0Z9nutsBxojGmx+Y83FqC3u3XNl/VybklAQXO/WT2QTj3SojlZYTSbBaeea2eJqJSOmb4JFqwMs
	3fRRpL/bA2gkJcba8kvw27oVs/0q4ODGizAduRYTqnstJIoV8c/24Xx5uQ0ZZlhMdH07dDPLq5l
	YefJZGKe3Umi7vuEeqdYblXTI3juO4zhIjDwyrYYOUJgBjlD60fEVIK5OyAv+liDrc6mHeE=
X-Received: by 2002:a05:6214:54c7:b0:8de:ca40:c3b5 with SMTP id 6a1803df08f44-908496be40bmr189875726d6.31.1785726376886;
        Sun, 02 Aug 2026 20:06:16 -0700 (PDT)
X-Received: by 2002:a05:6214:54c7:b0:8de:ca40:c3b5 with SMTP id 6a1803df08f44-908496be40bmr189875316d6.31.1785726376346;
        Sun, 02 Aug 2026 20:06:16 -0700 (PDT)
Received: from jpoimboe ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908432a1e44sm65308406d6.2.2026.08.02.20.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:06:15 -0700 (PDT)
Date: Sun, 2 Aug 2026 20:06:12 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 4/4] objtool/klp: strip klp-induced module dependencies
 from livepatch modules
Message-ID: <7r7l7impvs5y2lgx3mjfo2wmgmtsbjla3qiu3dtpor3xrlvf4g@lmci63zeujzb>
References: <20260720145658.1103243-1-joe.lawrence@redhat.com>
 <20260720145658.1103243-5-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720145658.1103243-5-joe.lawrence@redhat.com>

On Mon, Jul 20, 2026 at 10:56:58AM -0400, Joe Lawrence wrote:
> The klp-diff pipeline creates weak UNDEF placeholder symbols for
> cross-module references that will become klp-relocations.  When modpost
> runs on the linked livepatch .ko, it sees these UNDEF symbols, resolves
> them via Module.symvers, and adds the providing modules to the depends=
> field in .modinfo.
> 
> These dependencies are unnecessary: klp-relocations are resolved by the
> livepatch infrastructure at patch-enable time, not by the module loader.
> Adding hard module dependencies defeats late-module patching, since the
> kernel will refuse to load the livepatch module unless all depended
> modules are already present.
> 
> Fix this by having klp-post-link strip any depends= entry that is only
> the result of klp-symbol (.klp.sym.<mod>.*).  The check is conservative:
> if any remaining SHN_UNDEF symbol matches a known export name from that
> module, the dependency is kept (indicating a legitimate non-KLP
> reference).
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

This patch is no longer needed in light of my tombstone patch which
should prevent modpost from adding those module dependencies in the
first place.

-- 
Josh

