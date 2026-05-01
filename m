Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80D309F08;
	Fri,  1 May 2026 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608540; cv=none; b=t/0wE+fzSjVZ5AnTEODe+pbgqTOw3K+iBp+jA3h47wy0b57AEic9aBpgtvTDPfpDaqefyh3tQpowoSpWQwgL0EcCMqddYdEY9Jy8IJd1alillpl/rkaWAAdP3S3GweoD/P8oVtpOKUYwf1jMBXgvWU1YgKZoITd5c80i2NFrqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608540; c=relaxed/simple;
	bh=zb7hC7l0LCStG+piTMPj7Oc08qllWAq6NyRRgV46RPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/b8MtVHZWGMapML2iTEtjHjW4HNSjjiRBJSjNmTmb4fsm5sGdJSfmABLFvkI4yITy8CemrRIzK/Rax7p8OFzxwrlgLjCWHD68gS5Gn9pgFhxiA8CvdXgsoSsU4nPx0nTRsZaAAb5AGdgkoqUlHqEZHlnhiH4y3v5Z6o2H70hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEA5937L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEA5937L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B49BC2BCB8;
	Fri,  1 May 2026 04:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608540;
	bh=zb7hC7l0LCStG+piTMPj7Oc08qllWAq6NyRRgV46RPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEA5937LiiLtYHr9OrUApFk8IICwU8XWSkRvrQIWaM4+cNG1gBfyUvp6hBl0jtqmV
	 z5qPbO9qTatnd74To8To8zUA521dR8OnrC3tga21KoGcNp8QBTqBVT+25f+dpu0qjN
	 TE+PEtR/13fZUM0Sir/5J9tHkldxl3LErrciJ541VAKr9SB0bmxHmjzo6WrNulV0iW
	 MbA/JtCixtWrc0U9kQDMv6Bo60NWJb33w9Bb/onwuup6REu6kLu1C3f/V8mJUUKShQ
	 GGmHLgLZljNCC7/MZzI71Xy2YR/4iXk2OmozQNT7y7mZU11OV/qfb4n9X4SIr2V7In
	 UTGDYpNEfSARw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 22/53] objtool: Fix reloc hash collision in find_reloc_by_dest_range()
Date: Thu, 30 Apr 2026 21:08:10 -0700
Message-ID: <8f1c3b0616623fa498534b83eb5e8217e0ea44b2.1777575752.git.jpoimboe@kernel.org>
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

In find_reloc_by_dest_range(), hash collisions can cause a high-offset
relocation to appear when probing a low-offset hash bucket.

Only return early when the best match found so far genuinely belongs to
the current bucket (its offset is within the bucket's stride range).
Otherwise, continue scanning later buckets which may contain
lower-offset matches.

This ensures the first reloc in the range gets returned.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 74b873e49d92 ("objtool: Optimize find_rela_by_dest_range()")
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5a20dab683dd..f41280e454ca 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -315,8 +315,9 @@ struct symbol *find_global_symbol_by_name(const struct elf *elf, const char *nam
 	return NULL;
 }
 
+/* If there are multiple matches, return the first one in the range */
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
-				     unsigned long offset, unsigned int len)
+				       unsigned long offset, unsigned int len)
 {
 	struct reloc *reloc, *r = NULL;
 	struct section *rsec;
@@ -338,11 +339,11 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 					r = reloc;
 			}
 		}
-		if (r)
+		if (r && (reloc_offset(r) & OFFSET_STRIDE_MASK) == o)
 			return r;
 	}
 
-	return NULL;
+	return r;
 }
 
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset)
-- 
2.53.0

