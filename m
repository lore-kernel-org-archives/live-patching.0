Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A384CCF;
	Wed,  3 Jun 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451376; cv=none; b=X+PJKTy8AxA7NI6Ocki365S5Wfgwjo1VWsrmPHgmFFPQDjW1FZmhIhQWg3Fz2QciD/Bu682f8DpWVJieFCpI25LBy+ONtcM2zbLowVw6lhnWAMcnKq2El4iv79zx22LDRIJ18QzMVTKA6kZNbAZyF2Z5o8F+liOeTvjFkHmS/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451376; c=relaxed/simple;
	bh=eiiIVuINwTsPUnnbhML53HJVRhKPFYxi6Yxalf/+Ddw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1Y3NLN2M3I4dxePoi5e5O4fS4LHOWi1VHURL0UWXU+pBm0fqdsFo4B8iuABosBY7Y+CBAMDZB6gpnTdjaL3ArZ3R1L7VJILJ5XGpssXLtsYAsvhtfy3q59umupxrkwb6uMvL5e+POMDHTMFPlPpzZQtgxnMRtF2gsfZSYN3SOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T2B6uQJN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T2B6uQJN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780451371; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5c6u0pQsZNF6kyUVcoFwMxuHgokBKqWxj4uNhSsZtgs=;
	b=T2B6uQJNfcQ7+4Ra0bmuSasZ64k9hyrb8bNbYBr5aS9xmtki1xthED7h3CBkOv0CgEG8hJooqymsek/LKhsqszcbpmNPBdGfcOviHxRdxRtcgXIbM5Nagn4nc9SIpCryyClYA0u8nG9qeSUHIuQ95MLd5JWqjLwJagotzJvu+LE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X45nr59_1780451367;
Received: from 30.246.177.175(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X45nr59_1780451367 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 09:49:28 +0800
Message-ID: <a88b8245-04d1-41db-9507-aaddfbd8e042@linux.alibaba.com>
Date: Wed, 3 Jun 2026 09:49:26 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE
 and HAVE_LIVEPATCH
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
 <20260528082310.1994388-8-wanghan@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260528082310.1994388-8-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/26 4:23 PM, Wang Han wrote:
> Now that the metadata frame records, the kunwind state machine and
> arch_stack_walk_reliable() are all in place, advertise the capability
> to the rest of the kernel:
> 
>    * select HAVE_RELIABLE_STACKTRACE under FRAME_POINTER && 64BIT, so
>      only the configurations that actually have the metadata records
>      and the FP-based reliable walker enable it.


The 64BIT gate is conservative scoping rather than a hard technical
requirement: the metadata frame record, kunwind state machine and
arch_stack_walk_reliable() all build on RV32 too (and the
call_on_irq_stack change in patch 2/8 actually fixes a latent RV32
issue). However, the syscall livepatch selftest and module relocation
path have only been exercised on RV64 (QEMU virt SMP=2/4/8). The
64BIT gate can be dropped in a follow-up once RV32 has equivalent
coverage.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
