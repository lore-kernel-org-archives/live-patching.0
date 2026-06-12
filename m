Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17E2C21D8;
	Fri, 12 Jun 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229310; cv=none; b=Px0isC5a+uF/RdK4foxlGYGkDWSQQZyXmV0SaBr9LrEBCglAIeL/Xjy3Y2rS3tebF9p+i2a/k8FyUYxIxDS7sQ90pg4XZUzR95ZIMiST6ZMg+oZAwbVR71CYBIRxvu8QoNtCA9W2fhdLvpg0+vA/q4sqbROiH5iLo0QdBnBJRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229310; c=relaxed/simple;
	bh=9xA22wVJimg+XD28C2L+cY+sHz1FGSAX+RAwoc/grds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQGVwRzC7R7bAldNqmDbnRSjBe71t11JOoKzLbGgVGA0T7lVQOCbKZntgYzUSK33iSGuGbq/0YgfYorAQvUBFou3vYZJsvyOfjLfxcLQcG6j9Budhvj8X4KMtaucn6jqgAmpdNRgtNKJG6xC5+fYgIxsOpM2USE76eg4YpEn35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gc2d62KtjzYQtpF;
	Fri, 12 Jun 2026 09:54:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 85A5040573;
	Fri, 12 Jun 2026 09:54:55 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgAHy4DtZitqxOPwBQ--.20143S2;
	Fri, 12 Jun 2026 09:54:54 +0800 (CST)
Message-ID: <6df6e707-0d79-4bc9-95c0-7f2c4896a229@huaweicloud.com>
Date: Fri, 12 Jun 2026 09:54:52 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rethook: Remove the running task check in
 rethook_find_ret_addr()
To: XIAO WU <xiaowu.417@qq.com>, sashiko-reviews@lists.linux.dev,
 Masami Hiramatsu <mhiramat@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
References: <20260610013658.1837963-1-wutengda@huaweicloud.com>
 <20260610015032.4BFAA1F00893@smtp.kernel.org>
 <tencent_3D17DC5BE32C8A51D938AF50F221321F6206@qq.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <tencent_3D17DC5BE32C8A51D938AF50F221321F6206@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHy4DtZitqxOPwBQ--.20143S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1UWw48ArWxGr45CrWfZrb_yoWDJrWrpF
	Z7trZ0yF95Aryvyr1DJr1UZFyrJrsYqw4UGr1kGFyUAa1UAr1jqrWSqr4Y9F45Cr4kGr15
	GF4jqr9rursrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Xiao,

Thank you very much for your detailed analysis and verification.

