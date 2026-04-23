Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DD3D75A0;
	Thu, 23 Apr 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917073; cv=none; b=h4FMg9sJ+bcHtCKpHjLUWrQEnBavsMxKsUyvgPrEAyK4XSVmFfRrsHYBj5L5M8aqUViPLzJMzDC9ejDydPrEux8KCajDkWYr0Ct+q5k4gL7YJhyi3B9ooNb808bM/gzWO/ai2QO9aDXx1v8+3jEJJq7vP7xzlJLpaUKybd5RgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917073; c=relaxed/simple;
	bh=p3tDSzhkhuYxo7Rda0jssYM2X7zLXfdCw/lc/q2MBvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+pfvXVGigTID5F4erd77gfH0M75Tx6heuuNoq7oc/kJKK05n9zplpi+kQdHkLTt0HK0AMvDwCPoDUPdXeYhfku0tjYKFrabmOX/P5X6uOTOnaGaynzgLI3fafp1DU8aZTTY56w50+w7UiLJvJgS9jFqh8mKYVM3+y5vP/cOhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGgetgGZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGgetgGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F1C2BCB2;
	Thu, 23 Apr 2026 04:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917073;
	bh=p3tDSzhkhuYxo7Rda0jssYM2X7zLXfdCw/lc/q2MBvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGgetgGZdpahrvq2LAhRk7GcdNa2zsd68FktJYpWHwX6KBFj5nMY/b5ywNXnO4AU0
	 39mLZ/72IWp5DzKp/1BIdzfJaRsgGVRlTGVjT2lMcNjeUetCQ/0JkZx/DUFwRZxsJz
	 xoPjHY36w3nCsV32x4eA5usbBjDbN7SGYEhbfqxQty5HnQxrROjnU1U2X9TXBVgc3r
	 Xx0wh3cTM6p83fogP6FcQztd7ryn27noYDpkF722Kur9beGC1nSfwXKRhJYwlYfY1U
	 cB1QYa5sPJru38mDNynCpOs21Y1faSpsqjX2tACooYFCGXvPQM5NvaCtQOtYlKDZ9K
	 A6OcSJRqlOqfg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 20/48] klp-build: Don't use errexit
Date: Wed, 22 Apr 2026 21:03:48 -0700
Message-ID: <f86bf0b781101152b35437bfe0e6a286f3955247.1776916871.git.jpoimboe@kernel.org>
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

The errtrace option (combined with the ERR trap) already serves the same
function (and more) as errexit, so errexit is redundant.  And it has
more pitfalls.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 2b8b3c338a87..e2f0eb8fdc7f 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -11,7 +11,6 @@ if (( BASH_VERSINFO[0]  < 4 || \
 	exit 1
 fi
 
-set -o errexit
 set -o errtrace
 set -o pipefail
 set -o nounset
-- 
2.53.0

