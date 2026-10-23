Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717920;
	b=ouwWutvHd+yv1qFrC8IIBRCw8UaRx1bnJI0OwrfGF7GpoV/urDUHtZ1X+iTjSglqXG89
	 o3fararsRPOX1HkwOXreO6UCueEN9qQkCdjjOBtcHGlpxH42iKeIafh2dwhsgq7/EkFG2
	 WLre7Lk8CmcktD/rJd+xrPJQK3JwrfNsZ6VjR9Y3SocexvtN83W+EtsHNniujUgDnN8l2
	 YGMsBIEn9LXTTszb/ADk2lAWoLmJIbKPzDvP2HYuUdJy68pkcqXlHZZ5pMqAfdtVc1gr8
	 mg1YtGu727Ai0GljvvCU28NReD2PLDtOALtoZAp8tqY+mokRBx5hcGLhyueMZV8NX/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EKRYaK8re9OY8Bm+GKzTSXXhwSwpYRu0gQKt0HR+FfM=;
	b=fsFdFpU525X4ElJ2NCeWlhYVQSoQ35vfOR/W0U5ldMg2Gy4DrfVnCbDyxfw6bIRlHrSV
	 PmyXsgjGLPBPgwgONX7Eq9wl5cZu/IauAawPz+/f99AZrPO5LURHmNsolm3fmENnat2ST
	 IE5uIrS1kzYgQVHCWuyFDqBQrZAcgFBtzgrHyr3gNQghPZiWsJiE4ZtGNsfe01DI0H4Gf
	 a4aZ6uzKKa9jL2K1Wl8RykGRy0XqRg/ijbfHNSvxJasI+BUOf9dPd+Jhr2Llz+K1MazlU
	 TP18XoG5hQr2epfXXt7sjNxGo4BrlamHu9Q0xFJ/cKIZi2AoBHSoWG2qTTJqgQrCAPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkQQqUi5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B11606A31F;
	Fri, 23 Oct 2026 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkQQqUi5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B871D1F01828;
	Fri, 23 Oct 2026 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717919;
	bh=EKRYaK8re9OY8Bm+GKzTSXXhwSwpYRu0gQKt0HR+FfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkQQqUi5VG4GX9NRDow1QtVulOvO2SpECtn9RMG6Oa/v/zTnQ2us7UOvaiW7TJjUo
	 2QmDAQ1jdSkkWKJF68QdShmqGk/h9DDB+L+ckp/fwy8CMzgCUsT52I7aX/wd5cveGY
	 gbaJRaOJbnKlz2CQj+qvbd7mXn1eqyfn7IV1g9FUg5eB/5RX8TdvoMXeE0sGI2G0Ik
	 kk0b7yCotaeBlriiR98PTtOAS5cJ6L9ErByCQwL7u8qmHick3T0HCSMNvCNhhnLjNW
	 2UeAo7A9KYr8THte/b2Y6gQw/2x+Oy7iRDTj07u8fCS4tNKBY0MX2JFyxf5LYZaYhZ
	 b9IL1IpmKMjFg==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 12/16] tracing: Mark the tracing_gen_ctx helpers notrace
Date: Thu, 22 Oct 2026 18:10:45 -0700
Message-ID: <20261023011049.1164625-13-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023011049.1164625-1-song@kernel.org>
References: <20261023011049.1164625-1-song@kernel.org>
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

tracing_gen_ctx(), tracing_gen_ctx_flags() and tracing_gen_ctx_dec()
are called by ftrace callbacks before they take any recursion
protection, for example function_test_events_call() in
kernel/trace/trace_events.c, which is built with -pg when
CONFIG_FUNCTION_SELF_TRACING=y. They are plain inline functions, so an
out-of-line copy is untraced only because inline implies notrace.

Mark them notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/trace_events.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5cbd09c8be8d..15990e23a662 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -197,13 +197,13 @@ enum trace_flag_type {
 	TRACE_FLAG_BH_OFF		= 0x80,
 };
 
-static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+static inline unsigned int notrace tracing_gen_ctx_flags(unsigned long irqflags)
 {
 	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
 		TRACE_FLAG_IRQS_OFF : 0;
 	return tracing_gen_ctx_irq_test(irq_status);
 }
-static inline unsigned int tracing_gen_ctx(void)
+static inline unsigned int notrace tracing_gen_ctx(void)
 {
 	unsigned long irqflags;
 
@@ -211,7 +211,7 @@ static inline unsigned int tracing_gen_ctx(void)
 	return tracing_gen_ctx_flags(irqflags);
 }
 
-static inline unsigned int tracing_gen_ctx_dec(void)
+static inline unsigned int notrace tracing_gen_ctx_dec(void)
 {
 	unsigned int trace_ctx;
 
-- 
2.53.0-Meta

