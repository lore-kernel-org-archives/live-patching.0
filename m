Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717894;
	b=YVyrNi6ojqmaIV36N3h3ci+guDtjiFVx6WM1/pQHULvImuwe8Rfbk4VgTIXZNjrcCqMu
	 CoZkUq79kAr4+poHNAetMmRgn6ereGL7BPR5MP79nMFS6t+9cRab3Hu9AU3TYz/GxGU5J
	 5vWwer7PtYhufihTJFrBV4oaiqffCZ3aqPgV6ToZt8YmIPDHFRZjjjFxHilWOTEA8Olb6
	 FxNDwWqdc/O4rX8vQTRaPhpTVF/h57c02/4XHzAFWWrWGC2erS3ZAewpJXUyU/dj1Geiy
	 Gn/EYOT2NFyalG2zIx4ijeX10fPBiXiXw4pN3a1Ji5jEsDzTCbQgVRz+eo4S7VqnXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6H7OGkU/bR+3Ls5SeXAtBsxdyESgiRhdYqVFUZbdRKU=;
	b=lhZLQUK3WpCj2//T7YopncAZo/m2/zK6bilRe0nHJ1Y4Amdl6d6Zrmpn/nUYW5db1KUQ
	 lf431jxhbrLuL4vlx4VfF0+u8qrcQt98pffLLMgzQrMRrnNA97kX62CqhrHPCv0o3pRtn
	 zaSM0RKM2XRufaaI94pgqomcV968f8PyZ7ufSjvQmEwUAcs5Mf/BJk/MAUn27GkHbo+8t
	 WfxZFjl8iTmFTPCBua81k/IYm/y1AHf98U788sc35fSlsz8IpEHznW0Oedvr5PS6M+iuf
	 +BJU+/Faw1jDIJlYOmnixPs65P8E2ZNnhb+TFblSvp47r0S+oCiQH1bHnV8hOJTFhJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnJkbDqf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E33606A31A;
	Fri, 23 Oct 2026 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnJkbDqf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913241F01829;
	Fri, 23 Oct 2026 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717893;
	bh=6H7OGkU/bR+3Ls5SeXAtBsxdyESgiRhdYqVFUZbdRKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnJkbDqfvTRWXRBjabwFxDpQv/1eAi+wFvW2HAnnf5sH24yMQ2seVie+mXsszyI28
	 8/qJ5fx+sg6Fph/eUW8E0CKEeW9hQLjiQo4gH/9M46QMmloxrgFW+J1gxDfXoW5s7m
	 M9bzmjc+YAfn7Fi6Kso0WvwCNjEUoQDH9E24T16yE6dgGToTsnFSyetZ+Hl6lCH9eS
	 4Coxg7iBWIUsaCMVyFG+FnvEd4fE4y2mi3HsrgJ7RZLNEmnWXjyVGNbTXFpLFn6Dhf
	 UDbU+AUy1TvdTlTFjBtgJwI51k4vweA+q+27xeDdh3v0vtHfn0wddPjl1++F48Kdkz
	 VJVAesd0R36/g==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
Date: Thu, 22 Oct 2026 18:10:40 -0700
Message-ID: <20261023011049.1164625-8-song@kernel.org>
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

__do_trace_##name() takes the tracepoint SRCU read lock and calls the
probes. It is called from trace_##name(), trace_call__##name(), and the
notrace rust_do_trace_##name(). It is a plain inline function, so if
the compiler emits it out of line, that copy is untraced only because
inline implies notrace.

Mark it notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/tracepoint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index e0d838c9ce93..1cd18b56c0a8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -308,7 +308,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
-	static inline void __do_trace_##name(proto)			\
+	static inline void notrace __do_trace_##name(proto)		\
 	{								\
 		TRACEPOINT_CHECK(name)					\
 		if (cond) {						\
@@ -332,7 +332,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
-	static inline void __do_trace_##name(proto)			\
+	static inline void notrace __do_trace_##name(proto)		\
 	{								\
 		TRACEPOINT_CHECK(name)					\
 		guard(rcu_tasks_trace)();				\
-- 
2.53.0-Meta

