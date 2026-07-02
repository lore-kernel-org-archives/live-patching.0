Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D793D45C5
	for <live-patching@vger.kernel.org>; Thu,  2 Jul 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979178; cv=none; b=d9buEHS7CbgP4bQIz8KYQBX+dx2UJiBRHGGlQ5juuhJ//P0shd0MipdyvYx1Ebgiuqi73X4w/aJ7bncSO0ubFVQmg4uN8oRQB+Gml1wR+oJD0pFrJXMjQE8TPNm4FkhELqiIidC8VRJzCamAf/9W9G+/iRmmJVx3AgwfuI8bY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979178; c=relaxed/simple;
	bh=vRg8ejT1okP8H1BKFX7RnjGT4nGLmJ/GIqUOTUeg+rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVvtVzysZ45mDOvpQ7ShmvyYQ88FzQEwXwVTUOpLDxidZ08LyNsjRx9A7SwPonG0Mx/d8ZdEVeM+gjYxCMxduC6BdpWb4h/vIFdOsT7KDyJ07IEahNbfEY1gWRiK7U/9Nk3gYVufpOwaNh74H91GvSjPDsBbYCIJsdVXPf4VzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cZo8RGxU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cZo8RGxU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso8153225e9.1
        for <live-patching@vger.kernel.org>; Thu, 02 Jul 2026 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782979175; x=1783583975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKEK/klaSvR3KuXzn9lBRdKv/DAV0otTqYE5Q9JYbWE=;
        b=cZo8RGxUYvhTa3g25cb7mgXWFIp95k2Vo8KiN22NvDp/JHTpx704992vzKMWFOKvaS
         hs6rsKSWNuhf2GfTq1wrwrFb2I3kWD7SmoRGyNhv8tUrOtbtWvpiFnze+nklIJXaYtnp
         IRWv8i7156SAV00ltFmGS9gyb6P3HoCAkJ6VD6/KXJMkfz4eQmx68QSSnHBCpvuMV9h3
         tHtuEJLhGatfNrSAfq6y6owcJih4R9oMTDqnqeg8udgTENCgBq5Xcb1C7DaHw/96H4Iy
         JXe4/Lb/yJ7y/T3yu4BGrvGqn2WwlpSBC/FLOOJ/2BszDJ/F+RYHwyuph9tX3Ol3l8wW
         uZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979175; x=1783583975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKEK/klaSvR3KuXzn9lBRdKv/DAV0otTqYE5Q9JYbWE=;
        b=WKwYXNbJU5JpgrIgYuo0g1HRhOXRt18incPbteGl+upG79bFBmd8V9bcGcv+bvd53Y
         jSitlH8TyET6ZKjXSqpL/nSV4yCBcX+TWskx+kiHWcYclaM2YqCrS6RV2vhK03PJd79G
         RtsiJNpR9/favPIOYJFITUjIk1ixJokz3BbnhJj7tg8JlBuOcvcybHX1/yjhc23tqtoL
         Pmbjtec3L956viy7gXLqs9WIzedPHyY4ZxmuUOrRDlptWMIMiU0TMEiq8tPg9f6enH/4
         EVZULP8o4HBxEvEz+GchbbfgNWAW8YWyqZowzFGJ2RD5PGzvehSFHeiUQ4tukCN/al3y
         /+Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9uhSNJ6aHcELve30cduv594cS1QnRiZm1lvpWPrWZS5blv2DIAbQA3AGdb0L2RJsRguC9VJh6IAGwT/Oxx@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYyWllY8irSGhnxLlBhKt0PDZA89oQrssPUALr3JZ3u34Wo05
	Hdh6Ic4FfpcfR28R4Qgrrpp4ybx+jP7Cd7tceZJ0fGTsVPm/MbLI3QR6L0rFYhDDgxyFSo3FZdr
	Ign5Bexk=
X-Gm-Gg: AfdE7cmee1x1GJc/6yzXYDvO1wDpf6R+k1gLuMqPXcHeIs0o47DE7wBVMQTaotYmOx2
	HaMmAmxsBZbMnfveXdWDabFvxIPtTJJ6FXPkYwx+r0Ev055gDSiSBRdW3IvII4egt2vSO/Ev7yT
	EUP+Ct3LkUXGuFQC7PvN18QPffiVz8hkVQ3xZNv7dFxLJMm7PWEFXkGMY3oUAZq8iArgSqU0fxw
	hTusoJuegogAbaH6kUGo0iIHcnFlGHXWiJe8i+s1AOpf90ogfYNzjfs+YQUIwe8nWimZLe09GLe
	nFgBDD9PFTHTEoCaCiFw8FXbfA3WjSXbPf/Yub4fQQkxEmA+m0TCH4i0KSui3eCN8bnkzmOwwyb
	690DdKDv687e/n2DZ7hAe3og1tI7+mIl/9A6f2LTcJ8YL6lWCCEGlWJdy2Q1d0ps4qI/iQaUTJo
	UIDFzcQokNfuQI6r4=
