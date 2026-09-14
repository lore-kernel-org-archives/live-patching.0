Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D303D6CCE
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367206; cv=none; b=fWLLB1rk7OPYJsCSDcBuhvoCeVEwC3Cs5VHEYrhcSgACGjDjmwqhQcHsnKdsR5/mGRLKJkU2pJkbnIR7MVNadFvSeBB1GaoNp2MrT+SnSnr4wltViLFzwUPwEDCz6gp64MhLy2AzM7SwiWu6n1zO0J4yIxqKbxobZmWyv8kgT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367206; c=relaxed/simple;
	bh=oK8GG7uo6A+2nnzoCoClQnNMbEpNGvpwMLzAJcGDSf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLc4S/ulxCXvUJcdHY3jdnbM+/gnT3qI06XSV6mjIpdf/Q6AC1w/ZrNO2tavsXgfkBNkCjxtfwYgmNbfJLN94HB0Z+ged6a+bQnCXarCbQuTnTCNINvuTVQfAd4M7ZKod8hUpjJkjGBzQOOlp0+F+IuOqbRKBiixQym3sXJxf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn2C0wy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn2C0wy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887D41F000FF;
	Mon, 14 Sep 2026 06:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367204;
	bh=yx/wdZQ6aZyXuUMAHgYHnXv7h2ZvkfZRGWGF1btfdQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fn2C0wy8nEx9nlmUB6lO5bAm4i9J9icOo3d3okiPmZvAGfHFfvcsIxnEVp3nwIed+
	 clqgLt00JTbZ+8/3qAQP9vrFypIBS6skRI2Gp5Kp6iutoQCnTjxsBHLwFbMjnEqpaM
	 P17IPhXnfvxiLdxuFiNfRyLn9OqXzznsCN/sHYnUEhCvigE+FSxZzrVWy6zZqOOrue
	 YHORSTFjjRoIc5tLHTy64kCA7WNGqY2id/u7SGMj0tQHuNyF0xYR4nUDqS5CJ6P8A3
	 /LCLkcifmNyMstVB3Ps4/qVrt2T+NtE8WiPclm0t81nv9yTQh84mxjMjyzieIZNARi
	 USBTRQzmVHx9w==
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
Subject: [PATCH v2 14/58] objtool/klp: Add test for newly introduced functions
Date: Sun, 13 Sep 2026 23:24:30 -0700
Message-ID: <20260914062514.926997-15-song@kernel.org>
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

A function added by the patch has no original to correlate against, and
still has to be carried into the livepatch or the changed caller ends up
referencing something which does not exist.

The helper is noinline so the case survives the optimiser; otherwise the
compiler folds it into its only caller and the test covers nothing.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/new_function.c     | 21 +++++++++++++++++++
 .../tests/generic/test-new-function.sh        | 17 +++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_function.c
 create mode 100755 tools/objtool/tests/generic/test-new-function.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_function.c b/tools/objtool/tests/generic/fixtures/new_function.c
new file mode 100644
index 000000000000..e7886eaaff3e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_function.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Function introduced by the patch.  noinline keeps it from being folded. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+static __attribute__((noinline)) int klp_new_helper(int x)
+{
+	return x * 7;
+}
+#endif
+
+int target(int x)
+{
+#ifdef PATCHED
+	return klp_new_helper(x);
+#else
+	return x;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-new-function.sh b/tools/objtool/tests/generic/test-new-function.sh
new file mode 100755
index 000000000000..17af18545b7d
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-function.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A function added by the patch has no original to correlate against and must
+# still be carried into the livepatch.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair new_function.c
+run_diff
+
+assert_patched target
+out_symbols | grep -q 'klp_new_helper' ||
+	fail "new function was not carried into the patch"
+
+pass "new function carried into the patch with its caller"
-- 
2.53.0-Meta

