Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC083D75D0;
	Thu, 23 Apr 2026 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917077; cv=none; b=NG511wpfi+vrpVQzy/yzaJk8eNA62usz2s1QKh2TbWJ6kjVChd97y2perdq4lwyOiSVSoeDRIIlUgnakBQH4ku+3iOPdjNknOnVCxGjguB+T78CAUERLtjGrUwqWipCJ8tsOCBUp4nw5YjKPgikfGzwqx9WNToHuOqbgwRJcbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917077; c=relaxed/simple;
	bh=AjMnfHekD59cKjru1WGxZYJOSyqqQxN6zRp36f0FFWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXCmlNkf+SjbOt5rrdKC8Xd05tD8HJ+IphCbNTWUHPG1nh4XqbL3QDI2RPqZ34AMvmTsLlpUqQvTjtAb/O2vtpWZFfM42bMA4/0L6ohr1YIliwHsH06Y3iJpm8h7QfD6Sv8VLZA37n3aAcWfaZQMKiumnEfwGSdhHvkCvlIsAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcYCXfLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcYCXfLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F73C2BCB6;
	Thu, 23 Apr 2026 04:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917077;
	bh=AjMnfHekD59cKjru1WGxZYJOSyqqQxN6zRp36f0FFWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcYCXfLdkWyruZRFWevSdvQ2tx72xbTqp7jNIWWHVgZJfaMe5QmMr9HeFRXsrsKYg
	 XpAHjX0WkF9AyO2EDb3KLFDmeFqSs+PvE51733juO0NZ2L23ebqaoyLue53d1mno2Y
	 fJpAn5g+Fh50WdcHhdsp6elQ1XAPlTQtTwtzgezP1FDQr4BIvA+Q7ky2pEO565QUoa
	 II0PBe2W7VcEumDVv9sxw6xSNj9HuVKOrElyX1QxUbL1FKl4tZd5u4NFvzN3/EXOer
	 Y3Ft8wuypjjdq55cNYd5OGVRxgH29x5D7TjVVYiKMSAn0zk2eOjuXKuKUHEjqh4lHb
	 FIHsoDm5PXDfw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 27/48] objtool: Include libsubcmd headers directly from source tree
Date: Wed, 22 Apr 2026 21:03:55 -0700
Message-ID: <d9acc0495f258f58703820274e6045ceb2198d70.1776916871.git.jpoimboe@kernel.org>
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

Instead of installing libsubcmd headers to a build output directory and
including from there, include directly from tools/lib/ where they
already exist.  This fixes clangd indexing which otherwise can't find
libsubcmd headers.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index b71d1886022e..a4484fd22a96 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -58,7 +58,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
-	    -I$(LIBSUBCMD_OUTPUT)/include
+	    -I$(srctree)/tools/lib
 
 OBJTOOL_CFLAGS  := -std=gnu11 -fomit-frame-pointer -O2 -g $(WARNINGS)	\
 		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS)
@@ -135,7 +135,7 @@ $(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT) FORCE
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
 		$(HOST_OVERRIDES) EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
-		$@ install_headers
+		$@
 
 $(LIBSUBCMD)-clean:
 	$(call QUIET_CLEAN, libsubcmd)
-- 
2.53.0

