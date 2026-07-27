Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E0334C3D
	for <live-patching@vger.kernel.org>; Mon, 27 Jul 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161715; cv=none; b=ke8jM0ws+FLjekgHZzdZZrv7RNmOGSJXh/ZXWGhAIy/fdXb+HLguNBTeBxMjHJWb2LIGC5Iwf/4KFDcibZymn/Db+pQy0FgGE4bcnij5AHFpOz4wnakeStDU9QZqMh48OKE1GNbKQxIMspZaaGDx2dES+sUaT8kWBTdRsTfgkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161715; c=relaxed/simple;
	bh=Uyoxg0VngG1eblhnsxq/0sNeZxIxf2r+M6vCgv3jgbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idXSeqg9zIxF57jJDnBgDq2TdnzOxjH09f8gr9cqNWgkH3hwp5J7qqF6spHxTKpWCQkwG9DCqJ6wuPMZJzKojHYihC1h32IopR9kwjSf0gzT5xOMYHJEIaQpwo0jvQfGvi6phtxKkV2MxmS6v6L7eCAaMUqdVYGh0PGlGAQQbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URD8+qSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URD8+qSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EF31F00ACA
	for <live-patching@vger.kernel.org>; Mon, 27 Jul 2026 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161712;
	bh=5bBuDYxkCou9htY5z2TUBhK6y1aRMfiXwIPI1z4yTEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=URD8+qSNLYcweeHJznng7pr9aTMLGBMhwJlzn6jlWFmPuNbfnusc6yOSG2LA7DJAC
	 lnErVx22LuV7p4qKUK830Lr0Wog1gCXBP7FrhX9XfrSH3hTBkwkGS4UiclVn6mB0hE
	 k0kCyH6AcI8LOy1u2769HNFIpkvINIfs4He8TlY6CPO2otOgGq0QEnZgikiJOciuJU
	 Rq/a/k6afB0wR4LZpsJoW0OmPZrID2ik3pOymq46YUdsqaxRK2KMG4koVuZKwbtkr6
	 O+HWwLOCF/M6Qlmkw8iy6dIcGGr2/YA/lkIsWWVS03jcAvJrsYjTzWyzADrbhQj3gD
	 lNeoINe54DB5Q==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69f2c67650aso4266333a12.2
        for <live-patching@vger.kernel.org>; Mon, 27 Jul 2026 07:15:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrbV6ZDgosFcHNGugnm7QXbrvgriDgyZIhTdVJdI3Gr3ghnd62Y1nmimYCG4dSK9gviRj/WJuoqHM5pGwUP@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWANRgcX2P0+6nV3IJXcBIEqrl/PCHXioVkb2sbRz6ATMuN/n
	301xSixiBhFZdwINuyr35rIeT4T8tskVRz6HmMnYxSF5FR77E7Iax3Tg54vhZtBXdLqoW0tSBqF
	5aJDnCCP00HHtsDpArZei95TnG7ROb3M=
X-Received: by 2002:a05:6402:51ca:b0:69f:2c1d:d821 with SMTP id
 4fb4d7f45d1cf-69fc116f808mr3787084a12.35.1785161711450; Mon, 27 Jul 2026
 07:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724114128.31451-1-dongtai.guo@linux.dev>
In-Reply-To: <20260724114128.31451-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 27 Jul 2026 22:15:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7=WxEov9S3TTMxd1GORov-0dtuRWTgFH-B31teXpVNQw@mail.gmail.com>
X-Gm-Features: AUfX_mzFw-Ljy9Z5wQ5sfW9LGBkrPdKlUKDzxIUYfv0QustQ-NnObo9gN15ufjA
Message-ID: <CAAhV-H7=WxEov9S3TTMxd1GORov-0dtuRWTgFH-B31teXpVNQw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] LoongArch: Add livepatch build (KLP) support
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, peterz@infradead.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, kernel@xen0n.name, joe.lawrence@redhat.com, 
	rostedt@goodmis.org, ardb@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, yangtiezhu@loongson.cn, 
	jiaxun.yang@flygoat.com, wangrui@loongson.cn, liukexin@kylinos.cn, 
	guodongtai@kylinos.cn, xry111@xry111.site, wangyuli@aosc.io, 
	loongarch@lists.linux.dev, live-patching@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, George,

