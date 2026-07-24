Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF842A788
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893417; cv=none; b=WFri37aaBA/QQLvdEQbX4y62QuEdl5xmhjGWFf+SkC5Rc5vbPocAjhWfnaOKVqUH9h6C9zPy2q/vu6IqQLwERb1jF/l2hhjk6D8Sd5RhNaDRBJCgmk16ulmmIendK6m3AjyyYxwGR6MezQjGCkK35JHzvR2NWOSh8n/DmzRgbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893417; c=relaxed/simple;
	bh=vWZ2f6qLJn8k5AwIqGBaX6o9NuboH8z04KTf0fV6LSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5RSQJcuCjnPPVrKtj4/O2ebzNtZay525ly21fMi2WohJdwXNTZZulMdll1+I8bZY6I0U81CwVNfkUMt3reZ7Rn0CiKCv3r5YQ9i+7GBxw5FPpDTCuN9TFcp8BBeLuBJ8EkxxGNzO7ZNfj1lhf1Hdwtgkk4/2oPNChXaJ2aa720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bs6JK7id; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bs6JK7id"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7joukHFcR2YlJrUdrRU9RAszNALKTouzih+0IOutSo=;
	b=Bs6JK7idysRnF8e91HbePH1q0OK90zj1NUS7gTmNtysWgYFCAyBJwxHFKuSVS3tbNEBIGp
	oiqsYRsSiaw44OfTlCSt1tjUfeHGuuspplGGYusyv3TnF4k8cW7dqc0ssudbJaNjB3ZbXt
	dBp+Gy5ULPpGDqDcxcDecx61TN5dZp0=
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
Subject: [PATCH v4 05/14] objtool/klp: Add LoongArch jump opcode bytes support
Date: Fri, 24 Jul 2026 19:41:18 +0800
Message-ID: <20260724114128.31451-6-dongtai.guo@linux.dev>
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
2.53.0

