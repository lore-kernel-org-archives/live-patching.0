Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791D3F54BF
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152650; cv=none; b=Xs/hGyCEbIYZLOIkQCm0yOz/Ngs92qU4EkPO5CMvUp3HeXJrwdjz7qy6xPv38EMFSYjPq8PkRHltqdYRsHDS+27e1q5TAs98rl1vqJFTwehsZKGCrK1OJfdm8xkWJD4lZGkC7gk0DMqJZuVWysP04U8EhQf+2fo5LhxW7aFck/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152650; c=relaxed/simple;
	bh=+xN//YA5nPU5daS6rar0SIeVdiI9BoIS1L+6R4FwffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxBFpW8COpRFCDXuy0o+/0ubQfNL88MK8NKtOmnnLLtgdv0nonz5pldaAjCq47ZlyM+NrhVexFgatlR5GtZV0Y9RjNuEdiSAhfuZM54SNBzY5yEWIjg62pd7mc1YkoIA1o1Ni2q7/3ZGECANLOgFHX+R8z8eTa5s+4vzHnzfz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLVkxsHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLVkxsHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136681F000FF;
	Fri, 11 Sep 2026 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152649;
	bh=Lvfjcabrj6b8SwESpvZTawm2JVF48rrpPp82GZRO3t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLVkxsHl7XsmOEWR/cwltmjQaAwoMMhQOEibZ3/X1rYJvspEvQ8SbFPo6SQjNZEQi
	 W2JZJnWOfAm3uMBOWQ245Hs/skkdKiTbxnLafQUzbAOnHW/3rsigu+OTCZ1Ko9HU7N
	 MVqq6Qii/oqFSnrhgb0VlbuksBIhjh0gL8KPp1veiFPF+mQcVc5ZrMmvIN07QSXBF3
	 3XQ189sUdSHHl8BLDu3rrtNDIj9QMHpj6yjW9Q4rzitzjpcVJcOLR2onhMj/aTzymX
	 Yi1ub93m9RpiSXrKgJdoUbhyCCE1hbQ+2eUL+xom4KGgdfRv42O+czJYTD6JCo1q9r
	 /5bbsLPPdZkTg==
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
Subject: [PATCH 26/58] objtool/klp: Add test for unchecksummed input
Date: Fri, 11 Sep 2026 11:49:59 -0700
Message-ID: <20260911185031.1534046-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
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

