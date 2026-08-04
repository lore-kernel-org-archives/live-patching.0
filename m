Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0F448D06;
	Tue,  4 Aug 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839830; cv=none; b=HK64Z2XZx7J+ZKkmW8QBuklvpWh+rwVWGLqZPQwp9AmuN6o65uLo44znauhLBO+fL7+55xHId4kjEI6y5zqCeW4usDAq4J+BlfBc4qNJqX68sNLlBrB1CblWkCMelyd/JE3aT2xqV/EbgNRV3wTZkZIssgEG75xpuaZmpPr4Ftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839830; c=relaxed/simple;
	bh=V+TiK7MuCofMdG9dgvWdWCKyJPDTBZL1tm27s0teJgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+lZJ/KxU8M9tfLQ6uwQeNJNaGL3lQMgPEJdqTme11K9VCJ8J5iVwh1CFXaObPs/RWj8nIONIRCuqpxr1O85scFfa/s9xrKP68+4lhtfi4uWQpzUt05gtpc83HR3oDXJGnGLrWBxwIzKjTUCkNsyhpgFSgLgtV5MvItwYM03/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bhwn4Hxq; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bhwn4Hxq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785839824; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=osYv4PyMOH+hGuFQLUeP+UmPCqW/DzeJKVWPMYqOR5E=;
	b=bhwn4Hxqf2PXWP0BZTehIUi7eMtBkTqzkeUWvqErsp+ltB7WUBs3ENqGhhlqDn+MoGW2mHUUUCn1x7i3yR1hkXh/vDAlDv9eWX2jFw3+UXkuFfPTuk+x3IxDD9BbC6F3I+qvsM31rqyAw+8GQ3pg6JDU2sEfEUkgPOm/06aqn/s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X8Nlqdc_1785839818;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X8Nlqdc_1785839818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 18:37:01 +0800
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
Subject: [PATCH v5 7/7] selftests/livepatch: Add RISC-V syscall wrapper prefix
Date: Tue,  4 Aug 2026 18:36:26 +0800
Message-ID: <20260804103626.2803112-8-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804103626.2803112-1-wanghan@linux.alibaba.com>
References: <20260804103626.2803112-1-wanghan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscall livepatch selftest resolves and patches a syscall wrapper
symbol. To use that test for RISC-V livepatch validation, add the
RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.

Without this macro, the syscall livepatch selftest cannot resolve the
RISC-V target symbol, and the syscall-related livepatch test fails on
RISC-V.

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
---
 .../testing/selftests/livepatch/test_modules/test_klp_syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
index 08aacc0e14de..9baa2a5f84c9 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
@@ -24,6 +24,8 @@
     #define FN_PREFIX __s390x_
   #elif defined(__aarch64__)
     #define FN_PREFIX __arm64_
+  #elif defined(__riscv)
+    #define FN_PREFIX __riscv_
   #elif defined(__powerpc__)
     #define FN_PREFIX
   #else
-- 
2.43.0

