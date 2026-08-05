Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3C3845DC;
	Wed,  5 Aug 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940212; cv=none; b=nk8nUo0FsLA//jfm2pvyHmw/EY+eF1QgxVTf8C/fhztPs6638AVZizFPXUwktKZpaXWcJeh+QUXfFXD7eYiYT50E5dNNxmIflm0FB85wj4cJxKyOKbo4BWmTKTS16q+vf/bi1gX0H0bpo2g8+eVDgyHu7rHA+QolQVx74DIGfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940212; c=relaxed/simple;
	bh=Hfjnqjg3aVGCVR3Eelcf74WkYAF0rN8IT5jp2O/gNaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VURTYS/5+UigzklpC3ae995qFnqqve4Fiuhzh6iFE2mg+nwjcvNwDoT5jmHPRDVpJkWKHz14RcIo/L+luwWTWi3I59KSEHKz9wPRW7qRSSRj3tkyhJy43ymTI0mcqPez+GSs1qo0r85au5H8d03+APB1wiW/++to//ZrEgPDyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpuKjjvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpuKjjvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A191F00A3E;
	Wed,  5 Aug 2026 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940199;
	bh=uwstzOpG63diSNCrrN4Jkx77zyzWh2lWfcKJfZYHTiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpuKjjvFT4rywePd+RYjeuJX0u+hsb6UoUk+BJ3j1SPn294C/s8wf2Ji9Ac0ualTi
	 c8rskk5h5K+e9CwtyCiVWLGkbhpmE6YZlMEy4XurDvMQqFUDndku4IVlCTxhruLV3o
	 +tu+htyxCX8YaJNMSksdetXRPIyOfaJE+MGlfm7BB2y3xElOXVcdyFcj5qdwQ3zc/w
	 ZMPzN+U5sOtsJ5Yh4kj9Gtf5WInoqNQgCW1Bfz6rjCW0MNWmqvpSbVRezGNZfcpVBB
	 Vmyj73h40CJa5qOfLhvAEg43vNgY+9oNXl9IDhmBt3nsXqmSLqA1vSDqNYvV1J55Zi
	 2mK7h8wGq7T/A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 1/7] objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol symbols
Date: Wed,  5 Aug 2026 07:29:38 -0700
Message-ID: <18345294f074bffdf734ee6a523968aa7d64ef33.1785939903.git.jpoimboe@kernel.org>
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

