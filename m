Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171B38C40E
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152695; cv=none; b=Qd3oViuF+NCN92oO8XiqZcFd2T1Q0tXL/98zNzn9i3Mob/jwqjd9S5FE+WoM+1rIt7mRFOEBMix+jOGNkSUxpKBoyQEQer7YTJexUYiJmcgtoOXoR5ngo+MqKet7uZAk1ioMOjc1RKXxaOCSaB6K7LAxcPR/ecGY8SfUZ0bDy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152695; c=relaxed/simple;
	bh=O/Vyyquoe8PAs/bXEMIJGZdXPAzwhVdbV6aQFeqCMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7YIyJ3IaVjujZidVhl+1ycUvahnMaJyU5o+mnM/WRTwyizcfuSLcJClSjSCQwjNo6KZ6lRgbavPz43AYG0w4v/FstlTjIizsZnD78ZwaKjJq5HxC+6TKPxUJ7kDpMQHDXXXHgDlXvI2QxbDk+T78R7Nqoa7lDFxejlfjzL5ICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPdZu+UD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPdZu+UD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C8F1F000FF;
	Fri, 11 Sep 2026 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152694;
	bh=WV5VeW8fRzrqpwY3VtpGMwei4VK+vatQRHwjjgTf53I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPdZu+UDTbZ3bJ2UPp8M8TFZ5wtmrpVh/UEh0M+t7Cq88elrBSMqBqhyUTAH2oNeI
	 Q9c9BAsFzdDpxq+62PWEisQRRZF0zUbLC+7RmLldKbPY1Mu3n0e64ioTRlI/gQgofz
	 RLoiKFINLuHKnF4DnwR51KhDaHSa0+BUgQD6wuSvCMri9Vxvos5o88uhAM+R3ph3lF
	 ziuBgorz+M0qUPlmqq28iVRNFZFSziSsDCk/GNu/v/8npRGHscEAESpRUXFsM3WVLd
	 IYeczoG69FicZhMkQw+WPFSw7QAAXjbKDkhz/p4XC32C8171SeKG2sKAFv5AKTE5Rz
	 doK8HD0D103/Q==
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
Subject: [PATCH 35/58] objtool/klp: Add test for recorded checksum values
Date: Fri, 11 Sep 2026 11:50:08 -0700
Message-ID: <20260911185031.1534046-10-song@kernel.org>
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

Whether klp diff treats a function as changed is decided by its checksum,
and until now nothing looked at one.  A test asserting only that the right
functions were cloned cannot tell a correct checksum from one that happens
to differ.

Asserts both directions -- the changed function's checksum moves, the
untouched one's does not -- and that checksumming identical input twice
gives the same answer, since otherwise every rebuild reports spurious
changes.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-checksum-value.sh      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-checksum-value.sh

diff --git a/tools/objtool/tests/generic/test-checksum-value.sh b/tools/objtool/tests/generic/test-checksum-value.sh
new file mode 100755
index 000000000000..feae6a12e98d
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-value.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# The per-function checksums klp checksum records are what klp diff uses to
+# decide which functions changed.  A checksum covering too little misses a real
+# change and the patch silently omits the function; one covering too much, or
+# unstable across identical input, clones functions nobody patched and drags
+# their dependencies in with them.
+#
+# test-basic covers which functions got cloned, which is downstream of this and
+# passes for either kind of wrong checksum as long as the two errors do not
+# happen to cancel.  This checks the checksums themselves.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair basic.c
+
+assert_input_symbol changed
+assert_input_symbol untouched
+
+run_checksum
+
+# The edited function's checksum has to move, the untouched one's must not.
+assert_checksum_differs changed
+assert_checksum_matches untouched
+
+# And it has to be a function of the code, not of the build: checksumming the
+# same input twice has to give the same answer, or every rebuild reports
+# spurious changes.
+first="$(checksum_of orig.o changed)"
+build_pair basic.c
+run_checksum
+[ "$(checksum_of orig.o changed)" = "$first" ] ||
+	fail "checksum for 'changed' differs between builds of identical source"
+
+pass "checksums track the changed function and are stable across rebuilds"
-- 
2.53.0-Meta

