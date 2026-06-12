Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA0384CF7;
	Fri, 12 Jun 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266819; cv=none; b=oCDf17OTEKCVWSy4mbNCwgv73dNeda1na+EbRKqv1CAgMndvcp6+SP2GSUxoZRn63iPPQWEWB3xGnTTz88IldrzMdHnWg4ykXfpnlODdAMUpRCwzPFvj0tmgt5fTlI92Vi3wzeeBawMsOkEY5DrG4wXFwFYOxQIUrH5F0nUQ4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266819; c=relaxed/simple;
	bh=Ralya6ZghOGBaQNOQcoxOdoPaROIGOw64SjdTXUl6iI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RlGM653Y3rjTOnISyJfhVAvJuL17ftg3RBoKfplMQQfbVk7CIuygPNswsb/hN1q/u5WUgGzbE7LVBpB5eLF17noj4qey6NoIuR0jEt3M+2HuSJMVgxvpXQgf7KnYjpetGduc6nNkmgH30TDw5zJ9BuWDdIc8FHR+Wp57zEQ+e3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuNrEegg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuNrEegg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F8F1F000E9;
	Fri, 12 Jun 2026 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781266816;
	bh=kUCBpwSNXyGDiawWxxm02Igm2sniJToSNoDs2v9eGn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QuNrEegg+4Z6XvM91l3Z/kFVZ4dCjGWCTLVSSWYAwYJrTNWbBANi8sz91j3p3Ir3j
	 tTkegCshvaPuj+YCb41aRv1FrlWljOli/VWRc8F+aMD+Bunq5BJp5UZ9GXrMlWOmXo
	 KTsDtAwVd3sgY7fgcb/O9qywxgkXSchPCcl73ClJZEsp0rWNDzLzFbnYH9F397+jMm
	 J99MqO8RW8w3OVVy68XozKc22Nenjnszxbmt+UJtYoLcIyzQos203bk40mCvRj/YfN
	 QJ324AgqyDnOFEdH1wbm3JyrbnXA+5ZX49JqicMowZMkJjc7+8HmVrijuG5WyJJbEs
	 0H0kwtOhsOhlA==
Date: Fri, 12 Jun 2026 21:20:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: XIAO WU <xiaowu.417@qq.com>
Cc: sashiko-reviews@lists.linux.dev, Petr Mladek <pmladek@suse.com>, Peter
 Zijlstra <peterz@infradead.org>, Tengda Wu <wutengda@huaweicloud.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v4] rethook: Remove the running task check in
 rethook_find_ret_addr()
Message-Id: <20260612212012.b1e0eaa4b3ba1e58afe11fa2@kernel.org>
In-Reply-To: <tencent_3D17DC5BE32C8A51D938AF50F221321F6206@qq.com>
References: <20260610013658.1837963-1-wutengda@huaweicloud.com>
	<20260610015032.4BFAA1F00893@smtp.kernel.org>
	<tencent_3D17DC5BE32C8A51D938AF50F221321F6206@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Jun 2026 23:53:36 +0800
XIAO WU <xiaowu.417@qq.com> wrote:

> Hi Tengda,
> 
> Sashiko [1] reviewed this patch and found that removing the
> task_is_running() check exposes stack unwinders to real crashes — not
> just "invalid information."  A PoC confirms this: a KASAN panic triggers
> within seconds when /proc/<pid>/stack reads the stack of a task that is
> concurrently running a kretprobe.

Hmm, why /proc/<pid>/stack unwind stack so unreliable way...
That should stop the target process, because it is exposed to
userspace. Thus it should work as safe as possible.

Anyway, thanks for reporting with the test program.

