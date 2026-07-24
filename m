Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981342BC36
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893431; cv=none; b=Szz7nnFLPWu60t3WGMmBXQx5BHKcUKKvgxuVGNaLze6v91Hv8kDPIUiVqIbC1xGc0q9vXdp7x3xyRP4PGhNtI8GU0cVVm+uFD1JFixJ/QDNoE836BHJLdkn+F9pgBwUjONJolvFwKE+KOYBczUN9uGzOlz1MvOCrPlBm4FN/FTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893431; c=relaxed/simple;
	bh=nR2NGgnoSO2e2cqedVwvp+9ffYat37por2Pc3FEwQSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C068rfq59auJnrSION9N9bGhEGXLKxTYW8pEKg6LwmDIzp1VLFsmjlwYAFz3JE+yDMB1hohkkHZULM+MFyHPwt5DPCJ/dkc3BkfeDrYCKXvnacLpGiz/GhZrJqtThrLAWF2hb9i5edNdnEzxl/57eG2QPZB1rrmVhPNXcLPw9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7ogIpGT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7ogIpGT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVqsYNxvxH4gglTruj2hqXBkW0j7nkdtxj7CnZ4x+PU=;
	b=Y7ogIpGTEYdzlwPARvlTWQZ9aVJkfPYE6qzq0Q8X/P1ZLOIQGZ18QHjEOu9jG7utHLfIWt
	ii1HE8gkwUM9vv000pvLTDajoSkIivC38aWQYNTIaUNk1WbWsadZU57zNvwDt3mhXG0zJc
	7k0gY+gVQeYvUCkeTxznVK3v2d+MdTU=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	wangrui@loongson.cn,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/14] klp-build: Add LoongArch syscall patching macro
Date: Fri, 24 Jul 2026 19:41:19 +0800
Message-ID: <20260724114128.31451-7-dongtai.guo@linux.dev>
In-Reply-To: <20260724114128.31451-1-dongtai.guo@linux.dev>
References: <20260724114128.31451-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add LoongArch support for KLP_SYSCALL_DEFINEx(), mirroring the generic
__SYSCALL_DEFINEx() pattern from include/linux/syscalls.h.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/linux/livepatch_helpers.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/livepatch_helpers.h b/include/linux/livepatch_helpers.h
index 4b647b83865f..d79e692e382d 100644
--- a/include/linux/livepatch_helpers.h
+++ b/include/linux/livepatch_helpers.h
@@ -91,6 +91,28 @@
 	}								\
 	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+#elif defined(CONFIG_LOONGARCH)
+
+#define __KLP_SYSCALL_DEFINEx(x, name, ...)				\
+	__diag_push();							\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_sys##name))));	\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __attribute__((optimize("-fno-optimize-sibling-calls")))\
+			__se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret = __klp_do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	__diag_pop();							\
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
 #endif
 
 #endif /* _LINUX_LIVEPATCH_HELPERS_H */
-- 
2.53.0

