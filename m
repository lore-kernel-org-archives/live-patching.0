Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE8453A58
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467935; cv=pass; b=oF4Ys4PMkYqcV5xVDbacYfowNky4eC8Dvf/b/1ppb98obmP+H4GA/YZqgjaOozuhBdjZ7+fYAnohZ2DBqR0G2qjsATV/8aI7VzrVFTanuBTXDWWIga5gG2Ez50XHX8Pg2fdyIynYMZW9uWuQDuqpKJHqk/1wvMzGBDVnsy6CL9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467935; c=relaxed/simple;
	bh=+Ypz7U6buxgORh1OWluKZomr0xkAeqqYj2KfousPsr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2r5meshH5FHuzMTd/rKw+FMoiSf/7cME3ULhMudb1WWgKiDG2v8bzY7rXUwUZStQAA3P2lpf5j0n6C4hx4COi3NbJXoXtk0gCZ/SC6t1TuFEc4d4hkEw3qe/d21Wt1BNMLHbM6SoEyETXkqjpT5QnRuMRPqD/rveoawbNYkvQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjOCivRG; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjOCivRG"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15d47266baso4011266b.3
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 10:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786467932; cv=none;
        d=google.com; s=arc-20260327;
        b=mhm01agNQd/HMWNwVFGPW7c6ISngISkFHgDZVn+PlK7lxZ3aUyWFf1sEcuXjtsa32K
         Z9C3pKrGvu/snjSmg5O6o7TnvAPpKUZwLTVR7PzvP6KrFIMeHPNEaBUmYD1ukYMzIwFW
         UcxO6wnMrVjXMa/cKQ1ymRvL+5uXnfnUVu+VM7Q7ov7AJhkuoHPBSiWkjeVcynKx5KhP
         yqvOZ5voFQBQm6tGY+e62lheYMely8Iuggf7xBN4z+G/ocYGEyIlw/iTataNGKYa7DPK
         FerkhyrWkcuiccZXsztsv+1Nc/a+Sazg2PSQ5LhrxqZxKZ1G4cIV1PfqtcvHWzIWztDs
         d/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pGAMSHHCOy6Ofyjr6GQGUC1+QOQEyOWjz2kH/2YxslA=;
        fh=Yz0yHt05jm6or9U8AM6ntbDfXA0ZxHuBv4UnPDeTMKo=;
        b=mg3jgq2+ZXT9VJ3WJaBWtXXHZPcajaYsYCGd6qF61/NWflUCHizxyFx5lMObFcxalv
         H8vCuhW45szglARN588yIZ9cWsBqyfUVTty9M9lN/WPAXalCEFAGhuNmKzFd1sUb6LM0
         khUyw4fJxiQ+x74VtfGHAbcA+UX7T3tgo3cjo/7g2b4onQxDZZgUQanC4rmCICGPvBNA
         GarSYQUeGKiqP664E9Lb0JV0wEcHXwvtqFGUYIX2F7HQFjqOphwShe0YUOKskS3/8sUa
         UzpUYtCIkTFiRFOQ5a8S00DdqssbeI+U8GQ99HdnYYBvmsmugQO4IwKVoscfZiTMq/du
         u1oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786467932; x=1787072732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pGAMSHHCOy6Ofyjr6GQGUC1+QOQEyOWjz2kH/2YxslA=;
        b=hjOCivRGQrTZoETld+lKPxLmVwTLXz7SpAvmmgB02vM+0A96ijc29tSxp3VBArBZo/
         74iYx7fcCEN0wGOusYWA8ZFUTWNpdKMAVatWdJScPQ1NWXSRTD0pHyIgnlnAiLOIetbP
         TQ1VeDWbvTlFDaVvh8HuUXwRAAUVeWD6HFwp84JUauW3cxwCWgZrWD5MtIGUF0ZFezSD
         ubpZmoqK9kvWmKwcS3BeUORayIn1BNj4JxP2JVzFeVAYuYWVrso7i2A+YLqSfQ4iSrnx
         X3gM7sIQwy6MT39yggmYmfVJ7yRULKxi9UR9y/Lf7TlHGPXpZ/5F1LYW71ODlN311Zp4
         qR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467932; x=1787072732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGAMSHHCOy6Ofyjr6GQGUC1+QOQEyOWjz2kH/2YxslA=;
        b=SGqYzSRBNk57+4qRWweYtTrsYv6ovZbXkuJ/SD3dbA9q3LN0EnDB1LSt+97pzEVoG+
         h1BMMc/3wVzzqts9R9JMcwoYxPuIZ4nIy8crKPWTRmydCSDSqvrr4/uN8nWDtbfuiBn+
         GUrY0ne07R32Qpev6SBLvJ2VKQEeoS1+jFLPXGuMhspX1ziVA5nYrz9X+wD120rCb2hH
         4EVOA4APRwaOHr6WY1+ojsmn0rG46I7f1J/NQE/r1Vs7O345vCWYrdu45opyCbDjTh0o
         H/TzaeOk2t/yWKDPQlaQ/MXJNhTzQAr+XBwy21yuH/n5pQIMkJ6rS3ZMpa+QMwlGH+H3
         3eOg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Ffi/2yvHLVeUwyTyU5AAU4PeVx0x3tB7ojoE++oL6iUTH7NkeIQ1TtcpaYW+F6sY8eFmn1477Lyd6RIO@vger.kernel.org