X-Received: by 2002:a05:600d:8649:10b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-493c2b904e7mr57036485e9.22.1782979175224;
        Thu, 02 Jul 2026 00:59:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6372368sm31052355e9.12.2026.07.02.00.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:59:34 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:59:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/2] perf symbols: skip livepatch symbols
Message-ID: <akYaZf228lnNLQbp@pathway.suse.cz>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
 <akWomlgaxlvkBwkX@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akWomlgaxlvkBwkX@google.com>

On Wed 2026-07-01 16:54:02, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jun 26, 2026 at 05:21:38PM -0400, Joe Lawrence wrote:
> > This patchset fixes two minor perf bugs when livepatches containing
> > special so-called livepatch symbols are loaded.  In both cases, perf
> > should ignore these symbols as they resolve as relocations to kernel
> > addresses and not module space.
> > 
> > - Patch 1 fixes `perf test 1`
> > - Patch 2 fixes `perf record --kcore` bloat
> > 
> > 
> > Testing notes
> > =============
> > 
> > ("perf symbols: skip livepatch symbols when loading kallsyms"):
> > 
> >   Without patch:
> >   ./tools/perf/perf test 1
> >     1: vmlinux symtab matches kallsyms                     : FAILED!
> > 
> >   With patch:
> >   ./tools/perf/perf test 1
> >     1: vmlinux symtab matches kallsyms                     : Ok
> > 
> > ("perf symbols: skip livepatch symbols in kcore_copy")
> > 
> >   1. Baseline = pre-patch perf, no livepatch
> >   ------------------------------------------
> >   
> >   $ ./tools/perf/perf record --kcore -a -o /tmp/baseline.data -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.221 MB /tmp/baseline.data (1717 samples) ]
> >   
> >   $ tree --noreport -h /tmp/baseline.data
> >   /tmp/baseline.data
> >   |-- [ 235K]  data
> >   `-- [   50]  kcore_dir
> >       |-- [  11M]  kallsyms
> >       |-- [  25M]  kcore
> >       `-- [ 1.7K]  modules
> >   
> >   
> >   2. Bloated kcore = pre-patch perf, with livepatch
> >   -------------------------------------------------
> >   
> >   $ insmod kpatch-5_14_0-570_94_1-1-3.ko
> >   $ ./tools/perf/perf record --kcore -a -o /tmp/klp-bloated.data -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.274 MB /tmp/klp-bloated.data (2757 samples) ]
> >   
> >   $ tree --noreport  -h /tmp/klp-bloated.data
> >   /tmp/klp-bloated.data
> >   |-- [ 288K]  data
> >   `-- [   50]  kcore_dir
> >       |-- [  11M]  kallsyms
> >       |-- [  68M]  kcore
> >       `-- [ 1.8K]  modules
> >   
> >   
> >   3. Post-fix = patched perf, with livepatch
> >   ------------------------------------------
> >   
> >   [ kpatch-5_14_0-570_94_1-1-3.ko still loaded from test (2) ]
> >   
> >   $ ./tools/perf/perf record --kcore -a -o /tmp/postfix.data -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.274 MB /tmp/postfix.data (2763 samples) ]
> >   
> >   $ tree --noreport -h /tmp/postfix.data
> >   /tmp/postfix.data
> >   |-- [ 289K]  data
> >   `-- [   50]  kcore_dir
> >       |-- [  11M]  kallsyms
> >       |-- [  25M]  kcore
> >       `-- [ 1.8K]  modules
> > 
> > Changes
> > =======
> > 
> > v2:
> > - Move klp symbol check into tools/perf/util/symbol.h alongside similar
> >   is_ignored_kernel_symbol() check [Petr]
> > - Use KLP_SYM_PREFIX instead of inlining it [Petr]
> > - Add similar check to kcore_copy__process_kallsyms() [Sashiko]
> > 
> > - Note: Sashiko flagged a pre-existing off-by-one in kallsyms__parse()
> >   where the symbol-name loop could write past symbol_name[] on overlong
> >   entries. That issue is unrelated to livepatch symbols and was already
> >   fixed by Rui Qi's 68018df3f55e ("perf: Fix off-by-one stack buffer
> >   overflow in kallsyms__parse()").
> 
> Petr, are you ok with this change?

Yup, both changes look good to me. Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
