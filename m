Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E223CAE95
	for <live-patching@vger.kernel.org>; Sun,  6 Sep 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729899; cv=none; b=Miz80Yu402LrGiigW22/eIPHgBcgInRFlKbs2jZCn9NbVimhCBwE63gGjA/hFYVQi6I6nBDeb2C+GBxeyaYCck0T0XFBu3iRxGE69LghcKsnd95H26jHYAhOS1SGa6pUpddDb4ofdyaXCT8fzhgymbBWAaLMhsb2/yj6XwIWvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729899; c=relaxed/simple;
	bh=pcjhQGSVfuM8CzMveHI2vIfzY9kUvlXaqbuPPVccsXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaGU3IlyfZDvt7HiOfzQop1NzxDlniPPfkGy+Jwt6LMH8JZNKLhTp96o4BjL52iyEe15Ldjdo7tztghhEIwu5mixSintMshFCf+7RskzPhSaFIAr859ceFj+s0XCPq/cNXQf/rqR78+EScH5YnjEHaihGxQO50MgESuwoUjAWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlQwmOce; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlQwmOce"
X-Envelope-To: live-patching@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pcjhQGSVfuM8CzMveHI2vIfzY9kUvlXaqbuPPVccsXU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788729893; v=1; x=1789334693;
 b=NlQwmOceV8DgiG4i2ZKRVIqqwPhvNf1sH4h/uL1/6jAngVzRvpEdVKFZGAIC4ImGNtRz/B3R
 eHcTuXCs8YQeeCoFa6va5ZrDYoWzzZncDv5WCymo9fsHb4K8XngUr/iVr7qhBRUl3XJN7gj9Xan
 WWgUzbff0itFOMZZwQgilhig=
X-Envelope-To: live-patching@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1ebff86c5741b26c;
	Sun, 06 Sep 2026 21:24:53 +0000
X-Mizu-Trace-ID: 1ebff86c5741b26c
X-Migadu-Flow: FLOW_OUT
Date: Sun, 6 Sep 2026 21:24:39 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Subject: Re: [PATCH RFC 8/8] arm64: ftrace: Allow CALL_OPS on kCFI kernels
 built with Rust
Message-ID: <ap3Z-YDtzmdtMiMk@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
 <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com>

On Sun, 6 Sep 2026 18:56:47 +0200, Miguel Ojeda wrote:
> Now, if we are going to filter this out for Clang, should we just
> filter it out for GCC too? i.e. outside the `ifdef`?

Yes, that makes it more future proof. For v2 I would filter it on the
bindgen_c_flags_final line, after the ifdef, unless you prefer it
before.

(And to your question on patch 6: yes, the rustc flag comes in this
patch.)

> By the way, "generates no code" sounds a bit strange, since `bindgen`
> generates source code...

Ah, yes. How about this, here and in compiler_types.h (patch 3)?

# Do not pass -fpatchable-function-entry to bindgen: its libclang may not
# support the section argument (Clang >= 21), and parsing does not need it.

- Jose
