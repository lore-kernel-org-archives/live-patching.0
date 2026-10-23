Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717899;
	b=vQ5tQnBXODqtKXcN6+fuC8NsxVbMCsyv3wSidheVtVzqGkXmuy17UTscOaT8y08GhP8M
	 jk7aqn7fdXsQqSc7betTW5JyDb0upWXiQHjZYrhVm23QS1jX6oycddUnfrrf0QLZ+6TC+
	 nvEmNqv+xN4y1LizpP5E/vjRPs8qezEZ1lLO6Sx6c9wk+y471VTmtKvv1zkQ2Hoqfj18m
	 8wWRTCA1PDpXxxFA8gURxWnnYAvUJQ1K2ThrZDvSwFU0z+t1O+Bo0DUFZXDBuYJ+MAIEc
	 v1OSJcRkNxXKG4sLetp4Ao02+rSyQ4bcFFYPb8ILbvyv4FWootmZQgEXWKFcRrXQ53w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tAB/PqyAB03MK42AfnxBxy/J6Gi92VHh4GhJDpFJkA4=;
	b=XYGvvrbsQlAtaPL025RQqotAgAT9ELFOiUeowSilDIFZs7Zi54uxaAe00V9yWy64P7CE
	 1ZbCaigJ+FuOEo7i5X4J9ZtYI3sQwweBXIysRiOv6iHbwqi/+GzCF7psnHqqtbFAODVxN
	 OjTPDMdUUsO6wdvXLe0i3aQUZ5SGrqoFIIZeYgNWURjJWnXABIBgrmdIzeYgyP1St9G9C
	 UDL/a/d9kILFkg9Yolg6Nv9OCelPSF08Q3o+6EKiZTHyr7kediu6VuYkmJuuE9XOrNb21
	 R9qDNUB28m/2gy396B+sydOKQBokSH6ojlr+8SPHrFvBRwMJzswXWXIw2sOY+793+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIv6nzFl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07252606A332;
	Fri, 23 Oct 2026 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIv6nzFl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25691F01825;
	Fri, 23 Oct 2026 01:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717898;
	bh=tAB/PqyAB03MK42AfnxBxy/J6Gi92VHh4GhJDpFJkA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIv6nzFl2MOintYM8ykrR9yRoVRfHfZR0bZ4XHZEV5DSxniIjsVWuQ+adbXU5gm3d
	 J31SfC6VhH/AcTqedOjilPA2s+biTLe8TPcqO/6SK0hZn+ywpbYRoSFWELtWWwTjLs
	 nYpJbl7Y39+UiYAAV633WGipgksYlxj83k0YghEFGOwTE6f27RcZfOwC9c7Tq2HUlR
	 oC+LzGmjAnCLtTOdLQM8nuKDHC4GKNlutyEc21Lz5dR91cWOeSbMtuGFi/ekHFPye8
	 skEjyfR7SEwPDbpNyu4h1c+XEtUMYCtlL31ePCM0ZQPdov/RfKKNweKWvNwRhjJfNh
	 sa0Wed6DY9I+w==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 08/16] srcu: Mark the fast notrace read-side helpers notrace
Date: Thu, 22 Oct 2026 18:10:41 -0700
Message-ID: <20261023011049.1164625-9-song@kernel.org>
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

srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace() are
used by tracepoints, and their comments say they cannot be traced. They
are plain inline functions, as are srcu_check_read_flavor() and the
Tiny SRCU versions of __srcu_read_lock_fast() and
__srcu_read_unlock_fast() that they call. An out-of-line copy of any of
them is untraced only because inline implies notrace.

Mark them notrace explicitly, as srcu_read_lock_notrace() and the Tree
SRCU __srcu_read_lock_fast() and __srcu_read_unlock_fast() already are.
No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/srcu.h     | 8 +++++---
 include/linux/srcutiny.h | 5 +++--
 include/linux/srcutree.h | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bce8cac45474..1ed3fc50b77f 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -377,7 +377,8 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_updown(struct srcu_s
  * Used by tracing, cannot be traced and cannot call lockdep.
  * See srcu_read_lock_fast() for more information.
  */
-static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
+static inline struct srcu_ctr __percpu notrace *
+srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *retval;
@@ -524,8 +525,9 @@ srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __percpu *
  * Used by tracing, cannot be traced and cannot call lockdep.
  * See srcu_read_unlock_fast() for more information.
  */
-static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
-						 struct srcu_ctr __percpu *scp) __releases_shared(ssp)
+static inline void notrace
+srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
+			      struct srcu_ctr __percpu *scp) __releases_shared(ssp)
 {
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	__srcu_read_unlock_fast(ssp, scp);
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 905b629e8fa3..fdb988d41167 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -101,13 +101,14 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
 	return (struct srcu_ctr __percpu *)(intptr_t)idx;
 }
 
-static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
 {
 	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
 }
 
-static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+static inline void notrace
+__srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 	__releases_shared(ssp)
 {
 	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index fd1a9270cb9a..8328218a34fa 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -368,7 +368,7 @@ __srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __percpu
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
 // Record SRCU-reader usage type only for CONFIG_PROVE_RCU=y kernels.
-static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
+static inline void notrace srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
 		__srcu_check_read_flavor(ssp, read_flavor);
-- 
2.53.0-Meta