> 
> [1] 
> https://sashiko.dev/#/patchset/20260610013658.1837963-1-wutengda%40huaweicloud.com
> 
>  > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
>  > index 5a8bdf88999a..1e7fdebe3cd5 100644
>  > --- a/kernel/trace/rethook.c
>  > +++ b/kernel/trace/rethook.c
>  > @@ -250,9 +251,6 @@ unsigned long rethook_find_ret_addr(struct 
> task_struct *tsk, unsigned long frame
>  >      if (WARN_ON_ONCE(!cur))
>  >          return 0;
>  >
>  > -    if (tsk != current && task_is_running(tsk))
>  > -        return 0;
>  > -
>  >      do {
>  >          ret = __rethook_find_ret_addr(tsk, cur);
>  >          if (!ret)
> 
> The commit message states:
> 
>  > The iteration is already safe from crashes because
>  > unwind_next_frame() holds RCU and rethook_node structures are
>  > RCU-freed; even if the iteration goes off the rails and returns
>  > invalid information, it will not crash.
> 
> There are two problems with this claim, both reproducible.
> 
> **Problem 1: stack-out-of-bounds in unwind_next_frame itself**
> 
> The PoC below reliably triggers the following KASAN panic — not in the
> rethook list traversal, but inside unwind_next_frame():
> 
> [ 1833.494623] BUG: KASAN: stack-out-of-bounds in 
> unwind_next_frame+0x861/0x2080
> [ 1833.494651] Read of size 2 at addr ffffc90003e6f5f0 by task poc/9854
> [ 1833.494707] Call Trace:
> [ 1833.494719]  dump_stack_lvl+0x116/0x1f0
> [ 1833.494743]  print_report+0xf4/0x600
> [ 1833.494788]  kasan_report+0xe0/0x110
> [ 1833.494836]  unwind_next_frame+0x861/0x2080
> [ 1833.494948]  arch_stack_walk+0x99/0x100
> [ 1833.495000]  stack_trace_save_tsk+0x16a/0x200
> [ 1833.495054]  proc_pid_stack+0x173/0x2b0
> [ 1833.495103]  seq_read_iter+0x519/0x12d0
> [ 1833.495166]  seq_read+0x3b7/0x590
> [ 1833.495297]  vfs_read+0x1f5/0xd20
> [ 1833.495497]  ksys_read+0x135/0x250
> [ 1833.495549]  do_syscall_64+0x129/0x850
> [ 1833.495566]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 1833.498894] Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> page last free pid 9737 tgid 9737 stack trace:
>   do_sys_openat2+0xbf/0x260          <-- target task inside kretprobe
>   __x64_sys_openat+0x179/0x210
> 
> This crash has nothing to do with rethook_node lifetimes or RCU.  It
> happens because the ORC unwinder reads stack memory while the target
> task concurrently executes a kretprobe trampoline that modifies return
> addresses.  The unwinder follows corrupted frame data past valid stack
> boundaries.  RCU protection of rethook_node structures is irrelevant —
> this crash occurs at the stack frame interpretation level, before any
> rethook list traversal.

OK, in that case, I think we should not allow list traversal.
I think without freezing the target task, accessing /proc/<pid>/stack
is potentially dangerous. Shouldn't we fix this at first?

> 
> The old task_is_running() check prevented the unwinder from attempting
> to unwind a running task's stack in the first place.
> 
> **Problem 2: use-after-free via rethook_node recycling**
> 
> Even if the stack-out-of-bounds above were addressed, a second crash
> path exists in the rethook list traversal itself.
> 
> rethook_recycle() immediately pushes nodes back to the objpool without
> an RCU grace period:
> 
>    kernel/trace/rethook.c:
>    void rethook_recycle(struct rethook_node *node)
>    {
>            ...
>            objpool_push(node, &node->rethook->pool);
>    }
> 
> Meanwhile, unwind_next_frame() in arch/x86/kernel/unwind_orc.c drops
> RCU between frames while the cursor (*cur) persists across iterations:
> 
>    arch/x86/kernel/unwind_orc.c:
>    bool unwind_next_frame(...)
>    {
>            ...
>            guard(rcu)();    // RCU held for one frame
>            ...
>    }                        // RCU dropped here
> 
> When the unwinder calls __rethook_find_ret_addr() in the next frame
> iteration, it does:
> 
>    struct llist_node *first = tsk->rethooks.first;
>    ...
>    *cur = first;
>    ...
>    node = node->next;       // node may have been recycled
> 
> If the target task returns from a probed function between frames, its
> rethook_node is recycled and can be instantly reallocated to another
> task.  The unwinder's stale cursor then dereferences a freed pointer,
> leading to use-after-free.


OK, this is still real problem. We should use call_rcu() to return
the object back to objpool.

Thanks!

> 
> ## Reproducer
> 
> The PoC sets up a kretprobe on do_sys_openat2, creates hot-loop threads
> calling open(), and concurrently reads /proc/<tid>/stack.  The race
> triggers within seconds (Problem 1 above; Problem 2 may reproduce on
> kernels without KASAN or with different timing).
> 
> Build:  gcc -static -pthread -o poc poc.c
> Run:    ./poc [runtime_seconds]
> Needs:  root, CONFIG_KASAN=y
> 
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/wait.h>
> #include <sys/syscall.h>
> #include <sched.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <signal.h>
> #include <pthread.h>
> #include <dirent.h>
> 
> #define TRACE "/sys/kernel/tracing"
> 
> volatile int stop = 0;
> 
> static int tfs(const char *f, const char *b)
> {
>      char p[256]; int fd, r;
>      snprintf(p, 256, "%s/%s", TRACE, f);
>      fd = open(p, O_WRONLY | O_TRUNC);
>      if (fd < 0) {
>          system("mount -t tracefs tracefs /sys/kernel/tracing 2>/dev/null");
>          usleep(50000);
>          fd = open(p, O_WRONLY | O_TRUNC);
>      }
>      if (fd < 0) return -1;
>      r = write(fd, b, strlen(b));
>      close(fd);
>      return r < 0 ? -1 : 0;
> }
> 
> void *hot_thread(void *arg)
> {
>      while (!__atomic_load_n(&stop, __ATOMIC_RELAXED)) {
>          int fd = open("/dev/null", O_RDONLY);
>          if (fd >= 0) close(fd);
>      }
>      return NULL;
> }
> 
> void *reader_thread(void *arg)
> {
>      pid_t target = *(pid_t *)arg;
>      char path[64], buf[8192];
>      snprintf(path, 64, "/proc/%d/stack", target);
>      while (!__atomic_load_n(&stop, __ATOMIC_RELAXED)) {
>          int fd = open(path, O_RDONLY);
>          if (fd >= 0) { read(fd, buf, 8191); close(fd); }
>      }
>      return NULL;
> }
> 
> void sigh(int s) { stop = 1; }
> 
> int main(int argc, char *argv[])
> {
>      int runtime = 120;
>      if (argc > 1) runtime = atoi(argv[1]);
> 
>      printf("rethook race PoC\n");
>      if (geteuid()) { printf("root needed\n"); return 1; }
>      signal(SIGINT, sigh);
> 
>      pthread_t hot[4], rdr[4];
>      pid_t hot_tids[4];
>      int pairs = 4;
> 
>      for (int c = 0; c < runtime / 5 && !stop; c++) {
>          tfs("events/kprobes/myretprobe/enable", "0");
>          tfs("kprobe_events", "-:myretprobe");
>          usleep(100);
>          tfs("kprobe_events", "r:myretprobe do_sys_openat2 $retval");
>          tfs("events/kprobes/myretprobe/enable", "1");
> 
>          pid_t main_tid = syscall(SYS_gettid);
> 
>          for (int i = 0; i < pairs; i++)
>              pthread_create(&hot[i], NULL, hot_thread, NULL);
> 
>          usleep(300000);
> 
>          {
>              DIR *d = opendir("/proc/self/task");
>              int cnt = 0;
>              if (d) {
>                  struct dirent *de;
>                  while ((de = readdir(d)) != NULL && cnt < pairs) {
>                      pid_t t = atoi(de->d_name);
>                      if (t > 0 && t != main_tid)
>                          hot_tids[cnt++] = t;
>                  }
>                  closedir(d);
>              }
>              for (int i = 0; i < cnt; i++)
>                  pthread_create(&rdr[i], NULL, reader_thread, &hot_tids[i]);
>          }
> 
>          printf("round %d\n", c);
>          sleep(5);
> 
>          stop = 1;
>          usleep(100000);
> 
>          for (int i = 0; i < pairs; i++) pthread_join(hot[i], NULL);
>          for (int i = 0; i < pairs; i++) pthread_join(rdr[i], NULL);
> 
>          stop = 0;
>          usleep(1000);
>      }
> 
>      tfs("events/kprobes/myretprobe/enable", "0");
>      tfs("kprobe_events", "-:myretprobe");
>      printf("Done\n");
>      return 0;
> }
> 
> ## Summary
> 
> The v4 commit message claims the iteration "will not crash," but the PoC
> demonstrates a reproducible KASAN panic:
> 
> 1. stack-out-of-bounds in unwind_next_frame (ORC unwinder reads
>     concurrently-modified stack frames of a running task)
> 
> 2. Potential use-after-free in __rethook_find_ret_addr (rethook nodes
>     recycled without RCU grace period, cursor persists across RCU drops)
> 
> The old task_is_running() check was racy but served as a practical
> safety net.  Removing it without adding equivalent protection in the
> callers (proc_pid_stack, BPF stack walkers) exposes users to kernel
> panics via /proc/<pid>/stack on any task running a kretprobe.
> 
> Thanks,
> Xiao
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
