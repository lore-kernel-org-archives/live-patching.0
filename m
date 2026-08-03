Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD849362149;
	Mon,  3 Aug 2026 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736198; cv=none; b=YOdUcNvs2YA9GzGiAnLxR435b0Uy9bX4eJfo9m/cGfuaHMxiVdiH3aHih6is1HkrSxk3JnkBaDUCJLPCCtIDE3yq+a4YUkkXwezRK5LimnNwRK9xq7dMjuM1XBNVaLecRJLQLWmJS1y8aIN89hsgGNj4N/zbzFKGIQrxaSrDZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736198; c=relaxed/simple;
	bh=slB9InxDI0/v0Vut52prpj4pCijHoTSF1EVG3RuHVmQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DzRsXmQaNuXb/6MZcln0sBjRFFGHwk8byhwPVEizZHp6d+tK0AMi7fPQmTxAWu90IUHnh8BzwtcbwSBJptT86mfuLIOe7x8BNtNDFh4lvIGA7qAvXm7+lZFt5fLlqqQB8XWd7HkW98UkmECXmT92C1xprexN3VAK3oVpOmezukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jDb3N6NU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zqB71XS9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDb3N6NU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zqB71XS9"
Date: Mon, 03 Aug 2026 05:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785736185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkZwqhzEDwfKZXo5szPc56FmHTHXk7dbSiom6kSVY4w=;
	b=jDb3N6NUAc4AvFdiKBjznjgvrvJoGB0RHPXTltEfTKR1Ro3TdJGEkgKjbS47gdv1W9lLPJ
	SA3qAGU72yT4N+YyJ4gortx/fB8tTpFoJIO64kLc9JYVRkve6swsx+mvVEtn6NGlZoXRTb
	We6OIcOlmUMiU8ezVPaLv82XFSUc/mDyBi31R5vzZGecO4n1g3Q5gDLtaRs/kaENgvZWzN
	ongAJX5JUnr6z00vJAyLgZDZYMtLWofLiwaUH0Kslt+sSm350KR4dnPIMPWhnUPV9T74d7
	qvCZJAHwOs1vaIy5eATh3jbPXC/ertcqNa35qHHw2+MuThobSOOOQ50+zMibKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785736185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkZwqhzEDwfKZXo5szPc56FmHTHXk7dbSiom6kSVY4w=;
	b=zqB71XS9n2K09gSDFHy60H1Fm+NEtpFvcPOyBtD1TbmqQOod+B/Eu/i6Dm+2aHatDzl9cQ
	JMJ3/3PXSuNul7DQ==
From: "tip-bot2 for Joe Lawrence" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Normalize Module.symvers paths to
 module names
Cc: Ben Procknow <bprockno@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <dbe1b72931bd3c31b751fd0729613d9f2226fff6.1785727106.git.jpoimboe@kernel.org>
References:
 <dbe1b72931bd3c31b751fd0729613d9f2226fff6.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178573618371.1210945.1444857092839684415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8668bf91e0508abeb8e98b4edd89032be02228a1
Gitweb:        https://git.kernel.org/tip/8668bf91e0508abeb8e98b4edd89032be02=
228a1
Author:        Joe Lawrence <joe.lawrence@redhat.com>
AuthorDate:    Sun, 02 Aug 2026 20:24:24 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Aug 2026 07:12:38 +02:00

objtool/klp: Normalize Module.symvers paths to module names

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

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Reported-by: Ben Procknow <bprockno@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org
Link: https://patch.msgid.link/dbe1b72931bd3c31b751fd0729613d9f2226fff6.17857=
27106.git.jpoimboe@kernel.org
---
 tools/objtool/klp-diff.c | 49 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index aeb99d5..15d37d9 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -83,6 +83,35 @@ static char *escape_str(const char *orig)
 	return new;
 }
=20
+/*
+ * Convert a build-tree object path to a runtime module name: strip
+ * directory components, replace '-' with '_', and remove file
+ * extensions.  Examples:
+ *
+ *   "arch/x86/kvm/kvm" -> "kvm"
+ *   "arch/x86/kvm/kvm-intel" -> "kvm_intel".
+ *
+ * Used by read_exports() to normalize Module.symvers entries and by
+ * __find_modname() as a fallback when .modinfo lacks a "name=3D" tag.
+ */
+static char *normalize_modname(char *name)
+{
+	char *slash =3D strrchr(name, '/');
+
+	if (slash)
+		name =3D slash + 1;
+
+	for (char *c =3D name; *c; c++) {
+		if (*c =3D=3D '-')
+			*c =3D '_';
+		else if (*c =3D=3D '.') {
+			*c =3D '\0';
+			break;
+		}
+	}
+	return name;
+}
+
 static int read_exports(void)
 {
 	const char *symvers =3D "Module.symvers";
@@ -150,6 +179,9 @@ static int read_exports(void)
 			return -1;
 		}
=20
+		if (strcmp(export->mod, "vmlinux"))
+			export->mod =3D normalize_modname(export->mod);
+
 		export->sym =3D strdup(sym);
 		if (!export->sym) {
 			ERROR_GLIBC("strdup");
@@ -1140,7 +1172,7 @@ static struct export *find_export(struct symbol *sym)
 static const char *__find_modname(struct elfs *e)
 {
 	struct section *sec;
-	char *name, *slash;
+	char *name;
=20
 	sec =3D find_section_by_name(e->orig, ".modinfo");
 	if (!sec) {
@@ -1158,20 +1190,7 @@ static const char *__find_modname(struct elfs *e)
 		return NULL;
 	}
=20
-	slash =3D strrchr(name, '/');
-	if (slash)
-		name =3D slash + 1;
-
-	for (char *c =3D name; *c; c++) {
-		if (*c =3D=3D '-')
-			*c =3D '_';
-		else if (*c =3D=3D '.') {
-			*c =3D '\0';
-			break;
-		}
-	}
-
-	return name;
+	return normalize_modname(name);
 }
=20
 /* Get the object's module name as defined by the kernel (and klp_object) */
