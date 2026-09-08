Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393B52FE51
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869131; cv=none; b=bB/vAJ2Gy3LBdCYcC0LTld8xlHo7mx40dqpqeG3A/UpXr0sl0yONV+YHwJJ6q+Ef6qHhpPPaOEHnXl2Rc9A3e56IZXpEK/bWUjauLr5A8p1eXoGVUIqydbwSVfhHQgTAH6EgTy9FtAu06xBpSjyHdsi40yEXNxaUKAq0G+4MABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869131; c=relaxed/simple;
	bh=DE3utOlU8enhMCeMv0x5ACam0SDsoyX2DVF3FJK632E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8AoVaMG6nKJScMCQcAJwXuUG96m6dThgpPWeUkf/mS/kgJHvX5df0lWR6Pet8CjE0FgVUtodzVJU7qQYqDp6areQST0gUrEEP17je7YPTxu59QvVwtxLzoHV/yqPezIhhLiaXaNqQlvOMO0pZK69VFVB8OLE6iTFf65I7GYBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FxN0WXFC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FxN0WXFC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so36286505e9.3
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788869121; x=1789473921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6gMrsDr3O2AhrIFNyV2FMFs0i+sTtOGoTHAK2qARBk=;
        b=FxN0WXFCprc50AAoJfy5Pxuriv7kLYeFFBdAkQ02Mq+hXkF+CSjuuwylieA5OEdB7x
         nDoL+FAn5lZs1eY4HVrDYtNxCsTReS9XzHMvJuL69HXfuomrkuXvByFrt9OrJ9HyGRIx
         mXFi/21mamLpAFYtov299YsxQ6Q0vAnD5UTpaYcUGiERaqjxksFSCi7SdaMvlLJk6D+0
         kl2Aka8Z8GgLSvpZauEwQXzOu47X+KKWfYQSxFq1l3BtTud6X54KWB+ufEhaMMKaNbul
         fIc4rhDbvNAvqWxN+dPHrBmldx0Ye2GHe6oPnMnbNuF9FN9fdMBJrbcabgRiLS8NCEe9
         AS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869121; x=1789473921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6gMrsDr3O2AhrIFNyV2FMFs0i+sTtOGoTHAK2qARBk=;
        b=R5basH/Lm0v3ZSsoW4MsOvdLp2fJhcf1D24AP+3Hqq8ZiWrmKIlVvnybrEOqbpHzud
         Fd0Q5ghGDJb/kB7d2h/MWENbXCmBbzh2t9cDO0Ch/QVjSDQn/RxzjKe8ufE44A5aABVu
         dO+yJq8y/gTzZe3O60PKOKwQmrbcD1LPrFHr+LTEDbxykLgRODMtVFj7+YDFK2BNUVr7
         lJrOg9V8bRogq0++bkXwdDhpRFTqU8KCVmuK8jImu/wSqft3ILHk6EAA38AVd0eQtxC7
         MYTTvtAHz1e6mdKQXfxMzEoh1Xu5sbFTooRJrl+1bJxz5i0Ak0JKYU3h0UZM/m41wUYj
         nfxw==
X-Forwarded-Encrypted: i=1; AKwUvByGRJHtBXVpcKIbPhyQbyg96u9VPvYUYim9MKGS8UkgrLK3TkwLzk/31LCg93Pe3tgs5RAsTlT4UWagoJYX@vger.kernel.org
X-Gm-Message-State: AFuF++lV3EHuC2Kq6PW5FcdP127w7fkbulol4wYU9cfWTfepPZqFCqPh
	ngz7/y1Ie7+GhCNUN6EFYlbB4sqm+xcbQaUwtlXZGXoy5nKTB3a5NP+gMWN3zWYRJLM=
