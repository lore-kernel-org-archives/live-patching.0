Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537759;
	b=gt5PnLOxK6ySWhGg+bJC9btN3mZHOYeQ9r6amV8ZKTT0AdB/TKxMLHuRSJW3/wvuQmUJ
	 onDbAmXpB3yyfaO0tbSOZIpvOLTFT3MauIUKvpE6MoOGHzkIG0U/XPsZ1DVCb7aCI+d4R
	 16i1uVLKz2xihxRFah1nK/vtGvwEykBWq0yuE350t9u/YM/mTBIkvM1bq2D3DsX+vHZOT
	 KDrmUVeV0twoS6xz7aNRkAz29Ke9tQ0h90lHNvnuGLfVsboH03O8thWdIh5MGi6fqw1mE
	 ZTLNb0WgEEeenp/GzQWIOSaKqsF/k7JTGidFxBn5oaX8CjWrmDtAeiHT2zKTaZTVl1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537759;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jQRGsd7cMv6GWPamWfpww1CqH3rlOptCcJ9oQe+sBGg=;
	b=JALVUBcfy5chA0XAQekrKNpKIKRQuOYTUt6Oj/CqleCBJaUkHaNj0ZplAPJQoCg1IxI3
	 q6zvjE9ee9Al1QAjKzvVdwxa7ytrd2+AVaEKk2w9v/RiMBtCc35e1Bkdl+cmBActmofT5
	 RHBp5nhSGxtqYPDkxfhMCPTCHUuiMMhpcW8w/Pnz1RXWyE0FkKCCTkN5US9Z5y8XfPgzN
	 1hRSJFuQtlXJihv0w5HPkxsYOw6cFGnA7kW98QPgJeJCjArX71b7y8jWGxN/8npxc8bgi
	 MZhsRdpw2Ma6g9PzVNoVO0llT38GL82F+442lW3/8rMpDsxz/LG3rBmQWKpVVITKkjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE0b+NA8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A9606A330;
	Fri, 13 Nov 2026 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE0b+NA8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1D91F000C4;
	Fri, 13 Nov 2026 02:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537758;
	bh=jQRGsd7cMv6GWPamWfpww1CqH3rlOptCcJ9oQe+sBGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OE0b+NA8xUWU6fbC4NV8Ynxt3V43jQEqtwT9grvgeXAyoQ1qVxA1c4zTRJySzfFND
	 Tq8ko47QSBZx7ZAZ4m+18/Am7EdW3xbN3cF+8ruLeT4Fcbgo61CrDkKL3N3PggxO9i
	 lw2bsC1NGw4D4N0ToxkKfLrhGTqvzq7W37hq+AGTmFm2bcjWVNdg41UoCilcdM0J+e
	 3+EYP2voUdO6r3J5rFoEJE0bF4q/c2+8E05yp0zsZtpMTQf3Vq/eBcVoRC6wA5LhMW
	 I5pRW/bT7gyziWMQi/fKkP9dBVjx+EyiAUf72Zgh07VWdKLU2neyeFJCrSEWeFB0QD
	 tymQ47M+EBAWg==
Date: Thu, 12 Nov 2026 18:42:36 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/11] objtool/klp: Fix checksums and copying of
 wide strings
Message-ID: <avZ3jEbnuVu5Qv2G@jpoimboe>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-2-luolongjuna@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104133158.3187525-2-luolongjuna@gmail.com>

On Wed, Nov 04, 2026 at 09:31:47PM +0800, Longjun Luo wrote:
> SHF_STRINGS sections can contain elements wider than one byte. Using
> strlen() truncates their contents at an embedded zero byte, hiding
> changes and copying incomplete strings into the patch.
> 
> Find the terminating zero element using sh_entsize. Use the resulting
> length for both reference checksums and copying, and propagate errors
> through checksum calculation. Keep single-byte string handling unchanged.
> 
> Add a test for two- and four-byte strings, including references from data.
> 
> Validated the available objtool tests with GCC 16.2.1 and Clang
> 22.1.8. No failures.

Please give example(s) of such "wide strings" in the changelog.

> Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Fixes: 873a2208ea31 ("objtool/klp: Calculate object checksums")
> Assisted-by: LLM
> Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
> ---
>  tools/objtool/elf.c                           | 29 +++++++++
>  tools/objtool/include/objtool/elf.h           |  1 +
>  tools/objtool/klp-checksum.c                  | 44 ++++++++-----
>  tools/objtool/klp-diff.c                      | 14 ++--
>  .../tests/generic/fixtures/identity/common.h  | 15 +++++
>  .../generic/fixtures/identity/wide_string.c   | 36 ++++++++++
>  .../generic/test-checksum-wide-string.sh      | 39 +++++++++++
>  tools/objtool/tests/identity-lib.sh           | 65 +++++++++++++++++++
>  8 files changed, 223 insertions(+), 20 deletions(-)
>  create mode 100644 tools/objtool/tests/generic/fixtures/identity/common.h
>  create mode 100644 tools/objtool/tests/generic/fixtures/identity/wide_string.c
>  create mode 100755 tools/objtool/tests/generic/test-checksum-wide-string.sh
>  create mode 100644 tools/objtool/tests/identity-lib.sh
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index a791f4ea6ec1..71f1a272e468 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -1382,6 +1382,35 @@ struct elf *elf_create_file(GElf_Ehdr *ehdr, const char *name)
>  	return elf;
>  }
>  
> +/* Wide strings, such as the u16 PSR setup table, end at an all-zero element. */
> +ssize_t elf_string_len(struct section *sec, unsigned long offset)

What is the "u16 PSR setup table"?

> +{
> +	size_t entsize = sec->sh.sh_entsize, size, len;
> +	const char *str;
> +
> +	/*
> +	 * FIXME: GCC's range_string() uses a one-past-end string pointer.
> +	 * strlen() reads past the section; preserve the string base and addend.
> +	 */
> +	if (entsize == 1)
> +		return strlen(sec->data->d_buf + offset);

I don't understand what this comment means either.  Please make sure all
comments and changelogs are written by humans, as LLMs tend to write
nonsensically.

-- 
Josh
