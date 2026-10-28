Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223994;
	b=If4C8R+QOUN0pnuC2xEQM0MDtVPA3fOqR3ipzZrksmQCtvWTADv9ofx0yX/Wz0zkpZYH
	 nU1aNajYtOR7bAzB1rEgfcwpUaEUBdMrllsNNvUd59mKVOcEDmrwoSNh7punbvgKuN0hA
	 TRbOHqK9XIBis3d+FBXSY3q8aHoRAXIOwyMNR0Ln+/TYKtZXt8W5h7uNQnLifuoFNPORO
	 rncaNosu7WKdlnAw2Pbr4RnMGvovheIGmrBuD7ndlwnljbC3ahBSs2AMJvs+1Ysz1hl4I
	 HgMF6bt6oIUcOdz/BmIrUChSjoCC4SPrETv+03ImWWnlyG1GQ23Okirgi+ClKnFFVmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uAxvqSX2kA3fyLPnGMXVT0LzCwzXBbu1y4NCRJrG17w=;
	b=VJtne47s2stoJ03Id55k0rbW/BG+G3oNNTKL5nAW49sqTwnxk5PPaqq1Kb4pzQwzHJNQ
	 kkTNpFdbEqrIYjbIAvx1ICynrY2NCKWRILcsqxjgkdpaNi6B1qLtazs3VienQjLwiUnXf
	 77XWSTSVKJEpds4DCsZ2rysy1YuxW0xJN/fwxWnqUtoi0v+38psBPdCkxASoYElsl7DBh
	 iJZgvLQ1MXLXns4OI34MujeAq2eLD6Aq2LvnYMljCNqWMTu+n+Sb6Ihv99DAsyun50xB9
	 7GXtF7Yk9IVhJe0P+pW7jQvSMsXdLnMOzjFMvnwYW/tnK0SItTSb9EeK10qRUeyovNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCyvmozr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3D60A262F;
	Wed, 28 Oct 2026 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCyvmozr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389011F01404;
	Wed, 28 Oct 2026 21:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223994;
	bh=uAxvqSX2kA3fyLPnGMXVT0LzCwzXBbu1y4NCRJrG17w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCyvmozrfTd47CWtZEkT6U/+Hv8unaCQNGMargICIGCgA17E9vS6UVvadDrRSANvX
	 JcMk6SghTLUJy0/gealfpuCtgvBDtnvIqFuvxdHhTN1YUO2jbcLhZVZmQH6RzrnzEn
	 EthVT0Hd+5IMHX/am9k+DYO3mPiQbtLZXnvpdZk/6rJhOP/b6nfUcrIKElewkJ4DKB
	 a0XFsE8omX04Jzj+AEkvd7vKONu1tQRPfjQgeOv46cMEpqhm4HI1qeysyQ+OzQhnh/
	 bOmk6N7s7sduO1t6/XaqzqLDniIcPWDiNm6W3+VW2BMnPBD7hRZnnGsaEM4KIih4+H
	 7x0f9IWkJ6PDA==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 11/12] selftests/livepatch: Test klp-prepare-patch with patches which don't apply
Date: Wed, 28 Oct 2026 14:45:33 -0700
Message-ID: <20261028214534.1919398-12-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>
References: <20261028214534.1919398-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that klp-prepare-patch rejects a patch which doesn't match
the source, and that when the second patch of a series doesn't apply,
the first one is reverted, leaving the source tree as it was.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |  3 +-
 .../test_klp_build/test-patch-not-applying.sh | 73 +++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 02feb1ad52d0..3650de4d6975 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -6,7 +6,8 @@ TEST_PROGS := \
 	test-cancelling-patches.sh \
 	test-new-and-deleted-files.sh \
 	test-line-directives.sh \
-	test-unsupported-files.sh
+	test-unsupported-files.sh \
+	test-patch-not-applying.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh b/tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
new file mode 100755
index 000000000000..32e871dc7ffc
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
@@ -0,0 +1,73 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+setup_tree
+
+add_file drivers/foo/foo.c <<'EOT'
+int foo(int x)
+{
+	if (x < 0)
+		return -1;
+	return x;
+}
+EOT
+
+# - a patch which doesn't match the source is rejected
+
+start_test "patch which doesn't apply"
+
+add_patch 0001-bad.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,6 +1,6 @@
+ int foo(int x)
+ {
+-	if (x > 0)
++	if (x >= 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_prepare_patch 0001-bad.patch
+
+expect_error "$PATCH_DIR/0001-bad.patch did not apply"
+
+# - when a later patch doesn't apply, the earlier ones are reverted
+
+start_test "series whose second patch doesn't apply"
+
+add_patch 0001-foo.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,6 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 0;
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+add_patch 0002-bad.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -3,6 +3,6 @@
+ 	if (!x)
+ 		return 0;
+-	if (x > 0)
++	if (x >= 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_prepare_patch 0001-foo.patch 0002-bad.patch
+
+expect_error "$PATCH_DIR/0002-bad.patch did not apply"
+
+exit 0
-- 
2.53.0-Meta

