Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425793D9699
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556209; cv=none; b=sNSxYQL4AnVgo9fIgsEsByhKRKfQiifOuqKB+xYxsm9Nqm9V1x1DeWSrkijYNOmgHf9vvB3VBOblfQbv6YKacu6SRg2EJAXJWBzD2VWmbXxInbxiR6UvUUK6oJL2Eu1Bcu9ZrXoG6nGedhJnBSUB4tI9SFx/bUY4XnBSnjyMd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556209; c=relaxed/simple;
	bh=cDfZSz3ivvl1QfWZ9jvAA+VablcjicxvJ0V6T4B9iOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUI37yt7rrn2Ca5piGaeEjK4fQ+RpvrKewMOJmxpVB4Dqe1BGw0vLNnbvC+G6YiP8U4ZwOJ8aIdKYCV9hrN90SJcA0iQOyuf/WI7Z46aUKnNFPI7/lVCcQxFXuxkgNnuaUOiR98GnP8apcGS0xYFTQ8q5IiwhlDb3Y0qRTuEmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qw/LD98X; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qw/LD98X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjOt6p1vyAYaMNIqwKJQkplVc88EqcFx+7171iEr4bE=;
	b=qw/LD98Xc9AvH7ZbB0k5aNJcUKoq562Ef7c2MoKZ7WPcJT4lwIT8IutXQEnzYfooS9VRKR
	7PdhHGKhC7m7QtjytaG5LctnehDHX1W0Ib24e6ZCjvwNpXeDtXQC0GzVDlF7l7oTMpsoS+
	cEtx131EP2eT2xE3p45kBwyL/vK0Fn0=
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
	xry111@xry111.site,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 7/8] objtool/klp: Add LoongArch jump opcode bytes support
Date: Thu,  4 Jun 2026 14:53:16 +0800
Message-Id: <20260604065317.219777-8-dongtai.guo@linux.dev>
In-Reply-To: <20260604065317.219777-1-dongtai.guo@linux.dev>
References: <20260604065317.219777-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Implement arch_jump_opcode_bytes() for LoongArch so that klp checksums
for jump/call instructions with non-relocated destination offsets are
position-independent, mirroring the x86 and arm64 implementations.

Mask out the embedded branch offset while preserving the opcode and the
register operands, which differ per instruction format:

  - B/BL (reg0i26):                  no regs -> 0xfc000000
  - BEQZ/BNEZ/BCEQZ/BCNEZ (reg1i21): keep rj/cj -> 0xfc0003e0
  - JIRL/BEQ/BNE/.../BGEU (reg2i16): keep rj/rd -> 0xfc0003ff

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/arch/loongarch/decode.c | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 674e4efd138f..12facd0cc8d1 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -432,6 +432,47 @@ unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *tabl
 	}
 }
 
+size_t arch_jump_opcode_bytes(struct objtool_file *file, struct instruction *insn,
+			      unsigned char *buf)
+{
+	union loongarch_instruction *code;
+	u32 insn_word;
+
+	insn_word = le32toh(*(u32 *)(insn->sec->data->d_buf + insn->offset));
+	code = (union loongarch_instruction *)&insn_word;
+
+	switch (code->reg0i26_format.opcode) {
+	case b_op:
+	case bl_op:
+		/* reg0i26: 26-bit offset, no register operands */
+		insn_word &= 0xfc000000;
+		break;
+	case beqz_op:
+	case bnez_op:
+	case bceqz_op:		/* == bcnez_op */
+		/* reg1i21: keep opcode + rj/cj at bits[9:5] */
+		insn_word &= 0xfc0003e0;
+		break;
+	case jirl_op:
+	case beq_op:
+	case bne_op:
+	case blt_op:
+	case bge_op:
+	case bltu_op:
+	case bgeu_op:
+		/* reg2i16: keep opcode + rj/rd at bits[9:0] */
+		insn_word &= 0xfc0003ff;
+		break;
+	default:
+		break;
+	}
+
+	insn_word = htole32(insn_word);
+	memcpy(buf, &insn_word, sizeof(insn_word));
+
+	return LOONGARCH_INSN_SIZE;
+}
+
 #ifdef DISAS
 
 int arch_disas_info_init(struct disassemble_info *dinfo)
-- 
2.25.1

