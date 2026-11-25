Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615127;
	b=44qR/yHatOzXTdm4706udnUHp3XXQyVjIt7cWw0j7ypRIJJ6skIWUFoeY2kkDrYBtz1v
	 W02IHoz9zl1YGDsHLpTJoMTULLuFI5/68EEXWGMQodkrijWxRoXeOd2vngvfCDxABmfXY
	 RO4CV4odyTh370oOepoE+dgKTjWP0cVoSMGjX/y8vxQYS7iITCocIoNaLyiC7XMaEgTfV
	 XwXtqDq0DYp16QBOVOMOE+OHP7VcfJxE2boHNy5gbvlg/OK/5d/m+UKon+QZQX8hs5YLo
	 R8vvkR3XoVqdcY4GnvD154KesoYyKve8YQMJiHW5FU+YS79jLJFOuo1shpv4CeO1P8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bYQRumrui6g//Hi5w1Qlxc6EOY07FJc2ALHDzwA+doM=;
	b=Eqca1RgNbBIdeDr17XTY6gV4vtcsrYPKBt/61ZcnFRWdLh3mhR+4VqiPJIa8o+Ht4oV2
	 pGXDX+DGXlLteueuY8p78f3wDCqjBna05CY8YVSPwgMMp8dajR8Glg2eAHiYbSF0jgDrR
	 iaxChZ/iE4nWXgIgyZF7ZkOTE25GJAVFs/fhr5C+6xEkszW99h/xUrRjYnjBeLNJZ2XA+
	 aChbb/X7ZRVA4gtbmHNr+6i+NQGv8/Udv3JyW2r2FVQWHEJu0Ny3Bji8MSsrKCO2/wZyZ
	 RFqSeVXWLhzOIn5EeY+NKlsFF44TY0mx3gJ02wk1gN0kLbkrXw+QAJRPzamHRnmWW7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cz6o6Y3g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF0606A321
	for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 13:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFFF0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cz6o6Y3g
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67da3d03263so6000713d50.1
        for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 05:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795615126; cv=none;
        d=google.com; s=arc-20260327;
        b=mwmEJ329nSWm3UOicmedJBX6KFWK1PAWJNyex+50Qq7+ZBGp7F4rSttouzrjZHtGtX
         Sp3BJc1HBOYzpfI6YuwPQlLHfW01yJFzZ9Nl+2Tlvv7+JlGV03tOWVPRazDySgYx31bZ
         f/GMQdOaRGoBe7/7CdOW3yDqTtj8BHNvXqcuCyGFd8yeqAc6+1IY0S8sOkm4Zr6AZGBl
         PXUgskF09oqN5DLYWs+TTNIm1/zN2dEdhiXoINUMaaWBbq9fIB4IpTYLuD4b0b2dg+o6
         hFGfuaIn3ayRRkr1+lEzeEsxq41s86NIumkmCttek2DxIbymVjz+WjBZtwg5Kq8VJoxR
         0GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bYQRumrui6g//Hi5w1Qlxc6EOY07FJc2ALHDzwA+doM=;
        fh=qG78OvXHAGMKdaRX5j4PFw+SlYG80copYaRyIdZeig0=;
        b=kx3xTbQwpPBP5mPIzPOQvQps8YcLDWgg1BKjZeWgO4VWluinyKCoz11KfZeEg9weY0
         JjWF7h2JxbwJJp2wdStJVLSw8nlqnr6tq5THMAUUArGt8PBFDy07W5IaiYDncffuVeMF
         s75NmGwqgPbh+MiX5XuXx55DzaPJRdtjxb1+1yWG+eu1qy8mArXQuIhniZqd8NuLtqjH
         KxWpc/Fj34r+rbJkhc7arxbrp7q/9KpXQwFtpnYhI5BgajhwkDphGtMCHJ2BWV0exAUw
         0AQWGi6xUjz29JatW/t7hA5ERj8lFaJjFLAnmt4TzeyFej19H6SWS1chcK3/V3drK34K
         Autw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795615126; x=1796219926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYQRumrui6g//Hi5w1Qlxc6EOY07FJc2ALHDzwA+doM=;
        b=cz6o6Y3gmtKtAkD+gbIekXyikWhsN+fl1NFIiIeqCPKH6KHGxiBzQlWk0/Y3H2gm5c
         MrCBU1d4wjAWA3ORhaqcy8LxUmfjBQaylj2t0Jol9ym+j7A0jIvGzHZVkPW7Z4wT/RSE
         hFbAsOrJJmVGQF2M4WX5rWegtY4LcBVLXPSA3RiAcG+BJ42aQTwHIU35uX8DKa4iL3FA
         RyNPscndRCjHCz3c+mCm7K9B+v/4f3JJzuPm2Qb8jjc7hmb5IDorWbGtHKXL6ElFc9Za
         O6OL3PBnpIPCAzsese0lIIJzWMQyH3RhhjC3UP0z1wxWTY0Ur2a+S8/dMfO923xAOJGy
         WJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615126; x=1796219926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYQRumrui6g//Hi5w1Qlxc6EOY07FJc2ALHDzwA+doM=;
        b=Ix+RUzsurSaxFbgqKryxguwjiM50Ui8CFZj3QpKebpiG57JIdLMG58hN1APnHKMyFw
         Y/rciflL9ADhcGzHxck6v1ezOScAPdHI5Fxbv+0UCt6C4/Uwy8zLPPApUFM0qkaLOHaR
         /WVQcdvsAZwGQp7SF+FNLTVJ3HkKqKGt3no7QU3ht69zAMN9W4rBFNvt5vRGub465tWz
         B2TTmDsfXWFoZP8hKsncF7SJ6TeP9oxyP9Hfut9StdfV7WclrzNshNalYRjxFBOK6aJ1
         hU1fUcGUWbqbJbOBg3nzpmxXfrG4TYXEmDeoZS2FERl1A/5RKzsPYjL7lvqiMl84lRou
         YoQw==
