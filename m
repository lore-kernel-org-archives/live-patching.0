Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C42E285C
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487781; cv=none; b=q2+W8EoF0Jgg2fblWmTyOIJyq4A2L0ATX+AQvnT3OX36Ji0dxKhI9q5ePNpwZYcTteCSWf0mo+p6b75TV8ZrkeXCGltb3lvWzpqD1WGc7KRq005ldv4+r7EimCU3o+4h6C56f9rtOTQyiFMTqNONmOlBQwQx1z0CoAzbSvgYcmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487781; c=relaxed/simple;
	bh=AfldEmuhATcFxMIBdZpYfqXyTqeNtBoD5/COHSk4wWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJlXK+EqJM7X3ANzbWOgKEKbmc6oa+/dIybDQdi6GY+rLilCq4z9bRpV5buNQJQISBl1eLXmMfQ+lmnX18oVOVnuUnCvpq3Kablmervy3z4fTcFaEI8K6sdhQUjNhXSxdlELEol5bbBJwvQXsHwnqrdRnDn6iaO1KVIzyn9iu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMvzFNcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMvzFNcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0E31F00AC4
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786487780;
	bh=zLlNtAVo/6r202zcjzEkJ+yD0bMpIwaZgzntaBzQmH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hMvzFNcEC9PbL7hVuTsYJ0MS4Zwx+EKRV1y7H2FTQ1OZFwa7rbcCXQptKFwIP8ZqV
	 5MhxkEJJ9iQlYROmxYq6SiNEDmw78OQ/qzIfj9J8Am2oTLkD/dCOxx+xmfM3dgKFFD
	 8/xdzWJlFB3VK69wpf1ElAhafs0d62Z6gXL1wgtkA5tU3SFMDpc1xe2+0x3frsclRa
	 o2nxEMkyg01j1gACNwUzkYicHgOHD8C/wb74ZSPu9rFv+ssIDbWDULbLe1eulbnURH
	 Wr/jVMbbUKfQkXQDBmmhMll1cbwHZvZAnxVWkVs8yUDMWjapTzKiog8Ziv/+L3VIWP
	 03mjtaqWKkE9A==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92ed3993c1eso28770785a.1
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 15:36:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq2p52ZzUatAmdFJ/Fh8SG5FCXOWpsLTqYXoPCaWx73CVqsNR7MLV/DksTCUEztm2YC04Leamgx+pE9DRkc@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzgtujEDQDg3CQJhiUy3q/zWTSBI7KFAvZSSVmqf8JM2Z4q98
	jPLCqBmfgh35X5MabEASgTEMtz4BwtlwMKh9tptigLeZS1gQCYA1mAWalUzUstXIc9OLDyYwPtE
	a+KkSdZER/DmmTb9WLYbdzOKzOQM1MxI=
X-Received: by 2002:a05:620a:27c6:b0:932:dbf6:6f9 with SMTP id
 af79cd13be357-936b39f5c1dmr87037085a.9.1786487779500; Tue, 11 Aug 2026
 15:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786138493.git.jpoimboe@kernel.org> <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
In-Reply-To: <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 15:36:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4_ci8RiX_2z6GEb9VE4=2quxEpSA1yUoc8wJBzrtS+2Q@mail.gmail.com>
X-Gm-Features: AUfX_mxT1A_SdKNAllzAAJCUU6uHIcqhgrRSKg1oqIhubyzO3OBKw--q3adSNgc
Message-ID: <CAPhsuW4_ci8RiX_2z6GEb9VE4=2quxEpSA1yUoc8wJBzrtS+2Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] objtool/klp: Fix relocations for
 EXPORT_SYMBOL_FOR_MODULES() symbols
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:38=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> EXPORT_SYMBOL_FOR_MODULES() puts a symbol in a "module:<names>"
> namespace, which the module loader grants access to by matching the
> importing module's name against that list.
>
> klp_reloc_needed() only creates a klp reloc for module-owned exports; a
> vmlinux export gets a normal reloc.  For a vmlinux symbol exported with
> EXPORT_SYMBOL_FOR_MODULES(), using a normal reloc results in a modpost
> failure in klp-build:
>
>   ERROR: modpost: module livepatch-foo uses symbol mpol_shared_policy_loo=
kup from namespace module:kvm, but does not import it.
>
> And the modpost error is correct: even with that error removed, the
> patch module would fail to load:
>
>   livepatch_foo: module uses symbol (mpol_shared_policy_lookup) from name=
space module:kvm, but does not import it.
>   livepatch_foo: Unknown symbol mpol_shared_policy_lookup (err -22)
>
> Treat it like an unexported symbol by using a klp reloc.
>
> Note this only affects "module:" namespaces.  Ordinary namespaced
> exports continue to work with normal relocs thanks to copy_import_ns(),
> which propagates the patched object's import_ns tags to the patch
> module.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lore.kernel.org/6a6608f4-0a05-4d75-8b7f-edddfac9c5d4@redhat=
.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
