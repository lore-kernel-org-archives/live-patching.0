Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9C4078CA
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152773; cv=none; b=jqa04GsC0HKUZRgFo541XgoLEb4TtwXiVS/8vpdfhqG6+B42m9ZqQR2sksSG87By9J2htbKqxLrHtG7q7NStnsw8QrCVQIH87Xtp81PuBf4NqdkMXVrNGTt/7Hq2vGAdjFHrOEjhU0issPlEg+lfs++L9R4i92LcrVoplPmq/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152773; c=relaxed/simple;
	bh=563yzkvl7uM57G3+9mkAixCH4+qiL4GrvqIJGnYc2fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ME2wnSP8xYZoF3XeawOBL7fJCBNKUrTpgLbEb204o2VwlpvK0lp3gtXF2RcR97vapvI/tZRz1OrtaDSCnk+uNzzSnYAuPFRq98Ph9Zk8hsPPGM5AA+lncJBKmASwUCXH+FlWnBt8LvlZXFKEpvIzMy7ty51C5WEN/yp7A9Qbj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpt8Lrpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpt8Lrpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255F31F00898;
	Fri, 11 Sep 2026 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152768;
	bh=kecb0ZgddCo9jpJe57fc6fPyQU0Zi7rcMyXaq056HJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpt8Lrpcitx5G23ZfimobcVf3RIR1oqA2qORFX431va6wz+QjcshhBBNHzYKdDjA+
	 xhEE6ij0R3Nly1KbABPKz50YKM73JIZJmWPdqOsC1GiOjGpb9dDq9ghosDS/87HQ14
	 u1P13IJG2jzCDltVwy1pHAF40DzFHdpXMTnk5jxJgb3de97y81B9fNgfcezLS4uC/o
	 Gv0tEqOfy3FA9L4TNKRqFT4SRHyBRBByUXFKlghhXWKycCxpKKy4Zcn2HdKXmuBALz
	 +VH9Enb6nA9K6seQOvxKMP9FQtVkUUvaJvbe+FZo+l9ZKQJdn+zQP/QfLJhwT3pxQx
	 AS44NlEwo5OGg==
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
Subject: [PATCH 50/58] objtool/klp: Add test for a static call introduced by the patch
Date: Fri, 11 Sep 2026 11:50:23 -0700
Message-ID: <20260911185031.1534046-25-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911185031.1534046-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The counterpart to the static branch case: a patch may add a static call to
a function which had none, so the .static_call_sites entry is new and there
is nothing in the original to correlate it against.

Where the key lives still decides whether that is allowed.  A vmlinux key
is reachable; a module-owned one is not, for the same reason an existing
module key is not -- late module patching lets the livepatch load first and
the unresolved entry is dereferenced when the module arrives.  Both halves
are here because they fail in opposite directions: dropping the new entry
leaves a static call the kernel never patches, and accepting a new
module-owned one is the corruption the check exists to prevent.

Extend test-jump-label-new-key with the module half of the same question.
That needed the vmlinux export dropped first -- while the key is exported
it is reachable and being new changes nothing, so the first version of that
addition passed for the wrong reason. klp-build unit test corpus.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-static-call-new.sh     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-static-call-new.sh

diff --git a/tools/objtool/tests/generic/test-static-call-new.sh b/tools/objtool/tests/generic/test-static-call-new.sh
new file mode 100755
index 000000000000..f7d2b39c0fec
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-new.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch may introduce a static call where the original function had none.
+#
+# The .static_call_sites entry is then new, with nothing in the original to
+# correlate it against, so klp diff has to carry it into the patch from
+# scratch.  Where the key lives still decides whether that is allowed: a
+# vmlinux key is reachable, and a module-owned one is not, for the same reason
+# an existing module key is not -- late module patching lets the livepatch load
+# first, and the unresolved entry is dereferenced when the module arrives.
+#
+# Both halves are here because they fail in opposite directions.  Dropping the
+# new entry leaves a static call the kernel never patches; accepting a new
+# module-owned one is the corruption the check exists to prevent.
+#
+# Covers the same ground as corpus/x86_64/static-call-vmlinux-new and
+# static-call-module-new in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_call.c -DNEW_CALL
+
+# The premise: the original really has no static call, the patched one does.
+has_input_section orig.o .static_call_sites &&
+	fail "fixture put a .static_call_sites in the original; nothing new to add"
+has_input_section patched.o .static_call_sites ||
+	probe_skip "compiler produced no .static_call_sites on this arch"
+
+run_diff
+assert_patched target
+assert_section .static_call_sites
+assert_reloc_sym .static_call_sites target
+
+# The same new call, with the key owned by a module: not reachable, so the
+# build has to stop rather than emit a relocation nothing will resolve.
+rm -f "$workdir/out.o"
+build_pair static_call.c -DNEW_CALL -DMODNAME='"klp_testmod"'
+run_diff 255
+assert_diff_log 'unsupported static call key __SCK__klp_test_call'
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "static call introduced by the patch carried in, or rejected for a module key"
-- 
2.53.0-Meta

