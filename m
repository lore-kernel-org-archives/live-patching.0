Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE90267F73;
	Fri,  9 May 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821878; cv=none; b=DinlQ6CchqgVaZJPW9i9qh9YK283xF7IpwrbZRE1XjBg8GjmjTPuQXtY+FYW7WrnmP3QpGRbO1Aja9xXXJ2lo/5eFqrddC7JF6SJjGZ36UpxcmG/SFAPNOh2uozDU12q+O8ledxUWufc2EOWaiqZPjVVRQOn4E/eKJzJE0FirkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821878; c=relaxed/simple;
	bh=L1LqTskq/WOpKf8Dm/MOhrYquHsVHeNDKUmrpvXx9rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkoyvokrGfLM4KLxTPf9ph0EesCUR+j/5RD63XWwdJu+ZKF8tuzwenGGRV9DalRY+EMndN0N+r7MBHYluf0azXCJsqrAa49YbtmHcJMC31gbSlKcTVGi4gebHCEBhoKZcdYbUrkAQJa6UHbkA12EoYTkbOxbUWD4MWTrtyhbID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjanlGXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjanlGXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E06BC4CEE4;
	Fri,  9 May 2025 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746821877;
	bh=L1LqTskq/WOpKf8Dm/MOhrYquHsVHeNDKUmrpvXx9rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjanlGXJ2723P2kYBrNdN6PQj57AwRvcoUta0VR3ZBDAKvFaSsR0AwCblrWWA1iyB
	 kVMwhJG5Nefx9x3YRW9YKhKzdq2cX9Nx92ndCHpupY914UDUHUG76d+7k6byS8bjyS
	 j7ymYgApHE0Q9HLoOnWnqJYLLcZCfkuLTBiYn6GXYeG0HA4AWNs3NrFkk4H+dgakqc
	 XBgLIlLWjyRVGlkGtlzlmWiwbYZkU3GBuTJs90Viti4DIqrRYaaZ7+Ok+8oZQZ2IuE
	 jX02vu0fatfabbubS948O+TCyo0a9BxbhLHDEVy0sOnI5lEvIoTgGZqZGkb1s2P/dV
	 2/o3ezUS73LHA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH v2 20/62] objtool: Fix "unexpected end of section" warning for alternatives
Date: Fri,  9 May 2025 13:16:44 -0700
Message-ID: <7d99e58d5a0bbd46ccfe4ece125c72815e99e205.1746821544.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746821544.git.jpoimboe@kernel.org>
References: <cover.1746821544.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the short circuiting logic in next_insn_to_validate(), control
flow may silently transition from .altinstr_replacement to .text without
a corresponding nested call to validate_branch().

As a result the validate_branch() 'sec' variable doesn't get
reinitialized, which can trigger a confusing "unexpected end of section"
warning which blames .altinstr_replacement rather than the offending
fallthrough function.

Fix that by not caching the section.  There's no point in doing that
anyway.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ea4e0facd21b..53793b9ea974 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3545,15 +3545,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 {
 	struct alternative *alt;
 	struct instruction *next_insn, *prev_insn = NULL;
-	struct section *sec;
 	u8 visited;
 	int ret;
 
 	if (func && func->ignore)
 		return 0;
 
-	sec = insn->sec;
-
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
@@ -3791,7 +3788,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			WARN("%s%sunexpected end of section %s",
 			     func ? func->name : "", func ? "(): " : "",
-			     sec->name);
+			     insn->sec->name);
 			return 1;
 		}
 
-- 
2.49.0

