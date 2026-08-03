Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC80373C1D;
	Mon,  3 Aug 2026 03:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727494; cv=none; b=M1yddcLSzLdF1/HCIQGrIrq0SRLKsnSMpZQkhAQnsnKsNdnvHjnkZntMNoBCXMmIrnw6MZkZL/HnOjDxJSzLh3/kHR9luDG6oSQonjUq1Aok43pD5e24OwRw4XLrdmf7zUgcWln8eBsQ58lSsru4iIOlXb1DLMHhA8WoK5n5wgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727494; c=relaxed/simple;
	bh=bUEz3yqIl8iuF01MWVluUFvE0Y6OJbyCUpjOZrRlAgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZRuQhjmoh4+A2zN9iINugL1o6dUIZi0haPsp9s0vvLM9ng0QrAvI/ACzVFKrjsGvOafUdJBgNs8Vp3zfRUScE1Q2UoMTawsdqkTLsGRCTXRRRoLcoR3PG41Q9Hr5GOTUneOYv59EVWc9CkrROWHmwrprygyI4JfHqogs2JIY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxouAoRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxouAoRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C751F00A3D;
	Mon,  3 Aug 2026 03:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727493;
	bh=bXyObPR/zEH+klDXuuVkfmL3pol8wEVXP2QY5Sl8GMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxouAoREg35Py8dGTbDj8nMQEKyVej5fchUKvtO9+pRF/XCuSARVlotnpzr/Ky4EY
	 nQ2sA0h9pxn2c9YVFzeJn3B5jtg0pIs8JoTbN6MzVhgnDZ9rgw2opatJITyFmAf6L6
	 9w6u7YRsPOx9qgW3oKhQVA6nzmFZUlcUsxy+/QEJXEk9kFxEQoIzC3d4t9Uyj14I3Q
	 9P9lRv2owUtrdNxTvFzM0oseYrYotslpD2jNyKdOcq64rACA7D96BHsmsj6/yp1IMl
	 2Bcw++mSfukemqwlxpaF+jvAev0PVztkQfSK5rfFG4J/wCRlZnA7crvCn/BFG8iXbm
	 Edwk84gQcy/5Q==
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
	linux-modules@vger.kernel.org
Subject: [PATCH 07/14] module: Add module_kallsyms_on_each_core_symbol()
Date: Sun,  2 Aug 2026 20:24:29 -0700
Message-ID: <9ff8d9f0ad20a9a5cdbab3fe650d3532688065d4.1785727106.git.jpoimboe@kernel.org>
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

module_kallsyms_on_each_symbol() iterates mod->kallsyms, which points at
the full init symbol table until do_init_module() swaps it out.  The set
of symbols it reports thus differs based on whether init memory has been
freed yet.

Add module_kallsyms_on_each_core_symbol() for callers which need a
symbol's position to be the same before and after that swap.
core_kallsyms is fully populated by add_kallsyms() before the module
leaves MODULE_STATE_UNFORMED, so it's readable on both paths.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/module.h   | 11 ++++++++++
 kernel/module/kallsyms.c | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..4ea4522a5fc5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -947,6 +947,9 @@ static inline bool module_sig_ok(struct module *module)
 int module_kallsyms_on_each_symbol(const char *modname,
 				   int (*fn)(void *, const char *, unsigned long),
 				   void *data);
+int module_kallsyms_on_each_core_symbol(const char *modname,
+					int (*fn)(void *, const char *, unsigned long),
+					void *data);
 
 /* For kallsyms to ask for address resolution.  namebuf should be at
  * least KSYM_NAME_LEN long: a pointer to namebuf is returned if
@@ -984,6 +987,14 @@ static inline int module_kallsyms_on_each_symbol(const char *modname,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+module_kallsyms_on_each_core_symbol(const char *modname,
+				    int (*fn)(void *, const char *, unsigned long),
+				    void *data)
+{
+	return -EOPNOTSUPP;
+}
+
 /* For kallsyms to ask for address resolution.  NULL means not found. */
 static inline int module_address_lookup(unsigned long addr,
 						unsigned long *symbolsize,
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 0fc11e45df9b..3a959c3c9f9b 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -494,3 +494,49 @@ int module_kallsyms_on_each_symbol(const char *modname,
 	mutex_unlock(&module_mutex);
 	return ret;
 }
+
+/*
+ * Iterate @modname's cut-down core symbol table, rather than mod->kallsyms
+ * which points at the full init symbol table until do_init_module() swaps it
+ * out.  For callers which need a symbol's position to be the same before and
+ * after that swap.
+ *
+ * core_kallsyms is populated by add_kallsyms(), which runs before the module
+ * leaves MODULE_STATE_UNFORMED.
+ *
+ * Unlike module_kallsyms_on_each_symbol(), @modname is required.
+ */
+int module_kallsyms_on_each_core_symbol(const char *modname,
+					int (*fn)(void *, const char *, unsigned long),
+					void *data)
+{
+	struct mod_kallsyms *kallsyms;
+	struct module *mod;
+	unsigned int i;
+	int ret = 0;
+
+	if (!modname)
+		return -EINVAL;
+
+	guard(mutex)(&module_mutex);
+
+	mod = find_module_all(modname, strlen(modname), false);
+	if (!mod)
+		return -ENOENT;
+
+	kallsyms = &mod->core_kallsyms;
+
+	for (i = 0; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+
+		if (sym->st_shndx == SHN_UNDEF)
+			continue;
+
+		ret = fn(data, kallsyms_symbol_name(kallsyms, i),
+			 kallsyms_symbol_value(sym));
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
-- 
2.54.0

