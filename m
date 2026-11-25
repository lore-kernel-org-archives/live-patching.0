Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600267;
	b=A9exNv0E6vzFkcM3chqLYTkg6gUCfcfIywYarDLyZQ1eEzLUuCrxGpUWQQXTrTArh11h
	 EjWGW6fQ1Iazf3fvIMkm9P47pr2Xj9J0Q45yk4f+ro1by49k2c3eV8tn5T7zScB0PWiF9
	 aPYcB1ThDv5t86wjeA2NMXcZGO92zNeEK/8xOvA9Mo61+4Y5n6HfGT1YVPsNuAktwYVOQ
	 Hv9AAONaE90PrOM333PRnDuZr9A3xfpPTlY8GTGw24y8FIDILdmjt9dny66bqVQMQmoqB
	 dJx6QLha/pn7IfSACXgRrbjQX8g8yfiAabhXYtfCVGhx0N4ekZxArEfb1bWFcLKeknw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600267;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=AxLOvMePbTstK1DQaZxy8Zd4nIn0KeC9fjuiHgv2EPA=;
	b=sWBSVa8A2nJ9OiskZ5aDQyT+giGN7/8QcSDQgIE6PrIY0McKIwkUF86trtwSn6+LOfXB
	 sjUUmfXTr4oV0xsXOk4KTr4FF43Q4QR80nukh49FZvzUmKUv7mu7+JvQI0PPv6Q0Po+Ik
	 LiYdFg3WQjg5CGZRSqwujqISt9Yix0wXrLsiIGp34cfFWVyt28YdWGK3Eh/Be1VhRd8D5
	 G9him4Bnt00LIOm2zTOrWZEm8dwln5VVEEC2HvVWVUR0/vki9+qqSEuy5zLruKcMEJaKO
	 MoYrw8/LGaw6tlTja8c7NjDfsJ18oe8KDwRzl/1sC7THD+SappIgf8+oMJltD4rVNiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=lPPMUnQw;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85B606A31E;
	Wed, 25 Nov 2026 09:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E85B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=lPPMUnQw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AxLOvMePbTstK1DQaZxy8Zd4nIn0KeC9fjuiHgv2EPA=; b=lPPMUnQwGoj6MlAqBh6Km74I49
	5sQ+/J8NI+Nr5rHiBEWHAopVyLCf8JFNU/c3KAq32ud9lwlG9yjgxclrt0mHa/dwwXBSIzjPMKh/K
	zBO/U3yGqg6OJjnUs/tdiRFWD3C2z99elIQuEBRxnKfIxPTZX3J1j+6G1Xzu3D+YKK5fT8C9yqI5m
	bkjjtC/R44RK/NbU5kMjo6jBX8tyrTY9ZVwYX96cV0NXkybYmI1FN7NkyCeqPA9lL5nWrvXxbGNaT
	yHOEqoK76OnipdSenQmU0mAbWKJCEzUTB/4h1GB0d26kbsVRkrWnd16LYemGeof5LGGkBVLcH2h3B
	t/34hU2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9eT-0000000A7SR-12Iy;
	Wed, 25 Nov 2026 09:50:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A10EF300446; Wed, 25 Nov 2026 10:50:56 +0100 (CET)
Date: Wed, 25 Nov 2026 10:50:56 +0100
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
Message-ID: <20261125095056.GZ2668804@noisy.programming.kicks-ass.net>
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

How does the freezer handle this? I mean, systems doing this must also
still suspend, right?
