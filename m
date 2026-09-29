Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA14E80C3
	for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672870; cv=none; b=AIxqhexWtS2J5lIufFRkebdsP/3ZjVSJr1R8edsadYLinqek9qatDLlve7zE1G/fdlhrsLcNCVf97L6PYkcApWrJnBSNWtRm4J9dZNVp6LQIhgXVp5cN90jD8l2BSACl3bKVSp2z4c9yypLT0Sxfmvtistip/9QBuCwr3nI6jE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672870; c=relaxed/simple;
	bh=fuapPkbLOBMrqBTo4RxlKl1AVJyeaxbGH+EbRQmteos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAKarBCwx250OWyCSImj016iAgFs0Dj80GLI9RXGddvts+YpUcY81uqapo4es20ZAmWvU7R0MRWEOiw1JMQm5xSM+xDa6vPXJpP7j1VlHnzkM2QMzqtJBJFrtg89iUx0dLhukR0W9mKBGe+yvQBwaA0NIqCuplnzMeUQfuIIyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HM9+8Jg7; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HM9+8Jg7"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so2281793f8f.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790672849; x=1791277649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WD5VyUREBeTWgWCvq7/SOd23MfZ7f7O+PL4C3K7mFuI=;
        b=HM9+8Jg7rg8UfB/waqWoK7+a30i6OmiaHb0OZkR2EvVBXRTu0k5kK9HJAA6jWv5vsh
         3TK8uga+JByYJIYzKRf3YYlEOzlw44v9TpJFS8Jqslkdb3Ur6h6qi/uM+wHduIWkJjtm
         S/3SA5VLR/gZn0UqGW0luGyWY8MqY03XNuMCmQknEuQ8+eh8iJB3xYagQpXtosqHph/z
         Sewzl3NsWLS0vtjVhdhtH/ebjd40whjPHt+vt+4ZzOhj2bgjn6Trh4IOL2prry6BNp4Y
         xHHX5TiPfW6PnhKEUz33wdQ6ab3XYSaOKBrpRTV0f5/u7y2jAmgKy2aLbH7KZ9y+3WBd
         VsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672849; x=1791277649;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WD5VyUREBeTWgWCvq7/SOd23MfZ7f7O+PL4C3K7mFuI=;
        b=iFaCVO81HepxVrrBAnRS5D0z1cSVxfn1sfjGxHDaw53K+Z1zW5H2zi17lIvKbUOEt0
         zIlVqtM8K5IdqI654LFBoMsjTx+cP3iDVbHDHbQkF093z9J/6dZMTlMclGAvldmyxRF2
         p+lNdnAuc+3X2o/OOp5sm4n+TslxfOL3G6Coyw22qvXU59uh4je2Xh4vET58ACMq7EvE
         N03ar1QZnLR7wFRBAGNe2fUOPKKBdd51v6qgicspx3xmCqK//yHRcWtUiPd+r41e+2nn
         2BGcj5Osxt076JRkllvVL+9CyMBJC0QnZF1+4et5ls0i+VxXDq0gZslO0UD2ccSHIdNg
         CTAA==
X-Forwarded-Encrypted: i=1; AKwUvBz2+aggQnzx1wQ+o9lpaoHrfR1Nh5Ng7lUja+VqVSCllycLpXnpBwsJrK1LclevdEwbWs3jmTk2H6bJ7p+5@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4QmvMnQ568R4nEi287q3cCfP0kF9oy9SusPAuhWNuGe2tmX2A
	nUpZWImUF3YmVpoPakrLmNg2DGNiWm21ht/WW26zKTop3vRWoA2Hs9QxWQw2HjuMm929bAp6jr2
	b+nhY/b8=
X-Gm-Gg: AYBFou1uIGoQq1WK1VEjrlVs4RWodaCJlVuFXCirN9jzDWzy5iPQcXCLIBs4J8gSoZ9
	7R4IGigOsjry5NLPJdpBp1imESdkOLXCTuePxTftURFNNp9fKPzuEMue1x67Ug/NovAuusJVrSd
	5zMkGIHEbu9iE2Nx2Sg+/TzwO556C7mhPsV4XyXdBg18q6UkiIjQsI8DsY+hnqzeizc9dYqhq6M
	aTObbGH0bBuNj/8sMkL4gvYUDSN1pzgzh/7gt2kHavTDVI5YVdWLHaBCnWzfknrp8uyqPfQLZCG
	JyBSO0hix7Mj4sL9fzmj/HzuPNMsEm4y9aborUFpeHzsnYfiV8I0DElu2jGOUEixF8xu4Qd23nV
	7dccNiDPl2Twxrz7VQ4f39Qjka8q6Cg7sJ1GTQkFjnHL1CAEBLRC6U8sQSh3pPZndXgHnLLWfLN
	wsVULSbJt33uIwjejTWCb1voz477emK99XVAoYb0LoFrCQtgIWX35QRycdu8Y8juLUkQjHHpzxI
	A248nbU21SiQqk=
X-Received: by 2002:a5d:5889:0:b0:48a:f3dd:6979 with SMTP id ffacd0b85a97d-48af3dd6b6emr2109376f8f.19.1790672849252;
        Tue, 29 Sep 2026 02:07:29 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af4f88b37sm2756615f8f.5.2026.09.29.02.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:07:28 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:07:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the livepatching for-next branch
Message-ID: <art_zcXuSXahklz3@pathway.suse.cz>
References: <20260926055219.3678061-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926055219.3678061-1-matthias.goergens@gmail.com>

On Sat 2026-09-26 13:52:19, Matthias Goergens wrote:
> The T: entry for LIVE PATCHING names livepatching/livepatching without a
> branch.  The repository's HEAD points to branch master, which mainline
> already contains.  linux-next merges the for-next branch of this
> repository (Next/Trees).  Name that branch in the entry.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> This is part of a cleanup of all T: entries whose repository HEAD is
> not where development happens: one patch per repository, sent in small
> batches.  The plan is at [1], and why it goes out in batches at [2].
> 
> [1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
> [2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

It seems that the motivation is that "master" is outdated in various
projects.

But I maintain livepatching/livepatching.git the following way:

  + "master" branch points to the last merge commit in Linus tree.

  + "linux-next" is based on "master" plus there are merged the "for-X-Y/*"
    development branches for the next merge window.

As a result, "master" and "linux-next" differ only by the few patches
which are in the queue for the next release. I believe that most
people actually sent patches based on the "master" branch because
they work with the Linus tree.

Note that livepatching is a pretty slowly moving subsystem.

By other worse, I believe that "master" is more appropriate for
livepatching.git.

Best Regards,
Petr

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 140eafcbbd78..e603835e4744 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15160,7 +15160,7 @@ M:	Petr Mladek <pmladek@suse.com>
>  R:	Joe Lawrence <joe.lawrence@redhat.com>
>  L:	live-patching@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-next
>  F:	Documentation/ABI/testing/sysfs-kernel-livepatch
>  F:	Documentation/livepatch/
>  F:	arch/powerpc/include/asm/livepatch.h
> 
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9

