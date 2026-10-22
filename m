Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671961;
	b=tXJeX3bf+Fkdc0/RyZ0B2ok1GGiMOPjB/nYflKJOYfkM12l/aLcJzOYH3jNt/85x/kGa
	 MnOM2NK1T/9eDdqu7+Awc9Sw5/KHyjt8AEA9vfUPyXjLTi3L7v6Twh8RkGc30EbfviXYd
	 HRUHM+QGszYQxZKv0Azt7ui1diMQhSUnaaybBN9zIZYFHb/36Jwww3VIkb94+W4hkVl7g
	 GGARKHqro+WQ5jrK/Hw6sT6ZsJb4yLjccSc5rtAD1mxMbfbnyKltNHaEh4VlvnJo8LDpd
	 JsFc381N2l8OhIV2tikg8m3Wqk7X+Y2Qi5nbaYFax6zpyV/FCKYuoOt09Zg3H0D05Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fciLY47DNySlM7jPcVRz2mIsxdyx2UZBjbGebbnu2t8=;
	b=0I6xTZ9s02kUpBwvYFTFZxBknUOpxpOs76/g91cu0PX8e+IcqMvm9DwivCt4vmE4T7PK
	 QJSH0NTP/LCRD4vZ451UdaZYK98uA5oiyUfJhtNNV179l4QikkyZTe7Gh8L4t8BETdSSS
	 9C6tlCs3JifS7Ld0I55gvIvlpXX6BKMMHkbvqrgGvdPYtyvKTDWUWozea2IICRHjqWwsi
	 Whm4zHwfwzpIyVN0lVx9hQWbeitD6g4gA9aAz/UZYfp6UCb639uP/CeBJL0ldBp0gEstO
	 RYhq0xAv2hvy033r7pY7UALrgu5eMnTLqKnfRnZbfLMvZ8rqqNQfPUm9Qk0LSHFCebA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYBWLMrX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485C606A319
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYBWLMrX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB5C1F000C1;
	Thu, 22 Oct 2026 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671960;
	bh=fciLY47DNySlM7jPcVRz2mIsxdyx2UZBjbGebbnu2t8=;
	h=From:To:Cc:Subject:Date;
	b=oYBWLMrXYiGUCrxKMrU9uPYJIFrtkdeS+KX/xAqXRSgKIHujRicJdAkUYSmE6GkIA
	 CWJa21BCwiMKvdJIcADhSSS4okh6mO2siBJ7/U+0kz2bcsK22hQpMRxHsAqnPWjE0B
	 MfgU6EFIHbAfapv1Odw8BeEiNGdVy82grWVxSdBQt2G18vlIfX1TQ5KPd6EKaXNakA
	 86pMy/jWElNp34gDcIuN+c/cxcPuAW3EYHm4j9wIoqsgrD7NEUUqLEPuYQ3Ndz93oc
	 bkk1cShzONRLxTUSYibpIv4EUa1dBcP1D7WQF0febzLbubEtkB0SdQvDeSsK6b7RkE
	 OI3V3O3CrpEGg==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 0/3] objtool/klp: Reject changed functions without an ftrace call site
Date: Thu, 22 Oct 2026 05:25:35 -0700
Message-ID: <20261022122544.125305-1-puranjay@kernel.org>
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
 .../tests/x86/test-special-sections.sh        | 23 +++---
 10 files changed, 257 insertions(+), 22 deletions(-)
 create mode 100644 tools/objtool/tests/x86/fixtures/notrace_target.c
 create mode 100755 tools/objtool/tests/x86/test-notrace-target.sh


base-commit: 6ecc854643e6fd6a2d07bc8d83015c7c34a951eb
-- 
2.53.0-Meta

