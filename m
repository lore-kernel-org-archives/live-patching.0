Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E23B5303
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773820; cv=none; b=uYXaWmJIe2Z8EHyq1o87TGFa6oDP1UYgdLuWPlgCSFGTQEItB1ZMUfL108mXosxjLR+Z99Dyh5D7fu8Q7QW4u3b3zO4vkRjQVthL6jqHRBfrUFPaIRNt3sA4qwYQck/JD2elHVH3qG+qRvHVw4ef9D4xjPp7xWuG+ZLbPnc1rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773820; c=relaxed/simple;
	bh=rEuLUsLWOT6XG2H0ug7PCU+HTdJX3Spbx1VaEW7dXdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=LjMAbx0UeFMwpdDn9Z7ck5bzNxvoDp2sBL84XR1fAdhfPf6913rwDnCFSy5M8cUBxS3qy9+toIw/aIVKCLJ8cBe1UCktQJwb6XZGPuWwHFun+vNJW3pV6QjbDSCxcYLFoRjP5gwaCARRtDMOMPmhTmh4UjBWbPssES7BA3ReyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB/+OGIX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB/+OGIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SqGrkHQm8dJ5v8HQSwteRwkbtcEIrt/1QGX2z5fIVY=;
	b=KB/+OGIX2lddSp2R1glcb8dFyiWXija/otxjYPq22Vc/6/XfOjIZvmTwx/rxqfTgvqZCLi
	n6s2JGgSGV3URK8C2tKcDXtFO1E0EJerOXxw45M9TA7xxm8l0PPyAxuN9aQ5vdTS6LvkFL
	CR7EvhcmSEBU2UGGniSLdrBNpY4j6dU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-UpAgDIDEPz-uOaXxF5mNUg-1; Wed,
 26 Aug 2026 15:50:07 -0400
X-MC-Unique: UpAgDIDEPz-uOaXxF5mNUg-1
X-Mimecast-MFC-AGG-ID: UpAgDIDEPz-uOaXxF5mNUg_1787773806
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E237C19540EF;
	Wed, 26 Aug 2026 19:50:05 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD2F73000239;
	Wed, 26 Aug 2026 19:50:04 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 2/7] objtool/klp: add --symvers option to klp diff
Date: Wed, 26 Aug 2026 15:49:55 -0400
Message-ID: <20260826195000.455905-3-joe.lawrence@redhat.com>
In-Reply-To: <20260826195000.455905-1-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a --symvers (-s) option that accepts a path to Module.symvers.  When
provided, it replaces the default "Module.symvers" filename used by the
auto-detection logic.

This decoupling helps to enable scenarios like out-of-tree module
patching and unit testing of klp-diff, where object files /
Module.symvers live outside the kernel tree.

The existing auto-detection behavior (try cwd, then top_level_dir()
fallback) is preserved regardless of whether --symvers is specified.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-diff.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 1726d17f31e5..f40c128fdd49 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -35,6 +35,7 @@ struct export {
 	bool mod_ns;
 };
 
+static const char *symvers_path = "Module.symvers";
 bool debug, debug_correlate, debug_clone;
 int indent;
 
@@ -48,6 +49,7 @@ static const struct option klp_diff_options[] = {
 	OPT_BOOLEAN('d', "debug", &debug, "enable all debug output"),
 	OPT_BOOLEAN(0, "debug-correlate", &debug_correlate, "enable correlation debug output"),
 	OPT_BOOLEAN(0, "debug-clone", &debug_clone, "enable cloning debug output"),
+	OPT_STRING('s', "symvers", &symvers_path, "path", "path to Module.symvers (default: Module.symvers)"),
 	OPT_END(),
 };
 
@@ -116,19 +118,23 @@ static char *normalize_modname(char *name)
 
 static int read_exports(void)
 {
-	const char *symvers = "Module.symvers";
 	char line[1024], *path = NULL;
 	unsigned int line_num = 0;
 	FILE *file;
 
-	file = fopen(symvers, "r");
-	if (!file) {
-		path = top_level_dir(symvers);
+	if (!symvers_path) {
+		ERROR("missing symvers path");
+		return -1;
+	}
+
+	file = fopen(symvers_path, "r");
+	if (!file && symvers_path[0] != '/') {
+		path = top_level_dir(symvers_path);
 		if (path)
 			file = fopen(path, "r");
 	}
 	if (!file) {
-		ERROR("can't open '%s', \"objtool diff\" should be run from the kernel tree", symvers);
+		ERROR("can't open '%s', \"objtool diff\" should be run from the kernel tree", symvers_path);
 		free(path);
 		return -1;
 	}
-- 
2.55.0

