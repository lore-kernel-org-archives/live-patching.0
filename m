Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717873;
	b=KiA+GtBzYIdQeXePBd3soTM1pj04VPLWbeqp5z7SrdBSIId6FPgsrUueYQ/nUPnjyJ5D
	 jp4cBww1p2OVYIj1Ki46SbcAwI6U7IbCcemnc0btqxDeZVNWmisEplHP0XOhvsREPBBgk
	 5v2nj19g2vsH7ki1nHFjas1OIgWfdZrOGCh0urTEKT3vzzjVHCARXYfAFYMsqxpqCzsjO
	 fDDODIf1Seh2x9rTkU3FmCx49NBVHz8TDzrXtS9RhgTisWP0TnJc+JAl88GX0LWIIIVhk
	 oacKIY9nye96rf6L1aC3bDf6mJdEQV0aPlpvBBcoKn41L2iXlTlCjP0hlHVERTo5CmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CVBqbp7fpd6zhgvXFHBagP8bn/A8yshHQA1XmUQ9wLM=;
	b=JjFFtqiB7sQjQFlTK1+yTLFxGbvjws7kccBK2OiQp+VVF0PCgIYGZoMujzHEJLuc2HQk
	 zl+84uyTrIBFuOBSe/d8lMR47K/DhM3CAOhKAdj3M1c00sVCDGLHOPDXQVyZ2b/EX83i3
	 XFjKgouf9w7qGgl9xy2/bm8+1T2w1hs49SU6lODO+c5ck1gJxpOxUFo2pqchBxYQ0wu+q
	 xVKs3seMj1vVDwoN5FjAHpeowznjqTy1ciFJDivOMWtmRYgoId00MeNimN4OTM9YEcE19
	 RknYqqB9ae3TaRP+MA6qMPcp6r64OxlZH2FuEnlSeDmsIVTiDjVG9aIv3kdo554Nq6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I78gobeN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03208606A320;
	Fri, 23 Oct 2026 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I78gobeN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E371F01829;
	Fri, 23 Oct 2026 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717872;
	bh=CVBqbp7fpd6zhgvXFHBagP8bn/A8yshHQA1XmUQ9wLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I78gobeNNbMoQ88Ucz7Mzs42Z4JbkMSR4wqLrCTWdK7fPEWtnIQR9CBdCKcGYNOMM
	 Dg7fv91fOft7pbTu5/Jo1qbxv3JT7787kSJsYj/l+KmADfBKScau0a+jAUE/2BrQ6C
	 j3ypTmeBM6xSOiPxYExe5f3+sqbgFYRS6gMXXO4cnKl6uJS8NB+3pD8k3t2eLNT5ND
	 2axH/XMeFPjs5dfYby2Ho195FemsJv/PYyqm+NlDY1RKZfobq8gDUIuvueOOgpOyPB
	 yNDbUnTKHGEkm855K/d+tnb56J8+m3Gm9Kq16m+9jn/uiBKFZkK4nPxwiwYMqzEdBc
	 O8rvOWl7sVuUg==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 03/16] bpf: Mark bpf_spin_lock helpers notrace
Date: Thu, 22 Oct 2026 18:10:36 -0700
Message-ID: <20261023011049.1164625-4-song@kernel.org>
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

Commit 178c54666f9c ("bpf: Mark bpf_spin_{lock,unlock}() helpers with
notrace correctly") made bpf_spin_lock() and bpf_spin_unlock()
untraceable, so that an fentry program that also takes the lock cannot
deadlock. These helpers call the static inline functions
__bpf_spin_lock_irqsave(), __bpf_spin_unlock_irqrestore(),
__bpf_spin_lock() and __bpf_spin_unlock(). __bpf_spin_unlock() releases
the lock with queued_spin_unlock(), which is a plain inline function on
x86 with CONFIG_PARAVIRT_SPINLOCKS. The generic version is
__always_inline. __bpf_spin_unlock_irqrestore(), __bpf_spin_unlock()
and queued_spin_unlock() run with the lock held, so an fentry program
attached to an out-of-line copy of one of them can hit the same
deadlock. These copies are untraced today only because inline implies
notrace.

Mark all of these helpers notrace explicitly, so that nothing called by
bpf_spin_lock() and bpf_spin_unlock() is traceable. No functional
change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/paravirt-spinlock.h |  2 +-
 kernel/bpf/helpers.c                     | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index 7beffcb08ed6..dd194646dd9a 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -66,7 +66,7 @@ static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	pv_queued_spin_lock_slowpath(lock, val);
 }
 
-static inline void queued_spin_unlock(struct qspinlock *lock)
+static inline void notrace queued_spin_unlock(struct qspinlock *lock)
 {
 	kcsan_release();
 	pv_queued_spin_unlock(lock);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..66d5005f2260 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -283,7 +283,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto = {
 
 #if defined(CONFIG_QUEUED_SPINLOCKS) || defined(CONFIG_BPF_ARCH_SPINLOCK)
 
-static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
+static inline void notrace __bpf_spin_lock(struct bpf_spin_lock *lock)
 {
 	arch_spinlock_t *l = (void *)lock;
 	union {
@@ -298,7 +298,7 @@ static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
 	arch_spin_lock(l);
 }
 
-static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
+static inline void notrace __bpf_spin_unlock(struct bpf_spin_lock *lock)
 {
 	arch_spinlock_t *l = (void *)lock;
 
@@ -308,7 +308,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
 
 #else
 
-static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
+static inline void notrace __bpf_spin_lock(struct bpf_spin_lock *lock)
 {
 	atomic_t *l = (void *)lock;
 
@@ -318,7 +318,7 @@ static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
 	} while (atomic_xchg(l, 1));
 }
 
-static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
+static inline void notrace __bpf_spin_unlock(struct bpf_spin_lock *lock)
 {
 	atomic_t *l = (void *)lock;
 
@@ -329,7 +329,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
 
 static DEFINE_PER_CPU(unsigned long, irqsave_flags);
 
-static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
+static inline void notrace __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
 
@@ -352,7 +352,7 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
-static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
+static inline void notrace __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
 
-- 
2.53.0-Meta

