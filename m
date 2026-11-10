Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327057;
	b=QGfqZsyNOVmgY1LEtaRNze7F+9WDUhlRl7NEtbyWq/obewsVtRHrVyyZcfs8bX6/A1f/
	 QzekY5BvTfLUdVcalx5JcN6e5GMqMuntjvxzGxauRLeiqQc70KK6dGRaA/c8adibL+vGv
	 Ul4+OAnhfQ6HQPbHDURTUL1hbE8CqEnfRbgqq5VMSsCz5GIKXPCpyBie+k66AwqfLp3k/
	 Z3XJt1jaNUO7kk9ek02uW71iJO0z5xjPA5VYRmI8Z1O2NM1goD7Qt7QsM364R8iaWXaMf
	 40uZH3UxIKfpH/jJpSUuXK7K1oKFYRzoY1kEF739g2qVqGi6246My6hF779HE1yUY0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QdU1aqKwlVngIKa2eaMFTNV7DLkp+ni68eEKDmr9dqA=;
	b=z7xxpFtjamjRulDUWIPWqb2W0o9SOzpVJ2Z7clOq+uiBwx2cBwktOw65IlKTwAiXWVUI
	 vawigpqOYak2xO6hGD4WXXnx7719aaPIyo6Mq7lNea9H+T8EsB7I6JP7dLKQ9SGrTaRdD
	 1znkH2lufIGcPDjhZJB0uUQBtKHN8Ot0nISD2GEQwc5sBDA+zS/QuipcO1V693um4c7lQ
	 63KaO4E7vIc18EMHllMDTpVNhrT9R6CamUfeq/I1ifetK2nPXIxoi4u/bDO5xvZeiuIa3
	 icqPbQrEsiBXxuY8QGctVqN7tEAiHjd+20IC7yrNGCHBKiT3e86qgMNImonEz49oV6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN2aJ3lB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D660A6F75;
	Tue, 10 Nov 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN2aJ3lB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3632F1F008A3;
	Tue, 10 Nov 2026 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327057;
	bh=QdU1aqKwlVngIKa2eaMFTNV7DLkp+ni68eEKDmr9dqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eN2aJ3lBMCXJnpWJLSJWHJHYe7XUcAgplG+1j6PP8+mrmya7mQe1z1Pf8yp7a2EaG
	 nn8i8v4ALT7ta2GcAD1teuYJpS9cI0wBHKjehIbiu4nVPOhZZLuINIj1uEtxPrzGDv
	 Ce8a2YJPXPEvmfCR16Muff4NiuavRhxJeGgjzPMtiCB1mQYBVa9F38LXvgujA5ONuu
	 BtSuyWrZL+lXBIYxuBM4IAtd5XmeKGl2V7P1iQt0RnlG6GfSmnXmgPE8ezOo1Nz1hx
	 O+ZnJkjzRtfkPrpnLAUOdtAr/j+2QCLmbnvm3aPuzRNWwLEg218uhTmhMdEuMNrVej
	 XNgMPanCc6JlQ==
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
Subject: [PATCH v4 3/4] selftests/livepatch: build the test modules against the kernel in O=
Date: Tue, 10 Nov 2026 11:10:49 -0500
Message-ID: <20261110161050.2451750-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161050.2451750-1-sashal@kernel.org>
References: <20261110161050.2451750-1-sashal@kernel.org>
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

Documentation/dev-tools/kselftest.rst describes building the selftests
for a kernel built in a separate output directory:

  make O=/tmp/kselftest TARGETS=livepatch kselftest

The livepatch test modules are not built against the kernel in
/tmp/kselftest, but against the running kernel, using its devel files
in /lib/modules/$(uname -r)/build. When those are not installed, the
modules are silently left out. Only an explicit KDIR=/tmp/kselftest
builds them for the kernel in /tmp/kselftest.

