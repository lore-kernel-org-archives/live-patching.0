Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621385;
	b=X0gwVVg1mSoL/9XzCUjuO+ieHmDOguqNgKBuH61fuapA75KMNG2YFh6nnphe+BoEZkG4
	 TVBJ2zyxG0d6oLbcx3ZdInXZFabLw5lnueFNLiNPUFwnfyk2T82/Ogoii5sWnVheSgNmJ
	 BJNK931RTyW0GZaFer5NQhDwCvjrD91Wmm8/by1saOVBTIQOpRmYlBwOkSN8QUlAq6myr
	 93RSruBBNpmo2El2R6rH2JgJfCmlc+hRM5oWTFUK8IV1URdIEVOKZNb8UUNiz6BbNoBCV
	 PAAzZn1kbR2C9WaOHIpzs5r/tdymEUSFRqyTb1NkWUZOrjdXim9pU1fUnzM20GRzIzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f638RTnmDUhYgsB0t3rdzo87luml5kZaSE06sLT1s7M=;
	b=jNfecbNjoeH+d9jfKqVzD9TPeX6ZB5uHKJQPp86BS/HYjsXsKet1/oh5PXufzEffHM6q
	 r441g3+qZ6G84kIBLqxhndvIdXBsUviqv0CApUNfHHlKv0kRtqY+R6LFTtTNwgzAg+4Al
	 Kgtbr/oC3uqc/MuN8imQIrVSQ9L9NFd3aMe8UJP/vfVR6wcfoVSFXB/CIOLHQTaSgm7cB
	 0lYhYGuHkEKR+6nfejwERGqKfcAYJUVER48gKWhAUuIWwpaIfnypssmXsnpKrI70GPc/y
	 2DVRLsNjJCA0DRpnaAdQ4PK0enPc+GmHl+be+XBbOSrDxVDeo4BynwnsvZhlF+IUlCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evypLS0E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18832606A31A;
	Wed, 21 Oct 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evypLS0E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9471F000C1;
	Wed, 21 Oct 2026 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792621384;
	bh=f638RTnmDUhYgsB0t3rdzo87luml5kZaSE06sLT1s7M=;
	h=From:To:Cc:Subject:Date;
	b=evypLS0EWxbwVoyabjSsFUygbI8AgCukjVhMtAozpC5DdjLqrdzzGUVETHQ+GOLgs
	 M3leedefl1FvJaGBtRNjHmIsxFJAufwQchB03kiBGUKDmYRjr/RqJ0W73iILBjU1Mx
	 rrgrRxsH6tEgCtsrhlyBA+qiksiGpl830gjQOQZP4TE6bLqVUeDwlZrV5BrC8f6XdE
	 NA+7iFRcCXRAq/OFAqoc7YcDfiBkCH0fgzEnkKtMIF0x4KiQp6LJeppoR9RHVbj8Gg
	 jSWNjm/gxYXElHLW7mkLatk7gMi5DlZy7NUeS2u6QJAapMBFk0Cp/eBihTa36GVKhy
	 LzrqyxJQ+qkUg==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH] compiler_types: Do not mark inline functions notrace
Date: Wed, 21 Oct 2026 15:22:55 -0700
Message-ID: <20261021222255.3124940-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The reasons for that change no longer hold:

 - Code that must not be instrumented is now marked noinstr, and objtool
   validates that noinstr code only calls other noinstr code, see commit
   c4a33939a7eb ("objtool: Implement noinstr validation"). This check
   is based on sections, not on notrace, so an out-of-line inline
   function called from noinstr code is reported whether it is notrace
   or not. The paravirt helpers that the tracer itself depends on, such
   as pv_native_save_fl(), are now in .noinstr.text or __always_inline.

 - All ftrace callbacks are recursion safe since commit a25d036d939a
   ("ftrace: Reverse what the RECURSION flag means in the ftrace_ops"),
   so tracing a function that the tracer itself calls no longer causes
   recursion problems.

 - CONFIG_OPTIMIZE_INLINING was made always on by commit ac7c3e4ff401
   ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly") and removed
   by commit 889b3c1245de ("compiler: remove CONFIG_OPTIMIZE_INLINING
   entirely"). The compiler also inlines static functions that are not
   marked inline, and creates .constprop, .isra and .part clones, so
   the set of traceable functions already depends on the compiler.
   notrace on inline does not make it consistent. It only hides the
   inline functions that the compiler chose not to inline.

Hiding these functions has a cost. They cannot be traced with ftrace or
used as BPF fentry/fexit targets. They also cannot be livepatched,
because livepatch redirects functions through ftrace, so a fix to one
of them has to be shipped by livepatching its callers instead.

A function that really must not be traced should be marked notrace or
noinstr explicitly, instead of relying on the inline keyword.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/compiler_types.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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

