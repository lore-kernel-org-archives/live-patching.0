Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717883;
	b=0pFn0BYzr58vDB1lbWZBwMlsIBLGZXOrolwu3+p6Yyyzy+2KFCEvsd4V/Ix2+ZdlHcen
	 5RISHsy9l1jaLLSNc0FVR16sJW/7e4RG7nX9C3iFBZKlAK2blbyqDH96B0TRM151bPYjS
	 F/Rt1ylwQpu9Fwa3bv+4P8WXIbKqad9YdzHhA6K/Si7PE80oSu4clRsTAJoj2dPiKri9l
	 3Nc2Kyk7dAIFNKhYEuaHQr8/VG+Wa/ghm2GWBEGUSURqu7veAHSuXuOGaTRtAgfuGhb1y
	 OOEwyCQLZgbjOKEq0KClfFAnioxDtPfDs+edfhcITrD5lVZl2lvkxCYzx2W8ut4ZilA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WB7xUwsalXpRO25TkM2fWFK3fMQBArx/xIplY1Zxit4=;
	b=LeUGN1SJvXnp5z7djBiuscByAKIrTkJLc8Zab4o6t0bG/DMNe613Hm4VqDI4XOjSjYxV
	 bG158AU6zBIvPGbvtLzzFo7OHY/mkmn3HnHVH0EN25V0mPSDAR4oGA7RW4EPbeveazET1
	 ueip2DnUs8B2FOttmfgcQtx6pqSGI6UGIL4giDYCxhVLPPAQPd1gfvr0T049DTo12GrRE
	 KCCqkUFmW9sfS0dAzUeKjk5fpgSX7aaBzpgRD8ebwzleQc6aW2Wh7NhR2FVM3wz6/z8VI
	 qMNeIQ+V/LJdAWfzgobUpJtd04z+9+6bq3mXatVwortzaYBTpth6Snjct0TmPy0dxiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvQFXUWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09B606A31D;
	Fri, 23 Oct 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvQFXUWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E551F01825;
	Fri, 23 Oct 2026 01:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717883;
	bh=WB7xUwsalXpRO25TkM2fWFK3fMQBArx/xIplY1Zxit4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BvQFXUWG0SnezE9ekcxQA/ViI2GYZwMiPEbZ3HjNQhpNu6AWlR9qAUnnxgSnREBrm
	 xqBNKFHQw603JJHBkG5+sm590z3ks8cYcngfajLkqFtrPrCNBsbV+BJ349G3eEaOMK
	 2zqSPGL83+HWyFNO9cUb3wSTQtTZn124anKesY0f5ATRKdBM5udavA5GP94k1Q3RpP
	 uL++Wh48id/vHIGGJfSN+m94V/IyHiNis8VnNVlXFGqlfddVpFeQhpJPoJaiddWvlM
	 uV4wEUp/a0pVZ6jNqrusK083e8Zddx7baY49OqjFHysmAn6fwCbhcS/ianz2sxtY0P
	 oyN21vxeHFhCw==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 05/16] bpf: Mark the bpf_mem_alloc fast path helpers notrace
Date: Thu, 22 Oct 2026 18:10:38 -0700
Message-ID: <20261023011049.1164625-6-song@kernel.org>
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

unit_alloc(), unit_free() and unit_free_rcu() are notrace so that BPF
programs cannot attach to them and corrupt the per-CPU free lists, as
the comment above unit_alloc() says. To take and release c->active and
to update the free lists, they call local_inc_return()
(local_add_return() on x86), local_dec(), __llist_add() and
llist_add(). These are plain inline functions, as are
__llist_add_batch() and llist_add_batch(), which the llist helpers call.
An out-of-line copy of any of them is untraced only because inline
implies notrace.

Mark them notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/local.h |  4 ++--
 include/linux/llist.h        | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 1749c4481000..66f2cd57160c 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -22,7 +22,7 @@ static inline void notrace local_inc(local_t *l)
 		     : "+m" (l->a.counter));
 }
 
-static inline void local_dec(local_t *l)
+static inline void notrace local_dec(local_t *l)
 {
 	asm volatile(_ASM_DEC "%0"
 		     : "+m" (l->a.counter));
@@ -103,7 +103,7 @@ static inline bool local_add_negative(long i, local_t *l)
  *
  * Atomically adds @i to @l and returns @i + @l
  */
-static inline long local_add_return(long i, local_t *l)
+static inline long notrace local_add_return(long i, local_t *l)
 {
 	long __i = i;
 	asm volatile(_ASM_XADD "%0, %1"
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 8846b7709669..53bc48f6b956 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -231,9 +231,9 @@ static inline struct llist_node *llist_next(struct llist_node *node)
  *
  * Return whether list is empty before adding.
  */
-static inline bool llist_add_batch(struct llist_node *new_first,
-				   struct llist_node *new_last,
-				   struct llist_head *head)
+static inline bool notrace llist_add_batch(struct llist_node *new_first,
+					   struct llist_node *new_last,
+					   struct llist_head *head)
 {
 	struct llist_node *first = READ_ONCE(head->first);
 
@@ -244,9 +244,9 @@ static inline bool llist_add_batch(struct llist_node *new_first,
 	return !first;
 }
 
-static inline bool __llist_add_batch(struct llist_node *new_first,
-				     struct llist_node *new_last,
-				     struct llist_head *head)
+static inline bool notrace __llist_add_batch(struct llist_node *new_first,
+					     struct llist_node *new_last,
+					     struct llist_head *head)
 {
 	new_last->next = head->first;
 	head->first = new_first;
@@ -260,12 +260,12 @@ static inline bool __llist_add_batch(struct llist_node *new_first,
  *
  * Returns true if the list was empty prior to adding this entry.
  */
-static inline bool llist_add(struct llist_node *new, struct llist_head *head)
+static inline bool notrace llist_add(struct llist_node *new, struct llist_head *head)
 {
 	return llist_add_batch(new, new, head);
 }
 
-static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
+static inline bool notrace __llist_add(struct llist_node *new, struct llist_head *head)
 {
 	return __llist_add_batch(new, new, head);
 }
-- 
2.53.0-Meta

