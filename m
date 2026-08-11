Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFA44BC97
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467173; cv=pass; b=YDEdUpcvLDQYq+3tif8pDDNRuK1KcokIamJwXna1pQeAvOh2JZrfTqsVATycadQZR7D0RtFyUFScurOiao5lnVea4DrqwIEfGw1aeSbmyJA+O4gwe3zhP2Hdc2xjzEi7ycsJb+pD0pHgVaB1qprXt4lLOdhwUPUuMKRiI/ljn3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467173; c=relaxed/simple;
	bh=XG2BtcAcBkAu3fC3vQHnDe5ESH2u5V2rEqgwW+LqHQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqkKvanmleGe/W+gmAyrKjdyd4q/8dHQYHXlOPbG4ZTEpujUb2Nspp4w6gZ0en3mmFrdMqH9pjeqPY4Wly7O6CMrh3zuqZnm4zDHjNfD4s4FfhPb7i35p3uWN0Xbu4nkOpzT7/pUECwjAUnLZsocwldFNfC8hm5L4PO3uA/rvIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKM2puOJ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKM2puOJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so82357a12.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 09:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786467167; cv=none;
        d=google.com; s=arc-20260327;
        b=R1PuN63edz27ydb9OhNwjoq/I5vWR+2Jz0VJp/B8ytFBXbiPR+ipo7dIvJy3yk7LqO
         95eAGzcKZVuBWU81bxGK+Pu2+iYkHfHhPD1cuROFnuO2L5w8xnLtowR7rpUL9WWfhfsA
         8Y50QbyZjeOMskHqiit0ktR/P3TovtSLepw1NDmJNkzpi6Z4kJVXYDkLLYGkrvhceVXL
         jqK/3+yE8jLsxWBj1R/ehaWcvODHgT2zwjkzMWFqYNwloePj67N6wbRBmay5I+qyr61p
         z+njjduhjA8M37BY30ZwzfBSQHnYamhLirVmyrkc06TFA8LWMLGI8oja1NBZdDUW9G3v
         151Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S4As2mFA8aWYhfLWWIWRMoWPqMew/xqk5MDSmOKH9xs=;
        fh=lzV+FLn586bQhwCX4L3kqk2UHsCzXL69L3SdBWMPjSk=;
        b=E2d1JZO1L5E6DebKrZUCxGCJ7NNIhPuKb2MNPQTMNQXh4RSLbL80QmJrFTu50/6Lzt
         novwrt3UVaUo+dPNXHZpCnoxnjDufu09O2EFQCRGICkPKloVTr5hs/ZVOJwFQv/sE4Wn
         zBW6Dhe9Qwi6ZTNkJNCVGyFlEPDfClieiPaj31RXwq6IYee9K9fIoEJSxyNibuSEU1G/
         yqmmMttIyXa8p1dqlZaEPQ0oTxwnfGuk8IKKL2/4k+PHLnr8wdlQdxvOaU7/e1obOOTA
         1LkcU72Seb0IRX3UfqCy0CuszwOVG19hXaQotDCkd/ttWOb5y+cK1+C+hgZAjx4mMcz2
         DIpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786467167; x=1787071967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S4As2mFA8aWYhfLWWIWRMoWPqMew/xqk5MDSmOKH9xs=;
        b=ZKM2puOJaXMfdCitEsrZvsgXSpWNdkaQ7oL8+Q58WWp0M4SKKzgZydX12SHn9SRkuK
         YTsIHdiakul6g6xr9WwMKdZ6s4D2bJWJ0mie/K/2/d7j60Eudqv7V2WaeOVRhZRoP+S3
         Gquxc8dNhssB6qgKi8UUR1INBJ3IjrCOgsWlC1yTZUnXrNiCAiDCRuJZNDmCmLiH2bYY
         2lNdMI+od+tj3K3urNxQQwYDvrsuJgnVGehNSPO9RO/3QjNrgh/a8VU2SaZy69ul3T0i
         atYzSEy0cY05v1X1MYJ092VmITev5x+8cscX9MXA72OeyXg1Fjyxb6mIjcUmVAmP77ML
         D2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467167; x=1787071967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4As2mFA8aWYhfLWWIWRMoWPqMew/xqk5MDSmOKH9xs=;
        b=Am2/kv8smEZfTl7vr5nIIVu8f78DNuN/XHQAoCUqmnrfDQ9/YQhwQDk901GescSoMM
         1WYlJJLLM2x28Fz1i3aJFQE55O+iYyWJVZPnqS7jr9Tez/Gl2WYRq834QjWhsHUCx+m4
         w133qPko1OEk/8+o2mtTNqc+LkKePn0LgDs5hVHzUlvdBAMPlK3gGbYIKre28qa5GWiu
         Z73jbWKgTAD50MTrNmPR1WInyzLIbQEVOF4OmbE/n/ExIb5N2kRlKxeCgWE7lkg8qnya
         y/i4B1s/ErUcOzUsbHKUnxX4RO7BEM9JQdVzlKVcy8AIQALj2hu2dtE209GplZ2gfDNX
         xT3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp7VJftmQzO/V+dK+/+yAMKhKjG+D0X53nQncIpsk5cKHsQGVUpvX5pwjGmA3jRp0o1A0RNKOtZ7ny/BYRQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LnW8Y0W6TiZCNtirymqmByYwOsSyAA5te7qarskdq/AgqYC3
	pBy2yhbLdwHHcdrIsWi7sQxW4xAbjIPNyMmYt1YdetNRPcNO/M1/7yBfx8cN47sQ9z3fO9T3y/+
	dUGgyh19Bzy7EL5iJZHyXzcJc0qJsB9taLEOAQ+1x
