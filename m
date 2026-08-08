Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7B37DAA9;
	Sat,  8 Aug 2026 23:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231123; cv=none; b=reDQ1gPBNQ5osWaiGTibxsdt+ou7QZXZOpjLlPDdDiHcfoC3hxElkLTzA+wnujxACofoK06AoiZe3iD3gQJOVvoe6rWX5JOiin1OlgI5CzoXmyOYSGwjdGrY2oCA8LHXOE4dnrUUqKoWZvHI8lRCG3mF+1jXcgA7QTCTf42RtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231123; c=relaxed/simple;
	bh=XvQzrveZy8keOwU3dsD3MwA/DM/UEranRTFFfT4zB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhurpoVK7U5lJKefNKOW6uOMcfosMGmXnoYFOMD+mpRenjnebaj/Y364R4Y6qp0BXPJCW7cDZIQ+shbghyKDS3WKHlq9TtK/LGxQcnN+5ELrp7Uhj5Ywza79OAVB0qgKHghLbpm6Fp/YzQYbZM9sf4RwWLfe5fIPm8FzLVmgARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6z/ksTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6z/ksTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94161F00ADE;
	Sat,  8 Aug 2026 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231119;
	bh=86Wu1e1fcjC+Q8R7XTOaEvr/qEDKKmtBvafngqJL0GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6z/ksTtDqX8xK/Pg8CXwXiVstVJiHyhOq+A/N0C9Xf/FjsMOM0cvO323+zp7/9M4
	 kPZQ/1VUQV++1ZdNOa6TlleV5cGCZ9bfhhMjI/Art7YBB1/INMBdPpqVVmgsvvk9Xp
	 kF69ORpK31ONF/4wWNWYFxA2u93421BShKk2qf6rK3sn2ZLF9Y57uJr/IODREruh9w
	 yn5f+eLZYRvOq4/Nye/KvOKkvbFhl1P1P7qFeicOpolMjQMjk4I0pta8L2WnGGbOEd
	 fev60tWWdcWzGOOlAkzJ4C6hLSisj4awzKqmkTiZGkmWIVTZwXAv4bJB1cP+hS5bLm
	 2al7Qa9FiS8sg==
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
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 17/22] objtool/klp: Filter arm64 mapping symbols in find_symbol_by_offset()
Date: Sat,  8 Aug 2026 16:17:21 -0700
Message-ID: <9b74908379fb4054ff30a7e0960606baec08c555.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
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

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 180e0a0da00ff..f9d49325dbe0d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -160,7 +160,7 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	struct symbol *sym;
 
 	__sym_for_each(sym, tree, offset, offset) {
-		if (sym->offset == offset && !is_sec_sym(sym))
+		if (sym->offset == offset && !is_sec_sym(sym) && !is_mapping_sym(sym))
 			return sym->alias;
 	}
 
-- 
2.54.0

