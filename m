Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C573388885;
	Sat,  8 Aug 2026 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231121; cv=none; b=sF1lyYHl3pOWyLI2mVC3F7fvDJtuNK1IYdLkkuymND3gcYf5bwVQVubo2TH6kEQIgPYoeLAB2pau7FmJ3vetNJIpcw0zkb578ebhM3XH6ARpEn9xHgiVecXm2GN4bKzK12ExgyY9AQo+7XZV3peJU7/4ehM/f9rPktxWv7VgOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231121; c=relaxed/simple;
	bh=6fM8KcMUTsMh3APd7Q69CFrzEQaWzzsd4MPHm/S4LGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcLL7aVb5mJSxDzN+kRD0GKxMS+CL19v645tLW9EdFo4UdQ2tyS0Tp652jV4cbVdeSBZffQY4+fwFgUbjrl+xgRWrNqsZ2Vilm8CMCYkIE73caO4tAv7CEkv9Befett3GAMt5C0MBZyT38BThZXNI+umsZP3za6bftB6GnQGh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUHdYqsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUHdYqsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123E51F00AC4;
	Sat,  8 Aug 2026 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231115;
	bh=dOZHGJeIbepL3mJdX8opMcoKRte7U11zEhbMcktjANc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUHdYqsO0zpCVOBvNEYBw7FpX5o8Dy0WeFYkKuS735DrtZwrgfuloJny+SPE7ziSs
	 dKRIdMxd5ERoCxsnt8sITbi+mGuiu5zTG+svBk3PvOiDPFzK4vuuTl08EGyEYr510U
	 piOi5esgGaDWVz2W4f17zRZU01GHczFJfjh3JRKFgPEvzX8VLWPb59Tpk13TdM60QB
	 hbw2B2zIHDDLp+Bsx4Dwe/LpaN8SGfjnQGKj7hM5DkRIdC8unk71ktCTCz0r6vV4RG
	 jR9u8+WHkZDJYw3OsZj6czlhDFNdbY2NZits11RpXk4dgcru7v96nyS3xPn/HbIHnA
	 gbieQK5GJojOA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 12/22] objtool: Ignore jumps to the end of the function for checksum runs
Date: Sat,  8 Aug 2026 16:17:16 -0700
Message-ID: <13cec0336ae0e9ad4bd605bf34b1236de85d6243.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes Clang arm64 code jumps to the end of the function for UB.  No
need to make that an error for checksum runs, which are only run
manually by klp-build, and for which caring about UB is out of scope.

Such UBs are still reported for normal validate branch runs (for arches
which do that).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b353c7d6cd893..c034676e1b8c7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -38,6 +38,22 @@ struct disas_context *objtool_disas_ctx;
 
 size_t sym_name_max_len;
 
+static bool validate_branch_enabled(void)
+{
+	return opts.stackval	||
+	       opts.orc		||
+	       opts.uaccess;
+}
+
+static bool alts_needed(void)
+{
+	return validate_branch_enabled()	||
+	       opts.noinstr			||
+	       opts.hack_jump_label		||
+	       opts.disas			||
+	       opts.checksum;
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
 {
@@ -1595,8 +1611,12 @@ static int add_jump_destinations(struct objtool_file *file)
 			/*
 			 * GCOV/KCOV dead code can jump to the end of
 			 * the function/section.
+			 *
+			 * Clang on arm64 also does this sometimes for
+			 * undefined behavior.
 			 */
-			if (file->ignore_unreachables && func &&
+			if ((!validate_branch_enabled() || file->ignore_unreachables) &&
+			    func &&
 			    dest_sec == insn->sec &&
 			    dest_off == func->offset + func->len)
 				continue;
@@ -2586,22 +2606,6 @@ static void mark_holes(struct objtool_file *file)
 	}
 }
 
-static bool validate_branch_enabled(void)
-{
-	return opts.stackval	||
-	       opts.orc		||
-	       opts.uaccess;
-}
-
-static bool alts_needed(void)
-{
-	return validate_branch_enabled()	||
-	       opts.noinstr			||
-	       opts.hack_jump_label		||
-	       opts.disas			||
-	       opts.checksum;
-}
-
 int decode_file(struct objtool_file *file)
 {
 	arch_initial_func_cfi_state(&initial_func_cfi);
-- 
2.54.0

