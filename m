Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE64BE444
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152305; cv=none; b=pZuiZDYxmfufcQ/mhRLTVSB7LRi3Bv5J5p3EPC/WsXmpqLaByyu1BpqDG5BP/R5c26GWZAGRjwycDRMpk/yC/S02GMODGltC822T/sK9EdHqib7yaaoFDpPgP07duUFsyemGWf/B9o94bCptZC4mgUw4NIAOSl/O7PqE7Cto2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152305; c=relaxed/simple;
	bh=oKIexGl6o6IfAOL4dK7/YEbBhpvrr9QsCqKSbZFVo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN/+c5mt1qPgK8scJ7JF1lfzdU6oEkShUv97c1ZwQaIDaqDIESB9v6xKKICKaH2X9sttGLAc5nJHR4UBVhsxrKjvZruIkQz5vTJ1A8iH83y09fn0REUOjmEnBE1QPsHeA6IiKvGARCi1O+yuW7HZpBU3FoDRRDlsGOzn05wiD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADYIEpyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADYIEpyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4741F000FF;
	Fri, 11 Sep 2026 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152302;
	bh=hNDwDggAztrl0d+M2aMDRMhoGtFrpvA2reEhUA87y1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADYIEpyZsu0wv+kIBYIodEKJ3GgXc29WwxWO6PP0erFkquGrOfig0sh9NC1hmTAd4
	 1O7mGyIFRUfJkRgb8y5KEyFvmqvCI1NY0WZxUMUv1La9Wj5Kl+S3JJPu7w6WnAfoRb
	 qECQqDspqKRAbMGNeFo903ZCXCCXWiwjYXrn/NL++aDEyJiwpnypE/A5sytqbu03nD
	 TMW9vP0khEe9HGNNM+iNEbHAJ7N0wD12Nw8FajEWn+dhMWaVRCY6TKxIKRqxPo6j5c
	 jllg+ug2MXFZ91FYwNKEUXfCcY+dcyzoTgyb7F9kbv1cllfEEklhq6Cb12konWamUN
	 m5Hg1uks3ZS+w==
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
Subject: [PATCH 17/58] objtool/klp: Add test for special section extraction
Date: Fri, 11 Sep 2026 11:42:24 -0700
Message-ID: <20260911184305.1457308-18-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

create_fake_symbols() gives each special section entry a symbol so entries
can be extracted individually.  Entries with ANNOTATE_DATA_SPECIAL are
handled first; the rest have their boundaries derived from the entry or
relocation size.

The second pass has to key off whether the first one created symbols, not
off whether the section already has something at offset 0.  Clang puts an
assembler-local label at the start of .kcfi_traps, and treating that as
already handled means nothing is extracted: klp diff still reports the
changed function and succeeds, but the special section is missing from the
module.

The fixture reproduces the shape without needing CFI or x86.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/special_section.c  | 24 +++++++++++++++++++
 .../tests/generic/test-special-section.sh     | 20 ++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/special_section.c
 create mode 100755 tools/objtool/tests/generic/test-special-section.sh

diff --git a/tools/objtool/tests/generic/fixtures/special_section.c b/tools/objtool/tests/generic/fixtures/special_section.c
new file mode 100644
index 000000000000..d28c5541e337
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/special_section.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Special section entry with no ANNOTATE_DATA_SPECIAL annotation and a local
+ * label at offset 0, the shape Clang produces for .kcfi_traps.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int target(int x)
+{
+	asm volatile(
+		"1:\n\t"
+		".pushsection	.kcfi_traps, \"a\"\n\t"
+		".balign	4\n\t"
+		"trap_marker:\n\t"
+		".long		1b - .\n\t"
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-special-section.sh b/tools/objtool/tests/generic/test-special-section.sh
new file mode 100755
index 000000000000..b6a9139c0062
--- /dev/null
+++ b/tools/objtool/tests/generic/test-special-section.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A .kcfi_traps entry belonging to a patched function must be extracted even
+# without ANNOTATE_DATA_SPECIAL and with a local label already at offset 0.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair special_section.c
+
+in_symbols orig.o | grep -q 'trap_marker' ||
+	probe_skip "fixture produced no .kcfi_traps on this arch"
+
+run_diff
+
+assert_patched target
+assert_section ".kcfi_traps"
+
+pass ".kcfi_traps extracted despite a local label at offset 0"
-- 
2.53.0-Meta

