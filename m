Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275568;
	b=WZiAtFOEirISgMpKwh/SvxsAgfZAgIPUCL7wE1gJNBHFN6hWN/H7X5nYP5XBQUAePIDb
	 aYP7VSHXIbXMVU5FL8RiB0hG2gimf5uykUb4CNTxY7n8/WOTZqgrWP8d17r16fuvEU0lZ
	 tUaOu1aDf7NdlBW1yLnghr680jY1Wg9PChiUHdVZIBlp4jFjUix/VtXTreRiLl2BUZEDm
	 XeuYE7RqSBUkbfDHeyrtODDBiUShIzYa0VWLalQDRziX46H19yNviDgJd5vFU7DYf6iMk
	 v9dlOyerNDyoYTdIKjdV2lnVWyz9Y6DNUpouKmuuK0NpqpkUURGsslxGL50SPg5tXuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Bbfxd4vb8prRdyU++9XKf80jbDkyzPxCXr/tfFV8Tg=;
	b=QSAzWnJ+3TvLFsws8Q5zsu0eOcGzs0xHNd0g1U5NfZJLOd6N7YyWYGIa2sAa3Z5lILpy
	 yPQoaZr8F98ctceJ1ZqET+Ollbf1nFVWa3hO88F4F5yslD812NAW27onY3uwpiEgUbudA
	 zRuuKGjD0QU9ZkY8NJsFwyf0/9Ql8DWKnWBXxq80In8mch3yE3WqyITVI2m0IMMYF+1zR
	 p6w1wdpN1WuZoGPbe10nTjSz+lI1GyEc9vigYehEXtmZQxeFPGOnPSdut2UfN/ganMggL
	 WYz7RNwo0xZSg5RjpByoL6gRiwEOcInJvNLvCAwcLEdD16+Nes5biRklIFYndu19Q6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWY709cN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE31606A31C;
	Tue, 10 Nov 2026 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWY709cN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E6A1F0089F;
	Tue, 10 Nov 2026 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275567;
	bh=8Bbfxd4vb8prRdyU++9XKf80jbDkyzPxCXr/tfFV8Tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWY709cNGIGP4ipIxMOn4gXvXiFGnPaXE/Tts4Pz/FuFWcmPTzhTd7tGEXyY417cD
	 R2CjnVsgSZySYhQjpka8N+SpF5aTyT0QzgvaM1tPKm5qipdvUOl0+xn3LMxgnQZy3e
	 yG/8qjTFYMjmo+FsYdAtBhBaQgsK2yVpSBE5mvmGC1TSifazuq6j6ykyeM9dUJTMY3
	 JIj6fcpu3YZ7iwehDVzYTU42HsKhC3Qks5zbJBvjt2YMBVQ3K4EAZ2S7CZAHcZoFp7
	 viEvuvUfL8+ovEwP5ONlovar9Gr4Tq1AjLWBAiBYaWgdLeYVjbJM6/zoT/UgW1oJaG
	 mzMS41ZEZoMDQ==
Message-ID: <sashiko-outbox-206002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] riscv: stacktrace: do not report the walker's
 own frame from arch_stack_walk()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu
Cc: alex@ghiti.fr, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, martin@kaiser.cx, kmehltretter@gmail.com, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20261110013750.36800-2-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:52:46 +0000
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
- [Medium] riscv: stacktrace: off-by-one frame unwind in
  __walk_stackframe() for !FRAME_POINTER
--

commit 0ad8b77869cf04ae7e9c217cd0f43219461f68f7
Author: Karl Mehltretter <kmehltretter@gmail.com>

riscv: stacktrace: do not report the walker's own frame from arch_stack_wal=
k()

This commit moves the stack walker into an always-inlined __walk_stackframe=
()
helper called directly from arch_stack_walk() and reduces the skip count in
return_address() from level + 3 to level + 2.

Link: https://lore.kernel.org/r/20261010132712.46931-1-kmehltretter@gmail.c=
om

> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/retur=
n_address.c
> index c8115ec8fb304..4da1cfd249d3d 100644
> --- a/arch/riscv/kernel/return_address.c
> +++ b/arch/riscv/kernel/return_address.c
> @@ -33,7 +33,7 @@ noinline void *return_address(unsigned int level)
>  {
>  	struct return_address_data data;
> =20
> -	data.level =3D level + 3;
> +	data.level =3D level + 2;
>  	data.addr =3D NULL;
> =20
>  	arch_stack_walk(save_return_addr, &data, current, NULL);
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index c7555447149bf..28c5744889bac 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c

[ ... ]

> @@ -102,10 +111,18 @@ void notrace walk_stackframe(struct task_struct *ta=
sk, struct pt_regs *regs,
>  	}
>  }
> =20
> +void notrace walk_stackframe(struct task_struct *task, struct pt_regs *r=
egs,
> +			     bool (*fn)(void *, unsigned long), void *arg)
> +{
> +	__walk_stackframe(task, regs, fn, arg);
> +}
> +
>  #else /* !CONFIG_FRAME_POINTER */
> =20
> -void notrace walk_stackframe(struct task_struct *task,
> -	struct pt_regs *regs, bool (*fn)(void *, unsigned long), void *arg)
> +static __always_inline void __walk_stackframe(struct task_struct *task,
> +					      struct pt_regs *regs,
> +					      bool (*fn)(void *, unsigned long),
> +					      void *arg)
>  {
>  	unsigned long sp, pc;
>  	unsigned long *ksp;

[Severity: Medium]
Does the !CONFIG_FRAME_POINTER version of __walk_stackframe() still report
walk_stackframe as its first entry before scanning the stack?

arch/riscv/kernel/stacktrace.c:__walk_stackframe() {
    ...
	} else if (task =3D=3D NULL || task =3D=3D current) {
		sp =3D current_stack_pointer;
		pc =3D (unsigned long)walk_stackframe;
	} else {
    ...
	while (!kstack_end(ksp)) {
		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
			break;
		pc =3D READ_ONCE_NOCHECK(*ksp++);
	}
}

Unlike the CONFIG_FRAME_POINTER version, which initializes level =3D -1 so =
the
initial walk_stackframe placeholder is skipped, the !CONFIG_FRAME_POINTER
loop passes pc =3D (unsigned long)walk_stackframe directly to fn() on the f=
irst
iteration before reading arch_stack_walk()'s saved return address from *ksp=
++.
As a result, when CONFIG_FRAME_POINTER is disabled, stack_trace_save() still
starts one frame too early, and reducing data.level from level + 3 to
level + 2 in return_address() causes return_address(),
ftrace_return_address(), and CALLER_ADDRx to stop one caller too early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D1
