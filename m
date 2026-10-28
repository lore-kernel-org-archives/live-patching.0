Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223941;
	b=s2qH9Z9MaMXZld2VZO4Y56z6l13Qz79h0J77OOoVNErVLPrtX3yi57PoKQRCpn37LvF+
	 Eb9+5h+iMmzTV6HK5r2iscUYaVYF9xxu7Hkb5bBXkYY66BF6LVatKA6h4uUMUHDHHMfRj
	 x1BgFr31mcPJDcJdsyYqZzI6Qf+BU75RtkpPws3GC59+pnQ32Z1rwqFD8M8fseRqn8eIr
	 R2k08yb52foj+nisManv13OnTmVtRLtVr80CF46Fz1UJYondVRx4qlrP4Uvpsy3UG75Xf
	 bjkS5hphpIkgL198htYwDZ2J//kq6fGRWNlA3MiGzN+RFHuCEGg+dPOD3QCwAWpawEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yFNarfJGA92cpgfiM4NgxjTSphO3sijmtYGw3WwbWrI=;
	b=Y8TCrabosfosBVc2jJr+o0nFUj3kB8VCFCJ80aZ9T6Pdoc8gS1AdlUpeaw4CFRzs7Kvk
	 8tlBMhJaSrKM/DDBUQCB5bMcyABiExsTxu26V3pZcNwrIK3a/hpG3MuHA9ubLkplVQ7OG
	 e+MdJo4AlE5Em9zutuGQbcp+O1PGMEUXyLh71w34fD1QtwcmoIOWv+XvrHMrGgFA5aFgo
	 kF0nM/sfim/AcsugLHZI2JfowJzDHc6rNHDNLLtS5JfSufon/FN68gnH+VeZbUZO2fZXF
	 IxaH8YyK9mm0tW3rhLdbc/obNYAyQPZGFB7srZFEGg74FaSLQP6t9ugFwDJFoMxpMhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ta/yWIER";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B607606A320;
	Wed, 28 Oct 2026 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ta/yWIER
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AF41F01828;
	Wed, 28 Oct 2026 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223941;
	bh=yFNarfJGA92cpgfiM4NgxjTSphO3sijmtYGw3WwbWrI=;
	h=From:To:Cc:Subject:Date;
	b=Ta/yWIER+NH6kyBL2n+l/QOIrKqwV1TZ05trNvDJzIIBx5p/rjXP5XhsQzeCpHL0G
	 5I5kHgNLuE8wFCDCytKeQ4cBZ0r0s0yiZKmPz9bUw6mtGUPJg02ag15syUndenlHH4
	 JgXrqgqQ3AagxOfo4tKq5RONviKpVaZZGpHGY4K2aeYa96YUqZ+Jn3UsQpz0ycEo06
	 uAjCqbEM+IZS19WiAiIT4zUP6pawFY52QGJMjNh1uNBetortB99GQvxHrjK935JkCY
	 izFYGcIQIpYUZAVPndyOPxARIjvSRsE2xi3zEr9gzlNXqFkC/SKHdi3MBuL1Ch2A9V
	 lWQUB4PsmI60Q==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 00/12] klp-build: Fix dependent patches, add selftests
Date: Wed, 28 Oct 2026 14:45:22 -0700
Message-ID: <20261028214534.1919398-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
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

klp-build fails when a later patch in the series depends on an earlier
one, because it fixes each patch against the original source on its
own.  Patch 1 fixes this by combining the patches into a single patch
before adding the #line directives.

Patch 2 does this while validating the patches, before the original
kernel build, so problems with the patches show up without waiting for
a build.

Patch 3 moves the patch processing into a new script,
klp-prepare-patch, which klp-build runs.  It doesn't need a kernel
build, so it can be tested on its own.

Patches 4-12 add a kselftest target, livepatch/test_klp_build.  Each
test builds a small source tree, runs klp-prepare-patch on some
patches, and checks the patch it prints.  The tests compile nothing,
need no root, and take about a second.  To run them:

  make -C tools/testing/selftests/livepatch/test_klp_build tests

Changes in v2:
- Patch 1: describe combine_patches() without "refresh", rename
  fix_patches() to process_patches(), keep the combined patch in
  $COMBINED_PATCH rather than $PATCHES, change the status message to
  "Processing patch(es)", fold get_patch_{input,output}_files() into
  get_patch_files(), and keep tmp.patch in klp-tmp (Josh)
- New patch 2: process the patches while validating them, before the
  original kernel build (Josh)
- Replace the --patch-only option with a klp-prepare-patch script,
  which the selftests run directly (Josh).  The intermediate patch
  without #line directives now lives in klp-prepare-patch's own
  temporary directory, which is removed on exit.
- Make the dependent patches test a case of test-basic.sh (Sashiko)
- Name the selftest helpers and subjects after klp-prepare-patch

v1: https://lore.kernel.org/all/20261017002441.716615-1-song@kernel.org/

Song Liu (12):
  klp-build: Fix dependent patches in a series
  klp-build: Process the patches before building the original kernel
  klp-build: Move patch processing to klp-prepare-patch
  selftests/livepatch: Add tests for klp-prepare-patch
  selftests/livepatch: Test klp-prepare-patch with dependent patches
  selftests/livepatch: Test klp-prepare-patch with independent patches
  selftests/livepatch: Test klp-prepare-patch with patches which cancel
    out
  selftests/livepatch: Test klp-prepare-patch with created and deleted
    files
  selftests/livepatch: Test where klp-prepare-patch adds #line
    directives
  selftests/livepatch: Test klp-prepare-patch with unsupported files
  selftests/livepatch: Test klp-prepare-patch with patches which don't
    apply
  selftests/livepatch: Test klp-prepare-patch with offset and fuzz

 scripts/livepatch/Makefile                    |   3 +-
 scripts/livepatch/klp-build                   | 137 +--------
 scripts/livepatch/klp-prepare-patch           | 277 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/livepatch/README      |  16 +
 .../livepatch/test_klp_build/Makefile         |  26 ++
 .../livepatch/test_klp_build/functions.sh     | 149 ++++++++++
 .../livepatch/test_klp_build/run-tests.sh     |  68 +++++
 .../livepatch/test_klp_build/test-basic.sh    |  93 ++++++
 .../test_klp_build/test-cancelling-patches.sh | 102 +++++++
 .../test-independent-patches.sh               | 124 ++++++++
 .../test_klp_build/test-line-directives.sh    | 175 +++++++++++
 .../test-new-and-deleted-files.sh             |  94 ++++++
 .../test_klp_build/test-offset-and-fuzz.sh    | 120 ++++++++
 .../test_klp_build/test-patch-not-applying.sh |  73 +++++
 .../test_klp_build/test-unsupported-files.sh  |  30 ++
 16 files changed, 1366 insertions(+), 122 deletions(-)
 create mode 100755 scripts/livepatch/klp-prepare-patch
 create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Makefile
 create mode 100644 tools/testing/selftests/livepatch/test_klp_build/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh

-- 
2.53.0-Meta

