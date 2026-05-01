Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760030E834;
	Fri,  1 May 2026 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608534; cv=none; b=NisJerC2Z6PLEeuf8x+v2qyjBbnmDr8sWViib0g2yMjI3HMNe8jsJCTsx5jQIQ0aDEtDbvKHN41fqAdh/EXJ/TqrsGH2owH7rUKDrp/hipcePyD/oLlluje7qPwG8vfgqecrZP7v9yEWdgdyvYA8SvxVOrDyZMTML3dk9xJM0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608534; c=relaxed/simple;
	bh=2+H7JiSFT/KZm+ogeaf0AbpRHFZ1id0DN/+htSs4/xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jewkoGhDTugMo6fT0YrekVARyM8YgN61fqGJsU96QPbSBhE5AiO7Ge5I8MX15gB0/mJkRQe4vIH7JFqnFQ29GsErj67o1JH1E3eDotmgpMiWSmpwneT07Px1XFqsK40J/DJ1GVOVZXvKqM4re3as23vZVbNalZJ9itIFhs7fqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW51tNMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW51tNMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7702C2BCB9;
	Fri,  1 May 2026 04:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608534;
	bh=2+H7JiSFT/KZm+ogeaf0AbpRHFZ1id0DN/+htSs4/xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MW51tNMtda3Jcu9eGQWDhzA7ErZ3mlu/D655hdJhwEYChzSvaMPaL+QRPd6JAnCS/
	 Pc16+Xnr7jo0R0Sz6xbuWPIsdrE49/ydeYZuAU4U+TPsBEzOf9Wf0fQOqSxcLpUIlr
	 XIbM6y3gPmdLFfLWrvBpsv54fNTdjsmfRtOLQBnajNzsVU7zpv3Sb5+Bws9bFOVRz/
	 3Q28i92LqM4BqQ4G6sbODhH1F9R0vTyz4YHSZvnZNvbZBkFg3Kp1T4M+/ZbRc3fPhD
	 k14trMV5gmc9OeWvTp7MV9ClbROajHR4DWMhjts3zBcnFL9ub84wMZl1cCvzUyJmeY
	 3UklL6gGkmkRA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 08/53] objtool/klp: Fix create_fake_symbols() skipping entsize-based sections
Date: Thu, 30 Apr 2026 21:07:56 -0700
Message-ID: <ad074fcd7689cd025aa1428fbcefdde8f50d8485.1777575752.git.jpoimboe@kernel.org>
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

From: Joe Lawrence <joe.lawrence@redhat.com>

create_fake_symbols() has two phases: creating symbols from
ANNOTATE_DATA_SPECIAL entries, and a fallback that uses sh_entsize for
special sections like .static_call_sites.

When .discard.annotate_data is absent, the function returns early,
skipping the entsize fallback and silently allowing unsupported
module-local static call keys through.

Fix it by jumping to the entsize phase instead of returning early.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Assisted-by: Claude:claude-4-opus
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index c5d4c9ed8580..0653bf6a33bd 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1374,7 +1374,7 @@ static int create_fake_symbols(struct elf *elf)
 
 	sec = find_section_by_name(elf, ".discard.annotate_data");
 	if (!sec || !sec->rsec)
-		return 0;
+		goto entsize;
 
 	for_each_reloc(sec->rsec, reloc) {
 		unsigned long offset, size;
@@ -1406,7 +1406,7 @@ static int create_fake_symbols(struct elf *elf)
 	/*
 	 * 2) Make symbols for sh_entsize, and simple arrays of pointers:
 	 */
-
+entsize:
 	for_each_sec(elf, sec) {
 		unsigned int entry_size;
 		unsigned long offset;
-- 
2.53.0

