Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274693;
	b=Oa7zTn7F2/veSrR50cSaRz5uzyJmq++2iouBbnYeevZFFQWl/SDcdjS4e5Y3ugrhR5/G
	 mwO2LaM3JN9GSv8enfEdmcaPeWVLUxck9eF3ZIfNkkXWWXWTE6/0B77x+cqqxelY8FQiK
	 uIM7/nSad3N6sprONS0GAB6dR4KmsT84fGVaO/MOvLxe3tRTNyCocyWvI5EfSv0W3aqoC
	 +XdP8R1n6Q6KwZJLif0GWhqSOHK0EvcwtLnDa4Hjz/R8gHktZI5/IPHSNaffn0n+0eUeI
	 ymB7XcNQ213JuKLd+tSfILz5xSlGQT7KKAKHCFxW3FWLbj2wjaoJoNgMT95uCAiRzOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274693;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q5YmmtbM1SABAOm/KP4HYIEpTxCJv3hCI3XTZLN6lEA=;
	b=22kvV/6/9+JwnZNb1Q8/z/cQFDqUb3aCrSazJJteXGYlJ9rgbzQv+SD3V5iWfJd048tj
	 pFcHWT0yMWjbCU+SEOVGZKAaGzTwYv5/zFXihecjqqzEyjBteNVPzL84UhofrAkbGRhJc
	 r1CZzPA8oEpLlXUa4/d0E9gN1Ev6mV9ELdRiIc1EcuDBo7dLQxDiZr8YRTeT+x2UrznvR
	 vkbHIIwvg24eENmt8NMTQKaSXzgA+olFTXLDksPa6uABawST7svv4F3c2ThzwZk+qQGzx
	 XScclJ5bNgqobtkMJZeXJhVN2eKtIjqU+Z92s0PPYzC2HFE4wtdPQPCfXy24GvmiZYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tgHpt3i0;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09360A260E;
	Tue, 10 Nov 2026 01:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D09360A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tgHpt3i0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794274689; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Q5YmmtbM1SABAOm/KP4HYIEpTxCJv3hCI3XTZLN6lEA=;
	b=tgHpt3i0o2bPdsXmVUsHIN7RVamzIAi8oQzF6lgvn2z0e1EsJhjLWsV/PhfL1FF9/c1XTHhQ2l/9UopJE6S4znCOE4KTRrtOrGKXWN6opEhgNQwkdol+BM7RLJ404HHHP685N1l7fF/DGLtwzysd0CWheYhlBE85WYEi/WU8nMM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0XETOX5x_1794274685;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XETOX5x_1794274685 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:38:07 +0800
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
Subject: [PATCH v7 05/10] riscv: stacktrace: disable KASAN and KCOV instrumentation for stacktrace.o
Date: Tue, 10 Nov 2026 09:37:45 +0800
Message-Id: <20261110013750.36800-6-xueshuai@linux.alibaba.com>
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

KASAN records stack traces for every alloc/free, which means it walks
the unwinder very frequently. Instrumenting the stack trace collection
code itself adds substantial overhead and makes the traces themselves
noisier.

KCOV instruments every basic-block edge. The unwinder is a hot path,
especially with KASAN enabled, so KCOV instrumentation has the same kind
of cost and noise problem here.

Mark stacktrace.o as not KASAN- or KCOV-instrumented, matching the x86
treatment of its stack unwinding code. RISC-V keeps the relevant unwinder
code in stacktrace.o, so a single translation-unit annotation covers the
equivalent scope. This is a prerequisite preference for the upcoming
reliable unwinder, but the change is valid on its own.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Tested-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/kernel/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f54c336bf547..c4c0f4d73368 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -44,6 +44,12 @@ CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
 endif
 
+# When KASAN is enabled, a stack trace is recorded for every alloc/free, which
+# can significantly impact performance. Avoid instrumenting the stack trace
+# collection code to minimize this impact.
+KASAN_SANITIZE_stacktrace.o := n
+KCOV_INSTRUMENT_stacktrace.o := n
+
 always-$(KBUILD_BUILTIN) += vmlinux.lds
 
 obj-y	+= head.o
-- 
2.39.3

