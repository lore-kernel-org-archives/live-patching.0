Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3735DA75
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668345; cv=none; b=uGTbeg6pDPB9KgZGPYLGwM2KRGqTtgwPkt6vbTLpMTMMkzxkU+CtFCdlR12FE86dZUh8M+kOWeBqXwampBq6f7twd7b9y8FS7BDvArtFUQfqV2VIN567qPA/RzZQAwSwEuh1L6UBgaeDRcYGFeYiuzMU1UTxmYR+0R8dLEpA19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668345; c=relaxed/simple;
	bh=Naw+0pM5jX8sriiCIMcNpVykYT6UQjT0Lv2jeaVucUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKQmXd/hcfAAuqTNzCknLjZrcp/zfxrrpKKpk2YPcprftwl3omvZLKsgEgrdTNjtRf48SdebuwyvZAvRSoatumlvPb05+sWFoSH4a4ORu4L/OA6AEAixQ+Jm6zcq0Nx7en1wt8JzWgStQu8NNZspHcwWB+RqUBpQ//2qUp6VI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9zbpl2t; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9zbpl2t"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so1006083f8f.1
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780668339; x=1781273139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQz8xMZ+YvTuLBSXCkopz10mbJB9XgtGAZm9roBwzQY=;
        b=b9zbpl2tLm00S63ACK7M8lQihpmryW9W4couUWY23dBetK6cUVcTQDcQXAXvr5FRFb
         A1/HL6lPn27T2rCK94iQ16VgGWkpHbZ0A0WMKNrEdS0+6PouwptpLMY8lXcBgshoGTrO
         I6e+kOlLyItdYdm0oDpQ1v1qDEEo23BFjw3dvC5SOfKTBX1NN+L+RkaYEYn9Jay27ikW
         crmkroynpgNzaARtDkeEAyq1ECi6d7OnpOVdo/QvJhE2oVYauXffMTkmO1JxEoGvewkk
         +98BeTfhrYjz7V96Yx2JJscQ833WQyyClC1oFOapxUpDcgIRqY6WhW4/1W0NvbalYcgL
         qQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668339; x=1781273139;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQz8xMZ+YvTuLBSXCkopz10mbJB9XgtGAZm9roBwzQY=;
        b=WMxCQq6Kmj65d206qW3fXwNoB4ZMyosOxGws4n+98K8XK7A9OfLsfOjJXSr8X7Rssl
         7YhPydHsNlzP04vwBUhjKHEyqg4sLcRqOX1kTOrLzvKYLWD14Pl/z0I9Lx0YYInRMD81
         6/Md89z+sgEvYIsG2wzZjG85kfmkCIePt2myFDQpCx+b5OoUmpexwwPs9lIynY8wu2X8
         DJ/jhFeV9kReAAeFPUKbZewtk5/JuUJihcVuH/bfzvf2Zs/Gxyv9aEydI52BWXTkJhpU
         FT8WFxw/CZJemqMTgqWb/iYKARDW0631ik7nabE+/6xh67o61PNkOg7SN45wMH6HN+bY
         OK0g==
X-Gm-Message-State: AOJu0Yw+NQs0rZHikUMwnGRWVN5BqWVh+kQZR+DLF+TjSmPRics0J7Mo
	zf+bI7EY4FRb2fOckpX4dqlqMpbJtMFpfF8l+JYX2Ye7X8mGfKNdbvL7j/uTLat6KOPEAKjE9pN
	P5a9TjdI=
