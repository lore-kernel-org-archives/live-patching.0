Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2B3FAE0A
	for <live-patching@vger.kernel.org>; Wed,  8 Jul 2026 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549980; cv=none; b=AgAk1KjyqM+jRTRrjkL2MCGVWlQ6ki+48i3adi74hxYQN7Iun1RH90bho1vUYkKxpn8IZwJY/KkB6pN2qnmrWHfs6lKhQU85kBGE7EWIAIFSJ+rQ0DbdQemMm1Jn0rPupIS1HTTjC4OcO391X4phBIRP7vYgAX+vU+CUP/twGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549980; c=relaxed/simple;
	bh=swODgbekQmS1CFeZ9iG/ZEs5COm4cAVix6GliQDtetY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRzkqIWziVdhMwK4/EHd0VAfHlhuwMcbzav05Zrzt6RqS80koFYQLpCymqYI6ha1xIGGiZ1Iz24v0faKuv2z3Qb8431DAB++bzgBxKpd4Y3jyzwlPvXwL+4+uqJRBJZtP45e/OjyA5c84KBRwGmixOolI4xqCweaHDc7As7UQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+ZNi+Rh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+ZNi+Rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783549977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/T4EWXW79x7TDZV95U66XrCatSBiUQKKPW4UkScdA4=;
	b=L+ZNi+RhEZILNzxGv0+5bseuEFTVO0rHXajtEtweKSg2At8o026khmRDBouh4pLPZ51ho7
	ISPYAeRf2LGUsAVP63suC1uDHJGUeUetmICK2RFUuaZrYuEO8AkYxweX766G/6xOTA35w9
	29DIf4JB/0XnmXprZZVvHMdlh82t2Fo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-c4VGxBctPoqaxYYIYg0UGQ-1; Wed,
 08 Jul 2026 18:32:51 -0400
X-MC-Unique: c4VGxBctPoqaxYYIYg0UGQ-1
X-Mimecast-MFC-AGG-ID: c4VGxBctPoqaxYYIYg0UGQ_1783549969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA54F1956041;
	Wed,  8 Jul 2026 22:32:46 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.46])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C1BA1800592;
	Wed,  8 Jul 2026 22:32:40 +0000 (UTC)
