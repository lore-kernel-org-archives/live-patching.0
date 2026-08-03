Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34D368D4D;
	Mon,  3 Aug 2026 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727489; cv=none; b=BsV2vL0jIKSC+Z5dpTOYYAhMb6hxXqZxsa3xCKfXER2rHjxjbzamvhpX8Ql2+ehP+88En0wXuBi00EGZgX9UIu2Qty0ZVf4g/05fSMA8BQPyKHOQq0M6p3w9L6kJw2UUWOcVlgYAcH8AgO1PiyrJTybmylWuhAZ7bU4B9W5okRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727489; c=relaxed/simple;
	bh=j48+m9Y5h1Lb70QjJlbMMwENgX14LqXfWbeAUxW8Jxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzSQPteKwSVWerNJOAvvNRoEEq7JchKTPto+uavqp8e9kwjXF5rOxNJ8/Ho/5m/BCXIZmLaXoMj2ugtVn995hPUXpMw+HkqTdrt4roG23tniEN86NA7a81qHW0o6Kzmk0LK3xX7Ayt05NqBu3u3vFxhhGSxIE/vRmosiGB34mGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6O7+QtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6O7+QtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128CF1F000E9;
	Mon,  3 Aug 2026 03:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727488;
	bh=JR91vB8if1gD9eqhICAVNUHycvHpRC2TsM3UmLccdpI=;
	h=From:To:Cc:Subject:Date;
	b=D6O7+QtP1VGjaznUvVnJS1xAsxxVUk5Zn3mUrkHvoGo7cb7o1RPNyo+ks/YgcLSjw
	 pk6m1FS5f2I8g02NGJMyMsM3JAe0NyVuA7EEsV2Q0UNDChoxYj1HPraBAEawbxNE0k
	 7i+i8BvCN3wyUekWQCP48jfTJz1eX9Azi4eMW9OfNFGe/GZzwnCd5p6xgOYdlwpw6U
	 aB3qXrePItnQ6uKp0nTbwKOqvqFSF7Q5NZ9LMZtGroyvVqGI6xlgkEy4ec4W84RzvA
	 fQLQueZOmaVcN918C5YdgX0ZrsWA1CHlgsdHMi/3NOew6gn+hUYthU3631DZnRPM45
	 +VAiULalfgFqw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH 00/14] objtool/klp: sympos/module/alternative/etc fixes
Date: Sun,  2 Aug 2026 20:24:22 -0700
Message-ID: <cover.1785727106.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This consolidates fixes for the klp-build issues reported by Joe over
the last several weeks, plus some more things I found while
testing/reviewing.

Fun stuff like symbol resolution, module dependencies, alternatives.

MODULE MAINTAINERS: see patches 7 and 8, you can probably ignore the
rest.

Joe Lawrence (2):
  objtool/klp: Normalize Module.symvers paths to module names
  objtool/klp: Allow new references to module exports

Josh Poimboeuf (12):
  objtool/klp: Fix module name normalization for paths with dots
  objtool/klp: Fix false module dependencies caused by dead relocs
  objtool/klp: Skip hidden directories when finding objects
  objtool/klp: Add .klp.symid for sympos disambiguation
  objtool/klp: Fix symbol resolution for duplicate data symbols
  module: Add module_kallsyms_on_each_core_symbol()
  objtool/klp,livepatch: Resolve module symbols against core kallsyms
  objtool/klp: Fix size of empty special section entries
  objtool/klp: Ignore replacement offset of empty x86 alternatives
  objtool/klp: Explicitly disallow patching or referencing init
    code/data
  objtool/klp: Fix cross-module klp relocation section naming
  objtool/klp: Don't match local symbols against exports

 include/asm-generic/vmlinux.lds.h       |  10 +-
 include/linux/module.h                  |  11 +
 kernel/livepatch/core.c                 |   2 +-
 kernel/module/kallsyms.c                |  46 +++
 scripts/Makefile.vmlinux_o              |   3 +
 scripts/livepatch/klp-build             |  17 +-
 scripts/mod/modpost.c                   |   1 +
 tools/objtool/Build                     |   4 +-
 tools/objtool/arch/x86/special.c        |  27 ++
 tools/objtool/builtin-check.c           |   7 +
 tools/objtool/check.c                   |   7 +
 tools/objtool/elf.c                     |  13 +
 tools/objtool/include/objtool/builtin.h |   1 +
 tools/objtool/include/objtool/klp.h     |  32 +-
 tools/objtool/include/objtool/special.h |   7 +
 tools/objtool/klp-diff.c                | 192 ++++++-----
 tools/objtool/klp-post-link.c           |  53 +--
 tools/objtool/klp-symid.c               | 117 +++++++
 tools/objtool/klp-sympos.c              | 441 ++++++++++++++++++++++++
 19 files changed, 877 insertions(+), 114 deletions(-)
 create mode 100644 tools/objtool/klp-symid.c
 create mode 100644 tools/objtool/klp-sympos.c

-- 
2.54.0

