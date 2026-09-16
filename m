Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B04D5993
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584391; cv=none; b=KbMMPOIj8RK1m4D8nls16Entsp3JlCdbgyn4eb77fUfqZZ+wWHb2nZv65K81M5vLOgDk8vUQCDSNnVk32v/aeX19i7Xkl5x1v018j/I9HYXkhXJE+mDsgNGPtFqMPQDRvICJNjRkqOtvE6NaungpzLx0fwnBEbHXg7zUs4tBleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584391; c=relaxed/simple;
	bh=+xN//YA5nPU5daS6rar0SIeVdiI9BoIS1L+6R4FwffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJMKn/F4vaxxEzR9wF/wSl7pgwWYIQ9ulXOiW9k/fqlKgT9KR6XDB0FmEhW8J4zm33kmT1W0Z5/wVmNZc9yz1s4K4y8e2al1MUr+qrPVI/mXHR90sD6/DkT6gtPe52MNQ6yuJ7ELoCH4iIsHRd+mNXEZqhtGjcKK1wGztMa4btc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJCL5dsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJCL5dsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD351F0089B;
	Wed, 16 Sep 2026 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584362;
	bh=Lvfjcabrj6b8SwESpvZTawm2JVF48rrpPp82GZRO3t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJCL5dsFxsIKn/Tm3wPmgMNhP20cJDrBuDlff7i+NQYBy2MDEXgN+MVlE4t39zK1g
	 nodHreZByryZpkrg8h6G7ZLmIiNpDCq23s10xo1MO3spy7Yt7r9GBVn9zFM2EE4F3P
	 9A+4SGYV+7dyM/e2nBq97O6s0XmQ08BfBXBt1qIbFw+wlEsNMvsWAoBQjI3hj9hcHK
	 GzgLmr3Da458KDUAP+r1KlbrawfqpkznDIgmppGOQaCLi4DJKoSKbM2Y3tcrg6OVWU
	 GKOITiKkieoV1sxClk4+uTIcoK8vl/bAGlFnToJ8zJ2z2Q7yT541tPHsTKhpAuHIR3
	 0XLbYz2C8WQKA==
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
Subject: [PATCH v5 26/58] objtool/klp: Add test for unchecksummed input
Date: Wed, 16 Sep 2026 11:43:19 -0700
Message-ID: <20260916184351.2720310-27-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

klp diff decides what changed by comparing the per-function checksums klp
checksum records in .discard.sym_checksum.  Handed an object which was
never checksummed it has to say so; silently concluding that nothing
changed would be the worst available answer.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-missing-checksum.sh     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-missing-checksum.sh

diff --git a/tools/objtool/tests/generic/test-missing-checksum.sh b/tools/objtool/tests/generic/test-missing-checksum.sh
new file mode 100755
index 000000000000..89a05b1869ed
--- /dev/null
+++ b/tools/objtool/tests/generic/test-missing-checksum.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Without .discard.sym_checksum there is nothing to compare; concluding that
+# nothing changed would be worse than failing.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair basic.c
+
+( cd "$workdir" && "$OBJTOOL" klp diff orig.o patched.o out.o ) \
+	> "$workdir/diff.log" 2>&1 && fail "klp diff accepted an unchecksummed object"
+
+grep -q 'sym_checksum' "$workdir/diff.log" ||
+	fail "expected a complaint about the checksum section, got: $(tail -1 "$workdir/diff.log")"
+
+pass "unchecksummed input rejected"
-- 
2.53.0-Meta