Date: Wed, 8 Jul 2026 18:32:37 -0400
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
Subject: Re: [PATCH v3 02/12] LoongArch: Mark special sections for KLP support
Message-ID: <ak7QBSm3mmDlB-4u@redhat.com>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
 <20260707072031.231066-3-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707072031.231066-3-dongtai.guo@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jul 07, 2026 at 03:20:21PM +0800, George Guo wrote:
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
>  arch/loongarch/include/asm/alternative-asm.h |  5 +++--
>  arch/loongarch/include/asm/alternative.h     |  6 ++++--
>  arch/loongarch/include/asm/asm-extable.h     | 10 ++++++++--
>  arch/loongarch/include/asm/bug.h             |  1 +
>  arch/loongarch/include/asm/jump_label.h      |  2 ++
>  arch/loongarch/kernel/asm-offsets.c          | 20 ++++++++++++++++++++
>  6 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/alternative-asm.h b/arch/loongarch/include/asm/alternative-asm.h
> index 7dc29bd9b2f0..d940d9d2c0e1 100644
> --- a/arch/loongarch/include/asm/alternative-asm.h
> +++ b/arch/loongarch/include/asm/alternative-asm.h
> @@ -5,6 +5,7 @@
>  #ifdef __ASSEMBLER__
>  
>  #include <asm/asm.h>
> +#include <generated/asm-offsets.h>
>  
>  /*
>   * Issue one struct alt_instr descriptor entry (need to put it into
> @@ -33,7 +34,7 @@
>  	.fill - (((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)) / 4, 4, 0x03400000
>  142 :
>  
> -	.pushsection .altinstructions, "a"
> +	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
>  	altinstruction_entry 140b, 143f, \feature, 142b-140b, 144f-143f
>  	.popsection
>  
> @@ -63,7 +64,7 @@
>  		(alt_max_short(new_len1, new_len2) - (old_len)) / 4, 4, 0x03400000
>  142 :
>  
> -	.pushsection .altinstructions, "a"
> +	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
>  	altinstruction_entry 140b, 143f, \feature1, 142b-140b, 144f-143f, 142b-141b
>  	altinstruction_entry 140b, 144f, \feature2, 142b-140b, 145f-144f, 142b-141b
>  	.popsection
> diff --git a/arch/loongarch/include/asm/alternative.h b/arch/loongarch/include/asm/alternative.h
> index b5bae21fb3c8..8f7712ed2f4e 100644
> --- a/arch/loongarch/include/asm/alternative.h
> +++ b/arch/loongarch/include/asm/alternative.h
> @@ -70,7 +70,8 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
>  /* alternative assembly primitive: */
>  #define ALTERNATIVE(oldinstr, newinstr, feature)			\
>  	OLDINSTR(oldinstr, 1)						\
> -	".pushsection .altinstructions,\"a\"\n"				\
> +	".pushsection .altinstructions, \"aM\", @progbits, "            \
> +		 __stringify(ALT_INSTR_SIZE) "\n"                       \
>  	ALTINSTR_ENTRY(feature, 1)					\
>  	".popsection\n"							\
>  	".subsection 1\n" \
> @@ -79,7 +80,8 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
>  
>  #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
>  	OLDINSTR_2(oldinstr, 1, 2)					\
> -	".pushsection .altinstructions,\"a\"\n"				\
> +	".pushsection .altinstructions, \"aM\", @progbits, "            \
> +			__stringify(ALT_INSTR_SIZE) "\n"                \
>  	ALTINSTR_ENTRY(feature1, 1)					\
>  	ALTINSTR_ENTRY(feature2, 2)					\
>  	".popsection\n"							\
> diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
> index d60bdf2e6377..2d7eef7c0b39 100644
> --- a/arch/loongarch/include/asm/asm-extable.h
> +++ b/arch/loongarch/include/asm/asm-extable.h
> @@ -7,10 +7,15 @@
>  #define EX_TYPE_UACCESS_ERR_ZERO	2
>  #define EX_TYPE_BPF			3
>  
> +#ifndef COMPILE_OFFSETS
> +#include <asm/asm-offsets.h>
> +#endif
> +
>  #ifdef __ASSEMBLER__
>  
>  #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
> -	.pushsection	__ex_table, "a";		\
> +	.pushsection    __ex_table, "aM", @progbits,    \
> +			EXTABLE_SIZE;                   \
>  	.balign		4;				\
>  	.long		((insn) - .);			\
>  	.long		((fixup) - .);			\
> @@ -29,7 +34,8 @@
>  #include <asm/gpr-num.h>
>  
>  #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
> -	".pushsection	__ex_table, \"a\"\n"		\
> +	".pushsection   __ex_table, \"aM\", @progbits, "\
> +	 __stringify(EXTABLE_SIZE) "\n"                 \
>  	".balign	4\n"				\
>  	".long		((" insn ") - .)\n"		\
>  	".long		((" fixup ") - .)\n"		\
> diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
> index d090a5bec5eb..14e3acbaad8d 100644
> --- a/arch/loongarch/include/asm/bug.h
> +++ b/arch/loongarch/include/asm/bug.h
> @@ -25,6 +25,7 @@
>  #define __BUG_ENTRY(cond_str, flags)				\
>  		.pushsection __bug_table, "aw";			\
>  		.align 2;					\
> +		__ANNOTATE_DATA_SPECIAL;				\
>  	10000:	.long 10001f - .;				\
>  		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
>  		.short flags;					\
> diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
> index 7ef4ae3abf08..d20f0fa24b6b 100644
> --- a/arch/loongarch/include/asm/jump_label.h
> +++ b/arch/loongarch/include/asm/jump_label.h
> @@ -12,6 +12,7 @@
>  #include <linux/types.h>
>  #include <linux/stringify.h>
>  #include <asm/asm.h>
> +#include <linux/objtool.h>
>  
>  #define HAVE_JUMP_LABEL_BATCH
>  
> @@ -27,6 +28,7 @@
>  #define JUMP_TABLE_ENTRY(key, label)			\
>  	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
>  	 ".align	" __stringify(PTRLOG) "	\n\t"	\
> +	 ANNOTATE_DATA_SPECIAL "\n\t"			\
>  	 ".long		1b - ., " label " - .	\n\t"	\
>  	 JUMP_LABEL_TYPE  key " - .		\n\t"	\
>  	 ".popsection				\n\t"
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> index 2cc953f113ac..470323aa022c 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -18,6 +18,8 @@
>  #include <asm/ftrace.h>
>  #include <asm/sigframe.h>
>  #include <vdso/datapage.h>
> +#include <asm/alternative.h>
> +#include <asm/extable.h>
>  
>  static void __used output_ptreg_defines(void)
>  {
> @@ -323,3 +325,21 @@ static void __used output_vdso_defines(void)
>  	DEFINE(__VDSO_PAGES, VDSO_NR_PAGES);
>  	BLANK();
>  }
> +
> +static void __used output_extable_defines(void)
> +{
> +	COMMENT("LoongArch exception table entry offsets.");
> +
> +	DEFINE(EXTABLE_SIZE, sizeof(struct exception_table_entry));
> +	BLANK();
> +}
> +
> +static void __used output_alt_instr_defines(void)
> +{
> +	COMMENT("LoongArch alternative instructions offsets.");
> +
> +	DEFINE(ALT_INSTR_SIZE, sizeof(struct alt_instr));
> +	BLANK();
> +}
> +
> +
> -- 
> 2.25.1
> 

