Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703367;
	b=KGbiGL+6sH1JwsOq/YSyIkIn91X0zzR7ktDA96vh24T94u+nQpZmcoVX46Wbb95wxwR6
	 o0dQMa+pYYdeC84/h720lxK2bumZub2yLvF3Xt1ryuhkwbrKYpqpm35H71xnBA01Lf2Lq
	 4QBGoYbjmYPWWI9+913V9C5A4mq2MrCBUsb2B56WzUCKfYBuLO2px4HMGd1JTK8zuk99+
	 pAqUrnlHFkt/F/hX/+ZoiJeO3RnsNVC4Akzgz0nAO3UngYIhwR37627KtRkmypZ3J1VUK
	 Lzykh6D3T75MG4CYqyVOkFCCMtDMxBWW+P151+ZXREVMnPlQRlm+2SSO4pDdKUyE0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703367;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=X/hkMTLizOgiJJFWSRYAIdxVXL58/kl9lpN57LuWZzk=;
	b=4QkTJ7ly4f7bMxXCy92DuRSXx9EIacNrSxTEMobcfVwkxjw4feJivvLYtb5+pkK9pu58
	 1PkIwEVlSSBQAqG8vlGdzutUR+QZgGV1RUyrmrrtH3suEOIUxc3xkdp7gWcZsKUSpGva6
	 v7s1KcBJ7uKdQFDw67yLowY8fcQ4YtUZ3P+JMHECA1s5K9FPwBBvvLHyB2hq60gE4Ylhm
	 X3ffeWda4C2sn51SHsbPl9XYPpQoGEYLK9NWFIboIWJ8pVOZHuWpOsvCJYR4VaBImJS3o
	 rE291q6WcFD/C4OOXo2yeaeiK6IwwHUL2LVNndUa5JBJlqZ1rMUUCOYhcIShUnfBk6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DEbUvSqi;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0B606A32A;
	Thu, 26 Nov 2026 14:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E0B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DEbUvSqi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X/hkMTLizOgiJJFWSRYAIdxVXL58/kl9lpN57LuWZzk=; b=DEbUvSqiqK3+fRUioPFsTd6DGU
	7Bue1eKVXG16DQ/lJ6hdbVlpddRVxEoV6YC3ejTd6kYzzNd0RixU341WKtCOTVxmqcRsNAaUN8M/i
	LITTwVlxykWSLpSPLAjIZM4xsjSwf08Am+2a6xPWDcAxV4w8iIY6QFIhM0ViACRWHkGkRvMST1IIe
	3emxZ8CNTuFf3FkP2JT8pvSeTNDGL7ycstOoysB22zH6bBeTh+3wvFe20duXyk96zuBtY84zuaZRS
	XPBcxQ25F1t1L1H/9zJ/0GrFwm/f5Ymi6VHLfwKJOe6FPoM+/mq9StLKGHw8pPoGEWsD2f8jEJ6uG
	l/pFHKVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaTP-00000005HKN-2qkX;
	Thu, 26 Nov 2026 14:29:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 355A5302186; Thu, 26 Nov 2026 15:29:19 +0100 (CET)
Date: Thu, 26 Nov 2026 15:29:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] sched, livepatch: Fix transition stall for
 CPU-bound tasks
Message-ID: <20261126142919.GG49833@noisy.programming.kicks-ass.net>
References: <20261125041900.3243569-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125041900.3243569-1-dylanbhatch@google.com>

On Wed, Nov 25, 2026 at 04:18:58AM +0000, Dylan Hatch wrote:
> Commit 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and
> live-patching") moved klp_sched_try_switch() from _cond_resched() into
> __schedule() and gated it on READ_ONCE(curr->__state) & TASK_FREEZABLE.
> This causes livepatch transitions to stall when CPU-bound kthreads,
> PF_USER_WORKER threads (such as vhost-<pid>), or user tasks in long
> kernel loops spin with cond_resched():
> 
> 1. Even when __schedule() is entered via preemption or an unfreezable
>    sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
>    sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
>    TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.
> 2. A sole runnable task spinning in the kernel never gets
>    TIF_NEED_RESCHED set during sched_tick(). In klp_send_signals(),
>    wake_up_state(task, TASK_INTERRUPTIBLE) is a no-op for a
>    TASK_RUNNING task, and set_notify_signal() sets TIF_NOTIFY_SIGNAL
>    without TIF_NEED_RESCHED, so the resulting reschedule IPI returns to
>    kernel mode without entering __schedule().
> 
> Patch 1 fixes both issues by dropping the TASK_FREEZABLE check from
> klp_sched_try_switch() (relying on stack_trace_save_tsk_reliable() in
> klp_check_stack()) and kicking still-running unmigrated tasks via
> resched_cpu() in klp_send_signals() (as well as waking interruptibly
> sleeping PF_USER_WORKER tasks).

So I didn't get a reply on my v1 comment, and I still have the same
quesiton; how isn't any of this a problem for the freezer?

The intent was to make sure that a patch problem is a freezer problem
and we fix both together.

Both cases above would also delay freezing, no?

It seems I have overlooked try_to_freezer() /
kthread_freezable_should_stop(). Those should also do the patching
thing. And then its a matter of adding either of those to whatever loops
you think are lacking.

