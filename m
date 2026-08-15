Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D09348C77;
	Sat, 15 Aug 2026 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769152; cv=none; b=RpOkvGhUBJyY8eXRW/GSYvt6t3jfhtbqyo3rd2+OEm2VTnhUL7huYXAzDmWN53cZAvea0ijkHwqlmHTh26Xo1iJQbG+hMqw96cUjt9BmRvuHqbpf+sY+xMjQk1NBgOrq+0X1iEk/qjI+yDk9rXAsPcSwYeTmnAnT3ngtGJYN4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769152; c=relaxed/simple;
	bh=Qc8dmVi3VPYi3jyIDF7WQ4WF7JOsXyd2qQaCAyX6ZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZk3efCkjOrnGbo4Db0P7oJZk514/wBqt+SbqyhAX1cr36038ZOIMxKN1UpdeZagXHmJhjnGomBZ2ChXksmr4dWmv4UG9qVyRqXUCcGQkvsN2v+WD4cJcJWN/B6MQf7AwVDg1dsaCN8XSM9IsNGU331y2uyEQHdwVnPl4XyKYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh2lWpvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh2lWpvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A381F00A3A;
	Sat, 15 Aug 2026 04:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769151;
	bh=y3RAP4/V/S2Ka1HZIeZ+MI/MmRFw0KCRbzs9mdx3m/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yh2lWpvnhz/fqU5jrXmd7zdXBwN04vdE8Z/rdgzWLKG0vWbPRSF34Y4UJkIZSwTOs
	 S4CkWWnCpBwkjvzo5FcwdusCciF7mOItmOGAPwvIuWuELsPaQOJ8gcLAnu460XMtlo
	 QO2PATvBByJLhdu2UjJ1jhXdjUsQi9BzR61XVcp/Y0VZgDpOkm80/sHY4DCroSkdzW
	 MtvS3EAex7G0Oqsiug7sSJekBehikkGIdr0L2ZpJe0ss1IlPNA70ziImVNr3QlEnYx
	 P7rBvcsr3r2B2TWM/tPLvFq1yVFWnUyh8HFFnVf4g/SCwrGzMEZIX+SXJpQm0bFbY6
	 QmA21yYigQvIQ==
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
Subject: [PATCH 11/12] arm64/bti: Force-enable BTI linker veneers
Date: Fri, 14 Aug 2026 21:45:28 -0700
Message-ID: <edae8b52c1cba6eecd0bc75f709f6009816b80b8.1786768375.git.jpoimboe@kernel.org>
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

The linker only emits the BTI veneers if *all* input objects have
GNU_PROPERTY_AARCH64_FEATURE_1_BTI.  All the kernel's objects now
advertise it, but if some object stops doing so, BTI veneers silently
stop getting created on >128MB kernels, resulting in BTI exceptions at
runtime.

Force BTI veneers enabled with "-z force-bti" to prevent a single bad
object from ruining things.  This also emits a warning (or error with
CONFIG_WERROR) if any objects are missing the bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4eee721c0b278..d0db9a6766a2f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -25,6 +25,7 @@ endif
 
 ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
 KBUILD_AFLAGS	+= -include $(srctree)/arch/arm64/include/asm/bti-note.h
+LDFLAGS_vmlinux	+= $(call ld-option,-z force-bti)
 endif
 
 cc_has_k_constraint := $(call try-run,echo				\
-- 
2.55.0