Hello George,

I've run into another test case while exercising v3 on LoongArch (Clang
build).I
       a
Setup
=====

Maybe my config was too small, but I couldn't find any existing vmlinux
.c file that emits .altinstructions on LoongArch, all in-tree
ALTERNATIVE() sites are in arch/loongarch/lib/*.S, which we can't modify
with klp-build.

I added a minimal dummy function to arch/loongarch/kernel/alternative.c
so I could test:

  $ cat base-vmlinux.patch
  diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kernel/alternative.c
  index 0e0c766df1e3..01d81db79b3f 100644
  --- a/arch/loongarch/kernel/alternative.c
  +++ b/arch/loongarch/kernel/alternative.c
  @@ -3,6 +3,7 @@
   #include <linux/mm.h>
   #include <linux/module.h>
   #include <asm/alternative.h>
  +#include <asm/cpu.h>
   #include <asm/cacheflush.h>
   #include <asm/inst.h>
   #include <asm/sections.h>
  @@ -245,3 +246,15 @@ void __init alternative_instructions(void)
   
          alternatives_patched = 1;
   }
  +
  +/*
  + * klp-build repro hook: vmlinux .c function with ALTERNATIVE().
  + */I
  +staatic int klp_build_alt_test_base = 10;
  +
  +static noinline int __used klp_build_alt_test_compute(int input)
  +{
  +       asm volatile(ALTERNATIVE("nop", "nop", CPU_FEATURE_FPU) : : : "memory");
  +
  +       return input + klp_build_alt_test_base;
  +}

Then a one-line klp-build patch to modify the function:

  $ cat test-alternatives.patch
  diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kernel/alternative.c
  index 01d81db79b3f..f5d5c4f0d8ef 100644
  --- a/arch/loongarch/kernel/alternative.c
  +++ b/arch/loongarch/kernel/alternative.c
  @@ -256,5 +256,5 @@ static noinline int __used klp_build_alt_test_compute(int input)
   {
          asm volatile(ALTERNATIVE("nop", "nop", CPU_FEATURE_FPU) : : : "memory");
   
  -       return input + klp_build_alt_test_base;
  +       return input + klp_build_alt_test_base + 1;

Repro
=====

Build the kernel as usual, then klp-build the test-alternatives.patch:

  $ patch -p1 < base-vmlinux.patch
  patching file arch/loongarch/kernel/alternative.c
  $ ARCH=loongarch LLVM=1 make -j$(nproc)
  ...
  $ ARCH=loongarch LLVM=1 ./sIcripts/livepatch/klp-build -T test-alternatives.patch
                             a
Result
======

klp-build gets through the diff step, then fails linking the livepatch
module:

  ...
  Diffing objects
  vmlinux.o: changed function: klp_build_alt_test_compute
  Building patch module: livepatch-test-alternatives.ko
  livepatch-test-alternatives.o: error: objtool: .text.klp_build_alt_test_compute+0x14: special: can't find new instruction
  make[3]: *** [/home/jolawren/src/linux/scripts/Makefile.build:507: livepatch-test-alternatives.o] Error 255
  make[3]: *** Deleting file 'livepatch-test-alternatives.o'
  make[2]: *** [/home/jolawren/src/linux/Makefile:2141: .] Error 2
  make[1]: *** [/home/jolawren/src/linux/Makefile:248: __sub-make] Error 2
  make: *** [Makefile:248: __sub-make] Error 2
  error: klp-build: line 964: '"${cmd[@]}" > >(tee -a "$log") 2> >(tee -a "$log" 1>&2)'

Should v3 (or a follow-up patch) include the inline alternative
cloning support?  Or is patching functions that contain ALTERNATIVE()
intentionally out of scope for LoongArch KLP for now?

If the latter, it would be worth calling out explicitly as this patch
reads as though .altinstructions is supported end-to-end. 

Regards,
--
Joe

