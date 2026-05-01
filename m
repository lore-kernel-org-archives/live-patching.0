Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F87383C60
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631773; cv=none; b=IjbuNWhvmI4NquIYMNuqeDRZoxPmxtknybk8XHc3Uy2xyP0TRzggHi5BNmFgn4G6osDjM2jaD7fnklDeH8xgtajnhq0QJ+BVNc9XTSRmkOakCY0R0AheFh+sPwbuDnIJvUUhdl02lK7IOzi2Q90dtyP6SuQJ6P6YtXX++wmNm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631773; c=relaxed/simple;
	bh=JtP1beQhA06wd1Qaxt8DHFGXvgdTZ9GOB+DjPnGqg+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B52BWmJQN+lcC2YS9Ero6zxCY1L5ZreS4vVkeyKEtmmQsT6lp/+jUuct9jgU1/vkyhhhlk20TksCddN2kLFxmElg7jodU+vX2RMw9Orlx01f7+5g/Dw27e4naolenuY+mkejE4vMPk7qV1xkpP7nj2vwHxdy4JopXmvkhwW1YVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcj0F3sA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcj0F3sA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23293C2BCB4
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777631773;
	bh=JtP1beQhA06wd1Qaxt8DHFGXvgdTZ9GOB+DjPnGqg+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hcj0F3sAbsBwlIBnHFHvq6ovw1UsMt8X2YlixSbA9WzxT5V8mlD4x5wa2D6A6LzWZ
	 2xo43DYZve1jhuWVK/Ozu8BQmqNQ9okR9+vAILwwNHmqLIERaLLLWWJ8i2jsuVWOam
	 dYwwbyf/+B5aABtIfW3/XKCsKjLz0PuSvViBGNKf7P+PRoRuXfPWLPp0n2MsymaHnd
	 WXZtKOQOFneTSANfsH4WjmoVgSW5tBZHREeHCmjtPBIfbdfkDF8OePJAgF5BAbEMuS
	 DREH1wrfPMkXq50n+i55WGdlQONxlyQaZ62tId9Y1on1jp2zBGBqB+kUD82zouwFPF
	 HeGBFLexyWHag==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso16024116d6.0
        for <live-patching@vger.kernel.org>; Fri, 01 May 2026 03:36:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ86yWqT9c9gBe0zI9ZmrsPwqqdT+3BO8vTeRYMy2ypks+ZEz6RmFMK0Ikj/FwPq0KME84iwlPHiFAvYIDPg@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiz9QbwNZWtf7NTRvmEKoy5KejjpfbBaxBikH156NlEbLYh9+
	dA1FAoBuJL1Jogb1eeA5TV1wXRL1YL1zk/qvMUVulztWLuhkzK3XTlLNwqvh/WocyQKSJwU89Wb
	iti2H3jcRqFJXW72pPQY++cQjqPkjznU=
X-Received: by 2002:a05:6214:5993:b0:89c:4cac:74c5 with SMTP id
 6a1803df08f44-8b3fe7bc8f2mr114638996d6.25.1777631772343; Fri, 01 May 2026
 03:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777575752.git.jpoimboe@kernel.org> <07de8098fd8981321baab0ff552f65aa2cfc31ec.1777575752.git.jpoimboe@kernel.org>
In-Reply-To: <07de8098fd8981321baab0ff552f65aa2cfc31ec.1777575752.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 1 May 2026 11:35:59 +0100
X-Gmail-Original-Message-ID: <CAPhsuW4p3L2qchJQaU94f1f3qK3gq_LRx2n_rmbZ7ALO0FFHSQ@mail.gmail.com>
X-Gm-Features: AVHnY4JQ_0IGDxquKjlxEhjH9qGmDaHVQvjP2pj1OXbt9J-S3O7X_mBKlUfBE2U
Message-ID: <CAPhsuW4p3L2qchJQaU94f1f3qK3gq_LRx2n_rmbZ7ALO0FFHSQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/53] objtool/klp: Fix pointer comparisons for rodata objects
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 5:08=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> klp-diff treats all rodata as uncorrelated, so any reference to it uses
> a duplicated copy rather than using a KLP reloc.
>
> For the contents of the data itself, a duplicated copy is fine.
> However, pointer comparisons (e.g., f->f_op =3D=3D &foo_ops) are broken.
>
> Fix it by correlating non-anonymous rodata objects.
>
> Also, use a new find_symbol_containing_inclusive() helper for matching
> the end of a symbol so bounds calculations don't get broken, for the
> case where an array or other symbol's ending address is used as part of
> a bounds calculation.
>
> While these are really two distinct changes, they need to be done in the
> same patch so as to avoid introducing bisection regressions.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
