Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343913E51FD
	for <live-patching@vger.kernel.org>; Fri, 27 Mar 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609224; cv=none; b=H8W2lKZ7/6rpoHIuAk7eTqIOl7bruPkKdElxY+oWwom5OmCxkBNOguVOeAnF7P7KyitqB6zNtdJDScrt67DZMVcsoagE5tci9NBdxxF3sNsc14eyC716PRFqiUmYhxmTM7hmATXqEdMErJTD3x2tcpm5gGQca7w0a0f5wybC4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609224; c=relaxed/simple;
	bh=nrnsHUz7/k/GUUXVjLVXMiD7Ts+e/jGMmi0H77ovY2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BRlDq7yqI47H3qNIHqtXmIS4vIg9x0VzDiSGXrdLc+NN4jkBHYDzrtnyaMvnL8yWo0WI5A2noEz2GLBq6fraAaYQq3u3hkfHvARW/frLMSLw0vEl664xzEXoNDn2+GT3Vt7Nj+gKr9x6rWUR20o9uNoA0YTxL1Vbq8jaIocP9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=KyRusaRx; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="KyRusaRx"
Received: (wp-smtpd smtp.wp.pl 19510 invoked from network); 27 Mar 2026 12:00:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774609207; bh=0tuv4FfKBKr6pfb0Zpw0fG5uTeoZMPynNgZXrQMlRdg=;
          h=From:To:Cc:Subject;
          b=KyRusaRxgqYdpjFnFpgkoRU6WRMrO4P9/K/87xY9wzL6l/bDPsO3zHR17NGXfjVBg
           8Uk3BHyM7Ifauu0p6Tl7VYXdj2M4iRyAaDkkB5xfmMCu6FMuiDUbKtWzOaUFiq+Kys
           A4D4nK/IvqnAvP5LweZNadyHxJmtWAgkTaloSoV1dp5g1obOA50SbvEXM6ev1UOe5x
           /M7f0kyj0vknySfwuNxaXt6qy1mrKoozUJAQYAV9DPsPWvMQhqP1BkOZp6y1UF/tfF
           AhGufyUPdVn64So44cxFkauYP8BITW4p0aK8dho+QUFkwGzwqW91QHuz3cbtAs2bwF
           pWINHecCPEHDg==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux-modules@vger.kernel.org>; 27 Mar 2026 12:00:07 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux-modules@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 1/2] module/kallsyms: fix nextval for data symbol lookup
Date: Fri, 27 Mar 2026 12:00:04 +0100
Message-Id: <20260327110005.16499-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: e0d26d1a0bf3dbd632a0485b0efa94ed
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IWNk]                               

The symbol lookup code assumes the queried address resides in either
MOD_TEXT or MOD_INIT_TEXT. This breaks for addresses in other module
memory regions (e.g. rodata or data), resulting in incorrect upper
bounds and wrong symbol size.

Select the module memory region the address belongs to instead of
hardcoding text sections. Also initialize the lower bound to the start
of that region, as searching from address 0 is unnecessary.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
v1 -> v2: new patch.

 kernel/module/kallsyms.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 0fc11e45df9b..f23126d804b2 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -258,17 +258,25 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	unsigned int i, best = 0;
 	unsigned long nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference(mod->kallsyms);
-	struct module_memory *mod_mem;
+	struct module_memory *mod_mem = NULL;
 
-	/* At worse, next value is at end of module */
-	if (within_module_init(addr, mod))
-		mod_mem = &mod->mem[MOD_INIT_TEXT];
-	else
-		mod_mem = &mod->mem[MOD_TEXT];
+	for_each_mod_mem_type(type) {
+#ifndef CONFIG_KALLSYMS_ALL
+		if (!mod_mem_type_is_text(type))
+			continue;
+#endif
+		if (within_module_mem_type(addr, mod, type)) {
+			mod_mem = &mod->mem[type];
+			break;
+		}
+	}
 
-	nextval = (unsigned long)mod_mem->base + mod_mem->size;
+	if (!mod_mem)
+		return NULL;
 
-	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
+	/* Initialize bounds within memory region the address belongs to. */
+	nextval = (unsigned long)mod_mem->base + mod_mem->size;
+	bestval = (unsigned long)mod_mem->base - 1;
 
 	/*
 	 * Scan for closest preceding symbol, and next symbol. (ELF
-- 
2.50.1

