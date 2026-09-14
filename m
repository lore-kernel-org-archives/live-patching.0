Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B93AB269
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427171; cv=none; b=XIplDf7qoz83CqAGwOBZNsahpT5DfFCid/eBu27NeuXQDuIsAYvPnGjNQtkkMHVugqpwvgBCmyn2DILKLrzszcyUmvjIenya09QrBc/TT/2AcJDsM9yt8Fm0tMJk8uSrZoJFJ7NvblnQOR2nqdjPtleKnfXpPZBjPCLNZnSyipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427171; c=relaxed/simple;
	bh=+xN//YA5nPU5daS6rar0SIeVdiI9BoIS1L+6R4FwffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcl+RcKKTwKeyIZwnzR5qYnmijeyHFw7Kh+v+6zp/WIa4c3HOiyfHgP6Z+5+VvB/sLhsGM4b9xT3CbsIC6lv/8S64KElVSqYu0G6OYm/+lS6utefvP/0P0Jk5KfUnprykYPHz2JdcEsvW133w2+2ad6czor9wixCrLrA3TZrpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLsptM3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLsptM3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4A11F000FF;
	Mon, 14 Sep 2026 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427169;
	bh=Lvfjcabrj6b8SwESpvZTawm2JVF48rrpPp82GZRO3t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLsptM3BPKR1ti90fYLaMsii5GIZ9ILXPcFeo223Rv2OotQ1u/HMHUBNO3lkOHqBZ
	 J5/7Pu+AJ78LAMVWuDL9Bfwvu9cL33Vq8EXy2B0Bo21ttQjRl8NIdVsK/F+Hc1+igC
	 uu2Q8cR5GtEWuGC2ulF/q7o0ytK0sc5hrbB9oigskCPMoOVM02QW2+zRdPv2mqpgpw
	 es+nfYJgWqOlKjpyhnPcF3/wvgKC8vThjH4BxCGb8Z5ISS5Gi1lP/wcri9oygRECen
	 ZNIiAN63FY8u/idC03fBdksBayXpKdtJH+6ot3hm4yO6zZQ7xGoDhkJdf2npp5/vUa
	 t3gjHJ+SuShCA==
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
Subject: [PATCH v3 26/58] objtool/klp: Add test for unchecksummed input
Date: Mon, 14 Sep 2026 16:03:23 -0700
Message-ID: <20260914230355.3422996-27-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
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

