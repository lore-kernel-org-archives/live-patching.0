Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717925;
	b=trhmd34PlIvmLmt5qARYvPU3RalrxXtBMMtaWllqUuMatKPA/Q1QaxJe0vaQ7K5WIjjw
	 lWOq3+m1BiaMri0+0LP88nRE+JBuRbVqgdULnMJYmb1iTGddolz/kfbGOEhqYCYS//sYf
	 VXof0gfVoVv1/UsiqeZm4sWpRZshrwUMSyk4gVL/uESq+PGuwmSPpuej4hnXUKDWjVM14
	 DCb1LCCVOxlcwugXr2QlYzFbtGPtOdyYrYY/hp/VDWIW4cuiMRj9zazFS8qoy8pQ+DDty
	 amppZqCk70i7o3+uUwubnz/478ZCXHuo27vooYWlBw2FL0LvBr36aUOviuh1s5dcohQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0zP+sgWhu1l68weL6bGSxiO1Qiej1KLZ/vMCG+x7e1A=;
	b=4yB4lh+byKnjGMjTooOVZOAq/+L7BEhd5YiJOlK3qFFK4ChcuOcQzKBS+X5cKfsSLd1G
	 N2FN/q5qGPhTqL5YSN5QGiWsvOvNRp3yWL9OB+cmls9LbNc5Up9hJaeFjoOFIUGVKJg7+
	 woNS8bxuPDBm+u22Sghczawt2yA9jObHw4u0yK/HTpKR1B/Jkl2UxSZrHCnqvC4E55Me/
	 vtXxUC8r0gk+9nkqs6g2SJJGYLTlDnUrF94fOGIqjLDNOaf27rDhnhoDS99FAITDZH54q
	 DvQD/zQCitJ1foA6Jja5iXZANqQULX/GNB3/+MAp4AumPr/pZF6ygvlt+LnuHLOaqQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfBQX7Hx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14557606A31F;
	Fri, 23 Oct 2026 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfBQX7Hx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D982F1F01825;
	Fri, 23 Oct 2026 01:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717924;
	bh=0zP+sgWhu1l68weL6bGSxiO1Qiej1KLZ/vMCG+x7e1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lfBQX7Hxzd8gTNOlC3cDsrTlp746gXcAysf+aigjJcflBKKNjktm/M4VhYsFmFOIa
	 3IX2420V4qFfbjQIugDG+dAXai/gkxcobZuAL+sGY4pwmA8lqBklNT1ohh0NfyuJec
	 lbERcu3Hv2W/KVLGRMrRbzjczMWlZbO3+VJ1qrJfd/QmQ07AJzaRNgpJbAMPh7hWj3
	 7lWuMwBSkGl2PT2d8Z+/WJAEo4HJY41a0TjlOmitdVi3ka6FT0YVLmGkiNRvEMGLwE
	 zAroGJYiurVAFl4zeKwiHCm9nSZIYx0pN0P7E08nueHCGt2kTgavL18vc0n5czSq9T
	 tOKmWJNFpEkSg==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 13/16] ktime: Mark ktime_to_ns() notrace
Date: Thu, 22 Oct 2026 18:10:46 -0700
Message-ID: <20261023011049.1164625-14-song@kernel.org>
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

The NMI safe accessors used as trace clocks, such as
ktime_get_mono_fast_ns() and ktime_get_boot_fast_ns(), are notrace and
call ktime_to_ns(). ktime_to_ns() is a plain inline function, so an
out-of-line copy is untraced only because inline implies notrace, and
tracing it would recurse through the trace clock.

Mark it notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/ktime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index f247e564602f..ed56774f68ea 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -75,7 +75,7 @@ static inline ktime_t timespec64_to_ktime(struct timespec64 ts)
 #define ktime_to_timespec64(kt)		ns_to_timespec64((kt))
 
 /* Convert ktime_t to nanoseconds */
-static inline s64 ktime_to_ns(const ktime_t kt)
+static inline s64 notrace ktime_to_ns(const ktime_t kt)
 {
 	return kt;
 }
-- 
2.53.0-Meta

