Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC237E5F9
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893545; cv=none; b=KWHys62Pz6iME1mzsg1TR4PBtmoGNlvpfmbAjuR3EbA/WM0/mFBBoFr6CvamelI/To2PcZwQsCISt/6yGZM6TGDdPEBeyYPU/osp1m4+MBGJKYeo7+4Pq2YtSFBT8tq9U2HNNTqTF9IBTgY828k/4kYq9LmuPUTyxISIUNEdmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893545; c=relaxed/simple;
	bh=16rzf+qzWNXObKuK83MOC2na7VFzAB9eGdvs8zN80YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fttL++urweF2adOivD0ySm5G8oLQEwG5vYHUCv6ZX6x2PhlADz8xbZnQLwkgebViY46RmeEm9L2z5ZdfClIlukYZgDpoQk+ISl0s3O7iyJUDziBVfafoeSYHXUeLGWZFWuLBEUVg8fw6p3NnpuPqMcqpUlMNWwk3AmVE/9+xeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eEMnYHAy; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eEMnYHAy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgzBqynfoZaxFoS1KfD08vyQRws3QN+VgwIwrElk/Ts=;
	b=eEMnYHAyZAMi3vx73G3SFKcesdVsn0xu9Wfqj3DwfvCGeXAKvIrmiEapK5YLQLi0myYaRu
	mYDZKkstdpWgumyWdlOpvw2gF5Z9ab6PdmHzElEyWN3IWrvnBVZ3KV9I+Y4gxdY0hEa8gy
	3594ymNp0/DY6uVRHppxMhkyF/k2+68=
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
Subject: [PATCH v4 13/14] objtool/klp: Keep LoongArch tablejump annotation table entries
Date: Fri, 24 Jul 2026 19:41:26 +0800
Message-ID: <20260724114128.31451-14-dongtai.guo@linux.dev>
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

With -mannotate-tablejump, LoongArch compilers emit a
.discard.tablejump_annotate section.  Each entry is a pair of 8-byte
words: the address of a jump instruction and the address of its jump
table.  objtool reads these pairs to find switch jump tables when
decoding.

klp-diff creates one fake symbol per 8-byte word and clones a word only
if should_keep_special_sym() accepts it.  The default rule keeps a word
only if it references a function that was cloned into the output
module.  The instruction-side word references the function and is
kept.  The table-side word references the jump table via its .rodata
section symbol, which is not a function symbol, so it is dropped.

The cloned annotate section then holds only instruction-side words,
compacted together.  The pairing is destroyed.  Parsing the malformed
section crashes objtool on the patch module and no .ko is produced:

  Building patch module: livepatch-shadow-newpid.ko
  livepatch-shadow-newpid.o: error: SIGSEGV: objtool crash!

Keep all .discard.tablejump_annotate words whose referenced symbol has
been cloned.

Reproduced with the shadow-newpid test, which patches
proc_pid_status().  That function contains two switch jump tables.

Before, klp-diff clones only the instruction-side words:

  DEBUG: vmlinux.o: _discard_tablejump_annotate_57441 [+DATA]
  DEBUG: vmlinux.o:         .discard.tablejump_annotate+0x0: proc_pid_status+0xc70 [FUNC GLOBAL]
  DEBUG: vmlinux.o: _discard_tablejump_annotate_57443 [+DATA]
  DEBUG: vmlinux.o:         .discard.tablejump_annotate+0x8: proc_pid_status+0xd2c [FUNC GLOBAL]

After, the full pairs are kept, including the .rodata table words:

  DEBUG: vmlinux.o: _discard_tablejump_annotate_57441 [+DATA]
  DEBUG: vmlinux.o:         .discard.tablejump_annotate+0x0: proc_pid_status+0xc70 [FUNC GLOBAL]
  DEBUG: vmlinux.o: _discard_tablejump_annotate_57442 [+DATA]
  DEBUG: vmlinux.o:         .discard.tablejump_annotate+0x8: .rodata.proc_pid_status+0x0 [SECTION]
  DEBUG: vmlinux.o: _discard_tablejump_annotate_57443 [+DATA]
  DEBUG: vmlinux.o:         .discard.tablejump_annotate+0x10: proc_pid_status+0xd2c [FUNC GLOBAL]
  DEBUG: vmlinux.o: _discard_tablejump_annotate_57444 [+DATA]
  DEBUG: vmlinux.o:         .discard.tablejump_annotate+0x18: .rodata.proc_pid_status+0x80 [SECTION]

and the patch module builds.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/klp-diff.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 92cf0fc3ff2f..f151ffc71184 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1956,6 +1956,7 @@ static int create_fake_symbols(struct elf *elf)
 static bool should_keep_special_sym(struct elf *elf, struct symbol *sym)
 {
 	bool annotate_insn = !strcmp(sym->sec->name, ".discard.annotate_insn");
+	bool tablejump_annotate = !strcmp(sym->sec->name, ".discard.tablejump_annotate");
 	struct reloc *reloc;
 
 	if (is_sec_sym(sym) || !sym->sec->rsec)
@@ -1968,6 +1969,16 @@ static bool should_keep_special_sym(struct elf *elf, struct symbol *sym)
 		if (!reloc->sym->clone || is_undef_sym(reloc->sym->clone))
 			continue;
 
+		/*
+		 * .discard.tablejump_annotate (LoongArch -mannotate-tablejump)
+		 * holds pairs of words: a jump instruction and its jump table.
+		 * The table word references the table via its .rodata section
+		 * symbol, which the is_func_sym() rule below would drop,
+		 * breaking the pairing.  Keep both words of each entry.
+		 */
+		if (tablejump_annotate)
+			return true;
+
 		/*
 		 * Keep special section references to cloned functions.
 		 * In some cases annotate_insn can also reference cloned alt
-- 
2.53.0

