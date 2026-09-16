Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C733DD85C
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584308; cv=none; b=nUmOw58wNAL0jOzhfooWNfHKbRQ3gVp0RghY/BbZK4Dy8y3aFIz0GsWoVgzYPE7bfYtThLXxYZKvQsT1OhC3FnqASBtwWoOKZDoTQ0Zq725pfOBIK7DIlMnc06lIulOXHqlka79/Lh2MWVDwrH2cfirg1ujXo7j1dMMaQIXiwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584308; c=relaxed/simple;
	bh=2hKdIBFIpaj/tnQec2lhpCWNYijjjDsoF1c/0itRAKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnSOqwnenoogeoZJc/apDanRNaG3vtHvsAXWvMr66K0i1kza4xXNqYZ0gDvnb6Ouu7yb+uryNI27kfPfVbwK7omq0bkx7eguxrFkwQ1CbJCNx9mNe9z+xvSpRhfjVi30y03MGr738MYZZi4kzx3smy9zn3aEu6AoN7MfH5GIF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmNYn5cy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmNYn5cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123101F0089E;
	Wed, 16 Sep 2026 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584291;
	bh=BM1WECVhSKHB/G3UIe/RxbYzNxpDDnd7/c67bhSNEvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmNYn5cyKRTQGFtulQ7GOBTTDy1sMVgjKqbYTghzQvj9PeriXHA0Sk1tXIEFoYi3e
	 GLUjjPTYJnXgGj0FpzIq/pTyOM0YKbOiHZilMBE45nt+UmfLQ5goStT00GIjhIfVKq
	 o5cYrp0kke1jkLTPvjt4b2nbYNdLe0HmeEF+t+AcZQ3YrYpzZX5ZdVwdcGjB4hnMQE
	 drqt0K37XvXuqOXCeJZ7SsTzb1dLsb0vD33px9pP4Zm6jRtKBgV31jhgMrTT8xDU5d
	 s2BaKYM2nx/jy7YKwhVSVofWcFpUUyE7D8zTv98NL+jWd7VWodl6MAWHF7ek0xWviU
	 zDRz9dH+e520w==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	puranjay@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 11/58] objtool: Forward toolchain variables to the klp test runner
Date: Wed, 16 Sep 2026 11:43:04 -0700
Message-ID: <20260916184351.2720310-12-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916184351.2720310-1-song@kernel.org>
References: <20260916184351.2720310-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Lawrence <joe.lawrence@redhat.com>

The tests target already passes ARCH and CROSS_COMPILE into
run-tests.sh.  lib.sh uses those to pick a default compiler and
binutils:

  CC=${CC:-${CROSS_COMPILE}gcc}
  LD=${LD:-${CROSS_COMPILE}ld}
  READELF=${READELF:-${CROSS_COMPILE}readelf}
  OBJCOPY=${OBJCOPY:-${CROSS_COMPILE}objcopy}

Those defaults only apply when the variables reach the shell that sources
lib.sh.  The recipe passed OBJTOOL, ARCH and CROSS_COMPILE explicitly, but
not CC or the binutils.  Makefile-assigned values (e.g. from LLVM=1) are
not visible in the recipe environment unless forwarded:

  $ LLVM=1 make -C tools/objtool tests
  ...
  # preflight
  #   compiler  gcc (GCC) ...

Pass CC, LD, READELF and OBJCOPY the same way as ARCH and CROSS_COMPILE,
so fixtures are built and inspected with the toolchain make selected:

  $ LLVM=1 make -C tools/objtool tests
  ...
  # preflight
  #   compiler  clang version 21.1.8 ...

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/Documentation/klp-test-design.txt | 12 +++++++++++-
 tools/objtool/Makefile                          |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Documentation/klp-test-design.txt b/tools/objtool/Documentation/klp-test-design.txt
index 67d20bf0dc10..2082c277197f 100644
--- a/tools/objtool/Documentation/klp-test-design.txt
+++ b/tools/objtool/Documentation/klp-test-design.txt
@@ -243,7 +243,17 @@ setting a cross compiler cannot produce one the host is unable to run.  ARCH
 selects both the objtool target and the directory of tests to run.
 
 clang needs telling, since it defaults to the host triple however it is
-invoked.  The fixtures include no kernel headers, so no sysroot is needed:
+invoked.  LLVM=1 with CROSS_COMPILE does that for you -- the --target= it
+derives is forwarded to the tests -- and the fixtures include no kernel
+headers, so no sysroot is needed:
+
+::
+
+    ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- LLVM=1 \
+            make -C tools/objtool tests
+
+Naming the compiler by hand works too, and is what to reach for when the
+target triple is not the one CROSS_COMPILE implies:
 
 ::
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ed5cf146ef2e..47afe1e8a9c5 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -151,8 +151,17 @@ clean: $(LIBSUBCMD)-clean
 mrproper: clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 
+# The kernel's own Makefile sets OBJCOPY, to llvm-objcopy under LLVM and to
+# $(CROSS_COMPILE)objcopy otherwise; tools/scripts/Makefile.include names only
+# LLVM_OBJCOPY and leaves OBJCOPY unset.  Forwarding it unset would hand the
+# tests an empty string, and they would fall back to GNU objcopy even when
+# asked for an LLVM toolchain.
+OBJCOPY ?= $(if $(LLVM),$(LLVM_OBJCOPY),$(CROSS_COMPILE)objcopy)
+
 tests: $(OBJTOOL)
 	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
+		CC='$(CC) $(CLANG_CROSS_FLAGS)' LD='$(LD)' \
+		READELF='$(READELF)' OBJCOPY='$(OBJCOPY)' \
 		KEEP=$(KEEP) $(srctree)/tools/objtool/tests/run-tests.sh
 
 FORCE:
-- 
2.53.0-Meta

