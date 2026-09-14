Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105F3E3D8F
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367272; cv=none; b=lbuGc/HfJs2lXVnq5UA40hg5v4dGNcth0AOmsChH63qacCtoCqhUNKqNcoAlhMUdGHNNVbadoqfmUax+XK2FYJ/tbqkAgatnx7qnpE5UXyBbBc9U+ckRV48G3PXxBqVf3P4S4dkuNpKssJC6EvQFQW//Ayxv5eh5fmdnAopjy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367272; c=relaxed/simple;
	bh=+xN//YA5nPU5daS6rar0SIeVdiI9BoIS1L+6R4FwffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ2AKR2mlJmI63zD5/fPHIqMcBAUCNj52jAA7RCxxJg7KhPRDvdi/ghzl7AXvGkWIUeLoy0bwXaIMp2Eezin2ioIEW5nfKtyPIaE+j++crNYgEDn9T/tDR176ZxHipMS7BUMGLhBrYP9K1T38BHGxsfUQf4ALlrPf+GSS3YeXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAmecuqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAmecuqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DDB1F000FF;
	Mon, 14 Sep 2026 06:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367268;
	bh=Lvfjcabrj6b8SwESpvZTawm2JVF48rrpPp82GZRO3t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mAmecuqrxg3Cq5l5DIHelHrbPZ8AykNY70j9Qp4jMLsKKt5wYIMdYT8QrAw3JTnhY
	 9DtM8WlaCo25vdLcpJZHoWwAitK5Yh3pu9O3Th77WHqWQZGTlqYpudxXbEfP+KgO5p
	 juTY3oxKVh0js8YlsGSTBViiLldsMn7fw0hLFxqd6sTnQq8lOjxPDgRGOkyE0b9hMb
	 8JLHicjygd33oXIFyBxpG4wDOSG11dm5zvLuO0u9bNPcFA2sBmiXvesaazAgHmATBV
	 FqGm/d4XexAY5/3kR7vOggsSQ1ak0z2F1omQM2G+PyH+SEtCvWELBuBuGRfc7czdtV
	 Le8SlCY57Sexw==
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
Subject: [PATCH v2 26/58] objtool/klp: Add test for unchecksummed input
Date: Sun, 13 Sep 2026 23:24:42 -0700
Message-ID: <20260914062514.926997-27-song@kernel.org>
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

