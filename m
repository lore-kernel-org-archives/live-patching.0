Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799164;
	b=ML7Oa8p6Ig5nrHPBrdgnzBh5g6rQGm9yEXqS2KsxHDbMjJSTFY5KBrhbnZF+JWEHOi25
	 LsN4m8VeY/BfsH6kKSePH0q09qrTm877BVKmJ9/AwT1oGpjUC/E77uYElsKA/Peg/qiDX
	 mFRY3quUoC9Jc5rOcj/Eh78nFmOCux1JZcHi1yWcf9MbZ5Cd123RyNFjN8yvrl1/4L9Yw
	 8Jn81DJTQ5IDfFPDV0/P5K2N/34JX7HXLk8KLjNVzvPz9xTK42plkI/E72jWUe30mSAt6
	 XYlQZDXRL+6cotc/+fuUiXpfLcCdod+pEILZ9CQDj4WSyqD671JVKRp6PE/vWfR/myw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hsId2+DpgTtxye1Yv6HPoaQDim7S8FopzLEymWWnRm0=;
	b=TvC3sZykpU7uIWUsLoHS1rIAE7IU/i7jpxjnjj7dEORnrJURW2isH5QEluJDQDM2dS4j
	 XBDzSj20Dw50eNBRWsd5nA9wi6whruoKRoQzcxlLwG0IpJZCfHQdbIYwuJSrKKOQwV8hD
	 KhTVCjDlLmZpDfCQSmZ2tWOV4lIRvyw5MuzWoPVeKqxNK0C+F9KsW/33TVqPc3sVXBbbN
	 ac9I1dQk+MgzZhDUPvWKwIYC0uaQ7p4ZutmwMwRMdffHELAfPGywG47vLsWPNImOQG+HU
	 NGLh/VdP7Cxfz+T2AxEH2kTY8SWQHHikmIQo8Yy9kdp05Bie5Kr974KR4MtyM7tkQzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwmzwBFO;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04E606A328
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C04E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwmzwBFO
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso571196b3a.1
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799149; x=1794403949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsId2+DpgTtxye1Yv6HPoaQDim7S8FopzLEymWWnRm0=;
        b=IwmzwBFOYv3W0BkI3zvF+i4IG6xcqz20VGMeRB5FrYpv+GPB1cLaaXHz7tyTvV0YFG
         uVetQwv2dyTV3G78NoOcLMsKjzAwN+yMcCkiX7Tj8F67nwsuP5yTCM2zlXhsMO02Hg4M
         Il+RF7HAKVt5V69NjauHb2Ur0BIQD7C4sceOUBs+6xOuSArAmjwiR8t8ur2oXsA6TZQt
         RHl0HOOFTnqSVDdffkhqIrfliZ9BbzvZ27w2nag7/vjqv4vUyYY7FrtJpWl4XzJXyEnd
         kG3OQf1GKtjcoBUAV8oSFwenIaROH3FIqIZ9A3nculPtTnqR1mfBBaxgoi3Y85tFf8l2
         FyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799149; x=1794403949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsId2+DpgTtxye1Yv6HPoaQDim7S8FopzLEymWWnRm0=;
        b=V7/lp1i0ilZKOkj9cULDzF1rcV5IDAK7qYCxe2vaH58hOF6hdjYSP4IHn8ooVh4C+b
         BQOufF5RU1cPqJWz/mcMDCzbEPg7F5IMZXKxGnyPDvMv5ZO9tL4I5s79lSmCeLvBzjnU
         BW/BIca2oMlK9pSMblIFakmxLHQOQcGheWxLhe5dJ0aCa9vJAKgBwDhIL79NC3nHYLqh
         fCoP+jC1Lgzg829XrYReoW1h2PskbSPdtjQEi11I4tkYXhHKne8wxCEUX3geJSwp5cr4
         45MLzlpXgQ++VMuOIj0qH5CnZyh/yUq8J3W96rod3ucIP8V0wFvZEtIiRUGoPt3DuGuB
         QvVw==
X-Forwarded-Encrypted: i=1; AKwUvBzYYL/cukmibhJkl4PAbdtLlSRXqma1EQY3fTn4dhp4FrQHNWhSGtEtRSrEQSxx/3/H2oF+KImuZD2wItk5@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q03y9Eq+r6RLPjayVyIz33BIcwR50XFy0s5I/nTgOHpAdR1m2
	dvpeR6cwsvpapqOvuiX+NvgVbDO0QK0tLm/3ihGeAP04Y/X8VCz8wQ+9
X-Gm-Gg: AYBFou2Qhq4rimB02+yXk8HdlCl7aVNaKapnXa6EUMHowKXvehe3ric39q/W+YZX+M8
	Z1qWvUP49J7XeUqV0ykqC65KwdD4eTemgko06NFAkgg1hofU9EvIg72nH666DgBsqfUeWKH1LOF
	lTYn/Zs2jfOcNuBxijtpa71UQsqthm+gKsQY1Zg3wb6llBUaVC/pgvKcPpvYHuFQ1fAwZK93C0K
	CKYUzuN5FHr38Fs3S5IcDBjk+FUsNQMq4Rzg8FdKvWKyyda2/ri4uxXSvAyEMa8Q7cLVSwdEDIh
	Jg6Xp41Uv0jfELwD40h7SdhUm/6brZu1O2L/Cd1FAaLDkTho9sPu80By1qjVGj1VW62GiN/CH5V
	qkyrGIlhTh+ZRkOrv1tDzXgSqYsytASZFiPdvvHQ2BSpb3rR+TQhNZbI8FhLK/c4xm8aHj24bxz
	iE3fHjepJPPsuvA8+dZXKEoY8kBrg8BZRi2dbE+MsNC12q9uDpSgAj7cU8SGqRPHnuJQroQBhxY
	+bT8ESX3LjggT2hx1rFrNtskBjtYBDMdMk1/IUM5dl4H+lQ+AyVvSwk30wzBMD6nKy+fVa997RF
	zh5YU61Amw/PPfzvulvhev1UDJvkInppfzLkW+J4tfBRLRK6jA==
