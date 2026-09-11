Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAB3F5BFD
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152736; cv=none; b=rWNGx0ar7+UuWBQN/XhW+WOYx10UQJ4oJ4TcRD0g39RRjui3I57PH+ZcYwxaMXcbd4eczb0xkYFQPd1s6ycPdA9zfn0Q9gRHdk0jKBii9/Q0PUDnBQgB2NybaQoAeoiJr93cZBfm2VXd/TnB9eFt9CRBzPKN2xWt7JfdZV3oCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152736; c=relaxed/simple;
	bh=BSpae24Mds/lGhzk2vxyAxx+PQ3JRQm4PJawLkRZbqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzd/G2nJr7kD6Ww81sNmXqWrbkSb2OSdKPNicTtNsGuw+3gqrpHGf3JuCM3Pc7rXmCzIjHF0pvRKfSQn2rm/mVGPMbxXBC+L65Ros3mP8kZEreG7BUqGvUrqmE1+kGlAzLA6REN61RvfuXeGRNFCmk/qpRoG52Vu0gSYkJd9zEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd+ZSGtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd+ZSGtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593801F0089A;
	Fri, 11 Sep 2026 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152733;
	bh=GNOu5YQ1Yy1SjYktH98viMEcO3YEQ/LEWoqh6ezWyZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gd+ZSGtR/HnWfJK+BdpWzfkjhEDHLFX7LsAG5izk/LeU9Y49Cer75YOGUDQuaaxZR
	 r61a62aNCCCtNT9wuQVnU1vagc8ssLHHrYIDhBEdCTmvzEL61qezcteS+lah2SwHhF
	 9ta6v1sd0OVSuF19tFfexCci1Th2J0LoK805ZFFTyMKV1ywUbH25c543VPL/GIbo8N
	 zSqQqXFEnCuri9GphDqdaCZiC5WnmvWhteDlxTwKhjAIsHPBMjpg9IX5+v7S6D8n8l
	 mHec1FMKuqGLeY/PumrFhLcFTPX6cjPu7pSmEnQJoWyARDcoWBNIU/aWEK1wf4y1W9
	 jbpyv3A12ZnEg==
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
Subject: [PATCH 43/58] objtool/klp: Test rejection of a file-local static branch key
Date: Fri, 11 Sep 2026 11:50:16 -0700
Message-ID: <20260911185031.1534046-18-song@kernel.org>
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

A static branch key owned by a module cannot be reached with a klp reloc:
late module patching allows the livepatch module to load first, leaving the
__jump_table entry unresolved for jump_label_add_module() to dereference.
validate_special_section_klp_reloc() rejects it at build time.

test-jump-label-module-key covers that for a global key.  A file-local one
takes a different route to the same check: the compiler references a static
through its section symbol plus an addend, so the key has to be resolved
from the section before it can be recognised as STT_OBJECT at all.  Until
commit f9fb44b0ecef ("objtool/klp: Fix detection of corrupt static
branch/call entries") it was not, and the reference was silently emitted.

Give the fixture a STATIC_KEY knob and cover it.  The test checks that the
input really does reference the key through its section, since without that
it is only a second copy of the existing test.

Verified by reverting commit f9fb44b0ecef ("objtool/klp: Fix detection of
corrupt static branch/call entries"): klp diff accepts the input and the
test fails, under both gcc and clang.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../test-jump-label-module-static-key.sh      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-jump-label-module-static-key.sh

diff --git a/tools/objtool/tests/generic/test-jump-label-module-static-key.sh b/tools/objtool/tests/generic/test-jump-label-module-static-key.sh
new file mode 100755
index 000000000000..7bdcbaf2fa60
--- /dev/null
+++ b/tools/objtool/tests/generic/test-jump-label-module-static-key.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A static branch key owned by a module is rejected whether the key is global
+# or file-local.
+#
+# The rejection matters because late module patching allows the livepatch
+# module to load before the module it depends on: the __jump_table klp reloc is
+# then unresolved, and jump_label_add_module() dereferences an uninitialized
+# pointer.  Catching it at build time is the only defence.
+#
+# test-jump-label-module-key covers the global key.  A file-local one reaches
+# the same check by a different route: the compiler emits the reference against
+# the section symbol plus an addend, so validate_special_section_klp_reloc()
+# has to resolve it to the underlying object before it can see a key at all.
+# Until it did, a static key was passed over as "not STT_OBJECT" and the
+# unsupported reference was emitted with nothing said.
+#
+# Fixed by f9fb44b0ecef ("objtool/klp: Fix detection of corrupt static
+# branch/call entries").
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair jump_label.c -DSTATIC_KEY -DMODNAME='"klp_testmod"'
+
+require_input_section __jump_table
+
+# The premise: the key is reached through its section symbol, not by name.
+# Without that this is just a second copy of test-jump-label-module-key.
+input_jump_relocs="$(in_relocs orig.o | awk '/rela__jump_table/,/^$/')"
+
+echo "$input_jump_relocs" | grep -q klp_test_key ||
+	fail "fixture produced no __jump_table reference to the key"
+echo "$input_jump_relocs" | grep -qE '\.(bss|data)\.klp_test_key' ||
+	probe_skip "compiler referenced the static key by name, not through its section"
+
+run_diff 255
+
+diff_log | grep -q 'unsupported static branch key klp_test_key' ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "module-owned file-local static branch key rejected"
-- 
2.53.0-Meta

