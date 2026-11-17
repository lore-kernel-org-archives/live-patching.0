Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881213;
	b=4MLg6CoN4TAN4CPWFfJP68hQlE5MzRfskfzxb5YyImdi9Pc7rTW/fBF6W1BUzpAuAeZE
	 FaB/PpMDS7cpT9gnwYc+OwU6drzpZHDewMir08a4TJ/oKj3yIxzI2S7r0FXM82tn4i0xY
	 6OHqWijm8cv94OzF3Akfw+MeIlp8FTkVGS+UJXwiPI7+UaSjMcEMUhCPNO83RqGtHn3AD
	 I4TLkAAjIvx2wPyLYg8XlByt6VCQ6/oX/mmeeui+Mn7lpAWGsOto0+sOUNamEZLUr99kZ
	 LVkAm2IG/44KGfDgUtTYFLO5b2SmG34hvRDoxk1o5Y7tVIGL95XgUhsiKKRSwaiDhYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3EMWJDhBBek59xKnIdxxZDsZ4a9Lk1PMfcEjUKx7BtQ=;
	b=WhXiheAFRiELMiaZfiYp68SR0LmqI4Knc1o7woiFZ1yKxlXW5EQYokzydQX5pscnsX4d
	 XLw02/RPHS+GZc1pd8UOOAFZW5ItEVXcpcGMlOU8HWPfbptUB8rAryvEX6pkGD/BFS2I6
	 uiDayxiTtTqRIsW8DdpV0LSl6uSLy5bzucOBroMQXRB9tgmZfqoT/n3vHTkZDPSj2xgwB
	 dMhcKSfqcJluDzzwfIY5awm741eiubZctEqiegyJaWxFVtIqQ1EnlQVndQmDlwv71871t
	 gOUekTVYE8eBP4Vv39623wDo9IrrjH+Bu8Qq7ejTf8wekojyBWwTUMeXvmrksZ3ekKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Zhqw/tcn";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9C606A329
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C9C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zhqw/tcn
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so5940814a91.3
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881212; x=1795486012; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3EMWJDhBBek59xKnIdxxZDsZ4a9Lk1PMfcEjUKx7BtQ=;
        b=Zhqw/tcndtGNDBpZsbT2CEVslLTKh9NwaywRlkF4fWG31ucZ9srscJ7UOWN0nOgBbE
         xq//UG2re8OpcqEEnO9fV9ZLCepO7ZZOAiOfbfTspZD3aXhFOmEaQQOU02FeLS2G5v4t
         aUCRQwXVrQ3Pv6++PWeqNJqEI4O5Pgv5zIG5SWaqPWQERjQTjwy4py+8YpLq6nPoIS4P
         sHS2IJuC2hRUKhWLJ+aYMPK/fGm7f4etpjJxmI/8fBge8rKW4S09UKgM1c5znNqR1Qqp
         hOtaUVjrHg05O14QGQeA8suq2IgvkxHbmA7qFkKKsIFYJEXCzNn/FULw1RcC0TjVqniE
         yYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881212; x=1795486012;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EMWJDhBBek59xKnIdxxZDsZ4a9Lk1PMfcEjUKx7BtQ=;
        b=aziGKIYayZZqflElLu/94kFxVNeCFySD9m1l2eAR9U+JVcGYvRgDkLJAYtgn2pjRS1
         7QnqSU6JlKJlUsccOsHRn2n8Jca3tlh9qtrzBp5YYs7VHGvg5TmWuqvx11vJifMzDugW
         gHPP1NdRkVO2CN0PViJQJSdRVmIijbdQTa9HpUgyV7fF/6dODF7AaezQoN3wzCCVXD6C
         gsf8DI8xACRs9mfCXAKtvHMN82V4ySDvmt1JbFBhcfm4/bmdejK3fD1FdrmHqMkR5HpA
         Wwpr/YaQ83RnmQC3xhhiIqk7jQTrGwL/667DV/sxuxnYOb4NWscS3tSWM81mrmH1y/2h
         khmg==
X-Forwarded-Encrypted: i=1; AL+hErHv8P13DrYh8Y8aahtRtN2mFAZA5B/KY93E7u2gY9zcNh9geIyHTI4rftz9ehQ2+ibCwtBNKtuF/GCoLikN@vger.kernel.org
X-Gm-Message-State: APuU4Z8HY2ANuiaCM8tqHXk9Tv1x6/u6XxZpaGXFJGTfoF+ejlroMe4J
	aH/OMVORIDp7244mj6qBaPkNrLl7ypoUBpAtPzCIzcNF7HiK+Mhn57CKU+JXo35n6Z++3WLOeJ8
	GDh6v5P+tU7jM+Vvrabkdnqc/kg==
X-Received: from pjbei2.prod.google.com ([2002:a17:90a:e542:b0:3b3:aa49:9102])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3890:b0:3b1:6f2:a188 with SMTP id 98e67ed59e1d1-3b1b0a4e441mr13189767a91.55.1794881211439;
 Mon, 16 Nov 2026 18:06:51 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:37 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117020648.323464-1-dylanbhatch@google.com>
