Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090353C988D
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515537; cv=none; b=WdVyL1JflAJjxoFu3D1hRtqTKBBpm8GEqVU/wHh5x2ApfaHM2G3Fp8J8QP8LsRKDiFKpOSc2OMhTyh9xevKIlkJ1ap1JvUFMree36sNX2bKmVM0vmhTl3IfOAOgcvS200zZFaOE4czNBZJ6qEV38T34x/WapwfGfH20Vr+TdSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515537; c=relaxed/simple;
	bh=BSpae24Mds/lGhzk2vxyAxx+PQ3JRQm4PJawLkRZbqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5liqxcLfeYW5CDLnP4EPhLj7M8BNqYDMVQ6XYTqeLtZxU5VjwwW9sbqtdSv38yAc++/NG08HjO06VUvpZ9PgTYHPkUP76dJrnEuAOkEmstEYBWBgEQh0CN+46twDWqRZ7w1AJbxyZ1uvHE/K6TvS7AhmE6mTU2jFElfo/Unu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/xhc1BD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/xhc1BD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BC51F000FF;
	Tue, 15 Sep 2026 23:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515535;
	bh=GNOu5YQ1Yy1SjYktH98viMEcO3YEQ/LEWoqh6ezWyZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/xhc1BD1Mgj3nzkNj8rOSQ+zeFtt6JBSVoGkd2kACAnoZSKUUYtfPhtRAoD4+4x9
	 BOTEns9baELmDPNKDFclDnAJXNLYg0VmqabY4GAqsNG/s9kLdZ+tXLhjQ0G2qJSXVo
	 h0zG5yjKQ8+GdP2wz2JXT+lRWe3KRzzG7o4Y/hpbqaSpDWIUrcEFuadlaemT2RJyRy
	 nfCsTYqsu3xy26ZIQvOdjqtYiAqf7vfUD9YymDrFcRpZtFUAuqOmKeIhIGf9WBXYbx
	 EKzaNn1DSM+fV9J4uoB+MkrPqA4m6Kf7wmFZj3o56bqp34U2OK0fXY9eU9tvFpnMfx
	 Mhlg5n+4I2Jvg==
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
Subject: [PATCH v4 43/58] objtool/klp: Test rejection of a file-local static branch key
Date: Tue, 15 Sep 2026 16:34:39 -0700
Message-ID: <20260915233454.2405019-44-song@kernel.org>
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

