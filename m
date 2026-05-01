Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73762FE582;
	Fri,  1 May 2026 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608538; cv=none; b=Y3MUA+F8d+F6uY3ox9EN+AVpDiZ502Vc3I6DEbrdYXaO4eNz9tdK7Wl3cJvgQXM5wfN51AhKNrfqO+vStrqU/Udc8EAtv0wF4MceGtlZwsbeCjQjxRcj7h3KGE/k+PGRo6v9cES0C5Z+eNDNmMA0w9PFXTg6f/pniHrnE13cz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608538; c=relaxed/simple;
	bh=Thr4wxf4FdYm4riP7kTt4KLaS2jq2dvObY7uSSp6BGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV9F51WfluO3a3uLvP6XdA7yZ1A5r36ZsFL2dhnpHeEmguJUaLfykHWzWakY8QYj++orgB/JWWB4wZ+wPkUwsgKCswdB95j9HMh9ojTxWEEPAR6v8MAlGhkySzLDo+y+nn0OA6d94AFq447rJZF6V1F9jHyp6wYSqcYdUkgNYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJyjMQur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJyjMQur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E367C2BCB9;
	Fri,  1 May 2026 04:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608537;
	bh=Thr4wxf4FdYm4riP7kTt4KLaS2jq2dvObY7uSSp6BGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJyjMQurpP7bce3TU0VyQPZ2tPmM4SjR54i0OeNfSC7P839ow9w/sT0FTiZPWXr2U
	 msY4oS0SvX+r1c7aTBR9LWdLNztOlLMoFVpWFjmk6io+Hu5OkFqY6LrkuY5PFDtjHk
	 Wn3LWXSXtmNhzrZWtbdYLIQpZXjBL00RLE9gaL2zXvDCfDzOTxb1Azn6UL2iPyknk6
	 CXc1osdacDmOdLw+91gWAmD7E16orh1hj1xuFwcB0zPJBhUjhEUwVcRstNKceI9A+/
	 GjjmZMHNpVmS4BkemyRZ4MA2Y6qgJijW7cLSNEiMsq1vdPGCYMjiZx224W2DyWmh4a
	 ktj9w+is+bl9w==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 16/53] objtool/klp: Fix relocation conversion failures for R_X86_64_NONE
Date: Thu, 30 Apr 2026 21:08:04 -0700
Message-ID: <00a7102c356daf80ebc8af174aa0c45d3cd56c96.1777575752.git.jpoimboe@kernel.org>
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

Objtool has some hacks which NOP out certain calls/jumps and replace
their relocations with R_X86_64_NONE.  The klp-diff relocation
extraction code will error out when trying to copy these relocations due
to their negative addend, which would only makes sense for a PC-relative
branch instruction.  Just ignore them.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index dd0e51dfc621..19bc811db396 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1033,6 +1033,9 @@ static int convert_reloc_secsym_to_sym(struct elf *elf, struct reloc *reloc)
  */
 static int convert_reloc_sym(struct elf *elf, struct reloc *reloc)
 {
+	if (reloc_type(reloc) == R_NONE)
+		return 1;
+
 	if (is_reloc_allowed(reloc))
 		return 0;
 
-- 
2.53.0

