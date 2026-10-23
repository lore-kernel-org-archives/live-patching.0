Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717935;
	b=KE9f4lA/KqGKWB3NvsSNWSgPlBV1rf2WhEBNQ0WxaSkwRLw1guJGKc0j71TLCjo7zDGF
	 sZZTUkmVCZlVj0k5ctEaaeKRr8XU4qBmAyq22CjPAhvGT2NKlUBbvl45XjXO5ty7tIJ4H
	 xREP1RZuqjJ/CTmBADvugFgJVrotozscUwyTk2jbNlyGuW9mFX0u58zj4u0/mRlUC4g5W
	 7l4wuGzqGQLuxh7Rw1++ncTY/V1gaptmxQWkDPq26XAFZI4+kyDUqYyTPZeIT8npmgEKF
	 bkGQR5CbPZLeQQ2GKUWhaMhpuwicedJ6+oInhkms0bVpiKlVduoP5K5y3Ld6iTwrXZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KJB9Vb+rWSFRZbQOYbJh2PfJHgIxuhYyTe485XUOck8=;
	b=Ak1j22csXlKofFIEGyAJn0j2KaIBYXRGRBuhVuWNSnjnlJAlque6pdNW6Z5oM8TTYC5R
	 AdJzZqqWyGG+G0p6Tf8TKiBrZQgR5uyvzlbD+2d5gtm4bpafrtEtoj2Xo0J8KzhfUWRGg
	 XSfgEdoxrs8kpli1L77SJ4JnxnyoBwXOwtwRgnN9egY24S2AdwOBLPslGEB/vob4kIzhF
	 XiA/x4j0q1nIJZwkORHhzNxZnIjf6eAP3vfYdIm+Lnl/fCNHVqzI5LqPvuCGKGVCASX8d
	 o7z62Y5alyxL5LMmQoeuUO8IfVEKtyPHS1BjnNfOO1654bX4Cqyag5iv1UE+FsRR62g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atCmbhEJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E0606A31E;
	Fri, 23 Oct 2026 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atCmbhEJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F451F031E3;
	Fri, 23 Oct 2026 01:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717935;
	bh=KJB9Vb+rWSFRZbQOYbJh2PfJHgIxuhYyTe485XUOck8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=atCmbhEJoEHLxDDW/lNC1oDiWkg/w0hXYV7HZq7m5htxqXU+SRO7BPt47VyejlXKH
	 VVvoYCknnD6SnP257eIUw5pKFGxuRO0JfoVXfi7Oe3N+VPc2wdLGUHjlhCK0zSP6z2
	 hx1smEitrX0Qjz/qap3qTHYfhO2kl55b5bm1XLC9uqa7fXIvNgOF1ITKXvPweCIVv3
	 GRVJ7JZylhiLL9Afrps9CzAJFFQqz0nkXgKqynlMkORdDuuIalTzJS9movTwGArx8x
	 uI8AYZKdQLLXgD/UginVMhdNEmrGaRyhbUOn4HiAIbYvoRQ/CK+ovY9Uc8oN+XhlNO
	 6P7FeFqkqYRGg==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 15/16] uaccess: Mark pagefault_disable() and pagefault_enable() notrace
Date: Thu, 22 Oct 2026 18:10:48 -0700
Message-ID: <20261023011049.1164625-16-song@kernel.org>
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

copy_to_kernel_nofault() and copy_to_user_nofault() are declared
notrace in <linux/uaccess.h>. They call pagefault_disable() and
pagefault_enable(), which are plain inline functions, so an out-of-line
copy is untraced only because inline implies notrace.

Mark them notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index eddbbb65ccc4..ee4966ba9c1e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -260,7 +260,7 @@ static __always_inline void pagefault_disabled_dec(void)
  * User access methods will not sleep when called from a pagefault_disabled()
  * environment.
  */
-static inline void pagefault_disable(void)
+static inline void notrace pagefault_disable(void)
 {
 	pagefault_disabled_inc();
 	/*
@@ -270,7 +270,7 @@ static inline void pagefault_disable(void)
 	barrier();
 }
 
-static inline void pagefault_enable(void)
+static inline void notrace pagefault_enable(void)
 {
 	/*
 	 * make sure to issue those last loads/stores before enabling
-- 
2.53.0-Meta

