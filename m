Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A241280309;
	Thu,  5 Mar 2026 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681510; cv=none; b=PxKwq3z2Zf+RWZ1aoszHpyLsMAZN2GNEgcGfHwnIAhGj3yQzQFT6yUn7fBIY4FnxkTKkKn+OwbRWTiq8SpI6M4gZ1ORkPoh84BSS2PuB1fjDUeIZ6DdgI5w3SAo8SXhENbu6YXtPwlnrIbJ6i67HOgpUfHbtpEigP8rkMIcOYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681510; c=relaxed/simple;
	bh=5NJSqLWQvTCeEjYLw+cyVI09fAwxwdSEOs9zrhOHrJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yat9/x7Ntb9QVyWztlQ6n969TUZuDAL7je7ZkejiBAz6x/2gTkuEskGfD/zS4X+HZFOx1SjUiHESv4XyQQ6XjNGWiHm/Z4x8LVD+O1iFhHpLxVr6G/RUnCWc6feRWW/uyy1jWmmdJtvfgvs+ngbSrRSfAk+w1FoWijgRFtUYIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtaioH7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtaioH7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D8C19422;
	Thu,  5 Mar 2026 03:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681509;
	bh=5NJSqLWQvTCeEjYLw+cyVI09fAwxwdSEOs9zrhOHrJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtaioH7ZbYcBhZZK3Jp83z+yQIQU1Phpz2iH8jV+jk6PMMMOhry84JoME+vpEjQ3A
	 AzxbTlbjEeJrRK+fkuaGKCoU/5ahlSShNuGHdFUC5mBSDjFb+qgfrQtBSPNr0ttWi/
	 y9kKrz+fYMCZ6i5nn/1EBEVhGd1Tpqo9RtxlMcTu/Kr8Btr25oPRvQbQfFw/vs2LAi
	 +MA3o6OyUeadSngMuz+CA3wlwdg52krarBeNF0WNDchwSxmYeW+QFutPtVMi4EfD0X
	 Alm0bIK9chbCzEUHwpn+q0DKpTeZJAaBNdjOkzITqAVZsdws5hNxAcQsTuOQpU8C6+
	 WTieenc6WUPQQ==
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
Subject: [PATCH 05/14] arm64: Fix EFI linking with -fdata-sections
Date: Wed,  4 Mar 2026 19:31:24 -0800
Message-ID: <f85416e754996eeaaf158143e43eea8a81003849.1772681234.git.jpoimboe@kernel.org>
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

When building with func-fdata-sections, the .init.bss section gets split
up into a bunch of .init.bss.<var> sections.  Make sure they get linked
into .init.data.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ad6133b89e7a..1f5e4f996a21 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -269,7 +269,7 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		INIT_RAM_FS
-		*(.init.altinstructions .init.bss)	/* from the EFI stub */
+		*(.init.altinstructions .init.bss .init.bss.*)	/* from the EFI stub */
 	}
 	.exit.data : {
 		EXIT_DATA
-- 
2.53.0

