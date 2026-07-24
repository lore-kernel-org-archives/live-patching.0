Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3F3DC850
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893552; cv=none; b=WGlh1yOg+F8uLq0Rsm4M1/sjp6Gl5PA+QaZl7oWjc8BP+shOWgeCgPUYzKLllmeDK2Zw7q3KerSfPmK6cIhj9JCbFcOmmH4eWS1NoRbupFXUeiFSyUA7jc7DeaLtUyhSNQYbid+jodSAdGowP98yS3f/6VS9CU++aeM5EgNKUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893552; c=relaxed/simple;
	bh=+EwcJGyjyyjcMkO5A9AdRmuju22Ek3rMbdBo+iANy7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD9cbBIKpXI2p0BErJgC2tFFoxELMVaLp1j443bZIPcPHmPodNlK73zewzHVGXYRU4GPxE/0NhgKWIXMRCvTS2TgCPi6vcN8zz0Lzon4ovJf4Wy5wMXtSxE254gIwXzHa6/DLjM/39BUvSOusbNM7RLl3m39Ft9wQhlutIaM7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r9MfNsHR; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9MfNsHR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18qWUBFyGokEbNhqKGAmxikEqxfS9peDgddO3aKzKXI=;
	b=r9MfNsHRhsBDq6cWq1zcTg9PYKqeMeK1ZHXHQis0l1F7aVefvkXlyphPGW4VGon19odeLH
	WTSubANUtPohjXeAxDNhIzXNpeNGSUn+9BbRbjvas+J0YhsKDmDnAP1t2ZE4TOntL0Khz5
	GsEQ0XurjW8QgSz3s9yBSUBpMW+d1vM=
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
Subject: [PATCH v4 12/14] objtool/LoongArch: Enable inline alternative cloning for KLP
Date: Fri, 24 Jul 2026 19:41:25 +0800
Message-ID: <20260724114128.31451-13-dongtai.guo@linux.dev>
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

An ALTERNATIVE() emits its replacement instructions into a .subsection 1
placed after the patched function.  When objtool clones the function into
a livepatch module, clone_inline_alternatives() clones that replacement
block too, but only for architectures that define ARCH_HAS_INLINE_ALTS.

LoongArch uses the same .subsection layout as arm64, and its alternative
macros now mark the replacement with ANNOTATE_DATA_SPECIAL (see "LoongArch:
Mark special sections for KLP support").  Define ARCH_HAS_INLINE_ALTS so
the replacement is cloned; otherwise a livepatch for a function containing
an ALTERNATIVE() fails to build with "can't find new instruction".

Reproduced by building a livepatch for a function containing an
ALTERNATIVE() (the base-vmlinux test).
Link: https://lore.kernel.org/all/ak7QBSm3mmDlB-4u@redhat.com

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/arch/loongarch/include/arch/elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index 0103f27fccfc..e2843679f24e 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -46,6 +46,7 @@
 #define R_TEXT32		R_LARCH_32_PCREL
 #define R_TEXT64		R_LARCH_32_PCREL
 
+#define ARCH_HAS_INLINE_ALTS	1
 #define ARCH_HAS_PAIRED_RELOCS	1
 
 struct elf;
-- 
2.53.0

