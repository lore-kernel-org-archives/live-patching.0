Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795467168;
	b=PHe3QFBPx2SQPjD2IiMhi+Wrj9KnRYFUCLQEXcQ4AlGi6/ir7fIEPFTKndaya/3ulDwK
	 g85LL0myZ8QHYD2uHUlWjGQ54pBVASRzOfI3tdCIzgcLIprBTFN/tTLQp4N7y+1Y74TAA
	 Arv0QnJOKq544JgQAIWvBP10NQ+ZnvzKIwsHKCqpjzke9my7y+x+BwVsqHZrKCZxsEtu4
	 VaHsw8XhpTbJADMQbfKWd6C3Q5NMDDsuAN4pEMXTOkRh0/XYKl2Z15VFgLXigbJcevCKv
	 z/c2rOQqf/lFT8XjBcBni7fhZMnsJ/qa2TfoLsAPNNOf523Vujl4Udb3a1B/WfGjs2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467168;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hDse418qH+tooiumypGhP2Bu3G/x+miTovUExhzmUmI=;
	b=32h6tFQLFgL7eW23gHsNOVfhHMqKEDihr2Dc0KUXV0o3+GqeZD0iKsEXEQw3oGPg40TT
	 EvQGuu01au86gYBr/ihA3Vah6h/oJTliv45U4mXFy9pKcshW0n37grzGGmwQ6KWRedvfA
	 o9tFCAbi+qkZLe2fRqWo1ADA4Pj4//42h7hdTh13GMZJte5aT8G6qe+TRmbi1C3ap7+WV
	 HMDWYSRfzst9/dVukZv1S6txb4fv9bq5Kq6eILv04H/ZTffq8pc7vsAZ2FARx/RignYWl
	 LFDomCbnszUkMmgUgA7SxxJyw9LZgShSesAZm395SqnH6l0wm2AAWLPg0yNnObXp7jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJEc+Xso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D1606A31E;
	Mon, 23 Nov 2026 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJEc+Xso
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795467168;
	b=mmZnK9wllTvwNPuEd8OD5UX+W9tio/jDUleZvonZbNqULc2CSOoEqIreqKQI3cKEZ6P/
	 9mULjt4hATfmVCZQLLpfkAAncQ/MI+zfZj8ZiLR+DyAVxZdKzeGQPCZuYmAWGnB88Si23
	 pJ2q6NRfRfDxeHyP22deWkKELYks5B4ZqPbhRGyQzyMNAUqh321ye8uKJ8qPJ5Gw/91pf
	 OHe3afn5nHanXLA3VwGB1mqSAtPgSttz4PQx8eb9r6qQwY1dCnSSwYlCvgEALYE4WaSMC
	 186YJihAc0fOniiMhs9Cow4k0wvbhYG2jMbBy1Pljt6n5kgoH3okJPe3oVSWSFYIUhw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467168;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hDse418qH+tooiumypGhP2Bu3G/x+miTovUExhzmUmI=;
	b=MHn8Q7NLCRiVRCceJslWuUa8BVYJkYX/W3QZ0BHZ3i3ICaTGiOw8b1n2YvkKMxh25vSc
	 5ui04H7/75FmUdon/nEGMY9G2TYgc2+h234mlFX2kTL3FtJmTRf5fLORvd8nXEJ+bGuTc
	 ekQcXHKc6LLMIp6da/mAISCZT6HBdK9y16+MegA1vv8RiciECSJ33XxLAEM1+/Ysi+piT
	 UxhY1EMou3tdmZUjqbvLDkTgnvwJ0cpOVAvYbxD5sVCBv+m6RyEd5mMBQrNzs0TSLAOs5
	 H2cXeUDo0JD8jiik9Q6hsusnJ3kihxlVBa6jUBn8m72bUYmYEx0YWeyxjS0Tf++ty7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D787F1F000C0;
	Mon, 23 Nov 2026 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467168;
	bh=hDse418qH+tooiumypGhP2Bu3G/x+miTovUExhzmUmI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BJEc+Xsoc1r/FaLMyfDTEvi0OirckPup1HyEYdSNsL3k2ZJ/OdWnh4JgMbtYiM/lb
	 tk1/ChQ+bRbl8SV02JteTI/RA7SEg2OHkpbQ8jKaqkcrM53cwtbHd0okdpfcnUWf3Z
	 Kqbo72RSNybAbaXT/6x4dGa1rgAAlMph1KlMXbBhlIkjkf1IUQkQANaCQCFXBHY6mg
	 b8KST+Poqw6FU7Z2Tn0tQSxNK5471VDHQDAcG3E0Ov304sv9sgwG681FmMgH9Tdnt8
	 XRdkJsSUQkJ841cCbl0lPUuQGugr45ptTZIQzWZHzgHjcVm++YDTAyxYwnM8Tif5HI
	 iYZzqNQQyMzMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6C3FD4C732;
	Mon, 23 Nov 2026 20:52:43 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Subject: [PATCH 0/2] livepatch: Do not lose exiting tasks during a
 transition
