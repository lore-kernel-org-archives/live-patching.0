Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49C352030
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427305; cv=none; b=uek34OwsUcL4jZozohInAwxaCn/D6K8LokGjPUrQ71B3Re46UdFr0aOAaKyzcMI9IEFSKqSwPr7yrgtK5URR5HZvhP3OLZZ6/WFISI0o2P8GdtEJVbM6OYs+8NBddEU1UYkhXdtwD5mPp5cNdxX5oonKZ8t30T/t8ZCL8UCX2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427305; c=relaxed/simple;
	bh=FGb2aQyX7NyyKBhjchuvgIYGATaiwX3/EywyJ6hG3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAq+lIdEGqiVluUM5944mj1ocaypeytgQcbpCmro428e/wbdn7dKtgYI9zoVKyzbNt2NWtKLX4wXkcMVqdsmgx7b4M9HxWRDzZFvR4J09/Kqy3YYFL6Plb+Q3DQ1xe28f+3bHtRvMOamOG5jtjTFa+BUhAeFIOq7/EUyLaf9KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhoJjaDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhoJjaDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD8F1F000FF;
	Mon, 14 Sep 2026 23:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427304;
	bh=40Xjg1WBvFiz/vd2PQBiblx5fPDphgAkDmglsYBmaSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhoJjaDaMiQCelALLBQjx9Y+yXs/kwa+PQSTHJzuRPeV1vWnYg4fbd6GM5OTyI3NC
	 um9DGkC0Zzwv9GKlnTWiNgfGsATL8D7mlkedM7O4173Xl93JJb0CO4l6IVimS7Bsky
	 Ijk8RbTRqV2RMw4QyCk29iBDnvopdmJ5CFUwDIxPBrXORdSAxJSkUEcL0by+i/czIw
	 qlXAHHcGjkvR2MVGtxT81Ov3QDnA9fxe7sPz5xD4J1bbhVt9eKfCBb2LvJmH50t2DQ
	 p5PiwUJdTgeRUGMwtlNm/9D+RcvYUffk99CH71kN+nfHdk1vAKBExo4JwdeE8sBbe1
	 icOxvmajkUmKw==
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
Subject: [PATCH v3 54/58] objtool/klp: Add test for a patch which strips a data annotation
Date: Mon, 14 Sep 2026 16:03:51 -0700
Message-ID: <20260914230355.3422996-55-song@kernel.org>
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

klp diff needs entry boundaries for a special section: either an entsize,
or ANNOTATE_DATA_SPECIAL annotations naming where each entry starts.
.static_call_sites has no entsize, so the annotations are all there is --
and a patch can remove the last one in a translation unit while leaving the
section itself in place, so that only the patched side has lost them.

The section still has to be handled.  Dropping it leaves the patched
function's static call unregistered; misreading its boundaries attaches the
entry to the wrong code.  Neither is reported at build time.

Give the fixture a NO_ANNOTATE knob and assert the premise -- annotation
present in the original, absent in the patched object, section present in
both -- before asserting the result.

Fixed by commit 3de711fba73a ("objtool/klp: Fix create_fake_symbols()
skipping entsize-based sections").  Verified by making klp diff skip
.static_call_sites when cloning special sections: the test fails.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../test-static-call-annotate-stripped.sh     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-static-call-annotate-stripped.sh

diff --git a/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh b/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
new file mode 100755
index 000000000000..818b047ed4b6
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch may remove the last ANNOTATE_DATA_SPECIAL in a translation unit while
+# leaving the special section it described in place.
+#
+# klp diff needs entry boundaries for a special section: either an entsize, or
+# annotations naming where each entry starts.  .static_call_sites has no
+# entsize, so the annotations are all there is -- and when the patched object
+# is the only side that lost them, the two sides no longer agree on how the
+# section divides up.
+#
+# The section must still be handled.  Dropping it would leave the patched
+# function's static call unregistered; misreading its boundaries would attach
+# the entry to the wrong code.  Either way nothing is reported at build time.
+#
+# Fixed by commit 3de711fba73a ("objtool/klp: Fix create_fake_symbols()
+# skipping entsize-based sections").
+#
+# Covers the same ground as corpus/x86_64/static-call-annotate-stripped in Joe
+# Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_call.c -DNO_ANNOTATE
+
+# The premise: the original describes its entry, the patched one no longer
+# does, and both still have the section itself.
+has_input_section orig.o .discard.annotate_data ||
+	fail "fixture produced no annotation in the original"
+has_input_section patched.o .discard.annotate_data &&
+	fail "patched object still has the annotation; nothing was stripped"
+assert_input_section .static_call_sites
+
+run_diff
+
+assert_patched target
+assert_section .static_call_sites
+assert_reloc_sym .static_call_sites target
+
+pass "static call site kept when the patch strips its data annotation"
-- 
2.53.0-Meta

