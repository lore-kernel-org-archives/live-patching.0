Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9C36197D;
	Sat,  8 Aug 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231111; cv=none; b=qK2nArPIAKR+bEfjVSoAiLTDYCl2ccAnMv4AG5Vd80RPlmyrGE5XjcQ8VJTi7tu5YULm2CrD1yTcvkwoIpfQr7ABzabN1ddmZkrxvtRa1ITds0bUf2QfhLLTJWryGnTUbRH39gOTvkJT5HK1IqU+Q1H/CvUYPv63Smog2Ufu9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231111; c=relaxed/simple;
	bh=NJjOZRlsA+ES/6neDIFawlMJMUrIfIY0o+rmpexD76w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb789KX+VQGepmgvjty59wg4ekK7eOuuPfU17OFiL+VEAf1tsAwjzkWQOkTadqw9zeMC2T6xxQHZ/Q6YQ/FQaJ/0ozB8EgQvQ8x5Pb87QiVWLCn9bZz455sp+SAk2fAPrsjBL+0HCKlqMbNEn03q2y9fnS4wWLi4GkyRpN5nUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLnA1aXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLnA1aXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6931F00A3A;
	Sat,  8 Aug 2026 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231109;
	bh=W9b4Bn/jCc6njmblrCdb5kz0LDKIkI3N8b9vqXSBZ44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLnA1aXrDS1TAiKjspJeJ5UQ5kn2WXj2kjANeHma49+w4uagHC80MPMREog7bgEX6
	 5iOreJWSQX5FW++X656Vqxgv4LbLKxBNr1ck+QNclsIZGefnx/2jXSbz74ftM/ZbUK
	 WheyLyhpCPewVpA/mD60T1QtJfFSTvjBSFLvxBICEDejXHBXP7Dd7NxEurf1wUjvDX
	 nt3tnpc5lBgAFrPAUxMlR3CpEdNbQriINpeJW2a9j2cOsa0SAkCYxWH4x85GGXGVS0
	 Emz1G7XBnbhseVEd7iATvLEjFhPcqvT45pvvOr+c9eIec8ZXGZkXSy11/OCAvMH0uR
	 pQZ1QKNNOM+NA==
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
Subject: [PATCH v4 04/22] arm64: Fix EFI linking with -fdata-sections
Date: Sat,  8 Aug 2026 16:17:08 -0700
Message-ID: <7b18edbeb7bb68f3a69b8b0bb7ede12d834ad1d9.1786230311.git.jpoimboe@kernel.org>
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

When building with -fdata-sections, the .init.bss section gets split up
into a bunch of .init.bss.<var> sections.  Make sure they get linked
into .init.data.

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index af1d720209764..91b700e20badf 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -281,7 +281,7 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		INIT_RAM_FS
-		*(.init.altinstructions .init.bss)	/* from the EFI stub */
+		*(.init.altinstructions .init.bss .init.bss.*)	/* from the EFI stub */
 	}
 	.exit.data : {
 		EXIT_DATA
-- 
2.54.0

