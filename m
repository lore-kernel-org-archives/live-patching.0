Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744830;
	b=H7B/nZIinvMHD2SApCQuKFX77CINGsKHGP6jPzlGDdxYJGrRFhDG4K8CvnW384ulCEMD
	 JXFHa3fcypDwQppFh1TLbmIA/c/B6nh3feuVu3RtEaG27zLWhYjkAOudMINGOIDHBdiBH
	 gnyYSaayZ2hKMzA5yjImQRXu2PS8BLV2hRlStoMw0Blz+DXxYnA+TjlKDz7IRaDb4n2AD
	 npJdX9RqzYPC9gR3FeScLUv65D9sR4U5AWLKTJH/UtYqz3GGS4o2g4wRmlRFFe8eoT9Aq
	 whXxyIGD9GKWW2fNTKOtIpY4RczeEic8k2C3kHuUeROwCBVWocR6zOX4TL6jOP3UuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xRYB8YXENfLpVj6cxCaQbqVgOpSfTaKjH7SMs0PYWJI=;
	b=wb77MzwCoO949hF0THG/rrIdQeMiY+5T8xoTlvk5sgnhSjMWtD7rqvz0Eu0HOVg6XGTI
	 7dP0ZcFYr0RYXPQwGs0yLqwkj0pE/Sf8Diwj/fYSVZ4OkCvydIkwrQ5GFyo937In0skvd
	 26I2d2EzPM7Nbjfv2S6/3khobkc5Dre+yYohzjo1tojne1XJFpfrNaZIitRLayGqQMAo5
	 EFgShPEzRAr1BhiMS0qDoqP/UxCa6kBXs9ZXzZ+tusOqjvTpF65PKrtIdASzFSH5XPnEq
	 QcJ5Vrx5Y6QCfoMDSIjjM6MAL2LBYM3cL/9nlc+6KSjsCniIM7rqC+SLUddvu0xdP8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azSQ3Njc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A1606A335;
	Tue,  3 Nov 2026 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azSQ3Njc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04A01F00919;
	Tue,  3 Nov 2026 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744830;
	bh=xRYB8YXENfLpVj6cxCaQbqVgOpSfTaKjH7SMs0PYWJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azSQ3NjcTi1poX+okN19aclpt45dDBMO+RvPdUMjYaUYYGRpmgYla9+yXyse0BWEO
	 gvlRqK32UdCqfEF3fV6CuXrs1idDSr2BYQlkcyE6i69jf0qRz+0p+xE3xsYVHEUjae
	 LsWiBUZWgFonaDUXOsBRaGbJvwyV0PaADPFQP1D5OR6OwlMikY/mYEdKd/G4H7KJgs
	 OT5ajJ8GEm7UpUlBFvqmn0r55xHgTvJNVCgi4di+ErCFCJwhDrOgmzPMrpCZGEmqm0
	 RXSSePVSxwUqg3SoD7lkVLcvRTxHjIOKu/CtDgCLG+wiKOpO9Y9sxRVghrGkUWLY89
	 csZNLGT3NxpBw==
From: Sasha Levin <sashal@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] selftests/livepatch: build test modules against the selected kernel
Date: Tue,  3 Nov 2026 17:27:05 -0500
Message-ID: <20261103222706.1642224-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103222706.1642224-1-sashal@kernel.org>
References: <20261103222706.1642224-1-sashal@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
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
absolute path, also when it was given on the command line, and stop
forwarding O and KBUILD_OUTPUT to the kernel build, including when the
selftests are built through the kernel's kselftest targets, since KDIR
already names the output directory.

Read CONFIG_LIVEPATCH from the selected .config and skip the modules
only when the configuration is readable and the option is not enabled. A
KDIR without a readable configuration still attempts the build, so that
a directory that is not a prepared kernel tree fails the build instead
of silently producing an installation without modules. A KDIR that does
not exist keeps being skipped, as before.

Always clean test_modules, through the kernel source tree that contains
them. Cleaning external modules needs neither a configuration nor
Module.symvers, and unlike the build targets, the clean target of the
selftests Makefile does not pass the absolute O on, so the kernel the
modules were built against cannot always be found at that point.

Have the scripts report a skip after the root check when the running
kernel does not provide livepatch.

Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/livepatch/Makefile    | 28 +++++++++++++++++++
 .../testing/selftests/livepatch/functions.sh  |  1 +
 .../selftests/livepatch/test_modules/Makefile | 11 ++++----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215d..5c631812575dc 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,7 +1,26 @@
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
+MAKEOVERRIDES := $(filter-out KDIR=%,$(MAKEOVERRIDES))
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
@@ -16,3 +35,12 @@ TEST_PROGS := \
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
index a13d398585dcb..62cb724c6b333 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -16,14 +16,15 @@ obj-m += test_klp_atomic_replace.o \
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
 
-# Ensure that KDIR exists, otherwise skip the clean target
+# Any kernel tree can clean the test modules, so use the one containing them
 clean:
-ifneq ("$(wildcard $(KDIR))", "")
-	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
-endif
+	$(Q)env -u KBUILD_OUTPUT $(MAKE) -C $(TESTMODS_DIR)/../../../../.. \
+		clean KBUILD_EXTMOD=$(TESTMODS_DIR)
-- 
2.53.0

