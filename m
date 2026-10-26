Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010027;
	b=DjvidJobkiwPfiAAnKLosj9gHkJZhkOKxh3IjGuz1zlIuW+zw+LvnTifaWxfLbcO/SRp
	 fdSmkM3fYf0qTcZsUezcqOC0U9WeFxrdFSrAAdC+t4dodqu//+3Gv+qmkC802zbskUMBK
	 fEmBaKy4dYz3A1RbafjdbvgKwfYG0JIzdT/ACGWEzcVsZsutIVtpokA3oUg7JRmlV08x2
	 8zDBdktOJm+2y6u2AaCzmTQdv5quxcZZUlOpvz8DZCfu3GHyQlz2IRBmki1gd9EgozyG1
	 bnziAaexexIwVKzgqse6FjwcZFXFRkF/7TWmKtwz/unfD8NmwRXPMIRiyN4KL41TFEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dw+PwsoARdbNap3UWfqkjK7ETMLi6GNoF5pQtgsQHaU=;
	b=iac0P/yrLMccb+ZPzvysP8LA6mu0HiqOEhixlAY63xvfuQ0JqXNx5v9itirSoZM3Bmex
	 wJijkQR+Wtuo89+wRkaISz7XQUO7qG7ZIjls71JWCI81dhpPFr+ZIdKzVprdBJHfzfLxt
	 Rkq+576ukwu4NhJO1SKYAwQltrKs8HEp2NQbzEb66PQFrIiR4vZxMR+Dza/9KGT71jfMs
	 xQAAwimzQDgHifwl+PAw0mNzeUxfld4zX4ROfL0HM4NyjTPG+za/yryp2A2jOwxeHEXfb
	 l4Gkqz8m7IXrr8xrNhmQPokNfFagAEnjMgjvNZ4HKl6JaJO9dAFceX09MLLnXUeIU6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TDfS0xlW;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150560A2619
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 10:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0150560A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TDfS0xlW
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1513474a91.1
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010026; x=1793614826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dw+PwsoARdbNap3UWfqkjK7ETMLi6GNoF5pQtgsQHaU=;
        b=TDfS0xlWQusW0fH9g2pM/4e8HSd/eujucbM8MhnotTazib7bS52pZsslSe9N7pvs2U
         rvhVJSwADwZ9ON1GjQDJWoYRYFHBIPTCxOtHpuvVvgaLdmTRtFUGWCcfLhdeZp70z0AY
         c6viuNWaHgKWS8j1JOxl0d1JFu7ypCiE7CkVvfhEFUq+IDx0l6LuXaxc6IAwrr2i2nA+
         H03b6Y6PFvjHyCwSmW45H/8SvyDr7tMtGFSodQZcPkfEA2t6HBWpVJbX/ivR/fDOrk6+
         LV/ctJ3lQF0D7ZR67Rm6d7ocrkJPwVmjZN/MrrxLo+dA60XoaNWJ9uRyFPxmamehi1rx
         ZeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010026; x=1793614826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw+PwsoARdbNap3UWfqkjK7ETMLi6GNoF5pQtgsQHaU=;
        b=JmJPnLL0K5K29ctO0ikgCouwwNdADFtqFbG9lwqNv3u93adKxi13C7EnFqqsb2pYmM
         jprNxqHcitGY6WwFTp60LxdEFlm1S9jjJS7Q3V3Hc78R9s28ypW09cu7gKcvM9RbmbPO
         EQwroA4hr5CiIdC5arT7TvcyrGJYhf4f/JRVllS538YZmlA3jyNkrTRndMA6iwP2gy7L
         8oX7peyZIPxQwpUL6m8fdaM17XbNLCCP2/mVq8c9OPeVuCLFl8jU0+v4uNB+UxNvNXUs
         xgCAz9NXgQFjQzMd4qcc0otQoPl9QEIZXxMjua0L8g2oASN1QvaIr+WbR+55DaCGtkOY
         LhGw==
X-Forwarded-Encrypted: i=1; AKwUvBxxA3X+S6OXfCOvuTMdMx9sCrUfNKxMDTtq0KFfS8e7S39MOOWbtqLLV4/CDkQ8/n6NnsAU7P0vOCb0iO9B@vger.kernel.org
X-Gm-Message-State: AFq9FYKCXOrXUS2aRoi8lCLWiYlNm31eIDvD1AlUBKD2mQGo7QQ6THp6
	Hn3su+iuGBz2FPyjFkEkRH61feU7Vb9YxbDN1ftv02JVTPNZYHVqxohY
