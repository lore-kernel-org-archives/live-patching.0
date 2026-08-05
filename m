Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD623D6477
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963119; cv=none; b=X0Gv6FvfbtT5KDXgZavpY1VU+OeKb9KtqMv6n4L0xVKgeZf8k+nOjZhtt7l0qVT8cu8QriqXhvXUcbFZ8+nWnrsHt5hTAKt1W7sUZcKiX4v525MEfuCLs+2RogVnQPc70u11sNxZYuvZIq1mg0PnyxdZARoI476FDnlOjErtLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963119; c=relaxed/simple;
	bh=KKm5UEVpbTqRu1LmC8tXlhWLKKi6EbDbC1H5b+fYsnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeBorl5/21NCQW4h1qiMx1gDNXkLE9JOap0FiAk+0TmyuMt/ZyBMiKItCyp884HLm2ReoZien4B+2UzDjaopOCWvKGhJBcDCe2H/VkHEY8Jmlgva4eubj4MFzxEA2IbeyxpCvWfBy+MhLzgtsf/R5fCgMl5AoEU+8OB69jq91gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDIMoAyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDIMoAyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBAB1F000E9
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 20:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963117;
	bh=w88bvYodNypk/ChdJGp8a3ODMwQLJ+RhrEmZDn4AMOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HDIMoAybRxPO/xqjNtyCcBDLkBbasxgCxt2nLa4dnaAKlPr1ZbKnuMtPAGO8nOPQk
	 7892E/a6mcOrjw/Nwr5hozx4TCCtk3dRTXHmOxM8FaVVccP8YRZQA89x0Hv3BMns21
	 smG59iP1kM4X+PqdmFMyh+1HYUJQC+meUbnD6k1RL2FzZcYZ8TJ89k1uCEYRyAPk0z
	 mYDLr1WOOYR2ADECoJkX6SrFhR5WCHpgpOGscchIP97LatHPh/evwnAlrhOTgGOQgu
	 ocF5hkbwE7GnSPggptK2Z4twfAS/yfyzSrKcSbiL32oD6aZXaBm4aC1URyGHO1UFlk
	 JSTAzSOzJrezw==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e53581361so88108085a.1
        for <live-patching@vger.kernel.org>; Wed, 05 Aug 2026 13:51:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrFb1MWEuOqztqA30TQvwsyrjVt1lkuR46mxWsJg6FcJl50Vo47Dvrzq0vcxpl0zn/IkwFfAPYtDwdhbrMc@vger.kernel.org
X-Gm-Message-State: AOJu0YzoE1I/t1IF61t9gDEglRBf/IFiyk4SEkPaX3mEkW1R+nfjBKxf
	YB0t7tGiuttYoGIh7/I6u+DNXZ5h4O7M76fykbAN+nPUraKROunaGFIe/P57mOMCeySQClH+oO5
	tVlk6rD7yGf83x7xd07by/+BcVsIweAg=
X-Received: by 2002:a05:620a:aa01:b0:927:25f5:ee08 with SMTP id
 af79cd13be357-936491552dcmr757140685a.43.1785963117057; Wed, 05 Aug 2026
 13:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <9f9c0c444e078869f2bceac7ecc72fe7310e188f.1785939903.git.jpoimboe@kernel.org>
In-Reply-To: <9f9c0c444e078869f2bceac7ecc72fe7310e188f.1785939903.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Aug 2026 13:51:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5i95esQj9yT8M5Rv=KyqQDU+NBp=R9t+T=Ngd0JXA3Yg@mail.gmail.com>
X-Gm-Features: AUfX_mxX1y6WlxV3N7zvMaS96mnseI-eviYwz3oMDq7tD1CDNMxs3DWvAw2Yo8U
Message-ID: <CAPhsuW5i95esQj9yT8M5Rv=KyqQDU+NBp=R9t+T=Ngd0JXA3Yg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] objtool/klp: Ignore replacement offset of empty
 x86 alternatives
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> An x86 alternative with an empty replacement, e.g. the second entry of
>
>   ALTERNATIVE_2("orig", "repl", ft1, "", ft2)
>
> has a replacementlen of zero.  Its replacement offset still gets a
> relocation, but the label it points at is the end of the previous
> replacement, which is also the beginning of the *next* alternative's
> replacement.  The value is meaningless; get_alt_entry() already ignores
> it for that reason.
>
> klp diff doesn't ignore it.  When such an alternative belongs to a
> changed function, cloning its relocations drags in the unrelated
> neighboring replacement, along with everything that replacement
> references.  On an x86 clang/lto build an empty alternative in
> meminfo_proc_show() pulled in the replacement of an alternative in
> proc_kcore_init(), silently emitting a klp relocation against init text
> which has long since been freed by the time the patch is applied.
>
> Add arch_alt_ignore_new_reloc() and skip such relocations when cloning.
> This has to be arch specific: on arm64 a zero-length replacement instead
> identifies an alternative callback, whose replacement offset points at
> the callback function and must be preserved.
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

The patch looks good to me.

Acked-by: Song Liu <song@kernel.org>

Maybe we should add a __weak version of arch_alt_ignore_new_reloc(),
but that can wait until we add arm64 support.

However, this reminds me the cross compile use case. With current
arch_* functions, we cannot run klp-build on x86_64 build server for
an arm64 kernel (right?). What's our plan with the cross-compile use
cases?

Thanks,
Song
