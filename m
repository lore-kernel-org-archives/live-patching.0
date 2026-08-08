Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCCF381AE0;
	Sat,  8 Aug 2026 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231116; cv=none; b=Vg42zYdsHd0v2EujUG6zMqm3X1MxO8ljw5PP4KeBa2+brvMihMrol79yjAy3+dRC/TqWRuCGhXnrZ+aLAbCpXRPOIeW5+7IqAByB+Gn1EMunnX5fADaLxsaCjx3Ly1xqHJNZpus5uRf2mLGASEn+NVQrtManZrAjhaf5kfzrt0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231116; c=relaxed/simple;
	bh=W3SyGCo462WJlJKCsRBruxE7yb6MA8zDTXvX8bGc+vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhegk3OfICmvY55qTvaqUUVBw+3Cip6y5ZOosTA3JQ9v6sYmCDR82R+NmS+aw1uICpO63zfgDU2K8NwL6nSwqO1KX/JSqtVf/FMPBSYpbzLlbhbNRe8AZRQLLJkyrwP+GKr1K+Dvi7HSkBNn8dbBHukhYzmdRXahw8XkuRC+OOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAc5hpwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAc5hpwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9873C1F000E9;
	Sat,  8 Aug 2026 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231114;
	bh=gV4QRBMjF8SWDxF8bR0dzMkZJ2kMlPEch7VZ8Sz4gRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nAc5hpwNrSZ1ouVZFjbyGeSZn5j2elY1TzRKCTN/lK5f96kuAgdka1mLYO7o0P2dr
	 F2Tyh6yMp3RpW5Rve6BNBxG+inmwfLWnd9pJ82afHZiyQj7H/i1vAfI6/XXy1gSQsm
	 11vErT/6U4BaAJa7kLsX/AvEOY5RtoRBS0le4NTHkeTORomKVhXwQXAiEqfO071GB0
	 SFoKcl1t/uhfJ43gvH6E1LsVI62QgvE+fTYnGE3gOOqcB4zR+SMCHuzjl6IJxENSSI
	 lBWghi+LzluP3rd2ay8Gea88ktGKTA9Qql9s7i3VJ+JT+EMCnUThtD08J7qqF2w9+m
	 owasDHEpY+vrQ==
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
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 10/22] objtool: Allow setting --mnop without --mcount
Date: Sat,  8 Aug 2026 16:17:14 -0700
Message-ID: <339aa792e9eec6de991f72bb3afc6016ddeb3d79.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of returning an error for --mnop without --mcount, just silently
ignore it.  This will help simplify kbuild's handling of objtool args.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 75b11dc85010e..b89c7dc7983f3 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -145,11 +145,6 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
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
2.54.0

