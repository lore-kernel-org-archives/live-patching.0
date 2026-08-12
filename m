Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A94570EE
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543367; cv=none; b=WuCkg1n8HeDy8wIYS+J5I4GARHBogxoPNiqBHxFVneYgHMPIiRIUE14jdxEJu5HmI9PvC/i0v3mkZr4hLK+H0Iika1KxoGic4Us02SFesEJzPeD4cKSuK8yn+WDYcLMcxxnnMBCBbe4/Yqng1OhP8V6roZi8JmNTme9Iji6N3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543367; c=relaxed/simple;
	bh=UOSzdtNbgPVCx3TtzCdxMnWY1v408O57BFcrXhSA6EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mShvfleo+lhdq7CQZXtjKewV/mXMiFTL+/ywJh5v6TE95uQH5BRq4CrIHWXj7wXLBGWUTHow+UF1dIv4nnTDPFexAinpxo2P9sVKSR9HQw6cWmfhYpmQKkh7ZauLwvMi+CHpBn2sxVjNBz+w3QHT+71EiKOslZlct/g9wkDOu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaRuLyFU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaRuLyFU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1469592a91.2
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786543365; x=1787148165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LG+vMzKytWNCEpJSjDGLo6pyjBGi5A+g2ffKcMGYpCw=;
        b=AaRuLyFUg/8svzlp3F4bC1vnqN6W9ySxQZ1P5mtaqs3arOorn7iU6yEl//llwIMTMu
         GvA59qlEc4bzTjE69js+tfOVFqU44BMCgxMFHWzcRLPhb1xypIwsjoitKDRddey3cpkN
         I8Fkydn84xZlnYJ4RNYtLuU9eP25HTLGHNRhqcIzazEDFD3eJ0IcbvkLfod1NsCQZIJP
         eTQkSLfD1sk7WYsl0VI/F+SxegNlhHQM6a68n4dbtUjZweHn5n1GUim3Vek9hWTDvpTV
         Rty8mV/25MlYJSdQwoJU5YRsTf7RM47Hpvp9i3rX7+UYSxQvArL8UVtPNauaH0EDIeRL
         nakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543365; x=1787148165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LG+vMzKytWNCEpJSjDGLo6pyjBGi5A+g2ffKcMGYpCw=;
        b=Gyza90IDJWFfb7Rut/KLz+Oa4IeCIOCii2IkyNUIOMc6QyEaF9wySHbp15cs+4qYA4
         nEOQlyiSc2/CxA8VIqQ7/1Pwf+eCYeqGM1R/GxnFq9CoiPZ0AiiEZmS8yI8JyxDRPv+T
         igV2G73eCRXf/5RF55YzCl+/mYDdZsCfGfbAYjwmYPX2iN+X9dCaOwvR8qIb4syl64xr
         CzpmNB+EOC1k6klj8zpESDfWOwiFhU5NEvgBjQbvxeL4mklaQh0hBzaC+GYdYmNm7LYf
         XTVTWOBK8I/cv3JQMXlbazN8rk76jeJ/7i4osR0InMJG8Alfk1UngOGDcQ1SOau6BQMr
         SQmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr59CE5zzdYNVpgyBeI1XFytWGhSjaFA4hXSglGuhCfv7yLjbuMnIxJ4rYq4dsz0iXCIIrp/qXlAoelWrGo@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0M9czcn3Z6VkfspAreRjkVbw843M28PRcbnOhU8kfvgqh6wg
	ikSB9ermjWK67Nm8Bs96L16zai7TzBe/YJUz3wwidVprn9f1dk95q4la
X-Gm-Gg: AR+sD10Ul3boM6Lh5vGIZwc1CJ+BgNPBYuIGLnxARaf4lglr9DfcyXytNoC2lS////N
	p9gTp8ok2PC2f906rYSEK7/WqXhkhSjc9PkCZesp53z5j1X24hISeNJl8ZYRVLj2fYHqZmkSyNM
	4ihn0VTh42KbFJTr9ostnYNSNvqSDh8aP7ZVNSQ6ZY4ToKlqPNsTEkUqbJHFsOJYLUCtOjNN8lm
	gpTlZJ9YepASbDHhIi+XESMH6obNzNaE5HQE4pW81BNROi/lTAloom51WPnJ9isQcN5pxWK4Z38
	D/SQ1JCsKRzzA/W8EUBU3Dtw60w4G4Rgc5HjT0zTxiLgFF9q66c6iJf1U6Jbr2BjZ+EFWMqfRMS
	0K5ekxKNuRl6GZCuhSMo9nBvr/MQ0bb2rmMn5Gcz9tyObOdLwCAQgiJjHyaHELu1YYrcmURp3Hb
	wH49RtZTstBqgTY8IL55IZpvRju1LjP/6ntx7UXNc3LpKP5aVKwJStepOMya0iKLf+DRambMF4U
	3lBM1H12XfFatSSAeCP5c4uou9mPSBsRqf1qw==
X-Received: by 2002:a17:90b:1d51:b0:38e:6f90:eabd with SMTP id 98e67ed59e1d1-393012026e1mr6198289a91.5.1786543364264;
        Wed, 12 Aug 2026 07:02:44 -0700 (PDT)
Received: from Harrys-Laptop.hitronhub.home ([2407:4d00:6c05:13e8:419e:d4da:8f19:22ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94f9e47sm4004307a91.17.2026.08.12.07.02.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 07:02:43 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harry Hsu <x90613@gmail.com>
Subject: [PATCH] livepatch: Fix stack check for aliased old_func
Date: Wed, 12 Aug 2026 22:02:32 +0800
Message-ID: <20260812140232.48079-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp_check_stack_func() decides which address range to look for on a
task's stack by asking whether the func preceding @func on
ops->func_stack is the original kernel function or another livepatch's
replacement.  It uses list_is_singular(&ops->func_stack), which only
tells "one func on this stack" from "more than one".  That assumes every
klp_func of a patch gets its own func_stack.

Aliases break the assumption.  Several symbols can share one address:

  ffffffff8ed7fef0 t __do_sys_fork
  ffffffff8ed7fef0 T __ia32_sys_fork
  ffffffff8ed7fef0 T __x64_sys_fork

klp_find_ops() looks the ops up by func->old_func, i.e. by address, so
two klp_funcs of the same patch naming two of these symbols resolve to
the same klp_ops and are both pushed onto one func_stack.

The stack is then head -> B -> A.  A is the last node and does
correspond to the original function, but list_is_singular() is false, so
the "previously patched function" branch runs: list_next_entry() applies
container_of() to &ops->func_stack, treating the list head as a struct
klp_func, and reads func_addr/func_size from past the object.  Besides
the out-of-bounds read, the bogus range can keep matching stack entries,
so tasks that are safe to switch get -EAGAIN forever and the transition
never completes.

Test whether @func itself is the last entry instead.  The answer is
derived from @func's position rather than from the list length, so it
holds however many klp_funcs share a func_stack and never steps onto the
list head.  A single-entry stack is still trivially last, so existing
behaviour is unchanged.

Fixes: d83a7cb375ee ("livepatch: change to a per-task consistency model")
Signed-off-by: Harry Hsu <x90613@gmail.com>
---
 kernel/livepatch/transition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..8d6e3a58101f 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -223,7 +223,7 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
 		 */
 		ops = klp_find_ops(func->old_func);
 
-		if (list_is_singular(&ops->func_stack)) {
+		if (list_is_last(&func->stack_node, &ops->func_stack)) {
 			/* original function */
 			func_addr = (unsigned long)func->old_func;
 			func_size = func->old_size;
-- 
2.43.0

