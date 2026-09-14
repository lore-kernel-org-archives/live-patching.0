Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3F3E49DA
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367291; cv=none; b=mlKh8+h0bGGN8jdbdvokM+hBSG+OhHILaE9zRgrJiknqOcmfjiWMBWf+KjAm+1KZbB6kX5t77IGp7oTdu9P9nvzY7ahLXmYsFKF+fsPCoxCkwfhtPEXtURA0GPpUFMQL1WxNZLQIHx4vYgKocp4gted3qWZNyRTGUe1iKUqB/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367291; c=relaxed/simple;
	bh=Ito7ebvG1LNLBlrJb6fD4kRKtT4NltRovU60aVKrIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjkGYzFB7TSuRtA/XT1ZJtZXZbeS9trUigK+few0HEY4FGsYojiWPVcfCNI00JqO/pmtzlkXRq7ORnrqqBcLhqhqTvYGV0ZwXMmtfe4BtE8X7Q7mWawc5SUBESvoywrohXebFFz3bkZjukAKiC07QarKU8d8HiWIqOoGVH1co+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiM879O2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiM879O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F291F000FF;
	Mon, 14 Sep 2026 06:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367289;
	bh=eG2JSvi9ve7FmKyFYGEcVlfvCpZ5lHgOSVC3BH1rHkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiM879O2nWKsQqh+YN7yHEgnCw/hwOJaBAv3jFyMaoxVUKyIIkIK8G7tvRbTjYLJt
	 vvblxeEFfuUi2CjBlyGHmnM2L7lxDFOZ1qYatFVZ3+C16+/4fxQH3NejlRFJrNk5Pz
	 tiEOjvM234DwV3uwVFDkm2j8JQa7RLxgRHt/YzfSgMXCVw9SBy/MTqyfIrnBJylBmK
	 1H+ZioQ5+pdJrn5wvanzKUSSpvmabeQbnJCkh002cl+HA32aD/G5nckoZ5eNIgm52m
	 csP74uYbHG4Ns9ceNsBPLE5Jt28fYH1YmpOIudwpF/piGH+iFBvcx8cFuFqjQcJNqB
	 LNzsm97TgDJFA==
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
Subject: [PATCH v2 30/58] objtool/klp: Add test for Module.symvers path normalization
Date: Sun, 13 Sep 2026 23:24:46 -0700
Message-ID: <20260914062514.926997-31-song@kernel.org>
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

Module.symvers names an export's owner by build path, and the kernel knows
modules by their runtime name.  Without normalizing one to the other, an
export owned by a module is not recognised as owned by anything, and a
reference that should become a klp relocation stays an ordinary one.

This tests the behavior of commit 8668bf91e050 ("objtool/klp: Normalize
Module.symvers paths to module names").

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-modname-normalize.sh   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-modname-normalize.sh

diff --git a/tools/objtool/tests/generic/test-modname-normalize.sh b/tools/objtool/tests/generic/test-modname-normalize.sh
new file mode 100755
index 000000000000..a8059bdbd667
--- /dev/null
+++ b/tools/objtool/tests/generic/test-modname-normalize.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Module.symvers records the build-tree path of the object that exports a
+# symbol, not the name the module has at runtime: "arch/x86/kvm/kvm-intel",
+# where the kernel knows the module as "kvm_intel".
+#
+# The klp symbol name embeds the owning object, and livepatch matches it
+# against loaded modules by name.  Left unnormalized it names a module that
+# does not exist, and the relocation is never resolved -- at load time, with no
+# build-time complaint.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_module_pair cross_module.c klp_testmod
+
+# A path with directory components, a dash, and no extension.
+export_syms
+add_exports "arch/x86/kvm/kvm-intel" other_mod_func
+run_diff
+
+# Directories stripped, dash to underscore.
+assert_klp_sym other_mod_func kvm_intel
+
+pass "Module.symvers paths normalized to runtime module names"
-- 
2.53.0-Meta

