Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177639099B
	for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267646; cv=none; b=GCjAzc575F+30Nv24vNWDzUhaGy7ilor7eIEqw3wD+4bxpwJNLAgaor0TnKAWxRHnJ2BqNmgBx7dmR9PcsygtcReXKai7h5D1lcniV9J2F3JF9avnrAD3RLs3pT7beZKWAPAdkQ3VbzX+IKXun2aK6n6YSTM/wsf31hkq/ZJ6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267646; c=relaxed/simple;
	bh=DF0iVsiMlxRUA6Ee8PQbkiVwsVQBuMlOuXazbXaok7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb74fOS7eOGVREBj9zuCLEPBypi1LIZmSTab3vFwzt+gKtrilOZ5vcNgpbZ1fjKvL3c2+aHCLCfTNE0J+l2CVSLWxhgQXyd97QfGuuDvp8WKbfGheriw9OrbU2ILjT1vrA07UtxE9JubDhDM5Oe3hPiF8X64f8pf2UxXpXugAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0840S2m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0840S2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2682BC19425
	for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773267646;
	bh=DF0iVsiMlxRUA6Ee8PQbkiVwsVQBuMlOuXazbXaok7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m0840S2mfMEQdFnLyTT1lEeoFg9TPeVLwUsMERazMNr2eZad6JPUWgUSoSiS1ghvk
	 cXEcK1tHnjfhSZEHKt7UrfFVog8eDIV1qw3OVgu+TCEIdHyEGPbEH2/vWcZKGpx006
	 Zfa+nddh9qsnLpNC4+NULys7eTVYmMlt4lUWl7//OxFk6cyN9Zjh+CMqjOKiBqVklw
	 woA51+8Paa34U3KXmV+FiC9LvpTM7jF1zxleq2F6tuGq8rTbw5XNf/T0qDJXPPjw+Q
	 snGsF5CV/CbZu4fX0C4FHWtbmHd909W9Cb1YHf5/u3URSdpRNtMqu54PWiELx7i7X8
	 COTcDfj7CwChw==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fac9caabso4953896d6.1
        for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 15:20:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpOISsg3y7SXFABK20no2kbAeqdTPB+HwL7WRVjX/xY1lmC/B6
	2LTcidUH6L5R9iXtd2OhxCzs1kTWYrxPPs/xB0r4ACKnxbB7sNJ4K10TW/mBXpr/9dLh5gn8UE7
	dqa5vTFxjELK7tysZClZ+KkV5pbwFYA8=
X-Received: by 2002:a05:6214:5286:b0:89a:1bd:22f with SMTP id
 6a1803df08f44-89a66aa2f30mr60246686d6.48.1773267645228; Wed, 11 Mar 2026
 15:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310203751.1479229-1-joe.lawrence@redhat.com> <20260310203751.1479229-5-joe.lawrence@redhat.com>
In-Reply-To: <20260310203751.1479229-5-joe.lawrence@redhat.com>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Mar 2026 15:20:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW44hJ28WPXkHAf6+oUHZRyFBceTnJ+JU_crAKq=4cs5TA@mail.gmail.com>
X-Gm-Features: AaiRm52EmxrJOA1Ych9TcYauZ-MGYzct7KtjF9nmLUf-uXmKhQHVwxQezB7eWdU
Message-ID: <CAPhsuW44hJ28WPXkHAf6+oUHZRyFBceTnJ+JU_crAKq=4cs5TA@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] livepatch/klp-build: switch to GNU patch and recountdiff
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:38=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> The klp-build script is currently very strict with input patches,
> requiring them to apply cleanly via `git apply --recount`.  This
> prevents the use of patches with minor contextual fuzz relative to the
> target kernel sources.
>
> To allow users to reuse a patch across similar kernel streams, switch to
> using GNU patch and patchutils for intermediate patch manipulation.
> Update the logic for applying, reverting, and regenerating patches:
>
> - Use 'patch -p1' for better handling of context fuzz.
> - Use 'recountdiff' to update line counts after FIX_PATCH_LINES.
> - Drop git_refresh() and related git-specific logic.
>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Song Liu <song@kernel.org>