On Fri, Jul 24, 2026 at 7:41=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> This series adds LoongArch support for the klp-build livepatch tooling,
> enabling automated livepatch module generation using objtool on
> LoongArch.
>
> It is based on Josh Poimboeuf's klp-build series [1] (see base-commit
> below, unchanged from v1-v3) and extends it with the LoongArch-specific
> objtool and build pieces, plus the toolchain and relocation fixes
> required to make livepatch modules load, generate, and run correctly
> under both GCC and Clang.
>
> Collaboration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Patch 1 ("objtool/LoongArch: Add arch_adjusted_addend() for KLP support")
> and patch 7 ("LoongArch: Add livepatch build (KLP) support") overlap with
> WangYuli's earlier LoongArch KLP work [2]. Both now carry
> Co-developed-by/Signed-off-by: WangYuli.
>
> WangYuli, please check that the attribution is recorded correctly. If you
> consider any other patch in this series to overlap your work, point it ou=
t
> and I will add the tags in the final version.
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
>  - Patches 1-8: the LoongArch objtool hooks, special-section marking
>    (including the inline ALTERNATIVE() replacement), the combined
>    -fPIC / -mno-direct-extern-access build fix, EFI linking, the syscall
>    patching macro, and wiring up LoongArch klp-build.
>  - Patches 9-14: objtool/klp-diff fixes found by running the full
>    klp-build flow under GCC and Clang.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The klp-build integration tests were run on LoongArch under both GCC and
> Clang: cmdline-string, proc-version, data-new, gcc-static-local-var-6,
> syscall, new-globals, new-function, and shadow-newpid. All of them now
> generate a livepatch module, load it, and run.
>
> new-function and shadow-newpid did not build under Clang before this
> version; the new objtool/klp-diff patches fix the Clang-specific
> failures the suite surfaced. Joe Lawrence's test case was also
> reproduced end to end on a Clang-built kernel in a VM (patch load,
> tracepoint toggle, clean unload).
>
> Changes since v3 [3]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - Merged the two build-flag patches (-mno-direct-extern-access and
>    -fPIC) into one. The combined patch is one complete thought: for
>    LoongArch KLP builds, replace the arch's KBUILD_CFLAGS_KERNEL (droppin=
g
>    -fPIE and -mdirect-extern-access) and add -fPIC via KCFLAGS. (Joe
>    Lawrence)
>  - Moved the LoongArch config checks (CONFIG_RELOCATABLE,
>    CONFIG_AS_HAS_EXPLICIT_RELOCS) into validate_config(). (Joe Lawrence)
>  - Patch 4 (EFI): fixed the changelog wording and added the
>    "/* from the EFI stub */" comment on the wildcard, matching arm64 and
>    riscv. (Joe Lawrence)
>  - Patch 6 (syscall macro): pad the line continuations with tabs. (Joe
>    Lawrence)
>  - New patch 12: enable inline ALTERNATIVE() cloning. Joe hit
>    "can't find new instruction" livepatching a function that contains an
>    ALTERNATIVE(). Mark the .subsection 1 replacement with
>    ANNOTATE_DATA_SPECIAL (patch 2) and define ARCH_HAS_INLINE_ALTS for
>    LoongArch objtool (patch 12), mirroring arm64. (Joe Lawrence)
>  - New patch 13: keep the tablejump annotation table entries. klp-diff
>    dropped the table-side word of each .discard.tablejump_annotate pair,
>    which crashed objtool on the patch module.
>  - New patch 14: rewrite PC-relative data references to GOT. File-local
>    static data uses a direct pcalau12i/addi.d pair that cannot reach
>    vmlinux from the far livepatch module; convert it to a GOT-indirect
>    load when the klp relocation is created. This affects GCC and Clang.
>
> On patch 11 (fold paired ADD/SUB relocations): Clang's integrated
> assembler emits the ADD64/SUB64 pair for a "sym - ." whose symbol is
> undefined in the current object, where GAS with -mthin-add-sub emits a
> single R_LARCH_64_PCREL. Reported to LLVM as issue #210052 [4]. The fold
> is kept regardless, since shipping Clang emits the pair.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/lo=
g/?h=3Dklp-build-arm64
> [2] https://lore.kernel.org/loongarch/20251203091039.125259-1-wangyuli@ao=
sc.io/
> [3] https://lore.kernel.org/all/20260707072031.231066-1-dongtai.guo@linux=
.dev/
> [4] https://github.com/llvm/llvm-project/issues/210052
>
> George Guo (14):
>   objtool/LoongArch: Add arch_adjusted_addend() for KLP support
>   LoongArch: Mark special sections for KLP support
>   livepatch/klp-build: use -fPIC and drop direct-extern-access on
>     LoongArch
>   LoongArch: Fix EFI linking with -fdata-sections
>   objtool/klp: Add LoongArch jump opcode bytes support
>   klp-build: Add LoongArch syscall patching macro
>   LoongArch: Add livepatch build (KLP) support
>   LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>   objtool/klp: Convert local label references
>   objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label
>     references
>   objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL
>   objtool/LoongArch: Enable inline alternative cloning for KLP
>   objtool/klp: Keep LoongArch tablejump annotation table entries
>   objtool/klp: Rewrite PC-relative data references to GOT on LoongArch

It is better to reorganize this series like this:

objtool/klp: Convert local label references
objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label references
objtool/klp: Add LoongArch jump opcode bytes support
objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL
objtool/klp: Keep LoongArch tablejump annotation table entries
objtool/klp: Rewrite PC-relative data references to GOT on LoongArch
objtool/LoongArch: Add arch_adjusted_addend() for KLP support
objtool/LoongArch: Enable inline alternative cloning for KLP
klp-build: use -fPIC and drop direct-extern-access on LoongArch
klp-build: Add LoongArch syscall patching macro
LoongArch: Mark special sections for KLP support
LoongArch: Fix EFI linking with -fdata-sections
LoongArch: Add livepatch build (KLP) support
LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Huacai

>
>  arch/loongarch/Kconfig                        |   2 +
>  arch/loongarch/include/asm/alternative-asm.h  |  10 +-
>  arch/loongarch/include/asm/alternative.h      |  11 +-
>  arch/loongarch/include/asm/asm-extable.h      |  10 +-
>  arch/loongarch/include/asm/bug.h              |   1 +
>  arch/loongarch/include/asm/jump_label.h       |   2 +
>  arch/loongarch/kernel/asm-offsets.c           |  18 ++
>  arch/loongarch/kernel/vmlinux.lds.S           |   2 +-
>  include/linux/livepatch_helpers.h             |  22 ++
>  scripts/livepatch/klp-build                   |  43 +++-
>  tools/arch/loongarch/include/asm/inst.h       |  11 +
>  tools/objtool/Makefile                        |   3 +-
>  tools/objtool/arch/loongarch/decode.c         | 212 ++++++++++++++++++
>  .../objtool/arch/loongarch/include/arch/elf.h |  35 +++
>  tools/objtool/klp-diff.c                      | 105 ++++++++-
>  15 files changed, 473 insertions(+), 14 deletions(-)
>
>
> base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
> --
> 2.53.0
>
