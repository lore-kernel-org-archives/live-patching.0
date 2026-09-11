Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693734A6CE7
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152274; cv=none; b=N9eVsD6zlk71yy0zsMHdmEKL2diDDQABQEF4FjzOWDSS1woBCIYug7/Wd3/uPgnr8s+UteEBTrJvB4KWHz/fvBCPXWDHVhJz2eQqnEQFqf6Jy1+lsOD0m1r+j/SxKV491tYKwQ2zpQmvHHj6sFcDw20C0+1pZhJL1YWfNmmr9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152274; c=relaxed/simple;
	bh=xhUBgU54xZyKl/Ai97nBALDAhk9EqaHWAusUkQlxmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeHCDkmwJs/xZN1u47XMXFrcFkesR8K/GAwoes7KAeEC8Yndhp65sT5rlMXGMnYYOT9Os5z/IYfMTfeK7GQakMbhpfXpg+H1muqk+PFKn5wz18mkzsZZKvQLg5p0OQfFAsfXNtVRr6p7MhQfw9kZJqIPHMPb9TyhP1KzNn9m4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQMyER3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQMyER3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBE91F000FF;
	Fri, 11 Sep 2026 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152273;
	bh=hMMqfYBA4ZBY+1snhzL+wcpFtd6VkgU5I89WG7xS0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AQMyER3Bu2M2btDYnIrB/R4rbJYnthM57cBOSHgzc6ZQBXd3QuymKNyMSmtfed2dL
	 Tc4w0P5w67XsXn6rxCBzVMuZDNm8FnOUpgjBtrdJVxhBuMSWKGvYpTitL2fzWgQdW+
	 Ic/ghFEcC2fX5oE9wO9/lCXzo1j0+DbyJRHK+le9uHlYLKy4pORdHRZoZWm7Bafobd
	 YzQFSGJkbXUwRJTTrC0IlWcTRa+BLOga7KvgwYPqOTTqnQdygoryOKWF7yieWDy6qA
	 uhbtZTf+LWQ3nJzpTkRnMQOWU4FKzlnXR9V1br1cllRmGW4pt6eDCkyX0RnKr05G6I
	 w1M3LGxiMjawg==
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
Subject: [PATCH 11/58] objtool: Forward toolchain variables to the klp test runner
Date: Fri, 11 Sep 2026 11:42:18 -0700
Message-ID: <20260911184305.1457308-12-song@kernel.org>
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

From: Joe Lawrence <joe.lawrence@redhat.com>

The tests target already passes ARCH and CROSS_COMPILE into
run-tests.sh.  lib.sh uses those to pick a default compiler and
binutils:

  CC=${CC:-${CROSS_COMPILE}gcc}
  LD=${LD:-${CROSS_COMPILE}ld}
  READELF=${READELF:-${CROSS_COMPILE}readelf}
  OBJCOPY=${OBJCOPY:-${CROSS_COMPILE}objcopy}

Those defaults only apply when the variables reach the shell that sources
lib.sh.  The recipe passed OBJTOOL, ARCH and CROSS_COMPILE explicitly, but
not CC or the binutils.  Makefile-assigned values (e.g. from LLVM=1) are
not visible in the recipe environment unless forwarded:

  $ LLVM=1 make -C tools/objtool tests
  ...
  # preflight
  #   compiler  gcc (GCC) ...

Pass CC, LD, READELF and OBJCOPY the same way as ARCH and CROSS_COMPILE,
so fixtures are built and inspected with the toolchain make selected:

  $ LLVM=1 make -C tools/objtool tests
  ...
  # preflight
  #   compiler  clang version 21.1.8 ...

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ed5cf146ef2e..4429ae6db888 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -153,6 +153,7 @@ mrproper: clean
 
 tests: $(OBJTOOL)
 	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
+		CC='$(CC)' LD='$(LD)' READELF='$(READELF)' OBJCOPY='$(OBJCOPY)' \
 		KEEP=$(KEEP) $(srctree)/tools/objtool/tests/run-tests.sh
 
 FORCE:
-- 
2.53.0-Meta

