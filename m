Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50C3B8D40
	for <live-patching@vger.kernel.org>; Mon,  7 Sep 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809599; cv=pass; b=hLr3dqDRjJjnk5S7+6YlqFXQcF3KMK6xDI1ubd+CcONEtralHGJjkjWxDwHu4GpC7hhANJ344A5wDvXO6cCi25yDtRlKa8bVdlMjvS+xa7geYEJ34mvEnJ9BzkFqCVsoVeNXbS9W3OpTLzTKezmI/xtPQKofIYBgNt+Jq3+uBvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809599; c=relaxed/simple;
	bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRiRLAUFsrqXaVS61oe4V0G9YvMaKDKLV/IICH8gf9pUuNme4Pp1grE+WyLXsDnrY04VhFNX96ijdbotwytFlEcPgdIjBLMb6NXGV9YHzRFqz+mBGxuaJLBqHQkiBikbwaQZ1Lr9i8vbmTTlK6UdqPzNN++zw/98dQEUOn15Ck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK0qYj5j; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK0qYj5j"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8523cc41f41so150924b3a.3
        for <live-patching@vger.kernel.org>; Mon, 07 Sep 2026 12:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788809597; cv=none;
        d=google.com; s=arc-20260327;
        b=D6VZJPlvOIyTzmeTlXW6guGU98wBOCGzzvXWhKa0CHN8c0WuLfYdwHKGez+RVDFXD8
         F9y7L4ERR3o15AjQTYW/khyLhnDTpJ4BS0FY/FfFN5WDrem9eSU1qskormYMbZqecPRP
         9fCJRBqEsNpQKGoMplTv4WU9n6Ei5E7vdt489gJZDlI0FQ3601juE7dJCpsELEgkXZ3O
         Gwg5VC/yO3TSaV00VDLTl60dY5NFK5Y7nd+hJtaJhtbtAycX1vJerj2lRWF5g2HlBEja
         DIwyJ9heitibeJ/ZBcK1CGUEYuL0SIU42yL76Lu1GVgIiEyKdJWT7yOIHDA/XFS35NJ8
         IEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        fh=9qx6OaR+mza4P5F2nHFDsKMr3RWEZWCMme4SWNox7qE=;
        b=pZeemD2ERpBZsCK+dJ6hYVm9VWA/pt0zMUJT0cNhbTbEy2ls7HOP1PG47v76vws7Qv
         p3UNI693mXMkEPwvwaCJuXxbsmpa/DjDdGaJAdrCuo3ptdG5nf4iKq4ScYvwZtD1Qk8s
         REpqUPuF+K971v7HWbZ0/ADjKiycdabg335EClTfFow4QZA046YLrzPaf237uwWzBP0v
         mXg1K8j6hTrn1iKpM7H82M/2yerCn+YoYA3lp0+gt74tI0gqG8qQE0bh2O5tU1Ht09Zq
         JO6W5E/qHSDo+4UhLdTPQWjDR59D0Q01FgCuhMCzlpAuzU1teqzFFzyVhGSrCDHz2Wed
         OYXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809597; x=1789414397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        b=iK0qYj5js7h9LqZ16ntFi4pR+coNw+J1DIsxddLy2bybdXua8s7AhsQh5PKG4aPy8k
         cWfcsot8Jd3QOFo9QOMLhxclr26W+2bFQXUQb/5htv9RCQ75k/nTYOvsiDpAh9ZC1h0P
         17HYrGhBkPAcaFKfVJDBRota6XZwJTFU94U1d0QKrv1bCLj5OM6vuETU3sDAU1WcF6/P
         XwKGZTES39HLJn7EPOvbTJ556I3rp76dCWF5AVgyuUSKXaJklfe1ypw/YLdAV2Pt4o8p
         oIt3UyGz4+F70fE+3rhKKK66OxHCacES0jUQHDbVEe3CfUFb1qgvkTLFywu8+KyEsrhR
         Wz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809597; x=1789414397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        b=gRFgE+9KzKEM+aj2T1Opyj50n2LQseMTyNpjn14oY/UA61zISvyYh+Y6OJ5sFgPj1u
         Jspyw5NLnj2/PdXFa3syAvAMz6xFvt+u+xx8u+ZE6KeLNTEZt5/dBIRIM0HCTz+kfMSM
         gn6mq8G2DZCd4lJjTxR2fTtEU73V69kwQKbH6E1kN2b7B9MvhaZMwC+uw0etTIM6WI4j
         EThUHbWungWFhLUO7YwSJxdyVPHZ/stdpfF3qh/58ci0SjLjP2/RbrCJhUTfxEOQofum
         RReI0ksFuzZ4GomzzpWKIObSdtdDPpq2CRRdX9JTPg2k6aAjtsliBtiC6bI69BPEzLIj
         vcNw==
