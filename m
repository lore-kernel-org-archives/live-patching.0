Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275675;
	b=27ejqcf83/qHyG53D7MslZhXxgKnc5aeGxUiKOw9bG4C3dLmlroDvNehAJQFpK6mK0+i
	 mUQlverlHwDHMe1UUZsxMIvijw0xz3xE/AFSj20UaIQuTixkyFOtS6N/z0H5T8QSct6nx
	 +t0BaUiODuCWqwuti3HpcbCgUGMRZBiPyZGdwjWLVf1WMV4pRarili82nMVJOS1BB6hPH
	 Mp9IDTRdScs6ne9XOiKmJGGVgWfM0DZ5tyRU4y0ieGp2DKKxOQAptmvF3BGnGqCAXwUhI
	 FDt8AF41CY2a6oeW6ib62DiaT+1sfjGxD72j1WaqLMDpRbQ4lreLoVGFqw7QRq78cGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275675;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=54yQrXtTo6n4glyDMJvBhVg56JBFe8LLpx850k4k4Zg=;
	b=n0CZePChRBRMDIzxObPt7HzymbeRHs/JCg1QY7i4k+WXK+Oa47rNlR51jcjQCXs8wvPC
	 IiKJR9xjvWLX9tVaWFv/YzqWzNwZXk2xY6qRHAQoXUaUnBDeNcq1arJ23OHClOesMr9Fk
	 y1rfOdL/xy3X1kqvtQSsC9E5d3tMJeENKWx2h+MmWB568NbN/yyRO47Pom7+9K/Yj+bvT
	 Wz7OYbasg+gExMjoi+Kpo3z+EBtBoNOjnzdqCGm3bMAsAHSbK8nwpM6kReBZcFvnt9All
	 /MCzC+xNS1upqg5Oi2ELSi/3WkE0bHrdYiL08s1tWyTVyQzQEgD4yh+37+iYZYWqyhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnWHx1jo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A148606A321;
	Tue, 10 Nov 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnWHx1jo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E18C1F0089F;
	Tue, 10 Nov 2026 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275675;
	bh=54yQrXtTo6n4glyDMJvBhVg56JBFe8LLpx850k4k4Zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnWHx1joezvBzDTRHvu09MaFP2S6CZpYZDF5ERfZemweOc3X5JtbkUrw3KVlcLTKu
	 GI8nCmhZJan1ktXLWyxyABEZYsHZO5Ea+6pnBAlGVLqSJwj9QgoHywmlR3V2wuCxzc
	 FepWZ9BweL4nPJ7C3kCSRnfaT7KSayxTWGVju5kId6OoYatT/kvbi5YYv1EYjBgcL2
	 chUQWA9CNQYKnUie5UJsD2R1oTZOMaZnVt1rkiI/gp9UR0mBP3aGAN+y+L58fweDL5
	 gRyLKckX/3fA10+Bl1PExtYJbOhBIAaoxNY2oxZkUC0iEtEflE5YT4zEs1u0fdKXyV
	 JyMf8k6sSVTrg==
Message-ID: <sashiko-outbox-206003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] riscv: stacktrace: Add frame record metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu
Cc: alex@ghiti.fr, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, martin@kaiser.cx, kmehltretter@gmail.com, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20261110013750.36800-5-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:54:33 +0000
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
- [Medium] riscv: entry: use call instead of tail for handle_bad_stack()
--

commit ed05329452fecde9e16a00910af1efec91f2922b
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: stacktrace: Add frame record metadata

This commit adds a metadata frame record to struct pt_regs and initializes
it across exception, overflow, boot, and task-creation entry boundaries
for frame-pointer stack unwinding.

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 61b7a77166971..4c69132d59785 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S

[ ... ]

> @@ -354,6 +376,19 @@ SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
>  	REG_S s3, PT_BADADDR(sp)
>  	REG_S s4, PT_CAUSE(sp)
>  	REG_S s5, PT_TP(sp)
> +
> +	/*
> +	 * Create a metadata frame record for the overflow pt_regs. The
> +	 * overflow path is entered from kernel context, so this is a nested
> +	 * pt_regs boundary and the unwinder can resume from the pre-overflow
> +	 * frame pointer saved in PT_S0.
> +	 */
> +	REG_S zero, (S_STACKFRAME + FRAME_RECORD_FP)(sp)
> +	REG_S zero, (S_STACKFRAME + FRAME_RECORD_RA)(sp)
> +	li t0, FRAME_META_TYPE_PT_REGS
> +	REG_S t0, S_STACKFRAME_TYPE(sp)
> +	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
> +
>  	move a0, sp
>  	tail handle_bad_stack
>  SYM_CODE_END(handle_kernel_stack_overflow)

[Severity: Medium]
Should this use "call handle_bad_stack" instead of "tail handle_bad_stack"?

Because tail does not update ra, handle_bad_stack()'s prologue saves a
frame record on the overflow stack that pairs the new s0 (pointing at the
overflow pt_regs metadata record) with the interrupted pre-overflow ra.
When panic() unwinds from handle_bad_stack(), the unwinder consumes
regs->ra before reaching the pt_regs metadata record, and if that return
address was hooked by function_graph or kretprobes, recovering it with the
overflow-stack fp fails and aborts the stack trace before reaching the
overflowed task stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D4
