Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47157374A0B
	for <live-patching@vger.kernel.org>; Mon, 13 Jul 2026 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978302; cv=none; b=FBXMRo+Q8kI27/nXO0DhGaKj2d50zhWcpr8rtC+MhT7aPwyRNpVZXwgOELcxvNp6Q3caX/SPtr/50S7r6WG809wyYbC+iQURcjqY1XpYrMwlMqj6kVkZlXxq8zDMMffR97+45TIuVeZYoPl8wuLhJY3fRrywcKm5b2IUH/gcwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978302; c=relaxed/simple;
	bh=6DNl4R2PRmzpI3kHireIJMrDAGXJPhiKkaLf3kNgkWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=maq/P5LqHtjQydAFYlVxh8iGccYZID2f1zHYci7/CkuRHRPEAm5BE3g7OJC197aJnLZD6aL0QQSlqaddNqNfZ2S10WJ4k0Mpc7LxOUy0Tbb6Iu2ce2Yd7B13g34sgG/NlVoaoPPCIkBnYZNn4ZJc383P30ChFavNSkwbX8FxPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+lTzEmU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+lTzEmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783978297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pejB6K7tZNEKx1Gu59ezgt+2BlcSYZTWqKl94LZxYAg=;
	b=J+lTzEmUwpVBjjEhFlTbz4ZK06n1lKmKddmdSnV3XhB5PcNvsFQtXfntlUfG/z9b1vFtwh
	vX6Hb4tSwJlvvearPnnUyTd8zYGhHBwBiIAUPgH3AQP+cOSgm2vRy49pJ/UVAEtsXr+DCB
	6+lsolK19ZiiMc8IA/SeHzQSp5Rnt8k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-uU5D_f1KNiun0oX91bxoLQ-1; Mon,
 13 Jul 2026 17:31:35 -0400
X-MC-Unique: uU5D_f1KNiun0oX91bxoLQ-1
X-Mimecast-MFC-AGG-ID: uU5D_f1KNiun0oX91bxoLQ_1783978294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ED0319560B9;
	Mon, 13 Jul 2026 21:31:34 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA1021956044;
	Mon, 13 Jul 2026 21:31:32 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Ben Procknow <bprockno@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 1/1] objtool/klp-diff: normalize Module.symvers paths to module names
Date: Mon, 13 Jul 2026 17:31:28 -0400
Message-ID: <20260713213128.3529250-2-joe.lawrence@redhat.com>
In-Reply-To: <20260713213128.3529250-1-joe.lawrence@redhat.com>
References: <20260713213128.3529250-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Module.symvers contains build-tree object paths as module identifiers
(e.g., "arch/x86/kvm/kvm") rather than runtime module names ("kvm").
Objtool's clone_reloc_klp() uses this field directly for exported
symbols, while unexported symbols correctly go through __find_modname().

This means that exported symbol relocations may land in a .klp.rela
section named with the build path rather than the module name.  That is
a crash waiting to happen: the kernel's livepatch loader silently skips
this relocation because it doesn't match the expected klp_object name.
The unresolved relocation sits in the newly activated code, crashing
when executed.

Normalize export->mod at Module.symvers read time using the same logic
as __find_modname() (refactored into a shared normalize_modname()
helper).

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Reported-by: Ben Procknow <bprockno@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---

Note on the fix and existing gotchas for the review bots: The
normalize_modname() helper is a direct refactoring of the pre-existing
loop in __find_modname().  To keep this critical bug fix short and
safe for stable backporting, I've kept the string manipulation logic
identical to what has already been proven stable in objtool.

 tools/objtool/klp-diff.c | 42 ++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index c2c4e4968bc2..2f3b5e69ab2d 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -83,6 +83,32 @@ static char *escape_str(const char *orig)
 	return new;
 }
 
+/*
+ * Convert a build-tree object path to a runtime module name: strip
+ * directory components, replace '-' with '_', and remove file
+ * extensions.  Examples:
+ *
+ *   "arch/x86/kvm/kvm" -> "kvm"
+ *   "arch/x86/kvm/kvm-intel" -> "kvm_intel".
+ *
+ * Used by read_exports() to normalize Module.symvers entries and by
+ * __find_modname() as a fallback when .modinfo lacks a "name=" tag.
+ */
+static char *normalize_modname(char *name)
+{
+	for (char *c = name; *c; c++) {
+		if (*c == '/')
+			name = c + 1;
+		else if (*c == '-')
+			*c = '_';
+		else if (*c == '.') {
+			*c = '\0';
+			break;
+		}
+	}
+	return name;
+}
+
 static int read_exports(void)
 {
 	const char *symvers = "Module.symvers";
@@ -150,6 +176,9 @@ static int read_exports(void)
 			return -1;
 		}
 
+		if (strcmp(export->mod, "vmlinux"))
+			export->mod = normalize_modname(export->mod);
+
 		export->sym = strdup(sym);
 		if (!export->sym) {
 			ERROR_GLIBC("strdup");
@@ -790,18 +819,7 @@ static const char *__find_modname(struct elfs *e)
 		return NULL;
 	}
 
-	for (char *c = name; *c; c++) {
-		if (*c == '/')
-			name = c + 1;
-		else if (*c == '-')
-			*c = '_';
-		else if (*c == '.') {
-			*c = '\0';
-			break;
-		}
-	}
-
-	return name;
+	return normalize_modname(name);
 }
 
 /* Get the object's module name as defined by the kernel (and klp_object) */
-- 
2.54.0

