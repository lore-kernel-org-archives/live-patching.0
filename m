Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44434CFD1
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947237; cv=none; b=lRhxqap0XVuAyPQThoEKtxtatiHrb7itbt+9uzqTc470kc7eGvPcB6xn28TcWwNvow+C/bAkwEqlwGVM8nazNTptOQclrxDcR5e9RZrzj1ytmKHjh/RhtDVrLWBz7PzfkcJls2GUU5cdzb1oZvZoyHKZxctRt5rVS8uCxK61WA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947237; c=relaxed/simple;
	bh=kDc1uEwwsz+khShkTHZMmtl904cSBkx8DaTp4B39jNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdsnCiQWnaFfpY3ASTa3ygzgHZPoij2u489PI7ZjbhyUCHc3J4uIT0mdtkNj0dOsxw7hh1cAfMxLuX08T/wKeyg3XMalTAwuIJ2CbWRGHIWWBx4MLa3kY5Z3ITkJRYeGqZBQPYw0TQEOZRZywFz+B4LQkQd2PAhHdkKhhmSmx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCVBsZLV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCVBsZLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782947234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8B65/I8GYURpH/ouE1U4pYhV4f5bwOGTW8eYQjqr3mc=;
	b=UCVBsZLV5R03Se6O8mjlheOj6TX2IdfaOaYFBC2CLI/PxM08MTljWTyiXkVDIyPDpHwYlc
	wN9I2yfks01ZNX0cTETPRAAZIsnn4lDHZDwt3YKtS0UsU0qPCg8ex+KKz3w5IGjHtVjxpo
	yE01538xhnfPBs0CxMyJSzmaBUYqVNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-DupFlTDBOlCJkburwWwXtA-1; Wed,
 01 Jul 2026 19:07:11 -0400
X-MC-Unique: DupFlTDBOlCJkburwWwXtA-1
X-Mimecast-MFC-AGG-ID: DupFlTDBOlCJkburwWwXtA_1782947228
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECFF6185D69E;
	Wed,  1 Jul 2026 23:07:06 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5399230001BE;
	Wed,  1 Jul 2026 23:07:00 +0000 (UTC)
Date: Wed, 1 Jul 2026 19:06:58 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
	kernel@xen0n.name, rostedt@goodmis.org, ardb@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn, jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn, guodongtai@kylinos.cn, xry111@xry111.site,
	wangyuli@aosc.io, loongarch@lists.linux.dev,
	live-patching@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] LoongArch: Mark special sections for KLP support
Message-ID: <akWdkjS4zXYoj0-O@redhat.com>
References: <20260608100852.325413-1-dongtai.guo@linux.dev>
 <20260608100852.325413-3-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608100852.325413-3-dongtai.guo@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 08, 2026 at 06:08:46PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
>
> objtool needs to split the kernel's special sections into per-entry
> symbols when generating livepatch modules. Mark them so it can:
>
>  - .altinstructions and __ex_table are read-only, so set an explicit
>    entry size via SHF_MERGE (ALT_INSTR_SIZE / EXTABLE_SIZE).
>
>  - __bug_table and __jump_table are writable. SHF_MERGE cannot be
>    combined with SHF_WRITE (Clang rejects it), so annotate each entry
>    with ANNOTATE_DATA_SPECIAL instead, mirroring x86/arm64.
>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---

Hi George,

Disclaimer: I don't have LoongArch hardware, so the best I can do with
this patchset is to read and poke at it with (cross) compilation.

For the special sections, said cross compiler (loongarch64-linux-gnu-gcc
(GCC) 15.2.1 20250808 (Red Hat Cross 15.2.1-1)) is interesting as it
appears to emit relocs in special sections (__ex_table,
.altinstructions, __bug_table, __jump_table) that point to local
assembler labels in the function's text section rather than the section
symbol + offset.

An example gcc / loongarch .rela__ex_table section looks like:

  Relocation section '.rela__ex_table' at offset 0x6a28 contains 10 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000005d00000063 R_LARCH_32_PCREL       00000000000011f0 .L1^B4 + 0
  0000000000000004  0000005e00000063 R_LARCH_32_PCREL       00000000000011f4 .L2^B1 + 0
  [ ... snip ... ]

Unlike everywhere else ...

llvm / loongarch:

  Relocation section '.rela__ex_table' at offset 0x5710 contains 10 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000200000063 R_LARCH_32_PCREL       0000000000000000 .text + 2a70
  0000000000000004  0000000200000063 R_LARCH_32_PCREL       0000000000000000 .text + 2a74

gcc / x86:

  Relocation section '.rela__ex_table' at offset 0x40f50 contains 2 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1596
  0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 159b

llvm / x86:

  Relocation section '.rela__ex_table' at offset 0x343d8 contains 2 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 231a
  0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 231f

gcc / aarch64:

  Relocation section '.rela__ex_table' at offset 0x448c8 contains 10 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000200000105 R_AARCH64_PREL32       0000000000000000 .text + 24bc
  0000000000000004  0000000200000105 R_AARCH64_PREL32       0000000000000000 .text + 2524
  [ ... snip ... ]

llvm / aarch64 Relocation section '.rela__ex_table' at offset 0x37760 contains 10 entries:

      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000000200000105 R_AARCH64_PREL32       0000000000000000 .text + 2730
  0000000000000004  0000000200000105 R_AARCH64_PREL32       0000000000000000 .text + 264c
  [ ... snip ... ]

The objtool/klp-diff.c implications is that
convert_reloc_secsym_to_sym() doesn't handle such non-section symbol
relocs in special sections:

	if (!is_sec_sym(sym))
		return 0;

That early return leaves the reloc pointing at a .L* symbol that is
never cloned into the output livepatch object.  When
clone_special_section() later calls should_keep_special_sym() to decide
whether to include each table entry, it cannot map the reloc to an
included function and silently drops it.  In the __ex_table case above,
the patched function's entries are missing from the .ko.  As far as I
can tell, this problem applies to other special sections (like
.altinstructions, etc.) as well.

If not GCC / GAS is to be supported, then klp-diff will need to handle
this alternate relocation format.  Perhaps these could be pre-converted
in convert_reloc_secsym_to_sym() to the general form (func_sym +
(label_offset - func_offset)) that is expected?  I don't know if that's
enough to keep everything hanging together, but might be a place to
start.

--
Joe

