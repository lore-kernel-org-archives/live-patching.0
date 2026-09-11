Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AAE364029
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152334; cv=none; b=GbQZi8QJ0v8NmXtHN01LsmBUjuT+aEL4nAJL8y4e0ZO5NpTPP9OYHzD6dlzfyZb6F+DM7+0OVSDQPrfNES1Q/SJCmQpTC77SJCLRYt2xkqIsZtwHqLmhL3OnURkg8nPZImQL2Axw7lbLjPYCBwVfvFeakTmpvalMukfy+WsXXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152334; c=relaxed/simple;
	bh=paJuQdKNH5Ytr4PlK+0pYUCu5AJ2vyCncP4mTTaiM1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChmVlU7cmvg9bpKrpxl2H0uSlPvW57Ope4ejRDLgWqCxGFgbKl2PxuPIgWFdCM+slIkEmDW8WhIZ2sdBWG6Jm1M3Mv1CYLVpgWKkxd7hDBRqw9wXT+C/eGMdzPjVhZ7tPKHtEb3XLxc78Ie8XclpIbYH0kdYfhJQKZslpw6sIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osgPL0WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osgPL0WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A361F000FF;
	Fri, 11 Sep 2026 18:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152332;
	bh=K19l8H4b3DtUsBqJ1QSkV5L6QGCnBAjDG37ydmV5tuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osgPL0WOEEHFM8Z4T2XiMMuCYer6fjnDBIBK6MDqM3k3uHbTpUuUh4zP8drCdsfv+
	 04P4GvU3aMh8Mac0XR6gwMRa0UjiUmNMhgFHjdHenvoexAiMk9mAcPlZmHn1c0IaKb
	 UD7IUL568DkHXci2UEUce2piD3JWa4ogJHD6ySvlnSZIUpPajUs5LXEX1jrtbQljoC
	 CWxqIw/GSxq23oI6c4Z36lGrDyQNcDohiZT0Hm6FnljzAW4RGcjcQCUbJjy5S35FU+
	 nTvk/RUNSzE6Bfj3OViRwBjKAwwE6/PcwI3fhDjuLTD66z+bUP9pk0RgU6haNZbwpn
	 czRXhWpwf5Nzg==
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
Subject: [PATCH 23/58] objtool/klp: Add test for rejecting references to init code/data
Date: Fri, 11 Sep 2026 11:42:30 -0700
Message-ID: <20260911184305.1457308-24-song@kernel.org>
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

Init code and data are freed once boot finishes, so a klp relocation
against them can never resolve.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/init_reference.c      | 16 ++++++++++++++++
 .../objtool/tests/generic/test-init-reference.sh | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/init_reference.c
 create mode 100755 tools/objtool/tests/generic/test-init-reference.sh

diff --git a/tools/objtool/tests/generic/fixtures/init_reference.c b/tools/objtool/tests/generic/fixtures/init_reference.c
new file mode 100644
index 000000000000..51b2a57dde14
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/init_reference.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Patched function referencing data in an .init section. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static int init_only __attribute__((section(".init.data"), used)) = 5;
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + init_only + 1;
+#else
+	return x + init_only;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-init-reference.sh b/tools/objtool/tests/generic/test-init-reference.sh
new file mode 100755
index 000000000000..8bf4b98bf458
--- /dev/null
+++ b/tools/objtool/tests/generic/test-init-reference.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Init code and data are freed after boot, so a klp relocation against them can
+# never resolve.  Such a patch must be rejected.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair init_reference.c
+run_diff 255
+
+diff_log | grep -q "can't patch or reference init code/data" ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+
+pass "reference to init data rejected"
-- 
2.53.0-Meta

