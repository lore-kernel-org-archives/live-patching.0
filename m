Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1A31E855
	for <live-patching@vger.kernel.org>; Mon,  3 Aug 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726258; cv=none; b=ISk4MZWdvaqxMyeqQOJH2LZc5gSEgfzd3wz9U4JOd/atEEoD1OYEGDX3jCHBHpWZHFBtPpRHJq5uX+TaOPXApHfKTumf2oCS+9bywEq5KjOqu1NmxtoZsvhEnseVvFmHlwj9AbgCfjU0T/JFW4pQ49B9Ch6Ho6u71PY9On73JpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726258; c=relaxed/simple;
	bh=op1uvfkiitjlJcvl7/XSLBJUpq4e0ubErjdG7DxM7JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2lOD6ip1r+Lx532yRSqdirF0xISPM9rniK9GOrhR/qCJKDJMrzAM/v2P8ptqbFBbhIVJifDlkTKNMzGioMaBzTEmW9r2OOYNVgSh1wRGE8vOMVTOYuwmyeZ6YXEeK9S4wZTQWyTUlXxacCMy2N35o2g//coF9qR+HqZM1ncTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fheQ70iZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWf0xL80; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fheQ70iZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWf0xL80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785726255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUtcRnSqNtRgjZiisBWB494atT1AA+2pGvQqVdG4DTE=;
	b=fheQ70iZ8XEhRyXvP2b+ArD3O5ToYManmKWrUTO/Rv2GXAR0p7Wp0ZmuCk/WyyPdS+FoMF
	O63yAp3bLJafnNd7jeVGNYUqHwPKfm77YeE2ng3K5Zhxisoi2b40JJyFCSuMGHjxKEUf4T
	mAYKLbtYA2XUtaMKqzlfkBTnI1adnv0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-SyBzPXk2PWSxHWA5HLP0qg-1; Sun, 02 Aug 2026 23:04:04 -0400
X-MC-Unique: SyBzPXk2PWSxHWA5HLP0qg-1
X-Mimecast-MFC-AGG-ID: SyBzPXk2PWSxHWA5HLP0qg_1785726244
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso307675485a.0
        for <live-patching@vger.kernel.org>; Sun, 02 Aug 2026 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785726244; x=1786331044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KUtcRnSqNtRgjZiisBWB494atT1AA+2pGvQqVdG4DTE=;
        b=RWf0xL80LqzPc+2FyCz4XQ6HMod+Q1R8Tou/syfDjcw/JSHUcnHeMd9WEFlpA2YxYb
         i1eyyCfLS3lRRMODsIqoqUYHnNgeEjRGCzeU2RL87BEsosURl1nV1xk4tjP9hyl2tz6F
         PUOG9naPVFcK9mFy2wAc//RcBGLRXjb5u3q6yUamYuUO1X2vkczIaudurHFNOzJhsxRf
         8YEKZTp9MiMiLjz1dtny0cu7fYRd48dm8qtffNFkHdU0+YprvuU7M+W2WA5Hn9Gh/bho
         Ee94g8upClJt3X6Ls+u4Z1H6yv51Dk4dwPViGybBBXWuwGtINJcUBjuxEmgLTaiYIr9Q
         Jptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726244; x=1786331044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUtcRnSqNtRgjZiisBWB494atT1AA+2pGvQqVdG4DTE=;
        b=D7HqSML9hxerHsnkoGyq1p8UgqSs+w85Q3rcBwz6SJvhy3RUeNUjGUtpIhI5AngRdl
         UvGfYmW9AF3+QlyyOcWycOQ3RDvPu7Q25VV1qMRVEIRmEVbeGQhvatBl7nyXZMyGbHUJ
         yHcDG/HD9op2/k6i8kovm+eLyBBTjUtyoebTL4YUDtnS/tSLQ4L0PPwkDIpOAS3pj/u7
         NIyOst2t5J8oN5jFHN7ONX9ke0EKJ/6Ggx/3N+wgdEBMv2JTq++z74UhyyLD/BJViCKY
         5FNgE3x+wBZzZ4+ekOU2tJ1sS3e9aY8ec0xBa4ZVLhXC4DpXkCDo5UO/gqVc4K4mwtTc
         asBg==
