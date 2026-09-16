Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE64D599D
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584511; cv=none; b=QOF6N504xBP6esY7xKMhd5HtuQGK66QNsJ9WZwLwP3WXRmXJDOt1+FIrAkRlK/SEsK1Qh8JckuA1O65WILJ0GcmLk/m/00PX1OM34cIu1LeQTqgYZ6etcmx6E8Rdh5hv/69Oqz6qN9EmNlGGZw7A1TEV/r9mvgPpMWVPpWXkXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584511; c=relaxed/simple;
	bh=FGb2aQyX7NyyKBhjchuvgIYGATaiwX3/EywyJ6hG3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aET9NSxEG/veXyp6RjBSDXjAijIYFoz1sgA/BLQ1b1Um0a4tMx4o5dh/3iRJ3Cm+r+KQXc3fzc71KWE54x/Yw90USBhc6mx44Q0wk9HkU+jD39gtA3RDzBjxJsBGZY42PvXnaTAHzXJiHM1GlQL4xX5Dd0UPXFIhlx0q3onRCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJZXuHDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJZXuHDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C421F00893;
	Wed, 16 Sep 2026 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584497;
	bh=40Xjg1WBvFiz/vd2PQBiblx5fPDphgAkDmglsYBmaSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aJZXuHDr4rFRKieuV/rwvJgFg/IS7HhujfRIKjdBfCPkK7w/c6y8YeByQTpIbyUNP
	 lECyuOQ6UX/VKmaYZrcu4pnD2d36rwaEjcGysI4/ltGkzLk0g7Z6ZMs08ZdoGJmoGt
	 GpNSSRqVgYnZ8zSn4p31DUP/VR3tC9CBWmQW0ppGMl0xWOCkaHNYpkKXBvl5maL4tn
	 7n9ueVl5/8uyD9YJQlKrPciuS1ZuhDn9h+sy63kjkKp5vGBtNl2KlduMRYiPVS24+G
	 d2qYyWOp9Me/7YBCqrzVP+W98MVoPMeW9e5DZ/2PQqd/S6shVRXnO3m1KIMr2ImmWL
	 C+6nKLmCzizSg==
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
Subject: [PATCH v5 54/58] objtool/klp: Add test for a patch which strips a data annotation
Date: Wed, 16 Sep 2026 11:43:47 -0700
Message-ID: <20260916184351.2720310-55-song@kernel.org>
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

