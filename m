Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67238A711;
	Wed,  5 Aug 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940208; cv=none; b=kAXcSSfER/KdxzPTnRLvPcnVPCyxyCcF8te6AIVEkZEeVFMBcNSPYb6V0wvHN2RVDQ+j8u7+0ZxzX3rGFDwr6IRKyoaIKbKDQrlSLGoyIYw1hiLPYNYXueoOVbT5VHGyLUaC2AOowVz3RS/OOOFrcSW8NdCLUMean2LlOt5oOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940208; c=relaxed/simple;
	bh=++D2kVBma2Em9Lyc+dgdKSyLsWgvkWlezEfWvK5BXy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRSb8n2H1rmNacVsopynS78YfFkClqZFD+fsVA0EiCRNElKH9aYArjoVTU0IFb3L6Vyvc5H8Cag3GqH+a4NM+hh1UUhJXvV7G46MizPg/twcszAJCxavvYp6YAkIJv7FozQRBrzT0W8OF9Jke9VT69QX99upSp1YTGJU/T7TADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmvoW0fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmvoW0fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD261F000E9;
	Wed,  5 Aug 2026 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940198;
	bh=ajRMrX/lQoa/yrGiMAGQJeKD4W1Y9cF0bOJA6JIuKcM=;
	h=From:To:Cc:Subject:Date;
	b=PmvoW0fVxZDBrtuU3B+sUOZBlDkMyifu1eL5VCh5OwHE4wTqBUFhyWZsrqeMP5Pcq
	 sXxufXTsxoYmzikFp3Cd9dEve1S6qGfb6hEXwQBIiBcwPmseGEwlF+c/57JaahP+v1
	 8gHCEN1hlBgREg4FZ/XbJFvHlyrzZB1KB/GiA3ogtanXoabSA+kUEu5L6gVYCPfA5f
	 +OoI9DJBnX9BUXbCjzAqtLdrZp326tPRorMypfMscDVVqRv2Z8o1LokX7R9oHidm4H
	 RBjB4gcEJ9qwkXb8KZhlfygn+GwwBgpWPFyHGVt3iKvPw+rNRHTmJi47IV0oeuSbsP
	 7maNb2sTBEngQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 0/7] objtool/klp: sympos/module/alternative/etc fixes
Date: Wed,  5 Aug 2026 07:29:37 -0700
Message-ID: <cover.1785939903.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: 
- rebased on tip/master (first 6 patches were merged)
- dropped original patches 7-8 (will post followup)
- added .klp.symid fix

v1: https://lore.kernel.org/cover.1785727106.git.jpoimboe@kernel.org

This consolidates fixes for the klp-build issues reported by Joe over
the last several weeks, plus some more things I found while
testing/reviewing.

Fun stuff like symbol resolution, module dependencies, alternatives.

Joe Lawrence (1):
  objtool/klp: Allow new references to module exports

Josh Poimboeuf (6):
  objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol
    symbols
  objtool/klp: Fix size of empty special section entries
  objtool/klp: Ignore replacement offset of empty x86 alternatives
  objtool/klp: Explicitly disallow patching or referencing init
    code/data
  objtool/klp: Fix cross-module klp relocation section naming
  objtool/klp: Don't match local symbols against exports

 tools/objtool/arch/x86/special.c        | 27 ++++++++++
 tools/objtool/include/objtool/klp.h     | 10 ++--
 tools/objtool/include/objtool/special.h |  7 +++
 tools/objtool/klp-diff.c                | 65 ++++++++++++++++++++++---
 tools/objtool/klp-post-link.c           | 53 +++++++++++---------
 tools/objtool/klp-symid.c               |  1 +
 tools/objtool/klp-sympos.c              | 10 ++++
 7 files changed, 141 insertions(+), 32 deletions(-)

-- 
2.54.0