On 2026/6/11 23:53, XIAO WU wrote:
> Hi Tengda,
> 
> Sashiko [1] reviewed this patch and found that removing the
> task_is_running() check exposes stack unwinders to real crashes — not
> just "invalid information."  A PoC confirms this: a KASAN panic triggers
> within seconds when /proc/<pid>/stack reads the stack of a task that is
> concurrently running a kretprobe.
> 
> [1] https://sashiko.dev/#/patchset/20260610013658.1837963-1-wutengda%40huaweicloud.com
> 
>> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
>> index 5a8bdf88999a..1e7fdebe3cd5 100644
>> --- a/kernel/trace/rethook.c
>> +++ b/kernel/trace/rethook.c
>> @@ -250,9 +251,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>>      if (WARN_ON_ONCE(!cur))
>>          return 0;
>>
>> -    if (tsk != current && task_is_running(tsk))
>> -        return 0;
>> -
>>      do {
>>          ret = __rethook_find_ret_addr(tsk, cur);
>>          if (!ret)
> 
> The commit message states:
> 
>> The iteration is already safe from crashes because
>> unwind_next_frame() holds RCU and rethook_node structures are
>> RCU-freed; even if the iteration goes off the rails and returns
>> invalid information, it will not crash.
> 
> There are two problems with this claim, both reproducible.
> 
> **Problem 1: stack-out-of-bounds in unwind_next_frame itself**
> 
> The PoC below reliably triggers the following KASAN panic — not in the
> rethook list traversal, but inside unwind_next_frame():
> 
> [ 1833.494623] BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x861/0x2080
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
>  do_sys_openat2+0xbf/0x260          <-- target task inside kretprobe
>  __x64_sys_openat+0x179/0x210
> 
> This crash has nothing to do with rethook_node lifetimes or RCU.  It
> happens because the ORC unwinder reads stack memory while the target
> task concurrently executes a kretprobe trampoline that modifies return
> addresses.  The unwinder follows corrupted frame data past valid stack
> boundaries.  RCU protection of rethook_node structures is irrelevant —
> this crash occurs at the stack frame interpretation level, before any
> rethook list traversal.
> 
> The old task_is_running() check prevented the unwinder from attempting
> to unwind a running task's stack in the first place.
> 

Yes, I was able to reproduce the issue locally using your PoC. The problem
does exist as you described. I need to take a deeper look and figure out how
to properly fix it.

> **Problem 2: use-after-free via rethook_node recycling**
> 
> Even if the stack-out-of-bounds above were addressed, a second crash
> path exists in the rethook list traversal itself.
> 
> rethook_recycle() immediately pushes nodes back to the objpool without
> an RCU grace period:
> 
>   kernel/trace/rethook.c:
>   void rethook_recycle(struct rethook_node *node)
>   {
>           ...
>           objpool_push(node, &node->rethook->pool);
>   }
> 
> Meanwhile, unwind_next_frame() in arch/x86/kernel/unwind_orc.c drops
> RCU between frames while the cursor (*cur) persists across iterations:
> 
>   arch/x86/kernel/unwind_orc.c:
>   bool unwind_next_frame(...)
>   {
>           ...
>           guard(rcu)();    // RCU held for one frame
>           ...
>   }                        // RCU dropped here
> 
> When the unwinder calls __rethook_find_ret_addr() in the next frame
> iteration, it does:
> 
>   struct llist_node *first = tsk->rethooks.first;
>   ...
>   *cur = first;
>   ...
>   node = node->next;       // node may have been recycled
> 
> If the target task returns from a probed function between frames, its
> rethook_node is recycled and can be instantly reallocated to another
> task.  The unwinder's stale cursor then dereferences a freed pointer,
> leading to use-after-free.
> 

Yes, Sashiko also pointed this out. You have opened this issue for further
analysis to clarify its fault model. It appears to be a pre-existing issue
that may require a separate patch to resolve.

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
>     char p[256]; int fd, r;
>     snprintf(p, 256, "%s/%s", TRACE, f);
>     fd = open(p, O_WRONLY | O_TRUNC);
>     if (fd < 0) {
>         system("mount -t tracefs tracefs /sys/kernel/tracing 2>/dev/null");
>         usleep(50000);
>         fd = open(p, O_WRONLY | O_TRUNC);
>     }
>     if (fd < 0) return -1;
>     r = write(fd, b, strlen(b));
>     close(fd);
>     return r < 0 ? -1 : 0;
> }
> 
> void *hot_thread(void *arg)
> {
>     while (!__atomic_load_n(&stop, __ATOMIC_RELAXED)) {
>         int fd = open("/dev/null", O_RDONLY);
>         if (fd >= 0) close(fd);
>     }
>     return NULL;
> }
> 
> void *reader_thread(void *arg)
> {
>     pid_t target = *(pid_t *)arg;
>     char path[64], buf[8192];
>     snprintf(path, 64, "/proc/%d/stack", target);
>     while (!__atomic_load_n(&stop, __ATOMIC_RELAXED)) {
>         int fd = open(path, O_RDONLY);
>         if (fd >= 0) { read(fd, buf, 8191); close(fd); }
>     }
>     return NULL;
> }
> 
> void sigh(int s) { stop = 1; }
> 
> int main(int argc, char *argv[])
> {
>     int runtime = 120;
>     if (argc > 1) runtime = atoi(argv[1]);
> 
>     printf("rethook race PoC\n");
>     if (geteuid()) { printf("root needed\n"); return 1; }
>     signal(SIGINT, sigh);
> 
>     pthread_t hot[4], rdr[4];
>     pid_t hot_tids[4];
>     int pairs = 4;
> 
>     for (int c = 0; c < runtime / 5 && !stop; c++) {
>         tfs("events/kprobes/myretprobe/enable", "0");
>         tfs("kprobe_events", "-:myretprobe");
>         usleep(100);
>         tfs("kprobe_events", "r:myretprobe do_sys_openat2 $retval");
>         tfs("events/kprobes/myretprobe/enable", "1");
> 
>         pid_t main_tid = syscall(SYS_gettid);
> 
>         for (int i = 0; i < pairs; i++)
>             pthread_create(&hot[i], NULL, hot_thread, NULL);
> 
>         usleep(300000);
> 
>         {
>             DIR *d = opendir("/proc/self/task");
>             int cnt = 0;
>             if (d) {
>                 struct dirent *de;
>                 while ((de = readdir(d)) != NULL && cnt < pairs) {
>                     pid_t t = atoi(de->d_name);
>                     if (t > 0 && t != main_tid)
>                         hot_tids[cnt++] = t;
>                 }
>                 closedir(d);
>             }
>             for (int i = 0; i < cnt; i++)
>                 pthread_create(&rdr[i], NULL, reader_thread, &hot_tids[i]);
>         }
> 
>         printf("round %d\n", c);
>         sleep(5);
> 
>         stop = 1;
>         usleep(100000);
> 
>         for (int i = 0; i < pairs; i++) pthread_join(hot[i], NULL);
>         for (int i = 0; i < pairs; i++) pthread_join(rdr[i], NULL);
> 
>         stop = 0;
>         usleep(1000);
>     }
> 
>     tfs("events/kprobes/myretprobe/enable", "0");
>     tfs("kprobe_events", "-:myretprobe");
>     printf("Done\n");
>     return 0;
> }
> 
> ## Summary
> 
> The v4 commit message claims the iteration "will not crash," but the PoC
> demonstrates a reproducible KASAN panic:
> 
> 1. stack-out-of-bounds in unwind_next_frame (ORC unwinder reads
>    concurrently-modified stack frames of a running task)
> 
> 2. Potential use-after-free in __rethook_find_ret_addr (rethook nodes
>    recycled without RCU grace period, cursor persists across RCU drops)
> 
> The old task_is_running() check was racy but served as a practical
> safety net.  Removing it without adding equivalent protection in the
> callers (proc_pid_stack, BPF stack walkers) exposes users to kernel
> panics via /proc/<pid>/stack on any task running a kretprobe.

Once again, I truly appreciate your thorough review and testing.
I'm not sure if I can fully resolve these issues, but if I succeed, I will
send out a v5.

Best regards,
Tengda

