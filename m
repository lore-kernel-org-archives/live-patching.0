Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA035CB87;
	Mon,  3 Aug 2026 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727490; cv=none; b=SjHkYjgkl4A1blK+E30xkde89dqALCiham2YBiY0iHKZL7H6XjiVmyDZxIOkUk7J+rSi/bC/wWUxTWdKdeCjkD8wg96tAGV66xBYTJ1UypVwgF4HNBuLkuc+2CYZVvaBZ93POHYuC/HQZfGGturGt+fkIH4ZPDudrqYrJBZUaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727490; c=relaxed/simple;
	bh=U8CEK6XYg42do2MR6KwtUPjR42Wqvg261Hq3tR9ojxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD224dsD7N5twBRYB/EOFystQ3Iqe68EDTbKAxQf68gnGr+U6/wDwFloAgfhZf6QokMGdIeJ07LAr70f+eogyIkXeYjasFrX9kmXjIyEU+fcF97GpFU+sL31pWvTDOhXqAqBLdwS9tRJ57JDiJ7BMt/dvIu/F66vI/YThQ/Y0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBsQSnKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBsQSnKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4A51F00A3E;
	Mon,  3 Aug 2026 03:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727489;
	bh=eYO/LoWPG6DH2eRKJ5hm/XFNO1RSrjFAdgJnmvUBJEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EBsQSnKuQfnyCfmqxYi6KNydKG0wC4mHjOU6LJJuz+qPuvsQk0/635+51EWu78H7L
	 oM3GQ07tFi04k4yWioMXTCjP1JUod7MpA3uNMZgiVu+ELHI217czo/XJC3x4wka77V
	 HKPZ5x0tX5/sO75ASDR88duDhJ5Yms7JF50x1dmraAc/fJrRhrATc7taZNqhiAfNT3
	 0zQqqNW0NuKvGgK0IgSwyhVsr3V7VPHcSmj0s3vPUvu13eHpRdH8Uwq9JeURxhvMSz
	 kZ4ySdpOd3hv3S03CcDsjWB1fBbLYVK/g0404LAj5fImQGuVbcJVaz2jFY84xfE/cz
	 FcwFWJGx+KGwg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 01/14] objtool/klp: Fix module name normalization for paths with dots
Date: Sun,  2 Aug 2026 20:24:23 -0700
Message-ID: <9017b4609553bed16674e8f924d34691cbc2b2c1.1785727106.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When .modinfo has no "name=" tag, __find_modname() falls back to
converting the object's build-tree path to a runtime module name by
stripping directory components, converting '-' to '_' and truncating the
file extension.

It does all that in a single pass over the entire path, so the first dot
anywhere in the path ends the name.  For an object built in a directory
whose name contains a dot, e.g. "drivers/foo-1.0/bar.o", the result is a
bogus module name.

Strip the directory components up front so only the basename is scanned
for the extension separator.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f8787d7d1454..aeb99d572300 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1140,7 +1140,7 @@ static struct export *find_export(struct symbol *sym)
 static const char *__find_modname(struct elfs *e)
 {
 	struct section *sec;
-	char *name;
+	char *name, *slash;
 
 	sec = find_section_by_name(e->orig, ".modinfo");
 	if (!sec) {
@@ -1158,10 +1158,12 @@ static const char *__find_modname(struct elfs *e)
 		return NULL;
 	}
 
+	slash = strrchr(name, '/');
+	if (slash)
+		name = slash + 1;
+
 	for (char *c = name; *c; c++) {
-		if (*c == '/')
-			name = c + 1;
-		else if (*c == '-')
+		if (*c == '-')
 			*c = '_';
 		else if (*c == '.') {
 			*c = '\0';
-- 
2.54.0

