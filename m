Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA23E5A05
	for <live-patching@vger.kernel.org>; Tue,  9 Jun 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998211; cv=none; b=s1SypUNFdy5FwptQi5FUs0N6GYJKXyoauPZthdoUzgQnvRmgqaZsOlKVIA48bcbdoPbT0qs6GRoaZMdvXKH4fL1zoHx/OYcwn/5xlJGHIS4EoqodYa2M6VeoyHDJOK1Qq+O6v6jNp8oAgLWSDbUQ1zQEyEOTcOFDkrvNc4v8C/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998211; c=relaxed/simple;
	bh=E2Ltt0U4mmFQEyaRwsaS3Tp+9/ALm4bhHbe+tUpel7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj+m7ixiyP7hPAzcmhUxIOHTmEcyOuyeHs+v9rzf7UD8dDioJ5Z2yMuQedXlYLytFiuHNYfb8EPXeWSIYHw7Zz3VsqT4yYpGOrOEcUcs00eE0UktD4YCVXvikEmO/CvfBvinaw2x193U7LiCWu3MCXXuRkJ3DHj/G2i8dAPE2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XK7x+kBv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XK7x+kBv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b915ded5so45614185e9.3
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780998207; x=1781603007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LEnHb0maSy8g9/4BjSQSLOMIWn5PmICQLX5a0bKKEc=;
        b=XK7x+kBvvKRd4cC892JCxG1ZKmC/c0SxDpRwXwYQTIy0GbxGwfyhQ+fnuAhLHIRcL/
         A03hVawBQvGmavLXAdXkOtAMSHUriHgOyWBCkFrK/Oudy/1tjSkbOTFshi/gTptXQsk0
         OnkIGFF4rKwVhMco3vF8jFVJQLGlIq8z+0bgAIEtgFBrtkGLScl06USiVmEaScJS/dAa
         yqUYM6/71D7w+cnBwki6Xli8gr84zwjOhCQQo8xRcoQ7c/Xa3MRY6twVRX/78kfWrMJ1
         SqmjSNzvB2NPu2tH5Z2keUy9SiPuvOijZgon5Mplh2ZnY/7DxHiJSqOq2MBGSQMsoqSk
         yZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998207; x=1781603007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LEnHb0maSy8g9/4BjSQSLOMIWn5PmICQLX5a0bKKEc=;
        b=PKNIjK7sVotWMb8YTehMzJvVN6XyzEVkJwch2bMpvFnGjAdTRw31HcYJSXXsVLGw61
         VaqS66tZjX8gPJqdnajv7WlFKWuFwL6VnaTJEWOkXxIPszCS8CifxoCKO94m94gUgEne
         Ywa6EN5Jnzpj60ygtsno+JfXp9P5Z3Pe8tv+asYsUeqTi31EMz785WOdaEFb+bHjDgcA
         gQzOesNeUwDeCjrKTdgQZR3Nr8RiG+GvWrT8hwU8hLS4zXpHOdje5wUnabzftgSNPquj
         GQcF2KR1jlPlphDUw08fFmGncgft/1mZ6JcxcGR7K/sJkGUS8Fbeu0HjM/Xcll1x6h0+
         pXqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aW6jg1zM22MJSlB/MtmWSNI8BaiXs49FzlC6cBZZZxrh6HQO/DOXJ6XjvCRnGttt9lhxzGQx8AJbqd22f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbl0o5wzkU67LjS0jzIjY5LiBz6a6/LnFu8+0YdKUOq/9+4fDH
	bkmoQz1+QMlvTdd70T5/OhW5JWj5645pyDU3+ydXqwEFHq0SXwyCyCcBl5nYTxg9sok=
X-Gm-Gg: Acq92OFrW7Tjd++XRyUAD2bzbIqkX8zUJ7J66pIivC5xp3TUy25eEwkmaWmjZbXvLqn
	YMzxotwsWZQBaYcsjzN7DnZLOf9zqYe94n5UGujgwp5d6hv67QtG2tcLPolQm2WhX7qeV7cy3WM
	y3yRxEsfYJeezeVGC03j13p0vzadUZ4jVl3HDv/5SKbNueIPD/j1qD/Xn5jaeIRFkEwuTFxDgGa
	DOeYZ5IAoHKKvIr7NqLTbfEpE/o2PftxkhFD3EfvuccHqvdUKK7VAZ78aB74VGhxipbilwDLyjA
	2aBbUr9/C7ug+z7e8aocIaVCD7Z1oRPlMHg4nlT49ecCHHu+77QzSF7Vt+iChHJ6TmiXJAzXeMa
	VKI2h9guO3geJ7/mLw00uM9clSxDgCSSPIAN72YfhQxLx2OXkLu+fJjIViZWu6/QVWwADpjctcj
	Pv7SCbPdk/P2dieEIy13yxq/k/+i3hcUT/hQNE
