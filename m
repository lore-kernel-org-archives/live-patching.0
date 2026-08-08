Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AC378D70;
	Sat,  8 Aug 2026 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231124; cv=none; b=d4ReGRb0bDivoy3OJEUertsaWsGLus2fXIZtYIWZZZP8X0ybzZGCEGCH+0Co8Ie91sfY8dDQNOxeCR1gizRZ7Fixype231fMNWR7+xEaVA5YKQ179dJJlMlgSJ00fZRxfzuqUnHVKN9eiLdUwESTwGMJumnPDQpQ4xa2xIUsRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231124; c=relaxed/simple;
	bh=Sgdk69pUZcGHcT7Fx1Hkm9Ph3wp1ZRnOKDhoZ7Fstjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPhMNuWmXiPyc+JiQY3+SD33nevzbl5Gk0hN0B8Hm5qLONNj+ADGhjmc5jy1Gr1TM+yGR+wSvlfynh7STqBfNNL7fsy5TgPW2zpsNMUtouUiLvEh7QH8y2zH+zO8LEKxrUTN4WkU3CFE7FLa4qnEX/bljxS69FZUDNAsgZn0+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq0mckAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq0mckAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963551F00A3E;
	Sat,  8 Aug 2026 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231123;
	bh=Ql766kWCyJrEzgimYF7/K/mUeDpunCOGDp3konzUix0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nq0mckAaodCqRAuEffJncChyCgw5SLKZuxiUI0nb/3BSzXXGa+y3QwmlW01DKue/A
	 BYBIxXoOfEOLAUGXpcf4t+0QnH8AnWaPZZA1uXU4G3vCVOlUUZC+W8ztZk8BpX7ogb
	 goMer3X7ppHfRcfEAeYmtU6FlzxNF9X55qfBAccXfQp24KcqOm5zLQYKzsa4axEL4b
	 6m6rGk/w3sTZAWYSQAMcj5zJQHQ2dUcfKPpOvmalU8sGiLDu6xSdorXFbFxua1SOGq
	 kI2cr1CjlR1c+VcrgtB4NUAsyzn8CGdLvU/uB3ZeXlsZU/4H+GF5BMFqn40dshD+p+
	 RqnuAUAN/RmiQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 22/22] klp-build: Add arm64 syscall patching macro
Date: Sat,  8 Aug 2026 16:17:26 -0700
Message-ID: <56e974b384ffbb3f8b424e7c69da3f702f87f2f8.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arm64 support for KLP_SYSCALL_DEFINEx(), mirroring the arm64
__SYSCALL_DEFINEx() pattern from arch/arm64/include/asm/syscall_wrapper.h.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/livepatch_helpers.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/livepatch_helpers.h b/include/linux/livepatch_helpers.h
index 99d68d0773fa8..fe02c7b2f769e 100644
--- a/include/linux/livepatch_helpers.h
+++ b/include/linux/livepatch_helpers.h
@@ -72,6 +72,26 @@
 	}								\
 	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+#elif defined(CONFIG_ARM64)
+
+#define __KLP_SYSCALL_DEFINEx(x, name, ...)				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);		\
+	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)	\
+	{								\
+		return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}								\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret = __klp_do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
 #endif
 
 #endif /* _LINUX_LIVEPATCH_HELPERS_H */
-- 
2.54.0

