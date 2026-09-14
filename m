Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4653D2FEC
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367174; cv=none; b=fW+2TMMihlM1RK2K9CzdnS/rvw81gDI28UguLDNXodEL2Ka7zlw2DgJNRvGzfCP+NJhjQ4ecsVOGSt8Tr00qd9sCIT8ruDfetdvJkN9hJdorr19gV0tK6ddH+Z92OS5Kb63MTQA1em0DEt1qCsIKA2wJ34agDFfmnWUlxdqvM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367174; c=relaxed/simple;
	bh=DqNAUURzV3Y4dSj9tEX9VZVCMaEzIyLa+/W+EJPPgWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK1hwLPWWqj4V7aMuwWEKrnBVEZHhr4FY4jnm4UmkxDmSApPKs3vqfEKflsIMjsCm0XyF2/6jyr4B3J24NHF4+RT6q6XLVpj0Zp9VgB4FACmJTAUHZYxKoNUxN4qnjfiPk6eHOle/6UZYWVW8Oov2CM+AgN97iDsgzWpWJXRjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KedUyct2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KedUyct2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10AF1F000FF;
	Mon, 14 Sep 2026 06:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367173;
	bh=7UGRiFOuzqg6DJdjfzw+Bu6+3C/n+i48eE/MGcCyzlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KedUyct2uCQeCKVqsThTMZqo9TZSXToo+apNmz3HS8lqPMxLYIpn1IXB72nLXhwbq
	 wgiU5nWyRCfzp2WG/1hXBt4pXxs5eTqHqVhkhjXMXDcr69ItOw+mL3C3Ll65t0YBoh
	 YN8IHf1NpaPKhpJtKPf1dS2SDvWzup24ZVPuh+PVjDoHpY694zJJj47CjN99UzPaDu
	 ivDzgRpmf9vxQBt6K8T40uINVOn6Jwfja+nxWv3khSL/k1xP3RKtL+wXYIOeW4ASQI
	 Oi7bPAQVfvTrq6YU//Wh890c/qF0+QcjyR7juip4VVG3RJRn/tnoJXMJrPt/w3dNZg
	 d2O9OhbsbS5UQ==
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
Subject: [PATCH v2 08/58] objtool/klp: Run the klp tests under set -u
Date: Sun, 13 Sep 2026 23:24:24 -0700
Message-ID: <20260914062514.926997-9-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914062514.926997-1-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
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
index 7b8b5b2f0c92..5d58ebd624df 100644
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

