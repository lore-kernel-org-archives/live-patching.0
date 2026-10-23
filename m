Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777480;
	b=BfjQ5iKuo5p6F1RsUwaRcfqS6PucX014OS5KQ229BdznLT+LZAwSOwXUpMMGvHs9GBM7
	 8io4ugRdyOA7veXjUJsj/elLaOHOm83PLnBvRw2eDlVWhvLyAFB4gCMAEsosFqc3DPLPl
	 BSwa9m+906r89kloz88gy3mKQ/zo061uAz3SIc7ZxvUYVsTl+vprYMIRpC69+NXNAWQ8+
	 /78AfHoRfesCi6xqGAB06hcoqk6Uz3KuS3Fts9ZHj6TcyAAAvmtWOWVV/W4wKt7v5LTVF
	 1leU9BrsQKP/79U+aEtgZ5ohv056sa3cbP7E3mVqQ3sHI2vdKcZGXVK7TkHO3e3bmyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777480;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zXiUemepjOPswE/dv3w/niJGom6WyXdqpKUx8jNiPFc=;
	b=HWiMOM6DQT/HbHnT5qkos9+efSZfe183boQVrfx4bC6mYMOsiAQESLZHGuw/H6JnFkML
	 Ql8ZtYvbokpRbgdAvf7W/fNSFV2kVu1xLSjvpJ+uxA/Kuo4WICMpFuXiCpWQRTPq76GeU
	 gUPug8O1krD73gDixyAODMHPRcI29erA7adGNyq7y29a77gikDBDdnmNWrRinHXOlx3+l
	 AMTYjP3XOqcvrLdo3ZMPeCewO9k7PvsvtFD3i/bkD+dTgdOYJtQCWJogHd9+x8yafRtP7
	 u4WwNqD2vCQcmvt9ZLzmpgoa/pZTIIc7TZnKF6X6pOkueAXiYcxMMiAwSSF85awsT1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdR7dWeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBD60A2638
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdR7dWeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE861F01825
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777480;
	bh=zXiUemepjOPswE/dv3w/niJGom6WyXdqpKUx8jNiPFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IdR7dWeTkJF+vbAS2dhBNUISpDnjcNOjAN+TK5/uq6UGz3hgsPVmCfi2zCHUnn8jD
	 c2alRFqa4Otm4o8OGfYQ8SuHaIsivR3cw98U0r/aSIlX7ItX+1WCb6xD9Gnp18L8Xe
	 x1eB5kQhYH1Xlyprt07K677BJjpHgbBmbEIdBI5QhRBpF6N5Ri8YhZReM8MtcutUPb
	 H92JiBQO8wiem8ITuseu12WPxA3y4s2W7vXjzqYRLfvytjyYrZJ+xrTLgZc4tmZegO
	 NzS+jSkT8j/DYvxHyKV3C/NCRj8JxfaVKhdopHQ8bdBHh0UDmVhlVGITJRsSIlm69y
	 +3d0nFPlC3gzg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c8958d5so111580085a.2
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 10:44:39 -0700 (PDT)
X-Gm-Message-State: AFq9FYLtI4lTbpzPkC7UpZlUzB/qWcO4FBrZl0BFEwyTITD3OktckmO5
	P6JeGf1iOOtzcc3HFq1wUEX3ZxrFlMl4y01TAlrxQ+Qqw3LkR+OrboPs9GID4G6P5V+HjsoEgXt
	xGsKSOUlD9AYKuMffoWpUgYb2LpX26hQ=
X-Received: by 2002:a05:620a:4449:b0:93f:34c9:924d with SMTP id
 af79cd13be357-93f6f9549d2mr437943685a.35.1792777479226; Fri, 23 Oct 2026
 10:44:39 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022171637.3298443-1-puranjay@kernel.org>
In-Reply-To: <20261022171637.3298443-1-puranjay@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 23 Oct 2026 10:44:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5TvQBVYZx=DkeW=H2K3Hfmxftkj67AZ=Gk119T08-L4w@mail.gmail.com>
X-Gm-Features: AclHuK8QEusyOIvplGrdalM_zykjFVOkIuFSHxXqY4YRCorV7fGbnhhyWBRsVYQ
Message-ID: <CAPhsuW5TvQBVYZx=DkeW=H2K3Hfmxftkj67AZ=Gk119T08-L4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] objtool/klp: Reject changed functions without an
 ftrace call site
To: Puranjay Mohan <puranjay@kernel.org>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miroslav Benes <mbenes@suse.cz>, 
	Joe Lawrence <joe.lawrence@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 10:16=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Changelog:
> v1: https://lore.kernel.org/all/20261022122544.125305-1-puranjay@kernel.o=
rg/
> Changes in v2:
> - test-special-sections: check __mcount_loc in its own block instead of
>   inside the section loop (Joe)
> - Collected Joe's Acked-by on patches 2 and 3
>
> A changed function without an ftrace call site makes klp-build produce a
> patch module which fails to load.  The kernel's 'inline' implies notrace,
> so this happens whenever the compiler emits an inline function out of
> line.  Patch 2 makes klp diff reject such functions, patch 3 tests it.
> Patch 1 builds the test fixtures with ftrace, which patch 2 needs.
>
> Tested on x86_64 with GCC 11 and Clang 22: the objtool klp tests, and
> klp-build with a vng boot, where a patch module built without the check
> fails to load with "failed to find location for function".
>
> Note for the arm64 klp-build series: arm64 has no __mcount_loc, so on
> top of that series this would reject every changed function.  It needs
> mark_traceable_functions() to also handle __patchable_function_entries,
> using pfe_offset.  I can send that on top of the arm64 series.
>
> Puranjay Mohan (3):
>   objtool/klp: Build test fixtures with ftrace
>   objtool/klp: Reject changed functions without an ftrace call site
>   objtool/klp: Add test for changed functions without an ftrace call
>     site

LGTM. For the set:

Acked-by: Song Liu <song@kernel.org>


>
>  .../objtool/Documentation/klp-write-tests.txt |  9 ++-
>  tools/objtool/include/objtool/elf.h           |  1 +
>  tools/objtool/klp-diff.c                      | 47 ++++++++++++
>  .../tests/generic/test-thinlto-ambiguity.sh   |  3 +-
>  .../tests/generic/test-thinlto-local.sh       |  5 +-
>  tools/objtool/tests/lib.sh                    | 42 ++++++++++-
>  .../tests/x86/fixtures/notrace_target.c       | 71 ++++++++++++++++++
>  tools/objtool/tests/x86/test-checksum-alt.sh  |  4 -
>  .../objtool/tests/x86/test-notrace-target.sh  | 74 +++++++++++++++++++
>  .../tests/x86/test-special-sections.sh        | 12 ++-
>  10 files changed, 254 insertions(+), 14 deletions(-)
>  create mode 100644 tools/objtool/tests/x86/fixtures/notrace_target.c
>  create mode 100755 tools/objtool/tests/x86/test-notrace-target.sh
>
>
> base-commit: 6ecc854643e6fd6a2d07bc8d83015c7c34a951eb
> --
> 2.53.0-Meta
>
>
