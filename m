Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2A397E86
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367421; cv=none; b=jlskYSxjImiBR2Q8iSutS8N5oK1eElaWyaZDB4w+2bfmS+kEa95pw8IzTH8b4YAIzS26uDTltkF7fz0MukDBuxbDTQWKZbq2510jvu/4vvvPkU3PepSgO2nA3Mn8zj5ApmRm87l59NzdaWUr9TMFUONeSSpXH0hAiTos523DnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367421; c=relaxed/simple;
	bh=FGb2aQyX7NyyKBhjchuvgIYGATaiwX3/EywyJ6hG3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Votky3G9esG7cP5gXiKQ9yEm3VCcclxuy+r5b4Gbfv5qOgUgIr9ur43T8XyG+eyeSa+z+4hgeFo4+hebAyuzKbsMYnf1VyAgv4nYPSK6pyf2ACQt3jOHVqqS5kmi/aaVSNP0GhqCHPQ5QvN+ikFkoOccGwpcQmkAcNnXpxeIo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL5hdWsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL5hdWsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6121B1F00893;
	Mon, 14 Sep 2026 06:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367416;
	bh=40Xjg1WBvFiz/vd2PQBiblx5fPDphgAkDmglsYBmaSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BL5hdWsvhiGDQPsEXMxacvUwVLxeSt/IVuiz4zfzFupGwM93DMy9Mj5IZJqZeZr7p
	 AyIb8Np99yFhhmecq3jhsM6ckb0rs9AMK/ts+ZnOQeEb7L2MaHVXeDHDY5FGvmbouC
	 aOKo9rkd1YxYGSuhF3FW4JG/mCSZR3PzIlxwibsjILEiljnaronpyFMs3w7EBbib68
	 AYMy6AtsjLCADogdSdEu9Zu72kRJ0CQbuoy7advmM1L0OPdLKsFYUu/QJBdnxECyrX
	 7uQY8pgAm7KJlMBJzHG8dYKkCNVp8yo0+d+AJzXsyLi/jJhjnKaN3nkEgcgGKr7x4j
	 OEecd8WaBa19Q==
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
Subject: [PATCH v2 54/58] objtool/klp: Add test for a patch which strips a data annotation
Date: Sun, 13 Sep 2026 23:25:10 -0700
Message-ID: <20260914062514.926997-55-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914062514.926997-1-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
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

