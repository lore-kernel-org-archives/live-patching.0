Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238E3093D8
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893489; cv=none; b=Z+iWAJ7w+0mDxllqfblISb+ZLoujbQ6pp+GP8sceecWMC7aEd8yKkReI5qlLkBArkpBhmRYcaw962fm1QgLWXEJdfYtc86dAzEvIfdncletszAjVleguS+Ll8IVb4gNm1mffjo4blj/DtS9x5sRyT8nSxu4JZdNQ0HqWL6QbwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893489; c=relaxed/simple;
	bh=CaFOpuuLUh9zgCRxgo2wwmY+NQu80AqfooJ+NmN19x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhpPNAjhkUkq8vhc3PHE0yMyfJD7lHcSDTbOBzFB/GZY3G6CAQtwY6TsxEiCqaa3WZ89ZffIKpd/c/0DlNPMf4J7MfMrJQANjNCHa8OqbZHW4W9mkR/UZZoGPTvRWRJE8E301r21ueM5i7OlJqsjVUvrrUSRJudesvmGjftLjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qEae7tMi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qEae7tMi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvQulOLnt6zPtOVaClrSdA4fxpkNIXdPTLy0qFfUDyc=;
	b=qEae7tMimh/BGqp58tT+Ftc7+Bgw99QaK1z2c1Cn2Fx+mB8nI4aWqjER/jw4s55utvEP//
	8SBuUDaYBT53nbAOjCCXCBgKyUt8id2PRsALAfax6v+DjitDeDRHL0wysj5XC7YvA1ZSCm
	A+fMK2f+oXBPTJjtTRAvoCzKZqqk45M=
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
	wangrui@loongson.cn,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/14] objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label references
Date: Fri, 24 Jul 2026 19:41:23 +0800
Message-ID: <20260724114128.31451-11-dongtai.guo@linux.dev>
In-Reply-To: <20260724114128.31451-1-dongtai.guo@linux.dev>
References: <20260724114128.31451-1-dongtai.guo@linux.dev>
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
index 3e573b73fe6b..a952e680e8a6 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1877,7 +1877,12 @@ static int create_fake_symbols(struct elf *elf)
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
@@ -1889,7 +1894,7 @@ static int create_fake_symbols(struct elf *elf)
 			    next_reloc->sym->sec != reloc->sym->sec)
 				continue;
 
-			size = reloc_addend(next_reloc) - offset;
+			size = (next_reloc->sym->offset + reloc_addend(next_reloc)) - offset;
 			break;
 		}
 
-- 
2.53.0

