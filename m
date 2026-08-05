Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EC47D932
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963605; cv=none; b=HBVJx28TH33QPt4EpqLwZWHHFR96Y10bRrfl6F9HhRSC8Dt8C6HDoQNoqMZ5flf+iCLHlTxKo9AEfriE45NgCgFfVeYSMYm8B8dx62Acl/K053IF9mj9DafzDbIAif6ZaPUJL78Z6QOAaFZJob5KrfZU7JxewXPgj+3D7hgur9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963605; c=relaxed/simple;
	bh=+rVpyPq0/1KIhurHDSz95MmXk1suKD1Ajn+WYGt12y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRbmd6pJg3/9j2kMcwyapz3qRPcGocK57HhwKBX94mOjJDPgKwBsujZjyyM5NcnxhVO+OPZkeYjD5UZXYOUejROgT6SF3UzB2m02OsZK6gvETxvaKK6Ou7vzp1C2aZb4j6KgHve0YkQ+h3CzYZoA5/3nWVWjS8FFjhfPCKyrXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgiXZ+fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgiXZ+fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43411F000E9
	for <live-patching@vger.kernel.org>; Wed,  5 Aug 2026 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963603;
	bh=+rVpyPq0/1KIhurHDSz95MmXk1suKD1Ajn+WYGt12y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TgiXZ+fi/5vr9RIFmSswCTlPkTiyyBCdyz1B6Sv4OqkpPK7E6Jlkl+uPvT6jFI3WV
	 xNMLVQ2LGzqS2jPneGLPxukTwde6MsgZmxDpXrXYazbzRST6cLAGVnbGsUGduMwCaD
	 IChx8Z6s2ADV/8larCTRYVi6KLH4Lu6VlhzMZWtvJTG2/usAx4ZWoMifiexCt1EqXX
	 GlXMhpSrLrP9iFrYTqvJwLBrswwQjClhhp3kgaVRuVyUiQdXf3/BB7bWdgXCbx7SOI
	 4pRBA5ciRoqVij3B8ErrW/4lDyLci7Ta5/O/RLg2EeJ7LMTVmjW9sgeXifZ3Z6XBm+
	 FOH8//wShorUw==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso96864085a.3
        for <live-patching@vger.kernel.org>; Wed, 05 Aug 2026 14:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqGXggJbGR2Q1A7N7W5pCzLGQCN5JIzpwjaENcNECzfxxADcxRuAJNRY/ic0R0FDP9JHJLnTCf6ESrAhqs+@vger.kernel.org
X-Gm-Message-State: AOJu0YxAETFEzNIB9hTpTKt+mLKoiSd5BcVVqldOQhXL6siZeEg/ryFe
	DMpgrQOV6VWogruzE9rXHHE/nwqEuLzpwUCzy2tgb5WdkaSYJ1uiJxQXBZurdtK8A9PXtukOk8I
	NlSLiOZAwnEzer5Dmg260lNkmdM0itko=
X-Received: by 2002:a05:620a:9cd:b0:92e:e632:1471 with SMTP id
 af79cd13be357-93649166f5fmr763141985a.44.1785963602591; Wed, 05 Aug 2026
 14:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <e36ef2370ad7ca6bf139b8791a1d2810f55785e6.1785939903.git.jpoimboe@kernel.org>
In-Reply-To: <e36ef2370ad7ca6bf139b8791a1d2810f55785e6.1785939903.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Aug 2026 13:59:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5auS=LV1+SW90Xi4b8JYix3dDrSYSVS5JorwpA_s9jtg@mail.gmail.com>
X-Gm-Features: AUfX_myCvJiJl46AjanIKOL4DpDlFnsGauTF9kKPyRZM38CkzdPCDV8AmpyDYRk
Message-ID: <CAPhsuW5auS=LV1+SW90Xi4b8JYix3dDrSYSVS5JorwpA_s9jtg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] objtool/klp: Don't match local symbols against exports
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
> Exports are always global, so ignore local symbols in find_export().
>
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diff=
ing object files")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
