Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717904;
	b=C/CL3KqcgQVtbXUzIBdzHg5WP1905IVIoE8Bra+zo5XKa2Nr0X/gh02Pc3LaPc/iPsTG
	 La2mrxWUkfti5hHVaBL7gREGCLXQAar8oYZnnjS3kSKoG979kiyVPkXgCPKVS2xsKYgzS
	 OTDiYtObiWuQSriQYmqAGwdo8S901f2izzvmqq6Tytz20aooyUUUExDrjSndjoVFKT6oy
	 EauRx/OpvrupKf+k8dGjLDTXq3Z23P1dzQYk82rCCkNtwS7VO/oF0qQydNfJU74T4yLVs
	 V9eBWXVeWq5FrCw8WR6w6XPhkCdAGnlAOa5QDvoyabin5FHEOcflgI6mVLJrCdLKlow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717904;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xp2TMs/Y5yl9q+bbABCJjm6cL649CMx+fGuVzRap2yA=;
	b=4u6HOwrzfdn+KHpT+xWMtFahIbG/2iqVI4paPvpxWTtO4iMXasd7Hk6CmfljReiJVkKe
	 2Rs9ECavmxRo3QlLbg9ZhWLOX09+dTzh/yRgNAWXjbZe12sEGce3Qhn43J3FoEiChOaqY
	 mOfr+rKM4tDadV+5xqb57Q7NXzz31xssZML2ekx4ezGdEWDhHb1udYeNaYi0N5gR5cmQd
	 NuT4kIPcxNvILo6Qk9BgUNrGAfVHmBUXL5XETzRknUDIWxMR7QUBfEi1QfcssCMZZxnZa
	 7/+1EMqQHZ3eXSLebUHQg0tgpYPDBpZ9hp0dqfWP3ocnQckaZdOGnNzlOOHWLFxsRGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxF71CS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82032606A319;
	Fri, 23 Oct 2026 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxF71CS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7EE1F01828;
	Fri, 23 Oct 2026 01:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717904;
	bh=Xp2TMs/Y5yl9q+bbABCJjm6cL649CMx+fGuVzRap2yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cxF71CS19gZ2U2mvEB3WKCl/CHdr1iu0iq2ZlLl4cceXr1vaoPKA078tWYBr+15C0
	 O2g8+Hb8ttFKeU/IaZw8fB21+WinTr8KDi5AHKyx6gkqHjUBgIyrT7rs8wuLmlpu1+
	 j/WZ4tVLfrF+mrScvDb01ZP/yy4eX9Kk3ueKz31YhciZ8pKKzw9OHj7M+NVRuvDGT/
	 z3B2xRHuJ5DfaQBXrTOtYx35xbrozRR8IJFmUaFaacMYsaHZe32CcNSrkg1t/sm8oL
	 +n9EPoafJGZI6J2G4PUp1iQvFUrb6BDDGaVD7Jjh0ZWp51ITGl77lrCsdS+4yWbjOk
	 qErLVTCScgASw==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 09/16] arm64: Mark the preempt count helpers notrace
Date: Thu, 22 Oct 2026 18:10:42 -0700
Message-ID: <20261023011049.1164625-10-song@kernel.org>
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

ftrace_test_recursion_trylock() reads preempt_count() to find the
current context, and preempt_disable_notrace() and
preempt_enable_notrace() use __preempt_count_add(),
__preempt_count_sub(), __preempt_count_dec_and_test() and
should_resched(). On arm64 these are plain inline functions. If the
compiler emits one of them out of line, that copy is untraced only
because inline implies notrace, and tracing it would recurse before the
recursion check takes effect.

Mark them, and preempt_count_set(), notrace explicitly. The x86 and
generic versions are __always_inline. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/arm64/include/asm/preempt.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 932ea4b62042..0441938c9e7e 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -7,12 +7,12 @@
 #define PREEMPT_NEED_RESCHED	BIT(32)
 #define PREEMPT_ENABLED	(PREEMPT_NEED_RESCHED)
 
-static inline int preempt_count(void)
+static inline int notrace preempt_count(void)
 {
 	return READ_ONCE(current_thread_info()->preempt.count);
 }
 
-static inline void preempt_count_set(u64 pc)
+static inline void notrace preempt_count_set(u64 pc)
 {
 	/* Preserve existing value of PREEMPT_NEED_RESCHED */
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
@@ -41,21 +41,21 @@ static inline bool test_preempt_need_resched(void)
 	return !current_thread_info()->preempt.need_resched;
 }
 
-static inline void __preempt_count_add(int val)
+static inline void notrace __preempt_count_add(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc += val;
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
-static inline void __preempt_count_sub(int val)
+static inline void notrace __preempt_count_sub(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc -= val;
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
-static inline bool __preempt_count_dec_and_test(void)
+static inline bool notrace __preempt_count_dec_and_test(void)
 {
 	struct thread_info *ti = current_thread_info();
 	u64 pc = READ_ONCE(ti->preempt_count);
@@ -73,7 +73,7 @@ static inline bool __preempt_count_dec_and_test(void)
 	return !pc || !READ_ONCE(ti->preempt_count);
 }
 
-static inline bool should_resched(int preempt_offset)
+static inline bool notrace should_resched(int preempt_offset)
 {
 	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
 	return pc == preempt_offset;
-- 
2.53.0-Meta

