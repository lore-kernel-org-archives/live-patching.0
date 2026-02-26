Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25811F7569
	for <live-patching@vger.kernel.org>; Thu, 26 Feb 2026 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067302; cv=none; b=uS3ycIuAoQT8rvHt9tvI9gbST1sJvNgNyntcNNiu0U130g2D7UbL6Fg8tDMOdHHa71WHeGjaqNLfosODSRArR0siOGnAaHsKmfqXgGM0ULoQOUEJplW+bcVViZ2T+5t1PAHkVwQm/kk+YWzLFxRpFCqjJuIcBz2ebn1mWQPPfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067302; c=relaxed/simple;
	bh=TLhRd3kSS4Cp7cPZphm+Lh5Lq6UmY3aYlOZ/EPRQil4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXs22TDN1KUbSVWS+vX8erFVYIUdMb+iHY2YSrXWUNMwlhxyq1+cfRb1e1HiFkP4Cs4OxRQ5Itc9jf7PfQCcs9pKtMd+qCWqSzSLkv87H33fiJ+yjR/Tt4o2+Ry6C35ntvXr9dEpDbD5ruNOLgRAqyv8+RrvabVfbknFfD9pi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je7meIfx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je7meIfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89957C116D0;
	Thu, 26 Feb 2026 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067302;
	bh=TLhRd3kSS4Cp7cPZphm+Lh5Lq6UmY3aYlOZ/EPRQil4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Je7meIfx08zLOgG+8i3sXa1BQ8xPi7/6O8B1p78ASArJGOwB4yqvRKJBj793Yyvkp
	 sefAu9TjjESlvVOTPW2tsRuBrk7otK9vOu5bf1QzkxRCLorHflloln4heNgNnRkeaD
	 tGdsUT/Gj7wKDfu3Rc/ib0xFwECfNlYeMlyODDA1Ucl1uF41Q5asCm+3bWj9zmApOd
	 9epyaVCNIUa8P3gHysiVIXTHxyj6SWMGJePmu4QYv9CkxU1OqM+rLbst0/1paveHzh
	 qsgH04en4rW/arcm67sk2azBUaLSIzq0xzVsEuXbHO5Vc5twFeEaLuyZZ4csegnDhN
	 hY4EzIWx/vkqQ==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 4/8] objtool/klp: Also demangle global objects
Date: Wed, 25 Feb 2026 16:54:32 -0800
Message-ID: <20260226005436.379303-5-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226005436.379303-1-song@kernel.org>
References: <20260226005436.379303-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_LTO_CLANG_THIN, it is possible to have global __UNIQUE_ID,
such as:

   FUNC    GLOBAL HIDDEN  19745 __UNIQUE_ID_quirk_amd_nb_node_458

Also demangle global objects.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/elf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c784a0484270..d66452d66fb4 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -488,9 +488,6 @@ static const char *demangle_name(struct symbol *sym)
 	char *str;
 	ssize_t len;
 
-	if (!is_local_sym(sym))
-		return sym->name;
-
 	if (!is_func_sym(sym) && !is_object_sym(sym))
 		return sym->name;
 
-- 
2.47.3

