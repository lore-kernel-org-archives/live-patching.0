Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1A3CEBB7;
	Thu, 23 Apr 2026 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917066; cv=none; b=BphGAbYzAnCk6bU0llcgXr1hB4+/f0JzSwGgxw7E22M86B7uNvHa+W9QphfuxqIr8QzWYuH6kg6a9zSWlJl6fsZNkdeUABK/bAYQCZKb//P5C7Wffq0NIoYTuBnky+uaxm3GaVnTs92Xfpwc6BoYZAYR+gvZ0n/9ISQK6GusKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917066; c=relaxed/simple;
	bh=HnzSw9B7ABZdAUJ8CrWgBNLplWHA42vKKzWDFcZRmYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtyh0BRCxaKTM7aRadEzw8GZ0B4GFMIVmnsxYr3iKUrzbZ5eNO275c4LiwMaL66VZt/VKp5rjIrmh3wBVjF/Llvulh445P5TMjK7HPdpPk8+6cEdmXgruILn2PzaTvWq6xT0pROQ/z7LNu7yxazQe66oSjMEBQPdcAp4xfXPEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPM9KZp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPM9KZp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5670BC2BCB2;
	Thu, 23 Apr 2026 04:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917066;
	bh=HnzSw9B7ABZdAUJ8CrWgBNLplWHA42vKKzWDFcZRmYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPM9KZp7chTUZFxT/grSTDssHWGe5slGOBvpd86CGtsY/b+qHpfKMxidoTmQ5C4JI
	 AR1CIoOqqc5+A367vVAYOHqaK8XcCv/dMzSnaAZeZmmfVON1jHHN4H6mRU5sz88ZzH
	 pb/tM4myygYmuSr/77fkyjcHlDEO6PQbbqGryvRkpWJEFXN9JFr6uh3JYkA13cgs/I
	 OruSSTv/lkG0O+xkxK8rYZIDKKI7tZOan6qH75qnX1FIShAEN1b6Z1U6cR6jINIY6G
	 ZFeDTrkPXADvCkrIWBXd1epx3QcsqDUA1uFXhRTJECiS/8htVUbUfQJBIBn5xcv+Cn
	 DG+nQwHsOl0Pw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 06/48] objtool/klp: Don't correlate rodata symbols
Date: Wed, 22 Apr 2026 21:03:34 -0700
Message-ID: <602e405888ab38cd08de4375060b56db0965651d.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some crypto assembly codes define the same local rodata labels (e.g.,
K256) which get duplicated when multiple .S files are linked into the
same composite object, triggering "Multiple correlation candidates"
errors.

Correlating rodata is tricky anyway, and not all rodata is associated
with a symbol.  So just don't correlate any rodata, so that any
referenced data will get duplicated in the livepatch module.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index ea9ccf8c4ea9..f6597015b33b 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -374,6 +374,7 @@ static bool dont_correlate(struct symbol *sym)
 	       is_uncorrelated_static_local(sym) ||
 	       is_clang_tmp_label(sym) ||
 	       is_string_sec(sym->sec) ||
+	       is_rodata_sec(sym->sec) ||
 	       is_addressable_sym(sym) ||
 	       is_special_section(sym->sec) ||
 	       is_special_section_aux(sym->sec) ||
-- 
2.53.0

