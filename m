Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A63EB0FB
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152767; cv=none; b=jkG4JVRzlkKeK4LHN7xKIoCgiux2bw1yqq5GrSJMnZLHCkernggQTbQYztf6XnctIGJO3WAlh5xyqNCXFSwEYYXiaBS9+qc2x11kXLxHYcI/T3EJvD2sxZxnmmPhipj92CGyJQK1ejNwhcIxpaE5etpuYxjGKtEuDJO4pd/9tJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152767; c=relaxed/simple;
	bh=BnPfarbKRQ3iCIGhGkcAP8phh6qju9esOxbDxnCu1Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU+iLsZvHJW7uVk9c91t2E2qh+5d8XsrlL6LOMIf0XYMu85eDhzzTWodNUoKliNn6fgv0RAKJWz8WOHUYLx+eggTUbw5yL0ChnwB1e0vFBaWeoLfW1tbEbsFb/gx4Eg8oKq9010SZTWopBN9koST4WWLMnl1TvkGgnJnqqAfRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMT4QI9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMT4QI9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11A1F000FF;
	Fri, 11 Sep 2026 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152763;
	bh=RQ7omf0xNS0uK9GAW+/RIpG2YvJsXoTit1j7iA2dHJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMT4QI9xYUfRtI5ZmhcQ3LfeYvhNtvDdy1ZueXcghnp1J3z0uTJEHUAXHqMbcGGRW
	 lpFgZlb63sz/BOKXuuzkDM7gIbgWRwPXcFSH+0l2ENa0g4RcA9FQBEeDkn2I9Fw7I7
	 bQtCvc6o2vkxTEPTqXpmVW9iWpwwsgYAMz07KCaCPsJ9MpfIfAxU8/5q9N4nBhgt7r
	 2d3/84XOAuz8s0A0Fw1u25597uYJAinMykpo6RLLOKojNZd6ANyijxB9UvQMo62hbq
	 kgAAq61wvsSxs0lsIn0bxUjrZ+Wjy0+4RgFfXV+MQJxHiZ604vDXsFzFFRlf2RqTQw
	 AdqvJlpZ/w6AA==
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
Subject: [PATCH 49/58] objtool/klp: Add test for tracepoint and pr_debug static branch keys
Date: Fri, 11 Sep 2026 11:50:22 -0700
Message-ID: <20260911185031.1534046-24-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911185031.1534046-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
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

