Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0408330676;
	Sat, 15 Aug 2026 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769159; cv=none; b=ILhI5vRrhtdMlfoQ57W9O0uN6crropUisQnJnpl5wExOcj/gmg1Lf/28V+aOp2no54Txas4OlWMAoziSDzLpSWjXjGfJ1xmepfvlNEj6GfKt4UVf+hg8l7Yd5lK3JEaIdydgndDzPX+rOlLc4lJ/CSNWcww4lrH/5y60yXATsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769159; c=relaxed/simple;
	bh=e0rQStexMZ2GxY4wY8mMJZQNTPMCP8H7AcdPcXyqahs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j16v9VmxRHdYBIYRDdRfN/rVVECapflEoHsn7Az83E8Z6smBdScrLvzms5HVKWLnKLeG0qOMrpdVzeJtOkW7ds7S40Mh0Cgz699Wz9XbFoo7bvMkg3zj4COTbgEpuAmhYatNI6MCPX6BqAwIhPbmvQeoXms/S6WF9eDqZNW5SM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uds8CyUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uds8CyUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE81F00A3D;
	Sat, 15 Aug 2026 04:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769151;
	bh=pEo+RWxb9Cy4x3mJlC/JTMk3aY2wjCClrY8gzFpWMUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uds8CyUoF1Yopnalrb3vrGSp1Q4mPilcRNod/8Z5E79NsAJUV7kN6E8KsQiRZiThv
	 txwf0uf0ZhoRGhI+VbfmdzCqZ2te2ok20qQCpr//+LgJRGrSxmYigTtUp4NUlo9+cK
	 0b21ZzCEfVeRIqBfhkGXXsM6tsR0kUSCfnvC32Kbk6XZmKm5rwjqXUvBe39Gn31Mlm
	 /jN/eykVUsiIJl+rUOCu26NFUJKI8d/OWsZjGbs0LXHuj+YEt4kZTY4gMNgpEjjW9k
	 v4O0wdtksJhj4d4YMMwnXZmM/Io4n48I79x/7xM9kMV8ecYQGd79l+UWbEFRfy55GZ
	 IbSApACY/8QWQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 12/12] arm64/bti: Enable kernel BTI for GCC
Date: Fri, 14 Aug 2026 21:45:29 -0700
Message-ID: <c08ef46772d364db9b904fac0861adbb3a3bd4e2.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c0a454b9044f ("arm64/bti: Disable in kernel BTI when cross
section thunks are broken") disabled in-kernel BTI for GCC because it
omits a function's BTI landing pad when it determines that a function
can only ever reached by a direct branch.  The observed failure was a
module whose init text landed far enough from its core text to need a
PLT, whose "br x16" then hit a function with no "bti c".

Note that behavior isn't GCC-specific: Clang 21 has started ommitting
landing pads as well.

Now that all the known BTI bugs have been sorted out, re-enable it for
GCC.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2687b71438661..e150807b03016 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2114,8 +2114,6 @@ config ARM64_BTI_KERNEL
 	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
-	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
-	depends on !CC_IS_GCC
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  Build the kernel with Branch Target Identification annotations
-- 
2.55.0