X-Gm-Gg: AYBFou21x73X24J58LKGQX/4mwssQe8T2FHj0jXu2E5wSH+MWK6tDI6boiy54yFLvEC
	rQLgj/0ngrOI6cNtfKpjLXEBR/190CG28XOLaJZn2LoF+2wnv9Ux4clh1Vt/5LN0n7r87jTSMFN
	Dy1pDRopRaQzDH6zqOuIAtZDDeZKZ0llgdJgCAeoQ3aFbABZaNz/Uo+lPH5BjXLGOHbUw7FERme
	gnGU8b+lxdvJf8NoYKcNBXUeqUaOGsNR4pdwQcNiF1gC3hlLbLA+BhYwh7hTLDlISSb3eDjgyl/
	OWL8yTN/mKbKE9H1bEySfa/Nf9Q6L5cCuN1DnatYxhKUYK9u1MgullpLRpbOh65xkHnXe7Qx7jP
	qmevRetUJI+fQX2mQWoJuoD4GPglPEQLc7OELwuqxhfLHhmlAPPxk/cq6GdPDmwpA8LbNyxgfKz
	LRAZQjDGw8XT8v+sb6Evj5EmKCMZk2gIaAAuBrtxZyCcx9kGVI+GH8lxDh9vaaU2kiBXfkTvCQ+
	mIwudhLWWZilJxG4mEg23qt7PZCRdMHtOZQ4nuRiZi+Es54s1gy4T0aiv8pTXNKcYdjsTm4NwpN
	wLsK0svr86I9rH/e40eXqBA=
X-Received: by 2002:a17:90b:314e:b0:3a2:bb45:d37b with SMTP id 98e67ed59e1d1-3adeaae8947mr5593294a91.25.1793010026082;
        Mon, 26 Oct 2026 03:20:26 -0700 (PDT)
