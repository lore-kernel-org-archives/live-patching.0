Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717930;
	b=d7t202l3ExwDyPp81ivSSIRtz6TTA2PaHA/pI2M7a4qcoUuSSQ3JBXsswKKLHiWVhE4y
	 cE3lDMDFp0QsHJh4SSvf/HJJlE76dA2mklFlcQGW7RH41zglknwE16Onubg2pc+kh/znX
	 WO8Fp6L78lzATDLRMZQo40f3q96/+4atgeUQ+Pb+Wn/36On2+TY3n24ln0d7fT5eCe/AH
	 nCumNzeJMuzF4OMUyTbWeaEsiO/s7mBvgq/RBELGpaVjBgHAZ46wqOm/GiATTM9haoGDB
	 jnnHS8hxgTnJgnd0br9DTJdrEp9kTMGY2DNSsWL6mfbQ76TtKGO6tLxPeN8B1PQ+0fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717930;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D3Pa9aFO7tWcwYOYyS34rsIKfLX+mbRsSMLshhBFNxI=;
	b=tQCDkMuqmnqvKDi+nKuvtg9iP2IpPgQPU3bsx/HlvT0+kQb+DFqDNSU49qGveW+eoKZ6
	 5F4R/aa3lEY7ibFEZDhPV7yB6lsIq4I0kAY3fwXEmNSfe9Aoc5WflTy8SrszTNggUEmTy
	 6CDyCZ/d+om41/oTYEU1J5Zw9TvaFMl7gqocIua/sFNUIJBp4L83UBtqD+AqhDQsoAB2e
	 zDRtgSfkf4kpeBRRV4rgH6jDDwYuL9C+MZ/AV8fKohVkLl+ARgKtVSooBWMaDzVky2HXZ
	 tFMmXYmM/DJ8a6vwIFneiDGCu4xUJ0j6BGskn2No/w8JxfiwDBwpmzGsmbT5L2sA1fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hemMtbkZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E0606A319;
	Fri, 23 Oct 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hemMtbkZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099971F01825;
	Fri, 23 Oct 2026 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792717930;
	bh=D3Pa9aFO7tWcwYOYyS34rsIKfLX+mbRsSMLshhBFNxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hemMtbkZKcekpiVpC2V678tQn1YEXRGODa3Awp89/0tA1m8JwCmFcEqmQ0wi+Qo7R
	 gp5ZkZDypweuZhnkKfF5ZkR0vgqEl5B3xWtktKsMe9FDL9yNB1pTQwFXF/HMFpHpvc
	 ioYPupL47NsYlkkmHb2cy2Lv887qSg8AOSSPmbgRpzvDxczGHnqdy+iXbEuIAYbBNf
	 IcMHHEmAD0NReMAQNE43sgXXJpbJq4w6OV3Z26R21zvXOodicjlUYox99zEkWoD7z3
	 iAV9DBDvorXupBGwHaxS8zjaO7uH6Yb+a/fC5wCDiUhB1W1zKZrGcf7hX1ES5asfQV
	 IaysGUcQQB+Ag==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 14/16] kallsyms: Mark the kernel text address checks notrace
Date: Thu, 22 Oct 2026 18:10:47 -0700
Message-ID: <20261023011049.1164625-15-song@kernel.org>
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

Commit c0d80ddab899 ("kernel/extable.c: mark core_kernel_text notrace")
made core_kernel_text() notrace, because the MIPS function graph tracer
calls it and tracing it recursed without bound. core_kernel_text()
calls is_kernel_text() and is_kernel_inittext(), and is_kernel_text()
calls __is_kernel_text(). These are plain inline functions, so an
out-of-line copy of any of them is untraced only because inline implies
notrace.

Mark them notrace explicitly. No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 include/asm-generic/sections.h | 4 ++--
 include/linux/kallsyms.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 0755bc39b0d8..d478ddc02316 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -193,7 +193,7 @@ static inline bool is_kernel_ro_after_init(unsigned long addr)
  *
  * Returns: true if the address is located in .init.text, false otherwise.
  */
-static inline bool is_kernel_inittext(unsigned long addr)
+static inline bool notrace is_kernel_inittext(unsigned long addr)
 {
 	return addr >= (unsigned long)_sinittext &&
 	       addr < (unsigned long)_einittext;
@@ -208,7 +208,7 @@ static inline bool is_kernel_inittext(unsigned long addr)
  * Returns: true if the address is located in .text, false otherwise.
  * Note: an internal helper, only check the range of _stext to _etext.
  */
-static inline bool __is_kernel_text(unsigned long addr)
+static inline bool notrace __is_kernel_text(unsigned long addr)
 {
 	return addr >= (unsigned long)_stext &&
 	       addr < (unsigned long)_etext;
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d5dd54c53ace..93c830b35aeb 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,7 +24,7 @@
 struct cred;
 struct module;
 
-static inline int is_kernel_text(unsigned long addr)
+static inline int notrace is_kernel_text(unsigned long addr)
 {
 	if (__is_kernel_text(addr))
 		return 1;
-- 
2.53.0-Meta

