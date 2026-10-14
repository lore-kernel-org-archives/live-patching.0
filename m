Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71B4E36D2;
	Wed, 14 Oct 2026 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983408; cv=none; b=YMvs8yI8hHBnqcLgtNemHYr687qAAnnBXCE3nrmJ2Ttb/mliC5NtA/9H4gYSzrz8o89RiPDNGvR4Gw/7dP82qkjkM7BwLtKs991ggGFvs7lXYDIjsIURpmaIjtCESsJJ2rorTLRVRqnVrbSU62pci5ybVDQJ93DTegahvsskVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983408; c=relaxed/simple;
	bh=Cvx4lOh9Q81VjksKJoawg6eN+66LrK3LWXSnIiPRD38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOdGlcoLFuyVbwq5M110eaWIStqs5jkRPl0CHLsa397UtSyhfBxuLt9RUNeXMuXhZzPKtI++jbHr3by4HQRqXEhaXSYPO9hYRGz+ZzXzzLuLhXNRlw4RaYyPTz8Gk4l1E5GVPCMQGJaDmE93a9jIy0lhgP3N1HroDRYWgpvnJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iSixPOae; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iSixPOae"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791983396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NfvwyHiH13gScZyLRyJ1bRdwmOqWUvSNVK5u+We9JrM=;
	b=iSixPOaemVe3z3Yi4IgI0ylhSBaW79McGva8sjz5K2ApcHgRTgDtuhXpB9Pta0nH4gdMfEdgYrK0ROzbeSUBjsvyPoyA1vALDg+D0pzXhM5kq2d+3dE2/kJ2rT+FmiGOk7gnSofyXnoUJv/XeCEKRFXhZGTr/y2muvJ88akLbCY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0XCp3Qsf_1791983391;
Received: from 30.246.161.148(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XCp3Qsf_1791983391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 21:09:54 +0800
Message-ID: <3bd83dc6-1206-4af2-bfcf-5894b1029907@linux.alibaba.com>
Date: Wed, 14 Oct 2026 21:09:51 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] riscv: stacktrace: switch to frame-pointer based
 unwinder
To: Martin Kaiser <martin@kaiser.cx>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, oleg@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org,
 jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com,
 shuah@kernel.org, mpdesouza@suse.com, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-6-xueshuai@linux.alibaba.com>
 <as6SEF4v6wt5GmVD@nb282.user.codasip.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <as6SEF4v6wt5GmVD@nb282.user.codasip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/26 4:18 AM, Martin Kaiser wrote:
> Thus wrote Shuai Xue (xueshuai@linux.alibaba.com):
> 
>> From: Wang Han <wanghan@linux.alibaba.com>
> 
>> Replace the open-coded frame-pointer walker in arch_stack_walk() with a
>> robust kunwind state machine, modelled on arch/arm64/kernel/stacktrace.c
>> and retargeted to the RISC-V {fp, ra} frame record convention. The new
>> walker tracks stack bounds, consumes frame records monotonically,
>> understands the metadata pt_regs records added in the previous frame
>> record metadata patch, and recovers return addresses replaced by
>> function graph tracing and kretprobes.
> 
>> This commit introduces arch_stack_walk_reliable() but does not yet
>> select HAVE_RELIABLE_STACKTRACE; that is done in a follow-up Kconfig
>> patch so this commit can be reviewed and bisected as a pure unwinder
>> replacement. Until that Kconfig change lands, livepatch is not yet
>> enabled and arch_stack_walk_reliable() has no in-tree caller.
> 
>> Three related callers are updated to keep the same frame-record
>> assumptions everywhere:
> 
>>    * Function graph tracing: the old RISC-V unwinder matched function
>>      graph return-stack entries by the saved return-address slot. That
>>      was consistent with the static mcount path, but not with the dynamic
>>      ftrace path where the parent slot is ftrace_regs::ra. Use the
>>      architectural frame pointer as the function graph return-address
>>      cookie, matching the kunwind walker.
> 
>>    * Perf callchains: route kernel callchain collection through
>>      arch_stack_walk() so perf sees the same frame-pointer unwind
>>      behaviour as dump_stack() and the upcoming livepatch path.
> 
>>    * dump_backtrace() / __get_wchan() / show_stack(): these now go
>>      through arch_stack_walk(); the explicit "Call Trace:" header is
>>      moved into dump_backtrace() to preserve the original output.
> 
>> The non-frame-pointer fallback walker is kept untouched for
>> !CONFIG_FRAME_POINTER builds.
> 
>> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
>> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   arch/riscv/kernel/ftrace.c         |   6 +-
>>   arch/riscv/kernel/perf_callchain.c |   2 +-
>>   arch/riscv/kernel/stacktrace.c     | 561 ++++++++++++++++++++++++-----
>>   3 files changed, 473 insertions(+), 96 deletions(-)
> 
>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> index be8b685144174..0facd824c911d 100644
>> --- a/arch/riscv/kernel/ftrace.c
>> +++ b/arch/riscv/kernel/ftrace.c
>> @@ -245,7 +245,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>>   	 */
>>   	old = *parent;
> 
>> -	if (!function_graph_enter(old, self_addr, frame_pointer, parent))
>> +	if (!function_graph_enter(old, self_addr, frame_pointer,
>> +				  (void *)frame_pointer))
>>   		*parent = return_hooker;
>>   }
> 
>> @@ -267,7 +268,8 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>>   	 */
>>   	old = *parent;
> 
>> -	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
>> +	if (!function_graph_enter_regs(old, ip, frame_pointer,
>> +				       (void *)frame_pointer, fregs))
>>   		*parent = return_hooker;
>>   }
> 
> 
> Are these two changes fixing a bug in the current code (that is independent
> from the rest of this patch)?
> 
> Without your changes, function_graph_enter_regs writes a struct ftrace_ret_stack
> with retp == the saved ra.
> 
> And the only place where retp is fetched and checked is
> 
> function_get_true_parent_ip
>     ftrace_graph_ret_addr(..., (uintptr_t *)ftrace_regs_get_stack_pointer(fregs));
> 
> The stored retp is checked against the stack pointer.
> 
> Your changes store fp instead of ra, this seems the right thing to do. (And
> it's in line with other archs.)
> 
> Should those two changes be in a separate patch (that can be backported to
> stable kernels)?

Hi, Martin,

Thanks for the sharp question.

You are right that the stored cookie is broken. What
ftrace_graph_func() passes as retp is &arch_ftrace_regs(fregs)->ra,
i.e. the slot inside the transient ftrace trampoline frame, which is
popped as soon as the callback returns. That has been the case since
35e61e8827ee8 ("riscv: ftrace: Make function graph use ftrace
directly") introduced ftrace_graph_func() in v6.8. (The code was
copied from arm64's ftrace_graph_func(), but arm64 passes
(void *)frame_pointer there - see 41705c4262aac for the current
shape.)

Since distro kernels only ever use the dynamic path, the net effect
is that the shadow stack is never consulted during unwinding:
whenever the function graph tracer is running, dump_stack(), perf
callchains and __get_wchan() report return_to_handler instead of the
real caller.

I will split these two changes into a separate patch and cc stable.

Thanks.
Shuai
