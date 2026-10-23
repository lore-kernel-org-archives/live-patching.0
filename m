Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717857;
	b=0GZShyzBlwLOlHBkWahGWxuKCORvUbtyun0ySs5MvOJo6ZvBDvH6GRXsjgUM2eX4PTwO
	 Atkv26tGjN/bCbTiKXmvEScC0pVjMHgEmVIlZC6xASJ78iEilhmsCKBu+g+qh5JtQsoPo
	 c4aARzUP+ZODSunnyamD9cOj8JIP4W4V3jlg2wIFEhxcCcx2EmED6+OIDq1P8Wg0oc2d6
	 rpa1ov8dmf8rZdt8R9g52Ik9GRBvkotqmDJ3YFAgyidAfc0iAOaAjSsJO7RfzE7p4omaQ
	 bqn1joFISjj4rUCi7xS5UN4aCveby8eEzRQxlh+QOPtdhWaUVFBAvmv74ac31rVs48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9KeoOiqmTZGtbiXX1Hkpwmoz/WoX+jVuLLnxsZlOErE=;
	b=QNLcGXnuzII6bybnRLpBr5XDK3NqnHuENTF3ko56azVhos6JLFQ/sBdxZI0HWNUyvsAJ
	 G21esRvbh8bbU7qx47ZravbuqOiRJNkb1S8zp9kE1sgsyFmq/kBPEe2ToSsZeKjSw3Uxo
	 pfPoXwnPTsodUD1YAeRN61H6QShdmp8SMFCKYw2eKEtoIAXBO0Ru4ykAJocTl7zOVpVHH
	 3IoWICrlaz2TVlvYv9Qs6WPlCtsAPYRabMRJFu7V4vl9MAIDnSGmLBkVB9q70oSKz+pkO
	 7d2BHbPiP7kzHi5LWpaH7aeYKz2UqMmAYSD6mszVwrNDt9HkBD6xHzTa/+X+SVwALEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoEmLuuI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C30606A31F;
	Fri, 23 Oct 2026 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoEmLuuI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5FA1F01825;
	Fri, 23 Oct 2026 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717856;
	bh=9KeoOiqmTZGtbiXX1Hkpwmoz/WoX+jVuLLnxsZlOErE=;
	h=From:To:Cc:Subject:Date;
	b=DoEmLuuIC26qPeMq5vOSLROyAZ37mmeGTSXs5j8zyz8vQ3sYNKPm2xd7hlFxI73VH
	 llYdCG6wtPiY07fQjtxMgoRyh3ljcaRyuwjjbML4tG3UHJjcNMYh6pcNQMD2q+DhZV
	 TKXZXI5dqLSs6Xxwi6MAcv/9KRrwCgxLvOwsXZLaQR0pRK8UZs0nh8JJv7ztUO0k6Z
	 A4dKv1g3SWjxA+WgSWXGcJFrSopR989c0FcJiukWUYOEvwR8J1Z4mtqrh0mxJrUhW1
	 Py8WdKHrmmTTwFnG/4Rz3xiTJCeWJ12aG2q4e2d8JHIsPlCdOVVP6Q78NkjFbszfNO
	 OiKhdNUq/0ifQ==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 00/16] Move notrace from inline to __always_inline