Received: from anatasluo-Precision-5560 ([2408:820c:d29:db90:8486:5157:635e:e0f0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8477565a91.2.2026.10.26.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:20:25 -0700 (PDT)
From: Longjun Luo <luolongjuna@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org,
	puranjay@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Longjun Luo <luolongjuna@gmail.com>
Subject: [RFC PATCH 3/3] objtool/klp: Test DWARF identities and reference checksums
Date: Mon, 26 Oct 2026 18:19:16 +0800
Message-ID: <20261026101916.3823942-4-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026101916.3823942-1-luolongjuna@gmail.com>
References: <20261026101916.3823942-1-luolongjuna@gmail.com>
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

Cover same-named static state in different scopes and TUs, compiler
renumbering, ThinLTO promotion and name drift, Full LTO, and newly
added source files. Check that patched functions reference their own
original state and that new functions use new state. Verify that
read-only descriptors retain their original addresses and reject
changes to their contents.

Also cover calls, data references and function-pointer tables switching
between same-named local and external targets, and an external caller
moving between TUs.

Tested on x86-64 with tools/objtool/tests/run-tests.sh:

  GCC 16.2.1:   51 passed, 3 failed, 7 skipped.
  Clang 22.1.8: 57 passed, 3 failed, 1 skipped.

All nine new tests pass with Clang; GCC passes six and skips the three
Clang LTO tests. Both DWARF 4 and 5 were exercised. Without the
reference checksum patch, only the two new checksum tests fail.

The three tests covering behavior that this series rejects by policy
still fail: local-to-global-flip (source-level linkage change), and
sympos and sympos-vmlinux (duplicate identities from compiling the same
source into multiple objects). They are left unchanged for discussion;
if the policy is accepted, they will be updated to expect the rejection.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 .../tests/generic/fixtures/identity/common.h  | 15 +++++
 .../generic/fixtures/identity/consumer.c      | 30 +++++++++
 .../tests/generic/fixtures/identity/entries.c | 10 +++
 .../generic/fixtures/identity/full_left.c     | 16 +++++
 .../generic/fixtures/identity/full_right.c    |  6 ++
 .../generic/fixtures/identity/move_left.c     |  9 +++
 .../generic/fixtures/identity/move_right.c    |  8 +++
 .../generic/fixtures/identity/new/same.c      |  6 ++
 .../generic/fixtures/identity/new_driver.c    | 15 +++++
 .../generic/fixtures/identity/new_provider.c  |  4 ++
 .../generic/fixtures/identity/old/same.c      |  6 ++
 .../fixtures/identity/promotion_bounds_a.c    | 12 ++++
 .../fixtures/identity/promotion_bounds_b.c    | 12 ++++
 .../fixtures/identity/promotion_bounds_d.c    |  8 +++
 .../generic/fixtures/identity/provider.c      |  9 +++
 .../generic/fixtures/identity/readonly.c      | 30 +++++++++
 .../tests/generic/fixtures/identity/record.h  |  8 +++
 .../tests/generic/fixtures/identity/rx.c      |  4 ++
 .../generic/fixtures/identity/source_driver.c | 11 ++++
 .../generic/fixtures/identity/static_scope.c  | 31 +++++++++
 .../fixtures/identity/static_scope_reorder.c  | 31 +++++++++
 .../tests/generic/fixtures/identity/tx.c      |  4 ++
 .../generic/test-checksum-identity-source.sh  | 24 +++++++
 .../tests/generic/test-checksum-identity.sh   | 31 +++++++++
 .../tests/generic/test-identity-full-lto.sh   | 28 ++++++++
 .../tests/generic/test-identity-new-tu.sh     | 22 +++++++
 .../generic/test-identity-readonly-address.sh | 23 +++++++
 .../tests/generic/test-identity-source.sh     | 26 ++++++++
 .../generic/test-identity-static-scope.sh     | 35 ++++++++++
 .../test-identity-thinlto-name-drift.sh       | 65 +++++++++++++++++++
 .../test-identity-thinlto-promotion.sh        | 25 +++++++
 tools/objtool/tests/identity-lib.sh           | 65 +++++++++++++++++++
 32 files changed, 629 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/common.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/consumer.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/entries.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/old/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/readonly.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/record.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/rx.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/source_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/tx.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-full-lto.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-new-tu.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-readonly-address.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-static-scope.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
 create mode 100644 tools/objtool/tests/identity-lib.sh

diff --git a/tools/objtool/tests/generic/fixtures/identity/common.h b/tools/objtool/tests/generic/fixtures/identity/common.h
new file mode 100644
index 000000000000..d0f56751fcd9
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#ifndef KLP_TEST_IDENTITY_H
+#define KLP_TEST_IDENTITY_H
+
+#ifdef __clang__
+/* Use noinline on Clang to keep calls visible in these tests. */
+#define NOIPA __attribute__((noinline))
+#else
+#define NOIPA __attribute__((noipa))
+#endif
+#define MODINFO static const char modinfo[] \
+	__attribute__((used, section(".modinfo"))) = "name=vmlinux"
+
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/consumer.c b/tools/objtool/tests/generic/fixtures/identity/consumer.c
new file mode 100644
index 000000000000..4aad0e941bc3
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/consumer.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+#ifdef PATCHED
+static NOIPA int helper(int uid) { return uid == 0 ? 0 : -1; }
+#else
+int helper(int uid);
+#endif
+#ifdef DATA
+#ifdef PATCHED
+static volatile int limit = 1500;
+#else
+extern volatile int limit;
+#endif
+#endif
+#ifdef TABLE
+struct operations { int (*check)(int); };
+struct operations ops = { .check = helper };
+#endif
+NOIPA int caller(int uid)
+{
+#ifdef DATA
+	return uid <= limit ? 0 : -90;
+#elif defined(TABLE)
+	return ops.check(uid);
+#else
+	return helper(uid);
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/entries.c b/tools/objtool/tests/generic/fixtures/identity/entries.c
new file mode 100644
index 000000000000..53e809957c1c
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/entries.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+unsigned int tx(unsigned int n);
+unsigned int rx(unsigned int n);
+unsigned int entry_tx(unsigned int n) { return tx(n); }
+#ifdef PATCHED
+unsigned int entry_rx(unsigned int n) { return rx(n); }
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/full_left.c b/tools/objtool/tests/generic/fixtures/identity/full_left.c
new file mode 100644
index 000000000000..1a75df588712
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/full_left.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+static volatile int state;
+#ifdef PATCHED
+static NOIPA int helper(void) { return ++state; }
+#endif
+NOIPA int left_fn(void)
+{
+#ifdef PATCHED
+	return helper();
+#else
+	return ++state;
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/full_right.c b/tools/objtool/tests/generic/fixtures/identity/full_right.c
new file mode 100644
index 000000000000..17583384cf32
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/full_right.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+static volatile int state;
+static NOIPA int helper(void) { return ++state; }
+NOIPA int right_fn(void) { return helper(); }
diff --git a/tools/objtool/tests/generic/fixtures/identity/move_left.c b/tools/objtool/tests/generic/fixtures/identity/move_left.c
new file mode 100644
index 000000000000..7d3b03bc87e5
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/move_left.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+static NOIPA int helper(int n) { return n <= 1500 ? 0 : -90; }
+NOIPA int keep_left(int n) { return helper(n); }
+#ifndef PATCHED
+NOIPA int caller(int n) { return helper(n); }
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/move_right.c b/tools/objtool/tests/generic/fixtures/identity/move_right.c
new file mode 100644
index 000000000000..9a5f82a7d9ba
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/move_right.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+static NOIPA int helper(int n) { return n <= 4096 ? 0 : -90; }
+NOIPA int keep_right(int n) { return helper(n); }
+#ifdef PATCHED
+NOIPA int caller(int n) { return helper(n); }
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/new/same.c b/tools/objtool/tests/generic/fixtures/identity/new/same.c
new file mode 100644
index 000000000000..54550f20fe79
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/new/same.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "../common.h"
+static volatile int bytes;
+static NOIPA int helper(int n) { return bytes += n; }
+NOIPA int account_new(int n) { return helper(n); }
diff --git a/tools/objtool/tests/generic/fixtures/identity/new_driver.c b/tools/objtool/tests/generic/fixtures/identity/new_driver.c
new file mode 100644
index 000000000000..c06a1ac27609
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/new_driver.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+#ifdef PATCHED
+int clamp(int value);
+#endif
+NOIPA int target(int value)
+{
+#ifdef PATCHED
+	return clamp(value);
+#else
+	return value;
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/new_provider.c b/tools/objtool/tests/generic/fixtures/identity/new_provider.c
new file mode 100644
index 000000000000..69c1b3d0b6a7
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/new_provider.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+NOIPA int clamp(int value) { return value < 0 ? 0 : value; }
diff --git a/tools/objtool/tests/generic/fixtures/identity/old/same.c b/tools/objtool/tests/generic/fixtures/identity/old/same.c
new file mode 100644
index 000000000000..e03f14f16214
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/old/same.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "../common.h"
+static volatile int bytes;
+static NOIPA int helper(int n) { return bytes += n; }
+NOIPA int account_old(int n) { return helper(n); }
diff --git a/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c
new file mode 100644
index 000000000000..74eb8ac0bfc3
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+static volatile int state[4];
+
+int a_get(unsigned int index)
+{
+#ifdef PATCHED
+	if (index >= 4)
+		return 0;
+#endif
+	return state[index];
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c
new file mode 100644
index 000000000000..2b96569ce6cd
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+int a_get(unsigned int index);
+int d_get(unsigned int index);
+
+int target(unsigned int index)
+{
+	return a_get(index) + d_get(index);
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
new file mode 100644
index 000000000000..a4d6c35f80a9
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+static volatile int state[4];
+
+int d_get(unsigned int index)
+{
+	return state[index];
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/provider.c b/tools/objtool/tests/generic/fixtures/identity/provider.c
new file mode 100644
index 000000000000..412c5cb67341
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/provider.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+NOIPA int helper(int uid)
+{
+	return uid == 0 || uid == 1000 ? 0 : -1;
+}
+
+volatile int limit = 4096;
diff --git a/tools/objtool/tests/generic/fixtures/identity/readonly.c b/tools/objtool/tests/generic/fixtures/identity/readonly.c
new file mode 100644
index 000000000000..f145d3344d60
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/readonly.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+struct protocol { int kind; };
+NOIPA const struct protocol *tcp_type(int valid)
+{
+#if defined(PATCHED) && defined(CHANGE_VALUE)
+	static const struct protocol type = { 4 };
+#else
+	static const struct protocol type = { 1 };
+#endif
+#ifdef PATCHED
+	if (!valid)
+		return (void *)0;
+#endif
+	return &type;
+}
+NOIPA const struct protocol *udp_type(int valid)
+{
+	static const struct protocol type = { 1 };
+	return &type;
+}
+#ifdef PATCHED
+NOIPA const struct protocol *unix_type(int valid)
+{
+	static const struct protocol type = { 1 };
+	return &type;
+}
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/record.h b/tools/objtool/tests/generic/fixtures/identity/record.h
new file mode 100644
index 000000000000..5af00486c5f4
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/record.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+static inline unsigned int record(unsigned int n)
+{
+	static volatile unsigned int state;
+
+	return state += n;
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/rx.c b/tools/objtool/tests/generic/fixtures/identity/rx.c
new file mode 100644
index 000000000000..5d9871527b08
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/rx.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "record.h"
+unsigned int rx(unsigned int n) { return record(n); }
diff --git a/tools/objtool/tests/generic/fixtures/identity/source_driver.c b/tools/objtool/tests/generic/fixtures/identity/source_driver.c
new file mode 100644
index 000000000000..0ebcb01ced02
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/source_driver.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+#ifdef PATCHED
+int account_new(int n);
+NOIPA int account(int n) { return account_new(n); }
+#else
+int account_old(int n);
+NOIPA int account(int n) { return account_old(n); }
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/static_scope.c b/tools/objtool/tests/generic/fixtures/identity/static_scope.c
new file mode 100644
index 000000000000..a467f24f1a14
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/static_scope.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+NOIPA int tx(int n)
+{
+	static volatile int bytes;
+
+#ifdef PATCHED
+	if (n < 0)
+		return 0;
+#endif
+	return bytes += n;
+}
+
+NOIPA int rx(int n)
+{
+	static volatile int bytes;
+
+	return bytes += n;
+}
+
+#ifdef PATCHED
+NOIPA int extra(int n)
+{
+	static volatile int bytes;
+
+	return bytes += n;
+}
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c b/tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c
new file mode 100644
index 000000000000..a451e632a6cb
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+#ifdef PATCHED
+NOIPA int rx(int n)
+{
+	static volatile int bytes;
+
+	if (n < 0)
+		return 0;
+	return bytes += n;
+}
+#endif
+
+NOIPA int tx(int n)
+{
+	static volatile int bytes;
+
+	return bytes += n;
+}
+
+#ifndef PATCHED
+NOIPA int rx(int n)
+{
+	static volatile int bytes;
+
+	return bytes += n;
+}
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/tx.c b/tools/objtool/tests/generic/fixtures/identity/tx.c
new file mode 100644
index 000000000000..d536c3c63549
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/tx.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "record.h"
+unsigned int tx(unsigned int n) { return record(n); }
diff --git a/tools/objtool/tests/generic/test-checksum-identity-source.sh b/tools/objtool/tests/generic/test-checksum-identity-source.sh
new file mode 100755
index 000000000000..b320a57c6a76
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-identity-source.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Moving an external caller changes which TU-local helper it calls.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+modes=(none)
+case "$($CC --version | head -1)" in *clang*) modes+=(thin) ;; esac
+
+for mode in "${modes[@]}"; do
+	build_identity_pair "$mode" "" identity/move_left.c identity/move_right.c
+	[ "$(in_symbols orig.o | awk '$4 == "FUNC" && $8 ~ /^helper($|.llvm.)/' | wc -l)" = 2 ] ||
+		fail "fixture lacks two TU-local helpers"
+	assert_checksum_differs caller
+	assert_checksum_matches keep_left
+	assert_checksum_matches keep_right
+	run_diff
+	assert_patched caller
+	assert_not_patched keep_left
+	assert_not_patched keep_right
+done
+
+pass "moving a caller between TUs detects the changed local target"
diff --git a/tools/objtool/tests/generic/test-checksum-identity.sh b/tools/objtool/tests/generic/test-checksum-identity.sh
new file mode 100755
index 000000000000..77248e547040
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-identity.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Checksums for calls, data references and function-pointer tables must
+# distinguish same-named static and external targets.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+modes=(none)
+case "$($CC --version | head -1)" in *clang*) modes+=(thin) ;; esac
+
+for mode in "${modes[@]}"; do
+	build_identity_pair "$mode" "" identity/provider.c identity/consumer.c
+	[ "$(in_symbols patched.o | awk '$4 == "FUNC" && $8 ~ /^helper($|.llvm.)/' | wc -l)" = 2 ] ||
+		fail "fixture lacks the local and external helpers"
+	assert_checksum_differs caller
+	run_diff
+	assert_patched caller
+
+	build_identity_pair "$mode" -DTABLE identity/provider.c identity/consumer.c
+	assert_checksum_differs ops
+	run_diff 255
+	assert_diff_log 'changed data: ops'
+
+	build_identity_pair "$mode" -DDATA identity/provider.c identity/consumer.c
+	assert_checksum_differs caller
+	run_diff
+	assert_patched caller
+done
+
+pass "call, data and function-pointer targets use the full identity"
diff --git a/tools/objtool/tests/generic/test-identity-full-lto.sh b/tools/objtool/tests/generic/test-identity-full-lto.sh
new file mode 100755
index 000000000000..7d68a7de7982
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-full-lto.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Full LTO merges FILE entries; a new helper must not replace an existing TU's helper.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_identity_pair full "" identity/full_left.c identity/full_right.c
+
+[ "$(in_symbols orig.o | awk '$4 == "FUNC" && $8 ~ /^helper(\.[0-9]+)?$/' | wc -l)" = 1 ] &&
+[ "$(in_symbols patched.o | awk '$4 == "FUNC" && $8 ~ /^helper(\.[0-9]+)?$/' | wc -l)" = 2 ] ||
+	probe_skip "Full LTO did not emit two same-base helper names"
+left_helper="$(identity_relocs patched.o .rela.text.left_fn | awk '{ sub(/^\.text\./, "", $5); print $5 }')"
+right_helper="$(identity_relocs patched.o .rela.text.right_fn | awk '{ sub(/^\.text\./, "", $5); print $5 }')"
+[ -n "$left_helper" ] && [ -n "$right_helper" ] || fail "missing helper references"
+left_state="$(identity_object_for orig.o left_fn)"
+[ -n "$left_state" ] || fail "missing left state reference"
+
+run_diff
+assert_patched left_fn
+assert_not_patched right_fn
+assert_patched "$left_helper"
+assert_not_patched "$right_helper"
+assert_reloc_sym .text.left_fn "$left_helper"
+run_post_link
+assert_original_reference "$left_helper" "$left_state"
+
+pass "Full LTO helpers retain their defining TUs"
diff --git a/tools/objtool/tests/generic/test-identity-new-tu.sh b/tools/objtool/tests/generic/test-identity-new-tu.sh
new file mode 100755
index 000000000000..31b2e10de83f
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-new-tu.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A patch may extract validation into a newly added source file.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/new_driver.c
+build_one identity/new_provider.c provider.o
+mv "$workdir/patched.o" "$workdir/driver.o"
+partial_link "$workdir/patched.o" "$workdir/driver.o" "$workdir/provider.o" || fail "partial link failed"
+
+[ "$(in_symbols patched.o | awk '$4 == "FILE"' | wc -l)" -gt "$(in_symbols orig.o | awk '$4 == "FILE"' | wc -l)" ] ||
+	fail "fixture did not add a FILE entry"
+
+run_diff
+assert_patched target
+assert_patched clamp
+assert_diff_log 'changed function: target'
+assert_diff_log 'new function: clamp'
+
+pass "new translation unit does not block existing symbol correlation"
diff --git a/tools/objtool/tests/generic/test-identity-readonly-address.sh b/tools/objtool/tests/generic/test-identity-readonly-address.sh
new file mode 100755
index 000000000000..18c49856833b
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-readonly-address.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Read-only descriptors still need their original pointer identity.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/readonly.c
+old="$(identity_object_for orig.o tcp_type)"
+[ -n "$old" ] || fail "missing TCP descriptor reference"
+
+run_diff
+assert_patched tcp_type
+assert_patched unix_type
+assert_not_patched udp_type
+run_post_link
+assert_original_reference tcp_type "$old"
+
+build_pair identity/readonly.c -DCHANGE_VALUE
+run_diff 255
+assert_diff_log 'changed data:'
+
+pass "changed function retains the original read-only descriptor address"
diff --git a/tools/objtool/tests/generic/test-identity-source.sh b/tools/objtool/tests/generic/test-identity-source.sh
new file mode 100755
index 000000000000..1c551cb91afc
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-source.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# old/same.c and new/same.c share the FILE name "same.c"; static state
+# from the new file must still be treated as new.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/source_driver.c
+build_one identity/old/same.c old.o
+build_one identity/new/same.c new.o
+mv "$workdir/orig.o" "$workdir/driver-orig.o"
+mv "$workdir/patched.o" "$workdir/driver-patched.o"
+partial_link "$workdir/orig.o" "$workdir/driver-orig.o" "$workdir/old.o" || fail "original link failed"
+partial_link "$workdir/patched.o" "$workdir/driver-patched.o" "$workdir/new.o" || fail "patched link failed"
+for obj in orig.o patched.o; do
+	in_symbols "$obj" | awk '$4 == "FILE" && $8 == "same.c"' | grep -q . || fail "missing same.c FILE"
+done
+
+run_diff
+assert_patched account
+assert_patched helper
+assert_no_klp_sym bytes
+assert_section .bss.bytes
+
+pass "private state from a different TU is new even with the same basename"
diff --git a/tools/objtool/tests/generic/test-identity-static-scope.sh b/tools/objtool/tests/generic/test-identity-static-scope.sh
new file mode 100755
index 000000000000..fc0372100886
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-static-scope.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Reordering functions or adding a same-named static must retain old state.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+
+build_pair identity/static_scope.c
+tx_state="$(identity_object_for orig.o tx)"
+extra_state="$(identity_object_for patched.o extra)"
+[ -n "$tx_state" ] && [ -n "$extra_state" ] || fail "missing static reference"
+
+run_diff
+assert_patched tx
+assert_not_patched rx
+assert_patched extra
+assert_section ".bss.$extra_state"
+assert_reloc_sym .text.extra "$extra_state"
+run_post_link
+assert_original_reference tx "$tx_state"
+
+build_pair identity/static_scope_reorder.c
+rx_state="$(identity_object_for orig.o rx)"
+[ -n "$rx_state" ] || fail "missing RX static reference"
+
+run_diff
+assert_patched rx
+assert_not_patched tx
+out_symbols | awk '$4 == "OBJECT" && $7 != "UND" && $8 ~ /bytes/' | grep -q . &&
+	fail "existing static state was copied"
+run_post_link
+assert_original_reference rx "$rx_state"
+
+pass "named scopes preserve state through renumbering and additions"
diff --git a/tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh b/tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
new file mode 100755
index 000000000000..03bb6cf2c074
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A bounds check stops importing a_get(), leaving its state local.
+# With -always-rename-promoted-locals=false (used by the kernel when
+# supported), the plain promoted name moves to d.c and ELF-only matching
+# silently redirects a_get() to d.c's state. Older LLVM loses correlation
+# and copies the state instead. Both must retain a.c's state.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+clang_only "ThinLTO requires clang"
+find_thinlto_toolchain || probe_skip "no matching clang/lld pair"
+CC="$THIN_CC"
+FIXTURE_CFLAGS="$FIXTURE_CFLAGS -flto=thin -fsplit-lto-unit -fvisibility=hidden"
+
+build_one identity/promotion_bounds_a.c orig-a.o
+build_one identity/promotion_bounds_a.c patched-a.o -DPATCHED
+build_one identity/promotion_bounds_b.c b.o
+build_one identity/promotion_bounds_d.c d.o
+
+# Match the kernel's ThinLTO import limit and promotion naming policy.
+link_flags=(--lto-whole-program-visibility -mllvm -import-instr-limit=5)
+rename_flags=()
+if "$THIN_LD" -r -mllvm -always-rename-promoted-locals=false \
+	"$workdir/orig-a.o" -o "$workdir/rename-probe.o" \
+	2>"$workdir/rename-probe.log"; then
+	rename_flags=(-mllvm -always-rename-promoted-locals=false)
+fi
+for side in orig patched; do
+	"$THIN_LD" -r "${link_flags[@]}" "${rename_flags[@]}" \
+		"$workdir/$side-a.o" "$workdir/b.o" "$workdir/d.o" \
+		-o "$workdir/$side.o" 2>"$workdir/$side-link.log" ||
+		fail "ThinLTO link failed: $(tail -1 "$workdir/$side-link.log")"
+done
+
+state_a="$(identity_relocs orig.o .rela.text.a_get |
+	awk '$5 ~ /^state(\.llvm\.[0-9]+)?$/ { print $5; exit }')"
+state_d="$(identity_relocs orig.o .rela.text.d_get |
+	awk '$5 ~ /^state(\.llvm\.[0-9]+)?$/ { print $5; exit }')"
+[ -n "$state_a" ] && [ -n "$state_d" ] && [ "$state_a" != "$state_d" ] ||
+	probe_skip "ThinLTO did not emit distinct promoted state references"
+[ "$(identity_object_for patched.o a_get)" = state ] ||
+	probe_skip "the bounds check did not leave a_get's state local"
+in_symbols patched.o | awk '$4 == "OBJECT" && $5 == "LOCAL" && $8 == "state"' |
+	grep -q . || probe_skip "missing local state after the bounds check"
+
+if [ "${#rename_flags[@]}" -ne 0 ]; then
+	[ "$state_a" = state ] && [[ "$state_d" = state.llvm.* ]] ||
+		probe_skip "a_get's state did not claim the original plain name"
+	in_symbols patched.o | awk '$4 == "OBJECT" && $5 == "GLOBAL" && $8 == "state"' |
+		grep -q . || probe_skip "the plain promoted name did not move to d.c"
+fi
+
+run_diff
+assert_patched a_get
+assert_patched target
+assert_not_patched d_get
+out_symbols | awk '$4 == "OBJECT" && $7 != "UND" && $8 ~ /^state(\.|$)/' |
+	grep -q . && fail "unchanged state was allocated again"
+run_post_link
+assert_original_reference a_get "$state_a"
+assert_original_reference target "$state_d"
+
+pass "ThinLTO import changes preserve both TUs' original state"
diff --git a/tools/objtool/tests/generic/test-identity-thinlto-promotion.sh b/tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
new file mode 100755
index 000000000000..62f9cc70568a
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A new caller makes ThinLTO import rx() and promote rx.c's copy of
+# record()'s static state; the patch must keep using the original state.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_identity_pair thin "" identity/tx.c identity/rx.c identity/entries.c
+
+in_symbols orig.o | awk '$4 == "OBJECT" && $5 == "LOCAL" && $8 == "record.state"' |
+	grep -q . || probe_skip "RX state was not local before importing"
+[ "$(in_symbols patched.o | awk '$4 == "OBJECT" && $5 == "GLOBAL" && $8 ~ /^record.state.llvm./' | wc -l)" = 2 ] ||
+	probe_skip "ThinLTO did not promote both state instances"
+rx_state="$(identity_object_for orig.o rx)"
+[ -n "$rx_state" ] || fail "missing RX static reference"
+
+run_diff
+assert_patched entry_rx
+out_symbols | awk '$4 == "OBJECT" && $7 != "UND" && $8 ~ /record.state/' | grep -q . &&
+	fail "promoted state was allocated again"
+run_post_link
+assert_original_reference entry_rx "$rx_state"
+
+pass "header state retains its defining TU across promotion"
diff --git a/tools/objtool/tests/identity-lib.sh b/tools/objtool/tests/identity-lib.sh
new file mode 100644
index 000000000000..69d9619ae7d8
--- /dev/null
+++ b/tools/objtool/tests/identity-lib.sh
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Shared build helpers for the multi-TU identity fixtures.
+. "$(dirname "$0")/../lib.sh"
+
+FIXTURE_CFLAGS="$FIXTURE_CFLAGS -fno-pie -fno-pic"
+
+# build_identity_pair <none|thin|full> <extra-cflags> <fixture.c...>
+build_identity_pair()
+{
+	local mode="$1" cflags="$2" side file i
+	local CC="$CC"
+	local flags=() parts=() patched=()
+	shift 2
+	if [ "$mode" != none ]; then
+		clang_only "LTO fixtures require clang"
+		find_thinlto_toolchain || probe_skip "no matching clang/lld pair"
+		flags=("-flto=$mode")
+		CC="$THIN_CC"
+	fi
+	orig_obj=orig.o
+	patched_obj=patched.o
+	for side in orig patched; do
+		patched=()
+		[ "$side" = patched ] && patched=(-DPATCHED)
+		parts=()
+		i=0
+		for file in "$@"; do
+			build_one "$file" "$side-$i.o" "${flags[@]}" "${patched[@]}" $cflags
+			parts+=("$workdir/$side-$i.o")
+			i=$((i + 1))
+		done
+		if [ "$mode" = none ]; then
+			partial_link "$workdir/$side.o" "${parts[@]}" || fail "partial link failed"
+		else
+			"$THIN_LD" -r "${parts[@]}" -o "$workdir/$side.o" || fail "LTO link failed"
+		fi
+	done
+}
+
+# identity_relocs <object> <relocation-section>
+identity_relocs()
+{
+	# readelf prints the section name in single quotes.
+	in_relocs "$1" | awk -v sec="'$2'" '
+		/Relocation section/ { active = $3 == sec }
+		active && $1 ~ /^[[:xdigit:]]+$/ { print }'
+}
+
+# The fixture's function references one static in .bss or .rodata.
+identity_object_for()
+{
+	identity_relocs "$1" ".rela.text.$2" | awk '
+		$5 ~ /^\.(bss|rodata)\./ {
+			sub(/^\.(bss|rodata)\./, "", $5); print $5; exit
+		}'
+}
+
+# After post-link, check the reference to the original symbol, not just its presence.
+assert_original_reference()
+{
+	identity_relocs out.o ".klp.rela.orig..text.$1" |
+		awk -v n=".klp.sym.orig.$2," 'index($5, n) == 1' | grep -q . ||
+		fail "expected '$1' to reference original '$2'"
+}
-- 
2.53.0

