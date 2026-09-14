Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E21A3D6461
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367190; cv=none; b=huSZRO8Agr12VSPXzcjIK/ZcKw4cbcWIAEKjpd+VAEnlM4JolREDrJFOY/lvMovq+DYIZjeE0QNMsRpIeCcflXLqRykKGVTukKcgYxDFXaFX8RbSoOkDiwYQbMUn3xHrzv7o4ch+ype+yAGrsgmjdesBgGH52VpSZXjZu9Vay5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367190; c=relaxed/simple;
	bh=xhUBgU54xZyKl/Ai97nBALDAhk9EqaHWAusUkQlxmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1rGI4JJn3PSwwZno2TaM6ql4DFZJCMo655+lOBs/q3oL/7/sB2ANw+TWRhjBnMeQsPecqgP336x7AUGeDWp1DDoKbmhaXyJzqxWA4E2FLsZJaL1CM/SE7m7TyTXxDTiXQ77CmZgNibBWHLV2Y4ma+kYEUBrNS2XupJT9n0kVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=insRjEIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="insRjEIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF951F000FF;
	Mon, 14 Sep 2026 06:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367188;
	bh=hMMqfYBA4ZBY+1snhzL+wcpFtd6VkgU5I89WG7xS0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=insRjEIo+u6gkFZeSYzIb0EyCWAzJj/T25F7gg90CTTrn0UJwVpVRo2/jGA17aMKx
	 3LfXVTIqNvk2+AagB98DOLrEqXBbK5oJP0gQjMK1+IExGUymyAAHz4+rzoizxkxmcV
	 O9qEYR0lcPBykPrRUvNU7xuPOBDz/kUyQOj/93ypM7KVEFynuMlhoqizBemo6WXZqW
	 9J0E+uVT/S40i3caQ8qVcTtJceuHEUxvNtqtCpOWM8eXpR8/4t97Ievh0W2HHV6zHR
	 XgWkPrY5we+wfwCawwzhx9bz6BCIiUO/dxVPYhuNQaORfoR4eAKuq+faU2nBH/OqCA
	 Xt3Un++jxhbkA==
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
Subject: [PATCH v2 11/58] objtool: Forward toolchain variables to the klp test runner
Date: Sun, 13 Sep 2026 23:24:27 -0700
Message-ID: <20260914062514.926997-12-song@kernel.org>
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

