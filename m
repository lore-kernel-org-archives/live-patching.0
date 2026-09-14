Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B73B42F7
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427155; cv=none; b=rO6GECiSwEA0Ehrfr58NwSlrClv1xmA+hhiwbojDNQML7lB9FUHG3wwk6IyLJGYxA4pzCleiydc9o4b2E3fPcKwDsiSeKqxpPRGPaP2SHZVas3ti0TOZgw+sFv5WQ3wvn2o6Ml9/hS+iZbWmXJamv9afVTRud49uyMx+mvp+KM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427155; c=relaxed/simple;
	bh=hM+FyQ3q96bxqPdxnCy10EzSqMXJwCAP72Nz7kZlaWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovn63P3tgnEfpEXGUh6+xpzgJlX34kBVvhJeESzRYdJpNAf5mebdI0MWJja1svks/kSz5bvR3sGVEj2B3xe0UFmNFwj+nEF6KRQ66pGGpTVjmUg4aoSlyiwmPuuFkmpsscIXbyoBFvF3Z7JP8+Rjp2E0B8mq0yY+JwOJe+eahRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHP32PFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHP32PFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9101F000FF;
	Mon, 14 Sep 2026 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427153;
	bh=obOEcs+wxQJBx0MaH7D1Z3F7SZz5vtVU3zQVph0jDwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHP32PFF7EarXGjyjZeRQRODennH21Aju6qfvDG0uTMr1IWc5CDcHToNhzXmSJq1S
	 yeqMX9ax7dAHXlZJqxffnYFMs17lbliRa9Cc7ea0Ts0+TiJ7dBRPspayHjaawG6gXd
	 BV+QBAwEw4Y+p2npB0qeJ3iFbmxlNrZHlUNgUdVOrq5an8XDpQSz/zSv8xk9d62FSr
	 7DW6CCYIMCIoRLCRQGNoU1NXmffJI/ieMDvbl6zHfyK5FUAdGN5bWJUuYcclgOPyiB
	 2JusLWRXb5iyBoDKcshyuOv6k+ZSkQvl1z1Nxplw0AjAnU278WZ8hLCPQ3RwrOxuX8
	 K8RJAUazbfGiA==
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
Subject: [PATCH v3 23/58] objtool/klp: Add test for rejecting references to init code/data
Date: Mon, 14 Sep 2026 16:03:20 -0700
Message-ID: <20260914230355.3422996-24-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
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

