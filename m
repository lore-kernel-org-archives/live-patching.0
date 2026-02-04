Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E57082D
	for <live-patching@vger.kernel.org>; Wed,  4 Feb 2026 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173304; cv=none; b=mDBSQMdsqERyeKlZ+JOvqGY5J7Ub0egskesQqS33lIHVXsmXzEX8lORMr86q78a6dTF/n/ws8EMbWDbo1yUzCLDvzujDZA4X7s8fljvkI/WPoctTNBmxuKN4+An2Tu7S8ArL9vXB3lgVaq2ShH3ctvcR9snpbuyyO6RVkuxRVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173304; c=relaxed/simple;
	bh=iHnvPLsts2o4nBIN/uBcI2oCapfk4eWrNZ2iN2lmGSo=;
	h=Subject:Mime-Version:Message-Id:References:Date:Content-Type:
	 In-Reply-To:To:Cc:From; b=BQ/vseXtm6L1hbXYUt8tUXD4TyNs1tWPryYR8+1ps7lpr0r3/iTglTBHEDEELLcmCXO+odlwOQ1RGSrDZTzLTBR/yn4tjUusu9RVgsG6WTdvk5zWJwFadYGwbB3cYflLGcEPHxEmIszgZLS5Bs4R6lJ2DG8wLhgcySM942Hf2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aCZ0nyR7; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aCZ0nyR7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1770173292; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SYb0tjqPc2nxaenpHdl5x/BM6Xt8do5Ii9RUw1EV+0s=;
 b=aCZ0nyR7wJkPHGgPNFloNhDMIPcOv+EvGZnRO27NEIqu7VUYC0LALaNTzLZljSIR63lZWt
 EXmot3wk69wM10YLI0nGo1CYCCpwR12uBhez0W7Lo/AaTZDKCjj/sPHU7FNKe8Sf0+/4bS
 XGtmAlutE2gi+RuNROuF96rkMfXZCdMasLZD06Dkr5MDOPSbkEWH1iSdgtYKtWRTy/Nn3u
 s9pdsQb0Zzk/snH2/u2vayZbZCrmncZOxDxHZpMry887EaGtyutufHDgQ0rRx+rANy9j5M
 6mNrNDdqmmXHZAi7JJBNlRGm6XzzmxEhv+ZJVyasyjZSMeZNZ9n+K7gb4wRHrQ==
Subject: Re: [PATCH] klp: use stop machine to check and expedite transition for running tasks
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260204024756.6776-1-lizhe.67@bytedance.com>
References: <5vctv762jvnxiselc3vwattfsgegw6uv7kltsp27qtoajel2rl@kjrg4ko74gcn>
X-Mailer: git-send-email 2.45.2
Date: Wed,  4 Feb 2026 10:47:56 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26982b36a+ce73f2+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <5vctv762jvnxiselc3vwattfsgegw6uv7kltsp27qtoajel2rl@kjrg4ko74gcn>
To: <jpoimboe@kernel.org>
Cc: <jikos@kernel.org>, <joe.lawrence@redhat.com>, 
	<linux-kernel@vger.kernel.org>, <live-patching@vger.kernel.org>, 
	<lizhe.67@bytedance.com>, <mbenes@suse.cz>, <peterz@infradead.org>, 
	<pmladek@suse.com>, <qirui.001@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>

On Tue, 3 Feb 2026 18:20:22 -0800, jpoimboe@kernel.org wrote:
 
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

klp_sched_try_switch() only invokes __klp_sched_try_switch() after
verifying that the corresponding task has the TASK_FREEZABLE flag
set. I remain uncertain whether this approach adequately resolves
the issue.

Thanks,
Zhe
