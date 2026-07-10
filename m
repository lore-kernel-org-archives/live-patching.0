Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBE3EEAF9
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697455; cv=none; b=a0K38QG3UfqvBdv34AZuYFrInvZ/IULy/4ajU1Nv+ONVMCXH/dkPIjzqbPKA3rVhuZeFpkRxMDEMtiOPdayN3hoqfmc0RZX47ThEu+dmexXXvoSTkAWhBkrnEPHIyveksKYEudN+0KMp2g0+gsj5KSnrYaaSJ6gxX8AFWWtyvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697455; c=relaxed/simple;
	bh=c3GKGppjfXmH+VgaA/JiQGmwaFjcivdUJSdynDUIJ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=sVYZPWorRadAuHL9Rdy645IOVXOd0na3oJXx41FI5TQrz1tt2C+F/+bizbYRx70yAXKz+W4hSxE7cVrArDCnNUtUvZPq4E74PUy7QtogQA8OztsPe+CiAgIEaOeh8BqRogcfW0DP7JxlKyqKpNom+CMtAE52+e7oDFfxsLc3SYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPhP8Qw2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPhP8Qw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783697453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2nVvr7K7TvFnV7MXCvGdl11WHIjqjTq0nn4C5kZ/kU=;
	b=GPhP8Qw2O3Ex84s02Qo3dR1JFfFfNFR85Nd0lVrtEPwXmbZc/4LqfK2nODB3gf+LKbcMO3
	HCEDW6tPetOJr1yo6xVNofhHThkhOlV77krmm1nQU32DzthplPOqwgrFjZdViAMgnzx7iV
	45OLqh/iMOiAR281B+G2tWpyiiYTyvc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-oM9A3KjwO-Kmc_KIE7Fbng-1; Fri,
 10 Jul 2026 11:30:50 -0400
X-MC-Unique: oM9A3KjwO-Kmc_KIE7Fbng-1
X-Mimecast-MFC-AGG-ID: oM9A3KjwO-Kmc_KIE7Fbng_1783697449
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E78FF19560A6;
	Fri, 10 Jul 2026 15:30:48 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1068C1800592;
	Fri, 10 Jul 2026 15:30:46 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Ben Procknow <bprockno@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 1/1] objtool/klp: fix symbol ordering for data symbols
Date: Fri, 10 Jul 2026 11:30:42 -0400
Message-ID: <20260710153042.3156788-2-joe.lawrence@redhat.com>
In-Reply-To: <20260710153042.3156788-1-joe.lawrence@redhat.com>
References: <20260710153042.3156788-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The find_sympos() function calculates a sympos (symbol position) used by
livepatch to disambiguate duplicate symbol names.  At runtime, kallsyms
iterates symbols sorted by address, so sympos must reflect that order.

For function symbols, there's already a workaround that counts
.text.unlikely symbols before other .text symbols, matching the linker
script's section ordering.

Data symbols suffer the same problem: the linker script places sections
in this order:

  .data..ro_after_init (lowest address)
  .data* sections
  .bss* sections (highest address)

However, vmlinux.o's symbol table is ordered by object file link order
(kernel/ before fs/, etc.), which can differ from the final address
order.

Extend the existing section ordering workaround to handle data symbols,
counting .data..ro_after_init first, then other .data, then .bss.

Reported-by: Ben Procknow <bprockno@redhat.com>
Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-diff.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index c2c4e4968bc2..1c6f9f6d7565 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -509,6 +509,46 @@ static unsigned long find_sympos(struct elf *elf, struct symbol *sym)
 					has_dup = true;
 			}
 		}
+	} else if (vmlinux && is_object_sym(sym)) {
+		/*
+		 * HACK: Similarly, data symbol ordering can differ between
+		 * vmlinux.o and vmlinux.  The linker script places sections:
+		 *   .data..ro_after_init (lowest address)
+		 *   .data* sections
+		 *   .bss* sections       (highest address)
+		 * Count in that order.
+		 */
+		for_each_sym(elf, s) {
+			if (strstarts(s->sec->name, ".data..ro_after_init") &&
+			    !strcmp(s->name, sym->name)) {
+				nr_matches++;
+				if (s == sym)
+					sympos = nr_matches;
+				else
+					has_dup = true;
+			}
+		}
+		for_each_sym(elf, s) {
+			if (!strstarts(s->sec->name, ".data..ro_after_init") &&
+			    !strstarts(s->sec->name, ".bss") &&
+			    !strcmp(s->name, sym->name)) {
+				nr_matches++;
+				if (s == sym)
+					sympos = nr_matches;
+				else
+					has_dup = true;
+			}
+		}
+		for_each_sym(elf, s) {
+			if (strstarts(s->sec->name, ".bss") &&
+			    !strcmp(s->name, sym->name)) {
+				nr_matches++;
+				if (s == sym)
+					sympos = nr_matches;
+				else
+					has_dup = true;
+			}
+		}
 	} else {
 		for_each_sym(elf, s) {
 			if (!strcmp(s->name, sym->name)) {
-- 
2.54.0

