Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1F3B3BE5;
	Wed, 13 May 2026 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643298; cv=none; b=jmE+ee/pyiH2QlL3OGjG8iQ2DKfkqHFGaQVBf6sbkjrtnoYvW3r8sioUbn0GqrIx5I7BXGTvH7HF9yBPAAk1ZkJPYhUKkGuE68zJ2bc6R274oja+cd+hc/uO6MeNBCzoqQT6SyGYxHC1Sf5PllpRR0bg/TMgTJ+cLaQk0iV5ARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643298; c=relaxed/simple;
	bh=YLQATZuaSnhkkzf9eNAaMViHdYeqnWtOoiB9QIjH1E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nh/XeTSLHVqON3rwkzGS7oB6ED+r/Y0j0kkQjs4RO5PelbIrM2/WsiNr+omRGf7KNkl+f5kiZ/eKXqHV9+wk+2DMwvfLSXBk32uYupGccyw0nTk/9XpEGrosZIa6STIS3JjSGNFK44EI13MnP5wgd8l6vki/Hs4QzacG9SJoikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srR52N72; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srR52N72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E43C2BCC9;
	Wed, 13 May 2026 03:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643298;
	bh=YLQATZuaSnhkkzf9eNAaMViHdYeqnWtOoiB9QIjH1E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srR52N72ajUS/qt0gfNhYQ2ypWHNM39KZV/y9QyU/Tbh9AewWSuInrKg1fY0AqSkq
	 bGFDCFvmtRYPpmTGDhZ79tmiUbXa1gAPhewu7765XOpGqRWIGtpUnz+AZZTeZxkQ//
	 aKVf1U6Iq02t1j3k4JpsHZvx0MZ+OAa6pnWil+kljhiX7RrhVJkT1DTAhaGzXhtngs
	 RhRvPcmm48852UA7rhOaOqZec1cX10IReoOqfMrliWxX0Jyzj1yqFPqqv62qxyToTB
	 DZH5OeCYUqYw79i2SpwLkdrqf/tZRN7aQEEmQpwdmkmTpyE4sKR3OHymVHXVoFvC2i
	 xYgYZw1nGVRtQ==
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
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 21/21] klp-build: Add arm64 syscall patching macro
Date: Tue, 12 May 2026 20:34:17 -0700
Message-ID: <3bf3cee43039fc4da84e83d0891a92e25f40f00f.1778642121.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260513033417.IxkYK2RnAFRcGLwF3WQr5BbYi187ceo6CuzsFzcyjWI@z>

Add arm64 support for KLP_SYSCALL_DEFINEx(), mirroring the arm64
__SYSCALL_DEFINEx() pattern from arch/arm64/include/asm/syscall_wrapper.h.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/livepatch_helpers.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/livepatch_helpers.h b/include/linux/livepatch_helpers.h
index 99d68d0773fa8..4b647b83865f9 100644
--- a/include/linux/livepatch_helpers.h
+++ b/include/linux/livepatch_helpers.h
@@ -72,6 +72,25 @@
 	}								\
 	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+#elif defined(CONFIG_ARM64)
+
+#define __KLP_SYSCALL_DEFINEx(x, name, ...)				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);	\
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
2.53.0

