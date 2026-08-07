Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85821415F03;
	Fri,  7 Aug 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138720; cv=none; b=qEVGfnMCIpmnGhuDnOBgymqmorGclJahoW819cttyi19vWA4ovBfTyuS4tnng5x0hRlAp89dlT7Hj9+JVGA2iVgEsX67ESPmSpzZnQk5RULYmxSOp9/LI8HfXcUB8pJSe4q8UtkfUY687DXBwZCu3AQfLlSAjozaawqylIhQZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138720; c=relaxed/simple;
	bh=VXmRrWZVTHFaT7hofHWs3uSAAGiWMDQtf3H3uLLqqQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcxG9hgO7nwSvFyEAxStGPzBYKlz9zn90SNTDjjHOyR43SQ5Rcakfum8AMTAg0FU49+1TZFLY0sasEFjkmM6diL1KBTOsRqGjCNKbgsrMaF8NVCqktbJb45HMspcOPvBzEiJ5vCWKNs9cRQcAxNQLAwRhbPB4y4b++c1uKTGiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/LAlQUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/LAlQUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269361F00A3A;
	Fri,  7 Aug 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138719;
	bh=rUt6locn3ii5lFfPGy35WculRb7UPWo5ZkS+XRT+YPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/LAlQUBSGNbkBk8kNegLoB9psbIVq2hZ/NbKTfn0olLYFc5cff8MbMhT6zhxlmaM
	 NYhZAvgzQhCVR5pfQbssRwF9KsTvngqTuduleVQ6fCFSvAfB8lnAKOorVePywTgQAv
	 LN7cVz9CSi7RQbleoEUaS3ZoiAC1YpkB4grAIYJ5MuKqHpzdPF3oDQ063pMR0J1v7j
	 qb0kPXFizm3WFzBHOePW/Wnf6VMV0gCQKO1J9XLFPSbOBM6RfyIfKxKMNVauxWMOIr
	 iUfXJ7rSjFZ/uX9TdnJJH7N3eqxYKyC+Ay2sxjMa7A+eLkg7lsJDfn9ZlSOiKy8Hfk
	 pevifzF7hK+OQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 1/9] objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol symbols
Date: Fri,  7 Aug 2026 14:37:46 -0700
Message-ID: <5a3cc4cded743167dd0878220201d80f7e48e5d7.1786138493.git.jpoimboe@kernel.org>
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

Testing klp-build with arm64 produced the following linker error during
the original kernel build:

  `__notrim.1' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.no_trim_symbol' of vmlinux.o

symbol_get() puts a static __notrim[] in .no_trim_symbol, which GCC
names __notrim.1, __notrim.2, etc.  Two or more built-in translation
units calling symbol_get() thus produce duplicate names, resulting in
corresponding .klp.symid references which trigger the above error.

Add .no_trim_symbol to the discarded section list so its symbols don't
get symids.

Note this issue is not specific to arm64: it just needs two built-in
symbol_get() callers.  arm64 trips over it easily because it has KVM
always compiled in vmlinux, whereas on x86 it's typically a module.

Fixes: 029223d30162 ("objtool/klp: Add .klp.symid for sympos disambiguation")
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-symid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
index cf188cdfa6079..21d8708013aba 100644
--- a/tools/objtool/klp-symid.c
+++ b/tools/objtool/klp-symid.c
@@ -31,6 +31,7 @@
 static const char * const discarded_secs[] = {
 	".discard",
 	".modinfo",
+	".no_trim_symbol",
 	"__tracepoint_check",
 };
 
-- 
2.54.0

