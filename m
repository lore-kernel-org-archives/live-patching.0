Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4083EFD15;
	Mon,  9 Feb 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664367; cv=none; b=kF/UYlTGAr/+99PWDe/aZcpXoUWDjGT2p30roSx5NQ4ebdIu/Muc7y5NTtqGMg84S7T9UCN5Z8CPbD/xk4oZTc2asdgOh8FMyTJXCXBb/jx4mQ641wI8I+L1sr75V+HJdR/ugH8ZLgtXJJmhkwXhfJ177B6DweeUkqvTr8jMh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664367; c=relaxed/simple;
	bh=6ZDcdVElo1I+iEUpWipYE7x/VGAUFpl3Pvk7KAGKaOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwuaB+3kezVMrqRB5NoLm8TA0SW2lOxXuOcFwqmormQ4Nm+ApAMWBigbgNy0I1MG2uHM4Z3OqQIp43tXOh2eyptmQbNC+B7bbXNEk1gahWvPyfHP34Di7EZE5UiR56aTDaOhWOI5D9cMBGhq9gSIGNosIRQXnZrGkOImgN/EfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RxuFg6X3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxuFg6X3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nA8xVVDIw/ShaxnFuOo+IP+3zPEfDN+cOzzQF9mGrXY=; b=RxuFg6X33Q6QxmbS4XFPjzK4HV
	ddsbJ8FPyealQW4EiiOfzLnsIp6VH6P6+JshYzt9O2GqMCjpDvBF7UFa2nusZwRe1chzmZHU4HXrS
	zcouAVdLuDLR/3nXf+/avW1wis9uNPWPdpyobPdGrg+qOZ3LWleDW+3yRx9p1BDqAiX0XT1UQtH09
	A384wxRQBK0fkltamnB1F5DilGp0mSBc4Ve3ozysLAh8IlcL/QzmUvdmamqVOLG3m9w8vZSPQ2oYQ
	iNp72M6CLEC7jveLlVEfNzjgZBw2jn9Lnfeon0hBG4nDfIZ8VxenwusIF/bD1IlSWyb7UlmXpHdqk
	kl4bx+mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpWgW-00000009vv5-1byU;
	Mon, 09 Feb 2026 19:12:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD397300F1D; Mon, 09 Feb 2026 20:12:34 +0100 (CET)
Date: Mon, 9 Feb 2026 20:12:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Li Zhe <lizhe.67@bytedance.com>, jikos@kernel.org, mbenes@suse.cz,
	pmladek@suse.com, joe.lawrence@redhat.com,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	qirui.001@bytedance.com, vschneid@redhat.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH] klp: use stop machine to check and expedite transition
 for running tasks
Message-ID: <20260209191234.GA1387802@noisy.programming.kicks-ass.net>
References: <20260202091334.60881-1-lizhe.67@bytedance.com>
 <5vctv762jvnxiselc3vwattfsgegw6uv7kltsp27qtoajel2rl@kjrg4ko74gcn>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5vctv762jvnxiselc3vwattfsgegw6uv7kltsp27qtoajel2rl@kjrg4ko74gcn>

On Tue, Feb 03, 2026 at 06:20:22PM -0800, Josh Poimboeuf wrote:
> On Mon, Feb 02, 2026 at 05:13:34PM +0800, Li Zhe wrote:
> > In the current KLP transition implementation, the strategy for running
> > tasks relies on waiting for a context switch to attempt to clear the
> > TIF_PATCH_PENDING flag. Alternatively, determine whether the
> > TIF_PATCH_PENDING flag can be cleared by inspecting the stack once the
> > process has yielded the CPU. However, this approach proves problematic
> > in certain environments.
> > 
> > Consider a scenario where the majority of system CPUs are configured
> > with nohzfull and isolcpus, each dedicated to a VM with a vCPU pinned
> > to that physical core and configured with idle=poll within the guest.
> > Under such conditions, these vCPUs rarely leave the CPU. Combined with
> > the high core counts typical of modern server platforms, this results
> > in transition completion times that are not only excessively prolonged
> > but also highly unpredictable.
> > 
> > This patch resolves this issue by registering a callback with
> > stop_machine. The callback attempts to transition the associated running
> > task. In a VM environment configured with 32 CPUs, the live patching
> > operation completes promptly after the SIGNALS_TIMEOUT period with this
> > patch applied; without it, the process nearly fails to complete under
> > the same scenario.
> > 
> > Co-developed-by: Rui Qi <qirui.001@bytedance.com>
> > Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> 
> PeterZ, what's your take on this?
> 
> I wonder if we could instead do resched_cpu() or something similar to
> trigger the call to klp_sched_try_switch() in __schedule()?

Yeah, this is broken. So the whole point of NOHZ_FULL is to not have the
CPU disturbed, *ever*.

People are working really hard to remove any and all disturbance from
these CPUs with the eventual goal of making any disturbance a fatal
condition (userspace will get a fatal signal if disturbed or so).

Explicitly adding disturbance to NOHZ_FULL is an absolute no-no.

NAK

There are two ways this can be solved:

1) make it a user problem -- userspace wants to load kernel patch,
 userspace can force their QEMU or whatnot through a system call to make
 progress

2) fix it properly and do it like the deferred IPI stuff; recognise
 that as long as the task is in userspace, it doesn't care about kernel
 text changes.

  https://lkml.kernel.org/r/20251114150133.1056710-1-vschneid@redhat.com

While 2 sounds easy, the tricky comes from the fact that you have to
deal with the task coming back to kernel space eventually, possibly in
the middle of your KLP patching. So you've got to do thing like that
patch series above, and make sure the whole of KLP happens while the
other CPU is in USER/GUEST context or waits for things when it tries to
leave while things are in progress.
