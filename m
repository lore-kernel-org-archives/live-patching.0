Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CE390616;
	Wed, 13 May 2026 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643271; cv=none; b=mjygwBLwBgVsS620CjjjKldQEohHQ79eyUD/mDI9GTfAGQg+Yp73Bf1tsmsO1bSFoKFgdiRQcjtMNxT5ARsJugO/YH2+OqkvcoaccRDL5xoO06Qo273QFnrEFglHRzdnMWIAF71MER4lU+cmR4M4jkykdkyLLCNYpE9g+WH77WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643271; c=relaxed/simple;
	bh=E5kQ00UQ2Ef71S/+LIcd2TddRuEa4D5lUI9w03xK5Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojK8WakfMMu+72FI2n5d8CWgIjJH8JlShaeU73NNWQYnsWxIdGiE7/bUhFvY81+0rNtotmVOQLX5KxlWmNXh2DduIufydNeN7UdWY9EXBPntI0l3ESOvDvJuFeQKfc90F44QC0qhvmr8rpLeydaBYU+ccR1FZi2i3SmOe+WZ48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb4B3Nvx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb4B3Nvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6DCC2BCFB;
	Wed, 13 May 2026 03:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643270;
	bh=E5kQ00UQ2Ef71S/+LIcd2TddRuEa4D5lUI9w03xK5Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gb4B3NvxEeWQBQYex2qIVG/q07IFXxq/Ros9VwBboVprvxZ6nDJDx7QNaRYLvC2ft
	 yarGDNnD9uaTUycsy5iTkPGVEZOdoawaSXf3k4jl3Hro4heOf+ea6ABz8LDwRZIP8/
	 cP7+jm0oj7OT19OQqVSQpX4ad/2/McPhwFK5AhXJBvbf4iO+rAZMF2SUcbbrz4RjzE
	 2eFaGH7bKs1L1SR7i2RGRkuEudBnbXIE0to9UNE26Q5ysEH9fbDI3zj20zzkytrs+t
	 X0l8RuZm0NFwYptJG/sl5zJppSQ8D5ZeW5C3FIDggl6c7POM9DcbuIQ8xYpzhmN3Hv
	 dSx9ZgzqNuLrA==
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
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 01/21] klp-build: Reject patches to init/*.c
Date: Tue, 12 May 2026 20:33:35 -0700
Message-ID: <f32864b560d40894cdb70d613480d7c2ecdb55e0.1778642120.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
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

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index c4a7acf8edc3f..911ada05673c2 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -362,7 +362,7 @@ check_unsupported_patches() {
 
 		for file in "${files[@]}"; do
 			case "$file" in
-				lib/*|*/vdso/*|*/realmode/rm/*|*.S)
+				lib/*|*/vdso/*|*/realmode/rm/*|init/*|*.S)
 					die "${patch}: unsupported patch to $file"
 					;;
 			esac
-- 
2.53.0