X-Forwarded-Encrypted: i=1; AL+hErEUw8HWKAb0omzcD3q1Jv4vhJ/JKSKS3YA/CCOYWQCY7XZGTRTK86a7343fct+784XST5bm+do/CBtcXQop@vger.kernel.org
X-Gm-Message-State: APuU4Z86Cq/2dA+joX+f2xmHZxzJp/OHpxECQP92Dwc6zEJryGdgued8
	lcqBfU637hE3uc7IprDd04YVdX65x0vQgNF4mtrPriEnNs1EZd9v0nqqRvgNw63m0dEUX0mPnTJ
	Ty43VwSyiFKYKiQuZDSaB02BP6Sixbn4=
X-Gm-Gg: AZFdTZfZUtj6iZbX8rSkkh8bbIaUJxxRX6CpZGPAVXN9ef4eC7zuTLRYCQq7HZaXJ6E
	yWCWNNvamZtg+rp+1S/9D7Qvl7iLcP0QYb368HzxtwT8gX3ACvEo8m9BphdR73w8WHborr2XETw
	RqYPlD5wYjO4EDZHQRZHsQdP6OG3GJ+DSA5ZnKV2vIjOShKVo6TrqN4D4dnQFtnR4mfcJ4WLPuL
	zYaKLoVnEdvmo9SWTnNIvF+3kiDTVR0dLobxn2CJiQk0sUrD1PoPfbezzauYP33JkCdjwP4QL2X
	+AeXaoGxtVKpwBBerW2GFQIPHTyPYnp/KTfYNho/wkn/qhvxKOvITeyRyVIKjrjVIZAVkaWQhKJ
	QfsiGLrq05+MyofRViO5PhzWcl3B9mH1w+wr7cg5uMM8OQJUyXWicjUaUy2gUxn4Uyyc=
X-Received: by 2002:a05:690e:14c1:b0:67c:2984:5b64 with SMTP id
 956f58d0204a3-67df43f3283mr7315840d50.51.1795615125798; Wed, 25 Nov 2026
 05:58:45 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-klp-series-v3-v2-0-50d20829a337@vt.edu> <20261124-klp-series-v3-v2-2-50d20829a337@vt.edu>
