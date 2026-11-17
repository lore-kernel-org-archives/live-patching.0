Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885563;
	b=avHmof852thNsyQSYbuk1GAK7T6yVWBTXLN3AcNMxZRN4CZQ76vqzXauoogffH8by9bX
	 dlU3/8wTGqrc3BJvlXGiFfCDDPY8/qP+RJdf9NUZv8t53V8Vt+HnuJvMs9rws+kn/Kzfr
	 MB6Y/a+w5T3bq0zg+fT396AbNy/gO/8t2uhCgNUlCVPVPICafhEs5Gh08tIHBrIwliIub
	 oPG3ZKLoNDfcZdRpsVXUeaD+HmJHCgWAopdwZnGgd1ioMdiu7ra+jDJsw0j7uTSyqAjy2
	 3qcN0B2swY/pf3RFHsDevBsU+W9SgG07xNh3PWhr6zPqHATaW4X3RPhyZt9SwmSVN3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hcbl5lJw3UJZZMZq8VIGWE2SLMqgjEn3qGS0UJAeEqc=;
	b=z/+s3pmMK9mD/ZGivSyeX4jMVHm6QjH3cVtlfxGyJop4EaZQ+XaPy83QjuA7CasoPsBb
	 eMdwpG+uStGdxxv5JB7RMyu5xSAwcfq6OyNGUtG3jER+Jxg7Fk4LgWy44b8ToFwSOGLrG
	 vs12QhPDDdavTx9YAB5Ar9Nn/wNYKtgCtii+2zJcNJjjpi+BIpj9CK/vejF57ebwdcjZV
	 Ow0CRtgHJ+I/S3rEKMAs0EVVrIp/fFkWfcOUJIDbl9b/O0XNQ7/V6AZlWXuDo0ELjf/xt
	 RClaIg+dH3eOOl6pWz9ZePf/lk9Z/Zw12NZp/+f8gW2FvJtOXRlD+P6px12LsAFI86Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh4ML6Wn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616E606A334
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh4ML6Wn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0291F000C4;
	Tue, 17 Nov 2026 03:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885563;
	bh=hcbl5lJw3UJZZMZq8VIGWE2SLMqgjEn3qGS0UJAeEqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gh4ML6WnJbGkYaSt7AMxcWfXC4LqXsPZfjr74gsohfVBhyzDzyUQgJOq0twGgdbOx
	 nA5Dqa8PcdgXemcymAeUqxQ+6sTQU7Vfi79jmRUatUpo/mpxyMRby7ypJ9rluLtMNA
	 P8x/bAOepHsRPRTVvBnVxKfeguZDO0WsY25JLuESpv/YCyDJC9YVFEiMhK9jf0jj31
	 /HCpmFoJthFKU0iNf4xvsCb+zFF6hTEtb8Xld2vtVaPwtWo59v2Oj4NwjWyk0mVGIQ
	 +Ggvg8+Y2cJ/cI/h7eLphVcIuTfQ1t9NTR22ST2MbkVnlwLgQIy0shMKqsQVvu4Uda
	 kdZhMGB+6y7xw==
Message-ID: <sashiko-outbox-218134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/11] unwind: arm64: Use sframe to unwind interrupt
 frames
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
In-Reply-To: <20261117020648.323464-12-dylanbhatch@google.com>
References: <20261117020648.323464-1-dylanbhatch@google.com>
 <20261117020648.323464-12-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:19:21 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] arm64: stacktrace: kunwind_next() clears state->regs after
  fallback
- [Low] unwind: arm64: consume FP stack slot in
  kunwind_next_regs_sframe()
--

commit e44539400678f653df77eaa983169650892957a4
Author: Dylan Hatch <dylanbhatch@google.com>

unwind: arm64: Use sframe to unwind interrupt frames

This commit adds kunwind_next_regs_sframe() to unwind across exception
boundaries using SFrame information, falling back to frame-pointer
unwinding and marking the stacktrace unreliable on failure.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c53fb04..e876af54a4055 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c

