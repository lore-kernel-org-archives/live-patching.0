Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799203;
	b=ORBNOdj7wBnFf8YMcaqjTb8fcbfrWxWfSoh9iVPeIYfAosit+J9h07clrtowUJeGE37I
	 dQ8TYlGnWF8reHS87S7zv0W+EInpWU6Veb+HEYPkTrg9jbFzYv53a7teIN0UManuRVlcH
	 eH4WrWOJdToEdTzbFFzGRXajY6IHI+fhmA4SQgyesW6TXgIentuxgvJVcUUJSLM3Syd+V
	 lrER0tuFbhpyoZmUlkhG2HIPNqWBO5vpYNDoHxZswS3yU8UQThkACjmOHwvDMsXdF/HuS
	 0NRwZ07iLqJUIrDao2ws5S6M4ARwBDOy0tV/fJGAJS6M9bqvHtebiwF1BhbE+MpexQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=57Lp9HZVeRfm+3eZpOl4jwSaGD36q5wOU5MMbOEi6gA=;
	b=aVs5j/KRyD37WBrmkTspvgB/+Wm6hqYNmgWKPsaa0UAs9WTP4atTrkQoo6ykgcvDDKob
	 sEyiodhd+JRQOOpSLv0PfBYVqqOM8QXG3fMhMkSbtSRdtNmxbMSNv12kKLmkvUfvnDfjh
	 ajV75YNk7UOKWeXFd3G+xkfqm0lNmPfVPo3Lxp134DoAugoxfGo4ojXakH9rdZIjSSZBs
	 8s+PWUG5BTm4KySBNrF+owEOiv7sK5jXqlI5kWnzD/w5S6YCGWnfA7KHwk0EhArtGKSgT
	 ivMa8rSqGr0oTeE+Ykt7va+bAGksXwI3SYIBYtxTe3tYQ7ZaGIf6+OjuCgz2/kMFBRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPe4YapA;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23996606A32E
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23996606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPe4YapA
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-886e61fa30fso348548b3a.1
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799200; x=1794404000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57Lp9HZVeRfm+3eZpOl4jwSaGD36q5wOU5MMbOEi6gA=;
        b=XPe4YapAzxNC0Si6XYO6bkhl0hkVb8kEZJ5yA+GLB8J5ksz5ApVQhpDuT92d+NDsic
         PvdqDfRgbLOCxT4kSKNqLsHTPYEOMu2A0bBxQfdo6p677x1ty3BYzE21tBZ5ClgYJy94
         OKfUSps9vBnY1d7s1ZQ6on0VvlJ1Uj+HL5gKSXPAdHb3QmXv/uwnmceSCeknoPuOUkoT
         HgpL+FSaGYH6kRNn2xtJlETtEqQY6nTL+ooI9t6DEjzGmKXDgFH3VO0pVC4D4t4IwNk6
         TzyohhGxNs8mLXFsqhpm/BW+uztiGNFc4ajeoBvZgREviCZ+JzXGMQE3xJ31brcSwsCH
         CdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799200; x=1794404000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=57Lp9HZVeRfm+3eZpOl4jwSaGD36q5wOU5MMbOEi6gA=;
        b=jN7DgEBQ+CUucbmz6mTNSZuIRoNQMqE5SoYRo++Ox3ibxWvG7sZoAgMQHMyeMGrzvQ
         AnojrlIM87C3KdQjZ1vJdPUBNuuZBep9PeB+WpmP7iV4xldiLbQyp6NItYvwcZpfvRo5
         Vp9wK0TDTjSiox3D4mr4L2g//sT5GqLPD4Y7YMiNjXIuSeczLT1lg2vHirPePahVfZrX
         u+qJ1XlBRN8apSvVRQj2M+5w9Ihynf4YCxoMoXk7vffrnc6Ku7yZmcVz6Np0KsE0QIcG
         2628Pc9XnyILCHbq9XffbQ3DX2G40CDWZnjztT9XW4/AjKXO8Z4MNHSi9d2HQpVS/w3v
         5TqA==
X-Forwarded-Encrypted: i=1; AKwUvBzBcGYK0fiiLBidTVhZ4Tii9muISz4RKPXmqYY1MLvPSLtPibX9fVkZWzGSdjzK5XKSM8+sUzUbyY/8n/Xm@vger.kernel.org
X-Gm-Message-State: APuU4Z+k3PQX8ApHqGp9gRKMpbJEJP9c3I9HH6r9ocS2sTIQIxXw9K2t
	VzMIcbvc4iSa7SV2uEx39lW/QaKqPib94d/lomf54dyH4xPrR5y9U6/o
X-Gm-Gg: AYBFou1pP5W11qe1gJAtpcFzOcQAZKXKTakn/okhrNMNOmsbO78YnBMTkQaZIGIBWrF
	cEUIsxyMdisXtohfmCLM6wvml/sdc0zYtcwg5TorKlpdXVzT2KPbphjlmA83f+GS3e0C54F1svN
	inaRZnSpTrpzveBWOIxf3X0Lzztn3TDF4LMMQv+G8Ma6vKbskXEeL3yoBHFd1zYkzRoZhJCErjX
	ImE4BE8udek3ooPVNKqFTOeYM7OGwdmdH1gOglKTehRXf8B+iLIenwsY2fBQRfN464AH37Z1VDR
	uSl7g/c/sY5qX229b1UsH6kUFl159dvvXLwTgdVQYIQ+NMHOArKgO4vbWW/1oyMyRwpsqmKLCw9
	ZmCrPXMr/yO2+cATvTXAGSBVSfsdBlszqpcmSkjehfZm3RM7mpsPhGQZByNT6pVSWQCABXn1xcI
	bYd4JShoefpfA6soAwrmCVSBAqr/Cpa0Bqqbdu/hQ5ytoXhfylpRr98k0sRVwFkQsHZXiLPALrL
	soRMqSKJ96AsJXZJDYx8A3FkWMC2MbjKGb3m/R5u0+HLd9M1ScCY90yQYZZOiibYOqNny5cCHTv
	4f2HGnUTZFf9fTMrpy/KEtXs4NqNDijRTmg2mGJWrsgKq4mgnQ==
