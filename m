Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3D345CCD
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268166; cv=pass; b=BnS6begtGPdC+S4uKRsajwImCVCvDs/j0eguc2ft1TL9PkCVPnQON72Ck08fsrQwvfsG+4NQRUyy9hhCnQqufVpsTOpazdtnSWDEmgDoIbJV7LAfS7f0cNwxa/Kg7kmOWPRqcw8yOFwJGObrrbEiYS4XezAW3oz44c6V7GtORA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268166; c=relaxed/simple;
	bh=DZGKf+y2yHjX0JATUvwRU5kGsye4Uuh7hr9rvML6qF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5cMHS+zmb/Y/QriOlTvtROjhVVJ9lZTFjGG5CTDht5XrheLe1DkusPh3enRoJ00hzY3m/bP27Ca5lSaa80f8qSSU9GaRCsywjeL3+fy/MTA6e8O37UpJ3cOrxmalbrKe5rzhzVNlmD5o9Ya3GV/nGnCjF9W8hL1joqdXXmIaMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fscuVAZc; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fscuVAZc"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so683498d50.0
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789268164; cv=none;
        d=google.com; s=arc-20260327;
        b=GTofsfrkNJsOB8Oe/eebOycicnd7NGRo+Me8byHRghxWWlAcFXRAX5V0HrME52yEAC
         tprGjGEGfbG2RvODCi61pAZnD5YxHS01+gNBVSbb9PI/l30N2Vow6kaH2Wxs71ESpHp3
         nCIXKXs2026r1fn/L5ndFRPlSz6SXMXbdhDO1LGEaVffSJAG04n3DjjiH1PkriHNHoRm
         4ilI0ELc5lsY6MNP5P20orHVWpaNf/xt477sn7KdiOFPCwgdLwsnU2UaqJutfAoqZUFC
         kNnjuub6EHEE6LYTUMOQcWW13O4wwRe1pPXhhrv1msw8CgzO+duRP6xELVILIpGGVQZX
         PCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZGKf+y2yHjX0JATUvwRU5kGsye4Uuh7hr9rvML6qF0=;
        fh=9L8j7NUmqYZnSokeWSz+7DgIkd0Ua2a0uWLYnllf6e8=;
        b=r/mhUuSSyG8+3jOl6TSv0BspfrXstlXnkv9YD64MEkpQrQlUTMmxjzv7OE6SSkrTe+
         iQsUgp2d5LFqhR1eVGDs/8Fj6kkPDd0XahbOseqIr5N9/WryQWfr3EL3toJ/fvaK0IdZ
         eppxhYQYqqW1rShRMo37y154pJxFCCiHs/3J+CoWsoRsIZotHrMu07fvita+tI0if8pW
         O86V15l4pSD6SLVXFDAMvDQ8MzTSaIDVIWVx4Hq5FgwsEb5gc7GvI93ymXpZTBjX7bh+
         3AqHEXV2E8S5UgE2qKZ/t+45wxfHUgmBBqfRDxjbYtaLiHU9VEvA1xHI2AxuzhGbyEkJ
         vP3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789268164; x=1789872964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZGKf+y2yHjX0JATUvwRU5kGsye4Uuh7hr9rvML6qF0=;
        b=fscuVAZcSd7tjy7Fm0XDFrxZ6B6RQ0O01jBp6AT0DJUq51bXiyo603lWkdBBU2lVim
         u9pC4F/IHAbmGO6nIV2G9Ew8OAbGU/qSDeXy/+PTB8+g54zDZqTYVATSrhIFrdmczCYo
         mvKkaFJKs7dMynQ+9KEhMi0f/SHADQpTbxMiakiYk9m1Ah3USwTRJk3cAQqO5VkGM1qx
         wfTZZQoQcxUxWfg1LRN2ni062nTSpqRYojTSwJC0h27lsPJuogludiV6rhvwyRZe5WgF
         SEqglGt1dQy0p+unCunGeN1CvOGQlFqLOlU4Uhds6fRNV8K506hHlWfh+NSrMvMjM7sm
         s7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789268164; x=1789872964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZGKf+y2yHjX0JATUvwRU5kGsye4Uuh7hr9rvML6qF0=;
        b=fEo1NkovdBn9TyxboP38FExJV3JEaw4HVZa5SSKuU2rwPZP1ClPR7TqZkE94vIMzOl
         VK1EKgLgK7mZ+8VoWAco37EMCV5ml6nFY71eDxf7NA8eFixr3frOGFtOQAs5sf//hvna
         a6nkzTkqWlPbiZhVxeXQgPw4WovK81Z9/80FTg2CKzgiy2XdPhIMj0G9jS2xTpqqLMME
         zoyLDq7n6HhoNBP3NrUtt7tQ+eFr+ojeKGOIvZKw8UsSb7S8loqNenmgQ+2UOENJSdAA
         yuiGMqq36rPZTS8Anw8ewhuXf+tMtmvCmPjMKuJICDSTo/KzmRWIrZXZOfiGGfuFssKU
         7kng==
