Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717940;
	b=v31L9B2v2GpKJ/uGdRF2jjdSeKFrKybV0E9YfE/Ss3zZMpswtqO1C/cTIQd2vQxgJlTX
	 ucOlmwwiOT8kThSzoYb7B/yG1BwXhVlRckylMl0VyMebHNPj+SwqtRXh4Nh5g9nUVr3Li
	 wyYto2N346tPjxAaRSTvOt7AIqQ/P0Dy/EvxgS9j3fVjwxQSvpeRyzfd8SeLflNU3UEod
	 lKKxX6x74LzK+WRP0O4K7a+nubOuW1fgAATCXLZDvbDoOn3B2+HwaNtTfWAEHSzlBIzrc
	 cc2x1Yrk3sCrBIi171VllnKrir55dCEy9FjVgt1WOPctZVOvUImAZSYS+z54/wuKXDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717940;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MDDy5jQJyoanTUkPzB5s4coGDvxcwLKDeaa23LDEAdk=;
	b=BHjUkUloKBWregW7pmqNLGQv4QkMsuoHjAaAZYawVwsatA+3ZXMQvvnZc6m3u+C0MQdw
	 qwC2RvdZfydoDxZxyP+nsDWSkw38JK2i0ftfaIn8LvR7rot3jbUtg+TeN2FpSQGBWY/sg
	 tLi/MOF7JFlHdd24ICCKVKsBZCFWtMpkydFIIi1VVFzEb+vE5TidsWLVhKhncmFVNJBLn
	 OEAUuJscoBwKKg895F4VGbbTTPcPVlrU4F8sk4pY2JqKs2YXWErAW/N4dXV5mM9sHOPXU
	 x9/QQ4yc4+6sxx/HvxQ4opu2QUUTe4OQovpWXVbPzvoNgbi37eD2sRvSw3p4wlLnrXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwyQG3co;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E9606A319;
	Fri, 23 Oct 2026 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwyQG3co
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451AE1F01828;
	Fri, 23 Oct 2026 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717940;
	bh=MDDy5jQJyoanTUkPzB5s4coGDvxcwLKDeaa23LDEAdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwyQG3coNC3/7Xsc1dP0EFscFSXxePXc5x5Roym/NOuhIeo1w3KX+/ExmPqdFeeXf
	 YDFiXKOniUAOJSUk9fZvSsC9RllES3+ZZzvr9wXpZ2IyBxK2mULn2x1cjEhUQBQKxY
	 RbB+xE/SkDUhok2B5iaj9/9Bz6/FcGjBV8qcC5op2Pkzx7CN868Q+ZP8OQiGTpAgu4
	 UBtN7O2cSQ7mOu1/Is9tCQqwrSXBox2IZusUDpdz/ymoM464G/eYBtLRsS8NnXIw87
	 b4rGvkQ+p8DH7l5oId2/9csrTTIio3oHMfy5rjrgZOW0jnizm7qvUJCIwRm+2UeDWT
	 bwikXXp8fRnAA==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 16/16] compiler_types: Move notrace from inline to __always_inline
Date: Thu, 22 Oct 2026 18:10:49 -0700
Message-ID: <20261023011049.1164625-17-song@kernel.org>
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

Commit 45959ee7aa64 ("ftrace: Do not function trace inlined functions")
added notrace to the inline macro. At the time, inline was only a hint
with CONFIG_OPTIMIZE_INLINING, and whether a given inline function got
an mcount call depended on the gcc version. Some functions that must
not be traced, such as the paravirt native_*() helpers, were marked
inline and relied on being inlined, so a different gcc could silently
break the function tracer. Making all inline functions notrace removed
that dependency on the compiler.

That trade-off no longer makes sense. CONFIG_OPTIMIZE_INLINING was made
always on by commit ac7c3e4ff401 ("compiler: enable
CONFIG_OPTIMIZE_INLINING forcibly") and removed by commit 889b3c1245de
("compiler: remove CONFIG_OPTIMIZE_INLINING entirely"). The compiler
also inlines static functions that are not marked inline, and creates
.constprop, .isra and .part clones, so the set of traceable functions
already depends on the compiler. notrace on inline does not make it
consistent. It only hides the inline functions that the compiler chose
not to inline. Hidden functions cannot be traced with ftrace or used
as BPF fentry/fexit targets. They also cannot be livepatched, because
livepatch redirects functions through ftrace, so a fix to one of them
has to be shipped by livepatching its callers instead.

A function that must not be traced should say so. The previous patches
mark notrace the inline helpers that relied on inline implying notrace:
the paravirt native helpers, the helpers used by resume and kexec, the
helpers used by bpf_spin_lock, the BPF trampoline and bpf_mem_alloc,
and the helpers used by ftrace recursion protection, tracepoints, SRCU,
the trace clocks, core_kernel_text() and the nofault accessors.

Keep notrace on __always_inline. Such functions are meant to be inlined
into their callers. An out-of-line copy exists only when the address of
the function is taken or when it has external linkage, and those copies
are mostly low-level helpers used by entry, context switch and tracing
code.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/compiler_attributes.h | 6 +++++-
 include/linux/compiler_types.h      | 3 +--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..5fdc07b3e380 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -49,10 +49,14 @@
  * to its docs (and also "warning: always_inline function might not be
  * inlinable [-Wattributes]" is emitted).
  *
+ * The compiler still emits an out-of-line copy of an __always_inline function
+ * when its address is taken or when it has external linkage. These functions
+ * are often used by code that must not be traced, so mark them notrace.
+ *
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-always_005finline-function-attribute
  * clang: mentioned
  */
-#define __always_inline                 inline __attribute__((__always_inline__))
+#define __always_inline                 inline __attribute__((__always_inline__)) notrace
 
 /*
  * The second argument is optional (default 0), so we use a variadic macro
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..ea7f2a928b4d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -230,9 +230,8 @@ struct ftrace_likely_data {
  * externally visible function. This makes extern inline behave as per gnu89
  * semantics rather than c99. This prevents multiple symbol definition errors
  * of extern inline functions at link time.
- * A lot of inline functions can cause havoc with function tracing.
  */
-#define inline inline __gnu_inline __inline_maybe_unused notrace
+#define inline inline __gnu_inline __inline_maybe_unused
 
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of
-- 
2.53.0-Meta