X-Received: by 2002:a05:6a00:893:b0:8a0:3172:bd86 with SMTP id d2e1a72fcca58-8a9be585f20mr12439526b3a.14.1793799200039;
        Wed, 04 Nov 2026 05:33:20 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:33:19 -0800 (PST)
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
Subject: [RFC PATCH v2 11/11] objtool/klp: Test symbol identity and state preservation
Date: Wed,  4 Nov 2026 21:31:57 +0800
Message-ID: <20261104133158.3187525-12-luolongjuna@gmail.com>
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

Exercise local state across source changes, inlining, compiler renaming
and LTO. Check that patches reference the original objects and allocate
only new state. Cover aliases, assembly, metadata, ICF, DWARF pieces,
shrunk storage, reduced information and saved DWP files. Cover separate
cold-fragment identities left by weak overrides.

Check rejection of ambiguous repeated statics, conflicting references
and changed data. Complete compound-reference tests and add same-named
target switches for the identity-based reference checksum.

Skip the saved-DWP test when the linked libdw lacks DWP support.

The full suite has 68 passes with GCC 16.2.1 and 75 with Clang
22.1.8. Only local-to-global-flip, sympos and sympos-vmlinux fail,
reflecting the linkage and duplicate-identity policies.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 .../tests/generic/fixtures/identity/alias.c   | 25 ++++++
 .../generic/fixtures/identity/block_data.c    | 22 ++++++
 .../generic/fixtures/identity/branch_hint.c   | 28 +++++++
 .../generic/fixtures/identity/cold_strong.c   | 13 +++
 .../generic/fixtures/identity/cold_user.c     | 15 ++++
 .../generic/fixtures/identity/cold_weak.c     | 10 +++
 .../generic/fixtures/identity/consumer.c      | 30 +++++++
 .../tests/generic/fixtures/identity/entries.c | 10 +++
 .../generic/fixtures/identity/full_left.c     | 16 ++++
 .../generic/fixtures/identity/full_right.c    |  6 ++
 .../generic/fixtures/identity/icf_left/same.c | 16 ++++
 .../fixtures/identity/icf_right/same.c        | 16 ++++
 .../fixtures/identity/inline_helpers.c        | 27 +++++++
 .../tests/generic/fixtures/identity/lookup.c  | 13 +++
 .../generic/fixtures/identity/metadata.c      | 24 ++++++
 .../generic/fixtures/identity/move_left.c     |  9 +++
 .../generic/fixtures/identity/move_right.c    |  8 ++
 .../generic/fixtures/identity/new/same.c      |  6 ++
 .../generic/fixtures/identity/new_driver.c    | 15 ++++
 .../generic/fixtures/identity/new_provider.c  |  4 +
 .../generic/fixtures/identity/old/same.c      |  6 ++
 .../tests/generic/fixtures/identity/once.h    | 16 ++++
 .../generic/fixtures/identity/once_inline.c   | 28 +++++++
 .../generic/fixtures/identity/once_insert.c   | 21 +++++
 .../tests/generic/fixtures/identity/pieces.c  | 28 +++++++
 .../fixtures/identity/promotion_bounds_a.c    | 12 +++
 .../fixtures/identity/promotion_bounds_b.c    | 12 +++
 .../fixtures/identity/promotion_bounds_d.c    | 12 +++
 .../generic/fixtures/identity/provider.c      |  9 +++
 .../generic/fixtures/identity/readonly.c      | 30 +++++++
 .../tests/generic/fixtures/identity/record.h  |  8 ++
 .../tests/generic/fixtures/identity/rx.c      |  4 +
 .../tests/generic/fixtures/identity/shrink.c  | 19 +++++
 .../generic/fixtures/identity/source_driver.c | 11 +++
 .../fixtures/identity/static_replace.c        | 29 +++++++
 .../generic/fixtures/identity/static_scope.c  | 31 ++++++++
 .../fixtures/identity/static_scope_reorder.c  | 31 ++++++++
 .../tests/generic/fixtures/identity/tx.c      |  4 +
 .../generic/test-checksum-identity-source.sh  | 24 ++++++
 .../tests/generic/test-checksum-identity.sh   | 32 ++++++++
 .../tests/generic/test-identity-alias.sh      | 26 ++++++
 .../tests/generic/test-identity-block-data.sh | 12 +++
 .../generic/test-identity-branch-hint.sh      | 18 +++++
 .../tests/generic/test-identity-compound.sh   | 24 +++++-
 .../tests/generic/test-identity-dwarf.sh      | 34 ++++++++
 .../tests/generic/test-identity-full-lto.sh   | 30 +++++++
 .../tests/generic/test-identity-icf.sh        | 23 ++++++
 .../generic/test-identity-inline-helpers.sh   | 25 ++++++
 .../generic/test-identity-inline-state.sh     | 21 +++++
 .../tests/generic/test-identity-metadata.sh   | 20 +++++
 .../tests/generic/test-identity-new-tu.sh     | 24 ++++++
 .../generic/test-identity-once-insert.sh      | 19 +++++
 .../tests/generic/test-identity-pieces.sh     | 27 +++++++
 .../generic/test-identity-readonly-address.sh | 23 ++++++
 .../tests/generic/test-identity-shrink.sh     | 19 +++++
 .../tests/generic/test-identity-source.sh     | 29 +++++++
 .../tests/generic/test-identity-split.sh      | 34 ++++++++
 .../generic/test-identity-static-replace.sh   | 20 +++++
 .../generic/test-identity-static-scope.sh     | 35 ++++++++
 .../test-identity-thinlto-name-drift.sh       | 79 +++++++++++++++++++
 .../test-identity-thinlto-promotion.sh        | 26 ++++++
 .../tests/generic/test-identity-weak-cold.sh  | 35 ++++++++
 .../tests/x86/fixtures/identity_assembly.S    | 33 ++++++++
 .../tests/x86/fixtures/warn_reference.c       | 36 +++++++++
 .../tests/x86/test-identity-assembly.sh       | 19 +++++
 .../objtool/tests/x86/test-warn-reference.sh  | 21 +++++
 66 files changed, 1390 insertions(+), 2 deletions(-)
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/alias.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/block_data.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/branch_hint.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/cold_strong.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/cold_user.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/cold_weak.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/consumer.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/entries.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/icf_left/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/icf_right/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/inline_helpers.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/lookup.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/metadata.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/old/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/once.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/once_inline.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/once_insert.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/pieces.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/readonly.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/record.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/rx.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/shrink.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/source_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_replace.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/tx.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-alias.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-block-data.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-branch-hint.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-dwarf.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-full-lto.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-icf.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-inline-helpers.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-inline-state.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-metadata.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-new-tu.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-once-insert.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-pieces.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-readonly-address.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-shrink.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-split.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-static-replace.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-static-scope.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-weak-cold.sh
 create mode 100644 tools/objtool/tests/x86/fixtures/identity_assembly.S
 create mode 100644 tools/objtool/tests/x86/fixtures/warn_reference.c
 create mode 100755 tools/objtool/tests/x86/test-identity-assembly.sh
 create mode 100755 tools/objtool/tests/x86/test-warn-reference.sh