Subject: [PATCH v9 00/11] unwind, arm64: add sframe unwinder for kernel
From: Dylan Hatch <dylanbhatch@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Weinan Liu <wnliu@google.com>, 
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jens Remus <jremus@linux.ibm.com>
Cc: Dylan Hatch <dylanbhatch@google.com>, Prasanna Kumar T S M <ptsm@linux.microsoft.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, joe.lawrence@redhat.com, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Randy Dunlap <rdunlap@infradead.org>, Mostafa Saleh <smostafa@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

Implement a generic kernel sframe-based [1] unwinder. The main goal is
to improve reliable stacktrace on arm64 by unwinding across exception
boundaries.

On x86, the ORC unwinder provides reliable stacktrace through similar
methodology, but arm64 lacks the necessary support from objtool to
create ORC unwind tables.

Currently, there is a sframe unwinder proposed for userspace [2], along
with an RFC for an .eh_frame unwinder [5]. This patch series implements
a similar SFrame lookup library to [2], but with many simplifications to
account for the fact that user access is not necessary. The intent here
is to continue to leave the door open for common usage of definitions
and algorithms between kernel and user unwind in the future, while at
the same time keeping these patches strictly constrained the minimal set
of features necessary for arm64 kernel unwind.

Unlike past versions of this series, these patches apply directly to
v7.4-rc1 rather than depending upon [2]. To make this possible, I've
adopted a number of patches from [2] with significant squashes and
changes made in order to coherently suit the kernel unwind use case.
I've done my best to maintain appropriate authorship on these changes,
and have added 'Co-developed-by' trailers to attribute shared authorship
as accurately as possible. Please let me know if you see any
discrepencies in my work here.

Currently, only GNU Binutils support sframe. This series relies on the
Sframe V3 format, which is supported in binutils 2.46.

This full series is available on github: [4].

Ref:
[1]: https://sourceware.org/binutils/docs/sframe-spec.html
[2]: https://lore.kernel.org/all/20260505121718.3572346-1-jremus@linux.ibm.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/log/?h=sframe/core
[4]: https://github.com/dylanbhatch/linux/tree/sframe-v9
[5]: https://lore.kernel.org/all/20260821195259.2688377-1-jremus@linux.ibm.com/

---

Summary of changes since v8:
 - Rebase onto v7.4-rc1, resolving merge conflicts in Makefile and
   arch/arm64/lib/strncmp.S and dropping arch/arm64/lib/clear_page.S
   (removed upstream).
 - (sashiko) Add 'depends on !RUST' to HAVE_UNWIND_KERNEL_SFRAME and keep
   KBUILD_RUSTFLAGS conditioned only on CONFIG_UNWIND_TABLES.
 - (sashiko) Move STACK UNWINDING entry in MAINTAINERS to alphabetical
   order and add unwind_sframe.h patterns in the patch introducing them.
 - (sashiko) Filter out $(CC_FLAGS_SFRAME) in efi/libstub, arm64 pi, and
   arm64 kvm/hyp/nvhe Makefiles where unwind tables are disabled.
 - (sashiko) Guard SFrame header, FDE, and FRE bounds calculations
   against integer overflow.
 - (sashiko) Preserve KASAN, KCSAN, and ftrace exclusions on sframe.o in
   kernel/unwind/Makefile, and clean up header includes across sframe.h,
   sframe_debug.h, module.h, and kernel/module/main.c.
 - (sashiko) Mark is_kernel_inittext(), __is_kernel_text(), and
   within_module_mem_type() as __always_inline for noinstr sframe_find().
 - (sashiko) Provide generic include/asm-generic/unwind_sframe.h fallback
   and move <asm/unwind_sframe.h> include to the IP validation patch.
 - (sashiko) Update CONFIG_SFRAME_VALIDATION help text and commit log for
   in-kernel vmlinux and module .sframe validation.
 - (sashiko) Place .cfi_startproc before 'bti c' in call_on_irq_stack()
   using SYM_START().
 - (sashiko) Move out-of-line blocks in pmull_gcm_ghash_4x() and
   pmull_gcm_enc_4x() out of '.subsection 1' and annotate __pi_strrchr
   with SYM_LEAF_FUNC_START / SYM_LEAF_FUNC_END.
 - (sashiko) Restrict SFrame unwinding at KUNWIND_SOURCE_REGS_PC to real
   on-stack FRAME_META_TYPE_PT_REGS exception frames, drop invalid
   cross-stack 'fp < sp' check in UNWIND_CFA_RULE_FP_OFFSET, enforce
   8-byte alignment in get_word(), and propagate state->unreliable on
   -ENOENT in do_kunwind().

