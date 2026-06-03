Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698B3382F9;
	Wed,  3 Jun 2026 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449798; cv=none; b=fnTE+6rXEWml7Bpmi+gVMjr1W+cm9y00DWJgp+PjydaQ+GUO92uE+2XFWqd0XIaVZaRHBXdpMOWkkSxAmIvCe130R2mkg/ie8BpYJ/qpfFRvFxgZm1ZdxpAUhTjNKAnjYezy2tK58jxXun6niTuOoZfsso8Hgra9DdVyYyd+ND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449798; c=relaxed/simple;
	bh=OUNnNBmYkrpRZR+iYgT2ZVhB2ELR6BFLJRgUu4+IxB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNdJSfpuujmKLtKEBR+qHOIG6t1Mf0AargJKNxerJLp4RmEpF2ig+lSLReDgQNSE7j4fEFSm1jXKOcg1CKeUYawHeCE/UlpQhgGw7Ae27xeiHgBSuaBfozRMu64cX9j6NH0tIfHf65gYyxIH0nvG+X2WY0kwZjVJ40pj3ivmhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v0T79xHV; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v0T79xHV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780449793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aOvj40vd9kLAuQk7SPrErsDX1z7W+8ls3a4xdTv8HMg=;
	b=v0T79xHV3oyjexi2kUcB99zuD5zwCChUQcTVtyIWMr3NH9jrcttg/i8bENMBpmTU4ojqs99qJ/DiYt0y4XpxpAlOlFzc2eksLaM+X+El8GqP1IacuXySYZAUxwZT3NYi9uHv04Tye7ITyKr1UuDvozuqDldk3ota9UN4GRvw/S0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X45kknw_1780449789;
Received: from 30.246.177.175(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X45kknw_1780449789 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 09:23:11 +0800
Message-ID: <461a727f-e2cd-4192-9e19-16172500053c@linux.alibaba.com>
Date: Wed, 3 Jun 2026 09:23:08 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] riscv: stacktrace: introduce stack-bound tracking
 helpers
To: Wang Han <wanghan@linux.alibaba.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Pei <cp0613@linux.alibaba.com>, Andy Chiu <andybnac@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Deepak Gupta <debug@rivosinc.com>, Puranjay Mohan <puranjay@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527123530.2593918-1-wanghan@linux.alibaba.com>
 <20260528082310.1994388-6-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260528082310.1994388-6-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/26 4:23 PM, Wang Han wrote:
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
> +	unsigned long high = low + IRQ_STACK_SIZE;
> +
> +	return (struct stack_info) {
> +		.low = low,
> +		.high = high,
> +	};
> +}
> +
> +static inline bool on_irq_stack(unsigned long sp, unsigned long size)
> +{
> +	struct stack_info info = stackinfo_get_irq();
> +
> +	return stackinfo_on_stack(&info, sp, size);
> +}
> +
> +/*
> + * Task stack accessors
> + */
> +static inline struct stack_info stackinfo_get_task(const struct task_struct *tsk)
>   {
> -	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
> +	unsigned long low = (unsigned long)task_stack_page(tsk);
> +	unsigned long high = low + THREAD_SIZE;
> +
> +	return (struct stack_info) {
> +		.low = low,
> +		.high = high,
> +	};
> +}
> +
> +static inline bool on_task_stack(const struct task_struct *tsk,
> +				 unsigned long sp, unsigned long size)
> +{
> +	struct stack_info info = stackinfo_get_task(tsk);
> +
> +	return stackinfo_on_stack(&info, sp, size);
>   }
>   
> +/*
> + * Cast is necessary since current->stack is an opaque ptr.
> + */
> +#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
>   
> +/*
> + * Overflow stack accessors
> + */
>   #ifdef CONFIG_VMAP_STACK
>   DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
> +
> +static inline struct stack_info stackinfo_get_overflow(void)
> +{
> +	unsigned long low = (unsigned long)raw_cpu_ptr(overflow_stack);
> +	unsigned long high = low + OVERFLOW_STACK_SIZE;
> +
> +	return (struct stack_info) {
> +		.low = low,
> +		.high = high,
> +	};
> +}
>   #endif /* CONFIG_VMAP_STACK */
>   
>   #endif /* _ASM_RISCV_STACKTRACE_H */
> diff --git a/arch/riscv/include/asm/stacktrace/common.h b/arch/riscv/include/asm/stacktrace/common.h
> new file mode 100644
> index 000000000000..87d6d40672f3
> --- /dev/null
> +++ b/arch/riscv/include/asm/stacktrace/common.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RISC-V common stack unwinder types and helpers.
> + *
> + * See: arch/arm64/include/asm/stacktrace/common.h for the reference
> + * implementation.
> + *
> + * Copyright (C) 2024

Nit: The new common.h carries "Copyright (C) 2024", but this is a 2026
submission.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

