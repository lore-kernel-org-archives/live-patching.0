Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CE3E7BC6;
	Wed,  8 Jul 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498050; cv=none; b=ZzC4pyBUGS8VO1bJzCHLAvZ1Vh4oS6F925tzahlmTj4gaWoLLq4KosCd6UaJH79HHZurHriTrX9ZEy7r7XH1eXQvKl1QcDcwBvH2WRrw82cwN7zGFqBnnMHCGygGOxdGa8IpWAjjveZ4orj3C8fNcTg0nC0lOhATKjcWnfIWlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498050; c=relaxed/simple;
	bh=t5aDYhWDsenCSPBFg8sFWKNzaG45c943wAdMkXPrlFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THeHqoLaQ/wF/DutuY30wicWI5GBtLSae9pPl1ybFqUgOIt7dL+H6Cusy9Um30nzlJVsWHcmDlisNOrOLT6R75u2+z3D25HBxMyFQyT6kV4sOWScfoEBkxeCrbJC1wRrTrYJPVFX3I2/U0cL2pCaukEdVcgFbY4VlQ4Bgop1rgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TSI9Owt9; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TSI9Owt9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783498041; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7aX7B+3xkHbNhiVcp4PAYQLzOnDUqkKktfRxNWYRSCI=;
	b=TSI9Owt9xFK3U5bQlUri1HJ35iDcK98p5Wj7bR1IfzPOqUOG7bGCt6Fsp9bgDmvdgAScS2KdXjeb9kjdFyM2WQj76YOjBenDgO7hHntCduFoTbHwu1GGE4ectC0NmrLSM5VqfFxrmHuWzFEDlvkLv7h/9YdIYUujG3Sds2psbeQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X6h5OsU_1783498037;
Received: from 30.246.161.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X6h5OsU_1783498037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 16:07:19 +0800
Message-ID: <9986b3bf-e80e-4ffc-afd6-6b82baa1e9d0@linux.alibaba.com>
Date: Wed, 8 Jul 2026 16:07:17 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 2/7] riscv: stacktrace: disable KASAN and KCOV
 instrumentation for stacktrace.o
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
 <20260629072713.3273743-3-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260629072713.3273743-3-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/29/26 3:27 PM, Wang Han wrote:
> KASAN records stack traces for every alloc/free, which means it walks
> the unwinder very frequently. Instrumenting the stack trace collection
> code itself adds substantial overhead and makes the traces themselves
> noisier.
> 
> KCOV instruments every basic-block edge. The unwinder is a hot path,
> especially with KASAN enabled, so KCOV instrumentation has the same kind
> of cost and noise problem here.
> 
> Mark stacktrace.o as not KASAN- or KCOV-instrumented, matching the x86
> treatment of its stack unwinding code. RISC-V keeps the relevant unwinder
> code in stacktrace.o, so a single translation-unit annotation covers the
> equivalent scope. This is a prerequisite preference for the upcoming
> reliable unwinder, but the change is valid on its own.
> 
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>   arch/riscv/kernel/Makefile | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index cabb99cadfb6..c565a72a36f3 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -44,6 +44,12 @@ CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
>   CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
>   endif
>   
> +# When KASAN is enabled, a stack trace is recorded for every alloc/free, which
> +# can significantly impact performance. Avoid instrumenting the stack trace
> +# collection code to minimize this impact.
> +KASAN_SANITIZE_stacktrace.o := n
> +KCOV_INSTRUMENT_stacktrace.o := n
> +
>   always-$(KBUILD_BUILTIN) += vmlinux.lds
>   
>   obj-y	+= head.o

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