X-Forwarded-Encrypted: i=1; AKwUvByEtWpR4fv550I7xcxoHqh52hU/mBq+4vH2uvzpFsnqWuB6Aut4jEedpX6QX2QTK4BcLvVW52TiUHJ9ZZkZ@vger.kernel.org
X-Gm-Message-State: AFuF++myA5WX+BhsbZoKwAdpJ1Npi5Qy0gtAkiI1PohVe+GvDD2xNtZV
	zB8h7FKke+g3bzwfKJdxo8McFL2iA9ZwsQuVdXii5e1jezdVUEEHiy7DZuCRG46S2bVAR0vVwe5
	Hacr0J+YwH0wBoyBEN1nFHI8AHr2K4tM=
X-Gm-Gg: AYBFou1Qo8iJqCCY/w8i2rg3CB180a1uAJZUHcP590MnzQ3h4jDUx+Y2nh3JUHCux2y
	jw1xChdVqWNCkfdgtsRucvGq5zBnYZOdccdYgQYsqCZnnBkkmZ91s5bJORnYHi7YuIIwl4fkDue
	mWP1YGQcebffQUjACoIJGHA87TUuMbdE+YFK+stUSjTLchgoY+F9tv/ciLtqwT3rM9gk864UVQ5
	X5eozmcSGVawww3ELXc9Lz076CY2YvK/4z1cjVvB34wHIxp9LHBDlr9Qluzme4lRT5S7loIXDjn
	rwC/fHD1jV29Shqdiynuvq6j/Pl4rIb0a9CVF+YYtGURXIfdEJ4aPeY3HpJcKdDL0t8TPalK6mP
	QrAUyKHZOL6wdLg==
X-Received: by 2002:a05:690e:4806:b0:66f:7c64:9d47 with SMTP id
 956f58d0204a3-671245e99d1mr3820657d50.23.1789268159132; Sat, 12 Sep 2026
 19:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-7-laoar.shao@gmail.com>
 <20260913024817.2A6DE1F00893@smtp.kernel.org>
In-Reply-To: <20260913024817.2A6DE1F00893@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 13 Sep 2026 10:55:23 +0800
X-Gm-Features: AcwNN1XGxR-mMsAb0YOJXftgs1Id2BmjtGz_un8fTW9E9IfSrfUP1F5C5C-13Hw
Message-ID: <CALOAHbCyhyEhg0upyMgZSaArg1WEDtpOdZw7zC_+DtfF0_h__w@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] livepatch: Deprecate stack_order
To: sashiko-reviews@lists.linux.dev
Cc: song@kernel.org, mbenes@suse.cz, pmladek@suse.com, jikos@kernel.org, 
	jpoimboe@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
	Wardenjohn <zhangwarden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:48=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch removes the 'stack_order' sysfs attribute from the kern=
el but does not remove the corresponding test code from the livepatch selft=
ests, leaving a block of dead test code.
> --

No, the test cases won't be removed, as they may still run on older
kernels that support stack_order.

--=20
Regards
Yafang
