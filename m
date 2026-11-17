Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882891;
	b=mDhaHYKLvI7H8ZEjJF2cj04OqtiojY/H+vCLckMCbt3HCKqJXpMfDoPgHs1Rj0liGIe7
	 MANcvlDVi/XcE9Rds0KWtV9STAUSCJuRd+IfyZnQ3WYlu5yXXpL0Ug5+tkiz1uD227tIq
	 fLQ2NlspbaPo7A234KikKvATzBKtd6YZcpiTuS8B/dNmWfIYlpiim4T6cwRkkFJjUHULs
	 8+4PLyzqFiTjNm9A7a3PSCX2Rxhs0A4dbMKrpxglBNJKBK1o3e3eolSCaK6xh6TNZpsGt
	 JDgHLwrOwl8UNEUpIf+NMBv4cxEwfihQt5x/evUwTBVfSBTwNG9nyYT6zx9vWHx8C6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ns9FXWIYn3lzPBQvYpDMWB0UfQ2O3no/d0h52QPqb+8=;
	b=WGy/dIgngSSZi3GXqBS978rE2t9aj1oGX7ZgluOzT9oARQBCHp8ECyLCJAsroZYkxJom
	 wsTe600No0el5HMKNDz5GYW+Y4TYAUEypCuM54h+OpCru7L7nYCH38fp5UwHpGre7CJdH
	 6GSpsvmYSJviiHAD3enMRoC5TPCtfHybYXktxSEpYfdrofxrbAQfAgabAZu7IRxFiZyom
	 zvaUUQ6iI5CPStrxeQq4Vjo+P/Mn1TTcE5Y76/efKQO5OF3cYsRH3cMAaayZa5/Qj1kg8
	 F17YLW5IhbtHgtfFESN9sqHRMpdtSRyyRoHylUZ12hYoO+Jad623L6F5+y5oibVow0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MY70KXaE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD7606A31C
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MY70KXaE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699F61F000C4;
	Tue, 17 Nov 2026 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794882891;
	bh=ns9FXWIYn3lzPBQvYpDMWB0UfQ2O3no/d0h52QPqb+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MY70KXaEY5DZmkkwNL/c7IwqGrvfz/mWR9Nr5i61g726mRZg+VHxa5Rfpva0Vc/sa
	 bM+EHCap14dsoBL1hbq45JzNYoUf/wr8SreKX0lbJUwC0kjuc81qiH8Tjl9j3fhZ7l
	 lFtR7sjoKhokSu857u58tpEN5xkVCmlVd13Oaws4PvVlVd9cKCNcyD5xrMKD5AcuGO
	 wJpuf3EJG6L0sdPEQfSDNtNr0P8LuVPy0lLUkum9BHog1BS5H5GbVzRP5FUb1U/el0
	 A8IblIwXIwoTPdIpRb74o7a04vprceZr6r9Krhuf1fC4wXmcFB6aHyn1+WyuKYnjlv
	 NdbgdliTgVTOw==
Message-ID: <sashiko-outbox-218091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/11] module, sframe: Add sframe support for modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dylan Hatch" <dylanbhatch@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Weinan
 Liu" <wnliu@google.com>, "Will Deacon" <will@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Indu
 Bhagat" <ibhagatgnu@gmail.com>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Jiri
 Kosina" <jikos@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Jens
 Remus" <jremus@linux.ibm.com>
Cc: "Prasanna Kumar T S M" <ptsm@linux.microsoft.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Song
 Liu" <song@kernel.org>, joe.lawrence@redhat.com, live-patching@vger.kernel.org, "Randy
 Dunlap" <rdunlap@infradead.org>, "Mostafa Saleh" <smostafa@google.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
In-Reply-To: <20261117020648.323464-6-dylanbhatch@google.com>
References: <20261117020648.323464-1-dylanbhatch@google.com>
 <20261117020648.323464-6-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:34:49 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] unwind/sframe: noinstr violation calling rcu_is_watching() in
  sframe_find()
--

commit 777f63a65edfda582b87b92a3b49553c49d8a38c
Author: Dylan Hatch <dylanbhatch@google.com>

module, sframe: Add sframe support for modules

This commit adds SFrame section tracking and FDE sorting to struct module
and extends sframe_find() to look up PCs in loaded modules.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 50afaed9a0c93..55b7838bdd485 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -411,12 +416,53 @@ static __always_inline int __sframe_find(struct sfr=
ame_section *sec,
>  	return __find_fre(sec, &fde, ip, frame);
>  }
> =20
> -notrace int sframe_find(unsigned long ip, struct unwind_frame *frame)
> +#ifdef CONFIG_MODULES
> +
> +static __always_inline int __sframe_find_module(unsigned long ip,
> +						struct unwind_frame *frame)
> +{
> +	struct module *mod;
> +	int ret;
> +
> +	if (!rcu_is_watching())
> +		return -EINVAL;
> +
> +	instrumentation_begin();
> +	scoped_guard(preempt_notrace) {
> +		mod =3D __module_text_address(ip);
> +		if (mod && smp_load_acquire(&mod->sframe_init))
> +			ret =3D __sframe_find(&mod->sframe_sec, ip, frame);
> +		else
> +			ret =3D -EINVAL;
> +	}
> +	instrumentation_end();
> +
> +	return ret;
> +}
> +
> +#else
> +
> +static __always_inline int __sframe_find_module(unsigned long ip,
> +						struct unwind_frame *frame)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif
> +
> +noinstr int sframe_find(unsigned long ip, struct unwind_frame *frame)

[Severity: Medium]
Does calling rcu_is_watching() before instrumentation_begin() in
__sframe_find_module() violate noinstr rules for sframe_find()?

In kernel/rcu/tree.c, rcu_is_watching() is marked notrace rather than
noinstr, so it lives in .text and can be instrumented by sanitizers such as
KASAN or KCSAN.  Calling it from noinstr sframe_find() before
instrumentation_begin() triggers an objtool noinstr validation warning when
CONFIG_NOINSTR_VALIDATION is enabled and can run instrumented code while
unwinding from a context where RCU is not watching.

Using the __always_inline rcu_is_watching_curr_cpu() helper inside the
preempt_notrace guard before instrumentation_begin() would keep the check
in noinstr context and avoid toggling preemption twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117020648.3234=
64-1-dylanbhatch@google.com?part=3D5
