Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E43A4F58;
	Wed, 10 Jun 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080157; cv=none; b=O+Jm9mW0FvaA+cnvBY04Ucqyxl0kVxjw0fz/43vyLhbEJqSxoUU1urirFpGLNF+V7nWF1rXqnOJngwe+3nwcJIb6wq3sJPc91c6iy+Tk9q9VADtjEmC/N8VTxuZ793f34SlHBwsXAXM7UEIEa9BX71AFqKNaXzMgrC+IfId3BF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080157; c=relaxed/simple;
	bh=ToxkZY2A3N7s4IptGVgkaK1BmOYf7/Nd6ckYL0Uu/X4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lK9uGerc+Gn+UIJWrVeDccuuCtKTrar7wS5zvoaBXMy+qT3C5IytfkvkrPK2w2pjliv03Luls8kQ2/yYZURFCPW1/IAiIGHfoNS7WXox52+bKmeclyEwNYaZsu6kxesHuumSplD97QMuEuyWiQzuAfNhZ1ZzXe4H9R5rzEKsB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id7QXBUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id7QXBUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09F51F00893;
	Wed, 10 Jun 2026 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781080156;
	bh=IOsU3oX4q3ZwCNWXMbxQIeoL1EPjX+bUPxPRnD5EXQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Id7QXBUFh3rfPz2T9CJjaSeZ8BTD/oGvvDWPmb+pFHlQRpzIDSaEJ/obvbEi3orSg
	 SL1dz62sgUo98hQX23sMGUc2f5rkNy/xxsXV4VcdQ+UQJ/s1QyATdOknyZMVbqrt5N
	 kApjxlOzwQohUx0ugxcI9NKB0cwpxPwJNrK1IJ2q37zT8mw/Y9nrVHbjmz1SJZn8Pr
	 afIBCp1zNBFTH7HtgKPKJWyvdLJ1xDnlxkaNA/Mc75P3Y1WxO2/RbUM9Zt6BVja4IM
	 Bb0oXHIdXC9KWoYxBTIAcruonpXP/GFGZeTsQ3PnMb2lEVjOBMcmpB0YvASuwHVY1U
	 CbrkrObylbjaA==
Date: Wed, 10 Jun 2026 17:29:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Petr Mladek <pmladek@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] rethook: Remove the running task check in
 rethook_find_ret_addr()
Message-Id: <20260610172913.d6806ca2575197a425db9514@kernel.org>
In-Reply-To: <e016536c-df99-4de8-a8fb-6ac50932fd2f@huaweicloud.com>
References: <20260609084953.901576-1-wutengda@huaweicloud.com>
	<aifgPaLc_p2vZr5n@pathway.suse.cz>
	<e016536c-df99-4de8-a8fb-6ac50932fd2f@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 19:12:41 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> 
> 
> On 2026/6/9 17:43, Petr Mladek wrote:
> > Added live-patching mailing list.
> > 
> > On Tue 2026-06-09 16:49:53, Tengda Wu wrote:
> >> The current check in rethook_find_ret_addr() prevents obtaining a return
> >> address when the target task is marked as running. However, this condition
> >> is both insufficient for correctness and unnecessary for its intended
> >> purpose.
> >>
> >> The check is inherently racy: a task can begin running on another CPU
> >> immediately after task_is_running() returns false, potentially leading to
> >> concurrent modification of rethook data structures while the iteration is
> >> in progress.
> >>
> >> Rather than trying to fix this unreliable check deep in the unwinding
> >> path, simply remove it. The iteration is already safe from crashes because
> >> unwind_next_frame() holds RCU and rethook_node structures are RCU-freed;
> >> even if the iteration goes off the rails and returns invalid information,
> >> it will not crash. Callers that require consistency must provide a safe
> >> context themselves.
> >>
> >> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >> v3: Improve commit message: clarify safety semantics and document that RCU guarantees no crash.
> >> v2: https://lore.kernel.org/all/20260609005728.458962-1-wutengda@huaweicloud.com/
> >> v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/
> >>
> >> --- a/kernel/trace/rethook.c
> >> +++ b/kernel/trace/rethook.c
> >> @@ -250,9 +250,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
> >>  	if (WARN_ON_ONCE(!cur))
> >>  		return 0;
> >>  
> >> -	if (tsk != current && task_is_running(tsk))
> >> -		return 0;
> >> -
> > 
> > The description of the function should be updated as well. It still
> > mentions:
> > 
> >  * The @tsk must be 'current' or a task which is not running.
> > 
> > Instead it should explain that it safe to call the function even
> > on another running tasks but the returned address is not reliable
> > then.
> > 
> 
> Oh, I forgot that. Thanks for pointing it out.

Yeah, but it should be updated to explain what you need to do.
For example call it should hold RCU, or use for current.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
