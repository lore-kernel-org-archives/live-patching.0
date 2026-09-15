Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492F4BD7B8
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515347; cv=none; b=aDC0pJdzfRMJ1F7L9a4KOcz0RlgfoQXVGRorEPWbPmkVYab5biTxc1mjBQUhTrWOVotT4R0d3IQ3yicwMg2gVznESIp4VF+mwMlHrL8vQ09+3NSaJKBgQuYweF2SZK3uo5dkW1Ctj4rvADrdnLi1HyUXm9j8KnrZUrTV+SgGv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515347; c=relaxed/simple;
	bh=0LUSFdpF3h6sQ3RzG4N7yS2tkdh41Jy17U4Kjyh/cdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOPzQjpbAvM8VLy9p9ri8ybqwbacIqKDkaAMdYrnXOUwqsgF5eztCrPb2t9Sabb1pob3Uiw1/NmcsAEsfyPS+hgYi8vAWoQ3vNypOHYVM9DXWrKfICE2BHYvHHzimB5fy0OUJ3tiVJOQzXpaFSdqs2nTWQwNTxup0GLWmR7siw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn1Aw/pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn1Aw/pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3DD1F000FF;
	Tue, 15 Sep 2026 23:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515346;
	bh=xbHCAK71MO0v85ERBIT3UcTomeJmIz5TFJqZvxmhfJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fn1Aw/prbXubHM6mYNhN1WeNFMei5vkGmdkXpDu8WkpN1t3rpmx5wADxxjAPK1CqG
	 Hx/Og4ry+CQmgDrKcGpWYyJduMa8vizuWt6VhbbHjBKwnvbSYU7B4dOmMJR21L8GRs
	 6MHykR/EVUq7e/jQGbtoVsyO0GFG0N+V+E29wPoxKOhzrtu1hjDrspeWrhPhFC46cT
	 iztuNOjeAibpYfVdzBTJqvzVl+gdwSoA5kyofg4/piZN0QbSkC0a27lyuTSftJ79Xh
	 jhPTGkkoAvs6wNbORV9qQk5fmn0Gc+gw1JZte6+ynXOmvn8xY7QGsehEmis8dcbJ6j
	 HiK5G7r/7kZRQ==
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
Subject: [PATCH v4 08/58] objtool/klp: Run the klp tests under set -u
Date: Tue, 15 Sep 2026 16:34:04 -0700
Message-ID: <20260915233454.2405019-9-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915233454.2405019-1-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
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
index 026b3fac2353..9c3d5fbded9e 100644
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

