Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9D37D124;
	Sat,  8 Aug 2026 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231122; cv=none; b=YUXfbkxc9op80Ibr7OH7LAY0C5WV5fcf42VVNdFKN1Yd1V7oIcw4Ccba/91XDLutxwShm9edaznnIa7O8ZgAUxEqfIgQVPyZ9FXleDgFjUUstZ5YfQ+M/l31+lVnKf4q3wrFblL5OKCdA8p4m+KxXRmeC4MJw8vgdKYquOeXYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231122; c=relaxed/simple;
	bh=pmf79rrtsNXmpoe9hehE/nAg66JKSIJyNndJWZCs0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bma9z9XA5QrcCD9edh/Ibp0e2brhZdrcIOzm3QL/7qBJitAiw+ywpyS9jdG5ouALNJVAfLrC4Q/GttJHO7/JeL/Hl4ifazSEdhO9RmilQ0iVGc0jxcXVBwVS7kF95ogpGhzTl1i3b6u7A14lFljdMEiWKd1laVpOK7dKMmWNpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTjOZiEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTjOZiEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC281F00A3E;
	Sat,  8 Aug 2026 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231113;
	bh=6ADoXXo4TVe2TzxKvpv7LpzKJ+UodT4wZ8UmCONxN/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTjOZiEJ/oVFbHxdRHa9OdqUfCW0ZkH/Pa0qeea/645oCYuH6IWs86G5L5eMfRnbn
	 f4dd3lsEnmGxZ4vkZcaEJY1/0ca1uA1DMBLLxkaeevsR50rJe+gm8QxcbxTSJKxb+a
	 C0mPDNYJ1O4i9QfNXp8FgGkCOl7khYqMVF+jGXg8hWXyiCFchPoSG0gXCcJP294tbV
	 tFqlB3iFLcN0wfsQT32TFenXZUqQtkVTBuSzgtB/ZtIIuASipdos4hIZz/Pv3BecG6
	 gK4dkCaSoi3M1bjLItXD10lpp46yD3CorxgvvUyEigTKQ26Jgzf+T0fW/TBG36+1ZF
	 PQqf8qQ8IsZBw==
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
Subject: [PATCH v4 09/22] crypto: arm64: Move data to .rodata
Date: Sat,  8 Aug 2026 16:17:13 -0700
Message-ID: <bf52b36c34e987a3a75c2c1c2d4c8d0f91b75f6c.1786230311.git.jpoimboe@kernel.org>
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

Data embedded in .text pollutes i-cache and confuses objtool and other
tools that try to disassemble it.  Move it to .rodata.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 lib/crypto/arm64/sha2-armv8.pl | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/crypto/arm64/sha2-armv8.pl b/lib/crypto/arm64/sha2-armv8.pl
index 35ec9ae99fe16..e0ee2d5367e72 100644
--- a/lib/crypto/arm64/sha2-armv8.pl
+++ b/lib/crypto/arm64/sha2-armv8.pl
@@ -207,12 +207,13 @@ $func:
 ___
 $code.=<<___	if ($SZ==4);
 #ifndef	__KERNEL__
+	adrp	x17,.LOPENSSL_armcap_P
+	add	x17,x17,:lo12:.LOPENSSL_armcap_P
 # ifdef	__ILP32__
-	ldrsw	x16,.LOPENSSL_armcap_P
+	ldrsw	x16,[x17]
 # else
-	ldr	x16,.LOPENSSL_armcap_P
+	ldr	x16,[x17]
 # endif
-	adr	x17,.LOPENSSL_armcap_P
 	add	x16,x16,x17
 	ldr	w16,[x16]
 	tst	w16,#ARMV8_SHA256
@@ -237,7 +238,8 @@ $code.=<<___;
 	ldp	$E,$F,[$ctx,#4*$SZ]
 	add	$num,$inp,$num,lsl#`log(16*$SZ)/log(2)`	// end of input
 	ldp	$G,$H,[$ctx,#6*$SZ]
-	adr	$Ktbl,.LK$BITS
+	adrp	$Ktbl,.LK$BITS
+	add	$Ktbl,$Ktbl,:lo12:.LK$BITS
 	stp	$ctx,$num,[x29,#96]
 
 .Loop:
@@ -286,6 +288,7 @@ $code.=<<___;
 	ret
 .size	$func,.-$func
 
+.pushsection .rodata
 .align	6
 .type	.LK$BITS,%object
 .LK$BITS:
@@ -365,6 +368,7 @@ $code.=<<___;
 #endif
 .asciz	"SHA$BITS block transform for ARMv8, CRYPTOGAMS by <appro\@openssl.org>"
 .align	2
+.popsection
 ___
 
 if ($SZ==4) {
@@ -385,7 +389,8 @@ sha256_block_armv8:
 	add		x29,sp,#0
 
 	ld1.32		{$ABCD,$EFGH},[$ctx]
-	adr		$Ktbl,.LK256
+	adrp		$Ktbl,.LK256
+	add		$Ktbl,$Ktbl,:lo12:.LK256
 
 .Loop_hw:
 	ld1		{@MSG[0]-@MSG[3]},[$inp],#64
@@ -648,7 +653,8 @@ sha256_block_neon:
 	mov	x29, sp
 	sub	sp,sp,#16*4
 
-	adr	$Ktbl,.LK256
+	adrp	$Ktbl,.LK256
+	add	$Ktbl,$Ktbl,:lo12:.LK256
 	add	$num,$inp,$num,lsl#6	// len to point at the end of inp
 
 	ld1.8	{@X[0]},[$inp], #16
-- 
2.54.0

