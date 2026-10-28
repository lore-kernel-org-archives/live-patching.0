Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223990;
	b=D4qy6xnDXy8YfBEcXq6Na3JeOW61HLxSfWMrpmugeV/sXmRrVvG0/M2tH0/Mj6VTs+UM
	 XooUR2E3qGhvuUvG+bfwP44gUXTUTeev5HRZjEmCALtnMVfAoyKRwjHX6Xy0y4q7PN9p4
	 xO1G3M8tzFoIZje+abCcESYG/ZOD6Te6Lji7BBWR/7nM+DgtC8fBgw/wNcNiS6xMyB1JD
	 FgRWfBURYn9vDCWTSrirSJTVKxAwyNdzoGbc+UuYWrSI4PNYolI/fh5el0LpKaOz+iiBf
	 qeeSUPKxp/36q8RgSPjcudVPYxrpAc/RntuE+AMOj9mg0MEyGCp6LlZHlyBIXbzB1Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g/N0NwzCaJe53Lw2dzpkptXRKLdnJI9dMetTrPjUKaU=;
	b=RysQhs2knTBdPaWc3Fr1XfxaQOEH+XK5KJGtTAPJZ1dCQcuCwT4PKi0Bow0Ilw1NJOdo
	 uoUCQoUBmoSwKfwMXllxFhfT7jHlGziZfUxU9haxI+KE/NHCHwpDR2Q6Uj9PA0Nwpapbu
	 KUMJ/+YeanYhqY6nUaobf/Kc3Jw074QqlwGtEnIc1NsK2oEfOUZWlebx3NHEQB2O3b8QN
	 Na+QHwK3DQGRVW5INWNNjEArtybD06OiwQ7Bqu7NXq/i9jc/PJwKe3QAuFPpw376Qqaye
	 6rfeAQEN3y8wLRqz4FwUXP6v4Gjm3lXrAUnVdlUEVYHyiEyMahYwatjgtshSr89vZDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsPhCg9i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE2606A31A;
	Wed, 28 Oct 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsPhCg9i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC861F01401;
	Wed, 28 Oct 2026 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223989;
	bh=g/N0NwzCaJe53Lw2dzpkptXRKLdnJI9dMetTrPjUKaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsPhCg9ikOlKN/YcrnHsmis5CtAzx07yNMG+g0PViIWZHiviFvw4KeqY3CK54BzaA
	 dK6eN9+H+jK+CLg40ANnBUws9tnu8/maQVugDPPoAXXhdlK123FkgZ07NPqUJFnpAG
	 sY5OvnBDTUfpWfT5TFeIsFpVRfpNeGTeL4bDBcuKDpPiBkk1sMw6buY5bs8GErzADZ
	 1Bh09VszppGgOOa77/XmGOChS5mb3GZGKnGWsW1mBezZyDsVwQSeHZzbiciwSVa8+B
	 Qdq0cxku996n6wdysSDb9ySlXTttaScivzC8XtueERdEfNm9FF9VOu5vM78fKZLeoR
	 FuK3W6PgrALKQ==
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
Subject: [PATCH v2 10/12] selftests/livepatch: Test klp-prepare-patch with unsupported files
Date: Wed, 28 Oct 2026 14:45:32 -0700
Message-ID: <20261028214534.1919398-11-song@kernel.org>
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

Add a test that klp-prepare-patch rejects patches to lib/, the vDSO,
real mode code and assembly files, which klp-build can't build a
livepatch for.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |  3 +-
 .../test_klp_build/test-unsupported-files.sh  | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 902a62bfca86..02feb1ad52d0 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -5,7 +5,8 @@ TEST_PROGS := \
 	test-independent-patches.sh \
 	test-cancelling-patches.sh \
 	test-new-and-deleted-files.sh \
-	test-line-directives.sh
+	test-line-directives.sh \
+	test-unsupported-files.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh b/tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh
new file mode 100755
index 000000000000..eb360923ecb1
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+setup_tree
+
+# - patches to lib/, the vDSO, real mode code and assembly are rejected
+
+for file in lib/string.c \
+	    arch/x86/entry/vdso/vma.c \
+	    arch/x86/realmode/rm/video-mode.c \
+	    arch/x86/kernel/head_64.S; do
+
+	start_test "patch to $file"
+
+	add_patch unsupported.patch <<EOT
+--- a/$file
++++ b/$file
+@@ -1 +1 @@
+-int x;
++int y;
+EOT
+
+	run_klp_prepare_patch unsupported.patch
+
+	expect_error "$PATCH_DIR/unsupported.patch: unsupported patch to $file"
+done
+
+exit 0
-- 
2.53.0-Meta

