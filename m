Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AE3AB27B
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427095; cv=none; b=EjM19IOAwFc5qlKP3DGkF2TEjrQvI0sJFFGVdbN5nCO1QEvNlpKaDkciiROP31wzF+lZxa9EPZnEvvMhiCm0GPSEf+DKZMvgXGnWTs4j6JldU2BTIwdpcxbZsZS0ifjzk3fsIdZKKPqlVAFx/5rUojnOdyhrCELY87vxpWEK0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427095; c=relaxed/simple;
	bh=7ia2889Z9/IBF/WO9ez45VEfl/bLl2ZRbhcB/WzuSTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhG9X+zBiakwnr3H/g/HqcGWSDZrqUvnOZ1pspmHr+ajjU/Br+jiIiiYkSQypSO7dCRHK3g8sby2E/IyRGVegvFeQeZCyQrALiwpRsf2WtLPOZWNWLp1MDHy1cdCqsvDJoknuoUSvKp7uCRDzekOzPgNTpPgkeLGztUdqyNmtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1CqBjiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1CqBjiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EDA1F000FF;
	Mon, 14 Sep 2026 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427093;
	bh=tZo+Cly9AL3k0bkjwfIMPK0Uae0Y7r4aZIkCUB255kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1CqBjiIU6NrvowTjILK/YHr1U0Ev89gjb93cMuqRwDbgbOq3xevJ/Pt4PATgdwwa
	 jddw4LGtHvYUTWtSR5urxwH93Auxp3KDJNvmze50258EWhZZUoSx8GVxGvs95TGaOX
	 SDCD2zQChoDlAsYgMYIRXNctpFVQWhPTBVkU8nPKrXegFuSqW+T8HeLmN+g/hACYXl
	 CO3Mmh5oQsFoEKNyFWmPKLUvAehSj5jELjTxwc0JqryKiQ+7sWWbW7vaqgq43hv3Bb
	 qpthtZlaZqJYoiUTBGdP7gTKmK9aycPIQq92FhwLRPfIiQ9p8pR1/2rbXG0ri0adG+
	 +iaEXbPw08lYA==
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
Subject: [PATCH v3 11/58] objtool: Forward toolchain variables to the klp test runner
Date: Mon, 14 Sep 2026 16:03:08 -0700
Message-ID: <20260914230355.3422996-12-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
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
 tools/objtool/Makefile                          |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index ed5cf146ef2e..a3d09a5af7a2 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -153,6 +153,8 @@ mrproper: clean
 
 tests: $(OBJTOOL)
 	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
+		CC='$(CC) $(CLANG_CROSS_FLAGS)' LD='$(LD)' \
+		READELF='$(READELF)' OBJCOPY='$(OBJCOPY)' \
 		KEEP=$(KEEP) $(srctree)/tools/objtool/tests/run-tests.sh
 
 FORCE:
-- 
2.53.0-Meta

