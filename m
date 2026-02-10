Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2D33893D;
	Tue, 10 Feb 2026 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770760225; cv=none; b=D6xE4E+RutbJFd89GOa5cTb1FrTUv8P7GaZbF40R0NM1IxYUd2OZvtZzbaeV2Ktk4OXiqsXS368W/oxHSJ9CT6PbuxPRoelH7Oy4COicNilFyTXd9haVJJ4MjjjyNYaoMngVEnisYOGOLXDvUtFbvos1RM4I0TsJ8OLe7oygTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770760225; c=relaxed/simple;
	bh=kCFGPObFBu8qXIKo6upQhx1VBMY7BjzgFVXVj1l9Ivs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNgRgN9bobTB4KwxnTwoSMdiUmXJzfB19ZjTehkcqRmFLuacAkD4+d13+pY4h+n+LyKS/Vy0NebgeYae+Z3qgZHktJ2bVuqNzDxLvUcIJnBklEvY+ef8IBoW4SpKUczSiJflidjz23eTUMS6wDjw+8VNKHAJGJDkkjLJfctMgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amUSt5Tu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amUSt5Tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6743CC116C6;
	Tue, 10 Feb 2026 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770760225;
	bh=kCFGPObFBu8qXIKo6upQhx1VBMY7BjzgFVXVj1l9Ivs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amUSt5Tun5UdJgct+4Zk2yiFrladdHVsJu0OPqKQN4byuwkdYOw/xf06rzpZ20JgG
	 95ZPeSTLnwBvIBuKb/2rXqztnIFnN22BOGGyUSSOcKQCnUIf4i6Nxjm9FFRU/DvFL7
	 P0HbsZx5RGdBrt54bRqz28apHANKJBwSDCHRYb4XRHl+lCh+MZZkpT3q+hpiT5gAxo
	 +wd4c3bd6z/WQFoV+y8CvrTjVIdrGNgKYpJZfcW3fNVfcmmv6GnzLB0/jCAkC4tw86
	 H9c5/4zPl+chlwW22Kofs7eb4CIk5EdomA23ptleuKv9NtViduvUgJckLPk4N15tH3
	 pCdq/8qQGU+lA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 2/3] objtool/klp: Disable unsupported pr_debug() usage
Date: Tue, 10 Feb 2026 13:50:10 -0800
Message-ID: <3a7db3a5b7d4abf9b2534803a74e2e7231322738.1770759954.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770759954.git.jpoimboe@kernel.org>
References: <cover.1770759954.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of erroring out on unsupported pr_debug() (e.g., when patching a
module), issue a warning and make it inert, similar to how unsupported
tracepoints are currently handled.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index d94632e80955..9ff65b01882b 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1334,18 +1334,18 @@ static bool should_keep_special_sym(struct elf *elf, struct symbol *sym)
  * be applied after static branch/call init, resulting in code corruption.
  *
  * Validate a special section entry to avoid that.  Note that an inert
- * tracepoint is harmless enough, in that case just skip the entry and print a
- * warning.  Otherwise, return an error.
+ * tracepoint or pr_debug() is harmless enough, in that case just skip the
+ * entry and print a warning.  Otherwise, return an error.
  *
- * This is only a temporary limitation which will be fixed when livepatch adds
- * support for submodules: fully self-contained modules which are embedded in
- * the top-level livepatch module's data and which can be loaded on demand when
- * their corresponding to-be-patched module gets loaded.  Then klp relocs can
- * be retired.
+ * TODO: This is only a temporary limitation which will be fixed when livepatch
+ * adds support for submodules: fully self-contained modules which are embedded
+ * in the top-level livepatch module's data and which can be loaded on demand
+ * when their corresponding to-be-patched module gets loaded.  Then klp relocs
+ * can be retired.
  *
  * Return:
  *   -1: error: validation failed
- *    1: warning: tracepoint skipped
+ *    1: warning: disabled tracepoint or pr_debug()
  *    0: success
  */
 static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym)
@@ -1403,6 +1403,13 @@ static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym
 				continue;
 			}
 
+			if (strstr(reloc->sym->name, "__UNIQUE_ID_ddebug_")) {
+				WARN("%s: disabling unsupported pr_debug()",
+				     code_sym->name);
+				ret = 1;
+				continue;
+			}
+
 			ERROR("%s+0x%lx: unsupported static branch key %s.  Use static_key_enabled() instead",
 			      code_sym->name, code_offset, reloc->sym->name);
 			return -1;
-- 
2.53.0

