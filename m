Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746F3AD515
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427186; cv=none; b=cHhOy2ADJPHpRGXkUbCxjnS3j1wLJwTfrJ0+KaajjRfXuyT0Tq2dQMjdjqSfetwdWYJsdzamwkI77/7c2jWUSlZPt3od2gdplmqiYF90BXNACE4yCm9nt2eezC3nW0IkT4rtGP0HdVfbAPRa+frU8L7aK0pzQYwxpCe2WNdvL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427186; c=relaxed/simple;
	bh=OV3PG5RHEQDDlfYICSq8BEj5/hfrpKxcNJpcc4Pl8iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaTvbcI3500h+VtMUGkbYv7YTWF59aq+NESbinGAfzH200nhRXTGLAC1ozwAuSUNRVMN0fei7yj978XgQCgieoU6fpCFGiy7zxRb0HROAQdRc2LmJKDmZZ+R2Oje7vIgTKEyy41RG8axvHSu/zp5I/ZMgMtPnKDJtVRYNkd6AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POY7/znI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POY7/znI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963D91F000FF;
	Mon, 14 Sep 2026 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427184;
	bh=+mQmUlzGh2hgexbyzeasUkjBtvD1pESiZPPcrmg700o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POY7/znI3e8bsDD5sLwH8/exPPvL1VBUgkR+6j+tn+D18NnZFMWiD2uypFsKEeTBz
	 2InYRy9xCWjAZuTmw/xCxk0C2iRH50uTo8JH9s9dFN6K1eqGSqESJw0Nbq8YFhaIcV
	 BRxv8SjmtfWtpThjQUfBs7igO3q7K8ZjjZ1haF96B/C5pNObDt3WAJXh8D7bwRM7p9
	 6UmJlplt8tz/9bR2YjnsMZGn0xJAT7vPNEQAek3btwybSLK7XNcmBBrVi1vkaZhz+d
	 +SwfkoGSIVG1sndTqf2RuNATSZmhbyHY5N5NoB+mmpLkmQkVEmJKofaxQa4ZlPQ9NZ
	 DbO5cUZd5QdnQ==
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
	Song Liu <song@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v3 29/58] objtool/klp: Add test for vmlinux relocs in a patched module
Date: Mon, 14 Sep 2026 16:03:26 -0700
Message-ID: <20260914230355.3422996-30-song@kernel.org>
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

The kernel refuses a module-targeted klp relocation which names a vmlinux
symbol.  An EXPORT_SYMBOL_FOR_MODULES() symbol needs a klp relocation, so
patching a module function that references one only loads if klp diff files
that relocation under vmlinux rather than under the patched module.

This fails at load, not at build: klp-build produces a module and static
checks of it find nothing wrong.  Hence the assertion on which object the
relocation is filed against.

Reported by Dylan Hatch, whose mod-ns-lp branch carries the kernel-side
half of this case.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/test-module-vmlinux-reloc.sh      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-module-vmlinux-reloc.sh

diff --git a/tools/objtool/tests/generic/test-module-vmlinux-reloc.sh b/tools/objtool/tests/generic/test-module-vmlinux-reloc.sh
new file mode 100755
index 000000000000..635a75f6b8ba
--- /dev/null
+++ b/tools/objtool/tests/generic/test-module-vmlinux-reloc.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Patching a module, where the patched code references a vmlinux symbol which
+# needs a klp relocation.
+#
+# The kernel does not allow a module-targeted klp relocation to reference a
+# vmlinux symbol, and a symbol exported with EXPORT_SYMBOL_FOR_MODULES gets a
+# klp relocation.  Put together, filing that relocation under the patched
+# module produces a patch the kernel refuses to apply to its target.
+#
+# So it goes under vmlinux instead, and is applied when the patch module loads
+# rather than when the patched module does.  That is the opposite of the rule
+# for a reference to a module's symbol, which test-module-object covers; this
+# is the other branch of the same decision.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+# The object being patched is a module ...
+build_module_pair cross_module.c klp_testmod
+
+# ... and the symbol it references belongs to vmlinux, exported in a way that
+# still requires a klp relocation.
+export_syms
+add_exports_ns vmlinux module:kvm other_mod_func
+run_diff
+
+# Filed against vmlinux, applied when the patch loads.
+assert_section __klp_relocs.vmlinux
+assert_klp_sym other_mod_func vmlinux
+
+# Not against the patched module: that is the relocation the kernel rejects.
+assert_no_section __klp_relocs.klp_testmod
+
+run_post_link
+assert_klp_rela vmlinux .text.target
+assert_no_section ".klp.rela.klp_testmod..text.target"
+
+pass "klp relocation to a vmlinux symbol filed under vmlinux, not the patched module"
-- 
2.53.0-Meta

