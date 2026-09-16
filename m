Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28244B1D1D
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584492; cv=none; b=SnQYNZ1eni8+dXes5zmHUS4Z+ccFTmqHJMrF6ptgQKGLBMzUHQ5lzMl/fCDjIegfEiMSlMiN7JUNzuUr9NZwQKjII94mgsoxY8rcD/9A5kr4xlrkqVSNiac/r8AOQvXmqbcYu6btSHWE/asXz/e0w8EYAwOn72ujqbOPYNOUZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584492; c=relaxed/simple;
	bh=BnPfarbKRQ3iCIGhGkcAP8phh6qju9esOxbDxnCu1Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYvpmRgW6kY93ouASSuvbYMnDsn6n5giCRbXveuikN14rf9wo2bX9+htCkJLGWKP82hR664GxO80RQbXwfGvz80TJaGPd2dXuXJQj8PBwrzCpSXaT823gWt90c0+WYaonO7C4oknCgTjHjABVrwOXtYQjin2+TIUW8yEX4pjB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOp2pyEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOp2pyEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672C51F00893;
	Wed, 16 Sep 2026 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584473;
	bh=RQ7omf0xNS0uK9GAW+/RIpG2YvJsXoTit1j7iA2dHJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOp2pyEuifVI+A7Dc7uNlpWSZMLJyJl+eitOiOe9ybVeVIDVfpE3xhegiVTy7hCk9
	 rCj5YWb5WdgzQ5uKNNkbotwWNcgw3j89JL+qSBL96AbkGbE9hM3rB82Pj8yFRxO+XV
	 UDytmoSLpMl2blCyfF3Qs+s7VlkuQoO41ohUVpP0GyVXs0w2FDdLGwAiCaaIJvdikf
	 u0hPw+g3ABJLvKfSgBURrbcXh/YW1T0oY+j7bW/R0p4y8djnR5AGj0xrw25MTg7Yiz
	 aCv2cBJuDcZMH8dQU3V6XEHw3M/okX5roUIi58Y4JmFx8ZYHaojE6fB7sMdeAtErBV
	 jyB2EZVpRf0iQ==
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
Subject: [PATCH v5 49/58] objtool/klp: Add test for tracepoint and pr_debug static branch keys
Date: Wed, 16 Sep 2026 11:43:42 -0700
Message-ID: <20260916184351.2720310-50-song@kernel.org>
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

A module-owned static branch key is normally fatal, because late module
patching lets the livepatch load before the module it depends on and
jump_label_add_module() then dereferences an unresolved entry.

Tracepoints and pr_debug() generate such keys everywhere, so refusing them
outright would make any function containing a trace_*() call or a
pr_debug() unpatchable.  klp diff drops the entry, warns, and carries on:
the patched code works with that one tracepoint or debug print permanently
off.

Both halves matter, and the test asserts both.  A build which fails is a
function nobody can patch; an entry left in place is the corruption the
rejection exists to prevent.

Give the fixture a KEY_NAME knob so the same static branch can be built
with either special name.  Verified by removing each exemption in turn --
the test fails for both.  That the entry is then dropped is asserted but
not isolated, and the test says so.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/test-jump-label-exempt-keys.sh    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-jump-label-exempt-keys.sh

diff --git a/tools/objtool/tests/generic/test-jump-label-exempt-keys.sh b/tools/objtool/tests/generic/test-jump-label-exempt-keys.sh
new file mode 100755
index 000000000000..fa2f913d860b
--- /dev/null
+++ b/tools/objtool/tests/generic/test-jump-label-exempt-keys.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Two kinds of module-owned static branch key are disabled with a warning
+# instead of rejected.
+#
+# A module-local key is normally fatal: late module patching lets the livepatch
+# load before the module it depends on, so the unresolved __jump_table entry is
+# dereferenced by jump_label_add_module().  test-jump-label-module-key covers
+# that rejection.
+#
+# Tracepoints and pr_debug() generate such keys everywhere, though, and
+# refusing them outright would make any function containing a trace_*() call or
+# a pr_debug() unpatchable.  So klp diff drops the entry, says so, and carries
+# on: the patched code keeps working with that one tracepoint or debug print
+# permanently off.
+#
+# Both halves matter.  A build that fails is a function nobody can patch; an
+# entry left in place is the memory corruption the rejection exists to prevent.
+#
+# The two exemptions are isolated: remove either and this fails.  That the
+# entry is then dropped is asserted but not isolated -- making the caller keep
+# it anyway produces no output difference here, so that assertion stands as a
+# check on the behaviour rather than on the line which produces it.
+#
+# Covers the same ground as corpus/x86_64/static-call-module-tracepoint and
+# pr-debug-unsupported in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# check <key name> <expected warning>
+check()
+{
+	build_pair jump_label.c -DKEY_NAME="$1" -DMODNAME='"klp_testmod"'
+	require_input_section __jump_table
+
+	# Accepted, not rejected: this is the whole point.
+	run_diff
+	assert_diff_log "$2"
+
+	# And the entry is gone, not merely complained about.
+	assert_patched target
+	assert_no_section __jump_table
+}
+
+check __tracepoint_klp_test        'disabling unsupported tracepoint klp_test'
+check __UNIQUE_ID_ddebug_klp_test  'disabling unsupported pr_debug'
+
+pass "tracepoint and pr_debug keys disabled with a warning, not rejected"
-- 
2.53.0-Meta