When KDIR is not set, use the output directory given with O= or
KBUILD_OUTPUT if a kernel was built there, then the kernel source tree
if the kernel was built in it, and only then the running kernel.

The selftests also pass their O= on to the module build, and the kernel
Makefile takes it as the kernel build directory instead of KDIR. The
top-level selftests Makefile passes O= even when it is empty, so on a
Debian machine with the devel files of the running kernel installed,

  make -C tools/testing/selftests TARGETS=livepatch

uses the source part of the devel files as the build directory and
fails:

  /usr/src/linux-headers-6.19.13+deb14-common/Makefile:798: /usr/src/linux-headers-6.19.13+deb14-common/include/config/auto.conf: No such file or directory

Do not pass O= and KBUILD_OUTPUT on to the module build, since KDIR
already names the kernel build directory.

Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/livepatch/Makefile    | 26 +++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile | 12 +++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index a080eb54a215d..97478ef90945c 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,5 +1,31 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# The test modules are built against the kernel in KDIR. When KDIR is not
+# set, use the output directory given with O= or KBUILD_OUTPUT if a kernel
+# was built there, as with
+#   make O=/tmp/kselftest TARGETS=livepatch kselftest
+# otherwise the kernel source tree if the kernel was built in it, as with
+#   cd tools/testing/selftests/livepatch; make
+# and otherwise the build directory of the running kernel, which its
+# devel files provide. A kernel was built in a directory if it has a
+# Module.symvers.
+ifndef KDIR
+KBUILD_DIR := $(firstword $(O) $(KBUILD_OUTPUT))
+ifneq ($(and $(KBUILD_DIR),$(wildcard $(KBUILD_DIR)/Module.symvers)),)
+KDIR := $(KBUILD_DIR)
+else ifneq ($(wildcard ../../../../Module.symvers),)
+KDIR := ../../../..
+else
+KDIR := /lib/modules/$(shell uname -r)/build
+endif
+endif
+
+# test_modules is built from its own directory, so pass KDIR on as an
+# absolute path, also when it was given on the command line.
+override KDIR := $(abspath $(KDIR))
+export KDIR
+MAKEOVERRIDES := $(filter-out KDIR=%,$(MAKEOVERRIDES))
+
 TEST_GEN_FILES := test_klp-call_getpid
 TEST_GEN_MODS_DIR := test_modules
 TEST_PROGS_EXTENDED := functions.sh
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index 01eaf2e1755c9..82f0119f6cf0d 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -16,6 +16,11 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state3.o \
 	test_klp_syscall.o
 
+# The kernel Makefile would take an O= or KBUILD_OUTPUT passed on from the
+# selftests build as its build directory, instead of KDIR or, for clean,
+# the source tree. Drop them.
+modules clean: MAKEOVERRIDES := $(filter-out O=% KBUILD_OUTPUT=%,$(MAKEOVERRIDES))
+
 # Build the modules only if KDIR exists and its kernel was configured with
 # CONFIG_LIVEPATCH, as recorded in include/config/auto.conf. If that cannot
 # be read, still try the build, so that a KDIR that is not a kernel build
@@ -29,14 +34,11 @@ endif
 
 modules:
 ifdef BUILD_TEST_MODS
-	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+	$(Q)env -u KBUILD_OUTPUT $(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
 endif
 
 # Cleaning external modules needs no configured kernel, so clean them
-# through the kernel source tree that contains this directory. The kernel
-# Makefile would take an O= or KBUILD_OUTPUT passed on from the selftests
-# build as its build directory, so drop them.
-clean: MAKEOVERRIDES := $(filter-out O=% KBUILD_OUTPUT=%,$(MAKEOVERRIDES))
+# through the kernel source tree that contains this directory.
 clean:
 	$(Q)env -u KBUILD_OUTPUT $(MAKE) -C $(TESTMODS_DIR)/../../../../.. \
 		clean KBUILD_EXTMOD=$(TESTMODS_DIR)
-- 
2.53.0

