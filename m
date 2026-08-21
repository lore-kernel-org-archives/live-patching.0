Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73C3BE155
	for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302310; cv=none; b=ht+hTQVyaPNsNKGrwa2I3E0V6aKZH/kqXR/ZETt7xslV2/j4yTEF7NXcb7IyFCmFbFD80eNX5Kdi48hz2zhfaOkQBPqY9LYht/go8TuFu5r0fQikYP7jakZTa5tiC6XFU800VJ0n3urglMUoZJehEhw8MR9oz2byKVAS0WM0Iyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302310; c=relaxed/simple;
	bh=ONoLiILwAuo27RgtNNvwffOs2zb2RvAkJKkw0H1EQOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrmp7+afExyMgDdNxfHepxHgYre8f5GufM9RKJ+rZd0Y04cBjrjzTKzBkBHdE1NOmdnh8tpDXCrpM5g4ExXTstYAoBG29TF5yJI4bEcHlzZWXP8LJcAiY8UisEkapJdkD6cpbkNx3peV2zYDWSM8lCuIdP5q6OPC8SCRc5w58Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EOrvZhIe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EOrvZhIe"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c197e7e4e94so147031266b.2
        for <live-patching@vger.kernel.org>; Fri, 21 Aug 2026 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787302307; x=1787907107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJfaCgdpJlwyfiEez2J3vKbm3cGSdPRw5h1jwiFB9Uc=;
        b=EOrvZhIetvVti4CeK+VAQV9JdkwmdNHqFpq2xixvrjKzP+WZvRvk3YmcbVwjrBdEUG
         2EV0bWY4pP3Rze/690q1B6Bm3bOgbH0EJjHkxIwtaKAhc2IVzRlHd2g+YqUXyGLw2ZJR
         0CNXVVMDHgMWr+BHXMi0IsCC+CwCR+++NSTqBjIG6eG4VHzF4Vk5kCCn0z0HVp9tq7cS
         Hrxv1qt4kfQ2Ij7hWyUOKg+/2cTbnSJX5cOzz1J+d2XCCBEFgjv0z6Z3N8UB3dvewSER
         9zn7TWjma1krBCdEdxflmHMUySr5Zdi49X3IiJFql1GRlmoTLPgBo2850WuqUL1a1Vo0
         Dtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302307; x=1787907107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJfaCgdpJlwyfiEez2J3vKbm3cGSdPRw5h1jwiFB9Uc=;
        b=ndSViMsrBWNO+IDU83FqvUKy9VyVCkQc9tq/xqfSyihA1hrtyCCJ/9BTJp+eCRcS26
         3hwqAYtZo224g/1BkvZMcZo4ztZvCkx8Ul/lgkO94zpnJc+zpxozLc9wo0h4YX+ibeJI
         oPN79maQO/c/PxPBp1sFYYEvi0XtuCZvUl6nFGwz4y6YnoFfbPsuuGwgUC5WPn+gPMwG
         WSeuyerfDJ61WKvxh6mgf+/KS1eomQiwwKgiG+tjy+yOadMXrkTBZZZs267CxGA9vZ4w
         mJNQPJshnH1yuP7huYko81Qj4QjALGSL48GLOF3rvxMfTXEn83BDkioEyQS5a1g4vHmR
         RITQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYU3vxsCBcrgzVAYaTiykjSqqgtpnN6MGhwZPLHhl5Ti7/ZklQikGjm4ZucVmKIORsKlQ4RO9+Au/nXZrk@vger.kernel.org
X-Gm-Message-State: AFuF++n43bK0yWR37VI2Ws4l6eeNbpJv7JSFrgdhnwazp9mssv3+G27s
	Jn+hxFSkJ3bBEjJ5hPil9bt3OzFoIx7qpQYq/+sgbqTUQGSo5KwWoiwYc+P8NTl0bvo=
