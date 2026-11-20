Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795209897;
	b=ldq68HQLwSIG0dg0nsdmrxlPxlBu2nyywWjeI0CsBoa1i04y/j6TZYFQ0O3gyDehkD1X
	 4xZiHazOai3Chj5TaITvfLa4xmHW/PlEqWGRuXCz2rDUIDHObbTA+/6n+HaTuHK5WIgT8
	 UO+e9/rVg2DWIEdYSGeYyDnTn1hHTxXAncq31cnwlBTycg9OvxNEzCU48hoNB1nwPB3GM
	 4nYBgIDAjqtWzVCEl5LJYNyZWjgFNngZLPptzDgaz2Qors0AWTm+uTWUMIhQrkGaM1kAC
	 25N5PNWboux+q/wPGNHysvZOKZ6vSRF4pJYs8exu+8kRkCJS4cteghT8dH6y9mSPcoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bITuzVEfmK2u8ql0xrA72ELRr2YY5Eit7w0sg9Y24hY=;
	b=U+jECaV6Dt003oi89mBf5bR7rh4ndj94s2WMwesbcWxNteWNRjKjWBWaHwQ2J1k4xv6S
	 J3hRyKro6Vq/s1RRlhxq0boWGKh+0aJzmjNH8KLHc0DBTW4zzKyw9S59XGYcuWsCYpRyf
	 Dj9yji4EtNro1esFflrMTCdBqLzo2PIuvcvZ8WNWWV3RnbBSBuOoXlM5rc2d4xK3HfuR8
	 u5Ov6JcqQrW3Xbh66YT/c7wiRvnUUou5Y4bmD+E4ThypXUBSl5JwyfQDOAkYvB9N/kL4k
	 aI3Gdf2zZQyUQha3Hp/lObyxs71jmvRNq4wO+A2SqAPZgZoEn1At+OuJYrucw2n3CGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="E/40exfq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E8606A6B7
	for <live-patching@vger.kernel.org>; Fri, 20 Nov 2026 21:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80E8606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E/40exfq
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-99071945aa7so782045241.3
        for <live-patching@vger.kernel.org>; Fri, 20 Nov 2026 13:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795209893; cv=none;
        d=google.com; s=arc-20260327;
        b=GrIMA4wk/mXECBvoQ/VGKHoMCnQXdQOzFEGf82nVhveRP7tho+/lmMkBTVb0bs8kpC
         7JYm+BtKFaE01UVuruaX7w2Tr4EAA8zZ111xeYrJsWKVTB4KtBujbNowuhWme5yFHXiN
         +LcqQBJt0gj7nYxQNT3+ZarzojWUtDH3EJH6fIi4QumKX7THbcDYnZYKeUhBuclebfyA
         W7c32McJIBprUi8vjdrmQEMHyE/664B6d1oGAjIRAt/obyE55BaVgSKTj18hlvg8XIQl
         Eo2O+yUHNFCfcVXaY7UjKxwNgQR5XX6j6XtWUeDNrDURo1cNQIl0pucZd4CL1r6ZEs1U
         Zd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bITuzVEfmK2u8ql0xrA72ELRr2YY5Eit7w0sg9Y24hY=;
        fh=DLsqIcN9K1gkJ80N6A9GkpoaG5QeGH8B62sF8F4rojU=;
        b=D/lmUGEs5iIUCOid34fcnV3fKf2Ose5ODaFOAuqy/QJmRlyHlA/1TmzQrFaBTHKbFb
         mUHb4mSvYMxR9vty/gtPi7tzQssTu6mJLb4ykGQ8TPE1ilXj8eF/sPs9EqKJmy8y6taR
         fcyIlzlktp0e/YH91NhMc3kzbMVoZcgLIU80HlVWHdOJXhGk0Be3JO+rihiRpVU6abCT
         AIdQBR9Lz8hdz5dt5xIkVrb4pVj8cnq4YGOL8GYszMfrXari7Mh5RJVp7IJpKpQ6n71r
         44lyibqIwo7kcPYjOp0niW6Jkejo0Dhq60wPvPkrGDKKY5yfeFWpEL+lVlJnOS0sjnA8
         JaUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795209893; x=1795814693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bITuzVEfmK2u8ql0xrA72ELRr2YY5Eit7w0sg9Y24hY=;
        b=E/40exfqtM+dThAPB+qlxLIEYF/AnZPRFWd69sTeq2lJPxrBNUTo4c7rAMf/88sbrN
         2iTp5bZeyfHqIoUL3+dh091zwJqekWGZQfKRNS8APaO61TMZ8lWZn73rFe3cEprFMTuJ
         ko5lkrBW2jQf1Ulqmq5ZyS99zm5berzXY/i6q9+2I1GBpvtlntnQdbIpKYlIa6E2PSAZ
         6cjcXHoG4Bf3MLgnFTzl8HkWXW+c9Tt2PniOHS+qkE97/f/mBtMPIx1DClV/6F0Gy9Hr
         aKd5TBXFk/UlY/cxPRKThJIX7IO8pOWeLrumn2vnZL+FwmttEEEVskWDD2FOfwEDDZXb
         1nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795209893; x=1795814693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bITuzVEfmK2u8ql0xrA72ELRr2YY5Eit7w0sg9Y24hY=;
        b=JzZ36GEPgoGSCP/UVmcPldqU3SmUjuQDzuKZ/P5syj5oRChlVS9O2VqdkloeJfTqc4
         Bxd3P+X9eN7aQJxfONc1/Mn19X6oExjrmQ2lorRMIb+A8fEDWgoH3uHajaG+mXUYyNle
         G7XB3hjeneIY2nzf+9dtH5iweE/sJz12QPaJPJVg4ISregl/ZqrqDFyfE/vcd9S3wxsj
         nT8Dv5ilGIytwbwlIis4Mcl2qlmKeYldEXAIDmI5Fbx0KowyC5G81NpAJnn/GYPmyceS
         DnLuiYnknZ4x15bnVszpC9vxlvjykzR1G20WS2XMEMFKq/5x6Cx1vmyyCyZrHRY4kyw5
         WA1w==
