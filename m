Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21637BE7A;
	Sat,  8 Aug 2026 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231114; cv=none; b=B/pk4pTBA78DkmR5CDjwxGEB5bwfhXBko5PFhomeDk9pEkzzZTMSbBCpGDd+iHeX1qUha/o4apLMs3UvWHgZJZd3OHDcPTy8LnBdKOM4atIH7nUnjtZNAQRu+HtWudIUWCmyhIC6YniTyluQzRcRDueYVliZFqgNLUyaCTdbF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231114; c=relaxed/simple;
	bh=em/W6RX1LDB/B/iXSMlDcExQArcuro/ypwsLBvemSE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdmN9sNoMBc0RRzjRrKtD2I2vJfsITvtZrcSBbKFEnq2005t177cYBKhWYJPJFGEtjAJotb6W2VsGR0fEUTu/9zwwUvy+ZHlqxSumx+LFZMxir4RhbFaqGCOUG4oAlRfkx+CWJAncRATALNCRqMK1unnUQYtdk8Ca+umvD0r278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8T+/OKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8T+/OKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFC71F00ADE;
	Sat,  8 Aug 2026 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231112;
	bh=ca1nwuh/ovV7iRlJ1HipcMmil7CeSekJrBHAP1jRLkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8T+/OKR1u9TE8zMCEbQ4TXv1lVbonhiRfkPhEbj9aBh3hZ41aNT296DcWSDQxxxK
	 99oIJh/K451j+TTrApJzmlCGBBkddDrxpw9L/zoLPMkRZ6cuuDLYcKMTMP2T//ZXfx
	 rDoXERtMRV9KJuVPqPju07SwjrfbcQnYcfZ8+JFA7CWCAl3cVrhj/Ggp+neiu9mFYe
	 VfkYbrlLLj7jwmJ+mf6yWW6FpiIbHCZMmfVfmdmtyJTJZLfwngEYTxFrKQDih+6VgT
	 f6ffS9xmOq/1QoRICXUxnnBTRXyNE6ujppyVlcbU72ztkjGYC0DaajkkICYuuWtQjj
	 AkjbnfGEnqanw==
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
Subject: [PATCH v4 08/22] arm64: Remove unnecessary empty alternatives
Date: Sat,  8 Aug 2026 16:17:12 -0700
Message-ID: <a22bffd0fa5b02511fb6e4c1b68af871f260e691.1786230311.git.jpoimboe@kernel.org>
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

The code in arch/arm64/mm/cache.S creates three empty alternatives, all
from calling the dcache_by_myline_op_nosync asm macro.  If \op == cvau,
it creates an empty alternative for ARM64_WORKAROUND_4311569.

Since orig_len == 0, the alternative patching code mostly ignores it,
though it does do an unnecessary clean_dcache_range_nopatch().  It also
triggers an objtool error ("empty alternative entry").

Clean it up by moving the .ifnc check outside the alternative emit.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index effae53e9739d..6e059efced5bb 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -404,13 +404,13 @@ alternative_else_nop_endif
 	add	\start, \start, \linesz
 	cmp	\start, \end
 	b.lo	.Ldcache_op\@
-alternative_if ARM64_WORKAROUND_4311569
 	.ifnc	\op, cvau
+alternative_if ARM64_WORKAROUND_4311569
 	mov	\start, \tmp
 	mov	\tmp, xzr
 	cbnz	\start, .Ldcache_op\@
-	.endif
 alternative_else_nop_endif
+	.endif
 
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
 	.endm
-- 
2.54.0

