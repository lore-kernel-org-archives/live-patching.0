Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF483D8128;
	Thu, 23 Apr 2026 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917078; cv=none; b=fGWQuKDgOk9gFMr63IvNSSkqghNyY98WuHU4yWRjg79IpSvWDa+l8zWQj7JTP1hFRNenSnxN34VPW6/XmVUtgv3ge74DFU+ofPGARpV7KU9q/y35S205NDNmkgQgZZWKwiSPBJHWNSj4a6778XF9ywhsho9UJFczVEtjpF51UFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917078; c=relaxed/simple;
	bh=1Yg1WyHHwy/0H2Hyiv4fKLbjE8nOHP0jcAPFhtPhwmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2ICY44874ELcSpywQ4oOcHc2nqpqauBMjEy3qqJALKS8pILYdjGq8TtaJQd/SpH/rewAhZOi3cR1WWv0McAY4y9uHTmWSS5RchyyKvoC7EdfuWi6nBECUKI3jLMYfgd3tjHIt5ysBvEr2rPnln6XRzsf0k6EG7JivMsTYYzlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+BEhp90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+BEhp90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64267C2BCB5;
	Thu, 23 Apr 2026 04:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917077;
	bh=1Yg1WyHHwy/0H2Hyiv4fKLbjE8nOHP0jcAPFhtPhwmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+BEhp90S2/pTZYmbAeudjUuutJYGuZirc5cLg+dQE4S4ZuENehhW1QJTpUQNa++m
	 rNkNfdXJsjY8xwq0sbGfEyxRZBkYxKCdgt96zw2Eb7bZQmBzIcQfKK/x0k9WDYgTmy
	 xcJVvAjiOMLPbITUAYdwOcGyaKW8pBG0ERNhwTRjDWt4olhtBp/PQLUxfowV3vvqq5
	 8qUfqbtLN4bG1CXK8FFml89FMWqG8fIyQhB/zPtteZES5I7H8Hy0XdUuf1MhOLVaWo
	 i2Iwwo0t0xRNFwekJej30uJwjJM2aXOuPW3pbjHWcIceof96Kpf6rDJvQ4lPhiLZcz
	 8tgJMm8Ld2AXg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 28/48] objtool/klp: Create empty checksum sections for function-less object files
Date: Wed, 22 Apr 2026 21:03:56 -0700
Message-ID: <199a3d975e8e562421edd342b9eda242b4f57a71.1776916871.git.jpoimboe@kernel.org>
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

If an object file has no functions, objtool has nothing to checksum, so
it doesn't create the .discard.sym_checksum symbol.

Then when 'objtool klp diff' reads symbol checksums, it errors out due
to the missing .discard.sym_checksum section.

Instead, just create an empty checksum section to signal to
read_sym_checksums() that the file has been processed.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f14212a8c179..54ceac857979 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1044,9 +1044,6 @@ static int create_sym_checksum_section(struct objtool_file *file)
 		if (sym->csum.checksum)
 			idx++;
 
-	if (!idx)
-		return 0;
-
 	sec = elf_create_section_pair(file->elf, ".discard.sym_checksum", entsize,
 				      idx, idx);
 	if (!sec)
-- 
2.53.0

