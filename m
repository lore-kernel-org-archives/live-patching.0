Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42091283FC3
	for <live-patching@vger.kernel.org>; Thu,  5 Mar 2026 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752540; cv=none; b=cE/y/p7d4wXRb+kyLyq8Rh9rwJZTo7mBu3klNW5Km55mYja8o0Rsu5FrsJg9zDD3O8qu4kjYANQgWc5CWh2m+VcNu+XG3/bhITCW2SuiNQju6B0Z8FRVEXrCwr2k45Gf6lvYuQ2PKaTl0PEI+kOuGTo6al4A59BZrVrxONnZKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752540; c=relaxed/simple;
	bh=40k04CmkOe56l+VzauvrvQqzJ9Mw+1Hx+wwF/+HbjOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq+mRCfYR1L7VcdjZab1K6JPoLTWZnSawRsjvPZDBlBSadZkgh7Non3ClC4NLnuXelAjd+HlWXLXO3HX1DJKm5joQs60cjHl+gBeAWDH9ibqYyFCmwJTNmxREvc3gAtfcHE+URQ0FFfjPxyEfnRwi5fSpNZUA7EO1XlrIUXYXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk7/DIby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk7/DIby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048C4C116C6;
	Thu,  5 Mar 2026 23:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752539;
	bh=40k04CmkOe56l+VzauvrvQqzJ9Mw+1Hx+wwF/+HbjOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nk7/DIbyto3echDBLylVjIzooo1glqcK0NgilkwZy+VclVe3+vFqEAKyf4UQa7m2x
	 L319yzHeaHEtXnH4DXHP78551MDGxiLQHcywNEBQlI69T9TWsLslkVhn22V6wSyJKt
	 R965uwMhaFVe9N2iiCaFBs1FBQEwXLnC1U+uDrnK8xLvHuctCMGKsEmzS7gGb0qJ9s
	 KPagYAGuE3Anep88GzNC4CJXCvZM/6vsj3OswqTmcx5NfJjwK2snvkUQSnyqLIdwJH
	 ZIhRr8jZb4JMnfGSC0PdT+8pvO5mzz2PrRkWbVofnmpDGVu2gSPbBqfCx4j/h7wZ+H
	 Bv3xJ31IHCkpQ==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 1/7] objtool/klp: Remove redundant strcmp() in correlate_symbols()
Date: Thu,  5 Mar 2026 15:15:25 -0800
Message-ID: <20260305231531.3847295-2-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305231531.3847295-1-song@kernel.org>
References: <20260305231531.3847295-1-song@kernel.org>
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
2.52.0

