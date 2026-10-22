Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689414;
	b=EMSA1N4SX1iIXQk7iizh/RKZ9o2hRB3HvIyAs4gvzhyvtFsRnP7yKR2TATLVAH0xAPxL
	 y42QuQ6Tdz70E4LJDe9A0GTT7UPwCmZBXGXeRxUdJ+Hn4Ozsxt4RuUhnKJnJl0E7Agl46
	 /hjyR5PTW7rPk5OaB1HszFGfaGYf9aSKaBHd+BNuC6t/TLGPYWqx15gPyLiylLiJqW7Hk
	 y/5L/ZXoZibZwr81gnwSHFJ2B86M7pdioHI4xQWRpc7rUaV0tm9b5jX67Xzv9H6y4npfG
	 bgfVYqCNHtD3bdkPYYnVOQNpuofVQoSUGBOyAcfIafy0+2OmF7UGc3jKEGmVnf9WR6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689414;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cnWci/2f59bYhEh7jU+/jcqd9PHjbuJH1JyDNZxKMVI=;
	b=WnvANAxdndN/XBvVzoBmLKjnc0S9eCloJa3JfF4xlYstl3aV+2W+O5ubmYKHlM8ZT94Y
	 59uvA4YGitYf3xQH6+t0zjn4fF1pwPMi82XljR922RD38n7BFfW3kEN7Q7OmgL7vPBxb3
	 dZhv/eo2/u+ePaBLt0xurNskK1c9fDmk/Ws1Et3Xu2iwjJ7VEFzFpymk7PWOD4hBTP7TX
	 +6SPQZDl0mMHxtjnLOZs6hBqb9egXQJB790iXRamaseCsYfQ0SuVQ7WSLCvLl1whcs4nx
	 B9+F7e0iZ0GA+1ztKBKj/9Hh4pHCGJe+6RYiKd1ZmMTQ/t/KT3EsWOPGVfjPuqf4NJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAl+xShV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB5606A31D
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAl+xShV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75BC1F01825;
	Thu, 22 Oct 2026 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689412;
	bh=cnWci/2f59bYhEh7jU+/jcqd9PHjbuJH1JyDNZxKMVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAl+xShVd5Rlr7Yc2uld7izngzwZVGwF0nxDW1Gno3WwYXWEVMwfbjWwp50dtlomL
	 vyuc1aiwJpafjxdumJsocU3j1S2YRvZaK0FzqItS0xxOWcpF9DCgG7ssiVPFWY+g8U
	 1pXY+buGSxWMQz+FAuQoFuX0zgXpmysCBPhk1hYfWurjvnL4wkUsHJTpt1JzAOQnF2
	 gKUS1pywW+37RjhL146e17iSn1i6rnXbHR37gFORknDJz3QJjaDE+nl19Mi1iQsWue
	 lV7+7KYehc1NgkIrwDXSuzzQF+bwnAAzFffyRMlC086iIXCv51d8j7fONULOer7hPh
	 msq2XZrJeiTJw==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH v2 3/3] objtool/klp: Add test for changed functions without an ftrace call site
Date: Thu, 22 Oct 2026 10:16:36 -0700
Message-ID: <20261022171637.3298443-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022171637.3298443-1-puranjay@kernel.org>
References: <20261022171637.3298443-1-puranjay@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that klp diff rejects a changed function without an ftrace call
site, both a notrace one and an inline one emitted out of line, and
reports each of them.  Also test that a fully inlined function and an
ordinary function can still be patched.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 .../tests/x86/fixtures/notrace_target.c       | 71 ++++++++++++++++++
 .../objtool/tests/x86/test-notrace-target.sh  | 74 +++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/notrace_target.c
 create mode 100755 tools/objtool/tests/x86/test-notrace-target.sh

