Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30E3939C2;
	Fri, 18 Sep 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772447; cv=none; b=Oytq2V7fIWXBca7TEnNMuTUWn4IbptIFo/h5JTSUmbgIpMKZz28100SYo7WMJWttOOcUSxx03OtS83eds8y+gVSPrQZXgPmkpEMDuRYOqs7/kJ7bSD1IaC92+40GOU1c2KytVY2WPVMvXk7pqlJSc5zJIWBqnBig6JQkdAziqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772447; c=relaxed/simple;
	bh=07MFiAPJVkjq93YNX01Bwfkmf2FkFStlOJpLA7yYX8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l7zZJR+xeySFn1RedJKgkiEZUAZLjnMslc/si8u5rfFeR2xRmEssHZuleMSWjZdXpGpeQxhLRAhJ77KEbqN0gSfV7nx6D/vET1fyRr94xf/tikp8cMNQqsQjxF/pSjf8UnuWJmh+I/tqEwOGedMkRrphDiArpCS4pbuHtJmCStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/FGilup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/FGilup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414BC1F000FF;
	Fri, 18 Sep 2026 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789772446;
	bh=DmLZ94AHYP63wdAVIRZYQYO4b0tflVV2n0V+mhCuajs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/FGilupSkbIY0CbH7lTao6/7xUMgAR7Ql0qN2rDu3+stEAJ66vVVgeFTge2+8F/A
	 zLrfunsKdJKiq1q7k+b+vmEObHnkvqXEdgNanEUIku0QLxtceoEc/Sof1sgIojlduh
	 88MIeYtz/qa/c8a2TgbgB+POBnLkmjwtLP3JOrwmEit33c6K0No8VYm8d1a8CYT+2/
	 bKHZj57i40fguNnd33sMRn4URcW+BKqA6IvdE8DtrblriABP9YKJ9704ufX2yL36/3
	 eeWqDWm876tqUr/Wm5O0ZsHZtf3qiarnkWLczessiYlHmeoztgZ9iFrCyRYCszYMt8
	 ijJuStzO121yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/11] unwind: arm64: Use sframe to unwind interrupt
 frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Rutland" <mark.rutland@arm.com>, "Jens Remus" <jremus@linux.ibm.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Catalin Marinas" <catalin.marinas@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Weinan Liu" <wnliu@google.com>, "Indu Bhagat" <ibhagatgnu@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jiri Kosina" <jikos@kernel.org>, "Dylan
 Hatch" <dylanbhatch@google.com>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, "Mostafa
 Saleh" <smostafa@google.com>, "Prasanna Kumar T S M" <ptsm@linux.microsoft.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, linux-toolchains@vger.kernel.org, joe.lawrence@redhat.com, "David
 S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, "Song
 Liu" <song@kernel.org>
In-Reply-To: <20260918224157.1471085-12-dylanbhatch@google.com>
References: <20260918224157.1471085-1-dylanbhatch@google.com>
 <20260918224157.1471085-12-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 23:00:44 +0000
Message-Id: <20260918230045.414BC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: noinstr violation by calling sframe_find() in stack unwinder
--

commit 13ca4d55a43f451bf08442b7e6af494a6c23a78e
Author: Dylan Hatch <dylanbhatch@google.com>

unwind: arm64: Use sframe to unwind interrupt frames

This patch adds kunwind_next_regs_sframe() to unwind interrupt frames using
sframe info, falling back to frame-pointer unwinding on failure. It updates
the exception boundary unwinding logic to recover the return address more
reliably when sframe data is present.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c53fb04..5aaeac9611015 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
[ ... ]
> @@ -244,6 +247,162 @@ kunwind_next_frame_record(struct kunwind_state *sta=
te)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
[ ... ]
> +/*
> + * Unwind from a pt_regs according to sframe.
> + */
> +static __always_inline int
> +kunwind_next_regs_sframe(struct kunwind_state *state)
> +{
> +	struct unwind_frame frame;
> +	unsigned long cfa, fp, ra;
> +	enum kunwind_source source =3D KUNWIND_SOURCE_FRAME;
> +	struct pt_regs *regs =3D state->regs;
> +
> +	int err;
> +
> +	if (WARN_ON_ONCE(state->source !=3D KUNWIND_SOURCE_REGS_PC))
> +		return -EINVAL;
> +	if (WARN_ON_ONCE(!state->regs))
> +		return -EINVAL;
> +
> +	/* FP/SP alignment 8 bytes */
> +	if (state->common.fp & 0x7)
> +		return -EINVAL;
> +
> +	err =3D sframe_find(state->common.pc, &frame);

[Severity: High]
Does calling sframe_find() here violate the noinstr guarantee of the stack
unwinding path?

The unwind path is called via arch_stack_walk() -> kunwind_stack_walk() ->
kunwind_next() -> kunwind_next_regs_sframe().

Since arch_stack_walk() is explicitly marked noinstr to guarantee safe
execution in uninstrumentable contexts (like nmi), calling instrumentable
or rcu-protected functions like sframe_find() and __module_text_address()
could cause a recursive fault or kernel panic if tracing or kasan is active.

Additionally, could accessing rcu-protected module structures without rcu
watching lead to use-after-free bugs when stack unwinding is routinely
triggered by tools like perf or bpf tracing?

> +	if (err)
> +		return -EINVAL;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918224157.1471=
085-1-dylanbhatch@google.com?part=3D11
