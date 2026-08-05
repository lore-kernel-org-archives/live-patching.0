Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E273EC6AE
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968667; cv=none; b=ahA4V/RGbgiUWVUv1y5I66eqqNIYSXSk1nBW0sinpuK6sHi44KIY1B+M5SB7sjuBquSAOEkhYW1pGIpdLzJP6C8I3Qn594VGHYOjWqzdSyDpP+sWzyCO9tGxCF59UJXTytFk+oCcbO2reLeHqJztaVdVHBHxxZo1lbUYT56jjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968667; c=relaxed/simple;
	bh=gTn8j2HBN0y2mi9HvgQ3sO2kXam/V46XgFTdCHWGqLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhsAseCRvsIV3tW+QLYjiOaXlwuLxEH26iuSBgd+meIJJ00zDsF0Z1CaSysOopQH2MRlpmJ72KuG4+wWkaPo3rJD3+iEqtcjBW5U1cv+qdl07tMQSJ2yiMVSL6Def9EkAPZOgjEykY9Oj3R2UEeUQDMMgDvKC+ujHQ2sK2a4D8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3jEh0BC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3jEh0BC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7B41F00A3F
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785968664;
	bh=ENRcmGxzjyY3XpPs6PARuF3JYs2UjxLqfuPHHDcJ0lU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M3jEh0BCmkEijQ9S6Ukz0S2VnAe7auPOsKuwPoyaV4XX22WvuJXlYoNsRbDmXiUZB
	 vXvuKvRrbiRFnVpJVB5lHOziH9WAGc2LUyUZcd1akNBteWMZwI4xWl5NYKxFuhVoPO
	 dehrQOd+bn5Dl7tEKvMT6rFJddp/eQe9K5epSf/l0x1XYoLsDPpb6nEIeA6oRlUo2B
	 Lbmqa6fDVz906Dt2kBTns9mOxCA581zYfjAxbsloyuCvomFdHRhf03OXMosi1zup/4
	 vucQsFur6hr0MNu0CZVsaiyfo8fFVViNMN6c+4tdeSf5j1Rjc7LxOvRROw0y1btv3J
	 CVMFRDKVnY8vw==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5c92c389so87871185a.3
        for <live-patching@vger.kernel.org>; Wed, 05 Aug 2026 15:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpQ7Q/JPvYGKazQhaTP5ehq2aT36A/YWYXfMGdmD66uxWIkdbU83/bgoprLBid04nmILzRQ63PL/4Am/FoD@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/YyRHKr7olqP/cYBH8VjT6whrRjpNgPqBagqYVORNwGuOBRF
	BI9Lc2Uv70TLRvBUNyra6LRefzldawumtpOMobKmi5sIfeFBr48dVRZebcXFwBZMPc11MXiTRO0
	0xm0HZ+lH7XtfVZKqZ4k7VvpvW/d+zWY=
X-Received: by 2002:a05:620a:c53:b0:930:fad2:fd with SMTP id
 af79cd13be357-93649161658mr846282585a.17.1785968663907; Wed, 05 Aug 2026
 15:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <f7aa7f27c504588b2588f5f9870c21f45adfdcfd.1785939903.git.jpoimboe@kernel.org>
In-Reply-To: <f7aa7f27c504588b2588f5f9870c21f45adfdcfd.1785939903.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Aug 2026 15:24:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4rcUV564iOU3adNpq5PwG3hM1gZcXmy4xbycp49AX4nw@mail.gmail.com>
X-Gm-Features: AUfX_myrH8440vsiRni7vmGbEVku-ymsq0spKBzE3s0lx1iKGyIFYBpEKpw-3J0
Message-ID: <CAPhsuW4rcUV564iOU3adNpq5PwG3hM1gZcXmy4xbycp49AX4nw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] objtool/klp: Allow new references to module exports
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> From: Joe Lawrence <joe.lawrence@redhat.com>
>
> klp_reloc_needed() returns true for module exports to support
> late-module patching.  However, clone_reloc_klp() unconditionally
> rejects symbols without a twin (i.e., new references added by the
> patch), even when the symbol is a known export from Module.symvers.
>
> Relax the check: allow new references to exported symbols by only
> erroring on !twin when there is no export.  The export metadata from
> Module.symvers provides sufficient context to emit the klp-relocation
> without a twin.
>
> For a module export that isn't sufficient on its own though, as the
> resulting klp relocation will only be resolved at patch-enable time if
> the exporting module is loaded.
>
> If the original (unpatched) module already depends on the exporting
> module, the dependency is safe: the module loader ensures the dependency
> is satisfied before the patched module can be loaded, so the
> klp relocation target will exist.
>
> However, if the patch introduces a reference to a module that the
> original doesn't depend on, there is no such guarantee.  The exporting
> module could be absent or could be unloaded at any time, leading to a
> relocation failure or use-after-free.
>
> So also add a build-time check: when a new symbol reference (no twin)
> targets a module export, verify that the original module already has at
> least one UNDEF symbol resolving to that same exporting module.  If not,
> error out with a diagnostic message.
>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
