Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4825771;
	Sat, 17 Oct 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196689; cv=none; b=plZ902DA7IPmNObRAPsnzKjs+ZedJupEan3nej+ok18xYkuhUCj5DrLbRYI0gUVhRW0c7FSrjopzKMzg5EntYHYCpTCHwhD0VTNDLZMJjC+QqAM2kLJ5ZjceVrgjbkoI7A7ygFEG2HQTZKcW8rBL1lRHD5AJscUsof7MCZ17Nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196689; c=relaxed/simple;
	bh=6G5n0FDPTPjR9sBseTwJxbMei11euc6KKl3QHSgP3Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUlGOOeErrlKvwlWrmz9zIbKTI7gimLYi2nEb8DGgHkwI+x5xoNUbw0x28ZXbL6eb7fh21J59kvaNZkAc/ic3x7+RIaQ9agDXNMesw0hhjI06o5p/mV/hoIalh+ZBKWdXr4Wmfn4aoAE/C6hPlrot1JwWNm3otKRC5xwxl7eKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlvWTnsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlvWTnsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695031F000C4;
	Sat, 17 Oct 2026 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196687;
	bh=9fzL5hMra9kEevlYPK33fLecenioscGbo/vl/rIlX04=;
	h=From:To:Cc:Subject:Date;
	b=TlvWTnsazbjZzkZlDuUYuCiLFDbW3wL3EJkR7IMhxSM1oweaOourvg1jDuySXqafF
	 GH93mqKfeS3AQbjthAjIOnFOTT2Qh8P3Wg7YRqsF/I7vB8a5embQU6UNHC+/2LDjtP
	 NkhjcfXnZX9x4zYFV+4rB3wBGl29260EbiqiZUw9VFm+XRsXtWGeUi3EC+OOgw36LJ
	 iYW0oXRCgj6c7meOPLdY3e8D5SEFsDrPYZrPxNX3ZvQlAj+60T5IEX/M2JhChLLNCh
	 uMgUyQYAbOfVL1ptmK95Ln/LZiszDbma6lZZwttxdGCkCU2rb8R4B8W9ZNQ6Tdo3XX
	 5gH/VdyF+4QGQ==
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
Subject: [PATCH 00/11] klp-build: Fix dependent patches, add selftests
Date: Fri, 16 Oct 2026 17:24:30 -0700
Message-ID: <20261017002441.716615-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp-build fails when a later patch in the series depends on an earlier
one, because it fixes each patch against the original source on its
own.  Patch 1 fixes this by combining the patches into a single patch
before adding the #line directives.

So far, testing this step has needed a full kernel build.  Patch 2 adds
a --patch-only option, which validates and fixes the patches, prints
the result, and exits without building.

Patches 3-11 use it to add a kselftest target, livepatch/test_klp_build.
Each test builds a small source tree, runs "klp-build --patch-only" on
some patches, and checks the patch it prints.  The tests compile
nothing, need no root, and take about a second.  To run them:

  make -C tools/testing/selftests/livepatch/test_klp_build tests

Song Liu (11):
  klp-build: Fix dependent patches in a series
  klp-build: Add --patch-only option
  selftests/livepatch: Add tests for klp-build's patch handling
  selftests/livepatch: Test klp-build with dependent patches
  selftests/livepatch: Test klp-build with patches to different
    functions
  selftests/livepatch: Test klp-build with patches which cancel out
  selftests/livepatch: Test klp-build with created and deleted files
  selftests/livepatch: Test where klp-build adds #line directives
  selftests/livepatch: Test klp-build's rejection of unsupported files
  selftests/livepatch: Test klp-build with patches which don't apply
  selftests/livepatch: Test klp-build with patches which need offset or
    fuzz

 scripts/livepatch/klp-build                   | 121 ++++++++----
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/livepatch/README      |  16 ++
 .../livepatch/test_klp_build/Makefile         |  27 +++
 .../livepatch/test_klp_build/functions.sh     | 150 +++++++++++++++
 .../livepatch/test_klp_build/run-tests.sh     |  68 +++++++
 .../livepatch/test_klp_build/test-basic.sh    |  57 ++++++
 .../test_klp_build/test-cancelling-patches.sh | 102 ++++++++++
 .../test_klp_build/test-dependent-patches.sh  |  72 +++++++
 .../test-independent-patches.sh               | 124 +++++++++++++
 .../test_klp_build/test-line-directives.sh    | 175 ++++++++++++++++++
 .../test-new-and-deleted-files.sh             |  94 ++++++++++
 .../test_klp_build/test-offset-and-fuzz.sh    | 120 ++++++++++++
 .../test_klp_build/test-patch-not-applying.sh |  73 ++++++++
 .../test_klp_build/test-unsupported-files.sh  |  30 +++
 15 files changed, 1189 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Makefile
 create mode 100644 tools/testing/selftests/livepatch/test_klp_build/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-dependent-patches.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh

-- 
2.53.0-Meta

