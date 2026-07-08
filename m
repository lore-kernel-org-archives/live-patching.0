Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57333E7BB0;
	Wed,  8 Jul 2026 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497620; cv=none; b=OQYGGEP8Y2SZyMsHFsRxtT5ApzrfLe+qa5pRn5HyvBbgtLlsjCnGugBz+fpgpYhDupiCf4TZcD4z+EuMryG1kkliYO0NH7/O5qKpeHTdgBkq1c6CrpgfbPym+R6hsf6aoE3HaQVp/cfz+n88UAA5AX/wY7YO8z/oOF8xmHsuGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497620; c=relaxed/simple;
	bh=LPtC18JyFz+hwS+C9pcHqtJy9phFKLqN3jKlwccUhkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPQ1lOIgfmYF/oLNTdSsbZ5UeXcwwwfEaLms7G4/iD//tbNRlO+23tzJ4I77ccehXztrnZoYBYoahJUKr/1G9Q4AOxPiV2zfcYOtsjoSR4EX+uxj74/p+carB6XhCuhC30G6qaJMPsFORGmKqtiUkmZ0EKsC5J6C924QJEmCTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xiBwC+x2; arc=none smtp.client-ip=47.90.199.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xiBwC+x2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783497584; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j079AmEVBbiNXvluQB998ypvPaJY+g6xWti/GsxT9CQ=;
	b=xiBwC+x2tGu/Pg4lBrkqFZhfi3AzEA1Oz8k1pNHoE1pQkRmcXqoyjnWsVuHQbBtHHZRB1yIEcohvu6RFaplufb7WpbdcvepiMjjuIoF75VWv9PgUzZ1oSSJD8C292z55p2XzDOjG3+BQanBRpTCnMl+YX6tHBUHuzpOe1w0Ce0g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X6h4Ew7_1783497580;
Received: from 30.246.161.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X6h4Ew7_1783497580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 15:59:42 +0800
Message-ID: <aae5efab-a0db-4e69-8d7e-2716c2be4b81@linux.alibaba.com>
Date: Wed, 8 Jul 2026 15:59:40 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 1/7] riscv: stacktrace: Add frame record
 metadata
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
 <20260629072713.3273743-2-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260629072713.3273743-2-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/29/26 3:27 PM, Wang Han wrote:
> Reliable frame-pointer unwinding needs an explicit way to identify
> exception boundaries and the final entry frame. The existing unwinder
> infers those boundaries from return addresses, which is too loose for a
> future reliable unwinder.
> 
> Add a small metadata frame record to pt_regs and initialize it on
> exception entry, kernel stack overflow, kernel thread fork, user fork,
> and early idle task setup. The record uses a zero {fp, ra} sentinel plus
> a type field so a later unwinder can distinguish a final user-to-kernel
> boundary from a nested kernel pt_regs boundary.
> 
> This follows the arm64 metadata frame-record model, adapted to the
> RISC-V {fp, ra} frame record convention.
> 
> The metadata is established at the RISC-V entry boundaries that need an
> explicit unwind marker:
> 
>    * exception entry clears the metadata {fp, ra} pair and uses SPP
>      (or MPP in M-mode) to record whether the pt_regs frame is the final
>      user-to-kernel boundary or a nested kernel boundary;
>    * the kernel stack overflow path builds a nested pt_regs metadata
>      record on the overflow stack so an unwinder can resume from the
>      pre-overflow s0 saved in PT_S0;
>    * _start_kernel builds the init task's final metadata record, while
>      the secondary CPU path sets up s0 before smp_callin() so idle-task
>      unwinding does not inherit an undefined caller frame;
>    * copy_thread creates matching final metadata records for new kernel
>      and user tasks, and keeps s0 available for the frame-pointer chain.
> 
> Keep the embedded metadata-record field offsets distinct from the
> s0-relative STACKFRAME_* offsets used by call_on_irq_stack(), because
> the latter describe a frame record relative to s0 rather than to the
> record base.
> 
> These changes keep s0 reserved for the frame-pointer chain at task and
> exception boundaries.


Overall the patch looks good to me. One nit below:

