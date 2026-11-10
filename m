Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274687;
	b=dXzs3GP+JDKV1xHmlq1/RDqVYG7GGnlzRfiH9UwCRHb8+cpnKpv4n/XlmrtXlTreLZaH
	 MupYgC6UvdgEq2DUVxRU7jKWqaDvDvt+3V8eBkL1dcXeVH9MxHTDqCbMmz/Jj8ARk88+v
	 wtXMswf5e1R3PEdc6BhWoWWxmbb+UCUHZOC6K5iAQJnxG6ytA+2QaMTTe0VKj27WOILTT
	 i4SHMNy8gJkyvgFSY4zlKdDxwYRwUAZVRUj/kjFmzIzpIxOa5cXRMDBbEuwmJBRFPx7DA
	 E9xzwLXWKAw4Cohz0eklPEgUdMXbKXJLiMZXRapbszJk3o7gx8Z0yANC44QefqxbE3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274687;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIO64a3mT9fiK4+NP8JbdHWsQ2JRHiaO8iZSQOj4mJA=;
	b=ZiARHJhiyApUwMU3qTTRPSIbFktRXr2kEep5ObfLMR2KhTHsRgWmV0rwYWhmt5/T5wN1
	 EamqjlVSHGX/fD0zD5CVjQ8CGwRXKkqmT85nF9s37KB1Xi7cNz2m++Ihi1ycurIE/JMHo
	 BrveyypAbxKs1g+iozI9Ycl+9AW6yYZL+Q6Q/2V3RyZMk2TfaI3zR25GVclEbGScY/Ga+
	 3CaXCQ+A9GgNKgG3uwRxmYveflTY4QiB6Oy6P81WIUzL2S+a/531GFlA92CM40tkrAOhg
	 6fJbXqjgqV1FnJ1vq8cS4kzzm4VVInM6ERRZjlZn2lc90SSQgUWUHsqhEzYGJSodb+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NElttxdM;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696A60A2620;
	Tue, 10 Nov 2026 01:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D696A60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NElttxdM
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794274684; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UIO64a3mT9fiK4+NP8JbdHWsQ2JRHiaO8iZSQOj4mJA=;
	b=NElttxdMqo2k8FhGd3BpZWD0XxAYRjElEwOpk+xmP5/eJBEidWLIn5yG+dtzyCO66xDPwx6dF4EqgK1+cw3lRRJ0ahTdXbYuTCRFh1tZB2pg6aH08iuhamUNzlOeMqkv2ctEIIYBriVmj0/Vd3XbYoPA6vdd8dQnRR85XbVYhY8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0XETOX39_1794274680;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XETOX39_1794274680 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:38:02 +0800
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
Subject: [PATCH v7 03/10] riscv: ftrace: use the frame pointer as the function graph return-address cookie
Date: Tue, 10 Nov 2026 09:37:43 +0800
Message-Id: <20261110013750.36800-4-xueshuai@linux.alibaba.com>
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

The function graph tracer stamps every shadow-stack entry with a
cookie, ftrace_ret_stack::retp, which stack unwinders later pass to
ftrace_graph_ret_addr() to recover a return address that the tracer
replaced with return_to_handler.  The match is an exact pointer
comparison, so the producer and the consumer must agree on what the
cookie is.  On riscv they don't:

  * The dynamic ftrace path stores &arch_ftrace_regs(fregs)->ra, a
    slot inside the transient ftrace trampoline frame.  The frame is
    popped as soon as the callback returns, so the stored cookie is
    an address that no consumer can ever reproduce.  It has never
    matched anything since ftrace_graph_func() was introduced in
    v6.8.

  * The frame-pointer walker in walk_stackframe() passes &frame->ra,
    the ra slot of a live frame record.  That key matches the static
    mcount path, which passes the callee's ra-slot address, but not
    the dynamic path.

Since distro kernels only ever use the dynamic path, the net effect
is that the shadow stack is never consulted during unwinding:
whenever the function graph tracer is running, dump_stack(), perf
callchains and __get_wchan() report return_to_handler instead of the
real caller.

Switch the cookie to the architectural frame pointer, i.e. the
caller's frame-pointer value.  Every party can reproduce it from the
frame records themselves:

  * ftrace.c stores (void *)frame_pointer on both entry paths.  At
    ftrace entry the frame pointer is still the caller's, which is
    the value the callee later saves in its frame_record::fp.

  * walk_stackframe() passes that value, frame->fp, to
    ftrace_graph_ret_addr() instead of the ra-slot address.  The
    static mcount path has to switch too: its old cookie (the
    callee's ra-slot address) is exactly what the old walker key
    matched, so leaving it behind would regress the static path.

This is the convention arm64 already uses: (void *)frame_pointer
from ftrace.c, the saved fp from the unwinder.

function_get_true_parent_ip() keeps passing the entry stack pointer
as its key; that key is only reproducible on architectures whose
return address lives at the entry stack pointer (x86).  On riscv,
as on arm64, it keeps falling back to the raw parent ip.

Fixes: 35e61e8827ee8 ("riscv: ftrace: Make function graph use ftrace directly")
Suggested-by: Martin Kaiser <martin@kaiser.cx>
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/kernel/ftrace.c     | 6 ++++--
 arch/riscv/kernel/stacktrace.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index be8b68514417..0facd824c911 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -245,7 +245,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	if (!function_graph_enter(old, self_addr, frame_pointer, parent))
+	if (!function_graph_enter(old, self_addr, frame_pointer,
+				  (void *)frame_pointer))
 		*parent = return_hooker;
 }
 
@@ -267,7 +268,8 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	 */
 	old = *parent;
 
-	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
+	if (!function_graph_enter_regs(old, ip, frame_pointer,
+				       (void *)frame_pointer, fregs))
 		*parent = return_hooker;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 28c5744889ba..a5abb705d43b 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -96,8 +96,9 @@ static __always_inline void __walk_stackframe(struct task_struct *task,
 		} else {
 			fp = READ_ONCE_TASK_STACK(task, frame->fp);
 			pc = READ_ONCE_TASK_STACK(task, frame->ra);
+			/* the cookie is the caller's frame pointer */
 			pc = ftrace_graph_ret_addr(task, &graph_idx, pc,
-						   &frame->ra);
+						   (void *)fp);
 			if (pc >= (unsigned long)handle_exception &&
 			    pc < (unsigned long)&ret_from_exception_end) {
 				if (unlikely(!fn(arg, pc)))
-- 
2.39.3