X-Gm-Gg: AR+sD10YHdMK6KGhZohfJxbGMWZJh3N2kIk4N0jUiQTEYv+UrrVCXzl9R0dm8qMFT9C
	BT4UZGnTXxo8h4dhNsOLVngRlprgJdJ/rKl2C4+Q/QggqEAXaDDWLIY2pTL3PboGpbBcknshTL7
	tzhpOtBUtoh5htrhTcF6Hz6afhlqM5Z9AwyCzQYYdBDQZ44CaDhkz7Osym34su4LulYcghCuEUt
	st/fypCdVCQKSU5xYq9RGlKC37pSogUxlJJsrXpMqhfTQXT3M7/6Gx3HdxDq/1+VaDDUYJgorsE
	E6uRfNKCf0apNzMvcJhe+VRu9RppwWciFQozYP1aMkteT8j/oUud3GNxxvxWII8G85T6EA1Y6kz
	N4YUqUE8Z8R1BkDTGlDxsfNJe4Q4vEY5ZjIFASA1aGu/lOmzOmDTssc5LBWfp6itKdcPHMlW1kQ
	haxBK2p3lEW/LGwN+hOm8LpFjxojZpwAoQnQ5y9TzFSZKqRcFb4RUk12yucNHMQg==
X-Received: by 2002:a17:906:fe4b:b0:c20:3402:bd35 with SMTP id a640c23a62f3a-c246a605e78mr512915166b.12.1787302307160;
        Fri, 21 Aug 2026 01:51:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c245921e461sm395845966b.54.2026.08.21.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:51:46 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:51:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	song@kernel.org, live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 0/2] ivepatch: Fix several bugs found during replace
 set implementation
Message-ID: <aogRoHC151zl8VxW@pathway.suse.cz>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
 <aoWEX89bxOpo4873@pathway.suse.cz>
 <aocdq0hr_iQTimG0@jpoimboe>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aocdq0hr_iQTimG0@jpoimboe>

On Thu 2026-08-20 08:40:40, Josh Poimboeuf wrote:
> On Wed, Aug 19, 2026 at 12:24:31PM +0200, Petr Mladek wrote:
> > On Sun 2026-08-16 17:04:40, Yafang Shao wrote:
> > > These fixes were found while implementing the replace set series [0].
> > > They are independent of that series and can be applied separately.
> > > 
> > > Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]
> > > 
> > > Changes:
> > > v1->v2:
> > > - minor improvements and acked-by (Song)
> > > - fix issues reported by sashiko
> > > 
> > > v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar.shao@gmail.com/
> > > 
> > > Yafang Shao (2):
> > >   livepatch: Fix wrong index in funcs cleanup error path
> > 
> > This patch is against scripts/livepatch/init.c which is part of
> > klp-build framework. The klp-build-related changes usually
> > go via the "tip" tree by Josh.
> > 
> > >   livepatch: Fix UAF of unregistered patch kobjects
> > 
> > This patch is against the kernel/livepatch/* code. These changes
> > usually go via the "livepatching" tree by me.
> > 
> > Honestly, I am not sure how to handle this situation.
> > Josh?
> 
> The scripts/livepatch changes have tended to be tied to objtool, which
> is why they have gone through the tip tree.

Yup.

> I'm open to suggestions or ideas.  We could possibly rename or move that
> scripts/livepatch directory (scripts/klp-build/?  tools/objtool/klp-build/?)
> if that makes the boundary less confusing.

I like the idea with klp-build name. It might help people to
distinguish the two areas.

> Or might there be some other maintainership model or way of splitting up
> the files?

I guess that we need to keep the core livepatching code and klp-build
stuff separated because klp-build is very tight with objtool and
objtool is tight with arch code, ...

It might help to crate KLP BUILD section in MAINTAINERS.
It would point to the tip tree. You would be the maintainer.
And other livepatch people, including live-patching mailing list,
might stay as reviewers.

> In any case, I'll go ahead and queue up patch 1 for tip for now.

Thanks a lot.

Best Regards,
Petr