X-Received: by 2002:a05:600c:5246:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-490c25d800dmr317190655e9.9.1780998207384;
        Tue, 09 Jun 2026 02:43:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm60610711f8f.20.2026.06.09.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:43:27 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:43:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3] rethook: Remove the running task check in
 rethook_find_ret_addr()
Message-ID: <aifgPaLc_p2vZr5n@pathway.suse.cz>
References: <20260609084953.901576-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609084953.901576-1-wutengda@huaweicloud.com>

Added live-patching mailing list.

On Tue 2026-06-09 16:49:53, Tengda Wu wrote:
> The current check in rethook_find_ret_addr() prevents obtaining a return
> address when the target task is marked as running. However, this condition
> is both insufficient for correctness and unnecessary for its intended
> purpose.
> 
> The check is inherently racy: a task can begin running on another CPU
> immediately after task_is_running() returns false, potentially leading to
> concurrent modification of rethook data structures while the iteration is
> in progress.
> 
> Rather than trying to fix this unreliable check deep in the unwinding
> path, simply remove it. The iteration is already safe from crashes because
> unwind_next_frame() holds RCU and rethook_node structures are RCU-freed;
> even if the iteration goes off the rails and returns invalid information,
> it will not crash. Callers that require consistency must provide a safe
> context themselves.
> 
> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
> v3: Improve commit message: clarify safety semantics and document that RCU guarantees no crash.
> v2: https://lore.kernel.org/all/20260609005728.458962-1-wutengda@huaweicloud.com/
> v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/
> 
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -250,9 +250,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
>  
> -	if (tsk != current && task_is_running(tsk))
> -		return 0;
> -

The description of the function should be updated as well. It still
mentions:

 * The @tsk must be 'current' or a task which is not running.

Instead it should explain that it safe to call the function even
on another running tasks but the returned address is not reliable
then.

>  	do {
>  		ret = __rethook_find_ret_addr(tsk, cur);
>  		if (!ret)

I am still a bit concerned about the motivation.

Tengda mentioned at
https://lore.kernel.org/all/679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com/
that they tried to verify livepatching:

<paste>
Background: We are verifying the support of live patches for functions that
have a kretprobe. The specific verification method is as follows:

We construct a function foo() that calls bar():

void bar(void)
{
    for (;;) {
        schedule();
    }
}

void foo(void)
{
    bar();
}

A kretprobe is attached to bar():

echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable

Then foo() is triggered. The expected behavior is that bar() will call
schedule() and yield the CPU.

After that, the live patch is activated to attempt replacing the implementation
of foo(). The expectation is that this should succeed.

However, in reality, because the task that called schedule() is still in the
RUNNING state, the condition task_is_running(tsk) inside rethook_find_ret_addr()
is not satisfied, causing the function to return early. This, in turn,
prevents stack_trace_save_tsk_reliable() from determining the stack as
reliable, leading to a failure in activating the live patch.

**Not sure if this is correct:**

We believe that after a task voluntarily calls schedule(), when the stack
is expected to be reliable, it is a safe time to activate a live patch.
Additionally, a similar tsk->on_cpu check can be found elsewhere in the
kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
Therefore, we propose changing the task_is_running(tsk) condition to
tsk->on_cpu.
</paste>

More background:
----------------

The test is artificial because it keeps the RUNNING state before
calling schedule, see
https://lore.kernel.org/all/20260608093449.GH4149641@noisy.programming.kicks-ass.net/



My questions:

Does this patch allows to livepatch the above mentioned test code?
Is the livepatching safe?
Does it help in another scenarios?


My opinion:

The livepatching might be safe only when the process is migrating
itself. I mean that it might be safe even when it is RUNNING as long
at it is _current_.

I agree that we do not need to enforce this in rethook_find_ret_addr()
if the function is used also in other scenarios, for example, by
ftrace/BTF for taking snapshots of other processes.

But we need to make sure that the backtrace is reliable when
livepatching (migrating) the task.

Best Regards,
Petr
