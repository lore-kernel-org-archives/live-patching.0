Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E536196B
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490858; cv=none; b=ln4bt3visMpsPxvgjmzXKpc4dnmPw40PG5gGZY/EhDsiBp/l6K9onyKPzXeSAbKq3ZrxuXz5oxSZpdFxhhXRtFylPto8S0+yynhaeuo+7ti8VdecXEKumXccjlqQosv6XhvI8Ha3W5jR/MFbLLoZsv6cAItMhAVkyuiD+zMqpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490858; c=relaxed/simple;
	bh=em5HKmKuZZm7/fZuwJELDmQj/7DQgeSKE4517old0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THSaVwBOx1JCoSKoscSXdoWjr1PTIdHbzeWzBRwmaYVQNRnT94Lv/mTZZ/eIVjVkdMBtAGHTCZq2MfOzAvXAoBQ6RrAKfCEr1r0ziHLyVC58sa1APs3E/KgGZDBIejHJuWywYkX70rWP4EFHNzaSekGdkuCN9g364m9Yof3quQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/hkjEgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/hkjEgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290FA1F00ADB
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786490857;
	bh=8zh8FdoLPVYOFi3kDPtIftnZ0sQPUwKSPCzdZ4sWpZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O/hkjEgwHZmqcJgzgQhL8puh4FXSELEoQIZ+Vsz1CiMhEeVx1qWnWYNhxOvms+Yco
	 8tMtLBgZUdJWGtTyWyucBVB8RUQSqJoSOLGbsWglbXKgsN0YoqTDEZZPKOXZ3VJpdp
	 8yJdJ5nwH93Dc4l+sg+GPZDL9q05JiNPdqbPaxHYr6ziT/ZGh0ZCvs+gA6wvEZKNjs
	 aG8UI1NZMPe/LRCX+qAfURlWYe56aaSccsii5RzaHL11yyKdjYwGDnhnzMiMeW0eI4
	 5mbNgqVEnj2P7rT768z/CDe8p//GJFElcY4c/D5wbZa/G2SFO4RLoVUC3WtezyWt2R
	 3YmxAxgRHBeMg==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9034b6b7674so2954276d6.0
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:27:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoKzqPhSja7JCrENXEmmA2fiUK3orV+pJRA4vUiTTusFlLXapUFzN8Q7EwlGEmu2pPASWVUrP/tSmjTXNoi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy900wEGEVWThntRyl6zGJYNJREjmBYo+m+4QFz790PAAxZkOWd
	kQ9W8243jOrws9mlGoMptir10djs29OG1U4KFG8LjsBJY6Tlj10jjxMQegiss6Hg6TrAA1WU0Wz
	sK/FZ15bLL2/Xw6VjQUa7cC8C9lb4wUM=
X-Received: by 2002:a05:6214:4a07:b0:90a:3b62:805d with SMTP id
 6a1803df08f44-90a6ff13336mr8751586d6.4.1786490856251; Tue, 11 Aug 2026
 16:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <8faaead205b219607b6fc2359ae743be824056eb.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <8faaead205b219607b6fc2359ae743be824056eb.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:27:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6npZ+AP7wmw2j9JnfBkOSzM7pGUEs53fdTpmKOY8AuMA@mail.gmail.com>
X-Gm-Features: AUfX_mwMFKcqpM918zS1IsQwoCA_15C58RBfTvEXqZhQOjWORDLmFE6stS8l6Sc
Message-ID: <CAPhsuW6npZ+AP7wmw2j9JnfBkOSzM7pGUEs53fdTpmKOY8AuMA@mail.gmail.com>
Subject: Re: [PATCH v4 01/22] objtool/klp: Fix .kcfi_traps special section extraction
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
> create_fake_symbols() creates a symbol per entry for special sections.
> It does so in two steps: first for the sections which have
> ANNOTATE_DATA_SPECIAL annotations, then for the rest, using entsize or
> the reloc count to infer the entry size.  The second step skips the
> sections already handled by the first one by looking for a symbol at
> offset 0.
>
> That heuristic is too fuzzy: with Clang and CONFIG_CFI, it misfires on
> .kcfi_traps because Clang emits a .Ltmp* assembler-local label at the
> start of the section, so no symbols are created and
> clone_special_sections() extracts nothing.  klp-build still reports
> SUCCESS, but the livepatch module has no __kcfi_traps section and the
> traps for the patched functions are lost.
>
> Look for the actual fake symbols created by the first step instead.
>
> Fixes: da4326573ae8d ("objtool/klp: Fix kCFI trap handling")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Closes: https://lore.kernel.org/r/akQNqlfFC0T5pcMa@redhat.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
