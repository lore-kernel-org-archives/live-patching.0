Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B442E437;
	Mon, 14 Sep 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378040; cv=none; b=nZ+RElt61oHgaLmgFTU/pVGvgMxOotCoi13v/uR66lx9TVHDNmjeg7tP97o5Aor42zI1Cm1Nr+fyb8Bhf4a6ytBv4MKbhJDVL3U23hSc4GzxuF37VRRbEq0wJ0EyaxQbwYc2Bh0yIuUdMscphmd/e9ldZUqI36xTkxR2lJWJcMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378040; c=relaxed/simple;
	bh=36lNwUWi8r8zm0WG6WwG/ADrpK9nPjx3a/smgDapwcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMQ98YIrfP9fl107tj/sK7YHAMJoe+QJaFZpovn5IYIhhMXELseC8OnhvjIshd9jRID4l9RMGOU5FPGF3QAmCu9ZujCvh8/cNpaVs2wE25eFFSECV+rIW/ijH2lUOOqtDQtmWafhGXrj+uBdGMktjaLK2/v0Wwo1AuIqex7zvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w0mlITW2; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w0mlITW2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789378030; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PEnkvP/MMeE/AyrREVwFeM/SBbfr0Ph1OGEBAs/dnV0=;
	b=w0mlITW2M1K65cmqt+MBPGmvtuwHyx9T+mgAaBSChYXw06KLJ8IjyblTQtbWfFxcS5KdvCExGAivllJxSnKd9urZRKqLzauBlqTYXFBktW+26lLHqRBabBG9KPx6W+9NT0DLPFL1DkKPzBJ719gsV3stqjeBYu5VSiecpPPzWjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0XAuO-qg_1789378027;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAuO-qg_1789378027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 17:27:08 +0800
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
Subject: [PATCH v6 7/7] selftests/livepatch: Add RISC-V syscall wrapper prefix
Date: Mon, 14 Sep 2026 17:26:48 +0800
Message-Id: <20260914092648.51254-8-xueshuai@linux.alibaba.com>
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

The syscall livepatch selftest resolves and patches a syscall wrapper
symbol. To use that test for RISC-V livepatch validation, add the
RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.

Without this macro, the syscall livepatch selftest cannot resolve the
RISC-V target symbol, and the syscall-related livepatch test fails on
RISC-V.

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 .../testing/selftests/livepatch/test_modules/test_klp_syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
index 08aacc0e14de9..9baa2a5f84c95 100644
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
2.39.3

