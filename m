Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249F3DE43D;
	Tue,  9 Jun 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003570; cv=none; b=Gu5YHzRN0Jx2WnZsYvgBeZ/O3mYvJ1dXYNx2dE1rTtVEwRhabzSEmaXdQ7qzhTXlsshSEx75UnuHwz71EgMtty8eNYl17APSCK5ieRpbWYylLEDfD4vEEpecc9KqpZDAf5Z/9qN2bbuJmNBPpyvXaagPi1Dafi2lBc7YXGdxJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003570; c=relaxed/simple;
	bh=oGE5IqzKMCLbD/Z2qQ5P7uwoBIR1kaFEi2KeeJ7yfOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7zZIg/j9vsqzHgvS/4sgoylu7Gq+I/t3KW8c8Kx/+MNXZ9G2nvCmW7IVDtG4C5Xly59Y327lnSmxkYoKRt/cs8uxPewDsOBhEacJqlbrqA1MLo6m0cZY33Hmm8s/7erTCsAkMnLzOlEwIsfw1jE0AV9AslcvfGB32/uY0NmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZR7s5yb1zKHMYM;
	Tue,  9 Jun 2026 19:12:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3D75C40573;
	Tue,  9 Jun 2026 19:12:45 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgCX638p9Sdqaoy6BA--.27532S2;
	Tue, 09 Jun 2026 19:12:43 +0800 (CST)
Message-ID: <e016536c-df99-4de8-a8fb-6ac50932fd2f@huaweicloud.com>
Date: Tue, 9 Jun 2026 19:12:41 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rethook: Remove the running task check in
 rethook_find_ret_addr()
To: Petr Mladek <pmladek@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
References: <20260609084953.901576-1-wutengda@huaweicloud.com>
 <aifgPaLc_p2vZr5n@pathway.suse.cz>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <aifgPaLc_p2vZr5n@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCX638p9Sdqaoy6BA--.27532S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr17tFW3WF43KryxCw1rWFg_yoW7WrWxpF
	W7W3WYkFWDJw1IyrnF9w4fGry5Zws5G3y3Grn5Gw1FkFn8A3Wxtr4xKw4Y9a98urZ5Ga12
	qr42q3srCF1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/6/9 17:43, Petr Mladek wrote:
> Added live-patching mailing list.
> 
> On Tue 2026-06-09 16:49:53, Tengda Wu wrote:
>> The current check in rethook_find_ret_addr() prevents obtaining a return
>> address when the target task is marked as running. However, this condition
>> is both insufficient for correctness and unnecessary for its intended
>> purpose.
>>
>> The check is inherently racy: a task can begin running on another CPU
>> immediately after task_is_running() returns false, potentially leading to
>> concurrent modification of rethook data structures while the iteration is
>> in progress.
>>
>> Rather than trying to fix this unreliable check deep in the unwinding
>> path, simply remove it. The iteration is already safe from crashes because
>> unwind_next_frame() holds RCU and rethook_node structures are RCU-freed;
>> even if the iteration goes off the rails and returns invalid information,
>> it will not crash. Callers that require consistency must provide a safe
>> context themselves.
>>
>> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>> v3: Improve commit message: clarify safety semantics and document that RCU guarantees no crash.
>> v2: https://lore.kernel.org/all/20260609005728.458962-1-wutengda@huaweicloud.com/
>> v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/
>>
>> --- a/kernel/trace/rethook.c
>> +++ b/kernel/trace/rethook.c
>> @@ -250,9 +250,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>>  	if (WARN_ON_ONCE(!cur))
>>  		return 0;
>>  
>> -	if (tsk != current && task_is_running(tsk))
>> -		return 0;
>> -
> 
> The description of the function should be updated as well. It still
> mentions:
> 
>  * The @tsk must be 'current' or a task which is not running.
> 
> Instead it should explain that it safe to call the function even
> on another running tasks but the returned address is not reliable
> then.
> 

Oh, I forgot that. Thanks for pointing it out.

>>  	do {
>>  		ret = __rethook_find_ret_addr(tsk, cur);
>>  		if (!ret)
> 
> I am still a bit concerned about the motivation.
> 
> Tengda mentioned at
> https://lore.kernel.org/all/679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com/
> that they tried to verify livepatching:
> 
> <paste>
> Background: We are verifying the support of live patches for functions that
> have a kretprobe. The specific verification method is as follows:
> 
> We construct a function foo() that calls bar():
> 
> void bar(void)
> {
>     for (;;) {
>         schedule();
>     }
> }
> 
> void foo(void)
> {
>     bar();
> }
> 
> A kretprobe is attached to bar():
> 
> echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
> echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable
> 
> Then foo() is triggered. The expected behavior is that bar() will call
> schedule() and yield the CPU.
> 
> After that, the live patch is activated to attempt replacing the implementation
> of foo(). The expectation is that this should succeed.
> 
> However, in reality, because the task that called schedule() is still in the
> RUNNING state, the condition task_is_running(tsk) inside rethook_find_ret_addr()
> is not satisfied, causing the function to return early. This, in turn,
> prevents stack_trace_save_tsk_reliable() from determining the stack as
> reliable, leading to a failure in activating the live patch.
> 
> **Not sure if this is correct:**
> 
> We believe that after a task voluntarily calls schedule(), when the stack
> is expected to be reliable, it is a safe time to activate a live patch.
> Additionally, a similar tsk->on_cpu check can be found elsewhere in the
> kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
> Therefore, we propose changing the task_is_running(tsk) condition to
> tsk->on_cpu.
> </paste>
> 
> More background:
> ----------------
> 
> The test is artificial because it keeps the RUNNING state before
> calling schedule, see
> https://lore.kernel.org/all/20260608093449.GH4149641@noisy.programming.kicks-ass.net/
> 
> 
> 
> My questions:
> 
> Does this patch allows to livepatch the above mentioned test code?

At least it will no longer be blocked by the rethook check.

> Is the livepatching safe?
> Does it help in another scenarios?
> 
> 
> My opinion:
> 
> The livepatching might be safe only when the process is migrating
> itself. I mean that it might be safe even when it is RUNNING as long
> at it is _current_.
> 
> I agree that we do not need to enforce this in rethook_find_ret_addr()
> if the function is used also in other scenarios, for example, by
> ftrace/BTF for taking snapshots of other processes.
> 
> But we need to make sure that the backtrace is reliable when
> livepatching (migrating) the task.
> 
> Best Regards,
> Petr

Peter actually touched on this point earlier:

<paste>
Things like live-patch use task_call_func(), which ensures the callback
function is done while holding sufficient locks for the task to not
change state.
</paste>

From my understanding, removing this check should not introduce
stack reliability issues for livepatch.

Thanks,
Tengda

