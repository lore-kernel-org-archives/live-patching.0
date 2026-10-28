Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226051;
	b=5MbjtdB1POIbMQRF1hMF5LuO78ndOwriVbEmuqdFjIzGAZ8TMNRA+HDOwmbcxbPl2sfe
	 Fv2i6EX510If35oFdUlk4ioKOLmBAtJ8cE/Ati54GzMTkllYSIsrmdwtsMMwkD6uAyjoW
	 3sxi4m53yPh585xdU55Tm3yVZydjfZxZc4QI/ERzitaJNWGZ4h3gnjZiEatdwjFv30T4i
	 hSaSgUPTnHG35RjAcozfYG2FjwtsjzTaDdj9QJLkcAW4xUUQvrzgkce92LECS2KN0ZCTL
	 NCE8vThafTns35hB+5maKcUnnTw3BJ0xDoCM+ZRELz2nPOUy90GwQH/ECba+516PDbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226051;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6k3mwGo0Ko38RJGbMaFKnc5cA44pMnEE+a+lrwIaTnI=;
	b=H+68YxTDeMCDm8K2Bdn3JBbpN6aLtuzI/oALLRxltJVYQcipTi97+X6UPrYB9B1JsmuN
	 r8+Z3LrKLQWAE74xQHe4UPsjQNqZcZNLQVagMqREjyeCvH86vvdwP7cqyrOE1xvRVEf0n
	 zLP6vtsue1dGH/0+WOAbkupCLS6eL7K44f9es3iVA3nHlsA9AQ+QVDRNNQXnEU9frTBGV
	 oareSqt7Y6bT1JBY0q4kClbPMc/8ZLA8g8VsnaFncXvDmGmZS2SSo0tJMTI46Knd+lxN+
	 5fJ1UUveWzBGrb+8rZvGak61k3zBLstVbMvf5xlLocZgpV0dhrWMLWHiX1gLYvJscQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfNOl7LW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081A606A31F
	for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfNOl7LW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9715C1F031E3
	for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226050;
	bh=6k3mwGo0Ko38RJGbMaFKnc5cA44pMnEE+a+lrwIaTnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DfNOl7LW3mlO1WeVo+osAJO3xRBGgRYFDMESofUDg/nh+OSVwMsJgqiouTyQh88aH
	 mfoO9cLgEeSp22LU2BmcfDzqmhaP586pfJHyCF5Ovq4Jl1DIregbBOS2ltflaVnzKM
	 Zo6/YrcnijC9PGL5xoWAgPHidpUpyzHS436a4Hlj/JXYCnKPqjsi4w0hqYMraxIABu
	 T7tqqnIYhNAsPvdWrbpgAiIt1n3MgMwaahTuaVc3tI+Hz4n2pjmLObCTj1l5ibZYzY
	 1LvI+GQpJmVscNx6rEl2aCH4v6fvfP99SQ8jHLSGpu+W5+T3qVy1W2j2QvxeHCFJJP
	 ppnoAUsgeDyRQ==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f20b304c0so122493085a.3
        for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 15:20:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzN1AEHL6HPXVseD/X9BrQdk4xojCGUjcGQIsoTIDwGygb6mZ3Ool+Z/kLY2oKjXv/Y9IVlkMi50t120dEB@vger.kernel.org
X-Gm-Message-State: AFq9FYKTiWolP88wzneUJYuUJ9eklBMPHS8R+Fg4LtdqRi6781mi28qG
	CHAH69wrWUioPeMephrTmdMsHUZTdcGXxTvTWHGGGvg11XhQQv30JnUahkRMYuztGg8pbYh3G5l
	OJ9+egqdnOjvJPoSyvpgs0UCN+Yi9R9E=
X-Received: by 2002:a05:620a:29cb:b0:93f:3cb0:464b with SMTP id
 af79cd13be357-94408a92d54mr568990785a.49.1793226049819; Wed, 28 Oct 2026
 15:20:49 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023011049.1164625-1-song@kernel.org> <20261023011049.1164625-8-song@kernel.org>
 <20261023093256.20d3e300@gandalf.local.home>
In-Reply-To: <20261023093256.20d3e300@gandalf.local.home>
From: Song Liu <song@kernel.org>
Date: Wed, 28 Oct 2026 15:20:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
X-Gm-Features: AclHuK-FDTrAy-23MCIT0G9xMBF8_Y6vMb52wr6WlZqzmScWbO6PAc8beSFR7FE
Message-ID: <CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Do you plan to apply this set to the trace tree (after the merge window,
I guess)? If not, how should we proceed?

Thanks,
Song

On Fri, Oct 23, 2026 at 6:33=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 22 Oct 2026 18:10:40 -0700
> Song Liu <song@kernel.org> wrote:
>
> > __do_trace_##name() takes the tracepoint SRCU read lock and calls the
> > probes. It is called from trace_##name(), trace_call__##name(), and the
> > notrace rust_do_trace_##name(). It is a plain inline function, so if
> > the compiler emits it out of line, that copy is untraced only because
> > inline implies notrace.
> >
> > Mark it notrace explicitly. No functional change.
> >
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
