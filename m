Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9F382387;
	Sat, 10 Oct 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603545; cv=none; b=MNYBfbInpfBxPO9PDVQ22ae7pngN/5deQAWaodkgjuXhp50KJkFb0+W8Xw1pgF9sH3JTDRqXECAtKaOmUlhM2wXleQ0wPcAa3YMuNhBZhQul9iISbw2NRQJp568lmqp2XU1OTupEMr8zDXvSPAhb5VK+GiZk3ovcsQVI3+i04lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603545; c=relaxed/simple;
	bh=ypmEU6kQKeao3mRXaldZjjVkM83muqmZMU5NsPKJLR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4lj2eSq8wvwOW2P2zyvwTcT2Xm9dGBcuu1RmhPv6NQ2MWcLzqgOxrZDfy1lcft6tOneM+udU1vU7gwaUa5mA6ZS+8zFA99rIgo/AVHhEPuO/N+oEglN3edvyoYmtwHLKhyj4o9atACUBVTBkp41t/dTPF8UzoU1nEsV0HjQGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A7q/o2Av; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A7q/o2Av"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791603530; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SBB6AWvERMNQNcnv8IpcOyFkUIlmwIKsnK5k1h4Id5s=;
	b=A7q/o2AvOzEhw+XVOO+FKT/EhKev/5wGvR/VpaRI9XdOIHZBcd1UW+dbdK0h45sB7wCUdNjd3SXx/jaB6FwkBHmtKKkp6k1TZG4AnvnuTJJwNPdAnAUOyeJ09kfc++FAYP5CM51jh3dlCAMgIHK6CpzBoaulHpYCWiupwm3Y4Yc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0XCUukT6_1791603526;
Received: from 30.246.161.155(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XCUukT6_1791603526 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 11:38:47 +0800
Message-ID: <2650577a-a359-495c-a6bf-47a825e9282a@linux.alibaba.com>
Date: Sat, 10 Oct 2026 11:38:45 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] riscv: stacktrace: switch to frame-pointer based
 unwinder
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, oleg@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com,
 shuah@kernel.org, mpdesouza@suse.com, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com, martin@kaiser.cx,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-6-xueshuai@linux.alibaba.com>
 <20261009185904.82385-1-kmehltretter@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20261009185904.82385-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/26 2:59 AM, Karl Mehltretter wrote:
> On Mon, Sep 14, 2026 at 05:26:46PM +0800, Shuai Xue wrote:
>> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
>> +				      void *cookie, struct task_struct *task,
>> +				      struct pt_regs *regs)
>> +{
>> +	struct kunwind_consume_entry_data data = {
>> +		.consume_entry = consume_entry,
>> +		.cookie = cookie,
>> +	};
>> +
>> +	kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, regs);
>> +}
> 
> Hi Shuai Xue,
> 
> With this patch and FRAME_POINTER enabled, return_address() returns the
> caller one level further up than asked for.
> 
> return_address() in arch/riscv/kernel/return_address.c skips level + 3
> entries from arch_stack_walk(). The arm64 original skips level + 2. The
> third entry exists on mainline because the walk starts inside
> walk_stackframe() and first reports the return into arch_stack_walk().
> With 5/7 the walk starts at the caller of arch_stack_walk(), so
> level + 3 now skips a real caller. CALLER_ADDR1 and up are built on
> return_address(). The irqsoff tracer and the preemptirq tracepoints use
> them.
> 
> A KUnit test that calls ftrace_return_address() from
> leaf() <- middle() <- outer() <- check() returns:
> 
>               af32da41b032   with series   with series, level + 2
>    level 0    middle         outer         middle
>    level 1    outer          check         outer
> 
> The change to level + 2 has to depend on FRAME_POINTER. Without it the
> series keeps walk_stackframe() and the result is the same as on
> mainline. There, level + 2 makes return_address(0) return an address
> inside return_address().

Hi, Karl,

Nice point. Thank you for the thorough review and the KUnit test.
The analysis is spot on, and your table matches my reading of the code
exactly.

> 
> The same extra entry makes stack_trace_save() start one frame too early
> on mainline. 5/7 fixes that. I have a small fix for it on mainline,
> meant for stable kernels, which conflicts with 5/7. I would post it with
> you in Cc. Tell me if you would rather take the return_address.c change
> into 5/7 first.

Please go ahead with your mainline/stable fix for the
stack_trace_save() off-by-one as an independent patch. You are right
that this is a separate mainline bug: stack_trace_save() hardcodes
.skip = skipnr + 1, i.e. it expects the first entry reported by
arch_stack_walk() to be the return into stack_trace_save() itself, and
mainline's walk_stackframe() breaks that contract by reporting the
return into arch_stack_walk() first. A 7-patch series is not a vehicle
for stable, so the minimal fix is the right approach there.

Please keep me in Cc when you post it, I will review and test it.

> 
> Tested with clang 22 and the series applied on 52318cf0fa6e. The
> "with series" column is the same on QEMU's virt machine and on a
> BeagleV Ahead (TH1520). Everything else ran on QEMU only.

Thanks again for testing on real hardware (BeagleV Ahead) in addition
to QEMU, that is much appreciated.

Best regards,
Shuai Xue


