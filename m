Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701967;
	b=KuewT0X/POxysfVLECQuCMaazq6o37wftTLwohPXapoJ3WBYwFblTsFYMDMR3tN39f1C
	 gEotYPJ6zF9i5N1MhYpvMX9CB0uz3Z++pWBerzuaBMv9JFc1kzblj7z5Z7SqsX224H3Vf
	 z/TkI2VVZANNmrdAlbuk3A6f3Cb0mQOD2QW8VfO4TL2goYYnHzyzIr6i3T/SyJP524MW/
	 uxM3nKEob1w9EsD99WvM44yHCa2ikABMaeWQcl4efUOnl0+TW4sGnkTYBOjd4ZpbtlcTl
	 WFJVwjy0c6tZf3oXHrbda7XBwrlrCLEZ0s2GH8sAYcHU24uuBXpRgepzSpBwvPWqntw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701967;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/KDx6PRDjEGDYnhz2VHuKJaW+Yap8yQnZ51Ns2dL25s=;
	b=BM9RJ79VXmpLj/aitAKZSbePqDqEBZr+D5674PoWURJ7cg0WiTRx1oizcVP6LyokUbhO
	 WZJWZIIrAMlCrftI7Ns6T1FvEBa6kGhUk4SyPYg2JFpv+Bwe5MPrcVI5FHtDlbjDQVMCA
	 OcrnnBRuuWm6UpJ2EtehXVxZfCDPh1AOplDh437GBWAHbXODQMppQJPpKrse3PPioh0tv
	 OQIo+by+HHysC0y037RYveBwQQ+442kmPSrMEU0IWTwHX0WDhIwFqsjOgNE52+8pDD1jv
	 85THDxV0hSgN08VDHvdvqGhFuimKGfdvI50J0J8LzZFxD27CKg5BY49lrtIajZleeBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=R5s36xpL;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F8606A31C;
	Thu, 26 Nov 2026 14:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9F8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=R5s36xpL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/KDx6PRDjEGDYnhz2VHuKJaW+Yap8yQnZ51Ns2dL25s=; b=R5s36xpLZZgPLm9uLI7A4NQRBp
	BcPgrPg+UI4fudIwP0wP6NTooKgKiXNWPYZpuS/veOMyx1kOm4nEw771tf7kE1zfnN8w3pELMShiN
	aYwdVBEvtUzJbAfsPevaUf519f/405eaGSY8InuwM3EgTs8Xb96n3CkaCCQqfQ6QHZJu4X8FdgWw8
	HBv+R/JOMiqAWTMxYfzFskKB/zrGOeT22awtZfEWXrRhI6AfDVniH/bG/zthugHR4EwOgbilFbKzi
	KhKsTHLS9qNxHMKPEmWju28vjo5bK0sRpWl9cA9RNj+90TMeK7/tuz3xYlExMN2UGkCAjyAUwQ8Sl
	0eaVhJPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWa6p-00000004qEY-2zZJ;
	Thu, 26 Nov 2026 14:05:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E534302186; Thu, 26 Nov 2026 15:05:58 +0100 (CET)
Date: Thu, 26 Nov 2026 15:05:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, Miroslav Benes <mbenes@suse.cz>,
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
Subject: Re: [PATCH 1/2] sched, livepatch: Fix transition stall for CPU-bound
 tasks
Message-ID: <20261126140558.GF49833@noisy.programming.kicks-ass.net>
References: <20261117045254.1048298-1-dylanbhatch@google.com>
 <20261117045254.1048298-2-dylanbhatch@google.com>
 <awIMltMpXzhXiDpU@jpoimboe>
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
In-Reply-To: <awIMltMpXzhXiDpU@jpoimboe>

On Sat, Nov 21, 2026 at 01:55:39PM -0800, Josh Poimboeuf wrote:

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index e058d21d84b75..1ccbae2051c72 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -402,12 +402,22 @@ static void klp_send_signals(void)
>  		 * Meanwhile the task could migrate itself and the action
>  		 * would be meaningless. It is not serious though.
>  		 */
> -		if (task->flags & PF_KTHREAD) {
> +		if (task->flags & (PF_KTHREAD | PF_USER_WORKER)) {
>  			/*
>  			 * Wake up a kthread which sleeps interruptedly and
>  			 * still has not been migrated.
>  			 */
> -			wake_up_state(task, TASK_INTERRUPTIBLE);
> +			if (wake_up_state(task, TASK_INTERRUPTIBLE))
> +				continue;
> +
> +			/*
> +			 * If it's running, force it through __schedule() so
> +			 * it can switch itself in klp_sched_try_switch().
> +			 */
> +			if (task_curr(task)) {
> +				set_tsk_need_resched(task);

That's broken. Preempt state is more than just the TIF bit.

> +				kick_process(task);
> +			}
>  		} else {
>  			/*
>  			 * Send fake signal to all non-kthread tasks which are
