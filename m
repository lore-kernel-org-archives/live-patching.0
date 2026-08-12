Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BE171CD
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492985; cv=none; b=ahdA1KG8cinwjhPSwQDNzeCB12uCkczJ5aWIhcgTs/WA8hMT+KJy8C7UCUX4fw0/nWE2USPwU1B48/FjOLJ7DY68E/LJEDd/C/BM8wT/eiM2Rhe+sLng432+UB1bIKMm7kk7/kTG2twiNmuPcPzlKDBlhR9xWUrxbSPgNJC05MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492985; c=relaxed/simple;
	bh=5Kih/5Gb3n2KEUdLXQmm7RKtUqyE/igDwwvcsn9JuyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxStm+qvPyrQ9Uyobk+N0YLR32ysJGOPECiXCI8jlGev7SOoZ/RWPfYM4xuPTp6sg53mE40IerpUxcyG/PVkYb4kKES75DoujmfWk6qqEga7/mjAvtcsiwSSfT822dO04K+fJhh4hkAuxG9TMfiulA+HF7Kpu50789GKodvYvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrIORbIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrIORbIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BDE1F00A3E
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492983;
	bh=5Kih/5Gb3n2KEUdLXQmm7RKtUqyE/igDwwvcsn9JuyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hrIORbIq/rgGgPoVBZEkFCNjKZCBXeeWCVnQqG+xPs4CXt2w/Ck1EjSYrmESXEbaV
	 C1CGl4XrK8IxZeP+6xRfJdg8PQaDCtQ1+I8eHyC7PsDU10dcueZv9e2LVH/Vh71Otw
	 YW06oAKIWIYHw0CuYdzRNZ5qAVSJ0HimNOkn3ia6MBD0WylewrkSdrTULF5Fkpt5PK
	 B61VI43+3EATMXnqdTb9JsXZdWNLPEyQXiLEoFMnNHbM9YDqWyQIdF8UR8TPxEs7b7
	 KZBTK9JMRTBzloKxYFlAQrpNoJVA9jMpoAdbp1UXQ4L1BNuNarTR449317aBdUTIHZ
	 RqBRD5br6tXuQ==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e7632b193so36718685a.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 17:03:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpCO4HTkjT8XYT92RiO6eUNONi21+sjtsKlhP2k1nH5JlOT/4/dPPYGkDcJ9rp1+KTZl5JsUt7E/U8yU8gQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TplFfdjylPnVKAzdqv1oFcp7EEYdnJ1D/ItE28LGWFunsjee
	730a3JBgUWLrGrljWMENEF0S+ItEf0jy58RTWAmES9Q3AYcc7Q/MLn6Ay39OKWknr2J0tCJIET8
	2mdqz7s2zKXBJj6Skz1rqOof/1/nliLs=
X-Received: by 2002:a05:620a:3728:b0:915:b852:4361 with SMTP id
 af79cd13be357-936b3a7e00cmr113938785a.20.1786492982920; Tue, 11 Aug 2026
 17:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <56e974b384ffbb3f8b424e7c69da3f702f87f2f8.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <56e974b384ffbb3f8b424e7c69da3f702f87f2f8.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 17:02:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6EHzoqmHExDiUXSm0MmFH-PLdV8GNYCUNJA9xfj=hkkA@mail.gmail.com>
X-Gm-Features: AUfX_myU79kwtA8KLOeDN0dTNn1aonfc4LkMsrlHzwmFWelV0XLc1lXPl_idklo
Message-ID: <CAPhsuW6EHzoqmHExDiUXSm0MmFH-PLdV8GNYCUNJA9xfj=hkkA@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] klp-build: Add arm64 syscall patching macro
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Add arm64 support for KLP_SYSCALL_DEFINEx(), mirroring the arm64
> __SYSCALL_DEFINEx() pattern from arch/arm64/include/asm/syscall_wrapper.h=
.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
