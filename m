Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCE33CE92
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637242; cv=none; b=pzt2m36nCahjLAFzxCRLaC9+U6bqbKQN1IR1mGzAc84I0ohwuzBAhCj9jFdZM8OSye9KuJMF9jnjc515/oK3+F5EuSRG6ELCRmUl+ol6Gc3/RlVP4pXIP+A/da+HHG4WR7JsqdrLlqBPh0N2PZsKCm06U8yVIpHurg6CK5EPtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637242; c=relaxed/simple;
	bh=vLzg6K724O3WBnQdU3VJjcbFlkyG86EKEkMglLS3WPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIj6MhqNXGxmwXD8urCKwm8GEXerSeL017F8fpbR7TxXAV9vAt90Voj4/DXv4hxLVSMXfzUYi4G9IjCZnz/zY/s+i9q1STGBB8NffLPgndefe4jSTA2fMYtfnmucnVe9WScXAkTlH0dmho/fpHfwAt1oyPG6ALbnk/gO0MpEFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLPRA+Hx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLPRA+Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CBEC2BCB4
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777637242;
	bh=vLzg6K724O3WBnQdU3VJjcbFlkyG86EKEkMglLS3WPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aLPRA+Hx/P3NWxvejHS3sr6O0ra71kDXKJy7ZC5noufR8yQoBOZKdii8ltI1zEHQ1
	 2nlwzSzL3J8oNHL/yUYSR/eUgCXgPSTBgzPhwmPUJHQ0SMBppE4etpwD7PjEo5cYn/
	 Ei8gdUd2UFdP61/UUOc4pcMfcV01DNarkkRfROL2uJ4kFuFkjh1r0N1koLAwbL3dE8
	 6IOLvr3ROUu4U4Y9Jt1RjSpqanyD90ogeOoXAuW27LFY4I//2Y/FDxPrSBYQognI1g
	 SvDXfntmf8WbuBQLDNvkRNl4hKDQm0Rigm/5AvDlwTLNfp+rVzQdRzYQv/zszhzbwh
	 vTz1tYXTPW2OQ==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c70b5594f4so190260785a.1
        for <live-patching@vger.kernel.org>; Fri, 01 May 2026 05:07:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8e6OXQO0E2hmp/kuNRjCMXdQIdGBtUhsRjNQMpC3Zrt/YUSeASloIGcSKTBtO5CEuF0z5AC5YrE94n31KA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+26HjtsDaGbjG0gNPHHMm6xCryYI1YdTr0BwbTMiatovhFCyo
	ImWCv/L9FEflk59iFwXDb+dr1qd4aF+P3WFPnY1pYa5VORh6KoZYXrbj1vx6iSdmVqPOdHKZagB
	asG7ljC351TbsLLng/e65yAabkTr1PuU=
X-Received: by 2002:a05:620a:460a:b0:8d6:6db0:88de with SMTP id
 af79cd13be357-8fabbda6a40mr845838185a.44.1777637241556; Fri, 01 May 2026
 05:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777575752.git.jpoimboe@kernel.org> <27fcb5a17cc7b6821d8b1c4b9812ebb5b4ee6a5c.1777575752.git.jpoimboe@kernel.org>
In-Reply-To: <27fcb5a17cc7b6821d8b1c4b9812ebb5b4ee6a5c.1777575752.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 1 May 2026 13:07:08 +0100
X-Gmail-Original-Message-ID: <CAPhsuW7Pmxt5MbNtmUWcpWxHBLhVK6TLocOmuEkJtHUBkmxueA@mail.gmail.com>
X-Gm-Features: AVHnY4LbNxT6noq7tHhfhXv5hfXEee0PL65aXaUTk3Jd60I3H8-J-6RnnE6SW5o
Message-ID: <CAPhsuW7Pmxt5MbNtmUWcpWxHBLhVK6TLocOmuEkJtHUBkmxueA@mail.gmail.com>
Subject: Re: [PATCH v2 46/53] objtool/klp: Rewrite symbol correlation algorithm
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 5:09=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Rewrite the symbol correlation code, using a tiered list of
> deterministic strategies in a loop.  For duplicately named symbols, each
> tier applies a filter with the goal of finding a 1:1 deterministic
> correlation between the original and patched version of the symbol.
>
> The three matching strategies are:
>
>   find_twin(): A funnel of progressively tighter filters.  Candidates
>   with the same demangled name are counted at four levels: name, scope
>   (local-vs-global), file (strict file association), and checksum
>   (unchanged functions).  The widest level that yields a 1:1 match wins,
>   narrower levels are only tried when the wider level is ambiguous.
>
>   find_twin_suffixed(): Uses already-correlated LLVM symbol pairs to map
>   .llvm.<hash> suffixes from orig to patched.  Because all promoted
>   symbols from the same TU share the same hash, one correlated pair
>   seeds the mapping for the entire TU.
>
>   find_twin_positional(): Last resort, matches symbols by position among
>   same-named candidates, similar to livepatch sympos.  Used for data
>   objects like __quirk variables where no deterministic filter can
>   distinguish the candidates.
>
> Overall this works much better than the existing algorithm, particularly
> with LTO kernels.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>

Thanks for improving the correlation algorithm and adding detailed
comments about all these scenarios!
