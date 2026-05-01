Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9A37C0E6;
	Fri,  1 May 2026 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608555; cv=none; b=jmqCYUzLsu8EFi9bQoU+yqonEOdtMJbgbY3wbpLuPf0cN64T+uZ+kijNNCohW6MST/whMlbP7fZuI1PQTYJ2TQ3wC6BMCFrVMUOErEBIPl4Gdld/xbR3rZVrNra/YxHCiJOhQpUOduEzBDvVsKsoHgd6dm4/lVjhhD0CE5Zb58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608555; c=relaxed/simple;
	bh=3Ee18BmC2EF5jPRLr05L4egEX4DInJIDJhkmjz45QV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLjVqx4LRvyZlaifgDxhJoovqeOK1lyifsoiIMbVeS2TaZhebEEcSz0cAYxogueh9o6UG8Z9usm4Pj5uap7SBxoy1ofz/O4tFFCL4LAC2ZOpj76FE6TVXYWUOn20rkORcXir2ePjck2DpAyvITBaP+Uyf1hNdPKto0Z4GDK2tUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPJk0ruk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPJk0ruk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96ABC2BCB8;
	Fri,  1 May 2026 04:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608555;
	bh=3Ee18BmC2EF5jPRLr05L4egEX4DInJIDJhkmjz45QV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPJk0rukZeOpeNbhHRBUsM24NecfFTN9tO44rWPdKI7h/IMit0RRPz/nBChViHcYH
	 3M0VSkig+cX8lt0inU28+wHGgwwwUQYjJbjpjvLMo+yFjlyM/gBvFdp0dCaCkUmHl4
	 FqnAbW3fGKeuGKYjd1+JAE6cmLenqA0aI1FPNmh/xMiI1dcPo8MVBTVscbqCqrDwe3
	 wQY6v2XtrTJdOrSYX66eWYyCsi+9gwY4/BkEMW5Gb/p3bQf12iXdGsvboAfUEIHM2J
	 GOhrrZYJ8NeQmqPHnf2EtqMwVH4YDV1UDQCGN0jDKoMl8Nd+pb/szo6t+cnfCBz7Fw
	 Om76xwpW8zsTA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 51/53] objtool/klp: Fix kCFI prefix finding/cloning
Date: Thu, 30 Apr 2026 21:08:39 -0700
Message-ID: <3a6674fa08e32ea6b02adf3e2de185b8ad99b01f.1777575753.git.jpoimboe@kernel.org>
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

With CFI+CALL_PADDING, Clang places .Ltmp labels at the start of the NOP
padding (offset 5) between the __cfi_ prefix and the function entry
point.  get_func_prefix() only checks the immediately previous symbol,
so the intervening .Ltmp label causes it to miss the __cfi_ prefix
symbol.

This results in klp-diff not cloning the kCFI type hash into the
livepatch module, causing a CFI failure at module load when calling
callback functions through indirect calls:

  CFI failure at __klp_enable_patch+0xab/0x140
    (target: pre_patch_callback+0x0/0x80 [livepatch_combined];
     expected type: 0xde073954)

Instead of walking backward through the section's symbol list, just use
find_func_containing() for the byte before the function.  This works now
that __cfi_ symbols are being grown by objtool to fill the padding.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 305183f30a33..fccf72cbd343 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -539,10 +539,10 @@ static inline struct symbol *get_func_prefix(struct symbol *func)
 {
 	struct symbol *prev;
 
-	if (!is_func_sym(func))
+	if (!is_func_sym(func) || !func->offset)
 		return NULL;
 
-	prev = sec_prev_sym(func);
+	prev = find_func_containing(func->sec, func->offset - 1);
 	if (prev && is_prefix_func(prev))
 		return prev;
 
-- 
2.53.0