X-Forwarded-Encrypted: i=1; AL+hErFf7NaIgk5xKVOIo1U9zBiEYINKs1CrJexCqlhiGbzn15uvuC8g9igVKSJ4HdGIQvxuDwjwfgVP8ZmP0RYb@vger.kernel.org
X-Gm-Message-State: APuU4Z8sgShZeGgBXIknbuQBkDo9COzxAIbjdbZf6bRN2i5/9QckHGQe
	XSlYmM75eptv21uFLxdmG4aLrVEiNN1tEkeCW9Z3nDxUq1JK0qE6ACJ+OZ33dUWyzgN8D/LD9Kj
	sIoO9GOu7qqh/cNM1v7M54lW7ksJqOjBOoiUuVMw2
X-Gm-Gg: AZFdTZe6zkv+GA0KH7TuZMoN2jHgKsG8jrH9tnlM4xDkQFSErg4Nbu9FL48tOQKWh/Z
	BwfSxM6PbFIXe+YAMaWJz78UZuF3fuXijBbaIzSeQs6seJ0ZdqNSLNZRlclYP1l3Vdhqkgpc/8F
	gKbNrmZul5wryDYJ0D5Yls/nXz/7JKoRtpc/7AUtGVSzKnmdWksWeQM2Fuabj1SLVxWzE7MvAdQ
	LdbzfGlCkEMI+Gq90BEu4+D9Ev/TxSzWh+sClYtjIjONiEwe/TAF0uwAFLKpZWRD5oDi5ePlzSR
	+c3TsPrYb9zCy4D5z4yYVf8V+NSHzwITACUR+ChQfk2K6Wy7X3uPTszLtRL8/ek/mS6wzdA3hHj
	7VNURpvxbcFBVL9MWCkXyRWt8itlPfGvRdreo
