Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCB20CCE4;
	Thu,  5 Mar 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681507; cv=none; b=CdTZLV1vvhpx2oYcK8ZcIs2Sx5QhPObOutcHzPYc21o+IEDSoZqYK4ZXQF1FlBA75lyInoaFkKkhpfhs2Cs3naHsBnAXOYrPOTCM+4MyNWYNkkjz6NA2CrZ59ELGwfA5T69DzuTOQH138nyid4+Gi0m3/HuLciA+rdGgk+SZG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681507; c=relaxed/simple;
	bh=Lly+R/jrWXObFqx210gTdFxMEi6szRFOEEE+yXvt8TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecSZWEsciGOXbJnqLA8mIHl2S1QDAPAvIPck46ad4ghtd7t6lD6tho8Ybl3joWnwm/Mh4NDvZirKCZ7v6dagSSRq9CS4sMhKPpKLA2300MFx1VCvWrpYlL87m750LAtCCQhKdhAXdzDw+c1nQy9z32E1pZjoXaaAIVDf40kdd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+RWL5DJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+RWL5DJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659D7C116C6;
	Thu,  5 Mar 2026 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681507;
	bh=Lly+R/jrWXObFqx210gTdFxMEi6szRFOEEE+yXvt8TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+RWL5DJduqwWgMhcwPWpJFat7vD1Yin2T38SibOq2/ELzMaX65bTLsh7nczpmiMY
	 FUYTJTQZFMr/3Y20XdxBpgQh6ga4gMAN9TD6YTIlKmPMfluDucwBIg/im90XyHwUGN
	 dCWwDgYMbwvdKiEJQUeZ+vcVtGmakGXccXE/dIMtpgW0a9LwZgh5yHeRlC4poe2HGw
	 SLlnb7Do0IBIDwQQY7U9TDKRAvA3X9RpuQlxMDN4FIdEI/NECs42ptLbcGjQ+6mmAo
	 ayh23UoCs0PnyZWSMTWd6+lT6z7GLaSADU8BFhEAzwb8MTg7nm0O6apSLFCjCB2tq/
	 uaTTXOoCPBFAA==
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
Subject: [PATCH 03/14] arm64: Annotate intra-function calls
Date: Wed,  4 Mar 2026 19:31:22 -0800
Message-ID: <2fa6fbde8c6bbd91df0e2bf48b9c9370047dc61e.1772681234.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772681234.git.jpoimboe@kernel.org>
References: <cover.1772681234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for enabling objtool on arm64, annotate intra-function
calls.

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

