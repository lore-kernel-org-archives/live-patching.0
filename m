Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30041364042
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427081; cv=none; b=UBtYAelM8BxOg48993cwhvl6KKfzq5mxcYedq7SES/oKHkychzKAIZGp4qIBCfgBQAy6ssF7aNAv44cJJ84c8L6zKFie+1z+hd0H9zMxTWZr03MEmUkJlaAy5TxrO0R9Wtx5x8TymTcGIev7tB5j/e3w4DK0TyclCCkhxHJS9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427081; c=relaxed/simple;
	bh=x//lNXQEXVlKwBlOh2eyIQhvqoxfoAB2UEcvB71OYZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtpBM2IlTOQG+54ciM9Mua6cG/P/cd/wsYUGA2GcPU3MAzAb3V+E3BqJPbYY/SkOzZY22rATHVKmtXS4Lg0DSyY0ckXkMq5Yl7Val8EJGL/crBI9MXzw5NzqquXnv5t0rD2f9dhSzS3DX6d8hKtEo/4IStEj8kMIaRni7/OzvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN7C+KTD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN7C+KTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB01F000FF;
	Mon, 14 Sep 2026 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427079;
	bh=3HXkc1TPOmePJVivB67OL3mSodkHk8PVnEgL1EI+jCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jN7C+KTD8P5Gb1Fhxz9AFtluv4ED1HPt+G90iJ29YeMho5+1AVJR/c/El6N9INdc0
	 RZEgCvmho54R6dUuLo3eTsdC6nvcRFV2n7Y57kJ1ynxKgFFGmtqnEaWy7tXDAiXys6
	 XbH0nmlcuxMj+EFGXjaCSCcut7UBnk30FP1NTtnmro1Ok+0ho1MiUMK3AwFstHKxX/
	 dPC3wrj18Go+n7s7d9O2N1K0oYTOl/ssOEugqm+mzLpXTaihwLCkYEAt+M+BCcDa7b
	 MO3uRRFMq3FGbHJK6htwXN5uJYgvtG4QkfBOMRGBVdPVzeYbRSoiixcs6x25VylGsM
	 QrztJPKq5rOMQ==
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
Subject: [PATCH v3 08/58] objtool/klp: Run the klp tests under set -u
Date: Mon, 14 Sep 2026 16:03:05 -0700
Message-ID: <20260914230355.3422996-9-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
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
index 7598836a6442..9dd4967b244f 100644
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

