Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9C38F245
	for <live-patching@vger.kernel.org>; Thu,  2 Apr 2026 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122021; cv=none; b=jkV0EsqH205HTNOQ2QNygq67PPQ6mRURDbYu2MByBNnXk+HUjHWR2SPKdeLrA608YlRyVXrle5ll6thaWzC6QwOyvhgaREGFskXyZK2rRDdThr65Z7qDe87gUsfujBfRkKh9Q1iU592yOLMv3Zmi0I8uecwEYXiqyBJCk/AHVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122021; c=relaxed/simple;
	bh=8qL3h59juOVKtdfVtW9fmnPkaOy3E2k5IewpcRqOTrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxFIpF9Vf6FvRSSqtLMNSJPF9kDESVi3/IPbtLX+hUwWbhemOD4Pt3ram8u/Fc5F6BZEldjbjLnjLWhmdBagYzqqOAHhLv71CRNqNejuHQaFVo3c3smgRqoZUcXM0yFc5sfewwg+keYbrZeWaIjc2deqEmFLT5SlRpfds9ENBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPTcZuwa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPTcZuwa"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso364389a91.1
        for <live-patching@vger.kernel.org>; Thu, 02 Apr 2026 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122011; x=1775726811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n764rmShOBun+KHnL+n7memFmLpzCXWKwyty1boEneI=;
        b=GPTcZuwaQ9dsujgraAxVwHHCifPXrgGVTQfKWBjvaZNkbaWhkb2Q8HTKPwxUcjbCHG
         HUHKYo7aeWIu07KMMVuNTXX8esTE+wTkZ0Ut/Ur5MGHA1rmeG5E7dINFJ211kcyBpnMr
         kAZ0CLlhS67Fy2lGrWoSQXVd+WWr6N4enueijThYCtZSQTvcbEqU61s7Yb2rc46pyrit
         ySnl8LBYj9kuWCZiRunjmmXguhyFu5BirCL/HDAugPDL2ffgvPz3CEyser0L/bK8hTqE
         Xbl2CslJ2sH31NzuUOrm9o2DKi0q+FiCySkuU6+jqmzZdEmGSresbQcRzN/i1VPyVOoX
         E/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122011; x=1775726811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n764rmShOBun+KHnL+n7memFmLpzCXWKwyty1boEneI=;
        b=Ug5TwQxKjW5FtyCSywsJI1o7VvB+JJ1RsfcRvN0FffPZ9Pp065wnDXI6ASovShMY7S
         5LEiVBGtulYmuybqRSPJR88Hb5fpVLhF+7wbClHZk8p88zAQYgbTxmM2zdXVznzU65BQ
         GmLImaccpv0GeX94veBs+wuduUeYMlFE3MDJQ2yjsNdu/qsMpTV6+8D9W3FSkbulz/ax
         hN2FG3Ayh4jbyPslad5CouUbWs6mxVbI/+xd94/c0p8ira1nNrn0vFaG+vbTFlCFU361
         VDZ4vUQekmHya7nTsSXM5wt4crPEJHj1FkjR/Wyb2L/CAn99kdaz98OBiniT6L0Lh1iQ
         kZkQ==
X-Gm-Message-State: AOJu0YwDvepr3IWkueaC4u9R/QWQOamNPuqHRcWvf+fLT4bx7Q7hwuKL
	19vTXoPZHz/W+c4iHr+7aiAtFvcj3wOxbUqIBJ/UZfL1QMljZxxQxKX9
X-Gm-Gg: AeBDietoAb/zlE2in0ojvdsIlZYmdmrl/orz5gBH7Wemal7iF5Z0+2yfpuzl5k4nueI
	7R6C7JFSzPx0Fg2MEscOO00NhEnsF8RRqFGXWNlpwME/M11ZmCYhXlM0V+oMEp789lmViVUI1QI
	T5ghc2jwmcnV2xREk9Tfe0Pc1cvXtT2RKQnB30HijL/29eBN6Xfa6Ld3IElJQwZXr/PPZN7Za47
	0K2WwzP9Ud7REqThVBdPJG8ew7MOIWbai4m70/A94IHuI38sH0QiKgDJmegqUK9N7HhE1Cw36gi
	pHTiCMrZwwMZMlDnfNn7Hbb/QscbkzHJH5aavWem73j1qJ2gTkmTcUBfPztPPj87sepZhCK00kk
	utIZjGw0alqSTOEwmdzIikI/mgJ19rQ7IGFXiC6qQ49JNIs68dCsnF0LQeEIKKdpjKCLn+wC9Cp
	H817dJwKfhPcF6axNxnfUtrOtB5bThKG7VYN+FFwd/4PEQ
X-Received: by 2002:a17:90b:5890:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-35dc7002648mr6149423a91.23.1775122011254;
        Thu, 02 Apr 2026 02:26:51 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 4/4] livepatch: Implement livepatch hybrid mode
Date: Thu,  2 Apr 2026 17:26:07 +0800
Message-ID: <20260402092607.96430-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402092607.96430-1-laoar.shao@gmail.com>
References: <20260402092607.96430-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatching allows for rapid experimentation with new kernel features
without interrupting production workloads. However, static livepatches lack
the flexibility required to tune features based on task-specific attributes,
such as cgroup membership, which is critical in multi-tenant k8s
environments. Furthermore, hardcoding logic into a livepatch prevents
dynamic adjustments based on the runtime environment.

To address this, we propose a hybrid approach using BPF. Our production use
case involves:

1. Deploying a Livepatch function to serve as a stable BPF hook.

2. Utilizing bpf_override_return() to dynamically modify the return value
   of that hook based on the current task's context.

A significant challenge arises when atomic-replace is enabled. In this
mode, deploying a new livepatch changes the target function's address,
forcing a re-attachment of the BPF program. This re-attachment latency is
unacceptable in critical paths, such as those handling networking policies.

To solve this, we introduce a hybrid livepatch mode that allows specific
patches to remain non-replaceable, ensuring the function address remains
stable and the BPF program stays attached.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 04f9e84f114f..5a44154131c8 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -665,6 +665,8 @@ static int klp_add_nops(struct klp_patch *patch)
 		klp_for_each_object(old_patch, old_obj) {
 			int err;
 
+			if (!old_patch->replaceable)
+				continue;
 			err = klp_add_object_nops(patch, old_obj);
 			if (err)
 				return err;
@@ -837,6 +839,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 	klp_for_each_patch_safe(old_patch, tmp_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (!old_patch->replaceable)
+			continue;
 		klp_free_patch_async(old_patch);
 	}
 }
@@ -1239,6 +1243,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
 		if (old_patch == new_patch)
 			return;
 
+		if (!old_patch->replaceable)
+			continue;
 		old_patch->enabled = false;
 		klp_unpatch_objects(old_patch);
 	}
-- 
2.47.3

