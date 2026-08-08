Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168A384228;
	Sat,  8 Aug 2026 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231116; cv=none; b=JHWvkMsu4pyGpLGSZkhldaNwgvp+zTIH3TqoWRAcD+Hk6xOvcARoJ1dnmRjt2t+Qv5/bTua6I56ZDONfPH1VGZWlakC2DRdMPJCAT4Mc+wlcSbuXCBO6TUaLLU+DAgUIK2JtXIpBp9g3DlohJw4p/6XGB46KCtw8O6IPlaB8z50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231116; c=relaxed/simple;
	bh=/Wo5DedwZCEkHcc8ZLnJOXxc4qvg1OkUzCivi6XSoxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqwk+t5pXYT1jqWlAAIxyEIW52Ds1vEQGL5Slk9Hgj3zpYgmbQK481odxMuDGwdyBZYWco7fYccl5Za2qfAWkE+aT4CZi80qmIQocdfB7wmI2HkKovJX1FG1ppA1XACdSrMr4Dn7mYUgV/Dx71H2OdDAbY/3pywLjyaFJR3IMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWjAA/gY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWjAA/gY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5454F1F00A3D;
	Sat,  8 Aug 2026 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231114;
	bh=uE2HB1BAtSsaPradROS+PC6Riaax1AHZ+bCP9cmRupg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWjAA/gYAv55v5+/w7cCkSj0UNu6I3gMB/FfGSUyCCAClzFcAAd8pmOOY1/AkTaR4
	 HlXW8qgoNHHEuBv406o2OyvpF9lWG0+6PdWckAUBqh7dyet9nGwQ9r6wSRtb1svmNe
	 oCLSLo/c48r/KCxitmnFnfAH0RlBD45voktenPK3I8BSXTEGjn0yJuZmsJfypgNuu4
	 FCnkX4K2qfUvtcMG1zULnQFMr0QjwxPhRGNCgMNB6NhthuDvY9jKt7beZ/alXFCjrC
	 OLJeL6+8oEk4kWzYmiAhoyMbCjL3xV6qn8rltPyTIcZuHFBP05ecjG70wYYbsgpCSm
	 cX4a3nSLuQvPA==
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
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 11/22] kbuild: Only run objtool if there is at least one command
Date: Sat,  8 Aug 2026 16:17:15 -0700
Message-ID: <8adf966b340ea38ef1df845c7af0c794df3a7bce.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the objtool args into commands and options, such that if no
commands have been enabled, objtool doesn't run.

This is in preparation for enabling objtool and klp-build for arm64.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/boot/startup/Makefile |  2 +-
 scripts/Makefile.build         |  4 +--
 scripts/Makefile.lib           | 52 ++++++++++++++++++----------------
 scripts/Makefile.vmlinux_o     | 18 +++++-------
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5c..a08297829fc63 100644
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
index 9117457432463..d0865528edad5 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(target-stem).o)$(OBJECT_FILES_NON_STANDARD)n),$(is-kernel-object))
 
 ifdef CONFIG_OBJTOOL
-$(obj)/%.o: private objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
+$(obj)/%.o: private objtool-enabled = $(and $(is-standard-object),$(objtool-cmds-y),$(if $(delay-objtool),$(is-single-obj-m),y))
 endif
 
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
@@ -502,7 +502,7 @@ define rule_ld_multi_m
 	$(call cmd,gen_objtooldep)
 endef
 
-$(multi-obj-m): private objtool-enabled := $(delay-objtool)
+$(multi-obj-m): private objtool-enabled := $(if $(objtool-cmds-y),$(delay-objtool))
 $(multi-obj-m): private part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
 	$(call if_changed_rule,ld_multi_m)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0a4fdd8bd975d..272652875238c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -186,30 +186,34 @@ ifdef CONFIG_OBJTOOL
 
 objtool := $(objtree)/tools/objtool/objtool
 
-objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
-objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
-objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
-objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
-objtool-args-$(CONFIG_CALL_PADDING)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
-ifdef CONFIG_CALL_PADDING
-objtool-args-$(CONFIG_CFI)				+= --cfi
-objtool-args-$(CONFIG_FINEIBT)				+= --fineibt
-endif
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
-objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --werror
+# objtool commands
+objtool-cmds-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
+objtool-cmds-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
+objtool-cmds-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
+objtool-cmds-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
+objtool-cmds-$(CONFIG_CALL_PADDING)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
+objtool-cmds-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
+objtool-cmds-$(CONFIG_UNWINDER_ORC)			+= --orc
+objtool-cmds-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
+objtool-cmds-$(CONFIG_MITIGATION_RETHUNK)		+= --rethunk
+objtool-cmds-$(CONFIG_MITIGATION_SLS)			+= --sls
+objtool-cmds-$(CONFIG_STACK_VALIDATION)			+= --stackval
+objtool-cmds-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
+objtool-cmds-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
+objtool-cmds-y						+= $(OBJTOOL_ARGS)
 
-objtool-args = $(objtool-args-y)					\
+# objtool options
+ifdef CONFIG_CALL_PADDING
+objtool-opts-$(CONFIG_CFI)				+= --cfi
+objtool-opts-$(CONFIG_FINEIBT)				+= --fineibt
+endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+objtool-opts-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
+endif
+objtool-opts-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+= --no-unreachable
+objtool-opts-$(CONFIG_OBJTOOL_WERROR)			+= --werror
+
+objtool-args = $(objtool-cmds-y) $(objtool-opts-y)			\
 	$(if $(delay-objtool), --link)					\
 	$(if $(part-of-module), --module)
 
@@ -218,7 +222,7 @@ delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT),$(CONFIG_KLP_
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool-args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
-objtool-enabled := y
+objtool-enabled = $(if $(objtool-cmds-y),y)
 
 endif # CONFIG_OBJTOOL
 
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 24a3a4fd271c2..729f82eb85b35 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -36,21 +36,17 @@ endif
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
+objtool-opts-y					 = --link
+objtool-opts-$(CONFIG_OBJTOOL_WERROR)		+= --werror
 endif
 
-vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
-							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
+objtool-cmds-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
+						$(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
 
 # Only used for builds initiated by klp-build
-vmlinux-objtool-args-$(if $(KLP_SYMIDS),y)		+= --klp-symids
-
-objtool-args = $(vmlinux-objtool-args-y) --link
+objtool-cmds-$(if $(KLP_SYMIDS),y)		+= --klp-symids
 
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
-- 
2.54.0

