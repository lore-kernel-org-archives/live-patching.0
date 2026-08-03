Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020F3955EA;
	Mon,  3 Aug 2026 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727497; cv=none; b=NMUmkp0sO+DnbAZ5JJp2pPKF9vvesaVC+p/QEy9aVrIoMfQm5DZvS7m8ilfzI4VRm3raTRtCKjfaV6XomWmVb+FBtWNNFpF1/qFdY51Uiz9TEkh37dPt78uQzYyAPfLzkvkDD2LuhbqueVdnN7MHHS7oHWiwu+uvW4MS8aaYSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727497; c=relaxed/simple;
	bh=b0sitHEDJCrx7PwDglHA6q7PhKYS+wmgi4ZdRtViPgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gC42SjxTzWcCl48U12WBeuVZ3j9cV1K+ElfXKdqFPzgIEfIriN4Sw5Dd5uLa0R85UbDrVBjjAOiH8k3Wk+SrFwd5bXmhzvhnM2IunVSlSWAXMOg4TVwVlaa1lvRpJu70/r/f/e160BHsqyymEUkuEBjGJpQ6KaBn/gniBu6OVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCdLmmIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCdLmmIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ADC1F00AC4;
	Mon,  3 Aug 2026 03:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727496;
	bh=BbrA5q9AP0CghmcFrzT+3c7jTk5wM+gvdhHzAOQna00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dCdLmmImKzjrSYXcWCjYq4qHD5iVxQgrhNAluSgmjy+Cxxw5sGrlceWnlg3icmS46
	 eKAPb8+MP+bR5eOpkeGw34hxsLceRv/DSjXEU1xpQlviePQQfgA937DNS+hjyPB1wg
	 RfEvHttGD3WHLsIFda+Ni6orBFZBldtWtpNCK4IK609DX5Kyf/pRaVzsqZqueVFEGf
	 uXOXJhLS/FsLxYqBniIqm5Ib4VSkw94ZMdzi5yOHKW5PCswKDyTOYS/pAVdSM1hOnh
	 d9NgPs9qLpSfo2NC3qjzE8iX+OFrxB0ArhCmZlfv1Mau7b4z8HL4VqrLk4cFny+Xl1
	 D6w/e2ngz/G1g==
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
Subject: [PATCH 11/14] objtool/klp: Explicitly disallow patching or referencing init code/data
Date: Sun,  2 Aug 2026 20:24:33 -0700
Message-ID: <e6d81053fe0c1a031d6eb592c2e87262d7262e2b.1785727106.git.jpoimboe@kernel.org>
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

Explicitly disallow the patching and referencing of init code/data.
Otherwise it could potentially introduce some odd edge cases depending
on whether the target object's init section has been freed yet (note
that the init code still exists in the target module when doing late
module patching).

Such edge cases include sympos calculation and the patching and/or
referencing of non-existent (init-freed) code/data.  Not to mention the
inherent differences in behavior that occur when the init code is only
patched *some* of the time depending on module loading order or kernel
config.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-sympos.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
index 34bb8d1971bd..822ac53cfa47 100644
--- a/tools/objtool/klp-sympos.c
+++ b/tools/objtool/klp-sympos.c
@@ -378,6 +378,11 @@ static bool mod_sym_in_kallsyms(struct symbol *sym)
 	return !strstarts(sym->sec->name, ".init");
 }
 
+static bool is_init_sym(struct symbol *sym)
+{
+	return strstarts(sym->sec->name, ".init");
+}
+
 /*
  * "sympos" is used by livepatch to disambiguate duplicate symbol names.
  */
@@ -387,6 +392,11 @@ unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
 	bool has_dup = false;
 	struct symbol *s;
 
+	if (is_init_sym(sym)) {
+		ERROR("%s: can't patch or reference init code/data", sym->name);
+		return ULONG_MAX;
+	}
+
 	if (sym->bind != STB_LOCAL)
 		return 0;
 
-- 
2.54.0

