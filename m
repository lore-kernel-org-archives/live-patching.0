Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E4279346;
	Thu,  5 Mar 2026 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681515; cv=none; b=KGrSEkrCEwGyPD8uqxFT7wZptIh8VCsMj5GWC6M+prqNC5zN+3p8DCSyyRbMitU6q44bV6AYunvZhWnY3fa2dD667tOxtDwHQAk1ydtp4lA6qmfuXFCbOtpEFspCv6qty6EycWPO4lrwxbsWnfjVMS80BlCm8Bs3hqYA9Aj6QiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681515; c=relaxed/simple;
	bh=2RHHwjHDEfLBZts7gftP8ppQ8P51E1xBhiCigfZjKIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrK20iDqusf2HXTywfPygsfxRLsPkXtYCh6X2+2baEXusdt6/ssMv/ymTt6sRONGSEBhx8QRhAyzzlDIILZ7NvQXX0rcvV0usSSvihr3LK9rHHbT1kq7mbj9C35SKYVhGZhe32mo90RHqn63HQh2N59vrvdzyV/GpKUaDRPCsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfo0/10/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfo0/10/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D8EC19422;
	Thu,  5 Mar 2026 03:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681515;
	bh=2RHHwjHDEfLBZts7gftP8ppQ8P51E1xBhiCigfZjKIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cfo0/10/eTtxez/EjmHNrZDLUnJaecsM+kHAJbSI7XBEe4gYeKHIwJVgEVtidEPYX
	 C4RnCsY3R806DCdPLtIT78vvseTLwCH+w3DNb2PaAu306Bui1EUN6npvXLE6YR1/d3
	 2j1m7fIPQwh9BF5RoKdG48iOKVWinRCLyqUQzxQ4VzEZxK164sBltkpw8JI1RWcdus
	 DzD/kVsbK0U44FFs7VlZR6BXaUssGWcoLTqHLIUddl00+LzJfdqlK+cTrrMep+CYqn
	 Oz/SA1xPuEABCq8bVmpaEE+8em8YkFnly6C9QV5QaD/KPC23P1FI555AnHmZrUHB4z
	 gcQdc/PRbL3pA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 09/14] kbuild: Only run objtool if there is at least one command
Date: Wed,  4 Mar 2026 19:31:28 -0800
Message-ID: <b5f73df0d598e77104f7d2de5a84d69e75e80b9f.1772681234.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772681234.git.jpoimboe@kernel.org>
References: <cover.1772681234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the objtool args into commands and options, such that if no
commands have been enabled, objtool doesn't run.

This is in preparation in enabling objtool and klp-build for arm64.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/boot/startup/Makefile |  2 +-
 scripts/Makefile.build         |  4 +--
 scripts/Makefile.lib           | 46 ++++++++++++++++++----------------
 scripts/Makefile.vmlinux_o     | 15 ++++-------
 4 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..a08297829fc6 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -36,7 +36,7 @@ $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
 # relocations, even if other objtool actions are being deferred.
 #
 $(pi-objs): objtool-enabled	= 1
-$(pi-objs): objtool-args	= $(if $(delay-objtool),--dry-run,$(objtool-args-y)) --noabs
+$(pi-objs): objtool-args	= $(if $(delay-objtool),--dry-run,$(objtool-cmds-y) $(objtool-opts-y)) --noabs
 
 #
 # Confine the startup code by prefixing all symbols with __pi_ (for position
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 32e209bc7985..d2d0776df947 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(target-stem).o)$(OBJECT_FILES_NON_STANDARD)n),$(is-kernel-object))
 
 ifdef CONFIG_OBJTOOL
-$(obj)/%.o: private objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
+$(obj)/%.o: private objtool-enabled = $(if $(is-standard-object),$(if $(objtool-cmds-y),$(if $(delay-objtool),$(is-single-obj-m),y)))
 endif
 
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
@@ -499,7 +499,7 @@ define rule_ld_multi_m
 	$(call cmd,gen_objtooldep)
 endef
 
-$(multi-obj-m): private objtool-enabled := $(delay-objtool)
+$(multi-obj-m): private objtool-enabled := $(if $(objtool-cmds-y),$(delay-objtool))
 $(multi-obj-m): private part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
 	$(call if_changed_rule,ld_multi_m)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0718e39cedda..40a462581666 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -183,27 +183,31 @@ ifdef CONFIG_OBJTOOL
 
 objtool := $(objtree)/tools/objtool/objtool
 
-objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
-objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
-objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
-objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
-objtool-args-$(CONFIG_FINEIBT)				+= --cfi
-objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
-ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
-objtool-args-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
-endif
-objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
-objtool-args-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
-objtool-args-$(CONFIG_MITIGATION_RETHUNK)		+= --rethunk
-objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
-objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
-objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
-objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
-objtool-args-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+= --no-unreachable
-objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
-objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --werror
+# objtool commands
+objtool-cmds-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
+objtool-cmds-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
+objtool-cmds-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
+objtool-cmds-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
+objtool-cmds-$(CONFIG_FINEIBT)				+= --cfi
+objtool-cmds-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
+objtool-cmds-$(CONFIG_UNWINDER_ORC)			+= --orc
+objtool-cmds-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
+objtool-cmds-$(CONFIG_MITIGATION_RETHUNK)		+= --rethunk
+objtool-cmds-$(CONFIG_MITIGATION_SLS)			+= --sls
+objtool-cmds-$(CONFIG_STACK_VALIDATION)			+= --stackval
+objtool-cmds-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
+objtool-cmds-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
+objtool-cmds-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
+objtool-cmds-y						+= $(OBJTOOL_ARGS)
 
-objtool-args = $(objtool-args-y)					\
+# objtool options
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+objtool-opts-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
+endif
+objtool-opts-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+= --no-unreachable
+objtool-opts-$(CONFIG_OBJTOOL_WERROR)			+= --werror
+
+objtool-args = $(objtool-cmds-y) $(objtool-opts-y)			\
 	$(if $(delay-objtool), --link)					\
 	$(if $(part-of-module), --module)
 
@@ -212,7 +216,7 @@ delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT),$(CONFIG_KLP_
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool-args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
-objtool-enabled := y
+objtool-enabled = $(if $(objtool-cmds-y),y)
 
 endif # CONFIG_OBJTOOL
 
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 527352c222ff..09af33203bd8 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -36,18 +36,13 @@ endif
 # For !delay-objtool + CONFIG_NOINSTR_VALIDATION, it runs on both translation
 # units and vmlinux.o, with the latter only used for noinstr/unret validation.
 
-objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
-
-ifeq ($(delay-objtool),y)
-vmlinux-objtool-args-y					+= $(objtool-args-y)
-else
-vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+= --werror
+ifneq ($(delay-objtool),y)
+objtool-cmds-y					 =
+objtool-opts-y					+= --link
 endif
 
-vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
-							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
-
-objtool-args = $(vmlinux-objtool-args-y) --link
+objtool-cmds-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
+						   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
 
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
-- 
2.53.0