X-Gm-Message-State: AOJu0YztJaOei2Tyt9Vlp1nTuVFs+1XMF8S4I59wEOpTHpZg/rUTlaMk
	HcV6dZtn2Apw43qj6KtTMmSB6GNn0nmyzukDj4mdrcK+7T5P5lA/14eW8zhEhA0YWN3Z/20NJGX
	P318jZQZKtQ0DuZWpGEaZXG4P0hU6C0wkROYg2zF5
X-Gm-Gg: AR+sD12bA64Sl8V6/BSOVI0ltej1DlYffgH/RjuE4yFco9OkDy1xFKf/y+5c73Al+KF
	4hwSlL4yDxIT8f+AY498rjXwHsf+aHET18gf/9OJlUE5ws+ftZZeRYckmlpBRQtJxIxl546aeOz
	YedXpw3a9ZrQlLEOzcjvJ/lNwJbrOYMX5pNvAGBh5pIfEoh46ZANeNemCRvY5+GB0olwcdgxTPO
	iOmK+PnROa8TmIGsxQsqMAz3kQI02LrqwK9IPkeFhxNpQmkAvi6L32/x2n1+gPcuuLYdp24a3Xp
	wOf3ZHEEOOcwghdKhhUCkm418ba2b5o5UXH9jdpoRH8s+YfG+7RyOHyd4OTVbH235DqDrj0mxEE
	gEE/2BXASDa2A3UoyxoOH3KXDrTh2baD4ZkOKHlLB9ItPJypV/Bf/Xhis
X-Received: by 2002:a17:907:3e12:b0:c12:74af:51f3 with SMTP id
 a640c23a62f3a-c20e6001576mr216510566b.6.1786467931201; Tue, 11 Aug 2026
 10:05:31 -0700 (PDT)
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
 <CAKwvOdkrxJ_9qjaBNQS+o=+_m_f3e9k6jMEmXB-S3+nXGoLV7w@mail.gmail.com>
 <buq25tpmdjlvskzfvlit6swc6tsjuzbdnjfix4w6af6247zads@ka44wuolomci>
 <CAKwvOdkS5ZaBGaoiLwcXqCBjcOXLXE88VD3bj5ES1sssKFf4HA@mail.gmail.com> <b4bdf563-274f-4ab9-804f-35c47ab2f353@app.fastmail.com>
In-Reply-To: <b4bdf563-274f-4ab9-804f-35c47ab2f353@app.fastmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Aug 2026 10:05:19 -0700
X-Gm-Features: AUfX_mzxcGN4sb7ijjP5MydmAq4VJWRREtt4XkYwb-Zv99DfIfR8xj3RcsJ8Zs8
Message-ID: <CAKwvOdkn1WycY5d1EaOTdWWL-wH1wSeWxDGJJgmt2QW7PoQp4w@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:55=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
>
> On Tue, 11 Aug 2026, at 18:52, Nick Desaulniers wrote:
> > On Tue, Aug 11, 2026 at 9:41=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> >>
> >> On Tue, Aug 11, 2026 at 09:27:28AM -0700, Nick Desaulniers wrote:
> >> > On Tue, Aug 11, 2026 at 7:23=E2=80=AFAM Will Deacon <will@kernel.org=
> wrote:
> >> > >
> >> > > On Tue, Aug 11, 2026 at 03:18:17PM +0200, Ard Biesheuvel wrote:
> >> > > >
> >> > > > On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
> >> > > > > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
> >> > > > >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wr=
ote:
> >> > > > >
> >> > > > >>> Sure, but let's replace this with a link to a bug report in =
llvm's
> >> > > > >>> issue tracker?
> >> > > > >>
> >> > > > >> Yes, please! I can apply the patch once we have the bug numbe=
r.
> >> > > > >>
> >> > > > >
> >> > > > > I can look into that.
> >> > > >
> >> > > > https://github.com/llvm/llvm-project/issues/215547
> >> > >
> >> > > Thanks, Ard. I've ended up with the patch below.
> >> >
> >> > What's the extent that HAVE_LIVEPATCH will be used?
> >> >
> >> > Does this penalize kernels built with BTI in favor of HAVE_LIVEPATCH=
?
> >> >
> >> > For example, with my Android hat on, if we have a kernel that's buil=
t
> >> > with ARM64_BTI_KERNEL=3Dy, and _dont_ use HAVE_LIVEPATCH, we're goin=
g to
> >> > turn off BTI for a feature we're not using?  But maybe we _do_ inten=
d
> >> > to use HAVE_LIVEPATCH, and my assumption was wrong?
> >>
> >> The problem isn't specific to livepatch, livepatch just makes it easie=
r
> >> to hit.
> >
> > Rereading Ard's report, let me see if I can articulate _how_ and tell
> > me if I'm still not getting it.
> >
> > Let's say we have code in .init.text that calls code in .text. If
> > .text was placed large enough away from .init.text, we get a veneer
> > inserted by _the kernel_ (not the linker).  This veneer has an
> > indirect call to the destination. No landing pad. Boom.
> >
> > Is that precise?
> >
>
> Yes.

Naive question: Could the machinery that emits the veneer instead emit
N veneers, one for each cross section reference?  Rather than one
veneer that could branch indirectly to N destinations (that probably
don't have landing pads), could we instead have N veneers that branch
directly to 1 location each?  Are the veneers larger than just a
branch?  Is the destination unknown when the veneers are created? This
would retain the landing pad elision optimization for .text (which is
likely run more frequently than .init.text), and you could probably
put those veneers in .init.text and throw them away with the rest of
__init.

--=20
Thanks,
~Nick Desaulniers