> 
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>   arch/riscv/include/asm/ptrace.h           |  9 ++++
>   arch/riscv/include/asm/stacktrace/frame.h | 53 +++++++++++++++++++++++
>   arch/riscv/kernel/asm-offsets.c           |  6 +++
>   arch/riscv/kernel/entry.S                 | 39 ++++++++++++++++-
>   arch/riscv/kernel/head.S                  | 23 ++++++++++
>   arch/riscv/kernel/process.c               | 33 +++++++++++++-
>   6 files changed, 159 insertions(+), 4 deletions(-)
>   create mode 100644 arch/riscv/include/asm/stacktrace/frame.h
> 
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index addc8188152f..4b9b0f279214 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -8,6 +8,7 @@
>   
>   #include <uapi/asm/ptrace.h>
>   #include <asm/csr.h>
> +#include <asm/stacktrace/frame.h>
>   #include <linux/compiler.h>
>   
>   #ifndef __ASSEMBLER__
> @@ -53,6 +54,14 @@ struct pt_regs {
>   	unsigned long cause;
>   	/* a0 value before the syscall */
>   	unsigned long orig_a0;
> +
> +	/*
> +	 * This frame record is entirely zeroed on exception entry, allowing the
> +	 * unwinder to identify exception boundaries. The type field encodes
> +	 * whether the exception was taken from user (FINAL) or kernel (PT_REGS)
> +	 * mode.
> +	 */
> +	struct frame_record_meta stackframe;
>   };
>   
>   #define PTRACE_SYSEMU			0x1f
> diff --git a/arch/riscv/include/asm/stacktrace/frame.h b/arch/riscv/include/asm/stacktrace/frame.h
> new file mode 100644
> index 000000000000..5720a6c65fe8
> --- /dev/null
> +++ b/arch/riscv/include/asm/stacktrace/frame.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_RISCV_STACKTRACE_FRAME_H
> +#define __ASM_RISCV_STACKTRACE_FRAME_H
> +
> +/*
> + * See: arch/arm64/include/asm/stacktrace/frame.h for the reference
> + * implementation.
> + */
> +
> +/*
> + * - FRAME_META_TYPE_NONE
> + *
> + *   This value is reserved.
> + *
> + * - FRAME_META_TYPE_FINAL
> + *
> + *   The record is the last entry on the stack.
> + *   Unwinding should terminate successfully.
> + *
> + * - FRAME_META_TYPE_PT_REGS
> + *
> + *   The record is embedded within a struct pt_regs, recording the registers at
> + *   an arbitrary point in time.
> + *   Unwinding should consume pt_regs::epc, followed by pt_regs::ra.
> + *
> + * Note: all other values are reserved and should result in unwinding
> + * terminating with an error.
> + */
> +#define FRAME_META_TYPE_NONE		0
> +#define FRAME_META_TYPE_FINAL		1
> +#define FRAME_META_TYPE_PT_REGS		2
> +
> +#ifndef __ASSEMBLER__
> +/*
> + * A standard RISC-V frame record.
> + */
> +struct frame_record {
> +	unsigned long fp;
> +	unsigned long ra;
> +};
> +
> +/*
> + * A metadata frame record indicating a special unwind.
> + * The record::{fp,ra} fields must be zero to indicate the presence of
> + * metadata.
> + */
> +struct frame_record_meta {
> +	struct frame_record record;
> +	unsigned long type;
> +};
> +#endif /* __ASSEMBLER__ */
> +
> +#endif /* __ASM_RISCV_STACKTRACE_FRAME_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index a75f0cfea1e9..bc8e8cd7130a 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -131,6 +131,9 @@ void asm_offsets(void)
>   	OFFSET(PT_BADADDR, pt_regs, badaddr);
>   	OFFSET(PT_CAUSE, pt_regs, cause);
>   
> +	DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
> +	DEFINE(S_STACKFRAME_TYPE,	offsetof(struct pt_regs, stackframe.type));
> +
>   	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
>   
>   	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> @@ -503,6 +506,9 @@ void asm_offsets(void)
>   	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
>   	DEFINE(STACKFRAME_FP, offsetof(struct stackframe, fp) - sizeof(struct stackframe));
>   	DEFINE(STACKFRAME_RA, offsetof(struct stackframe, ra) - sizeof(struct stackframe));
> +	DEFINE(STACKFRAME_RECORD_SIZE, sizeof(struct stackframe));

This should be sizeof(struct frame_record) rather than
sizeof(struct stackframe). STACKFRAME_RECORD_SIZE is used to skip past
the embedded frame_record_meta.record field:

     addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE

The two structs happen to be identical today, but they are independent
types serving different purposes — struct stackframe is the existing
unwinder frame record, while struct frame_record is the one embedded
in struct frame_record_meta introduced by this patch. If struct
stackframe ever gains an extra field, this offset would silently break.

With that fixed:

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
