Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBE3E5EC3
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367401; cv=none; b=DTecXi/5RMFlnl+FU2bQLj8MkvbyDfFKRU97sb7aIhzFFknr8Diqnd6fFTHJtU2p6vPRJ/xJ1hbzRdxD2qAbhxcWO9DxXzWuX9DpBSKpavCpz5oNImW5sPbS/5fEmce8e20abqY5cwkE1xrlHaTvyhtQnMpA+3vagZsHCL23sRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367401; c=relaxed/simple;
	bh=LkInyhU4QZkMyaBVr4spacs2W/gBANQ3CPaNQ+jOfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5m4LzVisowRAo9dGjsNa27dyXCPDX6SVl2kK6/GtWf1UOEcancMkWSNtkcmxtu4kdjB9XH3NKT0FBFEcNsBhG6T1bI5GzazdpYxMsKNX6lzvFuLt2f9ch8xEc3YtiF3lupPw8jk8iKRRgCfm6+b2IGVUpQdwiNwnOPS85FDw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzjYTmuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzjYTmuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1EE1F00893;
	Mon, 14 Sep 2026 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367394;
	bh=alxai34FQdFaIrkf9TH48GWWK77DSl+25RcxFbyvZTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzjYTmujakAUwBjYVk2vbSKe1tcdYnEdP/kI6ZwacvRzBt6QqlmvdvAPpCRqesg63
	 E8rh7TjLyxCpFfqgVu8wfqiVy+54rS/MSg4TcEi6j6x9MVcWA6j5679kVMlkKflHCu
	 zVaQjwWdQxrG5TBxNgBwxB+aYnrLPYCdEg6WTzmbR8UQmnSSIarAiDDFc68VjxF2a3
	 M52OF0NQbV3ftkIuUhwlPW+giF0ZB5wc2K11Ftf1tTzQhxOIcjFinkBilJ7Csq2fWX
	 wuAvbRWyKnNOl9L+EMBnwOQdJNjVIjgrhqYVeXODmYBbuZCJ4kFeuud63o1DZ+hjXT
	 VHcTNCRiBQFHQ==
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
Subject: [PATCH v2 50/58] objtool/klp: Add test for a static call introduced by the patch
Date: Sun, 13 Sep 2026 23:25:06 -0700
Message-ID: <20260914062514.926997-51-song@kernel.org>
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

The counterpart to the static branch case: a patch may add a static call to
a function which had none, so the .static_call_sites entry is new and there
is nothing in the original to correlate it against.

Where the key lives still decides whether that is allowed.  A vmlinux key
is reachable; a module-owned one is not, for the same reason an existing
module key is not -- late module patching lets the livepatch load first and
the unresolved entry is dereferenced when the module arrives.  Both halves
are here because they fail in opposite directions: dropping the new entry
leaves a static call the kernel never patches, and accepting a new
module-owned one is the corruption the check exists to prevent.

Both halves are one test over one fixture: built with -DNEW_CALL the key is
vmlinux's and the new entry has to be carried in; built with -DMODNAME as
well the key belongs to a module, klp diff has to reject it, and no output
object may be left behind.  The premise is asserted first -- the original
must have no .static_call_sites at all -- since otherwise this is a second
copy of test-static-call-module-key.

Covers the same ground as corpus/x86_64/static-call-vmlinux-new and
corpus/x86_64/static-call-module-new in Joe Lawrence's klp-build unit test
corpus.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-static-call-new.sh     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-static-call-new.sh

diff --git a/tools/objtool/tests/generic/test-static-call-new.sh b/tools/objtool/tests/generic/test-static-call-new.sh
new file mode 100755
index 000000000000..f7d2b39c0fec
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-new.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch may introduce a static call where the original function had none.
+#
+# The .static_call_sites entry is then new, with nothing in the original to
+# correlate it against, so klp diff has to carry it into the patch from
+# scratch.  Where the key lives still decides whether that is allowed: a
+# vmlinux key is reachable, and a module-owned one is not, for the same reason
+# an existing module key is not -- late module patching lets the livepatch load
+# first, and the unresolved entry is dereferenced when the module arrives.
+#
+# Both halves are here because they fail in opposite directions.  Dropping the
+# new entry leaves a static call the kernel never patches; accepting a new
+# module-owned one is the corruption the check exists to prevent.
+#
+# Covers the same ground as corpus/x86_64/static-call-vmlinux-new and
+# static-call-module-new in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_call.c -DNEW_CALL
+
+# The premise: the original really has no static call, the patched one does.
+has_input_section orig.o .static_call_sites &&
+	fail "fixture put a .static_call_sites in the original; nothing new to add"
+has_input_section patched.o .static_call_sites ||
+	probe_skip "compiler produced no .static_call_sites on this arch"
+
+run_diff
+assert_patched target
+assert_section .static_call_sites
+assert_reloc_sym .static_call_sites target
+
+# The same new call, with the key owned by a module: not reachable, so the
+# build has to stop rather than emit a relocation nothing will resolve.
+rm -f "$workdir/out.o"
+build_pair static_call.c -DNEW_CALL -DMODNAME='"klp_testmod"'
+run_diff 255
+assert_diff_log 'unsupported static call key __SCK__klp_test_call'
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "static call introduced by the patch carried in, or rejected for a module key"
-- 
2.53.0-Meta

