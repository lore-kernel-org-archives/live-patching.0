Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF752F3632
	for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787465263; cv=none; b=cfx/VdGozcQoCHIFAGjeUFoNBIh3Z0/3BOjhhQWDwFNVosOajumfaYCfIs+WWWcKS8ftsmjGtkz8p3PAYiNcny7TKWWjuEYCK82oy8fEOCsHUm/q/yZzxGJGZXgDcacybq/xw4HOxQoLM0T9JZDLJvrACbzuwlfv2Rhw9DI+FeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787465263; c=relaxed/simple;
	bh=Aict32JxsG+xN20KXZ4+eGbazxup7Ht/42ye8xw1z0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhplidTvVVLiBIX93cltR6uahQ5UEecHQjgQPw5ORLnPQG1YkVJZQaKWRkOSB8yef7NdXCdkdyiJcYeTJEtTl03dsJMQrF9NkeImsCOKoiHQpcFwrocm8odBzvhciYcnC9TxhP4N8J1TWwD8C/GovEu//RPfdpIK1QkTeu383sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxMGbPTq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxMGbPTq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3268442b3a.1
        for <live-patching@vger.kernel.org>; Sat, 22 Aug 2026 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787465261; x=1788070061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TGtr99oRXQabMTcRjnuVAHCf7ojLORqpGOxFBHhRHHM=;
        b=JxMGbPTqRT0PTEuSH3kbSKQyBCL5cNdwovYg12MShBG/Xv8BjV1OtaNPRyZ9Pz9lqt
         7myNUWE846pI4SnLMxz1GFP4pOFkqeWIFzaNZRUXXAlMTzyQMPnUb2lHeO3j6Oi/V3uD
         SljGge3NE0HKprz/1DgnpDIYz32lsxdzNnGV7ddOD4YV+bRMoNK4qtob6uJRlRFo+fTa
         se0VfYEvwRUq42pdBWcQJL6uKPXuYNOLgHkxEUswrq9OxHUSoek4kyXB+7yjtzOaKidr
         8sb3RI2BtKbKxCM7RYYSZqN+OYIVlLl+jvYT9okSprvEI7hhW+uTwtxcWNiLYEvmtm15
         K2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787465261; x=1788070061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TGtr99oRXQabMTcRjnuVAHCf7ojLORqpGOxFBHhRHHM=;
        b=jtGdGJ0bTh8Q+KijYwRWaxXNCamkseuRjVWn+DjTQNC4DTE4uhd+3L3k9oGmG9RXxj
         soxr3zEBnuHMFyjujfRTny2f/+hSzuev4fxsUNtJ0GnzF0R86aclfrqHmX2HV9DAkuH3
         /RQ2s9c3nmRPdRg+gUo8sRmeJkF+yKQfQtBKFVWOmz6cpktOOvRqu9LNAs6K0B8ynbrP
         Iw30eRbBhARu520/11Dgab0qm+2s4FIp6TxUw44PL+69wJSVKqVxYGtl1SATSD0/0i8u
         nZMF6jyRabDwp4LjDKmahjWM2c3alrdhpg3n2Hzl38yE5zFXZSJCOr4oFnSz1RTBqqw8
         Q87A==
X-Forwarded-Encrypted: i=1; AHgh+RofFg0Aa9OwnAPydY/16W0epVjiTypmZomjbBQhikLxKRzDb6A3ZGEdFfI/fVdroU+zyZFpEIzTp6wN750u@vger.kernel.org
X-Gm-Message-State: AFuF++lQb5BuizjTRnEOPegzJRmjU0gsH91pKAq6TWEvWW34cvZGzD/G
	n/eXnwc9MCMC6imC/FJFneD6mb6T/e+oB/ZYlKK72JBkiJF0owA/SRi4