X-Gm-Gg: Acq92OFx9xWcB/wcU50G8YTqnyFFyOmZM3b3hkSRmJ0laLzCRZHwlOVxYmwEG/jmrk2
	So42wZaEzun4LAG7hNuZ0D1Y105tzXTyCvwlA2Ws2/JnfYoFo1OYrEvLFxAazEQdUT6CAiVWUtx
	xgpiS+1SnWQSQ+RnvOIQEAlgZy0iGfWeooVoHF7oYWaZJ4jGZhT1Lsrpeo8+p9rHnhrG45ZPhUU
	uM5pzzkjZ0dHUn6Tit/C5J7ml+fhBFXf83YcuNUy8IVpJGQIxsAsDFcr4RxUc1tyMUYbYBqO+r4
	STPEE/Z3+9o17PisEFAqTCiZK5iOcHCNWtgG4Spp/HyH1ac0yhuD9evi3ZYVE4b1EwVhynaSUU+
	RPSagCm8WeyC7XgAsKCmn4vHrMMICxS8jSttsjPDHmHiAzaAs0SIt6PuN3zwG1sCBcCRJdaS11F
	9XjS2/e9R1cR1DPme88fhGd99k5nPqHsfE0UZfaSCPw1x5s8S9ClMmhVp3QilOkMYcinMXU4gfy
	I81KDcZvN8=
X-Received: by 2002:a05:600c:6094:b0:490:4b89:5362 with SMTP id 5b1f17b1804b1-490c2609cecmr59481725e9.24.1780668339022;
        Fri, 05 Jun 2026 07:05:39 -0700 (PDT)
Received: from ?IPv6:2804:1bc4:803a:4c00:6a4d:bd81:dde2:ff59? ([2804:1bc4:803a:4c00:6a4d:bd81:dde2:ff59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm138093265e9.4.2026.06.05.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:05:38 -0700 (PDT)
Message-ID: <0f269520407c8cfc554059ffcba45ef3220ecfea.camel@suse.com>
Subject: Re: [PATCH 3/4] selftests: livepatch: Adapt mod_target module to
 pass on 4.12 kernels
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: sashiko-reviews@lists.linux.dev, Miroslav Benes <mbenes@suse.cz>, Shuah
 Khan <shuah@kernel.org>, Petr Mladek <pmladek@suse.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Joe Lawrence <joe.lawrence@redhat.com>, Jiri Kosina
 <jikos@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 11:05:32 -0300
In-Reply-To: <20260525002416.3B3A41F000E9@smtp.kernel.org>
References: <20260524-livepatch-unload-on-fail-v1-3-7465de7f741d@suse.com>
	 <20260525002416.3B3A41F000E9@smtp.kernel.org>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-05-25 at 00:24 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] The `test_klp_mod_target_ops` structure omits the
> logically required `.set` callback, exposing the kernel to a NULL
> pointer dereference during module load.
> --
>=20
> commit 532c1b8c7438f534fd4e3440716ede6cf83efe1c
> Author: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> selftests: livepatch: Adapt mod_target module to pass on 4.12 kernels
>=20
> Use the stable module_param_cb API instead of proc_fs for exposing
> module
> state. This approach is compatible with kernel 4.12 and later.
>=20
> > diff --git
> > a/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > t.c
> > b/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > t.c
> > index 9643984d24022..1382a266825fb 100644
> > ---
> > a/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > t.c
> > +++
> > b/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > t.c
> > @@ -5,31 +5,29 @@
> [ ... ]
> > +static const struct kernel_param_ops test_klp_mod_target_ops =3D {
> > +	.get =3D test_klp_mod_target_get,
> > +};
> > +
> > +module_param_cb(klp_mod_arg, &test_klp_mod_target_ops, NULL,
> > 0444);
>=20
> [Severity: Medium]
> Does this code need a .set callback in the kernel_param_ops
> structure?
>=20
> When a module parameter is passed during module load, the kernel
> parses the
> arguments using parse_args(), which invokes parse_one() in
> kernel/params.c.
> Because parse_one() unconditionally executes the .set callback
> without
> verifying if it is actually defined, omitting it here leaves the
> callback
> implicitly initialized to NULL.
>=20
> Could this lead to a NULL pointer dereference and a kernel panic if
> someone
> attempts to set this parameter during module load?

Indeed! I'll send a v2 addressing the missing argument. Thanks Sachiko
for spotting it :)