X-Received: by 2002:a05:6102:374c:b0:7d2:8dd6:e2c2 with SMTP id
 ada2fe7eead31-7d73963c573mr2445359137.29.1795209892946; Fri, 20 Nov 2026
 13:24:52 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <73024f3fce343bd6fba3d08fa366a61b4e2c0fa1.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <73024f3fce343bd6fba3d08fa366a61b4e2c0fa1.1786230311.git.jpoimboe@kernel.org>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 20 Nov 2026 13:24:42 -0800
X-Gm-Features: Aa3M54q00e7eFLXrWdso2Zy4lofaH4uwGilO3mLmdcGkjW-Fq6HTshHMHcZHXiQ
Message-ID: <CADBMgpx9TZ6P5KVWc=emKbT5zfv6psB-woLW6dnwh2XcwPDg5g@mail.gmail.com>
Subject: Re: [PATCH v4 20/22] objtool/klp: Introduce objtool for arm64
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sat, Aug 8, 2026 at 4:21=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Add basic support for arm64 on objtool.  Only "objtool klp" subcommands
> are currently supported.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/arm64/Kconfig                            |   2 +
>  tools/objtool/Makefile                        |   4 +
>  tools/objtool/arch/arm64/Build                |   2 +
>  tools/objtool/arch/arm64/decode.c             | 177 ++++++++++++++++++
>  .../arch/arm64/include/arch/cfi_regs.h        |  11 ++
>  tools/objtool/arch/arm64/include/arch/elf.h   |  15 ++
>  .../objtool/arch/arm64/include/arch/special.h |  21 +++
>  tools/objtool/arch/arm64/special.c            |  30 +++
>  8 files changed, 262 insertions(+)
>  create mode 100644 tools/objtool/arch/arm64/Build
>  create mode 100644 tools/objtool/arch/arm64/decode.c
>  create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
>  create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
>  create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
>  create mode 100644 tools/objtool/arch/arm64/special.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 11e733b6a3cf3..06b30924509ac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -209,9 +209,11 @@ config ARM64
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IOREMAP_PROT
>         select HAVE_IRQ_TIME_ACCOUNTING
> +       select HAVE_KLP_BUILD
>         select HAVE_LIVEPATCH
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
> +       select HAVE_OBJTOOL
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
>         select HAVE_PERF_REGS
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index a4484fd22a96d..94aabeee97367 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -11,6 +11,10 @@ ifeq ($(SRCARCH),loongarch)
>         BUILD_ORC          :=3D y
>  endif
>
> +ifeq ($(SRCARCH),arm64)
> +       ARCH_HAS_KLP :=3D y
> +endif
> +
>  ifeq ($(ARCH_HAS_KLP),y)
>         HAVE_XXHASH =3D $(shell printf "$(pound)include <xxhash.h>\nXXH3_=
state_t *state;int main() {}" | \
>                       $(HOSTCC) $(HOSTCFLAGS) -xc - -o /dev/null -lxxhash=
 2> /dev/null && echo y || echo n)
> diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Bu=
ild
> new file mode 100644
> index 0000000000000..d24d5636a5b84
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/Build
> @@ -0,0 +1,2 @@
> +objtool-y +=3D decode.o
> +objtool-y +=3D special.o
> diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64=
/decode.c
> new file mode 100644
> index 0000000000000..47658c76e1af0
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/decode.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <objtool/check.h>
> +#include <objtool/disas.h>
> +#include <objtool/elf.h>
> +#include <objtool/arch.h>
> +#include <objtool/warn.h>
> +#include <objtool/builtin.h>
> +
> +const char *arch_reg_name[CFI_NUM_REGS] =3D {};
> +
> +int arch_ftrace_match(const char *name)
> +{
> +       return 0;
> +}
> +
> +s64 arch_insn_adjusted_addend(struct instruction *insn, struct reloc *re=
loc)
> +{
> +       return reloc_addend(reloc);
> +}
> +
> +bool arch_callee_saved_reg(unsigned char reg)
> +{
> +       return false;
> +}
> +
> +int arch_decode_hint_reg(u8 sp_reg, int *base)
> +{
> +       exit(-1);
> +}
> +
> +const char *arch_nop_insn(int len)
> +{
> +       exit(-1);
> +}
> +
> +const char *arch_ret_insn(int len)
> +{
> +       exit(-1);
> +}
> +
> +int arch_decode_instruction(struct objtool_file *file, const struct sect=
ion *sec,
> +                           unsigned long offset, unsigned int maxlen,
> +                           struct instruction *insn)
> +{
> +       u32 ins;
> +
> +       if (maxlen < 4) {
> +               ERROR_INSN(insn, "can't decode instruction");
> +               return -1;
> +       }
> +
> +       /* arm64 instructions are always LE, thus no bswap_if_needed() */
> +       ins =3D le32toh(*(u32 *)(sec->data->d_buf + offset));
> +
> +       /*
> +        * These are the bare minimum needed for static branch detection =
and
> +        * checksum calculations.
> +        */
> +       if (ins =3D=3D 0xd503201f) {
> +               /* NOP: static branch */
> +               insn->type =3D INSN_NOP;
> +       } else if ((ins & 0xfc000000) =3D=3D 0x14000000) {
> +               /* B: static branch, intra-TU sibling call */
> +               insn->type =3D INSN_JUMP_UNCONDITIONAL;
> +               insn->immediate =3D sign_extend64(ins & 0x03ffffff, 25);
> +       } else if ((ins & 0xfc000000) =3D=3D 0x94000000) {
> +               /* BL: intra-TU call */
> +               insn->type =3D INSN_CALL;
> +               insn->immediate =3D sign_extend64(ins & 0x03ffffff, 25);
> +       } else if ((ins & 0xff000000) =3D=3D 0x54000000) {
> +               /* B.cond: intra-TU sibling call */
> +               insn->type =3D INSN_JUMP_CONDITIONAL;
> +               insn->immediate =3D sign_extend64((ins >> 5) & 0x7ffff, 1=
8);
> +       } else if ((ins & 0x7e000000) =3D=3D 0x34000000) {
> +               /* CBZ/CBNZ: intra-TU sibling call */
> +               insn->type =3D INSN_JUMP_CONDITIONAL;
> +               insn->immediate =3D sign_extend64((ins >> 5) & 0x7ffff, 1=
8);
> +       } else if ((ins & 0x7e000000) =3D=3D 0x36000000) {
> +               /* TBZ/TBNZ: intra-TU sibling call */
> +               insn->type =3D INSN_JUMP_CONDITIONAL;
> +               insn->immediate =3D sign_extend64((ins >> 5) & 0x3fff, 13=
);
> +       } else {
> +               insn->type =3D INSN_OTHER;
> +       }
> +
> +       insn->len =3D 4;
> +       return 0;
> +}
> +
> +size_t arch_jump_opcode_bytes(struct objtool_file *file, struct instruct=
ion *insn,
> +                             unsigned char *buf)
> +{
> +       u32 ins;
> +
> +       ins =3D le32toh(*(u32 *)(insn->sec->data->d_buf + insn->offset));
> +
> +       switch (insn->type) {
> +       case INSN_JUMP_UNCONDITIONAL:
> +       case INSN_CALL:
> +               ins &=3D ~0x03ffffff;
> +               break;
> +       case INSN_JUMP_CONDITIONAL:
> +               if ((ins & 0xff000000) =3D=3D 0x54000000)
> +                       ins &=3D ~0x00ffffe0;                /* B.cond */
> +               else if ((ins & 0x7e000000) =3D=3D 0x34000000)
> +                       ins &=3D ~0x00ffffe0;                /* CBZ/CBNZ =
*/
> +               else
> +                       ins &=3D ~0x0007ffe0;                /* TBZ/TBNZ =
*/
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       ins =3D htole32(ins);
> +       memcpy(buf, &ins, 4);
> +       return 4;
> +}
> +
> +u64 arch_adjusted_addend(struct reloc *reloc)
> +{
> +       return reloc_addend(reloc);
> +}
> +
> +unsigned long arch_jump_destination(struct instruction *insn)
> +{
> +       return insn->offset + (insn->immediate << 2);
> +}
> +
> +bool arch_pc_relative_reloc(struct reloc *reloc)
> +{
> +       switch (reloc_type(reloc)) {
> +       case R_AARCH64_PREL64:
> +       case R_AARCH64_PREL32:
> +       case R_AARCH64_PREL16:
> +       case R_AARCH64_LD_PREL_LO19:
> +       case R_AARCH64_ADR_PREL_LO21:
> +       case R_AARCH64_ADR_PREL_PG_HI21:
> +       case R_AARCH64_ADR_PREL_PG_HI21_NC:
> +       case R_AARCH64_JUMP26:
> +       case R_AARCH64_CALL26:
> +       case R_AARCH64_CONDBR19:
> +       case R_AARCH64_TSTBR14:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +void arch_initial_func_cfi_state(struct cfi_init_state *state)
> +{
> +       state->cfa.base =3D CFI_UNDEFINED;
> +}
> +
> +unsigned int arch_reloc_size(struct reloc *reloc)
> +{
> +       switch (reloc_type(reloc)) {
> +       case R_AARCH64_ABS64:
> +       case R_AARCH64_PREL64:
> +               return 8;
> +       case R_AARCH64_PREL16:
> +               return 2;
> +       default:
> +               return 4;
> +       }
> +}
> +
> +#ifdef DISAS
> +int arch_disas_info_init(struct disassemble_info *dinfo)
> +{
> +       return disas_info_init(dinfo, bfd_arch_aarch64,
> +                              bfd_mach_arm_unknown, bfd_mach_aarch64,
> +                              NULL);
> +}
> +#endif /* DISAS */
> diff --git a/tools/objtool/arch/arm64/include/arch/cfi_regs.h b/tools/obj=
tool/arch/arm64/include/arch/cfi_regs.h
> new file mode 100644
> index 0000000000000..49c81cbb6646d
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _OBJTOOL_ARCH_CFI_REGS_H
> +#define _OBJTOOL_ARCH_CFI_REGS_H
> +
> +/* These aren't actually used for arm64 */
> +#define CFI_BP 0
> +#define CFI_SP 0
> +#define CFI_RA 0
> +#define CFI_NUM_REGS 2
> +
> +#endif /* _OBJTOOL_ARCH_CFI_REGS_H */
> diff --git a/tools/objtool/arch/arm64/include/arch/elf.h b/tools/objtool/=
arch/arm64/include/arch/elf.h
> new file mode 100644
> index 0000000000000..418b90885c501
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/arch/elf.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _OBJTOOL_ARCH_ELF_H
> +#define _OBJTOOL_ARCH_ELF_H
> +
> +#define R_NONE         R_AARCH64_NONE
> +#define R_ABS64                R_AARCH64_ABS64
> +#define R_ABS32                R_AARCH64_ABS32
> +#define R_DATA32       R_AARCH64_PREL32
> +#define R_DATA64       R_AARCH64_PREL64
> +#define R_TEXT32       R_AARCH64_PREL32
> +#define R_TEXT64       R_AARCH64_PREL64
> +
> +#define ARCH_HAS_INLINE_ALTS 1
> +
> +#endif /* _OBJTOOL_ARCH_ELF_H */
> diff --git a/tools/objtool/arch/arm64/include/arch/special.h b/tools/objt=
ool/arch/arm64/include/arch/special.h
> new file mode 100644
> index 0000000000000..8ae804a83ea49
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/arch/special.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _OBJTOOL_ARCH_SPECIAL_H
> +#define _OBJTOOL_ARCH_SPECIAL_H
> +
> +#define EX_ENTRY_SIZE 12
> +#define EX_ORIG_OFFSET 0
> +#define EX_NEW_OFFSET 4
> +
> +#define JUMP_ENTRY_SIZE 16
> +#define JUMP_ORIG_OFFSET 0
> +#define JUMP_NEW_OFFSET 4
> +#define JUMP_KEY_OFFSET 8
> +
> +#define ALT_ENTRY_SIZE 12
> +#define ALT_ORIG_OFFSET 0
> +#define ALT_NEW_OFFSET 4
> +#define ALT_FEATURE_OFFSET 8
> +#define ALT_ORIG_LEN_OFFSET 10
> +#define ALT_NEW_LEN_OFFSET 11
> +
> +#endif /* _OBJTOOL_ARCH_SPECIAL_H */
> diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm6=
4/special.c
> new file mode 100644
> index 0000000000000..5a6424a59e1c5
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/special.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <objtool/special.h>
> +
> +/*
> + * On arm64 a zero-length replacement means the alternative has a callba=
ck,
> + * whose address is stored in the replacement offset.  It must be preser=
ved.
> + */
> +bool arch_alt_ignore_new_reloc(struct section *sec, unsigned long offset=
)
> +{
> +       return false;
> +}
> +
> +bool arch_support_alt_relocation(struct special_alt *special_alt,
> +                                struct instruction *insn,
> +                                struct reloc *reloc)
> +{
> +       return true;
> +}
> +
> +struct reloc *arch_find_switch_table(struct objtool_file *file,
> +                                    struct instruction *insn,
> +                                    unsigned long *table_size)
> +{
> +       return NULL;
> +}
> +
> +const char *arch_cpu_feature_name(int feature_number)
> +{
> +       return NULL;
> +}
> --
> 2.54.0
>
>

Flagging an issue I'm seeing, in case you haven't encountered it yet:
applying this patch to v7.4-rc3 (with the new objtool klp unit tests)
I'm getting a failure building with LLVM:

$ make -C tools/objtool ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- LLV=
M=3D1 tests
make: Entering directory
'/usr/local/google/home/dylanbhatch/worktrees/arm64-clang/tools/objtool'
make[1]: Entering directory
'/usr/local/google/home/dylanbhatch/worktrees/arm64-clang/tools/lib/subcmd'
make[1]: Leaving directory
'/usr/local/google/home/dylanbhatch/worktrees/arm64-clang/tools/lib/subcmd'
make[1]: Entering directory
'/usr/local/google/home/dylanbhatch/worktrees/arm64-clang/tools/objtool'
make[1]: Leaving directory
'/usr/local/google/home/dylanbhatch/worktrees/arm64-clang/tools/objtool'
TAP version 13
# preflight
#   objtool   /usr/local/google/home/dylanbhatch/worktrees/arm64-clang/tool=
s/objtool/objtool
(klp: yes)
#   compiler  Debian clang version 21.1.8 (3)
#   arch      arm64  (host x86, cross)
#   tmpdir    /tmp  (each test builds in a fresh directory here)
# not run: 6 tests in x86/ (this run is arm64)
1..46
                                                            not ok -
test-abs-and-addressable: abs_and_addressable.c does not build: 1
error generated.
...

I haven't been able to dig into it too closely, but my AI tool is
suggesting adding -mcmodel=3Dlarge for llvm, or putting '.set abs_sym,
0x1234' in a separate object and using partial_link.

Thanks,
Dyaln
