Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE33D9054;
	Thu, 23 Apr 2026 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917087; cv=none; b=UjzqRi7TPOkRchuXlI/V9NXY2wcfAUWEOCH/ynA+45b/meOW+QqiCyv0cEH41quqNTjarbfovS8FoA1nL4RlWfwVFiw8OzwdTPAabQBz+L3kbXy5Zprh7RztxxX/I17G46bK7IFouVNXZagyoGSIn06tMChd+SRR0Bvz4KlXiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917087; c=relaxed/simple;
	bh=jmH/VKCty/iodGaVUHV5BrqXJdFzVyb8Cmk8zWijg8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEecHfP9qTKvKJDiSMRkhLYlYbYMuzxBXRMBu7RzW/XH8Vcdpg9GtAAOmn8GkhXL03s1hPBOq8+yebk3aF/UahcjQ/kepf/29p4fV9TnIs+2B1M/lUu6Ex5jWmwQFOtPojVhillHQq0Yu6NU1GX98f6A1JgX+mCt/MZnjctpgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsFbKer+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsFbKer+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE20C2BCB2;
	Thu, 23 Apr 2026 04:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917087;
	bh=jmH/VKCty/iodGaVUHV5BrqXJdFzVyb8Cmk8zWijg8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsFbKer+mw5YiGBPTDk47cFunDmnrwF8xmy4Yevn6it73xihNSdI7/IRoHFPjFpbc
	 iU9MieBK5xCg0G9phrOvyVmdgQP9UflP45Z/wVXoYMBuEeD44t+opS/pIcS67X6OZT
	 Z1kW/IIyJVGQSfIrA9oUIgVfi9XXzuCEmIHtBTgOJ84ojq/nb46OxR7ZKK6EK2G4+b
	 TMkdqE0W0H6jcC0/mbQ1lFQpt8kDwEuLnHf0qJ92fXWERviawR9hY/YPURl6KDTQrN
	 GCI9zzplzQh023ILGrg1uXzt8e3VcptGI41bRYQz2OIXYWNngqRGVBXUwNfmxBQUKW
	 k8GqZ0jvPDd4g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 45/48] x86/Kconfig: Enable CONFIG_PREFIX_SYMBOLS for FineIBT
Date: Wed, 22 Apr 2026 21:04:13 -0700
Message-ID: <70107aab81b01f8a2360f052ff550a9e97c30f79.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PREFIX_SYMBOLS has a !CFI dependency because the compiler already
generates __cfi_ prefix symbols for kCFI builds, so objtool-generated
__pfx_ symbols were considered redundant.

However, the __cfi_ symbols only cover the 5-byte kCFI type hash.  With
FUNCTION_CALL_PADDING, there are also 11 bytes of NOP padding between
the hash and the function entry which have no symbol to claim them.

The NOPs can be rewritten with call depth tracking thunks at runtime.
Without a symbol, unwinders and other tools that symbolize code
locations misattribute those bytes.

Remove the !CFI guard so objtool creates __pfx_ symbols for all
CALL_PADDING configs, covering the full padding area regardless of
whether there's also a __cfi_ symbol.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f3f7cb01d69d..493b0038ac8d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2439,7 +2439,7 @@ config CALL_THUNKS
 
 config PREFIX_SYMBOLS
 	def_bool y
-	depends on CALL_PADDING && !CFI
+	depends on CALL_PADDING
 
 menuconfig CPU_MITIGATIONS
 	bool "Mitigations for CPU vulnerabilities"
-- 
2.53.0

