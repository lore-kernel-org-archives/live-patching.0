Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AB3D3CEB
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962199; cv=none; b=uhqy1sLBH1l0GRVTwTpnYVao9svKA50P2lcNS4AgytOnamkBZmRPEt9Nl7aImvvAUzdCaOHPpxJPrp7wsFiI6LxYEkQsg4CejrVisk6keiDBUG9ERTwS//xC+3E53TfyLww2FZeFdXWMjfVLWbcC54cr/Rwnp6zOxjDxj6KyvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962199; c=relaxed/simple;
	bh=uw67d/+SvXzNBtK/ER9HvDuERhIAuuU+gfWntqEgbTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K54yQ6mgCTiR0uUnZiFgD5KBRD9pRllfXuA8x/VxVgUlaChZj8d4pta/yM6Ln4miSohLDjbWNRtIDCB2n7DLnFwMlYdMnMK/5HAEox8a3xeaaNqCtEOPKGQaqSdh/Q/UsJ2tXDBo3SWRkXCw5K8O2GQ/oZZwP+xEV1/uXLuqddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS2WBS5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS2WBS5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FD1F00A3E
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962198;
	bh=Nja24SsaqxUB1zWTjrIw4e/gmfm/rK6fIdrPsDI07wY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dS2WBS5rI4HzgLHMgd9bf5p/C7ceTl0q25d8Jq/odBwxw3LX9N234rc7czDwUaUpp
	 t3oytF5jk7A9LP+BgEZYSOsr8HdWgsVT77sNukufFErr2LrdNzLZHS9wN9X3QkQyn1
	 OFI3YdHMUQMfVeGkEs/cUTBwz81OUuQ56ZcEriv6UTLnScOKDqfm5oJeHxbVsgGY3y
	 uwn6GxAOeJIijGpNEADghTLkMsqYlH8DBB9XIeKWzVHxpq8gt1TzKHNB4+TuknmvPE
	 lsBLGH4sgb6rv+y1Wl4mFn54s6HxTvccsIYKhWhoLJnyfiVmYq1ZIMhnv8l1c6/V5K
	 89xcr+6QB8kcQ==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930c0f9c1b1so92641985a.1
        for <live-patching@vger.kernel.org>; Wed, 05 Aug 2026 13:36:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roc7nsv6Xdk6kaNXbarkx1aUKtHL3rcr0R4gTLkoPFo/bABOe+AQ4Qw/8TnOhBffPl98REF4aI0CUVcoHuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUMPuKS4iOKf906afJf5BRYB1HeCle+ZtW28MwdzdLCc+w7OF
	ja+ts8VG0Mp7cpLNEdFHO3ul+IJSxZ0uaX1cCfkcqD/1lLFa/8pVLlhsoWiI+xqN9J5P7XDhEnu
	UUolq5cxWiwGZUN0sUfbEAsaIrTvoYjg=
X-Received: by 2002:a05:620a:5697:b0:931:4b6:a9e6 with SMTP id
 af79cd13be357-936492ece30mr686534285a.47.1785962197688; Wed, 05 Aug 2026
 13:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <d9debc941bd06c1a606ed7a366bff73d1680f0f8.1785939903.git.jpoimboe@kernel.org>
In-Reply-To: <d9debc941bd06c1a606ed7a366bff73d1680f0f8.1785939903.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Aug 2026 13:36:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW69pBfEzN=apAzQkSgY+FJvxeukgydNZwYSrpA6+kQ42Q@mail.gmail.com>
X-Gm-Features: AUfX_mwbeoyWxh5Y0o0FiEVPTgriyFVHNEmexP_ThhpIi4mtIPfd78I-5pgvzzU
Message-ID: <CAPhsuW69pBfEzN=apAzQkSgY+FJvxeukgydNZwYSrpA6+kQ42Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] objtool/klp: Fix size of empty special section entries
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
[...]
>
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 492d7a012cffe..11e8f3ddbb0e6 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1627,6 +1627,7 @@ static int create_fake_symbols(struct elf *elf)
>         for_each_reloc(sec->rsec, reloc) {
>                 unsigned long offset, size;
>                 struct reloc *next_reloc;
> +               bool last =3D true;
>
>                 if (annotype(elf, sec, reloc) !=3D ANNOTYPE_DATA_SPECIAL)
>                         continue;
> @@ -1641,10 +1642,11 @@ static int create_fake_symbols(struct elf *elf)
>                                 continue;
>
>                         size =3D reloc_addend(next_reloc) - offset;
> +                       last =3D false;
>                         break;
>                 }
>
> -               if (!size)
> +               if (last)
>                         size =3D sec_size(reloc->sym->sec) - offset;

Some comments about "last" logic here can be very helpful.

Also, with the last flag, "size =3D 0;" before the for_each_reloc_continue(=
)
loop can be removed.

Other than these nitpicks:

Acked-by: Song Liu <song@kernel.org>

>
>                 if (create_fake_symbol(elf, reloc->sym->sec, offset, size=
))
> --
> 2.54.0
>
