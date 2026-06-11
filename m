Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72478F59
	for <live-patching@vger.kernel.org>; Thu, 11 Jun 2026 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193234; cv=none; b=TPi2UNLx5QrOB2azbRHPJSlIfHkf0NcMFKXZMXYAAdupY4uvxlcDNSKpPi2jZema9lyBp2I6p9GgsFihkahf8nnAFfX4Svtq8zdZZZpS2DP0uEbCIvo5klJwxiOJ85sbSgMIQ8u2dbfEVXSfEe8FfxWmu2tOl8OicyJyEGDAHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193234; c=relaxed/simple;
	bh=UrJHc1zn5cYBOLn3pfidw1o3oMR7LpIRvrhqMQ2KYss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Itw+kHQEhUzlfVe2PinlZ5mluLkL391YxAKFkcJ2zzjDb/6rKgKFcYuwUbv1dvxYlHLQ3qnkcFRfUri5QUhcag4ocr+M6PRPXJ4gZJvvPZeIFWKpvzEhvuyZD5aGs/7jltAxi9xsSyEMoADjLo/dLC1KoXs+vABJATL2wUeBVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=T9qhJN6f; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="T9qhJN6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781193220; bh=Nrg0CX+AfSNCklWRxpBZUAyyoBEK3zoOzsw4h82GBHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T9qhJN6fFIYnBsGdpPs95AImsj+H8S2OBh9h2c3KYbcJ7bqAouYoie3muQYZ1q+1+
	 MXxKCVlJk+jrM2ejLquZyfs4fGhWBdBPQL9M6JpkYfbXKPOpR8wiwJCepsW/q81A6p
	 ET/NUwFRTHSYrJalU2yJgIJBBYVDdeSNTLcV7Of0=
Received: from [198.18.0.1] ([115.156.144.140])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D648B8D7; Thu, 11 Jun 2026 23:53:36 +0800
X-QQ-mid: xmsmtpt1781193216t1z857ko9
Message-ID: <tencent_3D17DC5BE32C8A51D938AF50F221321F6206@qq.com>
X-QQ-XMAILINFO: Ni33zkRHTF0SUyz31tuduCr0g1uuxDh1oPuI80M+5VBJzF12nEa6muyJP55grL
	 KjSpTdu11In2x9su/6krDW4pcfXb3YTLQrwJO8gOmQtufkMkRkUU6Ke3+FV2MV4SNZc4owd3pLu/
	 LDsL8mIzg9Jpj/2g5JLoDLYJ1RHChf81fN60rU9lWYgaTukoiTYI+faH/52UAn1ymQ/0lprV6Eoy
	 rrE8Mjxq42lz7oFvLrpyAq4Fbe/Q4c7EfIWEYvE7L7M69DzyGtqU4sHmwh5JK/hnJkrAmO74ga3h
	 vQ+m3Ddnj6PxYdodBkXyHthqkaVXypS+jn59naSyy4V3DB4IRAIMNYGINdtJYCVOGepIzu1NjiDW
	 +3ePUHv8vO0ojiKFMC6xjcJE0PUIJPnc74ATDUE3X9XLw+8NPgI/LFttM44hKQZBKX5lxIhULBn2
	 pGws7xTJP28vv1zafG3BdK5RrvIYMiJKG8l8IcYGfHmn/PJ/7PQ6oDedQuxV7v7jSnp7TWn5Ojpi
	 DUFTt/fHBRDRc09dRE/X3slZI1SswQA2zhXpqa07H6hDyCSXSzlTqBRZ+Tixzvh8cmOkE/uNkme0
	 k0objsyW/55b+EhMjsAQ/pEQJJQx1RgsAf/rSy0DBdVew5RGM1ga7FWKaKa/DnyU7jvvgLFn30Xn
	 Tq6P7grJXnWDAqNkvnnJoeibvQsEK20BgHAgYyLBK9aerejYiNzu68KOkO/+aiyWYILAOrR20OVs
	 WYxZfoHTSJ4WLhJ64CxcW4UHT0Ji1KKoz43atCdExKNHGBfCHD4ptOIhZlTcCMqYN/37umLeZMk3
	 usdK+kJ5Y4L4DZWnKaALMOX+4M6s1+/UN+mXUE3DcIUPCX0WkoweDZ4UVElTuhfSMnr2eBRXPwIm
	 n5iBFgvaGZAZG/KvDApSL2WtQeMVw6YbUp51G+hCm3xghcR+8M+GzfZ+201cTNL3ve8ZlN1ZVE2P
	 srh872CeuB7EjBaINMJhyhb4KOiDuAMANyPLywXvZcPymMWepbd+gJ6vFHmqa3GGRvCMnKBNVaiB
	 ZgdnOo48afxCW/8T/QY9T5NeuKyU3DD7oVNvTVEJUgLB13Mzf+0riNvv0U+f5R7rK0hbVl4gbLKS
	 E2FsfGMIyyCWA4JnI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <c02dbbe3-c2d6-4505-a028-a9e1bf297c00@qq.com>