[ ... ]

> @@ -244,6 +266,163 @@ kunwind_next_frame_record(struct kunwind_state *sta=
te)

[ ... ]

> +	/*
> +	 * Consume RA and FP from the stack. The frame record puts FP at a lower
> +	 * address than RA, so we read FP first.
> +	 */
> +	switch (frame.fp.rule) {
> +	case UNWIND_RULE_RETAIN:
> +		fp =3D state->common.fp;
> +		break;
> +	/*
> +	 * UNWIND_RULE_CFA_OFFSET is currently not used for FP
> +	 * (e.g. SFrame cannot represent this rule).
> +	 */
> +	case UNWIND_RULE_CFA_OFFSET_DEREF:
> +		fp =3D cfa + frame.fp.offset;
> +		if (!get_word(&state->common, &fp))
> +			return -EINVAL;
> +		break;
> +	/*
> +	 * UNWIND_RULE_REG_OFFSET and UNWIND_RULE_REG_OFFSET_DEREF not
> +	 * implemented -- flexible FDEs are not currently generated by assembler
> +	 * for arm64.
> +	 */
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +
> +	switch (frame.ra.rule) {
> +	case UNWIND_RULE_RETAIN:
> +		ra =3D regs->regs[30];
> +		source =3D KUNWIND_SOURCE_REGS_LR;
> +		break;
> +
> +	/*
> +	 * UNWIND_RULE_CFA_OFFSET doesn't make sense for RA.
> +	 * The return address cannot legitimately be a stack address.
> +	 */
> +	case UNWIND_RULE_CFA_OFFSET_DEREF:
> +		ra =3D cfa + frame.ra.offset;
> +		if (get_consume_word(&state->common, &ra))
> +			return -EINVAL;
> +		break;

[Severity: Low]
Does UNWIND_RULE_CFA_OFFSET_DEREF for frame.fp.rule miss calling
unwind_consume_stack() when frame.ra.rule is UNWIND_RULE_RETAIN (or
frame.fp.offset >=3D frame.ra.offset)?

get_word() reads the saved FP from the stack without consuming it, relying =
on
get_consume_word() for frame.ra to advance state->common.stack.low.  If RA =
is
retained in LR, the FP slot is never consumed, leaving state->common.stack
unadvanced (or failing to transition stacks if CFA + frame.fp.offset lies on
the previous stack) while state->unreliable stays false.  Note that the sta=
ck
should only be consumed after both frame.fp and frame.ra checks succeed so
state->common.stack remains intact if kunwind_next_regs_sframe() fails and
falls back to kunwind_next_frame_record().

[ ... ]

> @@ -259,10 +438,23 @@ kunwind_next(struct kunwind_state *state)
>  	state->flags.all =3D 0;
> =20
>  	switch (state->source) {
> +	case KUNWIND_SOURCE_REGS_PC:
> +		if (state->regs)
> +			err =3D kunwind_next_regs_sframe(state);
> +		else
> +			err =3D -EINVAL;
> +
> +		if (err) {
> +			/* Fallback to FP based unwinder */
> +			err =3D kunwind_next_frame_record(state);
> +			state->unreliable =3D true;
> +		}
> +		state->regs =3D NULL;
> +		break;

[Severity: Medium]
Should state->regs be cleared before calling the fallback
kunwind_next_frame_record(state)?

When kunwind_next() falls back to kunwind_next_frame_record() (for example =
on
a synthetic pt_regs or an exception in entry.S without SFrame data) and
state->common.fp points directly to an on-stack FRAME_META_TYPE_PT_REGS
record, kunwind_next_frame_record() calls kunwind_next_regs_pc(), which sets
state->regs =3D regs and state->source =3D KUNWIND_SOURCE_REGS_PC for that =
next
exception frame.  Executing state->regs =3D NULL afterwards overwrites that=
 new
pointer, preventing SFrame unwinding on the next exception boundary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117020648.3234=
64-1-dylanbhatch@google.com?part=3D11
