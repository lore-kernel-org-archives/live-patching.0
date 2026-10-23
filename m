Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717878;
	b=M0kdQ/ss6k0S5eDDDc+GxNvDMgN/XkxUOwkhRsDDEaw7WFuHRN80URr8xZyjCbWlSQSS
	 VSAHjlNnFsBvpfnB3jghsn+5MhemzLSU5fnbczOb6ZL6I5P3r9V2GtQwi2PuLXhBjO1J7
	 16TprKSFlgI9mdw3bd0PX6vjyQr/Tq52MNUuJwCXEhsAdqSyegy3YS4yzQWDDiIqn/YqZ
	 yOb3jWdSmk95vcppjwdeDuwinHWILK79nFxC4ytWUySdCJ8Fg/l2QDDG79KML42WO+pN9
	 /phAZXaDjxC2eu3fpWG9RfBHuW3OMf2n2k7Uhi9bYKaNkfRHahYzbKlAlFDbM/nVzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=81uugRe1+07nnJoKUb+wqLDTdJuicVlpgUINlJk6qbY=;
	b=RhFNPZIR7bVWk/lIRz76vVBGWUKWAnB7uaqr63ALWMHR9JGaj0jHhyrM+4vpbldDRLno
	 BSEPYJNgBYgKt+RWb5Nhy1nwOkHCQ/PusoSY0vteAUA4PykQ0wQclVrQPeFIYKYJbw3QX
	 X0b4W4qKGgHmvUXWqQKXOeavAN76Q52HotUi+CPpEt5gzvbGDVlxCBVk5qlr72mGG2mKp
	 XOYPuFESi5DJFeqE67KxmAIp7Myn1zkJb0v3gsdyJCQV66DKG8tNC69cecZEF4DmJCnsS
	 Id+zxznawiaBUsLzcLnTtuFsTzKYGoSfpFtLpRROA/cus5q0WEIdvEaSFsOY/Kj1S0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuLMJEO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFC606A31E;
	Fri, 23 Oct 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuLMJEO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D731F031E0;
	Fri, 23 Oct 2026 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717877;
	bh=81uugRe1+07nnJoKUb+wqLDTdJuicVlpgUINlJk6qbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VuLMJEO0egQ/oJIba5Bsb8+iUXlolSz98BEVTH7rS7VYi5FSZ9juxXb1C7CB8OzH8
	 vYWWE6UPP9gUuZiCLyKMQb4QOd0u3gUsIrRAcAfsZp1pd2xDfMjVY5IoRkv6Bc14Tk
	 pAdJJSFjPm9eWXwQZyu2gYzYAeku30+LcVAyhoAz0nyc/Q4wXE47uXOXkH6k7Qxk1i
	 t9ww4ksHYRFcNn+qQscuQKuGyOtkG5Q1yxfcW6ZYQaxY1+zx2H48419IIB+fNZrYvC
	 pxI3DebQi0U+eloOLhQROsfkVxY7GehGtMHkEEp1WTJ9S3NjWWTc7t9A9LP4dGJJpM
	 Uka5QqOmYL2rQ==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 04/16] bpf: Mark the BPF trampoline helpers notrace
Date: Thu, 22 Oct 2026 18:10:37 -0700
Message-ID: <20261023011049.1164625-5-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023011049.1164625-1-song@kernel.org>
References: <20261023011049.1164625-1-song@kernel.org>
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

The BPF trampoline calls __bpf_prog_enter*() before each program and
__bpf_prog_exit*() after it, and calls __bpf_tramp_enter() and
__bpf_tramp_exit() around the traced function. These functions are
notrace: if anything they call could run a BPF program, attaching a
program there would recurse without bound. The recursion check in
__bpf_prog_enter_recur() does not prevent this, because the trampoline
calls the enter and exit functions even for a program it then skips.
For the same reason, btf_id_deny already rejects attaching to the
out-of-line migrate_disable() and migrate_enable(), and, with
CONFIG_PREEMPT_RCU, to __rcu_read_lock() and __rcu_read_unlock().

