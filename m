Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5A3D7D8C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367316; cv=none; b=Pwv4N/4teTEIKui5Lb32wZPi3P044cdjbd/yP34RgI9RexZ7yy72zgB3QpYtX8YEQVYmFQ1tQ1bNk3Cq46qiK7C7RbgBk77fmSLrcBmdaV52BH68SWM12oLDL2koHHf41+hc7Lk/+jLWY4Km4YfY4PL0z1mecG4HOZtUfXXRXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367316; c=relaxed/simple;
	bh=O/Vyyquoe8PAs/bXEMIJGZdXPAzwhVdbV6aQFeqCMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhyL6qgZ4LHbSqqnrDgA8MynoOkV+bLpwi+4IT9jraGYfvvqFLGtTzf7tH/6jOfgQbmLXRZLrFAohEMdfVE9UHsVdqbmW3BKRt0XbPe6Z8QwaotrVUap0ge4cCGY+g34g2Tdv+qe6SuXjQGO0n1w9mbcBaaXkupaYp8CE1Pir8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/iN1xJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/iN1xJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C51E1F000FF;
	Mon, 14 Sep 2026 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367315;
	bh=WV5VeW8fRzrqpwY3VtpGMwei4VK+vatQRHwjjgTf53I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/iN1xJC+xGmhaJqCCiqfAsxgNoxcbt1MpoVpmdOASdMbwG8gHeRAbdje1IBwU+Cz
	 8dOMue0DGtiOpWkiBdSa6X/535SySpNVTXtAjChdlUDdfJ3FKq2Lf0O0CGmXZOq3KI
	 VRV7wH4rwamFAJcLm6SZemmi6BIz4NFgxmIDUuyqsTDUURBMKycHnjXpNomnu/ck3G
	 trLL+Zl58fZqVClcI+rDC3swgEYk3UbRnt+m+QYa1KP+96RKwtPdPM06BUFAwYJToq
	 DjpOaq6zr5vDfQYQL5ViWeKNA06y1WS0YghKPbaZzIQJDrPpUNa1DmQanJfeim10yY
	 M2aojzis5jAzA==
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
Subject: [PATCH v2 35/58] objtool/klp: Add test for recorded checksum values
Date: Sun, 13 Sep 2026 23:24:51 -0700
Message-ID: <20260914062514.926997-36-song@kernel.org>
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

