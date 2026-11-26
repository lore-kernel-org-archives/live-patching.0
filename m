Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678132;
	b=r8eFND2J4WNk9bBTJzNEQQ1wA/6USGsv6197LXz6e6c4ejl5gSZT6VpIWxc3q2cqHF9Y
	 h2sQRa4R3JZ1GWBTVLlRX0zNOFG2YqZgn+RmS155ac7m3co3LBR2SBHkng3uqJQ4KiILw
	 eNwjghlwdnOoVBTJM+iMDs8DykcvHqG90LIFtsLNYxV9IDhxTyxR5g/5CCIkA0BYntJmw
	 dSJpwhHsx7PRIRiS1h6theVSc4L/mFygDgX00YcZdidIgf5iXC66TO9SIzNPVa8MJSTwJ
	 7Tj+mpCzJ5Xqw0JRwIZATmU48Z7S6CKB68GXBAS0qSRnRIGbUymC5oIOW2U6Ule2rtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KZKygLtlmz59V0N/w8QgV02xDSy1geGC9X9NAkNdFK4=;
	b=hLRPX5TR5zWXTmfce+z2wIiFY9ZNFZ2O+fQ7XPY+aJ4l7lqOrVVjO113FA/eh48gwiFP
	 JKmZiUe+DqHZc02EPjqgNFzCza2cbJpf138OeaF2NebcvJr3JVzi0hgTmRJ93otu2pjAW
	 iOsBhhmGJcC2j5klS+uDhRWaHOvb1AjtdlaYmviwz3NXZ+ANkv7swj9ShyTRvxd9Y7i2l
	 tdTRMPMyCigQhCXAh0guEkhVMrq2DY19tL6Z1igK4eWF748w5nGoHjFmOcXCSojBWGc5t
	 SfpAtFD5bmJPDcCv9mpouztMuVwFXLyZdVK2C4UtB7hTXzNkBKmbVO39BddMOwtkYkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFgmHnLm;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD3606A68D
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 07:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AD3606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFgmHnLm
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc147d86bebso4138105a12.0
        for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 23:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795678132; x=1796282932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZKygLtlmz59V0N/w8QgV02xDSy1geGC9X9NAkNdFK4=;
        b=GFgmHnLmfMJ1MurIwtUyStcXNbBxaay9FhNRu2cCQxlfuwVcg+iCgKT0j30xEnqCfl
         /D8ASl/eUU9Isb1cCifU2oIvTYcltcV6Teuqx2JzpZHRNXr+snvloG4dI7/fcN/EglaK
         My5lThhnIW/KWLntGkgfEBwReR2/vcBgX2aybtUQe1zEt9qDH9J33jjXB1ynd4JMxXXq
         YACDQW0iHL6F8LjnabN5qOr7Xw/RCDtWVq1d/pSQ2dZM6WaO8RJySzYpLh5wuGySC7mn
         7Pk5YQR3mSKdCoqJUtvdOiLGSWZYfUsETm/BaJ1Z7nAFjgnVTljShhyKB/nOCQZmbIBq
         M68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795678132; x=1796282932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZKygLtlmz59V0N/w8QgV02xDSy1geGC9X9NAkNdFK4=;
        b=Hq/L8y5yuzLG3Khz6ebER9fBgrlpWmjiCoclhTfjarTyP2MmbEsa4Cxf3J4juCA+Cj
         OGE2gw2oAHZrJkAxIBHFoWfdMvasPYFSq2mwPbpN/1827rArwombzFtK3A/YTfrpP2Jz
         FjxW7Bac1gLEsmuqh7ySFIMFOO1feUiV55lF4gif84MTzmQA2i85uZkesFOoyWE9RYd7
         99WtzotgeOSXSuXkNT47i5qH6IhB0oIBH8Bro1Ce4HWruWCKvtRXSijC8ZcqsT8KA0Om
         t2jk6qx+kKyXAlQ88XAQfabTL4BLZ3KOcLne/SsNotc3Goq7cQ5FUnkTeqnHt4vMP5GD
         x7Dg==
X-Gm-Message-State: APuU4Z8D/s3LKAG/aMoGfCICHJdNd9oIkoVx07VITpuWjGhFcUfAwoQm
	06AmYZv4gBylFLPPkwljbmA4dFuQKiIJmtsAg6JJVmPGOD6qWw5YTLbvB2P8sGkl8ig=
