Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275458;
	b=0cqNxWsEfpq2hWOplgrzrQErXBmIvC0blQH5J9Rh1oAvT9b/VE3TvbTsovddzad/OLQv
	 ezXnP26YCOD8HuYJN4JrkR3Lu5UJQzgU3wyVObfZvTBbR2a+UWHhW2jPE7Q9ltQ6XVjgr
	 OrqG5Q7GUJH6t+dH37Pk5L3WkDIf8CUbrOaHSWOZqANM67DJ9pepCLNnt8Xu/dUxtBcbD
	 uIfERvY8hmmH5eATNRqtGr//g17e3fg/h8TKOX/t9tCgST11KHP7sU0f9sHBdQ97VCTJF
	 AuLF6R1dSsMjYAD9S3TIBtSY+W5Isn4PJUzCGNXH6/R0W7znHdLUP694QQdM+x0NDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275458;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBevaI+ckIf1/X2GXL2TLVM1xgMW2RuCaaIi3r/F4RQ=;
	b=f/bls5MtekGrW9q6FsulMiPmIkCmzqOlDsvfZp54uCVKPX6fVGyAFAhbcpdK7jfcyl58
	 oLF3ykaXM2YAt80WfT5GI3oxlTs/iTI/UzybmnA402LWX8E057MPbEzZ2Pv0cES630I24
	 ezsl390pbw2KNl6hu8e0/DOVBPo96BfcDEGvwLqIK/f4zQbWCJYQraRE25DrgotdOTXv4
	 uXS7magVAj66PgT9hBz86zesYX6pjpG2SdKNudaDBUDYa1RC0m23F9u1Cc9m6DejsydfR
	 zAUqp0S8Bfe/D7E6rMk62g8enuZxVVigNTTwbUPAfBNYTXvKXt5XB44Y4GB/sTpX5wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTjVQwha;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF6606A321;
	Tue, 10 Nov 2026 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTjVQwha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB21F0089F;
	Tue, 10 Nov 2026 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275457;
	bh=iBevaI+ckIf1/X2GXL2TLVM1xgMW2RuCaaIi3r/F4RQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KTjVQwhar9Qw2cuX3deiD2c51K1HmRUuDLfB/fXlepswcWI3ToAm1LsIFreURu/gx
	 Cl98FMlk9DdK1gEwm7A3OPQ2SIAPPXzqY+vpSjPOn6URvwNggXP9DgGsMhF1uNAN9g
	 xkg/opYNPGqq+OUEPrkhNdpTsrNwU6Vxp8WdBUtVRFcGum+Rx2rBrzk4fNOc4flw8h
	 0uC9NN6QpzmraPAIenqy5DxUhgggaqiOfyZSCSdmG4mOeCArKeh7WqAOJHatRbgSEI
	 wN1LPl3D6s4cbs050M+in7aw3IYEHKCCXCc1vSVfLNQO1Dtyl/qbo/JUTnZO92WOPL
	 zkbTEYx0cCQ7w==
Message-ID: <sashiko-outbox-205995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] riscv: Add KUnit test for stack trace start
 frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu
Cc: alex@ghiti.fr, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, martin@kaiser.cx, kmehltretter@gmail.com, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20261110013750.36800-3-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:50:55 +0000
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
- [Medium] riscv: vmlinux link failure when CONFIG_KUNIT=3Dm with
  RISCV_STACKTRACE_KUNIT_TEST
--

commit 88e1ac2e959d970cabee9d276d02925cc3d44f40
Author: Karl Mehltretter <kmehltretter@gmail.com>

riscv: Add KUnit test for stack trace start frames

This commit adds a KUnit test suite to verify the starting frame and skip
counts of stack_trace_save() and ftrace_return_address() on RISC-V.

Link: https://lore.kernel.org/r/20261010132712.46931-2-kmehltretter@gmail.c=
om

> diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/te=
sts/Kconfig.debug
> index 40f8dafffa0ab..eb79df5b2c5a4 100644
> --- a/arch/riscv/kernel/tests/Kconfig.debug
> +++ b/arch/riscv/kernel/tests/Kconfig.debug
> @@ -42,6 +42,18 @@ config RISCV_KPROBES_KUNIT
> =20
>           If unsure, say N.
> =20
> +config RISCV_STACKTRACE_KUNIT_TEST
> +	bool "KUnit tests for RISC-V stack trace start frames"
> +	depends on KUNIT && STACKTRACE && FRAME_POINTER && KALLSYMS

[Severity: Medium]
Does declaring RISCV_STACKTRACE_KUNIT_TEST as bool while depending on
tristate KUNIT break the vmlinux link when CONFIG_KUNIT=3Dm and
CONFIG_RISCV_STACKTRACE_KUNIT_TEST=3Dy (such as under allmodconfig)?

In that configuration, stacktrace_test.o is built into vmlinux while the
KUnit core symbols it calls (__kunit_do_failed_assertion, kunit_log_append,
etc.) live in kunit.ko, similar to the issue fixed for RISCV_KPROBES_KUNIT
in 5fada1605733 ("riscv: tests: Make RISCV_KPROBES_KUNIT tristate").

Should this depend on KUNIT=3Dy instead (since building stacktrace_test as a
module would also cause sprint_symbol_no_offset() in
riscv_stacktrace_check_skip() and riscv_return_address_check() to append
" [stacktrace_test]" to the symbol names)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D2