diff --git a/tools/objtool/tests/x86/fixtures/notrace_target.c b/tools/objtool/tests/x86/fixtures/notrace_target.c
new file mode 100644
index 0000000000000..64da58c872b8a
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/notrace_target.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* PATCH_<name> changes <name> in the patched build. */
+#define notrace __attribute__((__no_instrument_function__))
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifndef PATCHED
+#undef PATCH_OUTLINED
+#undef PATCH_NOTRACE
+#undef PATCH_INLINED
+#undef PATCH_TRACED
+#endif
+
+#ifdef PATCH_OUTLINED
+#define OUTLINED_K 2
+#else
+#define OUTLINED_K 1
+#endif
+
+#ifdef PATCH_NOTRACE
+#define NOTRACE_K 2
+#else
+#define NOTRACE_K 1
+#endif
+
+#ifdef PATCH_INLINED
+#define INLINED_K 2
+#else
+#define INLINED_K 1
+#endif
+
+#ifdef PATCH_TRACED
+#define TRACED_K 2
+#else
+#define TRACED_K 1
+#endif
+
+int sink;
+
+/* Address taken, so emitted out of line. */
+static inline notrace int outlined(int x)
+{
+	int i;
+
+	for (i = 0; i < x; i++)
+		sink += i * OUTLINED_K;
+	return sink;
+}
+
+int (*outlined_ptr)(int) = outlined;
+
+notrace int notrace_fn(int x)
+{
+	return x * 3 + NOTRACE_K;
+}
+
+static inline int inlined(int x)
+{
+	return x + INLINED_K;
+}
+
+int inlined_user(int x)
+{
+	return inlined(x) * 5;
+}
+
+int traced(int x)
+{
+	return x * 7 + TRACED_K;
+}
diff --git a/tools/objtool/tests/x86/test-notrace-target.sh b/tools/objtool/tests/x86/test-notrace-target.sh
new file mode 100755
index 0000000000000..09414ae65fc2c
--- /dev/null
+++ b/tools/objtool/tests/x86/test-notrace-target.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A changed function without an ftrace call site can't be livepatched:
+# klp_enable_patch() fails with "failed to find location for function".
+# klp diff must reject it instead.
+
+. "$(dirname "$0")/../lib.sh"
+
+# mcount_entry <function>: orig.o has an __mcount_loc entry for it.
+mcount_entry()
+{
+	in_relocs "$orig_obj" | awk '/rela__mcount_loc/,/^$/' |
+		awk -v f="$1" '$5 == f || $5 == ".text." f' | grep -q .
+}
+
+# check <expected exit status> <-DPATCH_... flags>
+check()
+{
+	local expect="$1"; shift
+
+	setup
+	build_pair notrace_target.c "$@"
+
+	assert_input_symbol outlined
+	assert_input_symbol notrace_fn
+	has_input_symbol "$orig_obj" inlined &&
+		fail "inlined() was emitted out of line; the fixture tests nothing"
+	mcount_entry traced ||
+		fail "no __mcount_loc entry for traced(); the fixture tests nothing"
+	mcount_entry inlined_user ||
+		fail "no __mcount_loc entry for inlined_user(); the fixture tests nothing"
+	mcount_entry outlined &&
+		fail "outlined() has a __mcount_loc entry; it should be notrace"
+	mcount_entry notrace_fn &&
+		fail "notrace_fn() has a __mcount_loc entry; it should be notrace"
+
+	run_diff "$expect"
+}
+
+rejected()
+{
+	local n
+
+	n="$(diff_log | grep -c "error: objtool: $1: no ftrace call site, can't patch")"
+	[ "$n" = 1 ] ||
+		fail "expected '$1' rejected once, found $n: $(diff_log | tail -2)"
+}
+
+check 255 -DPATCH_OUTLINED
+rejected outlined
+cleanup
+
+check 255 -DPATCH_NOTRACE
+rejected notrace_fn
+cleanup
+
+check 255 -DPATCH_OUTLINED -DPATCH_NOTRACE
+rejected outlined
+rejected notrace_fn
+cleanup
+
+# Fully inlined: the traceable caller gets patched.
+check 0 -DPATCH_INLINED
+assert_patched inlined_user
+assert_not_patched traced
+cleanup
+
+check 0 -DPATCH_TRACED
+assert_patched traced
+assert_not_patched inlined_user
+cleanup
+
+pass "changed function without an ftrace call site rejected"
-- 
2.53.0-Meta

