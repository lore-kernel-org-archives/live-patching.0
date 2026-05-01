Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCE345741;
	Fri,  1 May 2026 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608542; cv=none; b=FVnuEVIoF1MYlCqTVnnQUdr56i9eFEgUO59qr8GhxgxEhSG5XcLKnd5ZxlUcyVZbOBLd58v5RfCV5wS4e0po8Y+dT4nnU5XXdijCv6r/pyzIHm9wxmjaO6IhxhlxVmIneSuy3LY0LQ/LPUZeej+FUFdjpD7RI3WdlqgTJpldGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608542; c=relaxed/simple;
	bh=D8tuLnt0jX5cK8j/CyuHFHRPT9Nz4vaerNpKXeVU5Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA32JptPIGyD4oz6ikvRw9ZOOw1HlF6HH1Z0xlepF9q16Owm0mA8H8tO+et13WN7nHBK++0CaLzdmGmg4L6wQpr6nIqyOEXuTvpuYPfnNEOO3v6qrc1grZd2wy3njdIoblW0+Y2aSGWtN9OY9YmjHGHNqwQJmK3v1RF00XsDxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCksWzq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCksWzq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B492EC2BCB7;
	Fri,  1 May 2026 04:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608542;
	bh=D8tuLnt0jX5cK8j/CyuHFHRPT9Nz4vaerNpKXeVU5Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCksWzq5hEn3kWdUUsiugJrXa5dCZJu+k/RH5emEoVH5fef/AwP/P0sEQrX2QZXiN
	 q4RDu5wsS9GBLmckWvD1lOwwAJmR7EwoCEYbRfthm2zoilgtnxrqkiNwIcdvWAjHCU
	 lAdWLrwhd5oKNPjgxwxz9D69eq1P8ulpOe7mBaax/FsEcZoQeap+yVYNsFcsN5AHCo
	 Iobyv2pr93q42L4MGOztQeP9Ju8pRfmaXmqzMJMt1OfDtljinLUrHEmZ5GpGf4clQg
	 8j6lkEAcsUxGPoJCWDdYFJfe6TZCGF4zm6YPG7npIOQ7iW5PFpz7T1fYe5rWZcv27q
	 eDsFKsgveiRZA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 25/53] klp-build: Don't use errexit
Date: Thu, 30 Apr 2026 21:08:13 -0700
Message-ID: <8f13b66e0fedccde18f9f740f09c3b0705c29deb.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The errtrace option (combined with the ERR trap) already serves the same
function (and more) as errexit, so errexit is redundant.  And it has
more pitfalls.  Remove it.

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 8f0ea56f2640..68d61b72f39a 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -3,7 +3,7 @@
 #
 # Build a livepatch module
 
-# shellcheck disable=SC1090,SC2155
+# shellcheck disable=SC1090,SC2155,SC2164
 
 if (( BASH_VERSINFO[0]  < 4 || \
      (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4) )); then
@@ -11,13 +11,12 @@ if (( BASH_VERSINFO[0]  < 4 || \
 	exit 1
 fi
 
-set -o errexit
 set -o errtrace
 set -o pipefail
 set -o nounset
 
 # Allow doing 'cmd | mapfile -t array' instead of 'mapfile -t array < <(cmd)'.
-# This helps keep execution in pipes so pipefail+errexit can catch errors.
+# This helps keep execution in pipes so pipefail+ERR trap can catch errors.
 shopt -s lastpipe
 
 unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP XTRACE
-- 
2.53.0

