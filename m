Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531353E6DD8;
	Wed,  8 Jul 2026 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494310; cv=none; b=lwWG6HFUgqJDEzA44/9lHNAJ8rMjadZRHvtQjMqC/3P6eCsGazeXq0IK1EReubVaQ+fROxHemPGqso+6xGBS3V79WKkLuH6+LVRVWE6C1b3rjBiIXtZWZPhwZ+2uq48wgXcotKMUZEyctgEa5PNVHvMrYTnbCiIEh402P/ShwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494310; c=relaxed/simple;
	bh=Kfrb3+5tYPOiLtvz4HJtKv6RKCL/qDqvGfR0DV4LxG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfcs8RGURAXefMa4tLHfhjCfZMvU/USe4Q9FIWx5aykqchHhySf9DH1u5H3wqO8sm/jZ+zybsznFvm9rmGBXy98+XmvhHfgvMPv/AoewzB0wkVYAIBF93zIyMQQXaFJ4yo61wgjo2SQ7v7vBKRKfgEhZEsB98wfX1Xjx0F2opfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ldyH6F58; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ldyH6F58"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783494285; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VqOzBHcezIdJbCw9H20f4ApkMFhu+ojhnSlVxGo7tKM=;
	b=ldyH6F58hjVNhnMeZOfXhTo4aBYq11lEHFs+602BQUdrjf3OxaHRpFCr3mJwm120e22u8mM0r99KRz3T4Zxx4yALrToHw7sbXOdQfyR+AVEPXCUx84dzb/XwDOnj4gnJOkBOBjax/baNiaaKv7NoURMDXsSWTjKRVJ0E3cLHAo0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X6gnBaq_1783493952;
Received: from 30.246.161.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X6gnBaq_1783493952 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 14:59:14 +0800
Message-ID: <9228c07a-8879-41de-ba87-b9f879648ba8@linux.alibaba.com>
Date: Wed, 8 Jul 2026 14:59:11 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 4/7] riscv: stacktrace: introduce stack-bound
 tracking helpers
To: Wang Han <wanghan@linux.alibaba.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Shuah Khan <shuah@kernel.org>, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
 Marcos Paulo de Souza <mpdesouza@suse.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260629072713.3273743-1-wanghan@linux.alibaba.com>
 <20260629072713.3273743-5-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260629072713.3273743-5-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/29/26 3:27 PM, Wang Han wrote:
> A reliable unwinder needs to validate that every frame record it reads
> is fully contained in a known kernel stack, and it needs to refuse to
> walk back into a stack it has already left. Add the building blocks
> for that:
> 
>    * struct stack_info / struct unwind_state in a new
>      asm/stacktrace/common.h, modelled on the arm64 reference
>      implementation.
>    * stackinfo_get_irq() / stackinfo_get_task() / stackinfo_get_overflow()
>      plus the corresponding on_*_stack() predicates in asm/stacktrace.h,
>      so callers can ask "is this object on stack X?" by stack kind
>      rather than open-coded address arithmetic.
>    * unwind_init_common(), unwind_find_stack() and
>      unwind_consume_stack() helpers that enforce the
>      forward-progress-only invariant required for reliability.
> 
> No existing user is wired up to these helpers in this commit; the
> unwinder switch comes in a follow-up. The header changes leave
> on_thread_stack() with the same semantics as before, just expressed in
> terms of the new helpers.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>   arch/riscv/include/asm/stacktrace.h        |  65 ++++++++-
>   arch/riscv/include/asm/stacktrace/common.h | 159 +++++++++++++++++++++
>   2 files changed, 222 insertions(+), 2 deletions(-)
>   create mode 100644 arch/riscv/include/asm/stacktrace/common.h
> 
> diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
> index b1495a7e06ce..bc87c4940379 100644
> --- a/arch/riscv/include/asm/stacktrace.h
> +++ b/arch/riscv/include/asm/stacktrace.h
> @@ -3,8 +3,13 @@
>   #ifndef _ASM_RISCV_STACKTRACE_H
>   #define _ASM_RISCV_STACKTRACE_H
>   
> +#include <linux/percpu.h>
>   #include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
> +
> +#include <asm/irq_stack.h>
>   #include <asm/ptrace.h>
> +#include <asm/stacktrace/common.h>
>   
>   struct stackframe {
>   	unsigned long fp;
> @@ -16,14 +21,70 @@ extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re
>   extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
>   			   const char *loglvl);
>   
> -static inline bool on_thread_stack(void)
> +/*
> + * IRQ stack accessors
> + */
> +static inline struct stack_info stackinfo_get_irq(void)
> +{
> +	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);

 From https://sashiko.dev/#/patchset/20260629072713.3273743-1-wanghan%40linux.alibaba.com

Will this cause a link error when CONFIG_IRQ_STACKS is disabled?
Looking at arch/riscv/kernel/irq.c, irq_stack_ptr is defined inside an
#ifdef CONFIG_IRQ_STACKS block. Since stackinfo_get_irq() unconditionally
references it here, it seems this might result in an undefined reference
to irq_stack_ptr during linking.

Should this accessor be conditionally compiled, or should it provide a
fallback when CONFIG_IRQ_STACKS is not set?

Thanks.
Shuai
