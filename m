Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C112312834;
	Mon, 14 Sep 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378029; cv=none; b=OHEc5C5wGQuCF5vUP1TnnH0u/d5rv+TLq84nfhrePFRb/vweKyFY7K0nizS74fJksEt0n/e/LN5G5iDhy2yPcVkbMoiDGFljViCYuz2tyZ5hlgLGBn0gm/XJ5BJu2/66OB+tAc+SaVSii2dXVgUNHcsRWb5Wi2KkHQLQgRsFTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378029; c=relaxed/simple;
	bh=Xoe2g6PaoXjWDLYmYUO8CH8/g5+83BgHMb3DCEelxa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRkdaNQtN3HRrCQWDCHpaui44tN1WXBsNNwdbekYkJps3IT/j5e75hPsXbdRNoolO9EQG8yIEBr4qXDasjaCIHLgl4/Qtxk84NVpUK+/JQliS5iXbgCZJKVfCDn3e/AVWESuy8g2T8d51m7y/eXtWt1mllvxqM3qvSs4gn89riU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LHt4O1Qs; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LHt4O1Qs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789378018; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LEtjDojkW0StONXmozHIm/bJ7xi86aarazNel8UTP5g=;
	b=LHt4O1QsC2b/10u+LhnwEZyR6Uyo4IdKotw28c6E8PTzpYfV2TP+d4kVTb434ueAg02MWz44gK8ucC9fHcjmRmJeFqPpQ2hA7Pu9wLngassgNLctEi2c0niKszXC0E5Ng7EZEqvL5GhFs5POROjvGMf+fOMZ9XS1ltJsSNGQvFo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0XAuO-n8_1789378014;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAuO-n8_1789378014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 17:26:56 +0800
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
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/7] riscv: stacktrace: disable KASAN and KCOV instrumentation for stacktrace.o
Date: Mon, 14 Sep 2026 17:26:43 +0800
Message-Id: <20260914092648.51254-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
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
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/kernel/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index ebe1c3588177b..bf4645bb52403 100644
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

