Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778592D7BF;
	Sat,  8 Aug 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231111; cv=none; b=N1EGVGOlbCS3p0NxShnsTvKkaIlzuGk4e0lqjGX8z0TCBTQJUV8+NLza6mZZ1ElBCsTeBGkCGsXkX4YNTo7zX3XKbYBoq4YqpEVmLMjr0scDzs0c6L6Y1hQb+tLg94eWWFqAATdwHv+6ovIKK2ffYnQnLDMwtSbPQxZ94eQ8OP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231111; c=relaxed/simple;
	bh=EZhulEUeUjIh22n7R4XE6yRJ3zCVXvUK5w91EVCMNxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmXMu+3hK0ydaHmN1Tq7gkZns1wu7RmGsC+R503LKPu6d8w+uJj3KywiaaXOvWTUZ6i8m7XfAf9VQgHrU4BjkQrNtX6ugNhILEginQAIeP+i2kYC1U16+RAs7qWoU1y3T4v7zX+JnR7C5jlz6TSY48QfrJOre8kvwn5GdzFYJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/2Xcr9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/2Xcr9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C130B1F000E9;
	Sat,  8 Aug 2026 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231110;
	bh=tIcgB+tvT4EZ6BD6hvn5buiMDsNcMRKktpWUEIjKt0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/2Xcr9xyrCYzPPKDUPzMqRo1EohSgX5ZEo2WBvWrbz8qHLfa3hRADrCObejyGDBe
	 b6I35OxXQ7todPwPSUEN3V+sTbA0AvPp/PLri2Pc+I6XlPIpNrJaHWxejk4wVstUTk
	 jB56reLYqppiSip9NyozScQusOUiePtfutDjJFXEVYvUhJShiL01obRgGpsnqLlyjS
	 JDWLxW330X5kM4qRwqxZ0a8fOcsmto9l2yZa5ApsA/bKqTCHoHc/itXJNLRfTKXLp2
	 ZA+EN4z7jZJ12UY1ynoWn56LHBuROo/3JV4Vn+XT9Ky4F4bwzuf24YIzLBDYlGwSEo
	 VSD3x7DoLYF5w==
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
Subject: [PATCH v4 05/22] arm64: Rename TRAMP_VALIAS -> TRAMP_VALIAS_ASM in asm-offsets
Date: Sat,  8 Aug 2026 16:17:09 -0700
Message-ID: <108ebf574aa6a6e244fcc225856eb845346cc3fd.1786230311.git.jpoimboe@kernel.org>
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

Rename the asm-offsets TRAMP_VALIAS macro to TRAMP_VALIAS_ASM, following
the naming convention already used by PIE_E0_ASM and PIE_E1_ASM.  This
disambiguates the asm-offsets-generated constant from the C macro of the
same name defined in fixmap.h and vectors.h.

This is needed by a later patch which adds new includes to asm-offsets.c
that would otherwise conflict with the C version.

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/asm-offsets.c | 2 +-
 arch/arm64/kernel/entry.S       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b6367ff3a49ca..44b92f582c127 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -153,7 +153,7 @@ int main(void)
   DEFINE(ARM64_FTR_SYSVAL,	offsetof(struct arm64_ftr_reg, sys_val));
   BLANK();
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-  DEFINE(TRAMP_VALIAS,		TRAMP_VALIAS);
+  DEFINE(TRAMP_VALIAS_ASM,	TRAMP_VALIAS);
 #endif
 #ifdef CONFIG_ARM_SDE_INTERFACE
   DEFINE(SDEI_EVENT_INTREGS,	offsetof(struct sdei_registered_event, interrupted_regs));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d4cbdfb23d733..85f6305c1f568 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -102,7 +102,7 @@
 	.endm
 
 	.macro	tramp_alias, dst, sym
-	.set	.Lalias\@, TRAMP_VALIAS + \sym - .entry.tramp.text
+	.set	.Lalias\@, TRAMP_VALIAS_ASM + \sym - .entry.tramp.text
 	movz	\dst, :abs_g2_s:.Lalias\@
 	movk	\dst, :abs_g1_nc:.Lalias\@
 	movk	\dst, :abs_g0_nc:.Lalias\@
@@ -626,10 +626,10 @@ SYM_CODE_END(ret_to_user)
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
 alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
 	/* ASID already in \tmp[63:48] */
-	movk	\tmp, #:abs_g2_nc:(TRAMP_VALIAS >> 12)
-	movk	\tmp, #:abs_g1_nc:(TRAMP_VALIAS >> 12)
+	movk	\tmp, #:abs_g2_nc:(TRAMP_VALIAS_ASM >> 12)
+	movk	\tmp, #:abs_g1_nc:(TRAMP_VALIAS_ASM >> 12)
 	/* 2MB boundary containing the vectors, so we nobble the walk cache */
-	movk	\tmp, #:abs_g0_nc:((TRAMP_VALIAS & ~(SZ_2M - 1)) >> 12)
+	movk	\tmp, #:abs_g0_nc:((TRAMP_VALIAS_ASM & ~(SZ_2M - 1)) >> 12)
 	isb
 	tlbi	vae1, \tmp
 	dsb	nsh
-- 
2.54.0

