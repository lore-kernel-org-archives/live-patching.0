Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7443B6F0
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492699; cv=none; b=Q6Bl+yD37Aqi1AnogRv6jwbAX9onQA+4RllqK5NvOgOKHZjImtx6+H83koaVMF9zkewWI67F5406PtU6tYdClC6NIJA1+2ugCVIRWjdg+yVmMnCGrZLaNmXb3zeo81jtAW6uflhOGKRhlnZa9NmO7nvzoCcwdQccWAQvDDVGuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492699; c=relaxed/simple;
	bh=TL03LouVQiQYi+BRe5cmzoZdE7Jb0P8GBrGoU0aa5SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOrMygdGtt4XWyXHGmYG3UrzlN1Q1DC3LaQIWnHqTdVMHtATLbEHIxn0Z1iIoRqv8xFp+JpwVr9R2xRnoxYT6Vav88J5fSkNoiD6NNwdRsK9PVmsZrof7h50hNTZkWBrDgmzct4ANVcP0+Gy8qShr+jJ/0AaqfIwjS0insSMapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o03VnHxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o03VnHxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D71F0155B
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492698;
	bh=fAREtHbS82rvSxqq0HWUKkEUqHXgzX1Dax981OtXp3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o03VnHxs2N1yfipicNuhXzQXuc2/OtIsWiaLcE60IbVNrWTknlAibwoULOLcabTsJ
	 V4crRvm2J1tN0kX72QTHMeHcgy9JL5S9PYM0hS/4u/Ijp9JQEEnPITF6CXF9SRSyBn
	 S6IZQeFoqPtubk+JBipoxZsyPQGdLUOkOKZKeFYqwQumRf8pPJLSYvrsXnBZYhKT9G
	 +ab958k5gwCED3RHXIE+khBj7vH2BmD6bqMTLupzAn1JRLPa9kS0y55Ui0J6Ejvhs9
	 1fSVPvMdvQYXc2bDCX4ogXhKyRQYA2sTcrpbmrb0SA+s1N8WTvC3xD8Qu7g5ANGRw+
	 P4kh8J7aJhFKQ==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9349ad9c857so54341085a.1
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:58:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpH4B9u5fwIO57/8n7ubOyVJd1Bk59StFDrxnRpUvPGSDoUpNe973NNys9GN3MnbLtNhUW3A0GBfmWGJp5U@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOa/TQnxBWsSl1DLk6GzQMS3rOi12JS0bcgP3SUW0yNGAIU/+
	mDUiYK2KkXF4bN1Ll6UZaDXco/PCoUDA4zmpru8v/uhwxw569CnI+dnX0YAqYXZ45pSokQmTHnE
	AJYTGrtH0D5NnXkUzBzIc6JTeOKATlEo=
X-Received: by 2002:a05:620a:170b:b0:930:a3da:3a77 with SMTP id
 af79cd13be357-936b3a89916mr120474585a.16.1786492697247; Tue, 11 Aug 2026
 16:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <11e49187e13d36d4257bc60cd2606e0ff5481dfc.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <11e49187e13d36d4257bc60cd2606e0ff5481dfc.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 16:58:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5tzBOHnw42d31r_5k9eS28VrDLGXoUzS=hYkZmAyRbhw@mail.gmail.com>
X-Gm-Features: AUfX_mx7N2pB49_Aimj1F_L1AcYkp9oHPvSJaPSP5hfhgPDqfK_v6h_UtELmWJ4
Message-ID: <CAPhsuW5tzBOHnw42d31r_5k9eS28VrDLGXoUzS=hYkZmAyRbhw@mail.gmail.com>
Subject: Re: [PATCH v4 15/22] objtool: Prevent kCFI hashes from being decoded
 as instructions
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
[...]
>
> +/*
> + * ARM64 mapping symbols ($d, $x, $a, __pi_$d, etc) which mark transitio=
ns
> + * between code and data.
> + */
> +static inline bool is_mapping_sym(struct symbol *sym)
> +{
> +       return is_notype_sym(sym) && strchr(sym->name, '$');
> +}
> +
> +static inline bool is_data_mapping_sym(struct symbol *sym)
> +{
> +       const char *dollar;
> +
> +       if (!is_mapping_sym(sym))
> +               return false;
> +
> +       dollar =3D strchr(sym->name, '$');
> +       return dollar && dollar[1] =3D=3D 'd';

nit: is_data_mapping_sym() calls strchr() twice. Maybe we can
optimize it by eliminating a strchr()?

Thanks,
Song

> +}
> +
>  static inline bool is_global_sym(struct symbol *sym)
>  {
>         return sym->bind =3D=3D STB_GLOBAL;
> @@ -508,6 +528,9 @@ static inline void set_sym_next_reloc(struct reloc *r=
eloc, struct reloc *next)
>  #define sec_for_each_sym(sec, sym)                                     \
>         list_for_each_entry(sym, &sec->symbol_list, list)
>
> +#define sec_for_each_sym_from(sec, sym)                                 =
       \
> +       list_for_each_entry_from(sym, &sec->symbol_list, list)
> +
>  #define sec_prev_sym(sym)                                              \
>         sym->sec && sym->list.prev !=3D &sym->sec->symbol_list ?         =
 \
>         list_prev_entry(sym, list) : NULL
> --
> 2.54.0
>