X-Gm-Message-State: AOJu0YwXzW34vVIZhskAOwrna8fNRmICV+e+YfIBP9sDRXOr5mS9G/fm
	97+3fzWfDNPanb5hTQj21dgZ2ujTNycBVROgoD5XjZC+GvxvbvxT4fHLPkQK2ioJuD1vORxFgHL
	qPqlICVUaYsPwujfyl9vgyT69lX7LencBj/sodlFZ9Z9OK4dW+iASr4reclmWJV/Y5l4=
X-Gm-Gg: AR+sD10g4cb1PRZmBN6eKCewnzYBBX7fAwTor5DW2D/1q/U9nVEw92RCUdFXbkjZJhz
	Q3/OHICJI4wjhiPoWziQyaHLChskxZCFs5tsifwOYTM4Z6KDy2aUvkY5QXzv1qpIm4Gusw2ib+V
	xcfgcLcZcPat9fGApdXkXKb7WWydNi3r0nT/XXqzBaSTOqy924c2NU7ffXsxJfo7+w9TBaSorjv
	+qKlpyrGwi9WCT1PjkFQnGIKFKWoCy4pee8Nbo9eU3wxCVUFU+w1APKG4Qb9qX+yPG3J/lzWMwE
	z3rrpnxi8JUpeupYspvK0iq2WgB8wJzUdg3lMSL8BG9r9wmVJvjJWkCi+aOsfPPGuAGJ5OY=
X-Received: by 2002:a05:620a:2b42:b0:933:ade:2daf with SMTP id af79cd13be357-93499b2e3f1mr1787486285a.18.1785726244119;
        Sun, 02 Aug 2026 20:04:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2b42:b0:933:ade:2daf with SMTP id af79cd13be357-93499b2e3f1mr1787481885a.18.1785726243578;
        Sun, 02 Aug 2026 20:04:03 -0700 (PDT)
Received: from jpoimboe ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c207e64sm570618585a.47.2026.08.02.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:04:02 -0700 (PDT)
Date: Sun, 2 Aug 2026 20:03:59 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/4] objtool/klp: use patched module name for
 klp-relocation section naming
Message-ID: <gte6frofwqfzedcqq5juvuszopk4tobooz7iycqigqgjadwsmc@j6v57ud4aq7a>
References: <20260720145658.1103243-1-joe.lawrence@redhat.com>
 <20260720145658.1103243-2-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720145658.1103243-2-joe.lawrence@redhat.com>

On Mon, Jul 20, 2026 at 10:56:55AM -0400, Joe Lawrence wrote:
> Documentation/livepatch/module-elf-format.rst states (and the kernel
> currently implements) that the name of a livepatch relocation section
> must conform to the following format:
> 
>     .klp.rela.objname.section_name
> 
> where "objname" determines when the kernel applies the relocations in
> this section (i.e., when the "objname" module loads).  This allows
> relocations not only for currently loaded kernel objects (like vmlinux
> and loaded device drivers), but also for lazy resolution to facilitate
> late-module livepatching (for modules loaded after the livepatch).
> 
> Previously, objtool's KLP post-link step derived the "objname" from the
> klp symbol name, which encoded where the symbol *lives* rather than
> which module is being *patched*.  This broke cross-module references
> (e.g., can_isotp.ko calling can_rx_unregister() from can.ko),
> incorrectly placing them in the .klp.rela.can..text section instead of
> .klp.rela.can_isotp..text.
> 
> Fix this by adding an 'obj_name' field to the intermediate 'klp_reloc'
> struct.  klp-diff populates this field using find_modname(), and
> klp-post-link reads it directly to generate the .klp.rela section name.
> As a result, each relocation correctly carries its own target module,
> regardless of where the referenced symbol originates.
> 
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

I fixed this one a different way by putting the objname in the section
name: __klp_relocs.<objname>.  Will post the patches soon.

-- 
Josh