Date: Mon, 23 Nov 2026 15:52:14 -0500
Message-Id: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6nBGsC/yXMQQ5AMBBA0avIrE3SVhCuIhbUlEFKWkQi7q5Yv
 sX/F3hyTB7K6AJHB3tebICMI9BDY3tC7oJBCZVJqRKc5hX/Bo8Eu1TlRaZFWggDoVkdGT6/X1X
 /9ns7kt7eCdz3AyO0XZhxAAAA
X-Change-ID: 20261123-klp-series-v3-d52796c0590f
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
 Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>, 
 Jaidev Shastri <jaidevshastri@vt.edu>, Binoy Ravindran <binoy@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795467163; l=2301;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=8jw45Z4MONwXpwW16fWs+bguoDA4AMUrsssB1NGSAis=;
 b=KwX1UeAQbQ2O0SqnnT4zaR8qX7zMX5woDh7B1B/Zs6y+x/yTVWOb5SHeWmsDlEquYZcvv+U1a
 AEJtznQ9PwBDyw4N/k3DQBV02yzIU27PJYtO8lumV7kE5bxG6CU15w/
X-Developer-Key: i=binoy@vt.edu; a=ed25519;
 pk=4cNdKPHP0InmhK/9bb7Tm2ZMUXUvLGfw1pmVt5b98fA=
X-Endpoint-Received: by B4 Relay for binoy@vt.edu/20261123 with
 auth_id=1622
X-Original-From: Binoy Ravindran <binoy@vt.edu>
Reply-To: binoy@vt.edu

After exit_notify(), a self-reaping task is unhashed from the task list
but keeps running the rest of do_exit(). The livepatch transition walks
the task list, so it can complete while such a task still runs code from
a patch module that atomic replace is about to free. Yafang Shao and
Petr Mladek discussed this race in [1]. It is hard to hit, but it is
reachable by any livepatch that replaces a function on the exit path,
for example a fix to do_exit() itself.

Every exiting task is already on an RCU-tasks exit list from
exit_tasks_rcu_start(), before exit_notify(), until
exit_tasks_rcu_finish(). After that, do_exit() runs with preemption
disabled until the final switch, so the task cannot sleep or be
preempted. Patch 1 adds helpers to visit the tasks on these lists.
Patch 2 makes every transition step, including reverse and force,
visit them too. The exit path itself is unchanged. Kernels without
CONFIG_TASKS_RCU have no exit lists and are not covered.

We reproduced the crash with two atomic-replace livepatches of the
CVE-2025-38424 fix, which replaces do_exit(). With a debug-only sleep
after exit_notify(), 11 of 12 runs crash without the series and none
with it. With it, there were also no crashes in 1,200 cycles of a /proc
stress test or in 400 cycles with preempt=full. The measurements were
taken on v6.12.1. This series is the forward port to v7.4-rc2. On
mainline it has been build-tested only: it builds without new warnings
with livepatch on, with livepatch on and preemption off, and with
TASKS_RCU off. It has not yet been run on mainline. A reproducer and the
logs are available on request.

[1] https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/

---
Binoy Ravindran (2):
      rcu-tasks: Add helpers to visit tasks on the exit lists
      livepatch: Include exiting tasks in the transition

 include/linux/rcupdate.h      |  9 ++++++
 kernel/livepatch/transition.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h            | 67 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 142 insertions(+), 6 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261123-klp-series-v3-d52796c0590f

Best regards,
--  
Binoy Ravindran <binoy@vt.edu>


