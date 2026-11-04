Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801030;
	b=li/q/E5xkqBC8ZxwZQ6eXyRgJUeEyLj3ImiPBB32PYbzTFIpnHjT5kVZGcIq84LDojTr
	 lnWYdrkpcHCxB4U4gby/s0Sp+qivEGSfAeHJU4nYXy5Mo34KVCbOM6YqAJHU4vMy2W5Vd
	 SfzNCjADBkjFPIlet6F5LiiLzqYv5WojdYSyWpKOiENYKku3sM4e3cqAFYpFxNUNo5be+
	 1aaudW/OkwY+yIcp7fEbgnq2QYPOwM0qP9xWGwNUckCHqQK0jtE32o5368ZB0CjgQSgHp
	 e2/pK9PkM21ATUF3R3L4yBYb3vCSPQqmpe5iWRtIsUdrTxFyYWppBeg/LRXE9U+rKBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4wPZj4LJpcCWPHDX6n83UvAo2Q8E8JwLXkqzT3SeaCg=;
	b=lD5bWuBsdlWFzByHlBueQdFfhn7CwaKuDQ5EMUhhLy/q+/D4gxqLgMcApbzwdLKYgEQm
	 uv+m4HfkrY4fUNOOHMawqEcel+97Lp+hzgtKEb4PubQuAkqsEi56Pb+PjSbF+l2J3GEKt
	 QxG9ZUajQo3vRlPAJMwC5877n/4EJMHo4IpujYw6erqMob1oF8JUrh5SznLZIUA5vhGk6
	 lGZpW0F31vS90INqJn9QRVr8/XJrSlARtWt+P8sCNFovuZk8Kx12UftexdUcGxjCuLhQl
	 YTNLKpC//S+yoVdBnOKe13TeThJZJ1qCkZ2XDeMm5/sOHL/THganZ7365pkwLOZTsRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCup9x4i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41707606A328
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCup9x4i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5DC1F000C1;
	Wed,  4 Nov 2026 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801030;
	bh=4wPZj4LJpcCWPHDX6n83UvAo2Q8E8JwLXkqzT3SeaCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCup9x4ibRaBPPR8VDE/BTFgxTtd1xtCyRhIjtXW0oQDzQ+0y++5PF5t96XDSyram
	 YP4nMV0OdcwLMbjouJYqfdRAToGKAuDLger57WtI0HQbXi/lrM2hKGiQfoMiuEBPQu
	 YI0rurVFMOM4oUdzBDQvRaJyGufZBhX5aYgL7ZKBbtPW7xiQ0VSbQWGCuOVkvYdXP4
	 dTB8I0GLb0PsSEcLeuk3nYd3VhPIHUV5mhQIg/vdwowOdMa89MtQ+xCwtWEzySlWGC
	 4TNZMTSco807eYZX0yWVm6/MfDjadaszvVfjHmoxUmZXOr1r9c83sy1yPAAJT9fPmh
	 mcaB8g66NIB5A==
Message-ID: <sashiko-outbox-197388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/11] objtool/klp: Fix checksums and copying of
 wide strings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-2-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-2-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:03:48 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/klp: unadjusted PC-relative string addend in clone_reloc=
()
--

commit fd88c78f1c913d4c955b6342d4e45b4274643124
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Fix checksums and copying of wide strings

This commit adds elf_string_len() to compute string lengths in SHF_STRINGS
sections using sh_entsize so that wide strings with embedded zero bytes are
not truncated by strlen() during checksum calculation and livepatch relocat=
ion
cloning.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 34da55e456097..6321f691adbbd 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1548,12 +1548,18 @@ static int clone_reloc(struct elfs *e, struct rel=
oc *patched_reloc,
>  	 * version of the string section.  Now copy the string itself.
>  	 */
>  	if (is_string_sec(patched_sym->sec)) {
> -		const char *str =3D patched_sym->sec->data->d_buf + addend;
> +		ssize_t len =3D elf_string_len(patched_sym->sec, addend);
> +		const char *str;
> =20
> -		__dbg_clone("\"%s\"", escape_str(str));
> +		if (len < 0)
> +			return -1;
> +		str =3D patched_sym->sec->data->d_buf + addend;
> +		if (patched_sym->sec->sh.sh_entsize =3D=3D 1)
> +			__dbg_clone("\"%s\"", escape_str(str));
> =20
> -		addend =3D elf_add_string(e->out, out_sym->sec, str);
> -		if (addend =3D=3D -1)
> +		addend =3D ALIGN(sec_size(out_sym->sec), out_sym->sec->sh.sh_addralign=
);
> +		if (!elf_add_data(e->out, out_sym->sec, str,
> +				  len + patched_sym->sec->sh.sh_entsize))
>  			return -1;
>  	}

[Severity: Medium]
What happens in clone_reloc() when a patched function on x86_64 references a
string section via a PC-relative relocation such as R_X86_64_PC32?

In checksum_update_insn(), the relocation addend is adjusted before calling
elf_string_len():

tools/objtool/klp-checksum.c:checksum_update_insn() {
	...
	offset =3D arch_insn_adjusted_addend(insn, reloc);

	if (is_string_sec(sym->sec)) {
		ssize_t size =3D elf_string_len(sym->sec, sym->offset + offset);
	...
}

However, in clone_sym_relocs() -> convert_reloc_sym() ->
convert_reloc_sym_to_secsym() -> clone_reloc(), addend comes directly from
reloc_addend(patched_reloc), which still carries the -4 PC-relative bias on
x86_64.

When the target string is at offset 0 of the section (so addend is -4):
- For wide strings (sh_entsize > 1), passing addend as unsigned long offset=
 to
  elf_string_len() wraps to 0xfffffffffffffffcUL, which triggers the
  offset >=3D sec_size(sec) error and aborts klp diff.
- For single-byte strings (sh_entsize =3D=3D 1), elf_string_len() and
  elf_add_data() read 4 bytes before patched_sym->sec->data->d_buf.

When the target string is at offset >=3D 4, elf_string_len() starts 4 bytes
before the string (inside the preceding string's terminator, returning 0 for
4-byte wide strings), copies the wrong bytes, and then overwrites addend wi=
th
the aligned output section offset without preserving the PC-relative bias f=
or
elf_create_reloc().

Should clone_reloc() use arch_adjusted_addend(patched_reloc) to locate and
measure the string in patched_sym->sec, and preserve the bias
(reloc_addend(patched_reloc) - arch_adjusted_addend(patched_reloc)) when
computing the new addend for elf_create_reloc()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D1
