Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2719475
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492917; cv=none; b=awoXggDhCPkEOzcRg2DcmjzkhnS1zxS17XMxPIMlsCNQVt8EP2uLqv3sp+yNx+2GFhG5ezlAuKgtU7gTc/AgeXPyk4CK0ESn4WrtiUnMRzAo5VtO97/JsQBU3iG5d6s6dYDWeNv/rZxrxrMaoMleFBHdMldz8beFqAgCNBoDNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492917; c=relaxed/simple;
	bh=13aQ7q7fF7O8K4K6Io8XaHdGoH3ITQi67wups0eO6iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evYV9Uumb0Sz5DtgOQcgVd6z/3nQY//Sqmg+FUb+APjQd8HCvVItjbNjGgNnUdJcuelTAm1xIqgEUZ8Go0w6OV7A4xPB3f04E33QxNPVCdUD8oycNHYPn2cBg6jT6IXl5rBciCM3kED3NVy8vIbkdZWvuylmriE1J2T25+Si+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g71xhYkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g71xhYkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B211F00A3D
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492915;
	bh=tlNE8647W1oXM8pmslkXYsAQTxFMdYzSDM4CLpScHtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g71xhYkcBqiEAXjI0pUJc5IKys9x2zUQWNtogGpjpTV7PVgRSBu3VYrB52FeySmvL
	 lIXFmtXKxxFQ6tP4vS5LipnfZKLspRk7NWzzw0tipOIH3f3T/EH+WzFTjAmpVQ7WXx
	 aOFjDE+nKLZAHRRQXi088OCE8j2NRYb+wfTIx5gYMu5VbI6XDKkzW9ALQiG3pDMN7Q
	 m7cE/ITNxNRv4wNrm0GT3jIZNPI+NsZiD7fcfJs8BBk12zlzL77wYDfwJfLGdmghpi
	 ysLIvFP6sTJGgqPFUoV0UZ7bS8D7mKNfjlIDgXQQNhEOwoFZnvCv7POBdbtzenNn/L
	 YhEx6NH+5RDlQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-934974844ffso35052885a.0
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 17:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rofcrh+iThhJorypAR2EXnRz3Rk8Ibvt946E4xUtYkI8EsGbg1lPuyWZbviaP7tJl1XCy+5yrHJ6PWZfktU@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOEuTPWdzJ5ScwDFEhG5tWjgQ5UVJafdKrl9fpD9ASMfwdQMR
	cgy5TM6pvaB80u2vc7yabsCHdbjknVRBFOjowjcH2Bb5AwNmRIDioYdeUV6IDWR2krBAzsNDF7w
	ij8/djzwhGgFc8tnNIj7o/DIKes6yDO0=
X-Received: by 2002:a05:620a:608d:b0:92e:603f:1f20 with SMTP id
 af79cd13be357-936b39e0d3dmr131620585a.2.1786492915065; Tue, 11 Aug 2026
 17:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <73024f3fce343bd6fba3d08fa366a61b4e2c0fa1.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <73024f3fce343bd6fba3d08fa366a61b4e2c0fa1.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 17:01:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Coa50sXixg5dsbEf9QLTqM6F80wB2x_jE4KWsYsH-_g@mail.gmail.com>
X-Gm-Features: AUfX_mw7frV7K8Eb4zKvm7fI_9V3cTVMMpTJJxIT8TK0kJzqq-L4YeXq89sPw64
Message-ID: <CAPhsuW6Coa50sXixg5dsbEf9QLTqM6F80wB2x_jE4KWsYsH-_g@mail.gmail.com>
Subject: Re: [PATCH v4 20/22] objtool/klp: Introduce objtool for arm64
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Add basic support for arm64 on objtool.  Only "objtool klp" subcommands
> are currently supported.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
