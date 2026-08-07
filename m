Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404E451984;
	Fri,  7 Aug 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138722; cv=none; b=YyVDE3GRs6N9qRt2xILm8ot10dVugVbU1uKkzUsCEdBMA6oYyDH3Mhv/KnYa4PWuzYI9iGSgz7TmD0yLCCCmyIetgUhN8WrWccXcV7WMHB7yY3LT9dAezbhOFIAlSP7N391uIEikOTBWREz9Mhba9C1FLERdYILnUys4oVBQk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138722; c=relaxed/simple;
	bh=bXKEGCDiURahuIcWqn7gu0B7fl5MuFihQ3kAmjaVRd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7/ucuXWYGGLJqxSskslYboYRnqcfBX1+U2YpTF/WE5LBCppl4upgepsgMIs9lXmb2t3Iv2LUAdeKZKj2a2IwQFxDC2wa3CRo2zfhbRsuiGHDCuHtKDvMvTK5kMOBAomfa808URbU+EjuNBGZOQ/1vYJgQRNb7Itb2AUS0U+I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP8Zcy2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP8Zcy2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA311F000E9;
	Fri,  7 Aug 2026 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138720;
	bh=BqeFykBVHZByMoJTH9yxSh/5uI8akOGShaiCSHB7jhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GP8Zcy2bMiiezdGo2WbdbcBoK8dmjgDRBzg2M02DLuhGAlmPs0+8XtOquN/hdRapo
	 ILf/MYvWHPnP8EEiBO5IQE4SjgbpS9fZ3Rr+nXNlGZ4xaTuRsTAyo39Ur1iUrZKTtC
	 Km7TMqh1dePg4w7blG0/oDys+13903PEhQdsa+u+qTTxvt03/lP6jQkhLq0U5VnMKm
	 gFadfGIbGXAkpoqUBxkIA5RGa8XqkvaV0ly0okbaG/O2u36gmPW4erqkeaqisWqJQq
	 f6sw97qRWX5i9UVJLStnc5glJqj2yRRiY4qpr1ZPj3lVUwjyxEmCSEkm4/z65VFtJ+
	 SaLqPto8eZ4xA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 4/9] objtool/klp: Explicitly disallow patching or referencing init code/data
Date: Fri,  7 Aug 2026 14:37:49 -0700
Message-ID: <516e14f84cfbffa27dc19d3dcf35097504097966.1786138493.git.jpoimboe@kernel.org>
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

