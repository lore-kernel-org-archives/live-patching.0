Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0133D6F0;
	Tue,  9 Jun 2026 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986622; cv=none; b=Q3wrRNuoZ1JeiVS9t2Pi161Exkshz35eWb95VwVTiD8sAV3USuUZZao5G2nLwn1uuRmsbANkd2iUVXpuOpF9JbYH2NSupyuBs6xQUsuNc9SbeHYLywWRHirBqpuCrBFTxWYm8PzsXP1cXUCNzBmW5VcGAoGRhgyylP9rrj5X+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986622; c=relaxed/simple;
	bh=Pj7/LrIc+9w7nipZfHrJOoItSmQ2wzMIFB96EmLOzvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVZg0Hy8gCAo9FC/FoeqUlPylYNwpvHui/Lh8Sw6bZ9uIrhPI4u6YkczUl5HX7Om4D1/nQSRxk5oRoFk6vv0gteXnjt0D3lojArPnQQpZQxAMd3lrXKy5FFJkbs5mw6gC+mWrUHgfkvFthb50LkFi4UUcSh5LrDI72LDdbdRY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=odJNajOo; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="odJNajOo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780986618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NObCC9vuQ+8IIV353/PktQcevOOohH2eFHrfe868FZk=;
	b=odJNajOoTrlNL5SSrU+E5LY/vtdbrpYarC1EkP6VPwx0zGiI0RJCAWIi6Y+y9N9+6ixEFpDXd634cIR8Tzta31C+nzcRrupFofvgH1dE0qa7n08UEolJ3x1LzSNsw6/k56SOwVxOqMP6GTs5FlDlYnLyQywJ8Tcdhu25wHdyhpU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X4VD54T_1780986615;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X4VD54T_1780986615 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Jun 2026 14:30:16 +0800
From: Wang Han <wanghan@linux.alibaba.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Andy Chiu <andybnac@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	oliver.yang@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 8/8] selftests/livepatch: Add RISC-V syscall wrapper prefix
Date: Tue,  9 Jun 2026 14:29:59 +0800
Message-ID: <20260609063002.3943001-8-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com>
References: <20260528082310.1994388-1-wanghan@linux.alibaba.com> <cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com>
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
index dd802783ea84..275e4b10cf59 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
@@ -18,6 +18,8 @@
 #define FN_PREFIX __s390x_
 #elif defined(__aarch64__)
 #define FN_PREFIX __arm64_
+#elif defined(__riscv)
+#define FN_PREFIX __riscv_
 #else
 /* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER */
 #define FN_PREFIX
-- 
2.43.0

