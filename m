Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717889;
	b=BgnSjBN5JfChe1fKsWTmZgwljZnhnEa9NAmnlN3+44K71KCXgg+Jbe5SJ3WmQxpbDUAH
	 zyBFIdwZ9yiybsRQDwB56TObBsafP4nO0ITOdEXMIuxwng/z/3q66LFuF9Sj7ZWh9mWlU
	 C+f/likTjg45T9/i9Hv08jkcWrTvsdcQ6yE9ndW3CskdH1SjJG8tXB+twxXOoIW94E0/t
	 TsyKsn7+hfmW2sLeQc+nKcxvfM5jy/lIiYz+KpyCSp1g6xN0WQl3GfHvVM1/2L01kOeDv
	 /akLsZrL6wZvN3JzwCnTxzzAW4ofofdDSb8D3yYk2z5KooNTqtUnS4A8PWhVDAgBuaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717889;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9j9PMKAhVmuF3WUst5Dq3lx6px9ZUYXp2mfZuhiEjno=;
	b=aRRItRGobQbYrFgEjBd9VjoGLOTAjJ0P/RuJh46ND2F7+fB2xhn2r+aDmSDFFd0Av+kQ
	 9rNRpV7UWaUEp8DXq8PSW08qdJo3eg2qKedg92ReQnwCQg5G4c2Jj1OZ8hs2/VcSbaHPH
	 CTtKJJrGTrjHQXM3laZkgdOtY2Ing3FdMDDbBEdDZ3sNhwpBLmRxSMCKMSbxgKe2cJiz1
	 OoowDBru9OgU0zWInyrQdufWfR+HfMCfEulkXUN2X8vTpEIzYNUuLLMiOgwHVdoV0BW8d
	 wSS+xsv6lcL8a0OIrEmKtBP4mrQ6jg7tknAdok7XhiYiCeHjOiqUIgsEG04umeWHwBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBrZVCXF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686B606A31B;
	Fri, 23 Oct 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBrZVCXF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5338B1F01825;
	Fri, 23 Oct 2026 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717888;
	bh=9j9PMKAhVmuF3WUst5Dq3lx6px9ZUYXp2mfZuhiEjno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBrZVCXF38vX0ZSmriiXVEH/ikriA2oF/J0Nl7h6Gv6TXJgL3qIm5IjtGMC4NOjB7
	 T9RF/VohpUokd3PPVyj9oE7y3gDxaqJQzVEe9OKpTh6Cv/tFx/sCeZHCP2/x4rEvtf
	 Lsh0/GUuZpuzxXDKW34YwE/0WOBXhWRmUudDuHu24Ih79SKKXGf71R75e8kLfFgnx9
	 NHHRoDntbL5jHZVeJ4BVOF03CYcsW8XMtuRrGkD8oHUbZsZdSTG56ATvqVy/RfTtDn
	 mK833leAFRXMGEN2yXlpi1OVlo5JU71Wj+tZY493jliETcuFRk2JHUZdLoLk9n4PVU
	 3V9RtViB5XeZA==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 06/16] u64_stats: Mark the update helpers used by BPF notrace
Date: Thu, 22 Oct 2026 18:10:39 -0700
Message-ID: <20261023011049.1164625-7-song@kernel.org>
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

bpf_prog_inc_misses_counter() is notrace because it runs when a BPF
program was not run due to recursion. If it could call traced code, an
fentry program attached to that code would recurse forever. It calls
u64_stats_update_begin_irqsave(), u64_stats_inc() and
u64_stats_update_end_irqrestore(). The BPF trampoline calls
u64_stats_add() and u64_stats_inc() from __update_prog_stats() in the
same way. These are plain inline helpers, so an out-of-line copy is
untraced only because inline implies notrace.

Mark these helpers, and the __u64_stats_*() helpers they call, notrace
explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/u64_stats_sync.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index f47cf4d78ad7..06e5bffd0287 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -92,7 +92,7 @@ static inline void u64_stats_set(u64_stats_t *p, u64 val)
 	local64_set(&p->v, val);
 }
 
-static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
+static inline void notrace u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	local64_add(val, &p->v);
 }
@@ -102,16 +102,16 @@ static inline void u64_stats_sub(u64_stats_t *p, s64 val)
 	local64_sub(val, &p->v);
 }
 
-static inline void u64_stats_inc(u64_stats_t *p)
+static inline void notrace u64_stats_inc(u64_stats_t *p)
 {
 	local64_inc(&p->v);
 }
 
 static inline void u64_stats_init(struct u64_stats_sync *syncp) { }
-static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp) { }
-static inline void __u64_stats_update_end(struct u64_stats_sync *syncp) { }
-static inline unsigned long __u64_stats_irqsave(void) { return 0; }
-static inline void __u64_stats_irqrestore(unsigned long flags) { }
+static inline void notrace __u64_stats_update_begin(struct u64_stats_sync *syncp) { }
+static inline void notrace __u64_stats_update_end(struct u64_stats_sync *syncp) { }
+static inline unsigned long notrace __u64_stats_irqsave(void) { return 0; }
+static inline void notrace __u64_stats_irqrestore(unsigned long flags) { }
 static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
 {
 	return 0;
@@ -145,7 +145,7 @@ static inline void u64_stats_set(u64_stats_t *p, u64 val)
 	p->v = val;
 }
 
-static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
+static inline void notrace u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	p->v += val;
 }
@@ -155,7 +155,7 @@ static inline void u64_stats_sub(u64_stats_t *p, s64 val)
 	p->v -= val;
 }
 
-static inline void u64_stats_inc(u64_stats_t *p)
+static inline void notrace u64_stats_inc(u64_stats_t *p)
 {
 	p->v++;
 }
@@ -166,19 +166,19 @@ static inline void u64_stats_inc(u64_stats_t *p)
 		seqcount_init(&__s->seq);		\
 	} while (0)
 
-static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
+static inline void notrace __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
 	preempt_disable_nested();
 	write_seqcount_begin(&syncp->seq);
 }
 
-static inline void __u64_stats_update_end(struct u64_stats_sync *syncp)
+static inline void notrace __u64_stats_update_end(struct u64_stats_sync *syncp)
 {
 	write_seqcount_end(&syncp->seq);
 	preempt_enable_nested();
 }
 
-static inline unsigned long __u64_stats_irqsave(void)
+static inline unsigned long notrace __u64_stats_irqsave(void)
 {
 	unsigned long flags;
 
@@ -186,7 +186,7 @@ static inline unsigned long __u64_stats_irqsave(void)
 	return flags;
 }
 
-static inline void __u64_stats_irqrestore(unsigned long flags)
+static inline void notrace __u64_stats_irqrestore(unsigned long flags)
 {
 	local_irq_restore(flags);
 }
@@ -213,7 +213,7 @@ static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
 	__u64_stats_update_end(syncp);
 }
 
-static inline unsigned long u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
+static inline unsigned long notrace u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
 {
 	unsigned long flags = __u64_stats_irqsave();
 
@@ -221,8 +221,8 @@ static inline unsigned long u64_stats_update_begin_irqsave(struct u64_stats_sync
 	return flags;
 }
 
-static inline void u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
-						   unsigned long flags)
+static inline void notrace u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
+							   unsigned long flags)
 {
 	__u64_stats_update_end(syncp);
 	__u64_stats_irqrestore(flags);
-- 
2.53.0-Meta

