Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC703DAACE
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152670; cv=none; b=eTzsa1nhFFcylUGE0rA2SoZrHVYk/ZiFXOVVi4ZP5Hu1Vgl2rleOrJevTCqP6DwzsQwLIXGtEJ6Yji3MqSIbVB019FXTEkQCgkjWq2sz8VCpEPZceP/rh+H0fwxgS1d0/yMu5BLao9fWvfZPdOed+FXVDvGaVB+SI/zqdV64170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152670; c=relaxed/simple;
	bh=Ito7ebvG1LNLBlrJb6fD4kRKtT4NltRovU60aVKrIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcDGsYW8WP9VPIGrZI8kRCLHaAm8oukT+eU0sOPyr2rVLIb6+5szNCl4pVlQN+6gc9ccXjEGEvJISxA1iEbNLjoa00xZIhQxx6dDHbUGbCG5gR4AYvQrVpS+K4+CQc/jKnwKJm1hBxa+7Cs/eIMecEu3ac5xXON30940+65yyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAabZFMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAabZFMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F911F000FF;
	Fri, 11 Sep 2026 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152669;
	bh=eG2JSvi9ve7FmKyFYGEcVlfvCpZ5lHgOSVC3BH1rHkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAabZFMxaKT/w/UtiIv8MzAZYtqJOasD2S7b7EVcjOBkVsEc75FbB0SwAsIMjznaw
	 RUCIrBnRYQnQAcBcoVwH9BmEMIqNbHMB1bA1XjIYK6wMHQmIdo8KQ8Gh6e5aWOmjIz
	 UHwZs/0oYFhfXtYAEspVnFXgBU6y4x3qa3qc6laZoV2QcgFGofusNNAH8QQjJoIzTy
	 QHmo3hHRRddc/DSzbaqK9mQIxb7iCvErg827agg1dVtF4PgynddvZJKwsfjC/r3V9G
	 kEFReUSTC4bVzKrgiUM2fksqQUTN1AYhMXwgxQf79PtCClP4Zjh55FS9d+6wx3gD+P
	 ywUO812jV1VVA==
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
Subject: [PATCH 30/58] objtool/klp: Add test for Module.symvers path normalization
Date: Fri, 11 Sep 2026 11:50:03 -0700
Message-ID: <20260911185031.1534046-5-song@kernel.org>
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

