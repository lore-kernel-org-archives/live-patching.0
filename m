Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81F4CE681
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515411; cv=none; b=VLiyop1E4Q3Vg44hHcEk4sQYo8WhPZNfiN5XVN5Z4lL1G1qfa4xmNl0iT/n5OwBaY9iubeCZ7P/vOg7e54tBvjomsnnkpLwtXgTK1rguT7+JHdz7eIDq1uWyMGfjUF4Tm+1jg8ytI9tW/Y59DLdagFNe8DkgjREti6m0Yz8bZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515411; c=relaxed/simple;
	bh=nfGfU3LaIh7bgGt7j7/PkZRVj5wdsODeLERr39LlXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ildNkTs4ZiR1qUJ3yX8nXu/Du8qCdLNySHfYK08QxaH59GBZq+2sgssbI+TDqwd39X1i5AN7WdX5dQD7UgR2uVg99w63FVoONgZ2pG0DGfYB7FFPAnBNvc+kHlOrbYtHsaugrLh6sJx1jcGjqnrqX8nLHzL/P30DUU0lvc5tY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6A5SHqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6A5SHqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A91F00898;
	Tue, 15 Sep 2026 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515410;
	bh=w+q/DLez5PlneJgCmCrVqPe34qCrkcVpE4zDb70j/T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6A5SHqMWkOKrl8hz13wU1zdRYf0LHe68fvRDVBWAco5/3wbweMXEhCQRxKGiCXTR
	 qG773LpJpIPG+f7B+yQr/HE+gckfK7zn/PQBslkvI2lUOj5lauvL1S47A9UE1pHPY9
	 DD5mw/rEkj2iFEQ8CMOP8gNgzVLttNijFQbXnupCKhKq8IMvwNj138yPgvwojZFScb
	 hWV7z7B/xVywaWjkEVG8w3a9x6vMBIhMTCE+5jbZUFHDO0bW4MR7+4Ij6H84S3cgui
	 rpISGDcCMUHXSjGCXP6Bn4J7pBaaGv/vIkF+ozApQvmnBtLDjaPVaQrSYkvT6qOyOA
	 eC54aIB4BR70w==
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
Subject: [PATCH v4 20/58] objtool/klp: Add test for rejecting module-owned static branch keys
Date: Tue, 15 Sep 2026 16:34:16 -0700
Message-ID: <20260915233454.2405019-21-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915233454.2405019-1-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
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

