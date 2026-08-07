Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC745348A;
	Fri,  7 Aug 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138726; cv=none; b=IplNh25ApIt8qe9I6eiAIEUQ21Xd7ObPI/PCn4wCusLiBozwY4SoAe3ufAMeOHRJI4iAT83ITtLOTW/g/AdXqIKSZQ4dbULg4WUjUsad2I9N4oWVeFtCzGpRc7BZl0uFnlxBZxlyzuyWPS/EYC8t0qldpOR+hplrL5Sa+jRVcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138726; c=relaxed/simple;
	bh=to014yoJn5SqY4aGIU377Mjvt5TwEOJ3/fU4EEWIGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD48XmmTkEDPJfHV9qbPokFEYp4wWLfkIZyUzKl+b/m9oS3WyLgYiWM27ffg4kkyrKwZ0jIZJNc1uCelucK6j0LxdjpyyTeRjlO0SIok9NGm/6n+9/AI6GUByawyy98qETGG9Y7LaqluJ7jaUDvOkLBWy1zrR0CO/xFIeser54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAENn2SO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAENn2SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133EA1F00A3D;
	Fri,  7 Aug 2026 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138723;
	bh=+JtDE3z43FY3vC+Fg2RKoa0AqAM9urWsBd92cv1rHHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAENn2SOozRa+eELNIvecDhFB85Vpm1GZxAnyopUJfIru7H6fximuq+FdHFi8rgeR
	 VOAG7i1KKhFP8H9SrqO/RvJvHKBEQ3q81f5G0EmdgXfbXy4OnBngcZoScCuG4PC8Ho
	 koerRzP6Ped/pEogUd8XjcD4WvT1io5D0QLM7uoFhrYItlTCS+FdbmqNKif8/SJ0WP
	 xpAEGdxk7/rXlF0XLy5lYzA1exvx+QVCuW1ppKIQtkphGz/dyVj4u7cVI0SKcqWNJw
	 5l3yGpZ4p2zAcP2h1H7XNqUq91e0n8ZxeOrza0/cxvPHOWIGDKV8eSb1jQFqr9tfjU
	 BqcD6M6DziM+g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 9/9] objtool/klp: Fix line numbers in Module.symvers parse errors
Date: Fri,  7 Aug 2026 14:37:54 -0700
Message-ID: <133e16bb0c7cb916f10bbfb017eba525449ad1d6.1786138493.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786138493.git.jpoimboe@kernel.org>
References: <cover.1786138493.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_exports() reports the offending line number when it fails to parse
Module.symvers.  The counter is initialized to 1 but never incremented,
so every error blames line 1 regardless of where the bad line is.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 0f135b74a5b0c..b6b72ed71bf02 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -118,7 +118,7 @@ static int read_exports(void)
 {
 	const char *symvers = "Module.symvers";
 	char line[1024], *path = NULL;
-	unsigned int line_num = 1;
+	unsigned int line_num = 0;
 	FILE *file;
 
 	file = fopen(symvers, "r");
@@ -140,6 +140,8 @@ static int read_exports(void)
 		char *sym, *mod, *type, *namespace;
 		struct export *export;
 
+		line_num++;
+
 		sym = strchr(line, '\t');
 		if (!sym) {
 			ERROR("malformed Module.symvers (sym) at line %d", line_num);
-- 
2.54.0

