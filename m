Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FA3B9D99
	for <live-patching@vger.kernel.org>; Mon, 20 Jul 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559433; cv=none; b=UDm/Dsbuct3qwLz+rHg8Cvupa9JCzkT+L6RllGkGZP0mGRFRGu8XkX9mpr/s4ddi794LJFDsuCpt7ujusyddl6E5gKswAFFZIOl0IxgLFobgqEJCYPP1huyP9EZt7FFtog6O8p1zFjdZ4LGZEQLiAd/p/9D92bNtV75yYsJ4y2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559433; c=relaxed/simple;
	bh=CsB0lN9ENbCX8qOhvLHhwjBqHF08NBzdxR+brO3b4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=nQQGerj5NL8v/RUD/s7qPa+4mwrvu4DzLWNiuqWoZz6NFwmuFizQQalw6iCA9y1H9oU5EzvkV5UNqLYDfcBNhN7BB5QlZlqGorIcgO3BdOSr4Z0qpFfufZB2js1THRBWrhFCACea9/8w1Cw1HAf9lblXM/u8awS9wxxy51NHTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa7wCYn5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa7wCYn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784559430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgrbfnFbFxTFT75H0Jtno4dB1enoVYQVDIQOyvclcqs=;
	b=Aa7wCYn5PR4Y3f3dVg1aCe1/eAKiV5nFTlVRmQcMNy5vW485ynCBureFEp3ibXrBUX9v/2
	92JeknPgb6xOi1IAaCxVDPP0zknpjAmIbHXzd1txtLuZivwfN8VwC9dFzwsNW1y0/jU39L
	htV7gtwQFW7n55a9y1FAlpu0jG+Jj60=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-sdAF-rzYOLCWqA754d6uVg-1; Mon,
 20 Jul 2026 10:57:06 -0400
X-MC-Unique: sdAF-rzYOLCWqA754d6uVg-1
X-Mimecast-MFC-AGG-ID: sdAF-rzYOLCWqA754d6uVg_1784559425
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1CA18001D7;
	Mon, 20 Jul 2026 14:57:05 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DF6530001BE;
	Mon, 20 Jul 2026 14:57:04 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 3/4] objtool/klp: reject new cross-module references without existing dependency
Date: Mon, 20 Jul 2026 10:56:57 -0400
Message-ID: <20260720145658.1103243-4-joe.lawrence@redhat.com>
In-Reply-To: <20260720145658.1103243-1-joe.lawrence@redhat.com>
References: <20260720145658.1103243-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a livepatch introduces a new reference to a module-exported symbol,
the resulting klp-relocation will only be resolved at patch-enable time
if the exporting module is loaded.

A future commit will remove livepatch module dependency references to
facilitate late-module patching, that is, the pre-loading of the
livepatch before target modules are loaded.

If the original (unpatched) module already depends on the exporting
module, the dependency is safe: the module loader ensures the dependency
is satisfied before the patched module can be loaded, so the
klp-relocation target will exist.

However, if the patch introduces a reference to a module that the
original doesn't depend on, there is no such guarantee.  The exporting
module could be absent or could be unloaded at any time, leading to a
relocation failure or use-after-free.

Add a build-time check: when a new symbol reference (no twin) targets a
module export, verify that the original module already has at least one
UNDEF symbol resolving to that same exporting module.  If not, error out
with a diagnostic message.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-diff.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index e14d1f32126d..801f99bbdb0d 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1509,6 +1509,28 @@ static int convert_reloc_sym(struct elf *elf, struct reloc *reloc)
 	return convert_reloc_secsym_to_sym(elf, reloc);
 }
 
+/*
+ * Check if the original module already has a dependency on dep_mod, i.e. it
+ * already references at least one export from that module.
+ */
+static bool has_module_dep(struct elfs *e, const char *dep_mod)
+{
+	struct symbol *sym;
+
+	for_each_sym(e->orig, sym) {
+		struct export *exp;
+
+		if (!is_undef_sym(sym))
+			continue;
+
+		exp = find_export(sym);
+		if (exp && !strcmp(exp->mod, dep_mod))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Convert a regular relocation to a klp relocation (sort of).
  */
@@ -1533,6 +1555,14 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 		return -1;
 	}
 
+	if (!patched_sym->twin && export &&
+	    strcmp(export->mod, "vmlinux") &&
+	    !has_module_dep(e, export->mod)) {
+		ERROR("%s: new reference to %s (exported by %s) would create an undeclared module dependency",
+		      patched_sym->name, export->sym, export->mod);
+		return -1;
+	}
+
 	/*
 	 * Keep the original reloc intact for now to avoid breaking objtool run
 	 * which relies on proper relocations for many of its features.  This
-- 
2.54.0