X-Received: by 2002:a05:6a00:4694:b0:897:ffff:c18a with SMTP id d2e1a72fcca58-8b17e72e134mr369429b3a.7.1793799149518;
        Wed, 04 Nov 2026 05:32:29 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:29 -0800 (PST)
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
Subject: [RFC PATCH v2 03/11] objtool/klp: Preserve identifier digits when stripping suffixes
Date: Wed,  4 Nov 2026 21:31:49 +0800
Message-ID: <20261104133158.3187525-4-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
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

The name tx.crc32 loses its trailing digits, while tx.crc32.llvm.<hash>
keeps them because of an early return. ThinLTO promotion can therefore
break correlation and copy existing static state into the patch.

Strip LLVM hashes and complete .<number> suffixes on the same path.
Keep the counter-stripping rule for __UNIQUE_ID names, including
Clang's function-prefixed names.

Add a ThinLTO test which checks that the existing crc32 state is reused.
The available objtool tests pass with GCC 16.2.1 and Clang 22.1.8.

Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
Fixes: 020b71dcafee ("objtool/klp: Remove .llvm suffix in demangle_name()")
Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/elf.c                           | 33 +++++++++++--------
 .../fixtures/identity/promotion_crc32.c       |  8 +++++
 .../fixtures/identity/promotion_crc32_user.c  | 15 +++++++++
 .../generic/test-identity-thinlto-crc32.sh    | 23 +++++++++++++
 4 files changed, 66 insertions(+), 13 deletions(-)
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_crc32.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_crc32_user.c
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-crc32.sh

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 71f1a272e468..3ddbf5143260 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -448,32 +448,39 @@ static int read_sections(struct elf *elf)
  */
 static ssize_t demangled_name_len(const char *name)
 {
-	ssize_t idx;
+	ssize_t idx, len;
 	const char *p;
 
 	p = strstr(name, ".llvm.");
-	if (p)
-		return p - name;
+	len = p ? p - name : strlen(name);
 
-	if (!strstarts(name, "__UNIQUE_ID_") && !strchr(name, '.'))
-		return strlen(name);
+	if (strstarts(name, "__UNIQUE_ID_") || strstr(name, ".__UNIQUE_ID_")) {
+		for (idx = len - 1; idx >= 0; idx--) {
+			char c = name[idx];
 
-	for (idx = strlen(name) - 1; idx >= 0; idx--) {
-		char c = name[idx];
+			if (!isdigit(c) && c != '.' && c != '_')
+				break;
+		}
+		return idx + 1;
+	}
+
+	while (len && isdigit(name[len - 1])) {
+		p = name + len - 1;
+		while (p > name && isdigit(*p))
+			p--;
 
-		if (!isdigit(c) && c != '.' && c != '_')
+		if (p == name || *p != '.')
 			break;
+		len = p - name;
 	}
-	if (idx <= 0)
-		return strlen(name);
-	return idx + 1;
+	return len;
 }
 
 /*
  * Remove number suffix of a symbol.
  *
- * Specifically, remove trailing numbers for "__UNIQUE_ID_" symbols and
- * symbols with '.'.
+ * Remove complete .<number> suffixes and trailing numbers from
+ * "__UNIQUE_ID_" symbols.
  *
  * With CONFIG_LTO_CLANG_THIN, it is possible to have nested __UNIQUE_ID_,
  * such as
diff --git a/tools/objtool/tests/generic/fixtures/identity/promotion_crc32.c b/tools/objtool/tests/generic/fixtures/identity/promotion_crc32.c
new file mode 100644
index 000000000000..d95914eacdc0
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/promotion_crc32.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+unsigned int tx(unsigned int value)
+{
+	static volatile unsigned int crc32;
+
+	return crc32 += value;
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/promotion_crc32_user.c b/tools/objtool/tests/generic/fixtures/identity/promotion_crc32_user.c
new file mode 100644
index 000000000000..b44fa1d4a75e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/promotion_crc32_user.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+unsigned int tx(unsigned int value);
+
+unsigned int target(unsigned int value)
+{
+#ifdef PATCHED
+	return tx(value);
+#else
+	return value;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-identity-thinlto-crc32.sh b/tools/objtool/tests/generic/test-identity-thinlto-crc32.sh
new file mode 100755
index 000000000000..66988d0b7692
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-thinlto-crc32.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# ThinLTO promotion must retain the digits in a static variable's name.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_identity_pair thin "" identity/promotion_crc32.c identity/promotion_crc32_user.c
+in_symbols orig.o | awk '$4 == "OBJECT" && $5 == "LOCAL" && $8 == "tx.crc32"' |
+	grep -q . || probe_skip "CRC state was not local before importing"
+in_symbols patched.o | awk '$4 == "OBJECT" && $5 == "GLOBAL" && $8 ~ /^tx\.crc32\.llvm\.[0-9]+$/' |
+	grep -q . || probe_skip "ThinLTO did not promote the CRC state"
+
+assert_checksum_matches tx
+run_diff
+assert_patched target
+assert_not_patched tx
+out_symbols | awk '$4 == "OBJECT" && $7 != "UND" && $8 ~ /^tx\.crc32(\.|$)/' |
+	grep -q . && fail "promoted CRC state was allocated again"
+run_post_link
+assert_original_reference target tx.crc32
+
+pass "digits in static names survive ThinLTO promotion"
-- 
2.55.0

