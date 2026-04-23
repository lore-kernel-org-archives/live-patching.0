Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D313D5250;
	Thu, 23 Apr 2026 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917071; cv=none; b=BQ2C/yMHjnzcMaQsE8+MKip4ZTKSvSyDzxOLHqXG8Jw2HstJrCeZnjqAuRzcsEiTmCzCaZCi2X5R6Kl0fvdZz/QqBmQh150DYtJft3yzkbFHf4oEGzrViAQ8S8cpeUCkY63Iwv9eo6BqPQF893tIExX51UBV3cvXkkBeyTMaxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917071; c=relaxed/simple;
	bh=pytJZpJjyK7ja4MgCp5b2WBjImBrrXu1b/o8kx/gZ/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8ixqL0BJSYNXt8u3qtZ+7wUWef8ruPPXEwi3AfNGygD8iJKOJ1GXGdl8oUZpLATDM6LliN/0R2Be5Xg3ZFBvnrrNp8hVO1vsS/WUCcARNw0wEPY/e1oNz2usGLlIv5ebo5T2DSGHggnSK8D2oI1azE5/0z1YQF4IDvHNbV8Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxspzcl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxspzcl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CA7C2BCB9;
	Thu, 23 Apr 2026 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917071;
	bh=pytJZpJjyK7ja4MgCp5b2WBjImBrrXu1b/o8kx/gZ/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lxspzcl4uBH0BHsHMPKftU4YmHtENPHM7XiE8eeYp9EiBJrlqUwKa3JnmTkntP+vO
	 ELpR6A6aG5UZlcS9YgPrp5Pf3Z2jvWlQEKCKQwQEPgJXdfPBKhiFyfhp/qQM2SpkLW
	 d0T0RliCgh7p/cKnMmIe2vcMIf8QZfX7G2BjxJ7l7cxmNn6CqZbVapuC4uHrfz00V8
	 vlTBFpmwaXaTmSPPg1t4ETBbac8ZMn/7a/U9JbwzboGJ8ShSeUqgXFlU0Ab6JhM2UI
	 tDLMV8Ld7rJ1Q8SyWgD4V7vjtNWtkBK5mj2Pf4NrABN5WIPtQ/7OKIOzE23eMVlkO2
	 MYquJYvETaSmw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 15/48] objtool/klp: Fix kCFI trap handling
Date: Wed, 22 Apr 2026 21:03:43 -0700
Message-ID: <2022e064d670290bfc4ce96207c64b2282d39959.1776916871.git.jpoimboe@kernel.org>
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

.kcfi_traps contains references to kCFI trap instruction locations.
When a KCFI type check fails at an indirect call, the trap handler looks
up the faulting address in this section.

Add it to the special sections list so the entries get extracted for the
changed functions they reference.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 22942f394745..a8b9a1441e7e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -296,6 +296,7 @@ static bool is_special_section(struct section *sec)
 {
 	static const char * const specials[] = {
 		".altinstructions",
+		".kcfi_traps",
 		".smp_locks",
 		"__bug_table",
 		"__ex_table",
-- 
2.53.0

