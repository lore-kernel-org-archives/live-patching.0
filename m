Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72430E0D6;
	Mon, 29 Jun 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715368; cv=none; b=LS329jGi2NDHBGd5PfiduNw/IxDYNA5qBmBjFwZQVUnW05TjVWztNopl9poiyC1woncYV9fvHy/ZwIbHInKT9Cgm3DZ65ewL3Q/oks9FUQFNt7zGZlGhj/3jdzkbwT/ZUKrxwfTX+xolaiCcElFCxpkevYe7UL1W+vYXtvuxLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715368; c=relaxed/simple;
	bh=8gUFQfhcKCWl+SQPGfcUr9oaqzBY5sgciJASbO4/7I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzsnipHpLWthANLTw3Uo02MKn0AGlpM/am1R4r5xrj2R1WES76yJ9X/d0JqfceH+VRbrnD9PLFAYv5bOBtdJS8rG51dEvE/Nq4YKVkSz2jtm9qTZorNTBPb8P+ZJsjiJduXRRtyKQsqTZ9+4i9iG6DCP1GQtgDCk88GSGTQgJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bX+arkOK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bX+arkOK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782715357; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m8pnWfAyIRGdD3GPjP0E4M3+tZYcgxHxMKpoX0zv1+E=;
	b=bX+arkOKtV/Jt9vugk3GxJA9UahbB64LRo+649pOgm3DGpGhY5gcFOknLjnmqFcEQN+IE7drzUz7kvUv0lQlojoLvqasSODEc8hoLC9KMoQ7PwRAQ1s144fzGZm+lXNaDliXiPliMY9O5Njw/10ScXrWGaKR7k3K6v7idOe/8Rs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X5nWtbk_1782715354;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X5nWtbk_1782715354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 14:42:35 +0800
From: Wang Han <wanghan@linux.alibaba.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	oliver.yang@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/7] riscv: stacktrace: disable KASAN and KCOV instrumentation for stacktrace.o
Date: Mon, 29 Jun 2026 14:42:23 +0800
Message-ID: <20260629064228.3195856-3-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
---
 arch/riscv/kernel/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index cabb99cadfb6..c565a72a36f3 100644
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
2.43.0
