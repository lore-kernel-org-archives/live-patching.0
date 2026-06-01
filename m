Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E933F385;
	Mon,  1 Jun 2026 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294641; cv=none; b=a/Bll3KdURWxWVSdUeZFtiaLT0DTmSeVLF3xTXq05piSkbnwx6iLfThJ4ODcdz5dWbDy63Yyjdqe4dpxy5VzUn9ZeQ3XejK3BT1PDmJUgW691P76rWyTBU+hIAlSlQlsP5na7W09p+UyWWDOyFa6malseeV8iJQWTyHP4KL7GdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294641; c=relaxed/simple;
	bh=UihMiOTfDJRfJjmqfhqu9gvy6Q895RAgpxzCYDzc5Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jjt4f2a57ChlDetDpuke60XZRwcA6Ffb8+MfDg//4ibIDXa7PpBHFMKDuKZ3iS3dR5GOtq6AH2o6KTsmfNEGR7RQSGHPCLoJMxKLHKGIhSSVXJm6AiXl101fH1tgKuFWViGt2tvDLKtwUwa5/Z3XmWzef9Kxidufh5M5r0JS9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uUPDJhqc; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uUPDJhqc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780294633; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=trvE0xJ84EkBQvsLZo8DiAzrmg+egpDX0iqFxhFhu0A=;
	b=uUPDJhqc1Wbtrv6PwpsHm7cdO50RUSy9BVePrEJz+e+bCbbEGV2SAv+uL0sCVS86xcnNNlA+9Y0s9oLt1AxYMNO0lj7LlD4FRWvhdMiULGq1kFuDkTMHkyZ3YAx3abCLLpbMmZQsTKkQ2CrhpfjSeAVhd1GUlzintqNbR25MkP4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X3x9b9C_1780294629;
Received: from 30.246.178.94(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X3x9b9C_1780294629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Jun 2026 14:17:11 +0800
Message-ID: <0a913398-3d0c-472e-89c4-062052eae04d@linux.alibaba.com>
Date: Mon, 1 Jun 2026 14:17:08 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] scripts/sorttable: Handle RISC-V patchable ftrace
 entries
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
 <20260528082310.1994388-2-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260528082310.1994388-2-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/28/26 4:23 PM, Wang Han wrote:
> RISC-V uses -fpatchable-function-entry=8,4 when the compressed ISA is
> enabled and -fpatchable-function-entry=4,2 otherwise. In both cases, the
> patchable NOP area starts 8 bytes before the function symbol address.
> The __mcount_loc entries therefore point at the patchable NOP area
> associated with a function, while nm reports the function symbol at the
> entry address used for the function range check.
> 
> After RISC-V selected HAVE_BUILDTIME_MCOUNT_SORT, sorttable started
> applying that range check at build time. Without allowing entries just
> before the reported function address, the mcount sorter treats valid
> RISC-V ftrace callsites as invalid weak-function entries and writes
> them back as zero. The resulting kernel boots with no ftrace entries,
> breaking dynamic ftrace and users such as livepatch.
> 
> The failure is silent during the final link because zeroing weak-function
> entries is an expected sorttable operation. At boot, those zero entries
> are skipped by ftrace_process_locs(), so the only obvious symptom is that
> the vmlinux ftrace table has lost valid callsites and ftrace users cannot
> attach to them.
> 
> CONFIG_FTRACE_SORT_STARTUP_TEST also reports the table as sorted in this
> state: it only checks that the __mcount_loc entries are in ascending
> order, which a fully zeroed table trivially satisfies. The original
> commit relied on this check and did not see the regression.
> 
> On an affected RISC-V QEMU boot with both CONFIG_FTRACE_SORT_STARTUP_TEST
> and CONFIG_FTRACE_STARTUP_TEST enabled, the sort check still passes
> while ftrace reports zero usable entries and the early selftests fail:
> 
>    [    0.000000] ftrace section at ffffffff8101da98 sorted properly
>    [    0.000000] ftrace: allocating 0 entries in 128 pages
>    [    0.054999] Testing tracer function: .. no entries found ..FAILED!
>    [    0.172407] tracer: function failed selftest, disabling
>    [    0.178186] Failed to init function_graph tracer, init returned -19
> 
> Handle RISC-V like arm64 for the function-range check and allow
> patchable entries up to 8 bytes before the function address.
> 
> With this fix, a RISC-V QEMU smoke boot with ftrace startup tests shows
> the vmlinux ftrace table is populated and dynamic ftrace still works:
> 
>    [    0.000000] ftrace: allocating 46749 entries in 184 pages
>    [    0.051115] Testing tracer function: PASSED
>    [    1.283782] Testing dynamic ftrace: PASSED
>    [    6.275456] Testing tracer function_graph: PASSED
> 
> Fixes: 0ca1724b56af ("riscv: ftrace: select HAVE_BUILDTIME_MCOUNT_SORT")
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Link: https://lore.kernel.org/all/20260527113028.4b21a5de@fedora/
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>   scripts/sorttable.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index e8ed11c680c6..4c10e85bb5af 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -891,17 +891,21 @@ static int do_file(char const *const fname, void *addr)
>   	table_sort_t custom_sort = NULL;
>   
>   	switch (elf_map_machine(ehdr)) {
> -	case EM_AARCH64:
>   #ifdef MCOUNT_SORT_ENABLED
> +	case EM_AARCH64:
>   		sort_reloc = true;
>   		rela_type = 0x403;
> -		/* arm64 uses patchable function entry placing before function */
> +		/* fallthrough */
> +	case EM_RISCV:
> +		/* arm64 and RISC-V place patchable entries before the function */
>   		before_func = 8;

Nit: The shared comment now sits under `case EM_RISCV:` but the two
lines above it (sort_reloc / rela_type = 0x403) are strictly
arm64-only — they configure the RELA-based weak-function fixup that
RISC-V does not need. On a quick read it is easy to wonder if RISC-V
is implicitly inheriting that path. Splitting the comments would
help, e.g.:

        case EM_AARCH64:
            /* arm64 needs RELA-based weak-function fixup */
            sort_reloc = true;
            rela_type = 0x403;
            /* fallthrough */
        case EM_RISCV:
            /* arm64 and RISC-V place patchable entries before the function */
            before_func = 8;


> +#else
> +	case EM_AARCH64:
> +	case EM_RISCV:
>   #endif
>   		/* fallthrough */
>   	case EM_386:
>   	case EM_LOONGARCH:
> -	case EM_RISCV:
>   	case EM_S390:
>   	case EM_X86_64:
>   		custom_sort = sort_relative_table_with_data;

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
