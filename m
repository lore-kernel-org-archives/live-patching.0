Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEB3B995E;
	Tue,  2 Jun 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399379; cv=none; b=avstqWZ52BUNinhXbzR8GU1zB+54mn+p93wcSKdAXtGC3o1Zn3g6w6UheAjwWSY27bBaJiiS0wmPQACueW+ovRZG3cFr4yKwq2Rk8IZT0rpckokI+uINw90Z6wE9pXna1VG9la3BXO7s3kxhvyqfuC2KorLG1ykmqbuE0bF19q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399379; c=relaxed/simple;
	bh=2hnGczsE61WJKJTsFKGPfGzYvBHWq7w+13htcig3JQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8sCbsMjdVotw10Gos0MwUTYpBj9wsdN0IX6mYZj4SBLY/lpE22CzSk7jOosnuO0U5XXyrhEsP7/jeK5BA2LM5CDFlSwZRszyPy2qpXCaCFHu553NsbhlFnC1oBDjDl4HBQU6q9APv7K5rzR7jXpHxWEgFWw/Z5i+9fZozGQs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ld2B9ySg; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ld2B9ySg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780399373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Zbw5BKJXHyNT/TPLzF2MYusKHtOC6lHLUdejhNl1Q64=;
	b=ld2B9ySg6F8F9XA/6m5nnP0Y1YKK264jBfRluFKD3qskhQC4jGRCO+yFUZRhxfr38WTt62sSJWVZ9e+BOEFlWm2P0RYSDgZt4UMegURoMyDwjZzkAA9WGOdQ05PQyzQB5RVrPfgE3Nwfbhl1yitjKCxZFRA3TRLESrAI3JBl288=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X44JnKC_1780399369;
Received: from 30.100.154.88(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X44JnKC_1780399369 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 19:22:51 +0800
Message-ID: <a385e57a-e895-4044-ae94-8cd8dfbd3bed@linux.alibaba.com>
Date: Tue, 2 Jun 2026 19:22:49 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] riscv: stacktrace: disable KASAN instrumentation
 for stacktrace.o
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
 <20260528082310.1994388-4-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260528082310.1994388-4-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/28/26 4:23 PM, Wang Han wrote:
> KASAN records stack traces for every alloc/free, which means it walks
> the unwinder very frequently. Instrumenting the stack trace collection
> code itself adds substantial overhead and makes the traces themselves
> noisier.
> 
> Mark stacktrace.o as not KASAN-instrumented, matching the arm, arm64
> and x86 treatment of their stack unwinding code. This is a prerequisite
> preference for the upcoming reliable unwinder, but the change is valid
> on its own.
> 
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>   arch/riscv/kernel/Makefile | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index cabb99cadfb6..1cb6c9ab2981 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -44,6 +44,11 @@ CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
>   CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
>   endif
>   
> +# When KASAN is enabled, a stack trace is recorded for every alloc/free, which
> +# can significantly impact performance. Avoid instrumenting the stack trace
> +# collection code to minimize this impact.
> +KASAN_SANITIZE_stacktrace.o := n
> +

I checked the three referenced arches:
   - arm    (arch/arm/kernel/Makefile):    KASAN only
   - arm64  (arch/arm64/kernel/Makefile):  KASAN only
   - x86    (arch/x86/kernel/Makefile):    KASAN *and* KCOV
            (KCOV_INSTRUMENT_stacktrace.o := n, plus dumpstack and
             the unwind_*.o TUs)

So as written, this patch matches arm/arm64 but NOT x86. KCOV
instruments every basic-block edge; the unwinder is a hot path
(doubly so under KASAN, where it runs on every alloc/free), so the
same rationale that justifies disabling KASAN applies to KCOV. I'd
suggest making the claim true by adding:

  KCOV_INSTRUMENT_stacktrace.o := n

(RISC-V keeps its entire unwinder in stacktrace.o, so unlike x86
there's no dumpstack/unwind_*.o to also annotate — the single TU
covers the equivalent scope.)

Alternatively, if you'd rather keep it minimal, just drop "and x86"
from the changelog so the claim matches the code.


Thanks.
Shuai
