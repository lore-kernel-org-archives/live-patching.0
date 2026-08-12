Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E427FD4B
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492828; cv=none; b=CCfDBrwEhsNIdNcegzAi2pUPK2MM3ADpZCFhthiKbVY+X6Se03F1Pl3RUohpotigZPt1+Gqr4Q7aDfUOEguSZNZgjk23sFBXg0swF0msCN4csV+l1BytmDjR69DDIYc/T/dkuF5akeWubHd4NQtaRy/fIi0gsPTl+lT8EtQNNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492828; c=relaxed/simple;
	bh=sF+TCiA6ArIyA5AxwWCkmZGXn1NQFmtsyN4h/TlIa2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuTAdr6dZV0t4tvzFsT3NFAB48FkvrGGymT2vIGW01MHEtUyW9cUV2ILABmk8RvCEWtmKppQJz9Nm2Ux5CtoUxQK+sPwyiykvt9T1jviJIpo17pQKyC5fefF6I1szsz1kxSFkxcK58h9J0waFmABnuSxNeTCB/FFraET6x1SnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgT1UEUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgT1UEUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028911F0155A
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492827;
	bh=Fz3n2kx5aGQtVo+6M77EKhOapmsUAGWKVN5VjqkySUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OgT1UEUyZfZOiE8a5yKaPqQyTnh0Q84VTqxwcp7BDZsqoNdPYTUbOqXI4jVbnS4pz
	 UAQUfmyE1LLWa4FmjWveK2CYXcsWD8Zx6fTTEh5qiXZ0ZlfbC29Yob63F59zNvf95n
	 W3jIsR93h7z+Jaiot1OskgtUn+3C1thKlTmBgOJIosJKa/GNtlDkcMfQswRRV/Yu61
	 pH25Krr/C3yF3BxmCmADFV+QL1GIzOOjh52Xtj6h44x3hvL+9ny1s6AcPl+AcN+yPQ
	 DWdVsWBlZpR5DLMgMQpzGAsmhn4vcWoNPM+1l2M8z1HVcfg9QQ2W58fULHggNH8jE4
	 DXGuZpv6RXYwg==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-934956bee57so48914785a.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 17:00:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpX4izIXgVphVzTh0ywBq+1KnTAM+AfQbO5z34X/GlC3I4gQ4jgiwJOuavtj4FoE8f5oZLpoJFw/+IVgaKu@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnr4nxrj1QRI3Mh3BktGOPEjK0hoOnZ8jd0V5//APzGfAsPpI
	59UoiiCwzxJeRMsh3kQ4xiyCUkCrie+kzJBWghkP7H10ygl3wZ1yDn7Bcm1s5mtkTGA4NSRJLDE
	GAr30Apvg7ZRByByKLpTFf+n5Dw1GT0U=
X-Received: by 2002:a05:620a:2713:b0:930:fa5b:6ee8 with SMTP id
 af79cd13be357-936b3e1a2d3mr134602685a.45.1786492826100; Tue, 11 Aug 2026
 17:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <6f447024ac8b79a1a6f1b8eb1c5eb1b51017af79.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <6f447024ac8b79a1a6f1b8eb1c5eb1b51017af79.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 17:00:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW67-1chkvWrkySov3YMmiMvEWBSkE=b9xJ2Auay5GUazQ@mail.gmail.com>
X-Gm-Features: AUfX_my4jo80oP9q5uyoFMIHTpQXW7THsLSWkeLbBnzcmKVQED9n-OqEpUJakQo
Message-ID: <CAPhsuW67-1chkvWrkySov3YMmiMvEWBSkE=b9xJ2Auay5GUazQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/22] objtool/klp: Don't correlate arm64 mapping symbols
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
> ARM64 ELF files contain mapping symbols ($d, $x, $a, etc.) which mark
> transitions between code and data.  There are thousands of them per
> object file, all sharing the same few names.
>
> They aren't "real" symbols so there's no need to correlate them.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
