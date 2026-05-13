Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DB3A381A;
	Wed, 13 May 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643290; cv=none; b=TYeIsvwyF5YW96Z+17nMZTNiw5N/Ga4d8VYcE2yqhO4ePzXja5tv9rT+015BHGjHUMfYhURhE6rpPiCfJk+4xT3zQpOqdhDq4BL8VMnzk4AwnvxzLTUEyrFRS0/3dgeS4zqEawpxZQ5FKRvNopp25vLvP0hMvXZitHbrhtADqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643290; c=relaxed/simple;
	bh=G1VVkFA+yVRTPwxqst2UM5oq5D62mSukpDgUevX4w2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLbCab2KySRrMTM7mCn2gpGNPWE3BIelVTcBHC43z5MwXqNipM+I9rctcTKObBZQrDCwtTzyCnv1YoBDZo/Igi8NCDKdKg+MaOLtgsRmFpxU+rpCvVwhjiogXGvNDpO7gj5Lf323K4gWRjz6IF+t5nSgRJg4abQBDLIlP2gQVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFK55v94; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFK55v94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5710FC4AF1B;
	Wed, 13 May 2026 03:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643289;
	bh=G1VVkFA+yVRTPwxqst2UM5oq5D62mSukpDgUevX4w2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFK55v94+q/TgZ04oKyJ60qsdMKAZLWUmcuBlNhyXyN2mhUyeFJv30vLfN4RHe8xs
	 rvS6G5L8Ladtg+NNWyqBLjtdWk8kNTWV+8jkhqKR6L8hWULPG9q/smyw5VvYTloS/H
	 Q9em+hdiu/MuBOyOTvhY23o3BAHJ4hkXISHsm9dkOUZ7g1HiItJP2+zgwc9KUuInFj
	 8aNoQPcLW1KQqcsaT8LuzqVbQKapDdOqCvQfy7FiPMUJF8FYJ8orYN+8pnVMTuNMiF
	 LYokG8FW5X/PKZhcVv8195naNHfdsffqAoefoKz1Ghd8S93ciZ8vruRrULq7l5sUxc
	 OBio90LEomidA==
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
Subject: [PATCH v3 08/21] objtool: Allow setting --mnop without --mcount
Date: Tue, 12 May 2026 20:34:04 -0700
Message-ID: <87e956a4b3c8081c6ce0b75c043c15babf2a7f7e.1778642120.git.jpoimboe@kernel.org>
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
Message-ID: <20260513033404.4U9Ig6V7wNIZNO-yeYAvguOq23oM1U9PrzNrWNKQ-Uc@z>

Instead of returning an error for --mnop without --mcount, just silently
ignore it.  This will help simplify kbuild's handling of objtool args.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 118c3de2f293e..bd84f5b7c9ee9 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -144,11 +144,6 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
-	if (opts.mnop && !opts.mcount) {
-		ERROR("--mnop requires --mcount");
-		return false;
-	}
-
 	if (opts.noinstr && !opts.link) {
 		ERROR("--noinstr requires --link");
 		return false;
-- 
2.53.0