X-Gm-Gg: AYBFou0D5BwHtlWXsata2JiPdJgfGoi6qnVwYYf4yzqJ/va1TRHYE5MLWxN5ck0dqYs
	9puJGGMNn4tcHYVO+CKmpF48mRQtMeVEkyD4K+Esz+3jeDRvXDuqSY/BtvKBrfmi6nSYFSlORQ7
	1FtFfnFWSCBpL4UQLp265rydAl5tuoAwjC0+137qraNSVKp9Px9Ib6GGHWM7HL/gBYYkRMr4Cmn
	RXqWcR7vOV7OcbJNDryTX+tG/6HnJophcIDadDqLu9uxHOsNl2S2yIXTHKLA4gUApFfcH3qwJGB
	tl7I8jafprvsUO78g7WlqXcQLE63ET7dkqGgSx214w7xS6IqS35RXcQ8y3mnFUpJw4cgKBadMtR
	suFkAlAE2pW7dGls12tkLfu5UCaNGJL9xuTOfSZjP2kfLtQoVWDEMDbktx3+Sdtubx0Uo+JFh6b
	nOgjWGyxgfh+zDmSNmB13Cx6vz65gafCRx2VZkHc/elkmtcPsuuWw=
X-Received: by 2002:a05:600d:4444:20b0:49c:fc6c:be0a with SMTP id 5b1f17b1804b1-49cfc6cc001mr188498935e9.33.1788869120745;
        Tue, 08 Sep 2026 05:05:20 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm390140355e9.0.2026.09.08.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:05:19 -0700 (PDT)
Date: Tue, 8 Sep 2026 14:05:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org, live-patching@vger.kernel.org, shuah@kernel.org,
	song@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] livepatch: Fail object initialization on duplicate
 patched function
Message-ID: <ap_5_Qh3h_6YN8PE@pathway>
References: <20260908120149.299352-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908120149.299352-1-pmladek@suse.com>

Hi there,

please, ignore this mail. I am re-sending the series with v4 in the
subject. I am sorry for rumor.

Best Regards,
Petr

On Tue 2026-09-08 14:01:44, Petr Mladek wrote:
> This is v4 of the patch failing object initialization when it patches
> the same underlying function twice through two aliased symbols
> (functions sharing one address) in the same object.
> 
> Changes against [v3]:
> 
>   + Add selftest for livepatching aliased symbols [Song, Harry]
> 
>   + Only partially revert relocations when failing inside
>     klp_apply_object_relocs() [Sashiko]
> 
>   + Cleanup changes made by klp_init_object_loaded() for failing
>     patch on another failures in klp_module_coming() [Sashiko]
> 
> Changes against [v2]:
> 
>   + Clarify comments and the commit message [Miroslav]
> 
>   + Cleanup when klp_init_object_loaded() fails [Sashiko]
> 
> 
> [v2] https://lore.kernel.org/r/20260823060734.58443-1-x90613@gmail.com
> [v3] https://lore.kernel.org/r/20260830173343.52759-1-x90613@gmail.com
> 
> 
> Harry Hsu (2):
>   livepatch: Fail object initialization on duplicate patched function
>   selftests/livepatch: Test rejection of aliased symbols in one object
> 
> Petr Mladek (3):
>   livepatch: Move code for updating livepatch object relocations
>   livepatch: Clear relocations when klp_apply_object_relocs() fails
>   livepatch: Clean up klp_init_object_loaded() when fails
> 
>  kernel/livepatch/core.c                       | 137 ++++++++++++------
>  tools/testing/selftests/livepatch/Makefile    |   3 +-
>  .../testing/selftests/livepatch/test-alias.sh |  81 +++++++++++
>  .../selftests/livepatch/test_modules/Makefile |   4 +-
>  .../test_modules/test_klp_alias_patch.c       |  62 ++++++++
>  .../test_modules/test_klp_alias_target.c      |  48 ++++++
>  6 files changed, 285 insertions(+), 50 deletions(-)
>  create mode 100755 tools/testing/selftests/livepatch/test-alias.sh
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c
> 
> -- 
> 2.55.0
