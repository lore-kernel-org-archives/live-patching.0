Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC83383990;
	Sat,  8 Aug 2026 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231100; cv=none; b=d+V7wpKNWOrtT7XyBYtifYnzfn98yMOk/ueEP73ocqQlHFbYE0CB//E0BGnnY0LYDj6A1mdwFRY19YWV3wuzRtWBT6oZxCc06GiWa91bCX67QvUYhznkjRGywXS9WwF9MNfpZTXTYSXSstXeRP92Jxu4+O7g/wxYPgvvhCAWbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231100; c=relaxed/simple;
	bh=gbz/DYxJ/sJCXTm/JVO6OX9wG85Wy1PEbplpxSUYjOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DARLzzayJuaisV0T1yKOUpnusl/VQtjW8+6940AwF3mqont7h6pYpw2OkVTK9NyZ/ACJT+A/bUhM8I3UTz5bkXv04erCTNQT5F0WDNlcQS6SMKAKI/66P8Q6trNuHxjap2FgO5Bo3d89QgGA0ZOrQ9K7fBIq1yg4Fju++cdEWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCMIUlLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCMIUlLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF811F000E9;
	Sat,  8 Aug 2026 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231098;
	bh=y5jStvRxXhCnYlnJabnKzeT9J7k+pNzNQ0SCW4VdeUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCMIUlLz1Asek+LxJ+kcAPQ6aq74uNQTDC9q7nEcsLt4tESEewgyodt0rxoHbpRaX
	 FrQ1rIUO/vnDlvHSkB3WkFQNsQT4xiTFwUh5bnF7mllDKg0mlRJaDsHt8akX2JAi+1
	 XbgnFgT1g6n9lKmWWGFW5+3tgA1o0/N8uW4mjpxcQuDEn4zmLY0RCgV0AfFsPr4/Y1
	 1g3psKhadx5/uzRuwmotee6vMKfzEBBaPfQsofTjxWP3o3R2tcOoFkMdtgL4H4Wp3C
	 fg3DfurXXgY5fn95vjXz8FjZ899AtqA48aTQBHwgXRWMndnqxjJ88lr57mvuzTjRdI
	 PVHSCEx8UURFw==
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
Subject: [PATCH v4 03/22] arm64: Annotate intra-function calls
Date: Sat,  8 Aug 2026 16:17:07 -0700
Message-ID: <df382d501fd19172f11aa910ac3e0d0adfed9e6d.1786230311.git.jpoimboe@kernel.org>
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

In preparation for enabling objtool on arm64, annotate intra-function
calls.

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/entry.S       |  2 ++
 arch/arm64/kernel/proton-pack.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e0db14e9c843a..d4cbdfb23d733 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/annotate.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -705,6 +706,7 @@ alternative_else_nop_endif
 	 * entry onto the return stack and using a RET instruction to
 	 * enter the full-fat kernel vectors.
 	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	2f
 	b	.
 2:
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 7bb6553fec087..3737190ce36ec 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -25,6 +25,7 @@
 #include <linux/prctl.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sysfs.h>
+#include <linux/annotate.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -246,11 +247,12 @@ static noinstr void qcom_link_stack_sanitisation(void)
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
2.54.0

