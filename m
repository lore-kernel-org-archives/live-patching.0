Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E634252B;
	Sat, 15 Aug 2026 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769148; cv=none; b=kSkBhBbecnGpM1zNCWNEagy7CUuyOx0VnT5RauMX43Rr4IzDk2UjKjsoOar6YNaAuL5I6tKBRcrXJHz8dL/WnfaJ72/F4WDw9Kg+2byqZpls8ez/zn+ZJsltTM+kTmapz9BJkKR8Mb/l1WjKunvcn3maEtvNXKiUWOdqyEzTZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769148; c=relaxed/simple;
	bh=qya/h/jgm6BKCIUbx5n1BlQ1yPdZlszC93NTlzGn1TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwWyRtaZ7x9gQ+uiiSchoC4uUxJnoyURSCqF+J+tTrtIJaGu+7wy2S4UlapQDwP2py4vZ3mwcnxotyfgwwYPezi6//lAK5MKmTdGvw762nDUP6kuHeEfqkJTnlmStnFicV2kDnNJJjhHDQtXSxNk0iFrJQMbQuWyWKK+/8Y66DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFh6UQXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFh6UQXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818D51F000E9;
	Sat, 15 Aug 2026 04:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769147;
	bh=9wCRQs/DtGwKuk6KFB2dJnmuHFc0uK43X388YUJ5gCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFh6UQXUzmVr9Vh0yo33HvQJWaCYguigFZnKEJ6gy8qQcxVVhEHMrSt3D5nHMBXhj
	 ziSGYXNNHUpWD02KsjtZnxulTClP4rxAmCYvn9vsyiN25thRAJkSix/BPFZZCA3Y4K
	 splzGd/7Y+gu1zAU631JCcwOOeyLGLtmLyUCS/LcxUQ+WZkIwXwuSklVNccvOdcyKS
	 irrARnSVAYrDtQbNlNx9VZy3X7NR31bGM7T54umCH6EOpNSvwUO/nVebNBxIlRFeKL
	 bM164ghDz+oP9T108vpl+4HGurwA56HUFY8dgIcogYbROdMj025CYjK8xwLL5AypzP
	 ZKw+MIJAwi6Og==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 06/12] arm64/bti: Add link error for large kernels with BTI and livepatch
Date: Fri, 14 Aug 2026 21:45:23 -0700
Message-ID: <42ba934395666a29186dad1c072381a64712268b.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A livepatch module uses klp relocations to reference static functions in
vmlinux.  If the livepatch module is placed at an address far away from
vmlinux, it needs PLT veneers to call those functions.

With BTI enabled, the veneers' indirect branch targets need a BTI
landing pad, which not all functions have starting with Clang 21 (and
for all versions of GCC).

In such cases the module loader attempts to allocate a page close to the
target for emitting a second veneer which has the landing pad along with
a direct branch to the target.

That page has to come from either the region below _text or the region
above _end, as there's no way to allocate memory in the middle of the
vmlinux image.  For a target near the end of a >128MB text region
there's no address space below _text within branch range at all, leaving
only whatever room happens to remain above _end after rodata, data and
bss.

If the branch target is out of range from any available free pages, the
livepatch module load fails with -ENOEXEC and a "no address space within
branch range" error.

Add an assertion so it fails the build instead.  Only count the module
region below _text; counting the space above _end would make a text size
limit depend on the size of rodata, data and bss, and doesn't help
unless text is bigger than the rest of the image.  The span is _text to
_etext rather than __exittext_end, as init and exit text are freed
before any module loads and can't be klp targets.

Distro kernels don't seem to come close to hitting the 128MB text mark,
so this should hopefully be more of a safety backstop than something
people are actually hitting.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3a88da9212831..f5bd5ad24e19f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -419,6 +419,13 @@ ASSERT(__hyp_bss_start == __bss_start, "HYP and Host BSS are misaligned")
     defined(CONFIG_CC_OMITS_BTI_LANDING_PADS) && !defined(CONFIG_LD_HAS_BTI_STUBS)
 ASSERT(__exittext_end - _text <= SZ_128M, "Kernel text too big for BTI")
 #endif
+
+#if defined(CONFIG_ARM64_BTI_KERNEL) && !defined(CONFIG_COMPILE_TEST) &&	\
+    defined(CONFIG_CC_OMITS_BTI_LANDING_PADS) && defined(CONFIG_LIVEPATCH)
+ASSERT(_etext - _text <= SZ_128M - PAGE_SIZE,
+       "Kernel text too big for BTI live patching")
+#endif
+
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
-- 
2.55.0

