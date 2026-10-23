Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717909;
	b=IIWm07YVRPWpMQYj3JUNu/pYbFmY3p/MO9XVZMf3lTq3Mly/BxP6X3NhQDT6E2DtNkXr
	 NjYP+TTkQgGJ++eet+Il5oivg0QxwDfbH+FGMG6eQ49f3m0ZCiBPtTNJo5GhksJQh7Obm
	 YDmBBQHvcBUXGa6jnf2r7MNxMSZkWOJPUdsRpt26E8sM8XTex48f0psPAXGTCwFh9Mq2/
	 AayFUkGwnpTFrA3tMwvJ6MvKiFOlc6xzV+FgFj2rqs4cUWAElCBaa7Npjx944XTFyuLIq
	 kcLMKBpTOYjWr1wys0pat6MBxcANG3Rl5Ol2c2Su0a0TMWRIF5igMDbW2iOw6o1iYQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Uaspmp2ODihoXk6Ju3FruQFD2ZGMXaBy20k2Z2P+1K8=;
	b=WzNoH+2zjoId2TUUHGXDTy2SFBMzMpv/GLlH5HVqMdZCNiOftw5AmvHth7TVoTE4mZvN
	 +0lVkKnVntk0quay+dynZPN7ZUKFnq3z1XeFn52MZsMYw4vj2TNrJdhaeFVxac6VCv/IU
	 FzkjpAwc45DJmFi0N42EuBOCfu1xl2bEwW9jgR1h6OZ/bm7Qx/tTUedwOPcHvxLTjWsnl
	 GD1XKEbTC/dX9SZfc8KbgOjh6OCf3YDJJOisd2jH5EY6xqK8a9QnkyKcxC5eziC8SYMcS
	 9PMEzJQ+qimjYZWjfiECVXs2qiIL8T9ytX6A9mSRReGgLVGog1kLEzuWTaMv2sS0OTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8RTWf8F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802F606A321;
	Fri, 23 Oct 2026 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8RTWf8F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7881F031E6;
	Fri, 23 Oct 2026 01:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717909;
	bh=Uaspmp2ODihoXk6Ju3FruQFD2ZGMXaBy20k2Z2P+1K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G8RTWf8FIie9HXKs+Or5w9rGKm/Vb9NO10HQCK/2MtD/yVCMdqM/KfcL1B961Y57v
	 H7OHi7GxvNKtwJXimRVZIrk6Bd5pOWApMsGpC+4v9/H4H7WjgIVzNLzirQ4VZT24Gq
	 lZRSC1OWLTs+kwCAGGVQTIIhrNbTQ2uU6ntj+3aLIWZZUjYr04wg9PfGlMD/fe07NU
	 jTUQeT219gbITxpAj3ux6KZaKrE8He9y/raajeRpipE4DajJz2ZcJQxLkwJNapHBGY
	 t4CIl27U2Lab0GZ2u3MLHc7r297lqaZP3nm+qOJvgPNfhFjoh0CsHiASz+PbqIMQOj
	 71m5cINzjI0dA==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 10/16] powerpc, csky, mips, sh: Mark the accessors behind current notrace
Date: Thu, 22 Oct 2026 18:10:43 -0700
Message-ID: <20261023011049.1164625-11-song@kernel.org>
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

ftrace_test_recursion_trylock() reads current->trace_recursion before
it knows whether it is safe to trace, so reading current must never be
a traced call. On powerpc, get_current() is a plain inline function. On
csky, mips and sh, current comes from the generic get_current(), which
calls current_thread_info(), and current_thread_info() is a plain inline
function. An out-of-line copy of any of these is untraced only because
inline implies notrace.

Mark them notrace explicitly. On the other architectures that support
the function tracer, get_current() is already __always_inline. No
functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/csky/include/asm/thread_info.h | 2 +-
 arch/mips/include/asm/thread_info.h | 2 +-
 arch/powerpc/include/asm/current.h  | 2 +-
 arch/sh/include/asm/thread_info.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index fdd4f8ad45ac..d39498883c9a 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -42,7 +42,7 @@ struct thread_info {
 #define thread_saved_lr(tsk) \
 	((unsigned long)(((struct switch_stack *)(tsk->thread.sp))->r15))
 
-static inline struct thread_info *current_thread_info(void)
+static inline notrace struct thread_info *current_thread_info(void)
 {
 	unsigned long sp;
 
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 2707dad260dd..4d531efd89ec 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -64,7 +64,7 @@ extern struct thread_info *__current_thread_info;
 register struct thread_info *__current_thread_info __asm__("$28");
 #endif
 
-static inline struct thread_info *current_thread_info(void)
+static inline notrace struct thread_info *current_thread_info(void)
 {
 	return __current_thread_info;
 }
diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/current.h
index bbfb94800415..9663d3737d5c 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -12,7 +12,7 @@ struct task_struct;
 #include <linux/stddef.h>
 #include <asm/paca.h>
 
-static inline struct task_struct *get_current(void)
+static inline notrace struct task_struct *get_current(void)
 {
 	struct task_struct *task;
 
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 471db5173036..9e1ccdd70a7d 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -63,7 +63,7 @@ struct thread_info {
 register unsigned long current_stack_pointer asm("r15") __used;
 
 /* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
+static inline notrace struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
 #if defined(CONFIG_CPU_HAS_SR_RB)
-- 
2.53.0-Meta

