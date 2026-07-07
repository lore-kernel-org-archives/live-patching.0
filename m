Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B464426410
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409011; cv=none; b=shyyOeaxyF0G7YGUnbwnAHK7w4yYJ35SW28k0om1Gb2PSLpUHYkuC62lldtk6fYbOHwInclYfmRPGCU++EXAQB0wNuJanWrjCw5Cgvs6TrW4yDmMI2cgs77/e4q6NSs9tSEsjswNXpE6/THXqWcnUjdey2/JqX9inGI84+y7aiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409011; c=relaxed/simple;
	bh=TRE+wZe3+sfxk7zHnpCBwh2hoKCbh/nUceOcRYeIhj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQFZM5MmF8GVFh0R+L7t2bPEYZX5FyrXBH3smusxxAusKFs/SLEoS873Cl/N49muImltr0PZRwalmi/1KQVKod0OeuTtonR+g+64+jcO3q2tSl98dfdwAUqRmef0ILnHnXXHLGlvB4IyZa73/mSpX16tf7WLk9awmM7R6NrBvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p+tEWRW2; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p+tEWRW2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783409002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqmMptp8s2GmzxQeh1yY9uXsTdD6pQF4qnsThOVdAvU=;
	b=p+tEWRW2iYSNFld7ifHAzmdRGYOTwqxUlzjdjLM0LVSHjibVW4EROLLUGD2C29WxkoWPp9
	MC/j46e971j1l4tSNEQPSM/puTT1f0ibCRjBo37tgGc+ffkZDBMooG4I525wSM4rLqdFSv
	QEMOv8S5Hob8d4uRSi0LTVXVghQF9ro=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label references
Date: Tue,  7 Jul 2026 15:20:30 +0800
Message-Id: <20260707072031.231066-12-dongtai.guo@linux.dev>
In-Reply-To: <20260707072031.231066-1-dongtai.guo@linux.dev>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

create_fake_symbols() takes each annotated entry's offset from the
annotate relocation's addend alone.  That works only when the
relocation points at the special section's section symbol.  GCC/GAS
on LoongArch points it at the entry's local label instead, with a
zero addend: every entry then gets offset 0, the "distance to the
next annotation" size becomes 0, and the fallback sets the size to
the rest of the section.

So every fake symbol starts at offset 0 and covers the whole special
section.  If any entry in the section belongs to a patched function,
should_keep_special_sym() keeps such a symbol, and the output module
gets the entire __bug_table (thousands of entries and klp
relocations) instead of just the patched function's entries.

Compute the offset as sym->offset + addend, which handles both the
section symbol form (sym->offset == 0) and the local label form
(addend == 0).

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/klp-diff.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 05fd70e24326..0fa3ce324346 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1863,7 +1863,12 @@ static int create_fake_symbols(struct elf *elf)
 		if (annotype(elf, sec, reloc) != ANNOTYPE_DATA_SPECIAL)
 			continue;
 
-		offset = reloc_addend(reloc);
+		/*
+		 * The annotated location may be referenced via the section
+		 * symbol plus addend, or via a local label (GCC/GAS on
+		 * LoongArch): sym->offset + addend covers both forms.
+		 */
+		offset = reloc->sym->offset + reloc_addend(reloc);
 
 		size = 0;
 		next_reloc = reloc;
@@ -1875,7 +1880,7 @@ static int create_fake_symbols(struct elf *elf)
 			    next_reloc->sym->sec != reloc->sym->sec)
 				continue;
 
-			size = reloc_addend(next_reloc) - offset;
+			size = (next_reloc->sym->offset + reloc_addend(next_reloc)) - offset;
 			break;
 		}
 
-- 
2.25.1

