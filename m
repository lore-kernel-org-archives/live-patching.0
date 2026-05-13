Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1843A6413;
	Wed, 13 May 2026 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643283; cv=none; b=Q38VxEUR5mm0yS6HawlVWig40WkKiZ6dqtLRqrhZUfcVatAYuWCWgvvKydJ7E2cdIKXg1Wf57Aq3cCZldUaAxAihoJAaSB4Ily69LyjEWSydQtT9Y+QoQ446gb22vnoakLiwB6ShzicMdOJYXlyJ8YlQ4joDdHViD0JC2lg+Mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643283; c=relaxed/simple;
	bh=+/sFHocRcUihmUH6/AgqXb/DZFT8Oa4f5kM+W19rLY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUQfyV9vgTrHD2uhFA18caoXhFawieGVOKs4AteD54Ezonddub4wRcv9YWgHLmO4xQ/r06OodoYRRSmo9TQ2eIC7N4pvOU0lOjAtG97wXJEpYw4RTz3mLu8XUeeF/NDY0IJyLT55oA5gpm3QT6ZuA4ZiwLb9X7DjcdN+N+ANVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnB1C68t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnB1C68t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8234C2BCFB;
	Wed, 13 May 2026 03:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643280;
	bh=+/sFHocRcUihmUH6/AgqXb/DZFT8Oa4f5kM+W19rLY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnB1C68tGrQ+hg40bSzILDRUj87xYxnqRY9/BJQhZg67HOujbCZsCfElQ0oEInBTU
	 7tv8z+bAbnURxLtVLeojl9BGOy9qkqaLXsDZOtgO36wyn9iYQCvWHzCASnC14oQHX1
	 i/M4WTGGdXN3aQ8s+O/Tzs/BsxlE67LVTTOQD+RlxQCTW3kCA5vvBXMwS3BpjNpy/s
	 OP9hTFojt1p8wBP1lKsoY8lmqu6OIiyUwLTUYxOa2+D8EDeCSp5l6qYAwmdlT9bDS9
	 MZ5e8uRti/DPMjq1lu8C8aXp3b0uVbxAOor3Ya4kChgc9DZbQA58zPO3eCsbgJaEgo
	 gewvx101BQYYw==
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
Subject: [PATCH v3 16/21] objtool/klp: Filter arm64 mapping symbols in find_symbol_by_offset()
Date: Tue, 12 May 2026 20:33:50 -0700
Message-ID: <236050080db7b2462fdb13a03ed48a8efb2415a4.1778642120.git.jpoimboe@kernel.org>
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

ARM64 ELF objects contain $d/$x mapping symbols (STT_NOTYPE) at offset 0
in data/text sections.  These aren't "real" symbols so filter them from
find_symbol_by_offset(), consistent with the existing section symbol
filter.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 9d5a926934dc2..a4d9afa3a079c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -159,7 +159,7 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	struct symbol *sym;
 
 	__sym_for_each(sym, tree, offset, offset) {
-		if (sym->offset == offset && !is_sec_sym(sym))
+		if (sym->offset == offset && !is_sec_sym(sym) && !is_mapping_sym(sym))
 			return sym->alias;
 	}
 
-- 
2.53.0

