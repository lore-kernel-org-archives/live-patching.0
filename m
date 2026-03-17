Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76633A7F47;
	Tue, 17 Mar 2026 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787892; cv=none; b=WMXA7yfz9WzDq8H6IjnntmRdDfpZNvoNxLCws+bvTJLBb/YMta9TFp3RQ7KoooOnwjbtyjgkNvhdNGxZkm3DwQkr36XeKnksrF6P8z+SyVf2f8+mJxdtTN9cViRG3vYr3qFf6MNKaeKme9ZukTB4uCXbCMuZAA+DzKoiRlldLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787892; c=relaxed/simple;
	bh=sgRjFM7xWFg9L5n1fihixm+C5Qbm0Ax6cGt49J083JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sftcsAuwLhxDzZvYTCV47E1GR1qRszm9l5+TKEL7Gwsr6y8le/scrLtMdxS0N2/Pj5dul/aEpW0eiP7C3jcwJJEFE5opaIJb/iC27XmI6XNL/gwZ0FAQuks7DnCmJoCeM2jujwjPsrZGOYOFruJbrtha+2moQCeLQWT13JVXT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/glGm01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/glGm01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2F0C2BCB3;
	Tue, 17 Mar 2026 22:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773787892;
	bh=sgRjFM7xWFg9L5n1fihixm+C5Qbm0Ax6cGt49J083JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/glGm01cZOY8IhazlamaSFb++2gB16akWLwpdr+xDiQlDwhFBMGEU+K/8zBRuBlC
	 E3nJxjLBpP4w9TPa2qn0+fQbZdGcp+F/8gAq9AGPW60tQaMAONlVXt/uBSXnmlXS+L
	 tkPS3KC48AHcJwsfN1+2IhpieaQv8xJN3jDq6D47+DEYYYnVtemNLlENMmwtTN8mTr
	 uYpB+UFZ9H2OEZrWlCtfUYzDP8txjmPEzdJgFLb1mAcJgyU56qpNRmHCFgWI4b9kBH
	 qP2VJq8c4xLG6iEn9WyvagAuVOJ3K+GnjBxedvNJgtm3e9xgDIhRdvuATTHneM+y/i
	 kJNmpFfWVDzqw==
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
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 01/12] arm64: Annotate intra-function calls
Date: Tue, 17 Mar 2026 15:51:01 -0700
Message-ID: <3a9decf6cc0ad8ae707c3b4df814b92b3e7f85d8.1773787568.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773787568.git.jpoimboe@kernel.org>
References: <cover.1773787568.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for enabling objtool on arm64, annotate intra-function
calls.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/entry.S       |  2 ++
 arch/arm64/kernel/proton-pack.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f8018b5c1f9a..cf808bb2abc0 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/annotate.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -707,6 +708,7 @@ alternative_else_nop_endif
 	 * entry onto the return stack and using a RET instruction to
 	 * enter the full-fat kernel vectors.
 	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	2f
 	b	.
 2:
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index b3801f532b10..b63887a1b823 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -24,6 +24,7 @@
 #include <linux/nospec.h>
 #include <linux/prctl.h>
 #include <linux/sched/task_stack.h>
+#include <linux/annotate.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -245,11 +246,12 @@ static noinstr void qcom_link_stack_sanitisation(void)
 {
 	u64 tmp;
 
-	asm volatile("mov	%0, x30		\n"
-		     ".rept	16		\n"
-		     "bl	. + 4		\n"
-		     ".endr			\n"
-		     "mov	x30, %0		\n"
+	asm volatile("mov	%0, x30			\n"
+		     ".rept	16			\n"
+		     ANNOTATE_INTRA_FUNCTION_CALL "	\n"
+		     "bl	. + 4			\n"
+		     ".endr				\n"
+		     "mov	x30, %0			\n"
 		     : "=&r" (tmp));
 }
 
-- 
2.53.0