Date: Thu, 11 Jun 2026 23:53:36 +0800
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rethook: Remove the running task check in
 rethook_find_ret_addr()
To: sashiko-reviews@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
References: <20260610013658.1837963-1-wutengda@huaweicloud.com>
 <20260610015032.4BFAA1F00893@smtp.kernel.org>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260610015032.4BFAA1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tengda,

Sashiko [1] reviewed this patch and found that removing the
task_is_running() check exposes stack unwinders to real crashes — not
just "invalid information."  A PoC confirms this: a KASAN panic triggers
within seconds when /proc/<pid>/stack reads the stack of a task that is
concurrently running a kretprobe.

[1] 
https://sashiko.dev/#/patchset/20260610013658.1837963-1-wutengda%40huaweicloud.com

 > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
 > index 5a8bdf88999a..1e7fdebe3cd5 100644
 > --- a/kernel/trace/rethook.c
 > +++ b/kernel/trace/rethook.c
 > @@ -250,9 +251,6 @@ unsigned long rethook_find_ret_addr(struct 
task_struct *tsk, unsigned long frame
 >      if (WARN_ON_ONCE(!cur))
 >          return 0;
 >
 > -    if (tsk != current && task_is_running(tsk))
 > -        return 0;
 > -
 >      do {
 >          ret = __rethook_find_ret_addr(tsk, cur);
 >          if (!ret)

The commit message states:

 > The iteration is already safe from crashes because
 > unwind_next_frame() holds RCU and rethook_node structures are
 > RCU-freed; even if the iteration goes off the rails and returns
 > invalid information, it will not crash.

There are two problems with this claim, both reproducible.

**Problem 1: stack-out-of-bounds in unwind_next_frame itself**

The PoC below reliably triggers the following KASAN panic — not in the
rethook list traversal, but inside unwind_next_frame():

[ 1833.494623] BUG: KASAN: stack-out-of-bounds in 
unwind_next_frame+0x861/0x2080
[ 1833.494651] Read of size 2 at addr ffffc90003e6f5f0 by task poc/9854
[ 1833.494707] Call Trace:
[ 1833.494719]  dump_stack_lvl+0x116/0x1f0
[ 1833.494743]  print_report+0xf4/0x600
[ 1833.494788]  kasan_report+0xe0/0x110
[ 1833.494836]  unwind_next_frame+0x861/0x2080
[ 1833.494948]  arch_stack_walk+0x99/0x100
[ 1833.495000]  stack_trace_save_tsk+0x16a/0x200
[ 1833.495054]  proc_pid_stack+0x173/0x2b0
[ 1833.495103]  seq_read_iter+0x519/0x12d0
[ 1833.495166]  seq_read+0x3b7/0x590
[ 1833.495297]  vfs_read+0x1f5/0xd20
[ 1833.495497]  ksys_read+0x135/0x250
[ 1833.495549]  do_syscall_64+0x129/0x850
[ 1833.495566]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1833.498894] Kernel panic - not syncing: KASAN: panic_on_warn set ...

page last free pid 9737 tgid 9737 stack trace:
  do_sys_openat2+0xbf/0x260          <-- target task inside kretprobe
  __x64_sys_openat+0x179/0x210

This crash has nothing to do with rethook_node lifetimes or RCU.  It
happens because the ORC unwinder reads stack memory while the target
task concurrently executes a kretprobe trampoline that modifies return
addresses.  The unwinder follows corrupted frame data past valid stack
boundaries.  RCU protection of rethook_node structures is irrelevant —
this crash occurs at the stack frame interpretation level, before any
rethook list traversal.

The old task_is_running() check prevented the unwinder from attempting
to unwind a running task's stack in the first place.

**Problem 2: use-after-free via rethook_node recycling**

Even if the stack-out-of-bounds above were addressed, a second crash
path exists in the rethook list traversal itself.

rethook_recycle() immediately pushes nodes back to the objpool without
an RCU grace period:

   kernel/trace/rethook.c:
   void rethook_recycle(struct rethook_node *node)
   {
           ...
           objpool_push(node, &node->rethook->pool);
   }

Meanwhile, unwind_next_frame() in arch/x86/kernel/unwind_orc.c drops
RCU between frames while the cursor (*cur) persists across iterations:

   arch/x86/kernel/unwind_orc.c:
   bool unwind_next_frame(...)
   {
           ...
           guard(rcu)();    // RCU held for one frame
           ...
   }                        // RCU dropped here

When the unwinder calls __rethook_find_ret_addr() in the next frame
iteration, it does:

   struct llist_node *first = tsk->rethooks.first;
   ...
   *cur = first;
   ...
   node = node->next;       // node may have been recycled

If the target task returns from a probed function between frames, its
rethook_node is recycled and can be instantly reallocated to another
task.  The unwinder's stale cursor then dereferences a freed pointer,
leading to use-after-free.

## Reproducer

The PoC sets up a kretprobe on do_sys_openat2, creates hot-loop threads
calling open(), and concurrently reads /proc/<tid>/stack.  The race
triggers within seconds (Problem 1 above; Problem 2 may reproduce on
kernels without KASAN or with different timing).

Build:  gcc -static -pthread -o poc poc.c
Run:    ./poc [runtime_seconds]
Needs:  root, CONFIG_KASAN=y

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/syscall.h>
#include <sched.h>
#include <fcntl.h>
#include <errno.h>
#include <signal.h>
#include <pthread.h>
#include <dirent.h>

#define TRACE "/sys/kernel/tracing"

volatile int stop = 0;

static int tfs(const char *f, const char *b)
{
     char p[256]; int fd, r;
     snprintf(p, 256, "%s/%s", TRACE, f);
     fd = open(p, O_WRONLY | O_TRUNC);
     if (fd < 0) {
         system("mount -t tracefs tracefs /sys/kernel/tracing 2>/dev/null");
         usleep(50000);
         fd = open(p, O_WRONLY | O_TRUNC);
     }
     if (fd < 0) return -1;
     r = write(fd, b, strlen(b));
     close(fd);
     return r < 0 ? -1 : 0;
}

void *hot_thread(void *arg)
{
     while (!__atomic_load_n(&stop, __ATOMIC_RELAXED)) {
         int fd = open("/dev/null", O_RDONLY);
         if (fd >= 0) close(fd);
     }
     return NULL;
}

void *reader_thread(void *arg)
{
     pid_t target = *(pid_t *)arg;
     char path[64], buf[8192];
     snprintf(path, 64, "/proc/%d/stack", target);
     while (!__atomic_load_n(&stop, __ATOMIC_RELAXED)) {
         int fd = open(path, O_RDONLY);
         if (fd >= 0) { read(fd, buf, 8191); close(fd); }
     }
     return NULL;
}

void sigh(int s) { stop = 1; }

int main(int argc, char *argv[])
{
     int runtime = 120;
     if (argc > 1) runtime = atoi(argv[1]);

     printf("rethook race PoC\n");
     if (geteuid()) { printf("root needed\n"); return 1; }
     signal(SIGINT, sigh);

     pthread_t hot[4], rdr[4];
     pid_t hot_tids[4];
     int pairs = 4;

     for (int c = 0; c < runtime / 5 && !stop; c++) {
         tfs("events/kprobes/myretprobe/enable", "0");
         tfs("kprobe_events", "-:myretprobe");
         usleep(100);
         tfs("kprobe_events", "r:myretprobe do_sys_openat2 $retval");
         tfs("events/kprobes/myretprobe/enable", "1");

         pid_t main_tid = syscall(SYS_gettid);

         for (int i = 0; i < pairs; i++)
             pthread_create(&hot[i], NULL, hot_thread, NULL);

         usleep(300000);

         {
             DIR *d = opendir("/proc/self/task");
             int cnt = 0;
             if (d) {
                 struct dirent *de;
                 while ((de = readdir(d)) != NULL && cnt < pairs) {
                     pid_t t = atoi(de->d_name);
                     if (t > 0 && t != main_tid)
                         hot_tids[cnt++] = t;
                 }
                 closedir(d);
             }
             for (int i = 0; i < cnt; i++)
                 pthread_create(&rdr[i], NULL, reader_thread, &hot_tids[i]);
         }

         printf("round %d\n", c);
         sleep(5);

         stop = 1;
         usleep(100000);

         for (int i = 0; i < pairs; i++) pthread_join(hot[i], NULL);
         for (int i = 0; i < pairs; i++) pthread_join(rdr[i], NULL);

         stop = 0;
         usleep(1000);
     }

     tfs("events/kprobes/myretprobe/enable", "0");
     tfs("kprobe_events", "-:myretprobe");
     printf("Done\n");
     return 0;
}

## Summary

The v4 commit message claims the iteration "will not crash," but the PoC
demonstrates a reproducible KASAN panic:

1. stack-out-of-bounds in unwind_next_frame (ORC unwinder reads
    concurrently-modified stack frames of a running task)

2. Potential use-after-free in __rethook_find_ret_addr (rethook nodes
    recycled without RCU grace period, cursor persists across RCU drops)

The old task_is_running() check was racy but served as a practical
safety net.  Removing it without adding equivalent protection in the
callers (proc_pid_stack, BPF stack walkers) exposes users to kernel
panics via /proc/<pid>/stack on any task running a kretprobe.

Thanks,
Xiao

