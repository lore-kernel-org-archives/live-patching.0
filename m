Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3743093C1;
	Fri,  1 May 2026 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608533; cv=none; b=qZbwseBSe1BayL+9TrGzGQ2mpiz9734tHuiA391KpfWyFRFPjcaHwDbnm8PKvD4CqBaX0udZM/GGkswEsa6rSU5a2/wp5lVrNcZdFoxAsLoUpZc7UaW4ZKDecBR/GZlZaRhEKTo/BjydI48WVLQfrL/FKm+/c1oKLHmFrixXSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608533; c=relaxed/simple;
	bh=kx/DM46jLcl46ytKU6Wkkwpr6I9x6N6yRUUppki+X3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq+MQD9FcoU/6t3yAkATnEgaf8oPSc7mz4XWctbhcXefsMLHGKMZCzJVolsS0E0/JGKWc3t7mzrQuEa4JHCDRzwiCCcsmxiUsLNB2Pc3TFgERzktYdI5UrZQk3Br4PU0jdC1RGsCaY556r4rM6DvcDegcJxdVeoHnDvWw+tEJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug0zvKh6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug0zvKh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD12C2BCB8;
	Fri,  1 May 2026 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608533;
	bh=kx/DM46jLcl46ytKU6Wkkwpr6I9x6N6yRUUppki+X3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ug0zvKh6CIa34t0ye6V1PNLzXcSWy1w/8P2OC1UDNeOvVNDHwKKPAPodIw3O7zfqz
	 hxH9uCuqSuAsZaZXQV5SJbMi7MVrfRKb7EF0lrNgAMw2pyf5TPc8Y1jahyVCoxQN4l
	 9/WV3OUHwoKcVpHYk0Z1J9OWWRBpDB1OqX+44gwsfRmDiYgBe3yWTgnkaMe2wkC1Vb
	 rlbTIr53mynppupYqMH57SQYOK4hx/1d8Om9HWPxZmQ6JmhSfpT1X2GO8jHk7UNCx8
	 UQHcPGwDELgKXP9tVnYOpuEb05gdFFIxhTEcgxHdRxefY0m/I02vBhNSDuf/m3W4Ac
	 RH8weLN4kGjmQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 06/53] objtool/klp: Don't report uncorrelated functions as new
Date: Thu, 30 Apr 2026 21:07:54 -0700
Message-ID: <8709eeaf528ed434a5fb1c2056927bae6ceb473a.1777575752.git.jpoimboe@kernel.org>
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

Clang LTO uses __UNIQUE_ID() to generate some uniquely named wrapper
functions, like initstubs.  If they're uncorrelated, prevent them from
being reported as new functions and included unnecessarily.

Note that dont_correlate() already includes prefix functions, so prefix
functions are still being ignored here.

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 4f668117c45e..ccb16a45107e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -802,7 +802,7 @@ static int mark_changed_functions(struct elfs *e)
 
 	/* Find changed functions */
 	for_each_sym(e->orig, sym_orig) {
-		if (!is_func_sym(sym_orig) || is_prefix_func(sym_orig))
+		if (!is_func_sym(sym_orig) || dont_correlate(sym_orig))
 			continue;
 
 		patched_sym = sym_orig->twin;
@@ -818,7 +818,7 @@ static int mark_changed_functions(struct elfs *e)
 
 	/* Find added functions and print them */
 	for_each_sym(e->patched, patched_sym) {
-		if (!is_func_sym(patched_sym) || is_prefix_func(patched_sym))
+		if (!is_func_sym(patched_sym) || dont_correlate(patched_sym))
 			continue;
 
 		if (!patched_sym->twin) {
-- 
2.53.0

