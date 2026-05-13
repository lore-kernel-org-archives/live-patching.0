Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FFB3A7F50;
	Wed, 13 May 2026 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643285; cv=none; b=ERXRIY7rLCEkY2VQMkh20w9Ft7Bpmo9o8tgRPE2r6AvQ4wV7k+gh4npLSbBK1C8BhZ8zHS57NIG4nHwj/96iVZ34ePH4/H/6FWWpVLWWBeGbuBj4DYUPv83pjZC+9355HqWjGQD2XE3NWUrTtcrawBXeIOWKnkIjnoTwOVFA6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643285; c=relaxed/simple;
	bh=E5kQ00UQ2Ef71S/+LIcd2TddRuEa4D5lUI9w03xK5Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drk2eyQFl5Z8+njjOpvynS3azmzS6S96nqt5bpEH5XXRRGLanWA/au8diw1HtS3f8Xm8qcd6v/n6O4D/ql+hKD1oGQdXtsBDcZ2pht4qzl9afhm7/cv67UCOWhzNFwcqe258gGQ56+Y3qMjiin/GOwtITj4MXvcFw2FsqXXq3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEvEM9lp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEvEM9lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736F2C4AF15;
	Wed, 13 May 2026 03:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643285;
	bh=E5kQ00UQ2Ef71S/+LIcd2TddRuEa4D5lUI9w03xK5Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEvEM9lpAyNZOj1YJaY8R0CkMDWr0K6JsWqRGdXyGYF7QgGzischLDs79PKxdLeBU
	 BoENZDTVug+uDHJBYgM2J64TiNzyuokjyqpSSrlFeQjEPWcREDOlNv2olNyJbVZsbg
	 hS4vj8Q6y7UMTNU5XgP6bbRjDwOJ6d5Rv81YnssaHKAUzltD3qwCh4MtyZtfxCHeki
	 cu75wQw6cyaPkAOrmAauk1TKa+xgLAB4qwbgmZCndrArp4fAxpKl0JC/SBd826v+p1
	 N/dy0mSPSsCG/W6DvE7GOu6ACmfNQLJL3u9tjL0PAPWKFbm6au6R/YppInMWlRW9SD
	 KnorWSwo8nSSg==
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
Date: Tue, 12 May 2026 20:33:57 -0700
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
Message-ID: <20260513033357.ypxHvU6nY3gMiQ_n9snp-o3YDN5uaLc7oMV_UEvDxZE@z>

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

