Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AF37DAA9
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515442; cv=none; b=KB0Q12yF5x77ZNG5Ju8QUDDXpJsywn5dbNfN0Y8yhvWB167O3ttXw10EVBMFereQrLM9WphJ+Sitb6hOWm1jMyzyiHfgB53D3Ymzw8LVDjKSUSjtXh490wM8p2hn/l1yr3K8p5dNcQEx3sKkdrQrlqFTua+dzXjmGZgwGX6cGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515442; c=relaxed/simple;
	bh=+xN//YA5nPU5daS6rar0SIeVdiI9BoIS1L+6R4FwffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiyiCMsKbam8CkVG1VAG/ovbnZOn2cHAEDhKhkTAEJpIS6bEPMmgqmjPKspHvpkl1X8V2X9PY2iZifeFyXKvPkQlh/pA+Nk5Ke8oBdE5KiOvp4NUAkmdRbJsJBaRkMu9+ZJxZIcnjB592gX+XMmK4Iu75FGjRsQXhn8x/QzZHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8fj2Eg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8fj2Eg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED731F000FF;
	Tue, 15 Sep 2026 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515441;
	bh=Lvfjcabrj6b8SwESpvZTawm2JVF48rrpPp82GZRO3t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8fj2Eg8Fr6G1kSVbtLAcoRXiXk5CuehOfx4VEoyC89aJ7UpwdURrG+Og/ODWxKCj
	 lClpV81oEtGxA94a79kjv4OFExdnsNnuYhoRKqr0s8Cb+TcCYMmmPCx6zJwjeTkhlw
	 i12lTJCTeIg2Eyzu1oe5+QKhG1ARA4H8deupsPwz8eipD0wOKK+0SVb0yFWC4wlWid
	 xpVhArRpPobzkGRpbIxTu61/DTBnbSVcjmtZXQcpibj5XQrneASxfp+Hrltuxdywtr
	 Xa4B2RQ79o53JJKAsgy4bXIi5u9gUECUQVxprerC9KEwBCi54nFWezZpUJakCBJcXV
	 n8giVuDTXXk3w==
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
Subject: [PATCH v4 26/58] objtool/klp: Add test for unchecksummed input
Date: Tue, 15 Sep 2026 16:34:22 -0700
Message-ID: <20260915233454.2405019-27-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

klp diff decides what changed by comparing the per-function checksums klp
checksum records in .discard.sym_checksum.  Handed an object which was
never checksummed it has to say so; silently concluding that nothing
changed would be the worst available answer.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/test-missing-checksum.sh     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-missing-checksum.sh

diff --git a/tools/objtool/tests/generic/test-missing-checksum.sh b/tools/objtool/tests/generic/test-missing-checksum.sh
new file mode 100755
index 000000000000..89a05b1869ed
--- /dev/null
+++ b/tools/objtool/tests/generic/test-missing-checksum.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Without .discard.sym_checksum there is nothing to compare; concluding that
+# nothing changed would be worse than failing.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair basic.c
+
+( cd "$workdir" && "$OBJTOOL" klp diff orig.o patched.o out.o ) \
+	> "$workdir/diff.log" 2>&1 && fail "klp diff accepted an unchecksummed object"
+
+grep -q 'sym_checksum' "$workdir/diff.log" ||
+	fail "expected a complaint about the checksum section, got: $(tail -1 "$workdir/diff.log")"
+
+pass "unchecksummed input rejected"
-- 
2.53.0-Meta

