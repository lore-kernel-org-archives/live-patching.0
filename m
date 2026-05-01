Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD9359A94;
	Fri,  1 May 2026 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608545; cv=none; b=p+LaINcQZ1GZ+LZG8qLLRK8cnZkx9ggypE3O0xV9UHIYJy+oiQwZL6GNL5oLxsOKOC5i3O1dyJJIUoAg0241M2/1MmdXDf+YttNeschl5LnV+VkuYxL7gNTkXoChbwfkFC4FQ3K3IeD8iXmzeWKTrdOam2heqQL0h3wljVhLwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608545; c=relaxed/simple;
	bh=6jE4uMMHkB1mOztBVCv0yYQ2rdykfzMXfWMb8wecjjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJfwtQgmZ5asqvQ2Iwjp7O/EtVqMcG75h4FnTPCUZbbqSQlnu5ADkmjzerqUHZbWYnoDOgteSJoGssD27bQAdbWLRnwt8BQ4eZDSqHp91SQP3AfsALm7VW6hbJIJFzuNNNZZcs6Ud3/7SG1cld0HcCkxayqJDFrgv+kr3LKY47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeSqdBRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeSqdBRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75593C2BCB9;
	Fri,  1 May 2026 04:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608545;
	bh=6jE4uMMHkB1mOztBVCv0yYQ2rdykfzMXfWMb8wecjjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeSqdBRvDbQ4razru/Lqyx/m/A0iPPvj1Q0InlNU2tF0lzWAIxcoNP7Hc3NbE+/pz
	 X6+Fp56g2XhB7cwwaCHxXnyh0Bpx4D1ZPrqJsLCTfo9S1zsQfpFONLOYdE0SZ1XWOe
	 edRQx/NGA/R0gfOvH2QUM3XuOXogBHwzkeOOmGEtcvkvO0CwAonffCoNQlaN1rPVm7
	 czisz9y3y2hx0XyuHCwrxzblIQVWqI8wi4pU+Q+3cCr7ip8/YhC8h+ZtGIIFm4VSmD
	 KBWwNsfJJmmqZ5XJffrZ3Fi6Nu9i94o8CSklHVwT33geKGohD1MDsfnohrlSHk989Y
	 O09gnPGr+ExbQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 33/53] objtool/klp: Don't set sym->file for section symbols
Date: Thu, 30 Apr 2026 21:08:21 -0700
Message-ID: <d44d6a8f8256c9d3896bf531050c969cb15f2661.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section symbols aren't grouped after their corresponding FILE symbols.
Their sym->file should really be NULL rather than whatever random FILE
happened to be last.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f41280e454ca..d9cee8d5d9e8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -649,7 +649,7 @@ static int read_symbols(struct elf *elf)
 
 		if (is_file_sym(sym))
 			file = sym;
-		else if (sym->bind == STB_LOCAL)
+		else if (sym->bind == STB_LOCAL && !is_sec_sym(sym))
 			sym->file = file;
 	}
 
-- 
2.53.0