In-Reply-To: <20261124-klp-series-v3-v2-2-50d20829a337@vt.edu>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 25 Nov 2026 21:58:08 +0800
X-Gm-Features: Aa3M54pTYSMPOOwjXbmiWYZ8tWYfg3ERtldtjZhsx7Kxem-z5eI4PUTPknIU77Q
Message-ID: <CALOAHbAtgHUU+eY7LMOscmua23mqEd0EpU8v7Z0wG-E3qh-dvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] livepatch: Include exiting tasks in the transition
To: binoy@vt.edu
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Jaidev Shastri <jaidevshastri@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 11:35=E2=80=AFPM Binoy Ravindran via B4 Relay
<devnull+binoy.vt.edu@kernel.org> wrote:
>
> From: Binoy Ravindran <binoy@vt.edu>
>
> The transition walks tasks with for_each_process_thread(). A
> self-reaping task is unhashed in exit_notify() but keeps running the rest
> of do_exit(), so the walk never sees it. The transition can then
> complete, and with atomic replace the previous patch module can be
> freed, while that task is still executing, or about to return into, the
> previous module's copy of a patched function. This is the race discussed
> in the thread linked below.
>
> An exiting task is on an RCU-tasks exit list from exit_tasks_rcu_start(),
> before exit_notify(), until exit_tasks_rcu_finish(). Make every step of
> a transition also visit the tasks on these lists, using the helpers from
> the previous patch. klp_init_transition(), klp_start_transition(),
> klp_complete_transition(), klp_reverse_transition() and
> klp_force_transition() only set fields and flags. They walk the exit
> lists in place, under tasklist_lock, and skip tasks that are still
> hashed, so that each task is visited exactly once.
> klp_try_complete_transition() may inspect a task's stack, so it takes a
> snapshot with a reference on each task. If the snapshot cannot be
> allocated, or more tasks start exiting than it has room for, the
> transition is treated as incomplete and retried. An exiting task must
> therefore switch, like any other task, before the transition can
> complete.
>
> After exit_tasks_rcu_finish() the task may be on neither list, but it
> can still run patched code until its final switch. do_exit() disables
> preemption before exit_tasks_rcu_finish(), so from then on the task
> cannot sleep, be preempted or migrate, and the next context switch on
> its CPU is its last. klp_synchronize_transition() returns only after
> every online CPU has switched context, so it waits out every task in this
> stretch. Call it in two places:
>
> - In klp_init_transition(), after patch_state has been set on every
>   task and before func->transition is set. An exiting task that the
>   walks did not visit had left the exit lists before or during them,
>   so it is gone before any function enters the transition.
>
> - In klp_try_complete_transition(), before klp_complete_transition().
>   A task that left the exit lists unswitched after the snapshot is gone
>   before func->transition is cleared and before the previous patch can
>   be freed.
>
> Covering the initialization and completion steps matters as well:
> otherwise an exiting task keeps a stale patch_state from an earlier
> transition, which can equal the new target. Likewise, the reverse path
> clears TIF_PATCH_PENDING on exiting tasks and the force path updates
> their patch state, so neither leaves an exiting task behind.
> klp_send_signals() is not extended: a task that has passed exit_notify()
> never returns to user space, so a fake signal cannot help it switch.
>
> The exit lists exist only with CONFIG_TASKS_RCU, which every kernel
> that can enable LIVEPATCH builds today. A following patch makes
> LIVEPATCH select it.
>
> Tested on v7.4-rc2, x86-64, under QEMU/KVM. Two klp-build livepatches
> that each replace do_exit() replace each other ten times per run while
> self-reaping tasks exit continuously, with a debug-only msleep() after
> exit_notify() to widen the window. Without this series, 9 of 12 runs
> crashed executing freed module memory after the previous patch was
> removed. With it, all 12 runs completed their 120 replace cycles
> without a fault. Without the delay, both kernels completed 60 cycles
> without a fault.
>
> Fixes: d83a7cb375ee ("livepatch: change to a per-task consistency model")
> Link: https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail=
.com/
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Binoy Ravindran <binoy@vt.edu>
> ---
>  kernel/livepatch/transition.c | 98 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.=
c
> index 2351a19ac2a9..1889aea5b6ff 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -10,6 +10,7 @@
>  #include <linux/cpu.h>
>  #include <linux/stacktrace.h>
>  #include <linux/static_call.h>
> +#include <linux/slab.h>
>  #include "core.h"
>  #include "patch.h"
>  #include "transition.h"
> @@ -74,6 +75,84 @@ static void klp_synchronize_transition(void)
>         schedule_on_each_cpu(klp_sync);
>  }
>
> +static bool klp_try_switch_task(struct task_struct *task);
> +
> +/*
> + * Tasks past exit_notify() are off the task list but still run do_exit(=
) and its
> + * callees, possibly from this patch's or a replaced patch's code, so th=
e
> + * transition must cover them too. The try step inspects stacks, which n=
eeds a
> + * reference on each task, so it works on a snapshot of the exit lists.
> + *
> + * The other steps run with tasklist_lock held and skip tasks that are s=
till
> + * hashed, so every task is visited exactly once: an exiting task can be=
 on
> + * both lists until release_task() unhashes it.
> + */
> +static bool klp_visit_exiting_tasks(rcu_tasks_exiting_fn_t fn, void *arg=
)
> +{
> +       struct task_struct **xt;
> +       int i, n, max;
> +
> +       /*
> +        * Size the array from a count taken now, plus slack for tasks th=
at
> +        * start exiting before the copy is made. If even more arrive, re=
port
> +        * an incomplete walk: klp_try_complete_transition() runs again l=
ater.
> +        */
> +       max =3D rcu_tasks_snapshot_exiting(NULL, 0) + 64;
> +       xt =3D kvmalloc_array(max, sizeof(*xt), GFP_KERNEL);
> +       if (!xt)
> +               return false;
> +       n =3D rcu_tasks_snapshot_exiting(xt, max);
> +       for (i =3D 0; i < min(n, max); i++) {
> +               fn(xt[i], arg);
> +               put_task_struct(xt[i]);
> +       }
> +       kvfree(xt);
> +       return n <=3D max;
> +}
> +
> +static void klp_exiting_init(struct task_struct *t, void *arg)
> +{
> +       if (pid_alive(t))
> +               return; /* still on the task list: already visited */
> +       t->patch_state =3D *(int *)arg;
> +}
> +
> +static void klp_exiting_start(struct task_struct *t, void *arg)
> +{
> +       if (pid_alive(t))
> +               return; /* still on the task list: already visited */
> +       if (t->patch_state !=3D klp_target_state)
> +               set_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +}
> +
> +static void klp_exiting_try(struct task_struct *t, void *arg)
> +{
> +       if (!klp_try_switch_task(t))
> +               *(bool *)arg =3D false;
> +}
> +
> +static void klp_exiting_complete(struct task_struct *t, void *arg)
> +{
> +       if (pid_alive(t))
> +               return; /* still on the task list: already visited */
> +       clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +       t->patch_state =3D KLP_TRANSITION_IDLE;
> +}
> +
> +static void klp_exiting_clear_pending(struct task_struct *t, void *arg)
> +{
> +       if (pid_alive(t))
> +               return; /* still on the task list: already visited */
> +       clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +}
> +
> +static void klp_exiting_force(struct task_struct *t, void *arg)
> +{
> +       if (pid_alive(t))
> +               return; /* still on the task list: already visited */
> +       klp_update_patch_state(t);
> +}
> +
>  /*
>   * The transition to the target patch state is complete.  Clean up the d=
ata
>   * structures.
> @@ -123,6 +202,7 @@ static void klp_complete_transition(void)
>                 WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING=
));
>                 task->patch_state =3D KLP_TRANSITION_IDLE;
>         }
> +       rcu_tasks_visit_exiting(klp_exiting_complete, NULL);
>         read_unlock(&tasklist_lock);
>
>         for_each_possible_cpu(cpu) {
> @@ -450,6 +530,8 @@ void klp_try_complete_transition(void)
>                 if (!klp_try_switch_task(task))
>                         complete =3D false;
>         read_unlock(&tasklist_lock);
> +       if (!klp_visit_exiting_tasks(klp_exiting_try, &complete))
> +               complete =3D false;

klp_exiting_try() is the only function ever passed as @fn, so does the
callback indirection buy us anything?  We could drop @fn and @arg and
let klp_visit_exiting_tasks() return the result directly, which would
also get rid of the "*(bool *)arg =3D false".

>
>         /*
>          * Ditto for the idle "swapper" tasks.
> @@ -489,6 +571,11 @@ void klp_try_complete_transition(void)
>         /* Done!  Now cleanup the data structures. */
>         klp_resched_disable();
>         patch =3D klp_transition_patch;
> +       /*
> +        * A task can leave the exit lists unswitched after the snapshot.=
 Wait until
> +        * every such task has made its final switch before completing.
> +        */
> +       klp_synchronize_transition();

