Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CB2F5487
	for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271434; cv=none; b=SPxtURsdDtja8bFwfee2vCZC1e9Ni6barvCNKKjwpOsbb5uPDd46kZHFfP0eU3U8lkup5FISoLLh/Zng+8RuH81SX/BVbpNZ72x08V5lUR4HLWrbp8dKn74NmZ85wDmQn0jpUwyi+O3EEShZsGWCOFscfj0cqwkZDJgwT0CJ/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271434; c=relaxed/simple;
	bh=mdRHxPO65Zu0Xe+URvKXqIZJjEeUBJGZsZOu0DoJxXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGjFgMtrNgwR5Sos5eNWtCp5q83finRUs0tpBHnEihm9Qe4L07LhMAeTRJOxh4kizEf1PKQrfSiY3vJbbT0BYaglElpkjQ9uK5O1hD1nDEMsRH3bVFRlQJSWdqBUYlws5n2Q3mdTinb9bJi3Es166xqW9JRoJQJ43bAz3cdPYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKY6CSiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKY6CSiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEFEC2BCB0
	for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773271434;
	bh=mdRHxPO65Zu0Xe+URvKXqIZJjEeUBJGZsZOu0DoJxXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SKY6CSiXkmd5NVqnMn0YpSndGJXaXHirNQvsimbB+qDU3ZX3ppA+PRf/L7OBZu8KZ
	 gtTJcc92H6MSaTEAmmCXqU/wM0Nm4xBY2QNF0vwpJcVGQlQDeevAck3gtt2P5GKXG/
	 SWGLXQWVSym2caQMAi307DnGXC6fActrYDVtjA5NhpmS75cmNYzvWp61OyjA/Xy4nj
	 xYvlFVz2qaJPEY/Eg/tsLS2+UJYdg2o4BXoLj9DBxgZ/zYZGi3zh17RAoCCNlmoJ8D
	 tfgdnWGNs1/byN22UELnRs3VpH6zJZV6vfv5ODbA7HYe2CdSvgIF9354/2iTUTkfut
	 ycJsbDb7CO8EA==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899ee491af3so4888236d6.1
        for <live-patching@vger.kernel.org>; Wed, 11 Mar 2026 16:23:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPn+F4rpDNUVcNtnJiccxMaiWUvhu4Vc5VNNFGN2N64V6FitSvz5ggpDtGSHYbwyJ0wNbx4HVb2kGtTp81@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7EkfbdwzipRdGR15QW1nO5cXd7BE9oAd10EBVJ1mJ5/6B60o
	jnR/8DOoWvPYDN4kv3UqdoX4Z2sbB3EGLVcRsAWwlom7GxcuRoW3YwTqkRPFAXvvVLKzW4bjRIT
	h0+FLX0smbLYJg6TPih0rM8A634ncYnY=
X-Received: by 2002:a05:6214:19cb:b0:89a:6353:ac1e with SMTP id
 6a1803df08f44-89a66a24d02mr64053016d6.11.1773271433195; Wed, 11 Mar 2026
 16:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772681234.git.jpoimboe@kernel.org>
In-Reply-To: <cover.1772681234.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Mar 2026 16:23:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5HRtBgz5F9nQs=VZK-fs++m=yk5KJxWHTag9Px49KRbg@mail.gmail.com>
X-Gm-Features: AaiRm51haeqPpuVb_a45rNDs0elojnpeLnlifdhIe3YBSUHOtrCBPshja6EG53M
Message-ID: <CAPhsuW5HRtBgz5F9nQs=VZK-fs++m=yk5KJxWHTag9Px49KRbg@mail.gmail.com>
Subject: Re: [PATCH 00/14] objtool/arm64: Port klp-build to arm64
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:31=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Port objtool and the klp-build tooling (for building livepatch modules)
> to arm64.
>
> Note this doesn't bring all the objtool bells and whistles to arm64, nor
> any of the CFG reverse engineering.  This only adds the bare minimum
> needed for 'objtool --checksum'.
>
> And note that objtool still doesn't get enabled at all for normal arm64
> kernel builds, so this doesn't affect any users other than those running
> klp-build directly.

I run this test [1] with this set on arm64. Everything works as expected.

Thanks for enabling this.
Song

[1] https://lore.kernel.org/live-patching/20260212192201.3593879-9-song@ker=
nel.org/
