Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BE39A80E;
	Wed, 13 May 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643274; cv=none; b=kbhlhUdUSXiykuOXhy58ktVC/ypHh1USKyMGMlu0NSZs1kAETdbg0+G0KsooXjzEmh+3KxlxDfw5Mahq2kU7tuUCLjydNwq3KvB/yYAj3FF2XCv/klDG2PKDJHrXISwEW/ihCRmzDxpW8ic3P1bbopstONVhEyrGLgxd5IgGyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643274; c=relaxed/simple;
	bh=l/Ci/bQZJNfrCn5KEXNZpm9m+7qL/TrCFKOnkDayqLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZYmancEk4myjI4VG+5ca4FYCJB7ef5Td7AsrHblGStmyd9nficAp7tTSaopYmDWoJ5O36JmiMaWRIQgwJskNEeJB9dmsAURYRSy29lizxO8a2lARqhZC6kWSaBFlkABE0Dp1CDe8rS8T+LTloUxbK+ycT5zn7wNrK7gAVbYiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvWWrvr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvWWrvr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA1C2BCC9;
	Wed, 13 May 2026 03:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643274;
	bh=l/Ci/bQZJNfrCn5KEXNZpm9m+7qL/TrCFKOnkDayqLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvWWrvr3vNY1RHGCbwUIoeM7vpXEUIjvC/y+t1fFTd8vCbl4oLyTY+QbRiDylioNy
	 M8USGIkz/qOjDOS3rjVBs1VtEu/G5+9XhEJRROe6yxEKZRqyoj/y38yB0ExGNCeOTW
	 zlmqrMoprmqD7jT0ORFHmGirMPzAJv0z+XSbRniG8XA3QnUxdW7XLHamkQ5aGj2ORr
	 zIRxT919KRnpwccWrx8C/uH7+7lWHwhEl78BRPDIdVBA3iaLcuNSmZCplg9Ds2zaR2
	 iwzNfgVnk51VZH0eXCSDGISTVeeaXyk0HQzpQ2Kl+Suw7mcDL6ETogyMOWtr70jhVn
	 sSh5OP/xYmOAA==
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
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 07/21] crypto: arm64: Move data to .rodata
Date: Tue, 12 May 2026 20:33:41 -0700
Message-ID: <3757f0bdb8117c875c2085dc42b6becd28b4285b.1778642120.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
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
2.53.0

