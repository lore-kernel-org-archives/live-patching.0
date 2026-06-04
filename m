Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB93DBD7C
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556227; cv=none; b=coTsSTCZD8EDwDp+NU+0K6+HCZqOJFeEUvUMuWvnovKjfSISZ9Nfh+Db1fYjBO1bh3zZfelprgiOHaiQATLpmcRjdDUe05HcI0cnpkqJlTk+JchmIcEgRisH75qAAPS++wze6GsrpVB1wbaJrxuF8woVWb2rBM+WPWwmKly//RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556227; c=relaxed/simple;
	bh=dydZVhth1y6JE7+fyLmn2w7NHqI4W6Xits7j2exGHig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJkMJ4n56etPWPdTkuudgDXe+cY7tOonoV/b4uZ4cFLd92Nwrs6CfSYc4g76OLzvpll6Y5N+p91/DfOm1/3UndXkZkPyyknijOXAgvFW0Aw9xY+GZ0PbM6MrUvpZIfDHXGUSpHyScRXXrz0aiH/ju8HlbARRc/yzqeLuxpQ3psI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FcbXErjt; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FcbXErjt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K4imcceEzYpUOx6xUchhbO3GzKewULjWdUSxLezYq8=;
	b=FcbXErjtlTY6PwY7b3DmaGm946iCHHqA4xODP3txeKerfajc18mAzBEd9Nd86++L5m+r/y
	RvxO+5n1yjYTpd/M4hPs7P5GSklG+evgZW74n4dl7PktQBKl5+Wti4zqEVchk6dDjMWjFQ
	HSzjQISY/riGUyA58zySejFTRHTMHQA=
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
	xry111@xry111.site,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 8/8] klp-build: Add LoongArch syscall patching macro
Date: Thu,  4 Jun 2026 14:53:17 +0800
Message-Id: <20260604065317.219777-9-dongtai.guo@linux.dev>
In-Reply-To: <20260604065317.219777-1-dongtai.guo@linux.dev>
References: <20260604065317.219777-1-dongtai.guo@linux.dev>
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
index 4b647b83865f..a8aad067177b 100644
--- a/include/linux/livepatch_helpers.h
+++ b/include/linux/livepatch_helpers.h
@@ -91,6 +91,28 @@
 	}								\
 	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+#elif defined(CONFIG_LOONGARCH)
+
+#define __KLP_SYSCALL_DEFINEx(x, name, ...)                             \
+	__diag_push();                                                  \
+	__diag_ignore(GCC, 8, "-Wattribute-alias",                      \
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
+		__attribute__((alias(__stringify(__se_sys##name))));    \
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);                        \
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)); \
+	asmlinkage long __attribute__((optimize("-fno-optimize-sibling-calls")))\
+			__se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
+	{                                                               \
+		long ret = __klp_do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);                         \
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));       \
+		return ret;                                             \
+	}                                                               \
+	__diag_pop();                                                   \
+	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
 #endif
 
 #endif /* _LINUX_LIVEPATCH_HELPERS_H */
-- 
2.25.1

