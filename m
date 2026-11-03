Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714543;
	b=goj4AOLm08UzheM6bRsv2Zd4LdALNBNc/w1EUAtxzl2wOaIefCU43LTMTtyD24Qf5AzO
	 Sss8lS1Y3UfwWLcHrY5oWCibeT+NfEDnloeWClMOkJTOLUowaBkmPbtXeeuCAj+395Ovx
	 YgYbVms/9UIL7AYETmwNpCsMoKsguv/27TxeKiRl36svLAnVLX1AyU0dIFQEEi2Kc7kMl
	 902qwIbd5BmZL2Pt447dnMPI3MUyj4kFCRgzvNcrNucRye0nHlggl/oWEEp8Mgb3DsZ/e
	 woVDuQOuZda5uUT7t+QmZuzFxXQCqe2TlYCSMF0cVBg5EaZOuMdcq3fPHnTIJXOH1aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lvWs03XeyVF/B5EH+hspmJPt7gO0kdhqtoOPHHJ1LUg=;
	b=GNO33NvlK42Ewb/LkwesL8n60idOqSbFQhNNguFDkuSlHRHqhqu4gvgFy/Hm0bsEgwF1
	 0qevywFsuOI6/7J0pqJbrysvPboFPal8sEbWcP42oJXng6KrPloNoPY4XPU5gQukKbqgK
	 Xja6aOQgmwgMu+DsFds+E8jlohe5cH6EFSwuFv9/jE3KVD2ufMsHM+z5TFkxNHXmpFoqz
	 e9e2PWA/HtXZb61wQxYpSQ42/kWgsS757Yn8Z2ZcjDmE5hkoeL6cRERC7dmgjy23iifBA
	 ZqI9OpXciQdROAXjB//5VDtVhc+8butCUPTpgsU/vH1fctuBwMt+8/tSi5tnp0y1YQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6nnOxMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14A606A329;
	Tue,  3 Nov 2026 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6nnOxMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A5F1F0093A;
	Tue,  3 Nov 2026 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714542;
	bh=lvWs03XeyVF/B5EH+hspmJPt7gO0kdhqtoOPHHJ1LUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6nnOxMGVmzbuy1zQqs42O5xu+nGb78QH+u19ZnRnObQ6rEnZs/IKLRNd4LmVBE47
	 VG1OD/xKcBTBeGMoahWxAMSWflpASwSAT/i/Q0YNGOEe4VJQ3Sj5s59TAg7rA+bUNf
	 Bpgz29/DN/mP7sEwzekzHaDO6RbWDyGsA6W5RyEkmuZGOdfw7v+2hxRmGUYIdXFsZt
	 KLlORYiCnWAxHTgC6sttTo0PwXx50hFFwbcnukKx0iuTJkRWO3IxSOT6rSKIu8kS9x
	 lAHX4Dlxe/fZayEe0PgtVjhkx5i2OMWCQ30V119u/voW3k8BhyuuXya0mwolCV5gBC
	 LcRCjXm7yIWXA==
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
Subject: [PATCH v2 1/2] selftests/livepatch: build test modules against the selected kernel
Date: Tue,  3 Nov 2026 09:02:17 -0500
Message-ID: <20261103140218.17568-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103140218.17568-1-sashal@kernel.org>
References: <20261103140218.17568-1-sashal@kernel.org>
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
-- 
2.53.0

