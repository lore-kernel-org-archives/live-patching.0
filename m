Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689402;
	b=hXli7w7aaeMuCvZsQWMztZRT3XqEhsyhtTdZ6L+rnf04LMXjfBXiofVvdBrLf96ipK2J
	 AX+BL4EH4UMbY0WIltNpQgvXf89Ppa+eMK7vA0OFl2urkgNPQZbmziKe7XzAMGOSMAH8q
	 rzUMsT7PaO9X8A04N1TadUWwRLmeZznLp8r64zCi4qvmlN+M8xdd/40MC8YpoU6vvnGir
	 NOshbAj2y4JYPPVT7zHDPXrG/EbpnlIt8SqlRHA1Bfu5yDSIbITEIFKY4AqOEWqwxtreT
	 Y/cUdLhyw0VqBJesGoPHaNjNEQxEGED3Mq0OXlo40JrvTkcXeSdKnYMuiIPCtH1obHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dZNP7IJKBE2DeTd/Y2OyFrW/YBHvYHTlDpbVBDBOp3s=;
	b=034pfg1iuTGkTYTu8IIRuU1wr2vE5CYE38kGf9fWhK1jrD2Y8ebmLGHv82RbmGQTiniF
	 HNZd5bWrQsoR5TMASDZ2CiZQ5rcPODz/OilQh7C4bWupWD6uEc1Z5Bw9KJO/CyjvU0I7R
	 2XCLvfBCjg/ArpOrGIw6R9MFuQiHLEBC+U7dHwroEzWMyPxvigc5litujOSgYqs8uQm3/
	 Cq7sqeWVfKmhSP+teoL3EU9cpy+UN1RHd5AtPhyRtzGDoZCZAu/wQvQ0blqhULC13rX/p
	 gub6KXSoaJqcut+XvzB4z2bW+VabdIjPXqbgex6d83UTYR+6feBYODhWlEU7qIV9GwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsF7AAhU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D017606A31D
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsF7AAhU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C561F01825;
	Thu, 22 Oct 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689402;
	bh=dZNP7IJKBE2DeTd/Y2OyFrW/YBHvYHTlDpbVBDBOp3s=;
	h=From:To:Cc:Subject:Date;
	b=UsF7AAhUr/USc/Dzs5FQIX9iPwkbB6rhctmchv6DSbTAd7vbGCaAKLf/tu+im6G11
	 0W6gdEPJBA/USYAwEBNTbwoK255ik8JFFXHL8N1OPkkyKIHsaCBSm/NZX0L4FFpYz/
	 YXjyY7uComRz8gqPjDI0ehFFGnESpRP3jNBiBEzy+RPwl8hhu+mNtH2GjheC1I6NrR
	 qW+bp5D3jqNX8aMG8rQ5N9YZqH+9S5TlU7IGW6+N0AC5umoOsjC8u/+eNA6vnzSq/i
	 /os1pcpc0fR2eqjXL1BdOg+fTmlzJcpaG/eNgctGX13eLNqfgshDnHIaWq71M6Oh5t
	 6Nkx3iSV+PNLA==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH v2 0/3] objtool/klp: Reject changed functions without an ftrace call site
Date: Thu, 22 Oct 2026 10:16:33 -0700
Message-ID: <20261022171637.3298443-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1: https://lore.kernel.org/all/20261022122544.125305-1-puranjay@kernel.org/
Changes in v2:
- test-special-sections: check __mcount_loc in its own block instead of
  inside the section loop (Joe)
- Collected Joe's Acked-by on patches 2 and 3

A changed function without an ftrace call site makes klp-build produce a
patch module which fails to load.  The kernel's 'inline' implies notrace,
so this happens whenever the compiler emits an inline function out of
line.  Patch 2 makes klp diff reject such functions, patch 3 tests it.
Patch 1 builds the test fixtures with ftrace, which patch 2 needs.

Tested on x86_64 with GCC 11 and Clang 22: the objtool klp tests, and
klp-build with a vng boot, where a patch module built without the check
fails to load with "failed to find location for function".

Note for the arm64 klp-build series: arm64 has no __mcount_loc, so on
top of that series this would reject every changed function.  It needs
mark_traceable_functions() to also handle __patchable_function_entries,
using pfe_offset.  I can send that on top of the arm64 series.

Puranjay Mohan (3):
  objtool/klp: Build test fixtures with ftrace
  objtool/klp: Reject changed functions without an ftrace call site
  objtool/klp: Add test for changed functions without an ftrace call
    site

 .../objtool/Documentation/klp-write-tests.txt |  9 ++-
 tools/objtool/include/objtool/elf.h           |  1 +
 tools/objtool/klp-diff.c                      | 47 ++++++++++++
 .../tests/generic/test-thinlto-ambiguity.sh   |  3 +-
 .../tests/generic/test-thinlto-local.sh       |  5 +-
 tools/objtool/tests/lib.sh                    | 42 ++++++++++-
 .../tests/x86/fixtures/notrace_target.c       | 71 ++++++++++++++++++
 tools/objtool/tests/x86/test-checksum-alt.sh  |  4 -
 .../objtool/tests/x86/test-notrace-target.sh  | 74 +++++++++++++++++++
 .../tests/x86/test-special-sections.sh        | 12 ++-
 10 files changed, 254 insertions(+), 14 deletions(-)
 create mode 100644 tools/objtool/tests/x86/fixtures/notrace_target.c
 create mode 100755 tools/objtool/tests/x86/test-notrace-target.sh


base-commit: 6ecc854643e6fd6a2d07bc8d83015c7c34a951eb
-- 
2.53.0-Meta

