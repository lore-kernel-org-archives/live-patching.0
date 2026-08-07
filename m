Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F66363C5A;
	Fri,  7 Aug 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138720; cv=none; b=SGa+1BfR33SkItXYdfFTWWxL0drbrPvF4AE0BeptMbe3fZPRTEn4tXhctkMLOJSyTcyq3OLVgGbgAwie33efgwhUtCuDUGlu5cDv1kkahnL76Oj//7e1RhPGyovHjsvI8Tbhey4E9agrHKufVfE9zz96KIktv5wEVYMzVPfb+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138720; c=relaxed/simple;
	bh=OTODUrJ3NLYt7bAWdPXWumkvEeUzVzuWVzB41fdG9Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHkCXg/JRvHVvD+AajftlMVH9PKXwykv/sxqtZukShtKsvD+kl8WOE9eJ/lxTdY0mypKCXGUGiAZxaZM8KhPCXFf6UtXnnEo1MI15gYbdjL5drZVzlNp8epyMe9PSf4sumowpMOLZBVj8O04npXwoI7slXvBjG3yw4sqC8vOhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If79QAAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If79QAAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B261F000E9;
	Fri,  7 Aug 2026 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138719;
	bh=DsSwPjia3rP+xdgoQwgg31YAYEuvAKj6RCmKlRGUZ+A=;
	h=From:To:Cc:Subject:Date;
	b=If79QAApnUI3/rOluLy9ZxjNLLPuRMThCjJ5DF5vr0SaAwKB8mFyExIHPEIxFACxv
	 yhEgFR+nW7sWX8dFPcKIoKXA6R+OlOMkHivB4Tb9PlweBKtX4LB/o5hbomjiDsY4lC
	 fYVAwpk3P+NB3bEj97G2NArC0rgrMEYLu92avPq0VRPmuDiZTlrLw11bWSdCy/7SV2
	 yV9z3Faxn5SJj4wzSUG9xAH62++iUEi3iKwfNdYUAeL62Sw/jSlMxmWG2G3faoDkhJ
	 V5GQCbqcSG0t2aksmlSpo+j/Eq3Svkazd0ssV1MGYNZ3feuY59NufmvVdspqa4FGoD
	 KGUSufWJKpiwA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 0/9] objtool/klp: sympos/module/alternative/etc fixes
Date: Fri,  7 Aug 2026 14:37:45 -0700
Message-ID: <cover.1786138493.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- remove "size = 0" and add comments to create_fake_symbols()
- add patches 8 & 9

v2: https://lore.kernel.org/cover.1785939903.git.jpoimboe@kernel.org
- rebased on tip/master (first 6 patches were merged)
- dropped original patches 7-8 (will post followup)
- added .klp.symid fix

v1: https://lore.kernel.org/cover.1785727106.git.jpoimboe@kernel.org

This consolidates fixes for the klp-build issues reported by Joe over
the last several weeks, plus some more things I found while
testing/reviewing.

Joe Lawrence (1):
  objtool/klp: Allow new references to module exports

Josh Poimboeuf (8):
  objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol
    symbols
  objtool/klp: Fix size of empty special section entries
  objtool/klp: Ignore replacement offset of empty x86 alternatives
  objtool/klp: Explicitly disallow patching or referencing init
    code/data
  objtool/klp: Fix cross-module klp relocation section naming
  objtool/klp: Don't match local symbols against exports
  objtool/klp: Fix relocations for EXPORT_SYMBOL_FOR_MODULES() symbols
  objtool/klp: Fix line numbers in Module.symvers parse errors

 tools/objtool/arch/x86/special.c        |  27 ++++++
 tools/objtool/include/objtool/klp.h     |  10 ++-
 tools/objtool/include/objtool/special.h |   7 ++
 tools/objtool/klp-diff.c                | 106 ++++++++++++++++++++----
 tools/objtool/klp-post-link.c           |  53 +++++++-----
 tools/objtool/klp-symid.c               |   1 +
 tools/objtool/klp-sympos.c              |  10 +++
 7 files changed, 175 insertions(+), 39 deletions(-)

-- 
2.54.0

