Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7C3DA5C0;
	Thu, 23 Apr 2026 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917078; cv=none; b=UpAbLf7HZom8ev4omvjg7b6l8mLnIUGuoZxdkMo4exd1H+ifzypUIpxueq1RxvNIxuS+vpCcujcK6UVPIC7itQO8LoF/06mGIv8X4mai6ywTi8BzaWKSWOSwouIiI2tqNRsgUL2sRkryCXuCgdwMAzXU90hbVgLxzFjX+nVaZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917078; c=relaxed/simple;
	bh=7Qo3koABbYsFQ9v2wstd1aYbFGOa31F2LrdyiuE6QIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEuSQiTFDI0p4C2pqpMoAan0VmH0zKuECXvXfNxoNFJ/6Ip2P1XxBnzZbkLZ3kmnrw1XXdoShkojb+RFs86/YVO4k7Uv6esbFXEPwd73jZdjYzDnTli1QY2f/gDePbZclt+zeuza/C16nhY+CK1DIrtxjLBC93niJGHLTrK66Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr6tNusV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr6tNusV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FFBC2BCB9;
	Thu, 23 Apr 2026 04:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917078;
	bh=7Qo3koABbYsFQ9v2wstd1aYbFGOa31F2LrdyiuE6QIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr6tNusV7nYG66unsYMJlbD/Y06sS36HSpMa1No5ZPd4KySGbUvy6pP9weewce2bi
	 ZEpRg8ozaW69WckfsYSuQ3bXbg9YATZkPcTsPba9Y9WBSyNWSxYJFfsZveOT6H0dmo
	 fWEBxr/kDXXhM1vvbFcv+7dJwaE/u2PsIkwvGaR2soknJv2TbAW2jBc81AqyCcyeJw
	 H61O9+Z018Q0G5dQ7M7KWc/FC0lo/qE75MrhZrE93cbq02DvNGY7ThiEH1Tk4fVffQ
	 Xl6N64L3MSMZiJVT2gessfNTqwiBOWqlg31gyoTf55A/5xybh3OkFHawOmd2y6ljB1
	 QwYVzfcZAvmtA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 29/48] klp-build: Print "objtool klp diff" command in verbose mode
Date: Wed, 22 Apr 2026 21:03:57 -0700
Message-ID: <bf64851de287f98a2a94900df0dad7edf3d694c0.1776916871.git.jpoimboe@kernel.org>
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

Print the full objtool command line when '--verbose' is given to help
with debugging.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 48abbe43f1c9..84053e8aadd3 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -681,6 +681,7 @@ diff_objects() {
 
 		(
 			cd "$ORIG_DIR"
+			[[ -v VERBOSE ]] && echo "${cmd[@]}"
 			"${cmd[@]}"							\
 				1> >(tee -a "$log")					\
 				2> >(tee -a "$log" | "${filter[@]}" >&2) ||		\
-- 
2.53.0

