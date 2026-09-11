Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432640B6D4
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152792; cv=none; b=LJ1zvue+gSiX3bswU63YIiP/+dcK3iRKBKfw9D6QQvE4naCnLLIvp6ClYQE5QqNpWRFE5kCJq4aA76eZml8DDJH+PvdLpOiFpsGBZNe5gW7AGYCac5JDPh6UEnNivSigzR2AlNuI4QxvSZSr4rqcyyRMJN7qlYIKive4BM2PCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152792; c=relaxed/simple;
	bh=GMmY1M1guuuc3OFguEzpFu2htDQLuCYzhNNAdSmwzhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5R4/FHnSr2SKkm6VrkyBFT5tMJSSWLsZRzMInaGoHPQkqTO1Ulhp8sITG8GMaPSqF4uYhmiXj7ooqXjvufqKGXan1gGiMg/2nwng2L1WBGjkYHHnW1ismD5/8CUau1Jws44n1XauO1fonlnuQWECZwnQ7Igvog4ycEV6JPyXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYdDm8Hh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYdDm8Hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8381F00893;
	Fri, 11 Sep 2026 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152787;
	bh=26cd1MuaR4zG9uTsivySe11kqLamlpg9Z4sHrfrv75c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYdDm8HhwBM6WKqp5poKzmmifoD3rTcyYBh0cEOlauUdY+7b4uII1v83q4uFjxU2P
	 /PutxF2PYfCZVYT4V5tZdQyX/R75tkgF6wpiwGLya3+z4WAouWhhQMjs2+u5SEc4TQ
	 yi06DDxex5BgKz+zhtqyFjETb2zpQ/vL8kMKcSISXBY7vpHfQ5bLv2Dm5lXJ/kNHS5
	 rHmAIHOnouEdydqR+ayltCE+n+Uofw+uG7boQptc1P1WyhXyCtjbOJdbBPDQaMlzT1
	 G1RYugQID/bBEnA0ePSjNDs1Pf9c74jjuAkw3KjMdVjs2ayLWRwTnrF7BZUNLYYgTu
	 6jxNbd9jF4oEQ==
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
Subject: [PATCH 54/58] objtool/klp: Add test for a patch which strips a data annotation
Date: Fri, 11 Sep 2026 11:50:27 -0700
Message-ID: <20260911185031.1534046-29-song@kernel.org>
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
 .../test-static-call-annotate-stripped.sh     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-static-call-annotate-stripped.sh

diff --git a/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh b/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
new file mode 100755
index 000000000000..bdbc0a21c669
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
@@ -0,0 +1,41 @@
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
+# Fixed by 5c134aadb0d9.
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

