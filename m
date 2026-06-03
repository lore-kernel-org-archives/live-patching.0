Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CB23C4E9;
	Wed,  3 Jun 2026 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451680; cv=none; b=M3Dy2DqFcqZdIK2K+SycxLhTj1S2IW/e/ZnB41JeefWA0Cb/5XVtviu02PN5BE64WC/y4m2kVOKPgXONGRjnvVQysJuRKt2HUysK8NgIpeMJHR8l7W/iurLWRue1qmLBtrXZfwWLID/KWWtqehGbO6G/6VoKh47pKx5jiy6IMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451680; c=relaxed/simple;
	bh=FOxZC/YiUM7ajtKoiUohKoNaBkLvqGc6ykRYlSqUwz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fC15d2fr+K5gey3rdmQyPfnmB4VIAUsoxRPSBs7c289w5IUThVc2gaWxjF0KV93qCOcVvh2vRz9DpfsdOdzIa32njdTfGq2/SkaKkrIaZWbesN57AjixRS3j4EaOOAKO3jsYPUM9Yw2MJrcsON36r+ZktGFxFUfaQO+/tk1QMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=caWSVe2w; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="caWSVe2w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780451669; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GWtBiyHejnv89FPEQifhOKPx8r0yHdFw2ecrmrvXlug=;
	b=caWSVe2wqL4CJxol7sdMGfsHR+x9BjbSRboevvaHw29ijly8eZ3tdoCkixwQz/6nMd9XZnaORYEoMZFrJFNFeRDKOoWrnRnlilKzPzunEv5WwZlza+RkDJCrRP9pWHbwHFtOaEHt0wl0A8DKt7YS1yhfuvTHsRCN0RFTXKtNZbk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X45g72Q_1780451665;
Received: from 30.246.177.175(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X45g72Q_1780451665 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 09:54:27 +0800
Message-ID: <1bb1f3e3-1cba-426c-aa70-d50df8114636@linux.alibaba.com>
Date: Wed, 3 Jun 2026 09:54:25 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/livepatch: Add RISC-V syscall wrapper
 prefix
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
 <20260528082310.1994388-9-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260528082310.1994388-9-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/26 4:23 PM, Wang Han wrote:
> The syscall livepatch selftest resolves and patches a syscall wrapper
> symbol. To use that test for RISC-V livepatch validation, add the
> RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.
> 
> Without this macro, the syscall livepatch selftest cannot resolve the
> RISC-V target symbol, and the syscall-related livepatch test fails on
> RISC-V.
> 
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> ---
>   .../testing/selftests/livepatch/test_modules/test_klp_syscall.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> index dd802783ea84..275e4b10cf59 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> @@ -18,6 +18,8 @@
>   #define FN_PREFIX __s390x_
>   #elif defined(__aarch64__)
>   #define FN_PREFIX __arm64_
> +#elif defined(__riscv)
> +#define FN_PREFIX __riscv_
>   #else
>   /* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER */
>   #define FN_PREFIX

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