Can we use synchronize_rcu() instead in the two places this series
adds, the same way rcu_tasks_postgp() does?  Those two only wait for
the do_exit() tail, which runs with preemption disabled in normal
kernel context, so I don't think the "RCU is not watching" argument
behind klp_synchronize_transition() applies to them.

/* Finish off the Tasks-RCU grace period. */
static void rcu_tasks_postgp(struct rcu_tasks *rtp)
{
         /*
         ...
         * In addition, this synchronize_rcu() waits for exiting tasks
         * to complete their final preempt_disable() region of execution,
         * enforcing the whole region before tasklist removal until
         * the final schedule() with TASK_DEAD state to be an RCU TASKS
         * read side critical section.
         */
        synchronize_rcu();
}

>         klp_complete_transition();
>
>         /*
> @@ -526,6 +613,7 @@ void klp_start_transition(void)
>         for_each_process_thread(g, task)
>                 if (task->patch_state !=3D klp_target_state)
>                         set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +       rcu_tasks_visit_exiting(klp_exiting_start, NULL);
>         read_unlock(&tasklist_lock);
>
>         /*
> @@ -579,6 +667,7 @@ void klp_init_transition(struct klp_patch *patch, int=
 state)
>                 WARN_ON_ONCE(task->patch_state !=3D KLP_TRANSITION_IDLE);
>                 task->patch_state =3D initial_state;
>         }
> +       rcu_tasks_visit_exiting(klp_exiting_init, &initial_state);
>         read_unlock(&tasklist_lock);
>
>         /*
> @@ -590,6 +679,13 @@ void klp_init_transition(struct klp_patch *patch, in=
t state)
>                 task->patch_state =3D initial_state;
>         }
>
> +       /*
> +        * A task that has passed exit_tasks_rcu_finish() is on neither l=
ist but
> +        * may still call patched code until its final switch. It runs wi=
th
> +        * preemption disabled, so this returns only after every such tas=
k is gone.
> +        */
> +       klp_synchronize_transition();

synchronize_rcu();

> +
>         /*
>          * Enforce the order of the task->patch_state initializations and=
 the
>          * func->transition updates to ensure that klp_ftrace_handler() d=
oesn't
> @@ -642,6 +738,7 @@ void klp_reverse_transition(void)
>         read_lock(&tasklist_lock);
>         for_each_process_thread(g, task)
>                 clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +       rcu_tasks_visit_exiting(klp_exiting_clear_pending, NULL);
>         read_unlock(&tasklist_lock);
>
>         for_each_possible_cpu(cpu)
> @@ -714,6 +811,7 @@ void klp_force_transition(void)
>         read_lock(&tasklist_lock);
>         for_each_process_thread(g, task)
>                 klp_update_patch_state(task);
> +       rcu_tasks_visit_exiting(klp_exiting_force, NULL);
>         read_unlock(&tasklist_lock);
>
>         for_each_possible_cpu(cpu)
>
> --
> 2.39.5
>
>


--=20
Regards
Yafang
