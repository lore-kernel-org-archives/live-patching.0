Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E003515FF
	for <live-patching@vger.kernel.org>; Sun,  6 Sep 2026 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788727276; cv=none; b=klSAjs5cC8DgVnZP6yK0rdW615NM4M56DT2DAGw2NOHCLOX6HzfPEQN734JcyAqoWs3UBEaH0ykZXLK51HmW+VBLvVGJzgIpmIrOwLzbMtMJWgtCEE8LSbHwCwv6h0kEzNsUPKWMHuRsGcqL9kyAvcaY8x6L0e4IaGTx89B+05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788727276; c=relaxed/simple;
	bh=bSpNhh9FtdEJvuQK9j6aUZgksjI6iJ3Km92h4AkEbNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrUMuBM3/ec0D3bEQ8Au4WNFtWf5XqiusOR6RGheBKmEUOBCLxyzTkVk5DNQj6rP2GH2DlmMlIFdeRBxKPjOIv25pqyCsO/u6fTt7co2Kg5F3xWxfr2LTJVKkQKfMRisQ6u0QIMTOY3kyoAD09xdDzpN2jwsK1P5tnjHCKynweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ve0+NxTg; arc=none smtp.client-ip=95.215.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ve0+NxTg"
X-Envelope-To: live-patching@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bSpNhh9FtdEJvuQK9j6aUZgksjI6iJ3Km92h4AkEbNc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788727271; v=1; x=1789332071;
 b=ve0+NxTg7EOaLORzxPRSMPAsyjX76cEpURXPr2Wczsq0Y3VU1YC3jjBMmhAk/xlZZfoPG4Fx
 g43Enh5rW+yGQfcXUFcw3N5dO+qwej5NQqRBJwN+KXOPqmhWr+T99MXMDn7gF0nfGTzhcZjrPEB
 QvnU1HjF9VQiBvQZ37d8+ue8=
X-Envelope-To: live-patching@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ce9db71ae2dcd178;
	Sun, 06 Sep 2026 20:41:11 +0000
X-Mizu-Trace-ID: ce9db71ae2dcd178
X-Migadu-Flow: FLOW_OUT
Date: Sun, 6 Sep 2026 20:40:59 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <kees@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Subject: Re: [PATCH RFC 1/8] ftrace: Let ftrace_call_adjust() reject a patch
 site
Message-ID: <ap3PYIdhL3ETmN0Y@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-1-ce6687739b0c@linux.dev>
 <20260904084728.6d2ebcc8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904084728.6d2ebcc8@gandalf.local.home>

On Fri, 4 Sep 2026 08:47:28 -0400, Steven Rostedt wrote:
> The above could use a comment to why addr could be zero (I didn't even
> realize some architectures do that).
>
> 	/* Some architectures may return zero for mis-aligned addresses */

Will add one in v2, thanks.

Today arm64 returns 0 only for a mis-aligned patch site. But patch 4 of
this series replaces that check with two: the two NOPs to patch must be
there, and the ops pointer must fit in the prefix NOPs (which also
catches a mis-aligned site). How about this to cover the series?

	/* The architecture may return 0 to reject a patch site */

Happy to name the mis-aligned case in patch 1 and extend the comment
in patch 4 if you prefer that.

Thanks,
Jose