Many of the helpers they call are plain inline functions:

 - bpf_set_run_ctx(), bpf_reset_run_ctx(),
   bpf_prog_get_recursion_context() and
   bpf_prog_put_recursion_context();
 - __migrate_disable() and __migrate_enable();
 - the !CONFIG_PREEMPT_RCU __rcu_read_lock() and __rcu_read_unlock(),
   rcu_read_unlock() and rcu_read_unlock_migrate(), and the lockdep
   annotations rcu_lock_acquire(), rcu_try_lock_acquire() and
   rcu_lock_release();
 - rcu_read_lock_trace(), rcu_read_unlock_trace() and
   srcu_lock_release();
 - percpu_ref_get(), percpu_ref_put(), percpu_ref_get_many(),
   percpu_ref_put_many() and __ref_is_percpu();
 - local_inc() and local_add() on x86, called through u64_stats_inc()
   and u64_stats_add() from bpf_prog_inc_misses_counter() and
   __update_prog_stats().

An out-of-line copy of any of them is untraced only because inline
implies notrace. Mark them notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/local.h    |  4 ++--
 include/linux/bpf.h             |  8 ++++----
 include/linux/percpu-refcount.h | 12 ++++++------
 include/linux/rcupdate.h        | 14 +++++++-------
 include/linux/rcupdate_trace.h  |  4 ++--
 include/linux/sched.h           |  8 ++++----
 include/linux/srcu.h            |  2 +-
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 4957018fef3e..1749c4481000 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -16,7 +16,7 @@ typedef struct {
 #define local_read(l)	atomic_long_read(&(l)->a)
 #define local_set(l, i)	atomic_long_set(&(l)->a, (i))
 
-static inline void local_inc(local_t *l)
+static inline void notrace local_inc(local_t *l)
 {
 	asm volatile(_ASM_INC "%0"
 		     : "+m" (l->a.counter));
@@ -28,7 +28,7 @@ static inline void local_dec(local_t *l)
 		     : "+m" (l->a.counter));
 }
 
