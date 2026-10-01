Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4635BDA4
	for <live-patching@vger.kernel.org>; Thu,  1 Oct 2026 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829155; cv=none; b=FXTCj2gXLKa6I5LXV7/mZsi0nalrDvFQKn4yccZ2b1KicOFu7llJL5F41x3igfR1jSnp9SU9jq12zutG0iArs7XFTHS26ARxwUTGZjg+dxtvj7JFnuQDEw3oSbQT0Q2D6Fs0Ml9rmRVCqfVqYeYSe15rTCdLAVioGWB2IWegeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829155; c=relaxed/simple;
	bh=2cdXcBFEwI3jjzLipmLP0911D2tzhGvFyo2oGd1W+H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBKJFAt4w9XEYtGhd2ltPuMzmuzEg5s8M6hhQc3O1LSGWFK5NlsYDMYGwG9gshIcKKmikq6fOKCOLTZ1g0hy93D8YRzhGMqONDeXJKRkT4XeHsjDI58DZQH1dQ3zOnGYVMRIrROT+4JHCeNFJ4CNtsNZPRbxXKOkPCq8kMy0DeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnt8cTOU; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnt8cTOU"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so27375615ad.1
        for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 21:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829153; x=1791433953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elrhZUFLcXcRp6X3/p8YCNVRVzWhHBdMXnMivKI+qJc=;
        b=Mnt8cTOUziV9v8EX0nwjrZE96FK8fkoumiO71CPm2s8k+pX6tsTsC3AH5yAm4/IAfs
         Lhy0Z7HX5pdJsjKwNR0MWTycaH66fe3igF0bd3XouOalSYzLDC/wT3NWaDIFgZtd+hdl
         WAqUMCicFtba1DAn1tnMVAIDTWwUcRAynaf4EBOglQhqzuKvebvUwku+GdM+IvglSqW1
         F48c/P4pQtj++sou39CioJZYOVojUXL9g+YlzGmCciTZWkQ7UbeGDUYRJM+Z+qG2XHI0
         1MNXQn7vvcvJ1Tpt5bzlxSoaKxEjx/uolSJZJLuQSmUedBLZVxl1DPpr4HqW868zIqgu
         9FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829153; x=1791433953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=elrhZUFLcXcRp6X3/p8YCNVRVzWhHBdMXnMivKI+qJc=;
        b=jh2vITUuciQdTV2k65jTdVSKorwEskrodGXKcIHa/mEirnpyzzzvT/gulO7g82gIZO
         ng+DU5BQgj7dIUinAUvdb96FtHZrZfKjHaUuhBb9l71YIFL+JjvToz2cXkbVSEUWCQAp
         R2uF9wpoK5xSDLWAUlzN9CZYmznPg0dzCJ7T68KouxGSfd59wHOmnbFFqHt2+FtuwKxk
         c/LBQ2vokcIwq2cd9Ev2CJ0hhwZUGLFFpzxSauz0CWKCYT1CuAiv8LluYHj9Nq7Ip5T+
         WIOe/iNK0Fu71q+Pb4UNUGErUvwL4MvLAYnHCOaaOXJPJdWu68J4nnhMcZqmiKKHNBDZ
         7LCA==
X-Forwarded-Encrypted: i=1; AKwUvBwbAkjEDtl7U6G2UzhFQI4pnGHHdaRcBB8zhjt0G/86RU5hgPk2RSNblEVbKTnGuMslHHByTWGo4qdIuhZS@vger.kernel.org
X-Gm-Message-State: AFq9FYLxoIOrxkxkU/ebGDL2k2vpVmSArZxlcZ9ShPtyFBjpsSGM21LJ
	5Q7uCuk/G5ex3tYQ83YdYUBWLWDH+zI5uuIYcr2GOfwZfd6CNtM0rL09
X-Gm-Gg: AYBFou26IFhCRbwzG6NXzF3vnS3JAy76pyvKoLGV0oziG3INQSHItLqF7x96H4D2h1N
	1TiTiqME/WyapWmAQu4t/vMwR2QHdbZWnorM1T5p3I63B+iSua3+VOPyKv25L110XYW4wcK2hYd
	P3CntROekYzErXVkEKnEHFKyVC29X/ZUEosUApZnovzf6IVGykZ63Ca+dLTb6093h5BC06BO3Gs
	3ulSKHynr+2wqIf+a56ayaJyJFc1GtC6Y8UkhV3tLn7OU5OTMqwrxFoRDEipWhaEBxaabU/rfeQ
	Icce8dOq4Qt2CezQWHq/ShC9YMcRIzXaDIJKsJs0ji0CoOPIuRrIJnbdgGtxh2erdzggPnbM6cs
	hmAp6nMsW9GxpyUJLHwSkt8JYL20qpJkJHKsz0h6gGfsNr9p1q6fNjzOr2dxWe2l/H234AltRcy
	nyaGAsLxE+eBazkQhLUC0gT2Xihcnz3x1h0qDMTdte0iGoWxvQrdGNc5+ghtHuYzX77dgayO2kr
	+385g1bZykJ/XgZ1Dz78hBbDrAZrKkdn4aMqiwpI2DTLBgyTaplsG1qvWvVIfFGuL/HJG5FHkc=
X-Received: by 2002:a17:903:32c3:b0:2df:90d4:1188 with SMTP id d9443c01a7336-2e2e4939452mr28042805ad.7.1790829153200;
        Wed, 30 Sep 2026 21:32:33 -0700 (PDT)
Received: from lima-arm64-dev.hitronhub.home (180-176-144-38.dynamic.kbronet.com.tw. [180.176.144.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300a90dc9sm4921885ad.18.2026.09.30.21.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:32:32 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: mbenes@suse.cz
Cc: jikos@kernel.org,
	joe.lawrence@redhat.com,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	pmladek@suse.com,
	sashiko-reviews@lists.linux.dev,
	shuah@kernel.org,
	song@kernel.org,
	x90613@gmail.com
Subject: Re: [PATCH v4 1/5] livepatch: Fail object initialization on duplicate patched function
Date: Thu,  1 Oct 2026 12:32:28 +0800
Message-ID: <20261001043228.74946-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz>
References: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026, Miroslav Benes wrote:

> Could we also check prev_func/func->nop in the check in
> klp_init_object_loaded() and have a pass if true?

Thanks for the suggestion.

Yes, I've updated the check to skip the pair when both klp_funcs are
nops. Two nops added by klp_add_nops() for replaced aliases are
interchangeable, so an atomic replace patch that inherits nops for
__do_sys_fork and __x64_sys_fork from two previous patches now loads
fine. A non-nop func colliding with a nop (or another non-nop func)
is still rejected, since the nop would land on top of the real
replacement on ops->func_stack and silently disable it.

The incremental change on top of v4 1/5 is:

--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -894,6 +894,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			if (prev_func == func)
 				break;
 			if (prev_func->old_func == func->old_func) {
+				if (prev_func->nop && func->nop)
+					continue;
 				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
 				       prev_func->old_name, func->old_name);
 				return -EINVAL;

If this direction looks good, I'll resend the series. Petr, should I
just bundle everything into a v5, or do you have changes on your side
that I should wait for?

P.S. Sorry for the second mail. I forgot to quote the message I was
replying to in my first one.

Harry
