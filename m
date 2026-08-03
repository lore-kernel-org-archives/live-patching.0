Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40836492A;
	Mon,  3 Aug 2026 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727491; cv=none; b=gIRKGXB9AdTp2rHbw7QDw0i8oBMxagq88RaSAxbbntVV27LZeV79BexCXCYiqRDQerW70RHiJFSypRfOJSJm7B0YUTi4zpIK2ykb84J2abGz+GsXB8F14HcvrkTw+DK5THxvOSlT6HYBkILOC1HONKW8J2MgKdtaNotVXC+342g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727491; c=relaxed/simple;
	bh=hm3D/Xty8MBZM3QfRbUzA8YpbzAJCtUKOyJdYd95Ovo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9kN9bSrTZoA/uhTqXtwD3iP4Z0/ncqfGPDgzYh5f8uMjqjmHzP0Yqp9bSxCAFx9+OIRI5R1EsoTZQruLqxB/MIK9zdYjv35fbBYJrP/WOacPE9lwzJBM2WdbLPXttxNd1zfMwF4hc/ASl+cCfw4duA2NcFKsD2BeF4WyWseI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQTPu1Wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQTPu1Wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC31F00A3F;
	Mon,  3 Aug 2026 03:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727489;
	bh=7remyKREYUVeFS3QYdwJSO3fUjTHDVOdeo5ZoWSgbRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQTPu1WiC9tor+Sm1inMIHJPO7FNi+HIpRCyi58OrI0trvey27NJvz/41hc1q6Pi5
	 oi8FRITIKpGnBsnz5ka9z8wYzvwtk9yDQpdp9apD4NdpJ+2cGjH03hcjKEGlK1tTG0
	 yhOjI+1DFiu34j3JmgGKC/pq+Z/z6gu8Vs1TILeyHmJeRh/VZHRUt87D0jhC7qXQEW
	 rz6x1joInJZAiEG8u9osnDIJ4dk0YMPUesmbh8hutYlVwKTug19k9/yxLgqvO81fpi
	 dx1er5v2Aks54l/E8oHvinuz2Dit2HxeEamwAN4T60XtQR2ara2W6E9rc/Vbza5SCz
	 Lu4efUw274v1w==
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
	Ben Procknow <bprockno@redhat.com>
Subject: [PATCH 02/14] objtool/klp: Normalize Module.symvers paths to module names
Date: Sun,  2 Aug 2026 20:24:24 -0700
Message-ID: <dbe1b72931bd3c31b751fd0729613d9f2226fff6.1785727106.git.jpoimboe@kernel.org>
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

From: Joe Lawrence <joe.lawrence@redhat.com>

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
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 49 ++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index aeb99d572300..15d37d955af0 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -83,6 +83,35 @@ static char *escape_str(const char *orig)
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
+	char *slash = strrchr(name, '/');
+
+	if (slash)
+		name = slash + 1;
+
+	for (char *c = name; *c; c++) {
+		if (*c == '-')
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
@@ -150,6 +179,9 @@ static int read_exports(void)
 			return -1;
 		}
 
+		if (strcmp(export->mod, "vmlinux"))
+			export->mod = normalize_modname(export->mod);
+
 		export->sym = strdup(sym);
 		if (!export->sym) {
 			ERROR_GLIBC("strdup");
@@ -1140,7 +1172,7 @@ static struct export *find_export(struct symbol *sym)
 static const char *__find_modname(struct elfs *e)
 {
 	struct section *sec;
-	char *name, *slash;
+	char *name;
 
 	sec = find_section_by_name(e->orig, ".modinfo");
 	if (!sec) {
@@ -1158,20 +1190,7 @@ static const char *__find_modname(struct elfs *e)
 		return NULL;
 	}
 
-	slash = strrchr(name, '/');
-	if (slash)
-		name = slash + 1;
-
-	for (char *c = name; *c; c++) {
-		if (*c == '-')
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

