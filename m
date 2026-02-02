Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577B219FC;
	Mon,  2 Feb 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058822; cv=none; b=oeisn25fIL3DJRzZcyiiOxaR81UI7AteaVxhnvWTn5VkNUOXcN6s/w6Nn0nQxkLDrqaQXNcg59GVR+lKuYCBS3qhnMCdwZbMrg3qsPpixFQKvKLLYFYfbFnpeZVPCIGJ4zSM8kYzCxZOIa38olNNadPUoUmtM13Zae9Zab5DxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058822; c=relaxed/simple;
	bh=bxaG7klK7qfsH3deazaAsVe6aInN21iIFN87DMJsuRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FN63E/TtACEfy2nx8c0AblxSNxudvzFj2WmKx+iRjM3sSZ5K1LpNcvDhx9HErSXV9GAXkzhhT4QhLq7JAJ57ciIqr7pzSVY9/LfUwlwpaJWasHT34KVVcKuhdYMGWY4esaxe7JcS/5ryFa4/lzdYLDpCBBjMbaziJiBj2zQTP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atvbiGx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atvbiGx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDCEC19422;
	Mon,  2 Feb 2026 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770058821;
	bh=bxaG7klK7qfsH3deazaAsVe6aInN21iIFN87DMJsuRA=;
	h=From:To:Cc:Subject:Date:From;
	b=atvbiGx/ddIHfq/a6NalFswC11VAMyFwHmj+aMfHlVGCVIJ4t9khriuXrYpq+pbRl
	 t/LNt6XEkKhOGDVYDt4TCatZ366UGm7c90ROPnjLvzws7jAvyx7d7Wb6C/OfML4onJ
	 c4HAeaQauJySScb5NRtFFvY/hV2eOJQ8qqyUGhNRBBCr/3EZ42NJSeWwKU9LQV7sqI
	 eJdBZ7xwEj6Gos9wplboy79XHSxG/3cbrdqgNh83Z1FHiLTdyOuMQjB/+s17p/BIyq
	 F6nZw3nS66xvANziZEOmE6f5Akk7BUUnSCj2hireTsZpCgv60zT+0SRYL23RAeuw8Z
	 7aYxguV7VCpTQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] objtool/klp: Fix unexported static call key access for manually built livepatch modules
Date: Mon,  2 Feb 2026 11:00:17 -0800
Message-ID: <0bd3ae9a53c3d743417fe842b740a7720e2bcd1c.1770058775.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling CONFIG_MEM_ALLOC_PROFILING_DEBUG with CONFIG_SAMPLE_LIVEPATCH
results in the following error:

  samples/livepatch/livepatch-shadow-fix1.o: error: objtool: static_call: can't find static_call_key symbol: __SCK__WARN_trap

This is caused an extra file->klp sanity check which was added by commit
164c9201e1da ("objtool: Add base objtool support for livepatch
modules").  That check was intended to ensure that livepatch modules
built with klp-build always have full access to their static call keys.

However, it failed to account for the fact that manually built livepatch
modules (i.e., not built with klp-build) might need access to unexported
static call keys, for which read-only access is typically allowed for
modules.

While the livepatch-shadow-fix1 module doesn't explicitly use any static
calls, it does have a memory allocation, which can cause
CONFIG_MEM_ALLOC_PROFILING_DEBUG to insert a WARN() call.  And WARN() is
now an unexported static call as of commit 860238af7a33 ("x86_64/bug:
Inline the UD1").

Fix it by removing the overzealous file->klp check, restoring the
original behavior for manually built livepatch modules.

Fixes: 164c9201e1da ("objtool: Add base objtool support for livepatch modules")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 933868ee3beb..ef451cd6277c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -682,7 +682,7 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			if (!opts.module || file->klp) {
+			if (!opts.module) {
 				ERROR("static_call: can't find static_call_key symbol: %s", tmp);
 				return -1;
 			}
-- 
2.52.0

