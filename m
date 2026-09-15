Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAD4DF4C7
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515574; cv=none; b=toVkmjLqSYD5BSwNnxlOnxUI7g9Z3LMmsxji3wu5fh06XB28j4gL52+tSFRIgOIxIcMhd+zUwdwfPiOi66SWdu2yyuLfTXORCIezAZTdjrFCkkjNlR4BmPuTAjTw96WfbSGrMeVpowgHbFhYkJBsUP0Kzhk2Rlw9+VogsMRzW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515574; c=relaxed/simple;
	bh=LkInyhU4QZkMyaBVr4spacs2W/gBANQ3CPaNQ+jOfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry+l/fA9ddVtAYLMGfhR8nhk6z41rzpR9MIhiUCnFNfnZP0Xx6BJd0+ytrxu5Mh+7G4X1pEUZP+Marj9yxjTsazKq2g/lp8JmcX5W5v7LAc/Cj1TLRNZ1clE6btzALrs3ofraJqF5ldbJJW+itwQ+3QiAbs6dXXwdffS4rFS0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI+qXFye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI+qXFye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE6E1F000FF;
	Tue, 15 Sep 2026 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515573;
	bh=alxai34FQdFaIrkf9TH48GWWK77DSl+25RcxFbyvZTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OI+qXFye7IXfZv/8svJIRLMzMa7edCOEPfq75gDjYlGVDuWtwRo0IUCq0FN6Drx/U
	 imo5RIp6451hJOEF6UDQoeGPP9F1aFdtgCO3VOYV6DUaqTUoRxU5Vq9T1RvDpJci0Z
	 URS3JDOShUvZKvQahz2oaLSS1ooWTieBmyPKvFX6YmfaeDnFfi5YPjypHXcAhFb495
	 iFrWLKia4dQH/cMu1wGzlYe+p/bncMX+4dz79T3ESOfjk/KKG+qn0U2481jEywltGg
	 WcUCvpD4CtCeq15uL7qtiMhrSsK4mTrWP63o2ns4U5+Bq34nl2a1GLNKf1E9kOyoVZ
	 /5GPAohTOKAJQ==
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
Subject: [PATCH v4 50/58] objtool/klp: Add test for a static call introduced by the patch
Date: Tue, 15 Sep 2026 16:34:46 -0700
Message-ID: <20260915233454.2405019-51-song@kernel.org>
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

The counterpart to the static branch case: a patch may add a static call to
a function which had none, so the .static_call_sites entry is new and there
is nothing in the original to correlate it against.

Where the key lives still decides whether that is allowed.  A vmlinux key
is reachable; a module-owned one is not, for the same reason an existing
module key is not -- late module patching lets the livepatch load first and
the unresolved entry is dereferenced when the module arrives.  Both halves
are here because they fail in opposite directions: dropping the new entry
leaves a static call the kernel never patches, and accepting a new
module-owned one is the corruption the check exists to prevent.

Both halves are one test over one fixture: built with -DNEW_CALL the key is
vmlinux's and the new entry has to be carried in; built with -DMODNAME as
well the key belongs to a module, klp diff has to reject it, and no output
object may be left behind.  The premise is asserted first -- the original
must have no .static_call_sites at all -- since otherwise this is a second
copy of test-static-call-module-key.

Covers the same ground as corpus/x86_64/static-call-vmlinux-new and
corpus/x86_64/static-call-module-new in Joe Lawrence's klp-build unit test
corpus.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-static-call-new.sh     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-static-call-new.sh

diff --git a/tools/objtool/tests/generic/test-static-call-new.sh b/tools/objtool/tests/generic/test-static-call-new.sh
new file mode 100755
index 000000000000..f7d2b39c0fec
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-new.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch may introduce a static call where the original function had none.
+#
+# The .static_call_sites entry is then new, with nothing in the original to
+# correlate it against, so klp diff has to carry it into the patch from
+# scratch.  Where the key lives still decides whether that is allowed: a
+# vmlinux key is reachable, and a module-owned one is not, for the same reason
+# an existing module key is not -- late module patching lets the livepatch load
+# first, and the unresolved entry is dereferenced when the module arrives.
+#
+# Both halves are here because they fail in opposite directions.  Dropping the
+# new entry leaves a static call the kernel never patches; accepting a new
+# module-owned one is the corruption the check exists to prevent.
+#
+# Covers the same ground as corpus/x86_64/static-call-vmlinux-new and
+# static-call-module-new in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_call.c -DNEW_CALL
+
+# The premise: the original really has no static call, the patched one does.
+has_input_section orig.o .static_call_sites &&
+	fail "fixture put a .static_call_sites in the original; nothing new to add"
+has_input_section patched.o .static_call_sites ||
+	probe_skip "compiler produced no .static_call_sites on this arch"
+
+run_diff
+assert_patched target
+assert_section .static_call_sites
+assert_reloc_sym .static_call_sites target
+
+# The same new call, with the key owned by a module: not reachable, so the
+# build has to stop rather than emit a relocation nothing will resolve.
+rm -f "$workdir/out.o"
+build_pair static_call.c -DNEW_CALL -DMODNAME='"klp_testmod"'
+run_diff 255
+assert_diff_log 'unsupported static call key __SCK__klp_test_call'
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "static call introduced by the patch carried in, or rejected for a module key"
-- 
2.53.0-Meta

