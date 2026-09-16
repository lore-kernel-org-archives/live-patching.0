Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F363E1CFB
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584391; cv=none; b=kDqvZX+1AZ8lyKrwF3MQqy8GF9HUzOPypiZP1WrUnVub/E//cWcMNTVL18jwS1FMlyloJlH7qXmA6H4k7om4V7+Q35u/KqIDdb8EbM3Lmo/oSGfpCuBu8NmzkgXK/ONDc0oVSPwQbny/aMizE/st0nahjz1UclS7CaYv6NYxCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584391; c=relaxed/simple;
	bh=fp7uH4g7UVaSHgTTZTyKGs1C4fQ+N2Obxw3D4TSfgEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3b5Mu1ocfclEprRD9s3mTwiTggmo1lz/opM6eefJNuuf7aNpQVklCpZvXvuEaeWJb7uxT7CAUFTnd8wdWmAThqWe0LU8XwBgoU/Z65+XiAOXhFlEOOCWeieWSmCkhdmyZq8s5abXN7H60eVqr0WTfSvnxkMVM5jlU7P7suTmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqyTZKzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqyTZKzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289AB1F00899;
	Wed, 16 Sep 2026 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584358;
	bh=CT3mBjx9tGaHecf9KO04lllAlSlXs736+0nIt07OCgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HqyTZKzHys8xl1dsvzIy3XZIj+bCbRJYt98//hp1Y1fUP5jiWkiAQlRB2OGbDj1xK
	 By9pgOuM85y92hylRNjkZ7KbGUCw0pn+v0VxVlxB+KPc+LhouNkRH8jGoJEDFlwlQ3
	 BTe2I27cjkbNmP+YbLKnTKEjadyd2lzc5nhUnqLXJ6OAC14/kqqK1fYj0zFvweAyJu
	 /CsI2laN/1L5BRWMBDE84lliCkD41Y0QClvjAGhdFrNoV97H1JfzlgLg3FcqxGrrfM
	 7713RGLR9yuf6c59BodoIVns1uy5CNW6Gj/DsQMYNEvE+Zyd1vd0T2T/LjeUnaD8sk
	 0UMHkZptbVhLQ==
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
Subject: [PATCH v5 25/58] objtool/klp: Add test for objects without .modinfo
Date: Wed, 16 Sep 2026 11:43:18 -0700
Message-ID: <20260916184351.2720310-26-song@kernel.org>
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

The module name recorded in .modinfo ends up in the livepatch's klp_object,
and also decides whether a static branch key counts as belonging to vmlinux
or to a module.  An object without one cannot be diffed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/generic/fixtures/no_modinfo.c  | 11 +++++++++++
 .../tests/generic/test-missing-modinfo.sh        | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/no_modinfo.c
 create mode 100755 tools/objtool/tests/generic/test-missing-modinfo.sh

diff --git a/tools/objtool/tests/generic/fixtures/no_modinfo.c b/tools/objtool/tests/generic/fixtures/no_modinfo.c
new file mode 100644
index 000000000000..e46374702b1a
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/no_modinfo.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Deliberately has no .modinfo section. */
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-missing-modinfo.sh b/tools/objtool/tests/generic/test-missing-modinfo.sh
new file mode 100755
index 000000000000..6f242f7eb756
--- /dev/null
+++ b/tools/objtool/tests/generic/test-missing-modinfo.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# The module name in .modinfo ends up in the livepatch's klp_object, so an
+# object without one cannot be diffed.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair no_modinfo.c
+run_diff 255
+
+diff_log | grep -q 'modinfo' ||
+	fail "expected a complaint about .modinfo, got: $(diff_log | tail -1)"
+
+pass "object without .modinfo rejected"
-- 
2.53.0-Meta

