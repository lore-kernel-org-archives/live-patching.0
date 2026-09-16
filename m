Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A814E50B9
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584291; cv=none; b=AY0b/C7X/qNFh1OiMNFUHYCW/9NWM7TYqsDILUNw8+Y2PJe/MBnsnbQxesxRMgzydfeljt6mjhiLi0bGSwSdsudTXdHSWRWtvGAL2PrmRbjpC7sCXUZOcf9HrjSX/1J8FKKi73aKXrDqN6tfiRv5Q2S6XBmD8ubsPwssxE7vLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584291; c=relaxed/simple;
	bh=Gja+8bHl33iFGh5gEvpSlLHocRfj+xAyOKD2lib6fXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OG+FP+sw8ZgsIVthRUsDYvVod/e/QdrnByYme+1SyQS5qxdmV/WiFxYYDUZ4rMPhrWyvSq7ONlsNJzossAJjHKGRAt9y9PQSeZFZhPrxgk4HX3oKIZjY74qod4M1eO3jzM3/t5CQhMWeF1kxIyNv8H0+Rt78W0TOW9D6oSDuOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isbRA3RA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isbRA3RA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9279D1F0089C;
	Wed, 16 Sep 2026 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584276;
	bh=EW8USqp1cudwsWEhcUSXCzyJWdxDGpmwDabP8elxsL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isbRA3RAzvHaPpxogzAnl7DUD15J9z43DiR+i0iKIinsyOS9Ue7KGw3/bbi1dJAeu
	 TKHjo64KZpVoaPzfFuJdLRmg1duznd7zsbMuh8AvhXEwwCSLv+uzL/ZF5USpuEeeSk
	 nfg7qTCVmtKkuotHtFzPHLPzQUyWpBeBYVbdiBmcsqLx8YtPFYcPvAHGNRyXZE4JrY
	 A2myzE2BdHLwTkEyYnH6QnZcWKXyEGdvzgtEf6yvXp4hdMvzqcvhKnJ/LZNZ9VVy6u
	 Fio8WodO4Vh7UD9oc/w1nwJKORFsiRUBtoVkb5tC4LYXuHIX7UH3aFDtI+3/Zd6aVQ
	 fbfT4U8thq7Gg==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	puranjay@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 08/58] objtool/klp: Run the klp tests under set -u
Date: Wed, 16 Sep 2026 11:43:01 -0700
Message-ID: <20260916184351.2720310-9-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916184351.2720310-1-song@kernel.org>
References: <20260916184351.2720310-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of these assertions end in a grep, and an empty pattern matches
anything.  So a mistyped variable name in a test does not fail: it expands
to nothing, the grep succeeds, and the test reports a pass having checked
nothing.  assert_section "$sectoin_nmae" becomes a search for two adjacent
spaces, which readelf's column padding satisfies on every line.

Refuse unset variables.  lib.sh guards the few genuinely optional
expansions it has with ${x:-}.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/tests/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 82e6b0d4c670..294b99ced357 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -8,6 +8,8 @@
 # codegen varies between compilers and golden files would report churn instead
 # of regressions.
 
+set -u
+
 TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 
 # Tests live in generic/ or in an architecture directory beside it, and each
-- 
2.53.0-Meta

