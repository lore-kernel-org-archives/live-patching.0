Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB8485954;
	Wed, 14 Oct 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008118; cv=none; b=bs6ERRKs0t/65gbmOKuOGCQ4d3OUXKASDQMdKSjCp1HyQ6W6PoE2NnpQOLvZ1pxkHK2H+cWE/H6jPWXex2i4JmJbur0anzYofcrMFwxg7oZEW7HDViqSlnaVR9Pf79ialdhM7izoxa2UbtdleAXIUFLkTRjPKsHTRyoMF7HzNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008118; c=relaxed/simple;
	bh=pTizOKZw6Ad5FfhICeRJrMYPRcWK4OlQ4o37q2skKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHtpwlVln3qTdaMXOtQHNwnRRWIMJ9who6hZ4JvLUDu6G2EUrtTuKJES8Ktpzo4uS44UnShOioUKfoLksHzPeeCrZBKkwqjfROG/pNE1uCsB/s2RZBvssUN9rvARdgiy3IunrixeRbX41BxWaxf2Mhg7/7b30Pc4uVNnIewpe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf61j90Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf61j90Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE421F000C4;
	Wed, 14 Oct 2026 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008117;
	bh=LCObJpsEaN7y1DV7WmatB7bqNMyYbeBB8aYv44DDfRc=;
	h=From:To:Cc:Subject:Date;
	b=Vf61j90ZWWADxCqnmoYkC9pDbeAioj6wT0FZVG5yqJrvvSZ57qQG8ntu5Cn74U4a5
	 uFB9VibSFV/br1tdIbbiDOMK4U1O6EOVQCnSR22yA7dzrwf6H6ayNXAcGX2rHAqDAJ
	 nw60+M48BeM/lZlpsrXYzBQ5oN0PLR+izeSlUhXRDh9FU5xM5rD1Rh6AWE/WoXUbgr
	 pR07gsK/0zEFbDKkSFKbuLAO/uKMw/zsYGiKWbrf/7foSL+NW/7JZ8w2eBkBQK6+sr
	 ZhE+oiF2F7nNGYhQXmhipLo64QeyLVzN3iZDJ84ioygTH1aGuy4fdQSLiLZu7KXg09
	 x/fY7T3XNUEkQ==
From: Sasha Levin <sashal@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/livepatch: build test modules against the selected kernel
Date: Wed, 14 Oct 2026 16:01:54 -0400
Message-ID: <20261014200154.1365200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The livepatch test modules are built against /lib/modules/$(uname -r)/build
unless KDIR is set, and they are built unconditionally. This has three
problems:

- When the selftests are built for a kernel in an output directory
  (make O=...), the modules are still built against the running host
  kernel, or fail when the host has no build directory.

- The top-level selftests Makefile passes O to every suite, and the
  test_modules Makefile hands it on to the kernel build. Even an empty
  O= on the command line overrides the KBUILD_OUTPUT set by the
  Makefile of a kernel build directory, so the build fails against
  output directories and distribution headers such as Debian's:
  "make -C tools/testing/selftests TARGETS=livepatch" builds no
  modules at all.

- A kernel configured without CONFIG_LIVEPATCH cannot build the
  modules, although the installed scripts would correctly skip.

Select KDIR from O or KBUILD_OUTPUT when it is a prepared kernel build
directory containing Module.symvers, then from the source tree when the
kernel was built in place, and otherwise from the running kernel. An
explicit KDIR still takes precedence. Pass KDIR to test_modules as an
absolute path and stop forwarding O and KBUILD_OUTPUT to the kernel
build, including when the selftests are built through the kernel's
kselftest targets, since KDIR already names the output directory.

Read CONFIG_LIVEPATCH from the selected .config and skip the modules
only when the configuration is readable and the option is not enabled.
A KDIR without a readable configuration still attempts the build, so
that a directory that is not a prepared kernel tree fails the build
instead of silently producing an installation without modules. A KDIR
that does not exist keeps being skipped, as before.
Always clean test_modules, and have the scripts report a skip after the
root check when the running kernel does not provide livepatch.

Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/livepatch/Makefile    | 27 +++++++++++++++++++
 .../testing/selftests/livepatch/functions.sh  |  1 +
 .../selftests/livepatch/test_modules/Makefile |  6 +++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215d..855bbad241235 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,7 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
 
+ifndef KDIR
+LIVEPATCH_OBJTREE := $(firstword $(O) $(KBUILD_OUTPUT))
+ifneq ($(and $(LIVEPATCH_OBJTREE),$(wildcard $(LIVEPATCH_OBJTREE)/Module.symvers)),)
+KDIR := $(LIVEPATCH_OBJTREE)
+else ifneq ($(wildcard ../../../../Module.symvers),)
+KDIR := ../../../..
+else
+KDIR := /lib/modules/$(shell uname -r)/build
+endif
+endif
+override KDIR := $(abspath $(KDIR))
+export KDIR
+
+LIVEPATCH_CONFIG := $(shell if [ -r "$(KDIR)/.config" ]; then \
+	grep -qx 'CONFIG_LIVEPATCH=y' "$(KDIR)/.config" && echo y || echo n; fi)
+
 TEST_GEN_FILES := test_klp-call_getpid
+ifneq ($(LIVEPATCH_CONFIG),n)
 TEST_GEN_MODS_DIR := test_modules
+endif
 TEST_PROGS_EXTENDED := functions.sh
 TEST_PROGS := \
 	test-livepatch.sh \
@@ -16,3 +34,12 @@ TEST_PROGS := \
 TEST_FILES := settings
 
 include ../lib.mk
+
+ifeq ($(LIVEPATCH_CONFIG),n)
+clean: clean_livepatch_mods
+
+clean_livepatch_mods:
+	$(Q)$(MAKE) -C test_modules clean
+
+.PHONY: clean_livepatch_mods
+endif
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 429fce1f31431..8b26b70f92d8c 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -150,6 +150,7 @@ function cleanup() {
 #		 the ftrace_enabled sysctl.
 function setup_config() {
 	is_root
+	[[ -d "$SYSFS_KLP_DIR" ]] || skip "livepatch is not available"
 	has_kdir
 	push_config
 	set_dynamic_debug
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index a13d398585dcb..1fbeaac9c2b2c 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -16,14 +16,16 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state3.o \
 	test_klp_syscall.o
 
+modules clean: MAKEOVERRIDES := $(filter-out O=% KBUILD_OUTPUT=%,$(MAKEOVERRIDES))
+
 # Ensure that KDIR exists, otherwise skip the compilation
 modules:
 ifneq ("$(wildcard $(KDIR))", "")
-	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+	$(Q)env -u KBUILD_OUTPUT $(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
 endif
 
 # Ensure that KDIR exists, otherwise skip the clean target
 clean:
 ifneq ("$(wildcard $(KDIR))", "")
-	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
+	$(Q)env -u KBUILD_OUTPUT $(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
 endif

base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0

