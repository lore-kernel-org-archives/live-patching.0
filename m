Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FF32B9A4
	for <live-patching@vger.kernel.org>; Thu, 19 Feb 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539813; cv=none; b=DMhMkGYOCuwlVdydhssDjVmOgOMOugjBflCBeudbBFLxhME6wgsCJXNSRHoUkhEMent4TZh8jhtfqBV55NKgh6OQPTQq60UpQkZSWns1J5+tSFSvjhFvb6oQ6gYULwd02ta1WXMD9647WtbA3h/u+laj7C99ugV0c98i5YNVipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539813; c=relaxed/simple;
	bh=uWXxklnO+VVahMoKuUdDwiXwS1bQ/dagbHRiBYbDM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c23lMTksy4i+WNuGhz/3gRnO/5zh4+qjhrLL8J589FJzhx3ceU6RH2bNMYNTSzjdkmCRi5OONGb5K6qpAZzECNi4w0YBYdjRq2wVfnZ7vKCWsHxE7pNbXQ8xXETe+44y58Ob6HXd2/pmONQBNNe3m/DNKT1TVTZ00F6MnVN21y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td0wGaHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td0wGaHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C77C4CEF7;
	Thu, 19 Feb 2026 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539812;
	bh=uWXxklnO+VVahMoKuUdDwiXwS1bQ/dagbHRiBYbDM+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=td0wGaHbKDU2jY52QIignWPUP6tT01rqiEddY9W1yizI7nPyOoPMCzcPbJB94M5Z3
	 rbiOE69C7S45Xs45ZqoJz4Gw9YgXKRSztM7KbMZ/BhmZibhD2lBu4fHz4zR2g9d3xz
	 oSVbq//HA/1NUHLsHnz8QWTI7cfqj38VEpnsb0jfN196vWdc6U9ttxrJepHm/5rj60
	 6Ou1coqySq6SivoekAzHMqru5h7G71Tvr7V3TfbPozlLOG2XFl6w6/oe0CLwsH66an
	 8bIQy0ctP0AG8WQ+oYT1tpU5ql/zAJCzi5tOz6nNIii0bVSFYsrgAs981s+dwirj+o
	 ApqhdyIhCMxYg==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 7/8] objtool/klp: Correlate locals to globals
Date: Thu, 19 Feb 2026 14:22:38 -0800
Message-ID: <20260219222239.3650400-8-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219222239.3650400-1-song@kernel.org>
References: <20260219222239.3650400-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow correlating original locals to patched globals, and vice versa.
This is needed when:

1. User adds/removes "static" for a function.
2. CONFIG_LTO_CLANG_THIN promotes local functions and objects to global
   and add .llvm.<hash> suffix.

Given this is a less common scenario, show warnings when this is needed.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/klp-diff.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 147e7e7176fb..07fcaca46160 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -519,6 +519,37 @@ static int correlate_symbols(struct elfs *e)
 		}
 	}
 
+	/* Correlate original locals with patched globals */
+	for_each_sym(e->orig, sym1) {
+		if (sym1->twin || dont_correlate(sym1) || !is_local_sym(sym1))
+			continue;
+		sym2 = find_global_symbol_by_name(e->patched, sym1->name);
+		if (!sym2 && find_global_symbol_by_demangled_name(e->patched, sym1, &sym2))
+			return -1;
+		if (sym2 && !sym2->twin) {
+			sym1->twin = sym2;
+			sym2->twin = sym1;
+			WARN("correlate LOCAL %s (original) to GLOBAL %s (patched)",
+			     sym1->name, sym2->name);
+		}
+	}
+
+	/* Correlate original globals with patched locals */
+	for_each_sym(e->patched, sym2) {
+		if (sym2->twin || dont_correlate(sym2) || !is_local_sym(sym2))
+			continue;
+		sym1 = find_global_symbol_by_name(e->orig, sym2->name);
+		if (!sym1 && find_global_symbol_by_demangled_name(e->patched, sym2, &sym1))
+			return -1;
+
+		if (sym1 && !sym1->twin) {
+			sym2->twin = sym1;
+			sym1->twin = sym2;
+			WARN("correlate GLOBAL %s (origial) to LOCAL %s (patched)",
+			     sym1->name, sym2->name);
+		}
+	}
+
 	for_each_sym(e->orig, sym1) {
 		if (sym1->twin || dont_correlate(sym1))
 			continue;
-- 
2.47.3

