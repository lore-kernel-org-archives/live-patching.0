Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5B3CCFC8;
	Thu, 23 Apr 2026 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917065; cv=none; b=vBLiZeiYJZAFnIiHpAqulbB+VMUxrKgGVcKsTnKHrQlfVwB1gJNFiz6M1xD1AhB87afdB7Mn/h5Jgq/h3ABai/ZTTCC1GJvOfbpnnH0EkT+jHgEBS40Q5FOS6y3E07gkxEc8au64s80ViPS8kRbqJwF9OV1nZtF7MvZPjS+WD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917065; c=relaxed/simple;
	bh=cyERcQW1CXamUSzBO/tZKHzPR2DszRUAPYcixAswNfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgZ72xYeloO0EJYSucd4EfA4wiiK30D2C49LpyG6AVKcH29FD35nkZ1TdXqrI1rdnRM6IXJbwELZ1exTg7fEOyKtQE3dOx07u/Alp7F6h29+zdXp3KeCiftMcyx8dQYDtwSVc9z9JptwkQ9E1EaOlnHWSAB7dyYRm43ET9HEwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huIztDtu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huIztDtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C354C2BCB6;
	Thu, 23 Apr 2026 04:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917065;
	bh=cyERcQW1CXamUSzBO/tZKHzPR2DszRUAPYcixAswNfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huIztDtuAgkDcSUuO04FF1F0vDM2AEATe9A4j5P9HhRL5Z9FIMQdWcedoudB5hHHE
	 uBMTr0hpINH7OmhdN//sKqABUAiTTa3qZrn2grLsk4Kt0dEIJOr1IKZg1njVpUUhWb
	 CQd/1pYHrGTzorixy4AtcL5uog1ZWfxrtrWZ1rUdMi52zOEw55wFq2aPhhTUuPEIQX
	 FLeYlH67sBpMDMN+qSIiwGKkg8GUPnzIwdog53PRa/i2qHh5kNBQ4NSExuPWWpPvE2
	 Qes9Y+F39/jkWh7d8X7ZUxMQCDZOV+JqSKdXSQlXhxYTbGXIQvCzsEfuL1TJJGO/zf
	 i6r065urYF1Mg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 04/48] objtool/klp: Ignore __UNIQUE_ID_*() PCI stub functions
Date: Wed, 22 Apr 2026 21:03:32 -0700
Message-ID: <93c7c80130375edd22874a57cdea132b0edbb0e4.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Clang LTO enabled, DECLARE_PCI_FIXUP_SECTION() uses __UNIQUE_ID()
to generate uniquely named wrapper functions, which are being reported
as new functions and unnecessarily included in the patch module:

  vmlinux.o: new function: __UNIQUE_ID_quirk_f0_vpd_link_661

These stub functions only exist to make the compiler happy.  Just ignore
them along with any other dont_correlate() symbols.  Note that
dont_correlate() already includes prefix functions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 36753eeba58c..ea9ccf8c4ea9 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -786,7 +786,7 @@ static int mark_changed_functions(struct elfs *e)
 
 	/* Find changed functions */
 	for_each_sym(e->orig, sym_orig) {
-		if (!is_func_sym(sym_orig) || is_prefix_func(sym_orig))
+		if (!is_func_sym(sym_orig) || dont_correlate(sym_orig))
 			continue;
 
 		patched_sym = sym_orig->twin;
@@ -802,7 +802,7 @@ static int mark_changed_functions(struct elfs *e)
 
 	/* Find added functions and print them */
 	for_each_sym(e->patched, patched_sym) {
-		if (!is_func_sym(patched_sym) || is_prefix_func(patched_sym))
+		if (!is_func_sym(patched_sym) || dont_correlate(patched_sym))
 			continue;
 
 		if (!patched_sym->twin) {
-- 
2.53.0

