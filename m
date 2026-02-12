Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E828E0
	for <live-patching@vger.kernel.org>; Thu, 12 Feb 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924144; cv=none; b=EmbiB5yBw4GajcsXYR2698Ns2kIzrbE/BphMQbtLm4J+WYtHK3uK/rmjDs6OzYycvbHK03CAOt1SSGtwHbODAxTW1pyJ7nO4Uwzzc7SQGmdkVPSTT68MkIGzGFYGFdqRxf6LlZuNXX6oR+xx6xelsP8a2bLB3lLEcTUrukiQ7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924144; c=relaxed/simple;
	bh=NF985SuSmn9wmB4vLhm1ef1RmrUrWhw45OEe/IaMNFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkF3pLZ2TDBT3YHMy5cOWZP+hWC2gkW9opStDkGKDH46Q/FutrKkvi2KQpcgcLZfi0jBqkiAbL8Q+vZ6iiqU7xNEQ1D44PFOu4gybsEWTXZhnYZld8lZObZ3MaK+QJbY659YKiEciQtuRxMGlLXh8Jhyc25QZNgdW8rryZhb6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHFceIFc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHFceIFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CDCC4CEF7;
	Thu, 12 Feb 2026 19:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770924144;
	bh=NF985SuSmn9wmB4vLhm1ef1RmrUrWhw45OEe/IaMNFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHFceIFcpxuudh6jo/Aypyt1mtxwzhW1nhOcT317us1DZEjrsqR7ZNAyJ71jHL9+U
	 5+QgDxzexpv7jaEJJIWD0IApSpWYurl1hcx6OeESFH8Bs1QN+SYumzJIwrFudelnTa
	 HeHv+OCHCpTYNAiP/nAR0AqGZ8HlQl4bmQQWa9hveX/oN22RG4fcnURb6/F7aE7AZn
	 tFlcCd08S9tkhKf5Bq9k1e/8zXrs1XnlME94/Mgkuq5xTppvRsOMDqJ4Iq2w/XWCaL
	 GC5yUMye9mo9vZOZyOln9+kKDiwzpH8HrQXTHbyt2Nhj5Hf8qcJM2TJiDrQGGWAwl5
	 SYkNcJnvgLHnA==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH 1/8] objtool/klp: Remove redundent strcmp in correlate_symbols
Date: Thu, 12 Feb 2026 11:21:54 -0800
Message-ID: <20260212192201.3593879-2-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212192201.3593879-1-song@kernel.org>
References: <20260212192201.3593879-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_global_symbol_by_name() already compares names of the two symbols,
so there is no need to compare them again.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/klp-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index a3198a63c2f0..57606bc3390a 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -454,7 +454,7 @@ static int correlate_symbols(struct elfs *e)
 
 		sym2 = find_global_symbol_by_name(e->patched, sym1->name);
 
-		if (sym2 && !sym2->twin && !strcmp(sym1->name, sym2->name)) {
+		if (sym2 && !sym2->twin) {
 			sym1->twin = sym2;
 			sym2->twin = sym1;
 		}
-- 
2.47.3