X-Forwarded-Encrypted: i=1; AKwUvBwVnvw1O3Wln7LpsqCOCEpE35wPY4YnH/SG4tbm9g7Eb7iD2raf+4lNX5w6LqC2HE4DRt+dozhUYR/3a1BE@vger.kernel.org
X-Gm-Message-State: AFuF++m+mVNbdPU5AUnWzjJr8kQphQ0KdwxmwE3eP1cIyvLKGmsAI7z/
	lMYJMjsXDQ4Fv1pljTCVK0ClhFZ5TZJFCtnCY4InV3OhZKljJfAMPUKWJ+gTKVlDHF1NvhtcVCC
	WCixZjy+9HclQwcRmMQ4F8Bbb9obOQrQ=
X-Gm-Gg: AYBFou2m0g44R/AFvugv+0YyacwdGXfF28pTnGOxN6GuT73ESo78EKrNJU15vcxpUA0
	scC8YFUx0MUqMqnB4I5dV9miZfGXLFKUFwa+13Grv8bteQIczKYimpGYijl+MTVI3oAAV1I/J/3
	HONZAdCipp6OA9kv32snvmY8i0MApMdbc1999ZgdYZaFcTJuW6+zpAQU659KjMH2lys1in0/8Mv
	Sy2lCtm6NH7C/08/mHt8sysuzwOjEzhBy6PilfboRI6Cp298dci5f953G6xi54mjbaxw7ANJYMN
	tRklhhEmQN1CbXj18iBQHf1yXJiLUTN/zc+7NXZJV3Jbg6eDNLthdRg4YBQ9Zuh/7Voq0WaF3/u
	1NCmCadKqrWWdqmnSB1i78F7vE1UuePn0VbvVDKJ/a4chl41t8t0Nq4FYVvjBcg==
X-Received: by 2002:a17:90b:1e04:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39b264b24e2mr23088437a91.0.1788809597288; Mon, 07 Sep 2026
 12:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
 <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com> <ap3Z-YDtzmdtMiMk@linux.dev>
In-Reply-To: <ap3Z-YDtzmdtMiMk@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Sep 2026 21:33:03 +0200
X-Gm-Features: AcwNN1UJ5AD1nmjaRgagxZvj3fkfuD3Z7c-j0Zc231NENpcPq2HjO9j40kxIvNk
Message-ID: <CANiq72mVXNmqh-RdOunFLBKRwMgYHFBqJOP7NbXrd8WHPb3sAw@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] arm64: ftrace: Allow CALL_OPS on kCFI kernels
 built with Rust
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 11:24=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> # Do not pass -fpatchable-function-entry to bindgen: its libclang may not
> # support the section argument (Clang >=3D 21), and parsing does not need=
 it.

Thanks! Hmm... Not sure if "parsing" is the right word, i.e. a flag
change could still make `bindgen` parse and generate code fine but not
match the ABI of the C compiler.

i.e. I guess I would have expected something like "...: its libclang
may not support the section argument (Clang >=3D 21) and the removal of
the flag does not change the ABI" or similar.

Cheers,
Miguel
