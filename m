Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851114D09E2
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515495; cv=none; b=XW3GqSs69bPBp2zrgEtoMhUxkQCF/e11JqvDxZTmF5lsT/dkQZbxUyyHgNFhp2nYa0caInW9mAV03+/d7uAzpJyTx2+5qS+sl6+OBSat/PYHV651YalI99CFIZR7v4BczFlVMMFNTBriyr6/QeJSO7p/gV6d+yANhNGkdpVqwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515495; c=relaxed/simple;
	bh=O/Vyyquoe8PAs/bXEMIJGZdXPAzwhVdbV6aQFeqCMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlJhC7dua7M4TW9vgl+YYZfSAoEmKGq95HKMjBIeH4lttXfKt/gfotZreIwlRUo3TMFR6VKslhRF03uVFRsYKu3D2RPNbXQefXrxOKKBjZCUCcCZU/HJeZMLQZeXCf2VtemEII6filbmNDySEVUeEgCJJSs4JBwgS3SsOznhSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1CUMm6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1CUMm6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36B91F000FF;
	Tue, 15 Sep 2026 23:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515494;
	bh=WV5VeW8fRzrqpwY3VtpGMwei4VK+vatQRHwjjgTf53I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W1CUMm6wFnXlpAoufS95lOFigNSsChnB8esGt968pFohIKrK8KhVCjzT3ZLk33eQz
	 2kRbDa+1DCEmLDqn0+cgf9nCic0Qztf3suvuFmpC5aLcz8sdIFVMCQBrHjLtORCpXA
	 vVbTSiDqz7wNL6lEkb7AMmdPFUXdQR8FmaCmv5wLyEJ8UA4ZYxxs4sk4C/HhwBffC4
	 KCDRr+Lq5NZYxTUvozLtwTBFxOrd8QiXreRnP30EZXr42PN59ddpAlve9eWPPx/8a7
	 0CB3yHR2tYkAYY5EVLdYHceNNtAzdb+iAGS3e5PP77BZe3ARyzjoU+PuVjWnYAmIll
	 arenuFF1GAzkQ==
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
Subject: [PATCH v4 35/58] objtool/klp: Add test for recorded checksum values
Date: Tue, 15 Sep 2026 16:34:31 -0700
Message-ID: <20260915233454.2405019-36-song@kernel.org>
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

