Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54275364EB6;
	Sat,  8 Aug 2026 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231098; cv=none; b=VHGLmRcNkdpkVMacHQkOL2wFAfKB5kREPVKvC3YG8YAaAqbyiHcoIq6l7HcpzvKclDwlm1b3Vhm/h6rQ0097S4BtisImFDu7frKEmbT4lBpRoNnrNVM3BrcosNNCxjwZeuSQp29R1d4rGwifZSI2YLEE72MoMEkhcoxLGY04rr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231098; c=relaxed/simple;
	bh=RFcyjU6mCgm5h4w8Xta0i3O9cf9VoVPz/NERv5dcxwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir79Iifs4TL6lzpFy8XoWdffCcgZuEAdHKQmFXQvqAcBzTedxRa7NvIQSFjIC+xlmiMFPiCwlrnHFBphLvdpiIPVosj7DHgot1HIMFrQIpAh19ZxPfn3fPFNvuyuzMgF8S4baw8zLKCh/VR8xBtNXYZcgXjuwXIliYAFk2T6SCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS5JcHGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS5JcHGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769DC1F00A3A;
	Sat,  8 Aug 2026 23:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231097;
	bh=oyozvoBnjvSrjbOXhKp9IQG5F3ojaiPlP82IjEqib/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IS5JcHGdxxKfN7iks17rbx3r/JWSLEtBi45P786gDtjuKue1BGcRHzuIVpwlRMVMx
	 5HiUi8xZg3g6yPKzBvkJBemUv79cPcqWGxZhOKuDiaIKTH6FlN2sEInJ/sZvkuy5hL
	 K5eGEoncdXqi+eIKmquGRsCfELrPPIl8nsfdpFm3OskfT1qmLm0kHoEtzMcXLBDFZk
	 sVc5sgyRpqtWUod7T0BrJMOD3zBPlxWA7S5F9SMCXlf1cKjYTmEGLOU65NCycsdYcH
	 P4k3pUi55LSO3O5UT+dKKPVzFydTNyrK0PhQKPEDqllCOG3x/3ttdhuvq646cEhJFA
	 NDklV1Pz+ai2g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 02/22] klp-build: Reject patches to init/*.c
Date: Sat,  8 Aug 2026 16:17:06 -0700
Message-ID: <35e3cba998d143183562f76ec47d159e31424146.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init/Makefile hard-codes -fno-function-sections and -fno-data-sections,
overriding the klp-build flags needed for patch generation.

Don't allow any changes to those files; being init code they aren't
really patchable anyway.

Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f67..b311f290b1406 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -365,7 +365,7 @@ check_unsupported_patches() {
 
 		for file in "${files[@]}"; do
 			case "$file" in
-				lib/*|*/vdso/*|*/realmode/rm/*|*.S)
+				lib/*|*/vdso/*|*/realmode/rm/*|init/*|*.S)
 					die "${patch}: unsupported patch to $file"
 					;;
 			esac
-- 
2.54.0

