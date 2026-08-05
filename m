Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861F3515CD;
	Wed,  5 Aug 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940212; cv=none; b=JBLB+QNizpX599Ld0L9Pvz2YdFiEv3Y6C18Zhc0qulVp3lArl4oAWF5q3UITNz49+SyXSxgbMinLbBFwbId+oCepil9pfKNpPt2CJaqMbzWHvIrHmJdseOYDmfZ5hLJ+AlL2Sl/K8VUZw5qZ308p11sTCoKkDoOBzC+nyaPKNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940212; c=relaxed/simple;
	bh=bXKEGCDiURahuIcWqn7gu0B7fl5MuFihQ3kAmjaVRd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhMOBC3uVoHyyJojq5bbymImSgtSHDqsSXp+GGli+tA65lphz4OrDjKQL3//iGbYe8h2V29AaOfuG1HzmcT218wEnBN8SWYkR97Gq/D9hynEEMIohqQv/oGcy9r2LqYYdXCbOFp4HUV5XqHS+idOdUbPA7zCw2zs4U4ucLwOuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U80BA/RG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U80BA/RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921401F00A3F;
	Wed,  5 Aug 2026 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940201;
	bh=BqeFykBVHZByMoJTH9yxSh/5uI8akOGShaiCSHB7jhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U80BA/RGiAXfalmuXtViFIJuTOBIv6/UX1yKW5UCy33YQ0m3b0/ZJvPhz5FRcqc/G
	 5vPE9GaAQfR76E3i5a5t6GuzzJDy8rPI0clsW6997i+qiw0tlzLD+4yYRSb4EDCFgs
	 Tdhx52B2QldipWPwQl5iWMhE5dIKR5MS9BXBy2/fvP+ab+XVZv3l+feWE6fXwK7D8m
	 xp9tNJd/3trxWCDdx8SIeVNPTciLaV1UDc9AzESUVvQLU6VZjh+xmhFwhQ0IVoyggY
	 W5Lf2X+nHWwj59lLlm8aPfLBKNhY6QwnIVCe9+OUYGAQLVajUyMDbGkx+0hdXPEuXz
	 9O2udJ3GXu/6g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 4/7] objtool/klp: Explicitly disallow patching or referencing init code/data
Date: Wed,  5 Aug 2026 07:29:41 -0700
Message-ID: <a8edecfad944523b2b1e294b66c28c22fc50dad3.1785939903.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785939903.git.jpoimboe@kernel.org>
References: <cover.1785939903.git.jpoimboe@kernel.org>
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
index bbfae516d3395..dfca9dd746812 100644
--- a/tools/objtool/klp-sympos.c
+++ b/tools/objtool/klp-sympos.c
@@ -367,6 +367,11 @@ static unsigned long find_vmlinux_sympos(struct symbol *sym)
 	return sympos;
 }
 
+static bool is_init_sym(struct symbol *sym)
+{
+	return strstarts(sym->sec->name, ".init");
+}
+
 /*
  * "sympos" is used by livepatch to disambiguate duplicate symbol names.
  */
@@ -376,6 +381,11 @@ unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
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