X-Gm-Gg: AR+sD13R+piG3IigA1HMyIegkOLJbpjhIAN53TI2d9CiUpVWpiJ+/24UL+nXYBjEA5y
	+4I5zuZLLr4NzD2exkr/2KQwOFEYgBXygDJIlq3vUeqclzUZMubXbpjRHtxyn3m5Ts9/L3VzHeC
	EveEGaIR0ipI/GTfcayY7e7G0z8lYWPFUPU8Ouz0pte6XXUF5E04rOfO8m/nOUu2eXVXRkF7a4+
	qxzSygnXxpWdscD/CN5Ql7eUnw7DIyr993gYBz7vYMbt+mIhY2+KYxbACuFO0HG25UYOBS8PdJn
	VvFF5lvIMRj0Fxy9qDif8z/yOTEsu0kaXm34I/R41lhg1r/TGHOnHhNn5Y0znfsCb4gxmYURmpl
	OzIOM82/gog+Y7ofl5LiCFCdlx/0CxTtevo7K2ZZWD2JkhZixfp0gwMDqtOeAYuSXsy6Zb6jKn9
	3rbYIu4Qt5esC+L112ikCJ6kqo3jlcEzyRjmA0ED4nhHhD+HTlhUESiXecJO7uNM2vAu+m9RslN
	IQKAAkkFwuorl9wL4+kPnUWio+301BV
X-Received: by 2002:a05:6a00:a589:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-851f9efcc14mr28246865b3a.7.1787465260946;
        Sat, 22 Aug 2026 23:07:40 -0700 (PDT)
Received: from Harrys-Laptop.hitronhub.home ([2407:4d00:6c05:13e8:edcf:d188:51c8:54cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef0c76fsm1020878b3a.18.2026.08.22.23.07.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 23:07:40 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harry Hsu <x90613@gmail.com>
Subject: [PATCH v2] livepatch: Reject livepatches with aliased old_func
Date: Sun, 23 Aug 2026 14:07:34 +0800
Message-ID: <20260823060734.58443-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several symbols can share one address:

  ffffffff8ed7fef0 t __do_sys_fork
  ffffffff8ed7fef0 T __ia32_sys_fork
  ffffffff8ed7fef0 T __x64_sys_fork

klp_find_ops() looks the ops up by func->old_func, i.e. by address, so
two klp_funcs of the same livepatch naming two of these symbols resolve
to the same klp_ops and are both pushed onto one ops->func_stack.

This breaks the assumption that a single livepatch contributes at most
one entry to any func_stack.  klp_ftrace_handler() picks the entry at
the top of the stack, but when both entries belong to the same livepatch
there is nothing that says which of them should be used in the PATCHED
state, and the UNPATCHED state has to end up at the original function
either way.  klp_check_stack_func() cannot tell them apart either: it
asks whether the preceding entry is the original function or another
livepatch's replacement, and an aliased sibling is neither.

Patching two aliases of one function from a single livepatch was never
meaningful, so reject it while the object is being initialized rather
than leave the redirection undefined.  Compare the resolved old_func of
each klp_func against the ones already resolved for the same klp_object
and return -EINVAL on a match, naming both symbols so that the offending
pair can be found in the livepatch source.

Fixes: 3c33f5b99d68 ("livepatch: support for repatching a function")
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Harry Hsu <x90613@gmail.com>
---
v2:
  - Drop the klp_check_stack_func() change.  As Petr pointed out, using
    list_is_last() only made the last entry behave, still checked the
    aliased sibling's range for the other entries, and did nothing about
    klp_ftrace_handler() being unable to pick between them.  Reject the
    livepatch in klp_init_object_loaded() instead, as suggested.
  - Rewrite the changelog around rejecting the configuration rather than
    around the out-of-bounds read that v1 described.

Link: https://lore.kernel.org/all/20260812140232.48079-1-x90613@gmail.com/

 kernel/livepatch/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..c35cf08c27c8 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -866,7 +866,7 @@ static void klp_clear_object_relocs(struct klp_patch *patch,
 static int klp_init_object_loaded(struct klp_patch *patch,
 				  struct klp_object *obj)
 {
-	struct klp_func *func;
+	struct klp_func *func, *prev_func;
 	int ret;
 
 	if (klp_is_module(obj)) {
@@ -888,6 +888,21 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		if (ret)
 			return ret;
 
+		/*
+		 * Aliased symbols share one address, so they would resolve to
+		 * the same klp_ops and stack up on a single ops->func_stack,
+		 * leaving the redirection ambiguous.  Reject the livepatch.
+		 */
+		klp_for_each_func(obj, prev_func) {
+			if (prev_func == func)
+				break;
+			if (prev_func->old_func == func->old_func) {
+				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
+				       prev_func->old_name, func->old_name);
+				return -EINVAL;
+			}
+		}
+
 		ret = kallsyms_lookup_size_offset((unsigned long)func->old_func,
 						  &func->old_size, NULL);
 		if (!ret) {
-- 
2.43.0

