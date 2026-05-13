Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70034390209;
	Wed, 13 May 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643277; cv=none; b=PX+xsm9HoBQQcr9i93yM0mXGgXeXgT+T8OSdyF1Xpevi4Gwu7+cBK6SUw97Btn+Ot8kEwSmXkca0321cxCTyVKeLQgsSLqXMh0NmU4wiGMVz56Sv1KtPkL7GBQHP8uxPAYm2Hty4cwsaB+4DnKNPiImkE+xHH7fhAmMW+0yi718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643277; c=relaxed/simple;
	bh=ODGizz8YbR/8nDzbjCn/eHHTqaD5XRXQRwu11kVeY3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ri088n1c15053QLATeuDFwMM4aiHkX7qWgae1Skrr/lwY8oi6SqNfVdEQdeR+jMTUl7HQYFobGIlPMK+Tkir4M6VNLQf+Tfg7NwiUg36gQ8iq0jA8jG/HiDDJtpGETl2Q8kXcq7GJXp4uI1DyEpGkOQrZyusRlvmg37QTBzRUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiJfzUOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiJfzUOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0774C2BD00;
	Wed, 13 May 2026 03:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643277;
	bh=ODGizz8YbR/8nDzbjCn/eHHTqaD5XRXQRwu11kVeY3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiJfzUOFXeUHITChE7yfuGNT5uDwk9hbbPapbKdRrmsHlu5z8tAcCX2Gfd3wLsZGC
	 duxHuQrXypB5lkXdj3SDCOrKmj3uPirwJZf2XH1rVlFEQ7lNM3+rPgJwTBWMcBSsBO
	 fOLtjA3UFGD3Jn//ejeTbyukAhnv2uJI5vB0zwGsQ0ZeLRFmHZnhFtXbLMv8xZrh0u
	 nWbxqIchSibY3fq5GPari3EsINujqRqa18d0aWtClE36JQZf/u3O1UbKL54WVSWIIg
	 6543HYF8zLhlQo69WggqYMRV3X9YqlNqPQAbBPfhakActX5FO9Ati2AZb5Xbg07tFy
	 OveyiT0UHIzHA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 11/21] objtool: Allow empty alternatives
Date: Tue, 12 May 2026 20:33:45 -0700
Message-ID: <3c474673ec5ddc9f27fbf5ddb1fd0f66ef6a779f.1778642120.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 can have empty alternatives, which are effectively no-ops.  Ignore
them.  While at it, fix a memory leak.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 73451aef68029..e05dc7a93dc1e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1953,6 +1953,9 @@ static int add_special_section_alts(struct objtool_file *file)
 
 	list_for_each_entry_safe(special_alt, tmp, &special_alts, list) {
 
+		if (special_alt->group && !special_alt->orig_len)
+			goto next;
+
 		orig_insn = find_insn(file, special_alt->orig_sec,
 				      special_alt->orig_off);
 		if (!orig_insn) {
@@ -1973,10 +1976,6 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		if (special_alt->group) {
-			if (!special_alt->orig_len) {
-				ERROR_INSN(orig_insn, "empty alternative entry");
-				continue;
-			}
 
 			if (handle_group_alt(file, special_alt, orig_insn, &new_insn))
 				return -1;
@@ -2014,6 +2013,7 @@ static int add_special_section_alts(struct objtool_file *file)
 			a->next = alt;
 		}
 
+next:
 		list_del(&special_alt->list);
 		free(special_alt);
 	}
-- 
2.53.0