X-Gm-Gg: AR+sD13VZJh3lzBViEG4bNGz2qfq3PbwotLpZBgexNG6CuEy04kIJ5nMLwVYTblmPhb
	NvgD+qD4wPbU9X0tmLC+l7aUGqQDFBnQ+4VB6bA98qpyU4s78U0Z3XKPVJWDQ5RnkatG7WtHO3q
	3nk86O2GANqnsGdS1oAWWW6bWmI6dRypFjaK7str3Pa3ZQ/+6NR7tnnFqMPGRIdD30x4c6r56/U
	O8fKJW1ERej/4FslGdHxxpZl4xM2qq+Mz4FMEkbwdj3ueOoRWnNZ8KJ4lpw54FqQUOlc9Hqlrhd
	rDXeKpp0V637LgUFBk0RYeqUiUpD4HJRhmOnXZ2EVhoWFBwsZE3tRLhqO+ZmWZy6vYs8ePPIgL+
	xHcBziyuw2J3eWKarOnh14WDoD3xlOcrNhgjOV8/UUQUN0hIdWBxIKXFq
X-Received: by 2002:a17:907:724f:b0:c20:6d47:34ee with SMTP id
 a640c23a62f3a-c20e6056af9mr215890166b.7.1786467166490; Tue, 11 Aug 2026
 09:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <anmobvJXiBQqWn6S@willie-the-truck> <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com> <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck> <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com> <answWdRpVQLtIzIj@willie-the-truck>
 <CAKwvOdkrxJ_9qjaBNQS+o=+_m_f3e9k6jMEmXB-S3+nXGoLV7w@mail.gmail.com> <buq25tpmdjlvskzfvlit6swc6tsjuzbdnjfix4w6af6247zads@ka44wuolomci>
In-Reply-To: <buq25tpmdjlvskzfvlit6swc6tsjuzbdnjfix4w6af6247zads@ka44wuolomci>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Aug 2026 09:52:34 -0700
X-Gm-Features: AUfX_mzCq3u81v06vYARR0AyhIU67S0yPka865w-1u9RG5j9RiVHj-bgtj-BOcg
Message-ID: <CAKwvOdkS5ZaBGaoiLwcXqCBjcOXLXE88VD3bj5ES1sssKFf4HA@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:41=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Aug 11, 2026 at 09:27:28AM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 11, 2026 at 7:23=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Tue, Aug 11, 2026 at 03:18:17PM +0200, Ard Biesheuvel wrote:
> > > >
> > > > On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
> > > > > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
> > > > >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wrote=
:
> > > > >
> > > > >>> Sure, but let's replace this with a link to a bug report in llv=
m's
> > > > >>> issue tracker?
> > > > >>
> > > > >> Yes, please! I can apply the patch once we have the bug number.
> > > > >>
> > > > >
> > > > > I can look into that.
> > > >
> > > > https://github.com/llvm/llvm-project/issues/215547
> > >
> > > Thanks, Ard. I've ended up with the patch below.
> >
> > What's the extent that HAVE_LIVEPATCH will be used?
> >
> > Does this penalize kernels built with BTI in favor of HAVE_LIVEPATCH?
> >
> > For example, with my Android hat on, if we have a kernel that's built
> > with ARM64_BTI_KERNEL=3Dy, and _dont_ use HAVE_LIVEPATCH, we're going t=
o
> > turn off BTI for a feature we're not using?  But maybe we _do_ intend
> > to use HAVE_LIVEPATCH, and my assumption was wrong?
>
> The problem isn't specific to livepatch, livepatch just makes it easier
> to hit.

Rereading Ard's report, let me see if I can articulate _how_ and tell
me if I'm still not getting it.

Let's say we have code in .init.text that calls code in .text. If
.text was placed large enough away from .init.text, we get a veneer
inserted by _the kernel_ (not the linker).  This veneer has an
indirect call to the destination. No landing pad. Boom.

Is that precise?

>
> --
> Josh



--=20
Thanks,
~Nick Desaulniers
