Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA44D9F9C
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584327; cv=none; b=eiNbT0WoF5MtYb8ytSFipaApYuzvFvjJ6J7KJtlr3SFlZdOX8pwSoak0tphXlJSAdj/Vywn341GO73ihqkvujIQlUqZCBnnsvxsEdw5tDVa+IFeIWUyqMZPxpllpA20XMH+P/b+JWlwhLqul6Ft2IZKW+qh6GQebwOt3yU8q6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584327; c=relaxed/simple;
	bh=9ytSFPk/zV9LwXcHFqEhXVMHSlmttVilC2p+rWqLvA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi8vLJvj9Vl0d+0W3U9eYu4d2XC+HshfqF2r/5Phtq/g7X7tjZUpnoT1i0BaUkG6Wko9dAXdqdkfiIgcz8L+JYeFWQUNo37VIEzQnAaRMHyukq94mep9zoa4HjiRRimEXO/Gl4UhLzNS2t8sL7DNnUw0EttNCqPRAPGGiwnIhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl4bfoIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl4bfoIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A55E1F00899;
	Wed, 16 Sep 2026 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584300;
	bh=9ryHY9krSPc36qEqiezpF3xvGthQaxlMavUa3P1vP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bl4bfoIMTO9VI7HP3twxII+TEz4PUJhzqR7NrPwqt1DaiOG65lTLz2zl4bVVMx096
	 cP1ctsUx1fLy8eJdE4aHn1AbMhSVvdrXGUAvySDD3G3XPrLGb3KBLVH1bwGLMZ5Nfv
	 gUNIgEDVRjdWKtEL5iggE4jQas8+su7l7hyH3R4KLvA41ZrlWl5II2+9vER+pb+/f8
	 2qQeEp1ic6z/O1sfv7cT8wH6tcMVkd42vv4aHUq5eiJOaeTQNIrc26yKILuIzSUAOz
	 nHyZ678eGEwJECSXKrbqHT6g6BlfWK1v/8ibnpKCRzUKEyn4Xp0ImGogvwOkghJmNU
	 b23rngdQOltmg==
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
Subject: [PATCH v5 13/58] objtool/klp: Add test for newly introduced data
Date: Wed, 16 Sep 2026 11:43:06 -0700
Message-ID: <20260916184351.2720310-14-song@kernel.org>
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

Adding data differs from changing it: nothing in the running kernel refers
to a new variable, so it is safe and has to travel into the livepatch with
the function using it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/generic/fixtures/new_data.c | 23 ++++++++++++++++
 tools/objtool/tests/generic/test-new-data.sh  | 27 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_data.c
 create mode 100755 tools/objtool/tests/generic/test-new-data.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/objtool/tests/generic/fixtures/new_data.c
new file mode 100644
index 000000000000..ac364622f12a
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_data.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Data introduced by the patch. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+/*
+ * Not an arithmetic progression: { 1, 2, 3, 4 } indexed by x & 3 is something
+ * a compiler can compute instead of load, and then target() has no reference
+ * to the array and there is nothing for klp diff to carry.
+ */
+static const int klp_new_data[4] __attribute__((used)) = { 7, 3, 11, 5 };
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
index 000000000000..acb68ff19c99
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-data.sh
@@ -0,0 +1,27 @@
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
+in_relocs "$patched_obj" | grep -q 'klp_new_data' ||
+	fail "target() does not reference klp_new_data; the fixture tests nothing"
+
+run_diff
+
+assert_patched target
+assert_symbol klp_new_data
+
+pass "new data carried into the patch"
-- 
2.53.0-Meta

