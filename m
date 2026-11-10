Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327054;
	b=gRKICzti6p6TUIEm9OCn8e1gJciDfEJr9DSMYH9hlWKISRSP/lKVOOmpOHLvBx5REpv6
	 DU9zUCTydTk45tDYUExIh7JMnzOqSyoTHkXgPIspKxpIA3PuEFEOEFT7wl1ingq1VT6NO
	 upSwWYOlr9RtvR89RGqdW8MUrebWxHuwN+ejhZJpvYhbudW6joMlUuzzJJMjoK53u9xvv
	 wd9wdbXSZyYJVpMuXr86r7Ti4K59nFJqNvUDvWGX7sXidrnKq0/+/TAaAm6lq1xmWUxQa
	 P9Nkuo8T3FCe4CwL9hDm7aW+Rdd1C76UEEdztq5QyoAv8sydWn0IUL5olAoMxdE1omw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1ooPA6O6hIVoTNuFikXUygU5yHxlU7jJojv/pjgIdHQ=;
	b=Xy4JaF0evVFugfeiPT74yP2XpM1wgPgl3jk4dXTpVEPeraQgAOlOjMqNfLtezTpe24zu
	 2jqkXdSIEhHQ/80RqDq94ol4W1WK8kDuZHgH2M3GwLV4vo94wat8KoYTabJY34j6OPLtX
	 g/b22IsKUBY3ajR2Waf0IJS2Dbdw2Amy1CGNJizTWK6iqubijdlfKf6TenZuUTJen6V+s
	 vQjpyPxkE92amTigDw0dQSI7DZs7E8DBJtv2W43VYG5RBtFmfJKbzY3CalYez3T0SjyT3
	 q5KfTpAPcEgcs4jI3DGlx/EGLfnv38gjdzW2EJGfqdNMLGGnfUYG/u3fT5v3yZQ9LCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHZ+VuYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20960A380A;
	Tue, 10 Nov 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHZ+VuYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096271F008A3;
	Tue, 10 Nov 2026 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327054;
	bh=1ooPA6O6hIVoTNuFikXUygU5yHxlU7jJojv/pjgIdHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VHZ+VuYdYNDmMEE+0qknmF9ir9Gw63UJRynafDAOrkaL8HMYwAcH6ryS3vbjD0MEE
	 fES/AoaZHiBBy2xw9t4E5GwPwz3nxpDTZm4bL7vnGb+i4qtJuI44vZ86RDQRrdfVX5
	 UxdrWgP4OLv3gw/LuAL3JxD5k1k56qE++wF+6+A5xTxSLZvM3+LdCOI2wJqvfJ35Ni
	 XxPtaKhDzd1QRheYJDKuLNinoUV8hTtR4qhFGiruu87+lkShs6wU82solHHpLyKHaK
	 IGqxd4qkaUXawIFM1ggYMxVv+c92Q5alV3uLmizKtM1aKnYzVaUbAMdeyEX2kbHcDx
	 WhEGVUkR5Ex+w==
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
Subject: [PATCH v4 1/4] selftests/livepatch: skip the tests on kernels without livepatch
Date: Tue, 10 Nov 2026 11:10:47 -0500
Message-ID: <20261110161050.2451750-2-sashal@kernel.org>
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

The test modules can only be built against a kernel configured with
CONFIG_LIVEPATCH, but the selftests try to build them for any kernel.

KernelCI builds the selftests for many kernel configurations, most of
which do not enable livepatch. On mainline from November 8, 36 of its
69 kselftest builds fail to compile the test modules, for example:

  test_klp_callbacks_demo2.c:23:16: error: invalid use of undefined type 'struct klp_object'

These are arm and riscv kernels, which do not support livepatch, and
x86, arm64, powerpc and loongarch configurations that do not enable it.

Do not build the test modules when the kernel in KDIR was configured
without CONFIG_LIVEPATCH, and skip the tests when the running kernel has
no /sys/kernel/livepatch.

Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/livepatch/functions.sh     |  1 +
 .../selftests/livepatch/test_modules/Makefile      | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index a13d398585dcb..eddfb420db320 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -16,9 +16,19 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state3.o \
 	test_klp_syscall.o
 
-# Ensure that KDIR exists, otherwise skip the compilation
-modules:
+# Build the modules only if KDIR exists and its kernel was configured with
+# CONFIG_LIVEPATCH, as recorded in include/config/auto.conf. If that cannot
+# be read, still try the build, so that a KDIR that is not a kernel build
+# directory fails the build instead of being skipped.
+KDIR_CONFIG := $(KDIR)/include/config/auto.conf
 ifneq ("$(wildcard $(KDIR))", "")
+ifneq ($(shell [ -r "$(KDIR_CONFIG)" ] && ! grep -qx 'CONFIG_LIVEPATCH=y' "$(KDIR_CONFIG)" && echo n),n)
+BUILD_TEST_MODS := y
+endif
+endif
+
+modules:
+ifdef BUILD_TEST_MODS
 	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
 endif
 
-- 
2.53.0