-static inline void local_add(long i, local_t *l)
+static inline void notrace local_add(long i, local_t *l)
 {
 	asm volatile(_ASM_ADD "%1,%0"
 		     : "+m" (l->a.counter)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..22bf8e285117 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2156,7 +2156,7 @@ struct bpf_struct_ops_common_value {
 	enum bpf_struct_ops_state state;
 };
 
-static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
+static inline bool notrace bpf_prog_get_recursion_context(struct bpf_prog *prog)
 {
 #ifdef CONFIG_ARM64
 	u8 rctx = interrupt_context_level();
@@ -2176,7 +2176,7 @@ static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
 #endif
 }
 
-static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
+static inline void notrace bpf_prog_put_recursion_context(struct bpf_prog *prog)
 {
 #ifdef CONFIG_ARM64
 	u8 rctx = interrupt_context_level();
@@ -2547,7 +2547,7 @@ struct bpf_tramp_run_ctx {
 	struct bpf_run_ctx *saved_run_ctx;
 };
 
-static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
+static inline notrace struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
 {
 	struct bpf_run_ctx *old_ctx = NULL;
 
@@ -2558,7 +2558,7 @@ static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
 	return old_ctx;
 }
 
-static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
+static inline void notrace bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 {
 #ifdef CONFIG_BPF_SYSCALL
 	current->bpf_ctx = old_ctx;
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..41db7d25b802 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -155,8 +155,8 @@ static inline void percpu_ref_kill(struct percpu_ref *ref)
  * because doing so forces the compiler to generate two conditional
  * branches as it can't assume that @ref->percpu_count is not NULL.
  */
-static inline bool __ref_is_percpu(struct percpu_ref *ref,
-					  unsigned long __percpu **percpu_countp)
+static inline bool notrace __ref_is_percpu(struct percpu_ref *ref,
+					   unsigned long __percpu **percpu_countp)
 {
 	unsigned long percpu_ptr;
 
@@ -195,7 +195,7 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
  *
  * This function is safe to call as long as @ref is between init and exit.
  */
-static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
+static inline void notrace percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
@@ -217,7 +217,7 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
  *
  * This function is safe to call as long as @ref is between init and exit.
  */
-static inline void percpu_ref_get(struct percpu_ref *ref)
+static inline void notrace percpu_ref_get(struct percpu_ref *ref)
 {
 	percpu_ref_get_many(ref, 1);
 }
@@ -323,7 +323,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
  *
  * This function is safe to call as long as @ref is between init and exit.
  */
-static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
+static inline void notrace percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
@@ -346,7 +346,7 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
  *
  * This function is safe to call as long as @ref is between init and exit.
  */
-static inline void percpu_ref_put(struct percpu_ref *ref)
+static inline void notrace percpu_ref_put(struct percpu_ref *ref)
 {
 	percpu_ref_put_many(ref, 1);
 }
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e95acc33989..1d26aee3c71c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -98,12 +98,12 @@ void __rcu_read_unlock(void);
 void rcu_read_unlock_strict(void);
 #endif
 
-static inline void __rcu_read_lock(void)
+static inline void notrace __rcu_read_lock(void)
 {
 	preempt_disable();
 }
 
-static inline void __rcu_read_unlock(void)
+static inline void notrace __rcu_read_unlock(void)
 {
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
@@ -295,17 +295,17 @@ extern struct lockdep_map rcu_callback_map;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-static inline void rcu_lock_acquire(struct lockdep_map *map)
+static inline void notrace rcu_lock_acquire(struct lockdep_map *map)
 {
 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
 }
 
-static inline void rcu_try_lock_acquire(struct lockdep_map *map)
+static inline void notrace rcu_try_lock_acquire(struct lockdep_map *map)
 {
 	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
 }
 
-static inline void rcu_lock_release(struct lockdep_map *map)
+static inline void notrace rcu_lock_release(struct lockdep_map *map)
 {
 	lock_release(map, _THIS_IP_);
 }
@@ -863,7 +863,7 @@ static __always_inline void rcu_read_lock(void)
  *
  * See rcu_read_lock() for more information.
  */
-static inline void rcu_read_unlock(void)
+static inline void notrace rcu_read_unlock(void)
 	__releases_shared(RCU)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
@@ -982,7 +982,7 @@ static __always_inline void rcu_read_lock_dont_migrate(void)
 	rcu_read_lock();
 }
 
-static inline void rcu_read_unlock_migrate(void)
+static inline void notrace rcu_read_unlock_migrate(void)
 	__releases_shared(RCU)
 {
 	rcu_read_unlock();
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index cee89e51e45c..94a44773b87d 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -93,7 +93,7 @@ static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
  *
  * For more details, please see the documentation for rcu_read_lock().
  */
-static inline void rcu_read_lock_trace(void)
+static inline void notrace rcu_read_lock_trace(void)
 {
 	struct task_struct *t = current;
 
@@ -117,7 +117,7 @@ static inline void rcu_read_lock_trace(void)
  *
  * For more details, please see the documentation for rcu_read_unlock().
  */
-static inline void rcu_read_unlock_trace(void)
+static inline void notrace rcu_read_unlock_trace(void)
 {
 	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 373bcc0598d1..8ec1f4172180 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2429,7 +2429,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #endif
 #define this_rq_pinned() (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))
 
-static inline void __migrate_enable(void)
+static inline void notrace __migrate_enable(void)
 {
 	struct task_struct *p = current;
 
@@ -2464,7 +2464,7 @@ static inline void __migrate_enable(void)
 	this_rq_pinned()--;
 }
 
-static inline void __migrate_disable(void)
+static inline void notrace __migrate_disable(void)
 {
 	struct task_struct *p = current;
 
@@ -2484,8 +2484,8 @@ static inline void __migrate_disable(void)
 	p->migration_disabled = 1;
 }
 #else /* !COMPILE_OFFSETS */
-static inline void __migrate_disable(void) { }
-static inline void __migrate_enable(void) { }
+static inline void notrace __migrate_disable(void) { }
+static inline void notrace __migrate_enable(void) { }
 #endif /* !COMPILE_OFFSETS */
 
 /*
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a54ce9e808b9..bce8cac45474 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -188,7 +188,7 @@ static inline void srcu_lock_acquire(struct lockdep_map *map)
 }
 
 /* Annotates a srcu_read_lock() */
-static inline void srcu_lock_release(struct lockdep_map *map)
+static inline void notrace srcu_lock_release(struct lockdep_map *map)
 {
 	lock_map_release(map);
 }
-- 
2.53.0-Meta