diff --git a/tools/objtool/tests/generic/fixtures/identity/alias.c b/tools/objtool/tests/generic/fixtures/identity/alias.c
new file mode 100644
index 000000000000..ab1f67d29d01
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/alias.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+#if defined(PATCHED) && defined(CHANGE_DATA)
+long state[2] = { 12, 22 };
+#else
+long state[2] = { 11, 22 };
+#endif
+extern long state_alias[2] __attribute__((alias("state")));
+
+NOIPA long *target(unsigned int index)
+{
+#ifdef PATCHED
+	if (index >= 2)
+		return (void *)0;
+#endif
+	return &state_alias[index];
+}
+
+NOIPA long *unchanged(void)
+{
+	return state;
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/block_data.c b/tools/objtool/tests/generic/fixtures/identity/block_data.c
new file mode 100644
index 000000000000..bb64ba670d3e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/block_data.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+NOIPA int target(int which)
+{
+	if (which) {
+		static volatile int budget = 5;
+
+		return --budget;
+	}
+	{
+#ifdef PATCHED
+		static volatile int budget = 10;
+#else
+		static volatile int budget = 5;
+#endif
+
+		return --budget;
+	}
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/branch_hint.c b/tools/objtool/tests/generic/fixtures/identity/branch_hint.c
new file mode 100644
index 000000000000..a605426047cb
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/branch_hint.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+extern void consume(int value);
+
+#ifdef PATCHED
+#define FIRST_LIKELY 1
+#define SECOND_LIKELY 0
+#else
+#define FIRST_LIKELY 0
+#define SECOND_LIKELY 1
+#endif
+
+NOIPA void target(int first, int second)
+{
+	if (__builtin_expect(first, FIRST_LIKELY)) {
+		static volatile int count;
+
+		consume(count++);
+	}
+	consume(0);
+	if (__builtin_expect(second, SECOND_LIKELY)) {
+		static volatile int count;
+
+		consume(count++);
+	}
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/cold_strong.c b/tools/objtool/tests/generic/fixtures/identity/cold_strong.c
new file mode 100644
index 000000000000..d2049c417499
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/cold_strong.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+extern void strong_slow_path(int value) __attribute__((cold));
+
+__attribute__((noinline)) int foo(int value)
+{
+#if defined(PATCHED) && defined(CHANGE_STRONG)
+	value++;
+#endif
+	if (__builtin_expect(value < 0, 0))
+		strong_slow_path(value);
+	return value + 2;
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/cold_user.c b/tools/objtool/tests/generic/fixtures/identity/cold_user.c
new file mode 100644
index 000000000000..c88d9aff1a97
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/cold_user.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+int foo(int value);
+
+int user(int value)
+{
+#ifdef PATCHED
+	return foo(value) + 1;
+#else
+	return foo(value);
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/cold_weak.c b/tools/objtool/tests/generic/fixtures/identity/cold_weak.c
new file mode 100644
index 000000000000..15981d530be5
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/cold_weak.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+extern void weak_slow_path(int value) __attribute__((cold));
+
+__attribute__((weak, noinline)) int foo(int value)
+{
+	if (__builtin_expect(value < 0, 0))
+		weak_slow_path(value);
+	return value + 1;
+}
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
diff --git a/tools/objtool/tests/generic/fixtures/identity/icf_left/same.c b/tools/objtool/tests/generic/fixtures/identity/icf_left/same.c
new file mode 100644
index 000000000000..25312a0ee0c0
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/icf_left/same.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+extern long process(long value);
+
+static long base(long value)
+{
+	return process(value) + process(value + 7);
+}
+
+static long helper(long value)
+{
+	return process(value) + process(value + 7);
+}
+
+long (*left_base)(long) = base;
+long (*left_helper)(long) = helper;
diff --git a/tools/objtool/tests/generic/fixtures/identity/icf_right/same.c b/tools/objtool/tests/generic/fixtures/identity/icf_right/same.c
new file mode 100644
index 000000000000..e4357fe8b475
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/icf_right/same.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+extern long process(long value);
+
+static long base(long value)
+{
+	return process(value) + process(value + 9);
+}
+
+static long helper(long value)
+{
+	return process(value) + process(value + 9);
+}
+
+long (*right_base)(long) = base;
+long (*right_helper)(long) = helper;
diff --git a/tools/objtool/tests/generic/fixtures/identity/inline_helpers.c b/tools/objtool/tests/generic/fixtures/identity/inline_helpers.c
new file mode 100644
index 000000000000..41ee7326f8a1
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/inline_helpers.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+#include "once.h"
+MODINFO;
+
+static volatile long rx_seed, tx_seed;
+
+static inline __attribute__((always_inline)) long initialize_rx(long value)
+{
+	ONCE_INIT(rx_seed, 1);
+	return value ^ rx_seed;
+}
+
+static inline __attribute__((always_inline)) long initialize_tx(long value)
+{
+	ONCE_INIT(tx_seed, 2);
+	return value ^ tx_seed;
+}
+
+NOIPA long target(long value)
+{
+#ifdef PATCHED
+	value = initialize_tx(value);
+#endif
+	return initialize_rx(value);
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/lookup.c b/tools/objtool/tests/generic/fixtures/identity/lookup.c
new file mode 100644
index 000000000000..b72d8d01815d
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/lookup.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+NOIPA long target(long value)
+{
+#ifdef PATCHED
+	return value + 2;
+#else
+	return value + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/metadata.c b/tools/objtool/tests/generic/fixtures/identity/metadata.c
new file mode 100644
index 000000000000..53f6785b2593
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/metadata.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+extern void *get_symbol(const char *name);
+
+#define SYMBOL_GET(name) ({ \
+	static const char __notrim[] __attribute__((used, section(".no_trim_symbol"))) = #name; \
+	get_symbol(#name); \
+})
+#define TRACEPOINT_CHECK(name) \
+	static const char __trace_check_##name[] \
+		__attribute__((used, section("__tracepoint_check"))) = #name
+
+NOIPA void *target(void)
+{
+	TRACEPOINT_CHECK(start);
+	SYMBOL_GET(first);
+#ifdef PATCHED
+	TRACEPOINT_CHECK(finish);
+	SYMBOL_GET(extra);
+#endif
+	return SYMBOL_GET(second);
+}
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
diff --git a/tools/objtool/tests/generic/fixtures/identity/once.h b/tools/objtool/tests/generic/fixtures/identity/once.h
new file mode 100644
index 000000000000..c31b2911ce3e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/once.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#ifndef KLP_TEST_ONCE_H
+#define KLP_TEST_ONCE_H
+
+extern long generate(long seed);
+
+#define ONCE_INIT(state, seed) do { \
+	static volatile int done; \
+	if (!done) { \
+		done = 1; \
+		(state) = generate(seed); \
+	} \
+} while (0)
+
+#endif
diff --git a/tools/objtool/tests/generic/fixtures/identity/once_inline.c b/tools/objtool/tests/generic/fixtures/identity/once_inline.c
new file mode 100644
index 000000000000..607f81ca4dd1
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/once_inline.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+#include "once.h"
+MODINFO;
+
+static volatile long first, second;
+
+static inline __attribute__((always_inline)) long initialize(long value)
+{
+	ONCE_INIT(first, 1);
+	ONCE_INIT(second, 2);
+	return value ^ first ^ second;
+}
+
+NOIPA long unchanged(long value)
+{
+	return initialize(value);
+}
+
+NOIPA long target(long value)
+{
+#ifdef PATCHED
+	return initialize(value + 1);
+#else
+	return initialize(value);
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/once_insert.c b/tools/objtool/tests/generic/fixtures/identity/once_insert.c
new file mode 100644
index 000000000000..62f4215210ae
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/once_insert.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+#include "once.h"
+MODINFO;
+
+static volatile long first, second, extra;
+
+NOIPA long target(long value)
+{
+	ONCE_INIT(first, 1);
+#ifdef PATCHED
+	ONCE_INIT(extra, 3);
+#endif
+	ONCE_INIT(second, 2);
+#ifdef PATCHED
+	return value ^ first ^ second ^ extra;
+#else
+	return value ^ first ^ second;
+#endif
+}
diff --git a/tools/objtool/tests/generic/fixtures/identity/pieces.c b/tools/objtool/tests/generic/fixtures/identity/pieces.c
new file mode 100644
index 000000000000..4cd3ffbacbae
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/pieces.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+static struct { long first, second; } state;
+
+NOIPA void set(long first, long second)
+{
+	state.first = first;
+	state.second = second;
+}
+
+NOIPA long sum(void)
+{
+	return state.first + state.second;
+}
+
+NOIPA long target(void)
+{
+#if defined(PATCHED) && defined(SWITCH_FIELD)
+	return state.second;
+#elif defined(PATCHED)
+	return state.first + 1;
+#else
+	return state.first;
+#endif
+}
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
index 000000000000..2e2a2691df38
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+static volatile int state[4];
+
+int d_get(unsigned int index)
+{
+#ifdef PATCHED
+	return state[index & 3];
+#else
+	return state[index];
+#endif
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
diff --git a/tools/objtool/tests/generic/fixtures/identity/shrink.c b/tools/objtool/tests/generic/fixtures/identity/shrink.c
new file mode 100644
index 000000000000..1a43964f719b
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/shrink.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+extern void initialize(void);
+extern void finish(void);
+
+NOIPA void target(void)
+{
+	static int done;
+
+	if (!done) {
+		done = 1;
+		initialize();
+#ifdef PATCHED
+		finish();
+#endif
+	}
+}
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
diff --git a/tools/objtool/tests/generic/fixtures/identity/static_replace.c b/tools/objtool/tests/generic/fixtures/identity/static_replace.c
new file mode 100644
index 000000000000..5745738d5cbd
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/static_replace.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+#ifndef PATCHED
+NOIPA long retired(long value)
+{
+	static volatile long count;
+
+	return count += value;
+}
+#endif
+
+NOIPA long unchanged(long value)
+{
+	static volatile long count;
+
+	return count += value;
+}
+
+#ifdef PATCHED
+NOIPA long added(long value)
+{
+	static volatile long count;
+
+	return count += value;
+}
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
index 000000000000..cc8a70bf31d2
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-identity.sh
@@ -0,0 +1,32 @@
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
+	[ "$(in_symbols patched.o |
+		awk '$4 == "FUNC" && $8 ~ /^helper($|.llvm.)/' | wc -l)" = 2 ] ||
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
diff --git a/tools/objtool/tests/generic/test-identity-alias.sh b/tools/objtool/tests/generic/test-identity-alias.sh
new file mode 100755
index 000000000000..84a3829b00e8
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-alias.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Access through an alias must retain the original shared storage.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/alias.c
+assert_input_symbol state
+assert_input_symbol state_alias
+
+run_diff
+assert_patched target
+assert_not_patched unchanged
+assert_no_symbol state
+assert_no_symbol state_alias
+run_post_link
+identity_relocs out.o .klp.rela.orig..text.target |
+	awk '$5 ~ /^\.klp\.sym\.orig\.state(_alias)?,/' | grep -q . ||
+	fail "target does not reference original state"
+
+build_pair identity/alias.c -DCHANGE_DATA
+run_diff 255
+assert_diff_log 'changed data: state'
+
+pass "data aliases reuse the original object and reject changed storage"
diff --git a/tools/objtool/tests/generic/test-identity-block-data.sh b/tools/objtool/tests/generic/test-identity-block-data.sh
new file mode 100755
index 000000000000..439b2fe7cc61
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-block-data.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Changing a block-local counter's initial value remains a data change.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/block_data.c
+run_diff 255
+assert_diff_log 'changed data:.*budget'
+
+pass "changed block-local data is rejected"
diff --git a/tools/objtool/tests/generic/test-identity-branch-hint.sh b/tools/objtool/tests/generic/test-identity-branch-hint.sh
new file mode 100755
index 000000000000..68a49aa12e96
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-branch-hint.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Branch hints can reorder symbols for two existing block-local counters.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/branch_hint.c
+for obj in orig.o patched.o; do
+	nr="$(in_symbols "$obj" | awk '
+		$4 == "OBJECT" && $8 ~ /(^|\.)count(\.[0-9]+)?$/ { n++ } END { print n+0 }')"
+	[ "$nr" = 2 ] || fail "expected two counters in $obj"
+done
+
+run_diff 255
+assert_diff_log 'unresolved data reference:.*count'
+
+pass "branch hint changes report ambiguous counters"
diff --git a/tools/objtool/tests/generic/test-identity-compound.sh b/tools/objtool/tests/generic/test-identity-compound.sh
index 76b16616b32c..fc58d2fad17a 100755
--- a/tools/objtool/tests/generic/test-identity-compound.sh
+++ b/tools/objtool/tests/generic/test-identity-compound.sh
@@ -1,13 +1,33 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
-# Array contents and callbacks contribute to the referring function's checksum.
+# A changed function keeps the address of an unchanged anonymous table.
 . "$(dirname "$0")/../identity-lib.sh"
 
 setup
+for flags in "" -DWRITABLE; do
+	build_pair identity/compound.c -DCHANGE_FUNCTION $flags
+	old="$(identity_object_for orig.o target)"
+	[ -n "$old" ] || fail "missing compound reference"
+
+	run_diff
+	assert_patched target
+	assert_not_patched unchanged
+	run_post_link
+	assert_original_reference target "$old"
+	assert_no_symbol "$old"
+done
+
+# Array contents and callbacks contribute to the referring function's checksum.
 for change in CHANGE_LEAF CHANGE_TARGET; do
 	build_pair identity/compound.c "-D$change"
 	assert_checksum_differs target
+	run_diff 255
+	assert_diff_log 'unresolved compound reference:.*has no unchanged match'
 done
 
-pass "compound contents contribute to reference checksums"
+build_pair identity/compound.c -DCHANGE_FUNCTION -DAMBIGUOUS
+run_diff 255
+assert_diff_log 'unresolved compound reference:.*matches .* and '
+
+pass "compound references retain old storage or report ambiguity"
diff --git a/tools/objtool/tests/generic/test-identity-dwarf.sh b/tools/objtool/tests/generic/test-identity-dwarf.sh
new file mode 100755
index 000000000000..2b18110f243b
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-dwarf.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Kernel DWARF 4/5 and reduced debug information describe the same static state.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+reduced=(-fno-var-tracking)
+case "$($CC --version | head -1)" in
+*clang*) ;;
+*) reduced+=(-femit-struct-debug-baseonly) ;;
+esac
+
+for version in 4 5; do
+	for mode in full reduced; do
+		flags=("-gdwarf-$version")
+		[ "$mode" = reduced ] && flags+=("${reduced[@]}")
+		build_pair identity/once_inline.c "${flags[@]}"
+		states="$(in_symbols orig.o | awk '
+			$4 == "OBJECT" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { print $8 }')"
+		[ "$(echo "$states" | wc -w)" = 2 ] || fail "expected two initialization flags"
+
+		run_diff
+		assert_patched target
+		assert_not_patched unchanged
+		run_post_link
+		for state in $states; do
+			assert_original_reference target "$state"
+			assert_no_symbol "$state"
+		done
+	done
+done
+
+pass "full and reduced DWARF preserve initialization state"
diff --git a/tools/objtool/tests/generic/test-identity-full-lto.sh b/tools/objtool/tests/generic/test-identity-full-lto.sh
new file mode 100755
index 000000000000..08aa67a444a3
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-full-lto.sh
@@ -0,0 +1,30 @@
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
+left_helper="$(identity_relocs patched.o .rela.text.left_fn |
+	awk '{ sub(/^\.text\./, "", $5); print $5 }')"
+right_helper="$(identity_relocs patched.o .rela.text.right_fn |
+	awk '{ sub(/^\.text\./, "", $5); print $5 }')"
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
diff --git a/tools/objtool/tests/generic/test-identity-icf.sh b/tools/objtool/tests/generic/test-identity-icf.sh
new file mode 100755
index 000000000000..bad6acccd0c1
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-icf.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Same-named ICF wrappers in different CUs must remain separate functions.
+. "$(dirname "$0")/../identity-lib.sh"
+
+gcc_only "GCC IPA-ICF emits wrappers without code ranges in DWARF"
+setup
+build_identity_pair none -fipa-icf \
+	identity/icf_left/same.c identity/icf_right/same.c identity/lookup.c
+for obj in orig.o patched.o; do
+	nr="$(in_symbols "$obj" | awk '$4 == "FUNC" && $8 == "helper" { n++ } END { print n+0 }')"
+	[ "$nr" = 2 ] || fail "expected two helper functions in $obj"
+done
+
+run_diff
+assert_patched target
+assert_not_patched helper
+assert_not_patched base
+assert_checksum_matches left_helper
+assert_checksum_matches right_helper
+
+pass "same FILE basenames do not confuse ICF wrapper identities"
diff --git a/tools/objtool/tests/generic/test-identity-inline-helpers.sh b/tools/objtool/tests/generic/test-identity-inline-helpers.sh
new file mode 100755
index 000000000000..21641c8dc975
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-inline-helpers.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A new inline initializer gets its own flag; the existing initializer keeps its state.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/inline_helpers.c
+old="$(in_symbols orig.o | awk '$4 == "OBJECT" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { print $8 }')"
+[ "$(echo "$old" | wc -w)" = 1 ] || fail "expected one original initialization flag"
+nr="$(in_symbols patched.o |
+	awk '$4 == "OBJECT" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { n++ } END { print n+0 }')"
+[ "$nr" = 2 ] ||
+	fail "expected two patched initialization flags"
+
+run_diff
+assert_patched target
+new="$(out_symbols |
+	awk '$4 == "OBJECT" && $7 != "UND" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { print $8 }')"
+[ "$(echo "$new" | wc -w)" = 1 ] || fail "expected only the new initializer's flag to be copied"
+assert_reloc_sym .text.target "$new"
+run_post_link
+assert_original_reference target "$old"
+
+pass "inline helpers retain separate initialization state without an unchanged caller"
diff --git a/tools/objtool/tests/generic/test-identity-inline-state.sh b/tools/objtool/tests/generic/test-identity-inline-state.sh
new file mode 100755
index 000000000000..2cff1d3c0645
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-inline-state.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Both callers of an inline initializer must keep using its original flags.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/once_inline.c
+states="$(in_symbols orig.o | awk '$4 == "OBJECT" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { print $8 }')"
+[ "$(echo "$states" | wc -w)" = 2 ] || fail "expected two initialization flags"
+
+run_diff
+assert_patched target
+assert_not_patched unchanged
+run_post_link
+for state in $states; do
+	assert_original_reference target "$state"
+	assert_no_symbol "$state"
+done
+
+pass "changed caller retains both initialization flags"
diff --git a/tools/objtool/tests/generic/test-identity-metadata.sh b/tools/objtool/tests/generic/test-identity-metadata.sh
new file mode 100755
index 000000000000..fe575d710c56
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-metadata.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# symbol_get and tracepoint checks leave build-time markers that the linker discards.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/metadata.c
+assert_input_section .no_trim_symbol
+assert_input_section __tracepoint_check
+
+run_diff
+assert_patched target
+assert_no_section .no_trim_symbol
+assert_no_section __tracepoint_check
+if diff_log | grep -qE 'no correlation:.*(__notrim|__trace_check_)'; then
+	fail "build-time markers reported as unmatched state"
+fi
+
+pass "build-time markers do not enter state correlation"
diff --git a/tools/objtool/tests/generic/test-identity-new-tu.sh b/tools/objtool/tests/generic/test-identity-new-tu.sh
new file mode 100755
index 000000000000..9675af836b46
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-new-tu.sh
@@ -0,0 +1,24 @@
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
+partial_link "$workdir/patched.o" "$workdir/driver.o" "$workdir/provider.o" ||
+	fail "partial link failed"
+
+[ "$(in_symbols patched.o | awk '$4 == "FILE"' | wc -l)" \
+	-gt "$(in_symbols orig.o | awk '$4 == "FILE"' | wc -l)" ] ||
+	fail "fixture did not add a FILE entry"
+
+run_diff
+assert_patched target
+assert_patched clamp
+assert_diff_log 'changed function: target'
+assert_diff_log 'new function: clamp'
+
+pass "new translation unit does not block existing symbol correlation"
diff --git a/tools/objtool/tests/generic/test-identity-once-insert.sh b/tools/objtool/tests/generic/test-identity-once-insert.sh
new file mode 100755
index 000000000000..f1accb98d1e5
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-once-insert.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Inserting an initializer must not reset the two existing once flags.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/once_insert.c
+for spec in "orig.o 2" "patched.o 3"; do
+	set -- $spec
+	nr="$(in_symbols "$1" | awk '
+		$4 == "OBJECT" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { n++ } END { print n+0 }')"
+	[ "$nr" = "$2" ] || fail "expected $2 initialization flags in $1"
+done
+
+run_diff 255
+assert_diff_log 'unresolved data reference:.*done'
+
+pass "ambiguous initialization flags are rejected"
diff --git a/tools/objtool/tests/generic/test-identity-pieces.sh b/tools/objtool/tests/generic/test-identity-pieces.sh
new file mode 100755
index 000000000000..c42a98ad0ef1
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-pieces.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# GlobalOpt can split a struct into equal-sized objects with the same DWARF name.
+. "$(dirname "$0")/../identity-lib.sh"
+
+clang_only "Clang GlobalOpt splits this state into separate objects"
+setup
+build_pair identity/pieces.c
+nr="$(in_symbols orig.o | awk '$4 == "OBJECT" && $8 ~ /^state\.[0-9]+$/ { n++ } END { print n+0 }')"
+[ "$nr" = 2 ] || probe_skip "compiler did not split state into two objects"
+old="$(identity_object_for orig.o target)"
+[ -n "$old" ] || fail "missing state reference"
+
+run_diff
+assert_patched target
+assert_not_patched set
+assert_not_patched sum
+run_post_link
+assert_original_reference target "$old"
+assert_no_symbol "$old"
+
+build_pair identity/pieces.c -DSWITCH_FIELD
+run_diff 255
+assert_diff_log 'target.*twin conflict:'
+
+pass "unchanged references preserve pieces and conflicting field switches are rejected"
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
diff --git a/tools/objtool/tests/generic/test-identity-shrink.sh b/tools/objtool/tests/generic/test-identity-shrink.sh
new file mode 100755
index 000000000000..d9f007fc56f3
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-shrink.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A compressed once flag keeps its state when the initialization code changes.
+. "$(dirname "$0")/../identity-lib.sh"
+
+clang_only "Clang shrinks the int flag to one byte"
+setup
+build_pair identity/shrink.c
+old="$(in_symbols orig.o | awk '$4 == "OBJECT" && $3 == 1 && $8 ~ /\.done$/ { print $8 }')"
+[ -n "$old" ] || probe_skip "compiler did not shrink the once flag"
+
+run_diff
+assert_patched target
+run_post_link
+assert_original_reference target "$old"
+assert_no_symbol "$old"
+
+pass "compressed once flag retains its original storage"
diff --git a/tools/objtool/tests/generic/test-identity-source.sh b/tools/objtool/tests/generic/test-identity-source.sh
new file mode 100755
index 000000000000..bbb2e729571f
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-source.sh
@@ -0,0 +1,29 @@
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
+partial_link "$workdir/orig.o" "$workdir/driver-orig.o" "$workdir/old.o" ||
+	fail "original link failed"
+partial_link "$workdir/patched.o" "$workdir/driver-patched.o" "$workdir/new.o" ||
+	fail "patched link failed"
+for obj in orig.o patched.o; do
+	in_symbols "$obj" | awk '$4 == "FILE" && $8 == "same.c"' | grep -q . ||
+		fail "missing same.c FILE"
+done
+
+run_diff
+assert_patched account
+assert_patched helper
+assert_no_klp_sym bytes
+assert_section .bss.bytes
+
+pass "private state from a different TU is new even with the same basename"
diff --git a/tools/objtool/tests/generic/test-identity-split.sh b/tools/objtool/tests/generic/test-identity-split.sh
new file mode 100755
index 000000000000..0af15583fe08
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-split.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# klp-build saves the original DWOs in a DWP before the patched build overwrites them.
+. "$(dirname "$0")/../identity-lib.sh"
+
+DWP="${DWP:-llvm-dwp}"
+command -v "$DWP" >/dev/null || probe_skip "split DWARF requires llvm-dwp (or set DWP)"
+setup
+# libdw 0.191 added DWP lookup and dwarf_cu_dwp_section_info().
+libdw="$(ldd "$OBJTOOL" 2>/dev/null | awk '$1 == "libdw.so.1" { print $3 }')"
+if [ -n "$libdw" ] && $READELF --dyn-syms -W "$libdw" > "$workdir/libdw.symbols"; then
+	grep -q 'dwarf_cu_dwp_section_info' "$workdir/libdw.symbols" ||
+		probe_skip "saved DWP files require libdw >= 0.191"
+fi
+# CONFIG_DEBUG_INFO_SPLIT with CONFIG_DEBUG_INFO_DWARF4.
+build_pair identity/once_inline.c -gdwarf-4 -gsplit-dwarf
+states="$(in_symbols orig.o | awk '$4 == "OBJECT" && $8 ~ /(^|\.)done(\.[0-9]+)?$/ { print $8 }')"
+[ "$(echo "$states" | wc -w)" = 2 ] || fail "expected two initialization flags"
+for side in orig patched; do
+	"$DWP" -e "$workdir/$side.o" -o "$workdir/$side.o.dwp" || fail "DWP packaging failed"
+	mv "$workdir/$side.dwo" "$workdir/$side.dwo.saved" || fail "missing $side.dwo"
+done
+
+run_diff
+assert_patched target
+assert_not_patched unchanged
+run_post_link
+for state in $states; do
+	assert_original_reference target "$state"
+	assert_no_symbol "$state"
+done
+
+pass "saved DWP files retain the original initialization state"
diff --git a/tools/objtool/tests/generic/test-identity-static-replace.sh b/tools/objtool/tests/generic/test-identity-static-replace.sh
new file mode 100755
index 000000000000..987555f925a7
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-static-replace.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A new function's counter must not share state with an unchanged function.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity/static_replace.c
+new="$(identity_object_for patched.o added)"
+[ -n "$new" ] || fail "missing new counter reference"
+
+run_diff
+assert_patched added
+assert_not_patched unchanged
+assert_not_patched retired
+assert_section ".bss.$new"
+assert_reloc_sym .text.added "$new"
+assert_no_klp_sym "$new"
+
+pass "replacement function gets its own new counter"
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
index 000000000000..75374bcbb046
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
@@ -0,0 +1,79 @@
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
+build_one identity/promotion_bounds_d.c orig-d.o
+
+# Match the kernel's ThinLTO import limit and promotion naming policy.
+link_flags=(--lto-whole-program-visibility -mllvm -import-instr-limit=5)
+rename_flags=()
+if "$THIN_LD" -r -mllvm -always-rename-promoted-locals=false \
+	"$workdir/orig-a.o" -o "$workdir/rename-probe.o" \
+	2>"$workdir/rename-probe.log"; then
+	rename_flags=(-mllvm -always-rename-promoted-locals=false)
+fi
+# Change d.c as well so neither TU keeps its original ThinLTO module hash.
+for change in one both; do
+	flags=()
+	[ "$change" = both ] && flags=(-DPATCHED)
+	build_one identity/promotion_bounds_d.c patched-d.o "${flags[@]}"
+	for side in orig patched; do
+		"$THIN_LD" -r "${link_flags[@]}" "${rename_flags[@]}" \
+			"$workdir/$side-a.o" "$workdir/b.o" "$workdir/$side-d.o" \
+			-o "$workdir/$side.o" 2>"$workdir/$side-link.log" ||
+			fail "ThinLTO link failed: $(tail -1 "$workdir/$side-link.log")"
+	done
+
+	state_a="$(identity_relocs orig.o .rela.text.a_get |
+		awk '$5 ~ /^state(\.llvm\.[0-9]+)?$/ { print $5; exit }')"
+	state_d="$(identity_relocs orig.o .rela.text.d_get |
+		awk '$5 ~ /^state(\.llvm\.[0-9]+)?$/ { print $5; exit }')"
+	[ -n "$state_a" ] && [ -n "$state_d" ] && [ "$state_a" != "$state_d" ] ||
+		probe_skip "ThinLTO did not emit distinct promoted state references"
+	[ "$(identity_object_for patched.o a_get)" = state ] ||
+		probe_skip "the bounds check did not leave a_get's state local"
+	in_symbols patched.o | awk '$4 == "OBJECT" && $5 == "LOCAL" && $8 == "state"' |
+		grep -q . || probe_skip "missing local state after the bounds check"
+
+	if [ "${#rename_flags[@]}" -ne 0 ]; then
+		[ "$state_a" = state ] && [[ "$state_d" = state.llvm.* ]] ||
+			probe_skip "a_get's state did not claim the original plain name"
+		in_symbols patched.o | awk '$4 == "OBJECT" && $5 == "GLOBAL" && $8 == "state"' |
+			grep -q . || probe_skip "the plain promoted name did not move to d.c"
+	fi
+
+	run_diff
+	assert_patched a_get
+	assert_patched target
+	if [ "$change" = both ]; then
+		assert_patched d_get
+	else
+		assert_not_patched d_get
+	fi
+	out_symbols | awk '$4 == "OBJECT" && $7 != "UND" && $8 ~ /^state(\.|$)/' |
+		grep -q . && fail "unchanged state was allocated again"
+	run_post_link
+	assert_original_reference a_get "$state_a"
+	assert_original_reference target "$state_d"
+
+	if [ "$change" = both ]; then
+		assert_original_reference d_get "$state_d"
+	fi
+done
+
+pass "ThinLTO import changes preserve both TUs' original state"
diff --git a/tools/objtool/tests/generic/test-identity-thinlto-promotion.sh b/tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
new file mode 100755
index 000000000000..f4e9418817a0
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
@@ -0,0 +1,26 @@
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
+[ "$(in_symbols patched.o |
+	awk '$4 == "OBJECT" && $5 == "GLOBAL" && $8 ~ /^record.state.llvm./' | wc -l)" = 2 ] ||
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
diff --git a/tools/objtool/tests/generic/test-identity-weak-cold.sh b/tools/objtool/tests/generic/test-identity-weak-cold.sh
new file mode 100755
index 000000000000..a21c522d5702
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-weak-cold.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Overridden weak functions can leave cold fragments with the strong function's name.
+. "$(dirname "$0")/../identity-lib.sh"
+
+gcc_only "GCC splits functions into cold fragments"
+setup
+split_flag=-freorder-blocks-and-partition
+cc_supports "$split_flag" || split_flag=
+
+for flags in "" "-DCHANGE_STRONG"; do
+	build_identity_pair none "$split_flag $flags" \
+		identity/cold_weak.c identity/cold_strong.c identity/cold_user.c
+	for obj in orig.o patched.o; do
+		nr="$(in_symbols "$obj" | awk '
+			$4 == "FUNC" && $8 ~ /^foo\.cold(\.[0-9]+)?$/ { n++ }
+			END { print n+0 }')"
+		[ "$nr" = 2 ] || probe_skip "compiler did not emit both cold fragments"
+	done
+
+	run_diff
+	assert_patched user
+	if [ -n "$flags" ]; then
+		assert_patched foo
+		out_symbols | awk '$4 == "FUNC" && $7 != "UND" && $8 ~ /^foo\.cold(\.[0-9]+)?$/' |
+			grep -q . || fail "strong cold fragment was not copied"
+		assert_symbol strong_slow_path
+		assert_no_symbol weak_slow_path
+	else
+		assert_not_patched foo
+	fi
+done
+
+pass "weak and strong cold fragments retain separate source identities"
diff --git a/tools/objtool/tests/x86/fixtures/identity_assembly.S b/tools/objtool/tests/x86/fixtures/identity_assembly.S
new file mode 100644
index 000000000000..eb2c1ca9d71f
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/identity_assembly.S
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+	.file "identity_assembly.S"
+	.section .modinfo,"a"
+	.asciz "name=vmlinux"
+
+	.section .data.asm_state,"aw"
+	.type asm_state, @object
+asm_state:
+	.quad 11
+	.size asm_state, .-asm_state
+
+	.section .text.asm_unchanged,"ax"
+	.globl asm_unchanged
+	.type asm_unchanged, @function
+asm_unchanged:
+	mov asm_state(%rip), %rax
+	ret
+	.size asm_unchanged, .-asm_unchanged
+
+	.section .text.asm_target,"ax"
+	.globl asm_target
+	.type asm_target, @function
+asm_target:
+	mov asm_state(%rip), %rax
+#ifdef PATCHED
+	add $2, %rax
+#else
+	add $1, %rax
+#endif
+	ret
+	.size asm_target, .-asm_target
+	.section .note.GNU-stack,"",@progbits
diff --git a/tools/objtool/tests/x86/fixtures/warn_reference.c b/tools/objtool/tests/x86/fixtures/warn_reference.c
new file mode 100644
index 000000000000..1d5ffda88c75
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/warn_reference.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+static const char modinfo[] __attribute__((used, section(".modinfo"))) = "name=vmlinux";
+extern void report(void *entry);
+
+/* WARN passes its own bug-table entry to the reporting code. */
+#define WARN_ENTRY() do { \
+	void *entry; \
+	asm volatile("1: nop\n\t" \
+		     ".pushsection __bug_table,\"aw\"\n\t" \
+		     "2:\n\t" \
+		     ".pushsection .discard.annotate_data,\"M\",@progbits,8\n\t" \
+		     ".long 2b - ., 1\n\t" \
+		     ".popsection\n\t" \
+		     ".long 1b - .\n\t" \
+		     ".fill 8,1,0\n\t" \
+		     ".popsection\n\t" \
+		     "leaq 2b(%%rip), %0" : "=r" (entry)); \
+	report(entry); \
+} while (0)
+
+int other(int value)
+{
+	WARN_ENTRY();
+	return value;
+}
+
+int target(int value)
+{
+	WARN_ENTRY();
+#ifdef PATCHED
+	return value + 2;
+#else
+	return value + 1;
+#endif
+}
diff --git a/tools/objtool/tests/x86/test-identity-assembly.sh b/tools/objtool/tests/x86/test-identity-assembly.sh
new file mode 100755
index 000000000000..4aee7ee7f279
--- /dev/null
+++ b/tools/objtool/tests/x86/test-identity-assembly.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Assembly functions without their own DIEs still reuse existing data.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+build_pair identity_assembly.S
+assert_input_symbol asm_state
+assert_input_symbol asm_target
+
+run_diff
+assert_patched asm_target
+assert_not_patched asm_unchanged
+assert_no_symbol asm_state
+run_post_link
+assert_original_reference asm_target asm_state
+
+pass "assembly function retains the original data reference"
diff --git a/tools/objtool/tests/x86/test-warn-reference.sh b/tools/objtool/tests/x86/test-warn-reference.sh
new file mode 100755
index 000000000000..48c8042e0cbd
--- /dev/null
+++ b/tools/objtool/tests/x86/test-warn-reference.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# A patched WARN site needs the bug-table entry it passes to the reporter.
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair warn_reference.c
+assert_input_section __bug_table
+in_relocs patched.o | grep -q 'R_X86_64_PC32.*__bug_table' ||
+	fail "missing function reference to __bug_table"
+
+run_diff
+assert_patched target
+assert_not_patched other
+assert_section __bug_table
+assert_reloc_sym __bug_table target
+assert_no_reloc_sym __bug_table other
+assert_reloc_count __bug_table 1
+
+pass "patched WARN site retains its own bug-table entry"
-- 
2.55.0

