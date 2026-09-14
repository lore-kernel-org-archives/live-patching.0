Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A473AFD0F
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427277; cv=none; b=SrcVAM7RZist0EV0bXF+vDV0w+o8I54LhhdUreC5bBispmEPLomvgBxF8OpJmNS77851rUFJ0XbuXDFZAYj83IJtxjedsqweAjrB4V3z7Xep8ydD+ytDgDCMHHkM+bOLAlEEoy1x6cZPKpkIowNGxHipWPzwn+tPcA14gb8GqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427277; c=relaxed/simple;
	bh=e/pHIANHGDYMRXnxBmpEU2yFNHUvnLnAZ8w/B1ZL/ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua/hPvWO/+eTCPKbSfLA4w/35KTIwCPMx6JhVkAr/LbRy0y709y5sPpPYSXeae/TX3kWlQ2jsAws34QTeu194ce9I2IezzCNHOSuYV7LroPSqVC1HzaOQfB8of71xMr5aeb6OMlJX8FuuoBrc8DK4mWPLz8pidMGsgdlekMD3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If43bN+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If43bN+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CA21F000FF;
	Mon, 14 Sep 2026 23:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427275;
	bh=grYbOTHUMFqnye3BkRz1M3IDfTiEJErLed7bw7Y6x0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=If43bN+sw03KLNfn7Faj4tHiAnMpWqx4swyIahXOfFio/qqBSd5CTSVB15CEodizV
	 zugRz6oPkpmufJ7H+PLKxm6LAlVQ7rNv7coiYV32kn4jzcq623IB52xV8DuJ5SUaI3
	 YS2ZMROsp4i5d+NHU4vYft8FX7XlsEuOeOzcQPM5XwRq8Lb7Vj6xNRM5AZokqAqa9h
	 k8An3RAnkZ8CeB6IdoxhYZH7lPeM5kvN17sAYFBgg41mPbR+dt9NUzCSc2qDbOncNf
	 Ic9XfYWACVlw8zbx+/6mY2cSnmTG1243Y0W20mMRiNtyjnzQ181eNpk1TOhQg4JzPb
	 2pYDhGl2ZhizA==
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
Subject: [PATCH v3 48/58] objtool/klp: Add test for a static branch introduced by the patch
Date: Mon, 14 Sep 2026 16:03:45 -0700
Message-ID: <20260914230355.3422996-49-song@kernel.org>
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

Patching a function which already has a static branch and adding one to a
function which had none are different cases.  In the second the
__jump_table entry is itself new, so there is nothing in the original to
correlate it against: klp diff has to carry the entry into the patch from
scratch and reach the key the way it reaches any other vmlinux symbol.

Dropping it is silent.  The patched function keeps a static branch the
kernel never patches, so it takes the same arm forever whatever the key is
set to.

Give the fixture a NEW_KEY knob which puts the whole branch behind PATCHED,
and assert the premise -- that the original really has no __jump_table --
before asserting the result, since otherwise this is just a second copy of
test-jump-label-key.

Verified by making klp diff skip __jump_table when cloning special
sections: the test fails.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-jump-label-new-key.sh  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-jump-label-new-key.sh

diff --git a/tools/objtool/tests/generic/test-jump-label-new-key.sh b/tools/objtool/tests/generic/test-jump-label-new-key.sh
new file mode 100755
index 000000000000..3bc6005fc776
--- /dev/null
+++ b/tools/objtool/tests/generic/test-jump-label-new-key.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch may introduce a static branch where the original function had none.
+#
+# That is not the same case as patching a function which already has one.  The
+# __jump_table entry is itself new, so there is no counterpart in the original
+# to correlate it against: klp diff has to carry the entry and the key into the
+# patch from scratch, and the key has to be reached the way any other reference
+# to a vmlinux symbol is.
+#
+# Get it wrong and the entry is dropped, leaving a static branch the kernel
+# never patches -- the code takes the wrong arm forever, silently.
+#
+# Where the key lives still decides whether that is allowed, exactly as it does
+# for a key the original already had: a module-owned one cannot be reached, so
+# introducing one has to stop the build rather than emit an entry nothing will
+# resolve.
+#
+# Covers the same ground as corpus/x86_64/static-branch-vmlinux-new and
+# static-branch-module-new in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup klp_test_key
+build_pair jump_label.c -DNEW_KEY
+
+# The premise: the original really has no jump table, and the patched one does.
+has_input_section orig.o __jump_table &&
+	fail "fixture put a __jump_table in the original; nothing new to add"
+has_input_section patched.o __jump_table ||
+	probe_skip "compiler produced no __jump_table on this arch"
+
+run_diff
+
+assert_patched target
+assert_section __jump_table
+assert_reloc_sym __jump_table target
+
+# The same new branch, with the key owned by a module.  Drop the vmlinux export
+# first: while it is exported the key is reachable and being new changes
+# nothing, which is what the first version of this got wrong.
+export_syms
+rm -f "$workdir/out.o"
+build_pair jump_label.c -DNEW_KEY -DMODNAME='"klp_testmod"'
+run_diff 255
+assert_diff_log 'unsupported static branch key klp_test_key'
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "static branch introduced by the patch carried in, or rejected for a module key"
-- 
2.53.0-Meta

