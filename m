Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CC4BB26F
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152261; cv=none; b=WIAsUVu+j9ehjAKLPq/wlUwXXP0kdjFb8quEDS/Eg3S8cgzlWKizTHfQndtS6Rqj1NE5T6zOi3BLAHdY9mvROU/chlqsMe8qciZZTr0FiWMLA6DVGdPgmjNuUr5esPwM6OdHGolxH4Q+lnZdUAaNx5Ex/MX00d2j6028TKI+r08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152261; c=relaxed/simple;
	bh=Rn+ta0hoE9wsdhme6iwkkwl2xIOgc5XFasOz77btLa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kp+HDNpGioVPu3KtaBw8BaO61Yxy/biPrHVHjJAObUyO7EniCAF4OiqnMjWXg4buS69VaBWjw2dBlXLcfI6iKf75qB6d9FguDh3UwudEBgwhyd7M5AqZIVdrGVubX8jXs3uQf2au+ePn0x/3B6556gdCvvyTexFv1w5Pb7uEkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqf95NJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqf95NJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146961F000FF;
	Fri, 11 Sep 2026 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152258;
	bh=zrY8B4HnXfjhcBwXovpNDkVDsg7GPlogjycN9YePJhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqf95NJhRxmjluTls8dd5Roble2oMRoPJ+7iZoUYHnvjuXqNj8YzE3SH/vXsVra8I
	 8T2VskBPkqtn6iOtLp6Cywrbl+6zYj5UgsJkPd1NkR3a8eIK+1zpv2dDAGuu7QG3AW
	 SMWl323jq1soaGtn5bIfI1fI9SUgtVf9oIVNaMM2UlPhVs3DvZlC52u3WCdzRdL+n9
	 Fg6vdZ5zd/OcBygLrsnD3oQVC7eB073l8hmWaYmLHsvD3W+MQNfy2BfBHEds1nY+eR
	 NEzv5OovcycCt4wJ6zl/m7i9QZVvu/rHUpgd6lseVCALey81HDDDh2Or9YMhm71ew/
	 Hry89NAe/eaPg==
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
Subject: [PATCH 08/58] objtool/klp: Run the klp tests under set -u
Date: Fri, 11 Sep 2026 11:42:15 -0700
Message-ID: <20260911184305.1457308-9-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
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
index 08788510e722..4d8401ee8b41 100644
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

