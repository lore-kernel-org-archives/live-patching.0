Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64484FDE77
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584340; cv=none; b=eiU5iLVXeuaA+O0IXKbHrIzN/I52nIct+g80O4D6e2ijtPPIKwdw6pMbJQPaH4csYpeF6udjue+N17XaP8Z6m4mTiVKY0R1OSPw/moMOHzRKGBQtNfrp3Zf/SahusKT1BygISrP8nB8oA28Ke3uO/bj85qG3l1bT36VJs7HEWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584340; c=relaxed/simple;
	bh=nfGfU3LaIh7bgGt7j7/PkZRVj5wdsODeLERr39LlXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY5LJAynSMizyE2ei3UHEqI58hEwT2m3YUur5uhW6szcjdGs+VGXn2+cjDfxrxv/gQu50sUEaXwVqKViPRGG1IeNBA3+QGwSqV/VIGGenMpd33i5kHh2drI2fIOCGZgYfaLl63RPrBrsPmud2P5xoha2r9+kJFLO+sukDDokQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbLGZR/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbLGZR/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4058D1F0089B;
	Wed, 16 Sep 2026 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584334;
	bh=w+q/DLez5PlneJgCmCrVqPe34qCrkcVpE4zDb70j/T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbLGZR/mBP47ypYejd9krAaXYSGPiKdglZu14iuPNVNJwjckpfB8g9k77z0zcWEsO
	 oxwkf+PpOUXNdlojlPSX1StgUbucw+aCrkrGAJre2UNSdhV5BdeHxckEMkCOTIxVeX
	 LMV/3YBGTv/EhItZRbtf1AB6s0JuY7HFpT5ofw260KdJMAbgQHd1FDJvEL97ixA3/2
	 RKGmG0Zq4AM5kLWsfQwC5h/8DY7Sinkk9cGBSVVnHKv9/n4cLcp66M018/qEM/Jj1I
	 3rPMlYMlZVXMNk+HbTXL6ap3LISMLc6nJyfXepP9CrYyf9zf0zZLmo5IN7FCuvOB+L
	 GcjxkDH0DJQ/g==
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
Subject: [PATCH v5 20/58] objtool/klp: Add test for rejecting module-owned static branch keys
Date: Wed, 16 Sep 2026 11:43:13 -0700
Message-ID: <20260916184351.2720310-21-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

A static branch key belonging to a module cannot be reached with a klp
relocation: the patch may be applied after that module's static branch init
has run, which corrupts the code.  Emitting one anyway produces a module
which loads and then BUG()s the first time the key changes state, so klp
diff has to refuse it.

The fixture differs from the accepted case only in the module name recorded
in .modinfo.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/test-jump-label-module-key.sh     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-jump-label-module-key.sh

diff --git a/tools/objtool/tests/generic/test-jump-label-module-key.sh b/tools/objtool/tests/generic/test-jump-label-module-key.sh
new file mode 100755
index 000000000000..7c3f82cdd3c1
--- /dev/null
+++ b/tools/objtool/tests/generic/test-jump-label-module-key.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A static branch key owned by a module cannot be reached with a klp
+# relocation and must be rejected.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair jump_label.c -DMODNAME='"klp_testmod"'
+
+has_input_section orig.o __jump_table ||
+	probe_skip "fixture produced no __jump_table on this arch"
+
+run_diff 255
+
+diff_log | grep -q 'unsupported static branch key klp_test_key' ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "module-owned static branch key rejected"
-- 
2.53.0-Meta

