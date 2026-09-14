Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E43D1CAF
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367200; cv=none; b=MsPWiWRytqFhU54waS7usaZbExpWAuVw1Sa/JkZLWqth1F0sKeljizBCiSzIWIJF24Ru/dvBlTRj6hTemc/H8Ay7EIkHt50IuGCH7x3odprdBoevMAde6JPPoAEJGyG2ZAIfhCP81RGGsWvQqYZliyF7LZB/qO3VRDY5Q0nglW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367200; c=relaxed/simple;
	bh=4P/ZjhWuj3Sv5SPtzjXmr2SztED6+RrDXKYQtjd4CVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8hZKMYERKNlO/iRt2/cfvwfnVOjc44AD4xMAwvi8DgH3rjCExTQNljkfycD8bDLWAjQOtkLPwjqJbByh0V8PCWCxPnQGCJSZrtk2eONS0t2orhGyfkVBFz3+wI6zoCXqgkuRMUWz3BGzXsEGV1jEiyvzql+LG4k0qwvV5P/RBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWW6MJDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWW6MJDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327361F000FF;
	Mon, 14 Sep 2026 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367199;
	bh=PbqFX46N/aYe588o1d3LULWk9j0gQrAQwDXGPPtqCf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gWW6MJDzmFqSuKWc7en8oZ68UEiMTor3EuZR5f2ab0zydbIueOna66p0BPCVPY6ii
	 86jc4xZDUDNqVpCwpoSaczEEE4SfjB8vQgXUG1szvV9JjsK1Lqh7d7q0MYg4U/lvgI
	 fWx4mpVzAm72Y30uc8L0arWbD7TIbVNadhVF8yzGD9CUNhZLk8jKcsX93snq4o16+e
	 PXz6Qb//CdMg0gdSwfJ2/cisVNdsl/vsKzyIQeOV6xkneH5BzkmQ0p897ySWXbCHBs
	 KW/EbUnLLwROAnCZLZuAPiGmNlVwhEZaH9iDJt0oziJO2+EoNVIdrt4RSxpnkCEYd3
	 nO6d6G4/8iFkg==
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
Subject: [PATCH v2 13/58] objtool/klp: Add test for newly introduced data
Date: Sun, 13 Sep 2026 23:24:29 -0700
Message-ID: <20260914062514.926997-14-song@kernel.org>
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

Adding data differs from changing it: nothing in the running kernel refers
to a new variable, so it is safe and has to travel into the livepatch with
the function using it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/generic/fixtures/new_data.c | 18 +++++++++++++
 tools/objtool/tests/generic/test-new-data.sh  | 26 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_data.c
 create mode 100755 tools/objtool/tests/generic/test-new-data.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/objtool/tests/generic/fixtures/new_data.c
new file mode 100644
index 000000000000..fa861fe81386
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_data.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Data introduced by the patch. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+static const int klp_new_data[4] __attribute__((used)) = { 1, 2, 3, 4 };
+#endif
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + klp_new_data[x & 3];
+#else
+	return x;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-new-data.sh b/tools/objtool/tests/generic/test-new-data.sh
new file mode 100755
index 000000000000..c7336752f09a
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-data.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Data added by the patch has no counterpart in the running kernel and must be
+# carried into the livepatch.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair new_data.c
+
+# State the premise on both sides.  The array is new in the patched build and
+# absent from the original; if the compiler folded it into the code instead of
+# emitting it, the assertion below would fail without saying why.
+has_input_symbol "$orig_obj" klp_new_data &&
+	fail "fixture put klp_new_data in the original; nothing new to carry"
+has_input_symbol "$patched_obj" klp_new_data ||
+	fail "compiler did not emit klp_new_data; the fixture tests nothing"
+
+run_diff
+
+assert_patched target
+out_symbols | grep -q 'klp_new_data' ||
+	fail "new data was not carried into the patch"
+
+pass "new data carried into the patch"
-- 
2.53.0-Meta

