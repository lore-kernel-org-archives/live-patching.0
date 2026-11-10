Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274696;
	b=YkaMfomGiL4dx8u2SmOZXyu8HBIIhL30BsVlvATeiX0PAq4ZdcLN+C0cNTpbkvlhXpgq
	 3OOLPmH4Ya9O5paVp+ax4jkfGT/iWLTw2d95Ha18enE6gCMOuBVvz+RqZStUXoDbRj44P
	 NouJE0swVvLWbLUn0aG/je1dUDKZ5Z292UY3IaOcFwDkqefWbIWY4Z81lxE8BPFF6vSpP
	 6WP8F62pFLvVlbz9yfw9tlZZjqMMOWsIvyOMuc4h2kTy/IYjtTSdTyWUykids7Z/LRfYz
	 XMuW+BIAHfi8+k2ubBkWdamEIdyPiBtvWc9IQsr08E7HmatIO0jSXAkU4xyFuIEbsaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274696;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+/j56V+Dn6hnNsHW1N9gcti2dwgaRWtnAvBsP9OENaw=;
	b=x7mZmpdgSgcap9C4q8KJOOv9tSZqoF9HklzTelTT3vqG3baYcFGNPBmuPKvkyEPrIxCZ
	 3dY9RN7xZLMTyKG2g/vRcmdNhXXDSRTyxDDMk1zjjMiQEdDEUqqeFw9qp2Hy4AsoicWbB
	 XtoYDQs8WML7bn0dbGPGEr7vZJ9+7hQl3G9rUBiuHjt7WfIhCricz6m0WfQFNoCX8OBbG
	 8ae/e5WA9GdJ6xq1qncpFFoxaspVi/o3bdtfmQisMIfTOoIUBKtsLpGQ0CQbYWyM86IJd
	 ejAO/lnKjDyoM71C/UCHmFTevnAoYWuyakLy0D92KO/flMxkLQlFhJJFSWcA9dKeGFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MsihZXQH;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75D606A334;
	Tue, 10 Nov 2026 01:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E75D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MsihZXQH
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794274692; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+/j56V+Dn6hnNsHW1N9gcti2dwgaRWtnAvBsP9OENaw=;
	b=MsihZXQHv+X9oY5qUlmI+XvUU1fq/ziqqJ77ImZOw8uiw2fVqhBMWFEIR8WUuQZwva53ZsGYdGwz/E+4Azv1n1cly0gsxg8PS0i8nwRP/oGBiTNC1XVd8scA5ksqqR2wXDlk6ztSThmA9eQ7+usB9qlCqbnmKctYLXnUg0mDFVA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0XETOX7H_1794274688;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XETOX7H_1794274688 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:38:10 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	mpdesouza@suse.com,
	martin@kaiser.cx,
	kmehltretter@gmail.com,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 06/10] riscv: ftrace: always preserve s0 in dynamic ftrace register frame
Date: Tue, 10 Nov 2026 09:37:46 +0800
Message-Id: <20261110013750.36800-7-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261110013750.36800-1-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Han <wanghan@linux.alibaba.com>

struct __arch_ftrace_regs declares s0 unconditionally, and both
ftrace_regs_get_frame_pointer() and ftrace_partial_regs() read it
unconditionally. But the SAVE_ABI_REGS / RESTORE_ABI_REGS macros in
mcount-dyn.S only stored s0 under HAVE_FUNCTION_GRAPH_FP_TEST
(CONFIG_FUNCTION_GRAPH_TRACER && CONFIG_FRAME_POINTER). With
CONFIG_FRAME_POINTER=n the slot held whatever was on the stack before,
so any callback going through ftrace_partial_regs() saw a garbage
regs->s0. RISC-V kernels default to FRAME_POINTER=y, which is why this
has not bitten in practice.

Save and restore s0 unconditionally in the dynamic ftrace ABI register
frame. This fixes the latent garbage-s0 case, brings the dynamic ftrace
path in line with the static _mcount path (mcount.S SAVE_ABI_STATE
already saves s0 unconditionally), and matches the frame layout already
documented in the comment above SAVE_ABI_REGS. It is also a prerequisite
for the upcoming reliable unwinder, which reads
ftrace_regs_get_frame_pointer(fregs) directly.

The cost is one extra REG_S/REG_L pair per traced call, negligible
compared to the overall ftrace cost; the existing FREGS_SIZE_ON_STACK
already reserved the slot, so no extra stack space is used.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Tested-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/kernel/mcount-dyn.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 082fe0b0e3c0..26c55fba8fec 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -85,9 +85,7 @@
 	addi	sp, sp, -FREGS_SIZE_ON_STACK
 	REG_S	t0,  FREGS_EPC(sp)
 	REG_S	x1,  FREGS_RA(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	REG_S	x8,  FREGS_S0(sp)
-#endif
 	REG_S	x6,  FREGS_T1(sp)
 #ifdef CONFIG_CC_IS_CLANG
 	REG_S	x7,  FREGS_T2(sp)
@@ -113,9 +111,7 @@
 	.macro RESTORE_ABI_REGS
 	REG_L	t0, FREGS_EPC(sp)
 	REG_L	x1, FREGS_RA(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	REG_L	x8, FREGS_S0(sp)
-#endif
 	REG_L	x6,  FREGS_T1(sp)
 #ifdef CONFIG_CC_IS_CLANG
 	REG_L	x7,  FREGS_T2(sp)
-- 
2.39.3

