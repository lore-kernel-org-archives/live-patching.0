Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512C34104E;
	Wed, 10 Jun 2026 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056238; cv=none; b=prBG4DPCM6+5x+o9gRnbHAGSbq0vVVk7OKrVmCIuPtqQxYki4lbXzAFRZ+gz2Ne1TmrYNHWiHsEP7GyEWSIS432K2hTDoWDVvB5EIBwdZddYHNv8VPxBJet1l9zRN6d7lzzjCc3WOaRZoermHORMbHa/Ug6inzEHk2l0rQGzaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056238; c=relaxed/simple;
	bh=b33+8C8hYqiZMqsjPjrDGMAFFkeIz/tBwMU4lzafHo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqD1+YfwO14LVz4P4xqTcuJa+HpeJfjIlTymPgwGn2lffA+77WUK7+GuzCBgYhvjKZCXZ57cNPoII2B7TDTTQP/n4bG1pHNrm6f29FWiUCtriIzbBB5qROLWE5KCJ4POvUvjlBH2jA/rJsc4JD8VeEEk1J/lIqcEHtkVcb3yV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvcnC51W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvcnC51W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFAA1F00893;
	Wed, 10 Jun 2026 01:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056232;
	bh=uQRZpUaWAAh52NFpBhfqMgmHhKKGlFKdcGllajNVugk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvcnC51WcrwDTe06NtbnRJWdbh2dPzIwWwCxaGEMVSRyzaPQf08EOAPQIF6sHprVz
	 qx++gjSauKXPUgvRaQMmglwk5rujpzqePhQgBmcb0SKHhO6gREO0DeBfEJ5Jys7qah
	 VOfwxB7KTCLbZQgM7LYikGpoHworMZH9NRONX71wzltlbhIF19orRaeZag4av5I54P
	 MpdxqLBQZScQl9xUc6W7hMxBvft8yO8eM1YbsgBrsVhTK4M09+O0O8n9sC8kbWHq11
	 LbQne4Efk67mGufgSxodriglaaxLq9jXmvUQDwt9dgiEauyxy83zySocVJgO4VwnMp
	 qejjNG+UucXQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] rethook: Remove the running task check in
 rethook_find_ret_addr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Masami Hiramatsu" <mhiramat@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Peter
 Zijlstra" <peterz@infradead.org>
Cc: "Tengda Wu" <wutengda@huaweicloud.com>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260610013658.1837963-1-wutengda@huaweicloud.com>
References: <20260610013658.1837963-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:50:31 +0000
Message-Id: <20260610015032.4BFAA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Removing `task_is_running()` from `rethook_find_ret_addr()` expose=
s stack unwinders to use-after-free, wild pointer dereferences, and list co=
rruption when unwinding running tasks, because `rethook_node` recycling and=
 unwinding lack adequate RCU synchronization.
--

commit 83e1fac9c64377191cc2b41ef9da781c46f1e95a
Author: Tengda Wu <wutengda@huaweicloud.com>

rethook: Remove the running task check in rethook_find_ret_addr()

This commit removes the task_is_running() check from rethook_find_ret_addr(=
).
The commit message states the check is unnecessary because unwinders hold R=
CU
and rethook_node structures are RCU-freed. Callers are expected to provide
their own safe context.

> The iteration is already safe from crashes because
> unwind_next_frame() holds RCU and rethook_node structures are RCU-freed;
> even if the iteration goes off the rails and returns invalid information,
> it will not crash. Callers that require consistency must provide a safe
> context themselves.

[ ... ]

> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 5a8bdf88999a9..1e7fdebe3cd5d 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
[ ... ]
> @@ -250,9 +251,6 @@ unsigned long rethook_find_ret_addr(struct task_struc=
t *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
> =20
> -	if (tsk !=3D current && task_is_running(tsk))
> -		return 0;
> -
>  	do {
>  		ret =3D __rethook_find_ret_addr(tsk, cur);

[Severity: High]
This is a pre-existing issue, but does removing this check entirely expose
the stack unwinders to a use-after-free and list corruption?

The commit message mentions that rethook_node structures are RCU-freed, but
looking at rethook_recycle(), the nodes appear to be immediately pushed back
to the lockless objpool without an RCU grace period:

kernel/trace/rethook.c:rethook_recycle() {
    ...
    objpool_push(node, &node->rethook->pool);
}

Additionally, while unwind_next_frame() does hold RCU for a single frame
iteration, stack unwinders like x86 ORC drop the read lock between frames:

arch/x86/kernel/unwind_orc.c:unwind_next_frame() {
    ...
    guard(rcu)();
    ...
}

Because the unwinder retains the list cursor (*cur) across frame iterations
while RCU is dropped, could unwinding a running task allow the target task
to recycle the node?

If the node is recycled and instantly reallocated to another task, the next
call to __rethook_find_ret_addr() would execute:

kernel/trace/rethook.c:__rethook_find_ret_addr() {
    ...
    node =3D node->next;

on a stale pointer. Could removing this check turn a theoretical race into
an easily triggered use-after-free when reading /proc/<pid>/stack for tasks
executing kretprobes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610013658.1837=
963-1-wutengda@huaweicloud.com?part=3D1
