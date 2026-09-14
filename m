Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC23DD84C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367257; cv=none; b=cjDiAXWatuI4sIbL40m9zdolG7O3G44ALIgDqsJr2oOqCpI+fWF7MvJ/q/b2xVEg5uphGfai8V5Pxcm6UD8TBiUk4ifD89CrnuP3US6B+53Z23rqHZukZPUFkFbLvy7aIYtkDh0IEAAqfwwmz4kOCkaUYIpWLCAbA00EHfnzT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367257; c=relaxed/simple;
	bh=hM+FyQ3q96bxqPdxnCy10EzSqMXJwCAP72Nz7kZlaWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS2x1Wr+5bQqD8igcrHeuoZi5n+cED0N+s2fbxQILKUf6Ooqo+JJMLQUZN+UcDE0EWuOyApTedvg/RE2B3B8FSzbuvZ39QTqRbJo0jOWSjN/HWNewqHCZtGvbXiOlrdJDjGLVFmC9qqDmbsNe/g0HlA+xWZmGy4Jfz1oE75uCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi4A4hsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi4A4hsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7501F00893;
	Mon, 14 Sep 2026 06:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367252;
	bh=obOEcs+wxQJBx0MaH7D1Z3F7SZz5vtVU3zQVph0jDwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qi4A4hsQvbmAKlnWaWyjo+9mho+9NczAz8nYxqFAgmth2N6H4AB95lRlRnFsuQ3Dy
	 yvkgME8VH/4brIkFFJPquuwejvKtEnqWYLlhR0Zxi1CwINMGVPrkgzmVtg4zdSiyys
	 R6UBP1ygd+XA4r90ja7wSD3RZJUYjyHd7xwFP4Yb8VbHqrHL47Rb747xG4oLTJ9O91
	 ysjzcSk06s57jL9ZFKLKW0xeypU99tsVDe+KOsuczruf/Ef53w9uMRx9PEVYmUEGQD
	 pQO859VAPdEXljzCh9UsVibd8++CKJ9PR9cSvbpGUOCkR5XxU6sUmZU4AFrQLTlilm
	 f29cw5XTG+cCg==
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
Subject: [PATCH v2 23/58] objtool/klp: Add test for rejecting references to init code/data
Date: Sun, 13 Sep 2026 23:24:39 -0700
Message-ID: <20260914062514.926997-24-song@kernel.org>
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

Init code and data are freed once boot finishes, so a klp relocation
against them can never resolve.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/init_reference.c   | 16 +++++++++++
 .../tests/generic/test-init-reference.sh      | 27 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/init_reference.c
 create mode 100755 tools/objtool/tests/generic/test-init-reference.sh

diff --git a/tools/objtool/tests/generic/fixtures/init_reference.c b/tools/objtool/tests/generic/fixtures/init_reference.c
new file mode 100644
index 000000000000..51b2a57dde14
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/init_reference.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Patched function referencing data in an .init section. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static int init_only __attribute__((section(".init.data"), used)) = 5;
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + init_only + 1;
+#else
+	return x + init_only;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-init-reference.sh b/tools/objtool/tests/generic/test-init-reference.sh
new file mode 100755
index 000000000000..16df80a112cf
--- /dev/null
+++ b/tools/objtool/tests/generic/test-init-reference.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Init code and data are freed after boot, so a klp relocation against them can
+# never resolve.  Such a patch must be rejected.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair init_reference.c
+
+# The rejection can only happen if the patched build really does reference the
+# init symbol.  Were the compiler to fold the read into a constant there would
+# be no relocation, klp diff would succeed, and the failure below would look
+# like a missing check rather than a fixture which stopped posing the question.
+# The reference is relocated against the section symbol rather than against
+# init_only, since the variable is file-local -- which is the form klp diff
+# has to recognise anyway.
+in_relocs "$patched_obj" | grep -qE '(^|[[:space:]])\.init\.data([[:space:]]|$|[[:space:]]*[-+])' ||
+	fail "patched object has no reference into .init.data; the fixture tests nothing"
+
+run_diff 255
+
+diff_log | grep -q "can't patch or reference init code/data" ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+
+pass "reference to init data rejected"
-- 
2.53.0-Meta