X-Gm-Gg: AZFdTZfA/xGrrI0Uh+Pl8vYM0n9FP/IM45a7x7ogBAQClFQ72lOkKW7HnycGNbn0LUp
	08YVjxTOdxccm6JgSmnc2/TNjZD662Jb8o/XIvf8JWVp0Ie+jFFIP9xaqUGzceR9RpfAiZko6QL
	UYLcrg88w5VnhzaiQSqcz+JAZj/sEy4DoVTlY1NFmZ1L+2LDQn2O1ygywQjyTcsABO/5DwrqZg9
	SA2W7Bk8fjMhbZMx4qhZpKnAJUwNhrdEcPcX7jhsdYXb8NarekaCubM0q555UQd+2sCtJceFBY+
	LRuamVjmFXRfXF6xWl8luB3Jh0zwXOKPzLzK3NNVfbYHMf3x8wr+BkU22ElFgO9wp+B20PZjqoR
	tOeAE13n6fg0cRwcQY0rByiS3asfOcR/SIvpqOATEPZAuw3RC5cTGa1/p+4s7pbEBxTVDZSnuJX
	NxvMUTxBew1AHjcV+LeiuLZvYiRBpxuvGmLCJ046CX2yZNYjzmhfwJuMOTDU1E4iMmBsk8OFtgy
	ANyRdRCarQMxRwdiE/J9jEe5WVlyk6O3pdtonknzOTR/EjEc0JQmH3E99eknDZiRacVjIJbVgW6
	Tkuys61H5bJYWHu0AHkolM/XeQok79r3+PKsdHCQjIPXWdnsKXbTQF+miZX7CfrafelfihmBtha
	mKypUaFgYWAWeuGc6rxTyVg==
X-Received: by 2002:a17:90b:4d89:b0:3b5:29e:11aa with SMTP id 98e67ed59e1d1-3b5029e14b7mr1558186a91.43.1795678131781;
        Wed, 25 Nov 2026 23:28:51 -0800 (PST)
Received: from localhost.localdomain ([240e:46d:2300:827:b108:4552:5e9:4319])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm14772112a91.0.2026.11.25.23.28.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 23:28:51 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/2] livepatch: Protect the per-CPU stack buffer in klp_check_stack()
Date: Thu, 26 Nov 2026 15:28:28 +0800
Message-ID: <20261126072829.97792-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126072829.97792-1-laoar.shao@gmail.com>
References: <20261126072829.97792-1-laoar.shao@gmail.com>
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

klp_check_stack() stores the unwound stack into a per-CPU buffer and
requires preemption to be disabled. It currently relies on the caller for
that. However, on PREEMPT_RT even read_lock(&tasklist_lock) is a sleeping
lock. Therefore, we must disable preempt explicitly in klp_check_stack().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/live-patching/sashiko-outbox-228569@kernel.org/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/transition.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..4739fc170f48 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -253,17 +253,27 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
  */
 static int klp_check_stack(struct task_struct *task, const char **oldname)
 {
-	unsigned long *entries = this_cpu_ptr(klp_stack_entries);
+	unsigned long *entries;
 	struct klp_object *obj;
 	struct klp_func *func;
-	int ret, nr_entries;
+	int nr_entries;
+	int ret = 0;
 
-	/* Protect 'klp_stack_entries' */
-	lockdep_assert_preemption_disabled();
+	/*
+	 * The unwound stack is stored in a per-CPU buffer, so preemption
+	 * must be disabled.  Do not rely on the callers for that: on
+	 * PREEMPT_RT even read_lock(&tasklist_lock) is a sleeping lock.
+	 * When called via task_call_func(), this is nested inside its
+	 * raw spinlock and is a no-op.
+	 */
+	preempt_disable();
+	entries = this_cpu_ptr(klp_stack_entries);
 
 	ret = stack_trace_save_tsk_reliable(task, entries, MAX_STACK_ENTRIES);
-	if (ret < 0)
-		return -EINVAL;
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 	nr_entries = ret;
 
 	klp_for_each_object(klp_transition_patch, obj) {
@@ -273,12 +283,16 @@ static int klp_check_stack(struct task_struct *task, const char **oldname)
 			ret = klp_check_stack_func(func, entries, nr_entries);
 			if (ret) {
 				*oldname = func->old_name;
-				return -EADDRINUSE;
+				ret = -EADDRINUSE;
+				goto out;
 			}
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	preempt_enable();
+	return ret;
 }
 
 static int klp_check_and_switch_task(struct task_struct *task, void *arg)
-- 
2.52.0

