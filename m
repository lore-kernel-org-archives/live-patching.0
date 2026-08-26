Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954E3B4EA4
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773821; cv=none; b=RMqjdUrne1eVMVRtVon5iNQvKTVhPzNv5QLo96GV7eLkIMYdn+CHIeEBLHK02mb0IzORgI/wYZCGbKEsC6z34utMha6RR5rdfoqraQIVYFUgMoZRQuI7z9mm2ffDDA6D0ltTO+6v49sxYtm1ifbKIFeMPgF90+Ew6WH2R3LpByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773821; c=relaxed/simple;
	bh=J8B8bRZRyctvVnAuGlJ3w78i19weh055An38kJv9J08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=SXzwQkCeJXY74GwWcPVCp+52XJuk/Xj5qLKU0wZQVx4l7044NGHKGK8zg96aMU6v4aFq/cjSFNuDSqztts3JHL8YDnhv5gwnOrDGoU7z8sLoODzvLzF/Vm2zTNYmgwGJsnVYS6p+kjuLJ58e5dX21oLLcwphjg5B6y24RdyQrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WI5rEBHY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI5rEBHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIzXD75edV/cIPqeb4p1kvOcxJSAFOx2/iqu04v/n+I=;
	b=WI5rEBHYnqWP9qLdGfGwSKP8XMcUxi2wBqlbRx2+cThbUmyfTz39TrrsJWQX30DQskcqSi
	uOIDVRJUMcUVQ8XvlebaPAQl2l8R3GN5xSZS4K6XWAVS5vCH+jf60GeBQl53Q5SZ6h91/J
	vgYkHskbsizZOhjAsAObam454lgRC64=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-bQ2G4Pi6O1-2VsRQIqL8lg-1; Wed,
 26 Aug 2026 15:50:08 -0400
X-MC-Unique: bQ2G4Pi6O1-2VsRQIqL8lg-1
X-Mimecast-MFC-AGG-ID: bQ2G4Pi6O1-2VsRQIqL8lg_1787773807
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31B441801356;
	Wed, 26 Aug 2026 19:50:07 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 255D230002ED;
	Wed, 26 Aug 2026 19:50:05 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 3/7] objtool/klp: allow special section entry size overrides
Date: Wed, 26 Aug 2026 15:49:56 -0400
Message-ID: <20260826195000.455905-4-joe.lawrence@redhat.com>
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

Special section entry sizes (ALT_ENTRY_SIZE, JUMP_ENTRY_SIZE,
EX_ENTRY_SIZE) are built into objtool from arch-specific headers.  When
processing cached unit test objects that were built from a different
kernel version, these compiled-in sizes may not match the objects'
actual entry sizes, causing create_fake_symbols() to incorrectly parse
special sections.

Allow the user to override the compiled-in defaults via environment
variables of the same name.  When unset, behavior is unchanged.  This
will enable a klp-diff unit test runner to pass the correct entry sizes
from test metadata.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-diff.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f40c128fdd49..4195b3ccff15 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -21,6 +21,8 @@
 #include <linux/string.h>
 #include <linux/jhash.h>
 
+#include <arch/special.h>
+
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
 struct elfs {
@@ -1638,6 +1640,22 @@ static int clone_sym_relocs(struct elfs *e, struct symbol *patched_sym)
 
 }
 
+static unsigned int entry_size_from_env(const char *name, unsigned int def)
+{
+	const char *str = getenv(name);
+	char *end;
+	unsigned long val;
+
+	if (!str)
+		return def;
+
+	val = strtoul(str, &end, 10);
+	if (*end || !val)
+		return def;
+
+	return val;
+}
+
 static int create_fake_symbol(struct elf *elf, struct section *sec,
 			      unsigned long offset, size_t size)
 {
@@ -1781,6 +1799,27 @@ static int create_fake_symbols(struct elf *elf)
 		}
 
 		entry_size = sec->sh.sh_entsize;
+
+		/*
+		 * Some special sections have multiple relocs per entry,
+		 * so the reloc-based heuristic below doesn't work.  Use
+		 * the arch-defined entry sizes for known special sections.
+		 */
+		if (!entry_size) {
+			if (!strcmp(sec->name, ".altinstructions"))
+				entry_size = entry_size_from_env("ALT_ENTRY_SIZE", ALT_ENTRY_SIZE);
+			else if (!strcmp(sec->name, "__jump_table"))
+				entry_size = entry_size_from_env("JUMP_ENTRY_SIZE", JUMP_ENTRY_SIZE);
+			else if (!strcmp(sec->name, "__ex_table"))
+				entry_size = entry_size_from_env("EX_ENTRY_SIZE", EX_ENTRY_SIZE);
+
+			if (entry_size && sec_size(sec) % entry_size) {
+				ERROR("%s: entry size %u doesn't divide section size %lu",
+				      sec->name, entry_size, sec_size(sec));
+				return -1;
+			}
+		}
+
 		if (!entry_size) {
 			entry_size = arch_reloc_size(sec->rsec->relocs);
 			if (sec_size(sec) != entry_size * sec_num_entries(sec->rsec)) {
-- 
2.55.0

