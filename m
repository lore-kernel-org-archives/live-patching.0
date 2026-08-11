Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB708388E69
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492385; cv=none; b=Qjz3nWSLxllhCnrNx/uyNvPw4ZtSTOtbeBRETwTb267yoAUy5adyhT8/j2LbGXoYMybYnJQHV541V9e3luhue2epwhe6wQRSFQ3FaBdKkS117zJfJbuYvXG42gJn6XIfjDKtucHHwlBWLGvF3KiD5tHz3TRdUs6Im1pAFRLyv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492385; c=relaxed/simple;
	bh=YpYCX417iOiWd1GTtApglxPiqDkSX8rB6uHZxr6ATSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFrBZrpD9xY2jn7snOCSVIP3aJ0saolVQVU/AVa8ZyrZ/TujM0+BWrTxnD7ADi7MBux4zy5a63K8LgqLd9ZRLU8tuIUMFpp8bM+m8LH4SLJ1ptGaV8zCq/6czL+qHjMMMaYSjKvDWX9tr80opBolhvU0eSDEQwoG4tXXxfwqYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUETfSDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUETfSDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A7B1F00A3F
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492384;
	bh=mTGZpIz4M4r9TSqZuw4PEXtdDxWFgjyQGT20ghOJOs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IUETfSDBkQnsDjyBbXLKQ8oMvR0/zFsIs/1G3JE+te8UpUlm+xu9vxMjnZ2OOcHWH
	 eUEi2zqq81g/yASeaTxTmSu3ipVUa5UY9sCfqnSLH/Z98lCND3I8kKJmeEdPuV+aop
	 9lxe30nL4z/b3yzSOUTaZ8fkGZXUbxqO1+3nxLmwPWIvm011c5g6S7ujpfMplzz2nR
	 b4pVIF2CAb44KhJSp0+MTpDPE1G1orSiKjWnM2SkqwirowpcElYtzGpcU5jn8xk2i5
	 KIc0leZzdjiaWE8CFneKZyrF1CZ81dPtF3aw1Dmz2+PwA+brsZ1oOfdmi+sTlLiXvL
	 hIMAm2sntJjwA==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f256eaedf8so3798136d6.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:53:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro/RRclmdvsYprP05xPcReU5LcKHgq0x279LP7Ea/HQLZ33NQGwP2+myDALlAZR6mTkNRV+KhrdCwCbK1yu@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0jiqayvyzP6Hg34rOvTMnnqu+VbkEjgUFHWEBCfc+xr79qOz
	n2KIomCfTV52WCMzSa9zmRpfbBKrhUi0WOkrbfQroBxaXo7IJJ7zlVC+8t+JtbSmGX40a0jSUug
	c7neOEbv0xzValjskc40SqEO8c6OXqMw=
X-Received: by 2002:a05:620a:26a9:b0:934:b89e:ca5f with SMTP id
 af79cd13be357-936b3d9e6a5mr121592785a.40.1786492383827; Tue, 11 Aug 2026
 16:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <e0856be4208a6bed2b22dffe2bf8e010470f49cf.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <e0856be4208a6bed2b22dffe2bf8e010470f49cf.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:52:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6JgV1a7jMxQ0bknOpQ7WQNSqYbAHWss18GCrzGZ79OcQ@mail.gmail.com>
X-Gm-Features: AUfX_mx9w8Fk2oUp5Q1a-g80ik_We6OMbGfN_eNHn1Mi-ZbBJ5sgkLkmQBXmIKM
Message-ID: <CAPhsuW6JgV1a7jMxQ0bknOpQ7WQNSqYbAHWss18GCrzGZ79OcQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] objtool: Reuse string references
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> For duplicate strings, elf_add_string() just blindly adds duplicates.
>
> That can be a problem for arm64 which often uses two consecutive
> instructions (and corresponding relocations) to put an address into a
> register, like:
>
>   d8:   90000001        adrp    x1, 0 <meminfo_proc_show>       d8: R_AAR=
CH64_ADR_PREL_PG_HI21  .rodata.meminfo_proc_show.str1.8
>   dc:   91000021        add     x1, x1, #0x0    dc: R_AARCH64_ADD_ABS_LO1=
2_NC   .rodata.meminfo_proc_show.str1.8
>
> Referencing two different addresses in the ADRP+ADD pair would corrupt
> the memory access.  Avoid that by detecting and reusing duplicates when
> cloning string relocs.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>

With one nitpick below:

> ---
>  tools/objtool/elf.c                 | 29 +++++++++++++++++++++++------
>  tools/objtool/include/objtool/elf.h |  3 ++-
>  tools/objtool/klp-diff.c            |  4 +++-
>  3 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 8bf225d70d918..3bb04d6155a8b 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -1379,9 +1379,27 @@ struct elf *elf_create_file(GElf_Ehdr *ehdr, const=
 char *name)
>         return elf;
>  }
>
> -unsigned int elf_add_string(struct elf *elf, struct section *strtab, con=
st char *str)
> +int elf_find_string(struct elf *elf, struct section *strtab, const char =
*str)
>  {

elf_find_string() returns -1 for error and positive number for addend.
It is a good idea to add some comments for this behavior.

Thanks,
Song

[...]