Summary of changes since v7:
 - (sashiko): Put .cfi_startproc right after SYM_START to account for
   potential alignment bytes ahead of the actual function symbol.
 - (sashiko) Use __always_inline for IP validation helper.
 - (sashiko) Move .sframe module init and sframe section fields to arch
   generic code.
 - (sashiko) Make sframe_find() noinstr.
 - (sashiko) Add preempt_notrace and instrumentation to
   __sframe_module_find() code path.
 - (sashiko) Block tracing and kprobe on the sframe_find code path.
 - (shashiko) remove KCOV, KCSAN, and KASAN instrumentation from
   sframe.o (copying over ORC's shoulder).

Dylan Hatch (6):
  arm64, unwind: build kernel with sframe V3 info
  module, sframe: Add sframe support for modules
  arm64/sframe: Validate IP addresses
  sframe: Add debug helpers with object name
  arm64, crypto/lib: Annotate leaf functions with CFI info
  unwind: arm64: Use sframe to unwind interrupt frames

Jens Remus (1):
  sframe: Separate reading of FRE from reading of FRE data words

Josh Poimboeuf (3):
  arm64/sframe: Read vmlinux .sframe header
  sframe: Add support for reading vmlinux .sframe contents
  sframe: Add .sframe validation option

Weinan Liu (1):
  arm64: entry: add unwind info for call_on_irq_stack()

 MAINTAINERS                            |  17 +-
 Makefile                               |   8 +
 arch/Kconfig                           |  51 ++
 arch/arm64/Kconfig                     |   1 +
 arch/arm64/Makefile                    |   8 +-
 arch/arm64/crypto/aes-ce-ccm-core.S    |  12 +-
 arch/arm64/crypto/aes-neonbs-core.S    |  16 +-
 arch/arm64/crypto/ghash-ce-core.S      |  76 ++-
 arch/arm64/crypto/sm4-ce-ccm-core.S    |  16 +-
 arch/arm64/crypto/sm4-ce-cipher-core.S |   4 +-
 arch/arm64/crypto/sm4-ce-core.S        |  44 +-
 arch/arm64/crypto/sm4-ce-gcm-core.S    |  16 +-
 arch/arm64/crypto/sm4-neon-core.S      |  12 +-
 arch/arm64/include/asm/linkage.h       |  32 ++
 arch/arm64/include/asm/module.lds.h    |   2 +
 arch/arm64/include/asm/sections.h      |   1 +
 arch/arm64/include/asm/unwind_sframe.h |  32 ++
 arch/arm64/kernel/entry.S              |  17 +-
 arch/arm64/kernel/pi/Makefile          |   3 +
 arch/arm64/kernel/setup.c              |   2 +
 arch/arm64/kernel/stacktrace.c         | 211 +++++++-
 arch/arm64/kernel/vdso/Makefile        |   2 +-
 arch/arm64/kernel/vmlinux.lds.S        |  14 +
 arch/arm64/kvm/hyp/nvhe/Makefile       |   5 +-
 arch/arm64/lib/clear_user.S            |   4 +-
 arch/arm64/lib/copy_from_user.S        |   4 +-
 arch/arm64/lib/copy_page.S             |   4 +-
 arch/arm64/lib/copy_to_user.S          |   4 +-
 arch/arm64/lib/memchr.S                |   4 +-
 arch/arm64/lib/memcmp.S                |   4 +-
 arch/arm64/lib/memcpy.S                |   8 +-
 arch/arm64/lib/memset.S                |   8 +-
 arch/arm64/lib/mte.S                   |  28 +-
 arch/arm64/lib/strchr.S                |   4 +-
 arch/arm64/lib/strcmp.S                |   4 +-
 arch/arm64/lib/strlen.S                |   4 +-
 arch/arm64/lib/strncmp.S               |   4 +-
 arch/arm64/lib/strnlen.S               |   4 +-
 arch/arm64/lib/strrchr.S               |   4 +-
 arch/arm64/lib/tishift.S               |  12 +-
 drivers/firmware/efi/libstub/Makefile  |   2 +
 include/asm-generic/Kbuild             |   1 +
 include/asm-generic/sections.h         |   8 +-
 include/asm-generic/unwind_sframe.h    |   5 +
 include/asm-generic/vmlinux.lds.h      |  15 +
 include/linux/module.h                 |  11 +-
 include/linux/sframe.h                 |  42 ++
 include/linux/unwind_types.h           |  34 ++
 kernel/module/main.c                   |  20 +
 kernel/unwind/Makefile                 |   9 +-
 kernel/unwind/sframe.c                 | 714 +++++++++++++++++++++++++
 kernel/unwind/sframe.h                 |  79 +++
 kernel/unwind/sframe_debug.h           |  38 ++
 53 files changed, 1501 insertions(+), 183 deletions(-)
 create mode 100644 arch/arm64/include/asm/unwind_sframe.h
 create mode 100644 include/asm-generic/unwind_sframe.h
 create mode 100644 include/linux/sframe.h
 create mode 100644 include/linux/unwind_types.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h

-- 
2.56.0.679.gc527c65306-goog

