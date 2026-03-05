Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E117B425;
	Thu,  5 Mar 2026 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681511; cv=none; b=ONX0NWIB7CblCelEK2duXqV/4+UQTktHoPlPlNTSW7XLTNTzzrSmGRZ0899S9X8lwK5pK9HXRUlgjL1CZTfi+XUY32wLjbpY20I9AzrTLT/PCxMWVdcRQhfL+sQU31Tq/GkvAaY1PekySD6Qk61LjsG23t/42JBn8IKPksA+dnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681511; c=relaxed/simple;
	bh=VHYVcG46HDcvFMvnPYNK+XTdXj0sPBym+XtZyAEFC2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bReLBVOob81IsDmidl7c1iU85SyI93HAzLkA+nUovDfT7Q42tfcHH0jux0nbG8ZBBL7vhqEq5qk33PNoy3Go2ZcWXfialvi6zUhjATHryX8g25NruO9KK4lD22MI+UmFO8UNpjnXiqc9vIlSe25X3+4jk/mSIieMvoy6Yu44nTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOBegSj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOBegSj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBA4C2BCB1;
	Thu,  5 Mar 2026 03:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681511;
	bh=VHYVcG46HDcvFMvnPYNK+XTdXj0sPBym+XtZyAEFC2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOBegSj4bFua+UjhhPwRDV7XNVhh/g3cKxQYIjT6ew5n5CetHZ3r1VPz9EuZCV0Tg
	 swMjoMoh53oWoDa09zYVhImN91Zp1NCMiEJQrZRqI0Q++rkV9WtrcQtcbwdPTz/jjY
	 IvPvdLjkNcO6TtKX2LZOOME4Uc9ICEsJcbHX2H8bKve9InN/Qys/3LYRr4Z8keeDb+
	 YvaE6JwhSE1P/o5t5Ar1CxAnGRUZewumnyrLjtlW/MFNNzk0TuZJb9/XPVbpCYk5bN
	 +16QWy0tFMJT63+G0nCMqXwQOhKz0uRWj/AGumH4ZQfGoRhnjwY39auhvx7quWclaO
	 htiUQKywMIsBw==
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
Subject: [PATCH 06/14] crypto: arm64: Move data to .rodata
Date: Wed,  4 Mar 2026 19:31:25 -0800
Message-ID: <8060fb1dec9eff0927f999389b62957ca9dac675.1772681234.git.jpoimboe@kernel.org>
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

Data embedded in .text pollutes i-cache and confuses objtool and other
tools that try to disassemble it.  Move it to .rodata.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 lib/crypto/arm64/sha2-armv8.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/crypto/arm64/sha2-armv8.pl b/lib/crypto/arm64/sha2-armv8.pl
index 35ec9ae99fe1..8cd86768bf5c 100644
--- a/lib/crypto/arm64/sha2-armv8.pl
+++ b/lib/crypto/arm64/sha2-armv8.pl
@@ -237,7 +237,8 @@ $code.=<<___;
 	ldp	$E,$F,[$ctx,#4*$SZ]
 	add	$num,$inp,$num,lsl#`log(16*$SZ)/log(2)`	// end of input
 	ldp	$G,$H,[$ctx,#6*$SZ]
-	adr	$Ktbl,.LK$BITS
+	adrp	$Ktbl,.LK$BITS
+	add	$Ktbl,$Ktbl,:lo12:.LK$BITS
 	stp	$ctx,$num,[x29,#96]
 
 .Loop:
@@ -286,6 +287,7 @@ $code.=<<___;
 	ret
 .size	$func,.-$func
 
+.pushsection .rodata
 .align	6
 .type	.LK$BITS,%object
 .LK$BITS:
@@ -365,6 +367,7 @@ $code.=<<___;
 #endif
 .asciz	"SHA$BITS block transform for ARMv8, CRYPTOGAMS by <appro\@openssl.org>"
 .align	2
+.popsection
 ___
 
 if ($SZ==4) {
@@ -385,7 +388,8 @@ sha256_block_armv8:
 	add		x29,sp,#0
 
 	ld1.32		{$ABCD,$EFGH},[$ctx]
-	adr		$Ktbl,.LK256
+	adrp		$Ktbl,.LK256
+	add		$Ktbl,$Ktbl,:lo12:.LK256
 
 .Loop_hw:
 	ld1		{@MSG[0]-@MSG[3]},[$inp],#64
@@ -648,7 +652,8 @@ sha256_block_neon:
 	mov	x29, sp
 	sub	sp,sp,#16*4
 
-	adr	$Ktbl,.LK256
+	adrp	$Ktbl,.LK256
+	add	$Ktbl,$Ktbl,:lo12:.LK256
 	add	$num,$inp,$num,lsl#6	// len to point at the end of inp
 
 	ld1.8	{@X[0]},[$inp], #16
-- 
2.53.0

