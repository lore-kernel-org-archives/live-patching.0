Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9B4C10CE
	for <live-patching@vger.kernel.org>; Fri,  2 Oct 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950787; cv=none; b=dc5wchCjBC/mHsbNncpjXvPKFZSu2i4hXLV3WUyzNGU7qBhefP2wQiBAzwKmcCtu0wpO+No7MDoFHq2B045DNAGXvS+wxNGZZb3Pf62sGkKRaXf/pG9aW1B38ny5WvlyXGZhTcV/No2Ae/GzVwI8zU/J405QlfYH7J8EJyHisWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950787; c=relaxed/simple;
	bh=KlQovJtqsfJWa5E2IdCH7GkzuwM5G4QFhgGIY9dJrHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC97fz9YPqCR6Ez4x/leFOKN7wSIyTNjvNUoC335FVv9mdUohTH5ehk3FodSC3Y9XE07EmUXMn6LBSzLrEmoHNanCR/fKqCJnf3KTjFcBzHr6BYiVHpj+QSFXP0atqJoY9/8yqueAnClHJxP6gtPpMmVvWRgRmLqkbSx6Uzav3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eLzjkd+Z; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eLzjkd+Z"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso955055e9.0
        for <live-patching@vger.kernel.org>; Fri, 02 Oct 2026 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790950780; x=1791555580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K3xiZrFqhCfo1AQ6jn2xSr3Zn3h0mT8mskdrXPO4qxc=;
        b=eLzjkd+ZQjH98YwjOHPrbraK+liDAxfQl9X0GdyufGPWTy0y2p95Q7yse79DqeGZnw
         KBpt9v8VSrbPCAw+iD19fziZzj1XYjuEhuUgS8gA52qFvySIb0uaGPtR444CiOajiK3z
         eiNys9hEl542A36FCvY2EqEDGHe+wS/UFZsm+tTD9iSCi902noJzTV8PzBkGJMsHV897
         9IiJ0P66kRettqXrlYxLy7cNhm99rN+sJY/WQSdKMrY0HrBTjluT7p7oi/bYflaJFFlT
         QqOKARRcFYyUk0i/OBO1iGpcP2sOVdDTaPpGWhIyBC1rBTR8FKSPsscD2z6GvBnG895v
         QOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950780; x=1791555580;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3xiZrFqhCfo1AQ6jn2xSr3Zn3h0mT8mskdrXPO4qxc=;
        b=H0ec5WmBOZoegoS15KpQvEkbJHm3BpfpSmzS2jVfaL8CComO4FFjf0XzL5iugY676L
         qah6UeHT/45NPpjN5lQjqCYkrhntEtR6ep7baAtWs2gL3W2c5LXmd2NdIctUAjGQeORv
         SzjXl/HNB0llkPluvfprz8F4QDLBgmjvmb8k0/UM0oabjmWRSRKsqRd9E1VtjiriTw0B
         zFAJFGbGPra5Ee26mw3sTsXKc1gGCjrv3V6BuWdkcbSQO3i5d+RmpQjLPWGKOS0CWbEs
         2dS+vR2wjq8969hQGkq9uSWTiS5+5N0qQLmYtcmVCDsVZAk0p/FKrnEhX21+yBlzWHmD
         XaVA==
X-Forwarded-Encrypted: i=1; AKwUvBzakDzEt/yNI9jDnmlW/Kml1aXFpcMIXZ1WM2pA54p2jk6upJHA3uB3B2Uu2qd0kOemSYkWFGcTssFqLf0M@vger.kernel.org
X-Gm-Message-State: AFuF++nf/jnzuxY4bfYpRKVVgcXKf2erMlwHFoJKw5TJpa+FDu7+WrKT
	S2GZi47pElEGqaWINOpHaGIq97iK/s1BaoJrWOrn9y4prctgYrsT+cCQQ/YN01j3E3k=
X-Gm-Gg: AYBFou089xjbf47hUhppnLaTzM12R8aQvr2GaiuoiW2PLwCnQNX/X4fXRZ8AhgIkXlm
	myIy9ErJ4EOgRb2713tb1NTrnPSRPUR/QMEjwIWpIm2LReKpCuv1f4FwtWGOcxt+I507EZJ6riw
	q42dfsO4blnqQHQytCss+4C9YQzwBpGlnAMTr7CCHO1TWRkvdI6Zx8wmZ0ubbdM0rXuThp8UFsL
	n0u7oMMdzKB2xUyUhIokkx2VavKloFsXcvJsMnKnm7n8FNaGbXOldDp2YbcUYZank0mv8DKf3E9
	tYbxjl5A6cMaXb4lwoMB8afjVDJCQCuN8/a5CaIxpAMiFWUkInNqJwfI6QyXNChk7ROB81Lf+y1
	s6J7tnOAseNFFrTdpZRCUww9h1xDd5x7b8K0gEH5V0l+NBE0WbcZvrYz7Vm5OtmG50GPHPgdt7t
	nuEjb8WaT83IKeJg1XSVzVseGl3iCTWa2H+O2ijwmpUX0iiDB5qDkd1EGrPIKDnpzccjGPIVLR
X-Received: by 2002:a05:600d:238a:b0:4a0:18bc:3b94 with SMTP id 5b1f17b1804b1-4a02755fc4emr31496125e9.18.1790950779766;
        Fri, 02 Oct 2026 07:19:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0316b2524sm98062255e9.1.2026.10.02.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:19:39 -0700 (PDT)
Date: Fri, 2 Oct 2026 16:19:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v10 3/9] livepatch: Make klp_find_func() non static
Message-ID: <ar-9eY3Wh4oKyYtw@pathway.suse.cz>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930030323.14396-4-laoar.shao@gmail.com>

On Wed 2026-09-30 11:03:17, Yafang Shao wrote:
> Make klp_find_func() non static to allow its use in other source files
> by an upcoming patch.
> 
> While at it, rename the parameter @old_func to @func to better reflect
> its generic purpose.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Looks good and passes selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
