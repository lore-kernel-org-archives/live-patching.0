Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF804964F;
	Sat, 15 Aug 2026 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769144; cv=none; b=J1bhECUVHGYLN87ehyFvst+/4FDaX2+ADW7cm2gUOWxzR9fG7oilwITT9g6dhBLQzEiCPHncr8DKpwrDtt6KmxJS8gTKhs/HnZkRNmZQEWnt7tyzD8KprnNNPGY8iDTl3vtWmWk8idm6FrvZOiqFc41IfObRVL96Wqe1vlfYq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769144; c=relaxed/simple;
	bh=3M1behHkCGv6bYHhLp39v0ywWcLOIJADqn3UuuMpmQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM18Ri9QsgSi40tU+wv+9j3WMb/Wy0wToQ/wFXVKasiggIAFG/FLqTzqXvZl4UphsryQH4U7cy3i5Ib6JD+ivYN3H3E31ZbXo1uAG+KdvHMXfG8bC+QNKRYgxR4ndWZQ48uS5OcSbACV7uUf1SqLhi/dEY6tX78SF58cJApA0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFtaQ7Hy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFtaQ7Hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92991F00ADB;
	Sat, 15 Aug 2026 04:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769143;
	bh=AHPbfRN1aXc5IcowpP0Zhp7GRqsoacbyPIsxiGgDAIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFtaQ7HynKD0KIr6wOyIrZJDs8M0jhsHT8P2mazfzFwD85V++d7q5LtKKRfqokKs+
	 xbpmhxxcn7yo71SfMO3QKBccLMWmZYJVsd/pBqwyS3R22O5CcBoVTPJ9jdAeHyN2ry
	 5sC8e2cQF3vmVW5BWJQw1OUxUoPEmPszo0MJxbhx0f2m3CPy1rwR9PG3ul3OK6VUsU
	 Ldd1FYqKzEKvb+SnUQ8JpjTP5y81t0YTQPc+oXNvQ2jO9/oiR8Dq0c7E+w6A04pPRK
	 S/Qp6BqPFZBOBimSe7O3FXDta/3N7GjL0hYu7PX51uqjDq1a4YqUDSrbvEwEfOoJ3n
	 X4eBHNSyKPgqw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 01/12] arm64/bti: Add BTI landing pad to __sdei_asm_handler()
Date: Fri, 14 Aug 2026 21:45:18 -0700
Message-ID: <99226432cc316215829655c787f71a70f06d1600.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_UNMAP_KERNEL_AT_EL0, __sdei_asm_entry_trampoline() indirect
jumps to __sdei_asm_handler().  Add "bti j" to prevent a Branch Target
exception.

Discovered by code inspection.

Fixes: c50d32859e70 ("arm64: Add types to indirect called assembly functions")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e0db14e9c843a..16c21fcb41976 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -976,6 +976,7 @@ NOKPROBE(__sdei_asm_exit_trampoline)
  * want them.
  */
 SYM_CODE_START(__sdei_asm_handler)
+	bti	j
 	stp     x2, x3, [x1, #SDEI_EVENT_INTREGS + S_PC]
 	stp     x4, x5, [x1, #SDEI_EVENT_INTREGS + 16 * 2]
 	stp     x6, x7, [x1, #SDEI_EVENT_INTREGS + 16 * 3]
-- 
2.55.0

