Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45E2DFA5B;
	Fri,  1 May 2026 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608531; cv=none; b=p3VyBKBxvLLeIwklS98CcWrWEerdqySPDbB2xhljG0jE06iAQGFjDtsDoo308iF3J+EvXRXgoyWM6ZovcAl6gIXPMi0Zl9dDg1ITs9joUPvkHCgwqNv7oVNhSEMUjyXiKygF1kMQVNyUswn2Zrl5kz7ybzqEYDD2lHT5jmfohJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608531; c=relaxed/simple;
	bh=+60H085Djk62NlTyS/d3jVQprhrQBih8YD1olXS3z6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+IhmuPbnsOsBHFAiGHjFXQ2hlkE4vSjlM+KVLK6hw7Ts6vECpmEUrg42/YxVXUOGW7CaVRA8p7hbhuepPOwUoaK2artkbgHAMEtrXG05Y8Yz6g3r5g3vHhBrXwo+1GahwRHj9GYnUCAYQ2mMZolK3Qlz9M1YCEO/ftVvBTU43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiQ96GQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiQ96GQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4FAC2BCC6;
	Fri,  1 May 2026 04:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608531;
	bh=+60H085Djk62NlTyS/d3jVQprhrQBih8YD1olXS3z6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiQ96GQirQzajAaxPudNAR2OzQ1mWgCohph2KSmLudrfVWSLlIkLsaUhqGr3KC9nv
	 1B4XwpCcAl1BsI6PrVxJpedB4LnWp4GVZRe0ysbLW3ypxS4kPyt0UuBYR7wdErNL7q
	 Cgql/2O3k245aVzIp6bRLJaDuPKLC6XFQj9qSUTynNNHmyqaHvJJlTbTo26NFFPiTq
	 fcLz96/VuxQbYNtr49u9HQGtua5ztnRZyTGHtjH2OnEOp/GXaHC+BbpUrIYZicYWvv
	 f4P4OLu2aZZ3C2L1jlsuT8HPBz2BaeAmnXC1J898hoemiTKEaEELBgNqewstsh5mFt
	 /vQSZCetPYZlg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 02/53] objtool/klp: Fix .data..once static local non-correlation
Date: Thu, 30 Apr 2026 21:07:50 -0700
Message-ID: <2b864105c4f0d5c58006ec43f6ddde1bef2fe250.1777575752.git.jpoimboe@kernel.org>
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

While there was once a section named .data.once, it has since been
renamed to .data..once with commit dbefa1f31a91 ("Rename .data.once to
.data..once to fix resetting WARN*_ONCE").  Fix it.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b1b068e9b4c7..cb26c1c92a74 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -257,7 +257,8 @@ static bool is_uncorrelated_static_local(struct symbol *sym)
 	if (!is_object_sym(sym) || !is_local_sym(sym))
 		return false;
 
-	if (!strcmp(sym->sec->name, ".data.once"))
+	/* WARN_ONCE, etc */
+	if (!strcmp(sym->sec->name, ".data..once"))
 		return true;
 
 	dot = strchr(sym->name, '.');
-- 
2.53.0

