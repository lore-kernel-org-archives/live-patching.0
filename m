Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B954BE448
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152310; cv=none; b=kwWhU17v30Y9lXZ2bA3jwHUkdvlcgS/Amzn6xl0m6XdhN5zB3UWgY/jluf1KaWafqtUt8rEHCKkJR9dxLctDYWi5UrgvGUa6zZxS0t6bgOVJ2+CxN6qnFjkzrkfLd4EPMq/JbouJ4DfqLSZdkzgOiqY4jIkKug8TnE626lQfLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152310; c=relaxed/simple;
	bh=K1Ntqv2jSjrO5YQZcv1dTN/Od8c8VkXztXZpC/gknYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1m2ipTTXZ17BmUuvjnQLw/FWT1HtYdvPYnsB6YTWtQPjZ6kzQB3bCzqjNur31c8/5KbQjaHzboar+df5RtLDVbnpP2S1RF5ZEGlPs2432gMhrk7X4VbVP3q5cM9C+tOkR/5TSIKPX/myxLsqdlgwrpp/EGwU/TRlDJPx9+vBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5tv7s1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5tv7s1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B61F000FF;
	Fri, 11 Sep 2026 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152307;
	bh=r+S3kGYa/Hx7o6EOEIdlSdLsyGiYTPYPCIAH7y1XtcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5tv7s1fBp0/dqeqpBsFN0+CQYOSSlmvf/8/d3zn3UBmky0tIbyYQfyTljkj9SjPY
	 eaqIb7LFxX5YDF73H1e7p48amI+J6WPwxeRAHMIO7+KB/HUbv6XhpTKooCqXmG5EMe
	 0tdKEXxhapwzhM8hV3lbOgomtiyELZQU++vfS2tfon1eGYNGAcBof8OKLpsYoNXj/P
	 GASuoJjAJkWHCCVzYKuAGLnBZI+0qlixwe+gIyhGbPJ/0RZgsXOtJlZSc02HElnep0
	 EbN52khJJ0ujCaNtfWML05cRm1aHITZgJ4D8fcnh4fYU+z9TGmtT4IBeRFEqMV2XIn
	 2JKgO1QfC2B5g==
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
Subject: [PATCH 18/58] objtool/klp: Add test for selective special section extraction
Date: Fri, 11 Sep 2026 11:42:25 -0700
Message-ID: <20260911184305.1457308-19-song@kernel.org>
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

Two functions contribute entries to one special section but only one is
patched.  Cloning the neighbouring entry drags in whatever it points at,
which is how a livepatch ends up holding relocations against unrelated
code.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/fixtures/special_section_shared.c | 31 +++++++++++++++++++
 .../generic/test-special-section-shared.sh    | 26 ++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/special_section_shared.c
 create mode 100755 tools/objtool/tests/generic/test-special-section-shared.sh

diff --git a/tools/objtool/tests/generic/fixtures/special_section_shared.c b/tools/objtool/tests/generic/fixtures/special_section_shared.c
new file mode 100644
index 000000000000..f54e24f862c6
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/special_section_shared.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Two functions contribute to one special section; only one is patched. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int other(int x)
+{
+	asm volatile(
+		"2:\n\t"
+		".pushsection	.kcfi_traps, \"a\"\n\t"
+		".balign	4\n\t"
+		".long		2b - .\n\t"
+		".popsection\n\t");
+	return x * 5;
+}
+
+int target(int x)
+{
+	asm volatile(
+		"1:\n\t"
+		".pushsection	.kcfi_traps, \"a\"\n\t"
+		".balign	4\n\t"
+		".long		1b - .\n\t"
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-special-section-shared.sh b/tools/objtool/tests/generic/test-special-section-shared.sh
new file mode 100755
index 000000000000..05c6110b6aef
--- /dev/null
+++ b/tools/objtool/tests/generic/test-special-section-shared.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Only the patched function's special section entry may be extracted.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair special_section_shared.c
+
+has_input_section orig.o .kcfi_traps ||
+	probe_skip "fixture produced no .kcfi_traps on this arch"
+
+run_diff
+
+assert_patched     target
+assert_not_patched other
+assert_section     ".kcfi_traps"
+
+entries="$(out_relocs | awk '/rela\.kcfi_traps/,/^$/' | grep -c 'target')"
+[ "$entries" = 1 ] || fail "expected one .kcfi_traps entry, found $entries"
+
+out_relocs | awk '/rela\.kcfi_traps/,/^$/' | grep -q 'other' &&
+	fail "the untouched function's entry was dragged in"
+
+pass "only the patched function's entry extracted"
-- 
2.53.0-Meta

