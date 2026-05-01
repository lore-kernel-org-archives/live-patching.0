Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6813164DF;
	Fri,  1 May 2026 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608536; cv=none; b=kPBz0ky5tTPO9BarRkVvYY0UyrwWOYwUHbkVcT7O3uVGDJ6LvLvtTLPRbvv2GO9NRTgTQMUEVHNAMFoPK9Ivqy0iDL/lV4MTKaXgLQ/t0USCyrDL+qYY8bgPX2Z4RT4KKUgkbFGNgbr3m11mXDJguEhCLCmr36O/mG9GQZkxa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608536; c=relaxed/simple;
	bh=upnZpGO2ehfLykc94uj/fnnF7vh4EjIm6g3kzY61rCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9opzg6UzJAHyPDHDAlQfZ0dmEORABGYb5bhAByJLX31ZmCBlPESUmZXYU7XMDSzny+LP6LPdSVNEBohzJGnnz1l6v33AVjNQokawoXoUY3C6vBrPut8BtMFafL45lpT92Ms7lwVngpKIXoSL22EEDHHC+8WYkYbTiOCls2n/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJeJz4gI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJeJz4gI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03BEC2BCB8;
	Fri,  1 May 2026 04:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608535;
	bh=upnZpGO2ehfLykc94uj/fnnF7vh4EjIm6g3kzY61rCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJeJz4gIUTZyq13n3rF4u70PI/4vp0rzXl97KEjGVjwnoNxHcR/ld3agD6Yiw+nm9
	 RGW6rqKGcCQHYQbjaPlQdDFETkqBEEx4FOaLJuYnn1OdB7aqQ7KxEGStlnQdyXKinY
	 hWysWV1uxF7WBpKG3vXo8CBTBmNfhwyWV9UhUv0j8CxVoZl9bTaKi0fZJRQeQ/f8cV
	 dd2FJZAFQ7qjy0LEPsx9f6sAkCeJVv5BY7qXbsVGP4m7aHmm92B8yL5R4wdXyvMC1l
	 6orrnyUj0s/O4umAs24vQVFCvbb2FY1SNKMabavNg+xVRTGSUVcsZnH+RGxEuEofhO
	 ox3b/arq2fPqA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 12/53] objtool/klp: Fix cloning of zero-length section symbols
Date: Thu, 30 Apr 2026 21:08:00 -0700
Message-ID: <bf04f89e39cee2cdfe039c87c1b6ea72e0abf707.1777575752.git.jpoimboe@kernel.org>
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

Fix NULL dereference when cloning a symbol from an empty section.
sec->data is only populated for sections with non-zero size.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index a226e99948b3..17a6146b9406 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -681,7 +681,7 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 			size_t size;
 
 			/* bss doesn't have data */
-			if (patched_sym->sec->data->d_buf)
+			if (patched_sym->sec->data && patched_sym->sec->data->d_buf)
 				data = patched_sym->sec->data->d_buf + patched_sym->offset;
 
 			if (is_sec_sym(patched_sym))
-- 
2.53.0

