Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169B3E0C50
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367244; cv=none; b=nba3F7jmgJ8oQtZxgrnVUGlYrvkl3lj5EuV7DjQ01HyI9pSB7KTgoiSJwriD9INsNbTAPG76X6up70DEaYv3kgFv4JsNKa1CZCUpw6Yx92fxMqQQ/leKztmEIsylxHWe98r1FJBEkv2X4kEyw2zgTYR2hPh69CZDCsHlO/Jv5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367244; c=relaxed/simple;
	bh=nfGfU3LaIh7bgGt7j7/PkZRVj5wdsODeLERr39LlXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nnj2nEqlY/bq3oOt4sDuTieFhyxFmentgUmRY6sFSZ+vsvCb4d6hKtorZ1qdU/pT0o1NIp5YP+6bSb1TY37VHLm3K/eHphe2G7ZD/+Xdxpg0hDWQhw4+7aW7HtzKNXgEJGffUlcBIqmRbJ9rh0cmZcHH+2AP9zCsKTRbg29KBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuOQuCfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuOQuCfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2499B1F000FF;
	Mon, 14 Sep 2026 06:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367236;
	bh=w+q/DLez5PlneJgCmCrVqPe34qCrkcVpE4zDb70j/T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fuOQuCfJYvRa4Vnx2prb57UqIqawtajS9T6q31n6d5PHnUl2b+Tw7GjRLoLdw91j2
	 rhYJJ0/686ge4Zd19q1/nmTZxdspeMKUiTsRf5sO6GhOhI8XlOgo9pnJldwpqe1dkW
	 zGA/x7Mj9Vb5c9KsFeI6zKWMPxPX93Gb9k9maS0LaFPRBW2r6kcAtxoFlxlXTErlBn
	 /x+1chT6MsMSn834xD8+9PwDm/BETS3HYCXPuc4n3bx8XIrVlL0R0G7iJs6KX7uLWI
	 OcElgjGYN4U34ny0dAeSd3RyUZ+DtPaJpHFvyaWSbPixLfwK3jnlSD2QkM4fQpRf4F
	 otRy6iqz5vswg==
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
Subject: [PATCH v2 20/58] objtool/klp: Add test for rejecting module-owned static branch keys
Date: Sun, 13 Sep 2026 23:24:36 -0700
Message-ID: <20260914062514.926997-21-song@kernel.org>
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

