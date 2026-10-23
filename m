Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717915;
	b=BYQOUsL0UyNEUl0etLmKH/Nqpmb2r+uD3/S1/iyR1QvXChZB+hDPGPgvuXZQH1dixiQ/
	 RXSBK7CglhD9T6jCCtRgTNydnmcKLoWb9qtIYVvAMNYj02kF6pEKp0P1BVm7jU1Y3eU2+
	 J3s7P0a8F85yoBRRHgvgPQW5a/zG9WNxt8+pzUKf2NQmZSJLvR4HBhlEOg6XVvavN2hpR
	 iOgHm+B5LP3/6N3M4UfXcEtebgeLNduzfCI7SGRZwp3fUUvusKO7Ndx88X+6TX3oRodrA
	 XPG8Z9V+ssyKcb2yLntlI+ELyB6cd6yQ0w29k2aZ5bg10gyFZuaDKCY/TAOKNEHD0lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1lHuDn4z8Kz1neMnyAIWO59SgkebT/pvjUTNCcZq1kg=;
	b=1j4QOrwG9s8MUf+TJbfmxfbSTf3PjLte+tKdjHPwq/FVNnVdNwpSu0PZAEdA33Dgw9RW
	 09V6ywuLElQkEKGgYwli1zX3boFPE5SdwNoU8U+tUZIYi3GYR3P7bO3yjKPiFZKtHjAcT
	 3b8/lmbP3rFDBiWAPLaeev92HN2yhavHjOsnX7q7YyiDQuknAC35LO5Wn27Ee04dtpz5C
	 HUtEk+F2brKAf2BItc0oVNYkv/UGlc/pObv/B+uoQYdtXTrewYhQcZKo+Q0lw9lK8OBIm
	 yQdBPh+kwkmcRr1LjdicMfisStT5lZmqte+2/jzyRQDUhSDO+E6b++5lcRrpMQVgIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3eSFkrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989C606A31A;
	Fri, 23 Oct 2026 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3eSFkrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7AA1F01825;
	Fri, 23 Oct 2026 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717914;
	bh=1lHuDn4z8Kz1neMnyAIWO59SgkebT/pvjUTNCcZq1kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3eSFkrtC7TeosJh1UVpPJdX1TFWw+KXQ0A6aYLuTg0GgpNJr27ZIa0Ubs+jHcxS5
	 r/KNi1pm3S9PVdx95FJWf0BnGeW/F88jZuqQfr/GZx7UQ11qPvj1TprhIeVRik3kw0
	 JJ5T0+Eiz0GKzO7EwMRV23w0pPb/3QaZA0Rif/tD6Aufr8zpNNpJQM8v+98ca/SXzJ
	 9+5EnRLBuPqIr79ZgSqsiVVGaD5Hh06F6veohfLBlRxjH8CuQTJ8sT7eu44hEidyi7
	 +6zwsfnu6ihVsGKlC6Huq86rhMD33MMtRmVlZtDkFVZ0Oj4wm7rmCclI0RTy5TITmE
	 Nyl/++dy5P1lA==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 11/16] rcu: Mark the Tiny RCU rcu_is_watching() notrace
Date: Thu, 22 Oct 2026 18:10:44 -0700
Message-ID: <20261023011049.1164625-12-song@kernel.org>
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

ftrace_test_recursion_trylock() calls rcu_is_watching() before it has
taken the recursion lock. The Tree RCU version is a notrace function,
but the Tiny RCU version is a plain inline function. An out-of-line copy
of it is untraced only because inline implies notrace.

Mark it notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/rcutiny.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index f519cd680228..2a61d17e0e4e 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -127,7 +127,7 @@ static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
 void rcu_scheduler_starting(void);
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
-static inline bool rcu_is_watching(void) { return true; }
+static inline bool notrace rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_eqs(void) { }
 
 /* Avoid RCU read-side critical sections leaking across. */
-- 
2.53.0-Meta

