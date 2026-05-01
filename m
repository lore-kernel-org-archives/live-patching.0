Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190933148B4;
	Fri,  1 May 2026 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608549; cv=none; b=h+AgROeqQNRE4kQgT6f7wFhyiV8dglfriiolZjAlkUJ1Z51Ja8STZ+dMOJztAjzF1DXSpAgM/7ehpBRHInUsJRoXf9uwLDqplHaD1vzLf6cCL84CO3DqwO8b5+zFvZd6HBsi48HHQ9x2/ZS1/OohfQpj+SDvCdrnRlXHNOV6OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608549; c=relaxed/simple;
	bh=PAmYtqsZr0HcMy1tdE3sw+RY8cBvKIrfx2uuoBzbka4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQK4aBu29aXXvKDMq7gjEg89fuQbb9NTpw4A1E5rueO5Qi2Aydeg4DyI1EVvkKoS5whd4MqLMTkw4iuSWur9NOHKCMRGUej4Ag/ZYRIqlZPgaJy4bhvhVT8mF+bt2V/2GG/B1g5is4Np5X4unYEbFYN/tLM4AzOsxPIR085heyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWkc6ZUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWkc6ZUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694B2C2BCC6;
	Fri,  1 May 2026 04:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608546;
	bh=PAmYtqsZr0HcMy1tdE3sw+RY8cBvKIrfx2uuoBzbka4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWkc6ZUrTKd7wFbIs7KVl+GAEHAVmxpRLKaDEafmHX6/O5JZh2Prb/KaTwiHhZ1HM
	 6h3kyNqqKbhsU+HZ/byfLXjOBwJIqBCAwQjX18PIuNG0V9D7U5madz9EO2GUd1pWeF
	 dSVE//9Bzbb8dAxv8GINp9YKpBxRhVjpBkORfcDSxWZKVz6oieL9sJal3sCYdwzm3d
	 CCI1qiskSstCNDreTiCn/6ibbzsyz1u+jLi5/cynCvjk12vyZ0Qi398qnp9rkliVhx
	 CZ3Zy79c4dPqdkKLB4FknZvZ3Z2Qu/DXurJZGeW3tUuN0HEQQ7zBPk494C2cSmpS1l
	 QdfQoTIgR7hkQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 35/53] objtool/klp: Create empty checksum sections for function-less object files
Date: Thu, 30 Apr 2026 21:08:23 -0700
Message-ID: <94267cbd67da8e158153743b80f4d2bfb3f62b4a.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
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

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e7579c4e46dc..f020f21f94a7 100644
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

