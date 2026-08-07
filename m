Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5A42376E;
	Fri,  7 Aug 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138721; cv=none; b=A6MOUTGuq+cGmb/PYgeQSTNsTj7cymTGzCTGP8pByYl4baPz87Xu8dtP3xjK2RfkHPcNydjv8p1kxY+zmm4I47d7LkGfPLi6Dt0A8D1B+wxvNOcHTHSXh2bQNXXYgC3Z42kIMbZM57EHd1Pd8foyIbux41nag8jGFIz7Ve1CYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138721; c=relaxed/simple;
	bh=+BzvaZZkVfJk3xOhpsyMKt5MWHinWb0UZMOk+WFSg8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVFUTSFRftZb90v6lhL2GUPtogAIr1fT1tnFR7bqXzcUfEHo5qMVDWoC9iNGu+FZxgNeButp2wqqp2/c4kY17IDsj9WYHb0wDwX6w0HYFaovOoowBolsoTkC6N8nJCckP4vDwJJzftRxKvOY2tkJm+Kzt18ikosZFbOktoMhYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKqaPCb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKqaPCb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB91F00AC4;
	Fri,  7 Aug 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138719;
	bh=5YxbHzQFTHjQ5H8M6FCESecxFZ6y2bsJGH2Pqky/X40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKqaPCb2e0xiWM2sLiAhdYmtNmUIDjnw3U6GlIs9RItkDz3Vu+Q7SjXVWqN/FtwM0
	 PGf6tvMV/Vj6D6aLMeX43TDyNrejA55Q7GQk2JWZB80fc1tKhKe0+5SKDCydzya7hp
	 l/+tLJLYiQGdzE2ZqnbheqK+r125FBRMp+qR7isMusHc/Wulrw2BZya8LKU7uJBRGm
	 TwiLzE3IzKAHredH1j2hjPpXV2qv5PEx8MFggJewO2llp+bjl3OgDQ+YnEPqMymlOP
	 D+N6rLCXdY473fXy1M7PXRpXkAnsUBG4AGWwQ9JU96rHDX6D/HkuBb+rW7CzO9mq2d
	 58JueAT+eZzPg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 2/9] objtool/klp: Fix size of empty special section entries
Date: Fri,  7 Aug 2026 14:37:47 -0700
Message-ID: <913e691c5009397df832c7c9a18cd5cf71b42737.1786138493.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786138493.git.jpoimboe@kernel.org>
References: <cover.1786138493.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_fake_symbols() sizes each ANNOTATE_DATA_SPECIAL entry from the
offset of the next annotation, falling back to the end of the section
for the last entry.  But the last entry is detected by a zero size,
which also happens for an *empty* entry: ALTERNATIVE(oldinstr, "", ft)
still annotates its zero-length replacement, at the same offset as the
next entry's annotation.

So every empty replacement gets a fake symbol spanning the entire rest
of .altinstr_replacement.  That's harmless today only because
find_symbol_containing() picks the smaller of two overlapping symbols.

Track whether a next annotation was found rather than inferring it from
the size.  A zero-length fake symbol is fine: find_symbol_containing()
skips those, so the properly sized symbol at the same offset still wins.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 492d7a012cffe..38fae861d12c7 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1627,13 +1627,17 @@ static int create_fake_symbols(struct elf *elf)
 	for_each_reloc(sec->rsec, reloc) {
 		unsigned long offset, size;
 		struct reloc *next_reloc;
+		bool last = true;
 
 		if (annotype(elf, sec, reloc) != ANNOTYPE_DATA_SPECIAL)
 			continue;
 
 		offset = reloc_addend(reloc);
 
-		size = 0;
+		/*
+		 * Find the start of the next entry so the fake symbol size can
+		 * be calculated.
+		 */
 		next_reloc = reloc;
 		for_each_reloc_continue(sec->rsec, next_reloc) {
 			if (annotype(elf, sec, next_reloc) != ANNOTYPE_DATA_SPECIAL ||
@@ -1641,10 +1645,15 @@ static int create_fake_symbols(struct elf *elf)
 				continue;
 
 			size = reloc_addend(next_reloc) - offset;
+			last = false;
 			break;
 		}
 
-		if (!size)
+		/*
+		 * If no next entry found, this is the last entry, so its size
+		 * is from the current offset to the end of the section.
+		 */
+		if (last)
 			size = sec_size(reloc->sym->sec) - offset;
 
 		if (create_fake_symbol(elf, reloc->sym->sec, offset, size))
-- 
2.54.0