Date: Thu, 22 Oct 2026 18:10:33 -0700
Message-ID: <20261023011049.1164625-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 45959ee7aa64 ("ftrace: Do not function trace inlined
functions"), every function marked inline is also notrace. When the
compiler does not inline such a function, the out-of-line copy cannot
be traced with ftrace, cannot be a BPF fentry/fexit target, and cannot
be livepatched. This series moves notrace from inline to
__always_inline, so these copies become traceable. __always_inline
functions, which are mostly low-level helpers, stay untraced.

v1 [1] removed notrace from inline in one patch. Sashiko's review
showed that some code relies on inline implying notrace, and Steven
suggested keeping notrace on __always_inline and annotating the rest.
Patches 1-15 add notrace explicitly to the inline helpers that need it.
While inline still implies notrace, they do not change the generated
code: on x86_64 with gcc 11.5, vmlinux .text is byte-identical with and
without them.

 - 1-2: x86 paravirt native helpers, and the helpers used by resume and
   kexec.
 - 3-6: helpers used by bpf_spin_lock, the BPF trampoline and
   bpf_mem_alloc, where an fentry program on one of them could
   deadlock, recurse without bound or corrupt the free lists.
 - 7-8: tracepoint and SRCU helpers used by tracing.
 - 9-12: helpers used by ftrace recursion protection: the accessors
   behind preempt_count() and current on arm64, powerpc, csky, mips and
   sh, the Tiny RCU rcu_is_watching(), and the tracing_gen_ctx helpers.
 - 13-15: helpers called by notrace code in the trace clocks,
   core_kernel_text() and the nofault accessors.

To find these, I compared x86_64 builds with and without patch 16, and
listed the functions that become traceable and are called from code
without an fentry call (notrace, noinstr, or built without -pg),
including calls through pv_ops. To also cover helpers that gcc happens
to inline today, I repeated this with -fno-inline. The changes for
other architectures and Tiny RCU come from reading the code that ftrace
recursion protection uses.

On an x86_64 config with CONFIG_PARAVIRT_XXL and gcc 11.5, the series
makes 678 more functions traceable, and none become untraceable. In
QEMU, with ftrace filtered to native_load_idt(), a kernel with v1 dies
on resume from S3, as Sashiko predicted. With this series, S3
suspend/resume, CPU hotplug and hibernation test mode pass with ftrace
on all native_* functions, and repeated kexec passes with ftrace on all
functions. The series also builds for i386, and for arm64 and powerpc
with clang.

Changes v1 => v2:
 - Keep notrace on __always_inline. (Steven Rostedt)
 - Add patches 1-15 to mark notrace the helpers that relied on inline
   implying notrace.
 - Rework the commit message of the last patch.

v1: https://lore.kernel.org/all/20261021222255.3124940-1-song@kernel.org/

Song Liu (16):
  x86/paravirt: Mark native pv_ops helpers notrace
  x86: Mark CPU state helpers used by resume and kexec notrace
  bpf: Mark bpf_spin_lock helpers notrace
  bpf: Mark the BPF trampoline helpers notrace
  bpf: Mark the bpf_mem_alloc fast path helpers notrace
  u64_stats: Mark the update helpers used by BPF notrace
  tracepoint: Mark __do_trace_##name() notrace
  srcu: Mark the fast notrace read-side helpers notrace
  arm64: Mark the preempt count helpers notrace
  powerpc, csky, mips, sh: Mark the accessors behind current notrace
  rcu: Mark the Tiny RCU rcu_is_watching() notrace
  tracing: Mark the tracing_gen_ctx helpers notrace
  ktime: Mark ktime_to_ns() notrace
  kallsyms: Mark the kernel text address checks notrace
  uaccess: Mark pagefault_disable() and pagefault_enable() notrace
  compiler_types: Move notrace from inline to __always_inline

 arch/arm64/include/asm/preempt.h         | 12 +++++-----
 arch/csky/include/asm/thread_info.h      |  2 +-
 arch/mips/include/asm/thread_info.h      |  2 +-
 arch/powerpc/include/asm/current.h       |  2 +-
 arch/sh/include/asm/thread_info.h        |  2 +-
 arch/x86/include/asm/cpuid/api.h         |  4 ++--
 arch/x86/include/asm/desc.h              | 17 +++++++-------
 arch/x86/include/asm/gsseg.h             |  4 ++--
 arch/x86/include/asm/io.h                |  2 +-
 arch/x86/include/asm/io_bitmap.h         |  2 +-
 arch/x86/include/asm/local.h             |  8 +++----
 arch/x86/include/asm/msr.h               |  8 +++----
 arch/x86/include/asm/paravirt-spinlock.h |  2 +-
 arch/x86/include/asm/paravirt.h          | 20 ++++++++--------
 arch/x86/include/asm/pgalloc.h           |  2 +-
 arch/x86/include/asm/pgtable_64.h        | 10 ++++----
 arch/x86/include/asm/processor.h         |  2 +-
 arch/x86/include/asm/segment.h           |  4 ++--
 arch/x86/include/asm/special_insns.h     |  8 +++----
 include/asm-generic/sections.h           |  4 ++--
 include/linux/bpf.h                      |  8 +++----
 include/linux/compiler_attributes.h      |  6 ++++-
 include/linux/compiler_types.h           |  3 +--
 include/linux/kallsyms.h                 |  2 +-
 include/linux/ktime.h                    |  2 +-
 include/linux/llist.h                    | 16 ++++++-------
 include/linux/percpu-refcount.h          | 12 +++++-----
 include/linux/pgtable.h                  | 12 +++++-----
 include/linux/rcupdate.h                 | 14 +++++------
 include/linux/rcupdate_trace.h           |  4 ++--
 include/linux/rcutiny.h                  |  2 +-
 include/linux/sched.h                    |  8 +++----
 include/linux/srcu.h                     | 10 ++++----
 include/linux/srcutiny.h                 |  5 ++--
 include/linux/srcutree.h                 |  2 +-
 include/linux/trace_events.h             |  6 ++---
 include/linux/tracepoint.h               |  4 ++--
 include/linux/u64_stats_sync.h           | 30 ++++++++++++------------
 include/linux/uaccess.h                  |  4 ++--
 kernel/bpf/helpers.c                     | 12 +++++-----
 40 files changed, 143 insertions(+), 136 deletions(-)

--
2.53.0-Meta
