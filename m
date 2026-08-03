Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C5392814;
	Mon,  3 Aug 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727496; cv=none; b=FeELwEQlHQPBjoimMDxnhIoUbhV7XoMsRl+7UrvyRQhSTd7rDsq2t2SVwtNlnFOeJd8DfcHKVYeLG2MYpIUZWFgyzYEiebOjhJ6oon/5zYQ0gFi+rv24nXljO2I3E8ujHMKM/o6s6Q7eiQBUeFJe9kI4vgQzJ1R52r9etz3mC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727496; c=relaxed/simple;
	bh=PuGIeosLNrzN5dfJ1oAkMZpQui+o3DA7pVKICpEQZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkfxggUNR8sOTc2o6cLFaiUUtGKDdB8Od9YZOb/AJZNTGfhjswR/8MeaFT/C5tvAFWbSyMJL7oNNrB0ytANUK5gWViv2Qn/9F+XNH6fYAXl4bNqVq0IjwTzzpxl+OwENzPnD2fppsh9ODp6BmvBHNZxp9OIZHN7gqH8xwwCdJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeDxU+VF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeDxU+VF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DC91F00A3F;
	Mon,  3 Aug 2026 03:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727494;
	bh=c0QHyf3cRfjHH7dzTa7UwEKGKmVjGoKvql1dFCIHago=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NeDxU+VFw7ofIsTFqcyVmGDeOrX0ovoSZbGbRZP128WZ+5TEr7S9tmjg0VO4P+woH
	 BKN+Shk7DFWlJWjKDv6JlEABD/xWKUjfoxmt2lbUbDvkzn+v5vgZbcuzuUqlxw3H5c
	 5hVeka9oqd8AB0cRAvGsZUx9q5VhuC3ucWtz0d4pfLU6974BUMsJJSRKHnvAZfrfVJ
	 WZwNKAIWgcFKEsCv+C2z5UbMrLHACTFxco+JgPsL89CnnvcYrkF6Wi7Y75wB5rQ+MT
	 6Of+aM108lbbU7g18GAeNze0827kWnvNS5peAEuf6avXJAvlH6Sv2ahzgjSKzBPRAs
	 eh0jMXI/7SL1A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH 09/14] objtool/klp: Fix size of empty special section entries
Date: Sun,  2 Aug 2026 20:24:31 -0700
Message-ID: <d0c17b588f120a9b641857de7a5335e9e2618cc1.1785727106.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
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
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index c5284d275207..257e7f924928 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1628,6 +1628,7 @@ static int create_fake_symbols(struct elf *elf)
 	for_each_reloc(sec->rsec, reloc) {
 		unsigned long offset, size;
 		struct reloc *next_reloc;
+		bool last = true;
 
 		if (annotype(elf, sec, reloc) != ANNOTYPE_DATA_SPECIAL)
 			continue;
@@ -1642,10 +1643,11 @@ static int create_fake_symbols(struct elf *elf)
 				continue;
 
 			size = reloc_addend(next_reloc) - offset;
+			last = false;
 			break;
 		}
 
-		if (!size)
+		if (last)
 			size = sec_size(reloc->sym->sec) - offset;
 
 		if (create_fake_symbol(elf, reloc->sym->sec, offset, size))
-- 
2.54.0

