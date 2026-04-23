Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F293CAE88;
	Thu, 23 Apr 2026 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917065; cv=none; b=Fl9gsNwbJ0jPS8/vadvD1OI5JbBVtkcUE9Q+Vb3iiSNqmR341QudbTWoeiKCtAYOAm74/nRPDJKZGOk83n6uUFP811KnrA2I/6Ztqy2LD1DULWawtahLvEIdVwlEsA43N/nTlNseMmN8P5bRJUGQwh8fcOa7kAQ+9RIYOfqqZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917065; c=relaxed/simple;
	bh=v1/YJzbW78of1CWH8JzZKZQJi1ocZAKbzDcRsWSyYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8+7BIKkkKvxgSefLgwe5W8eZAuaNv0RucPWNKBMxW1FZFl3MghHKezZMsxzYBs0SyQcJuGIzDHLotYXc+HbUP5/ntcxVbysG34/ktbFwfTybfc0Nf6uP1nb/6T1WMWhXv+fRL62UDelVBuJyFOcMsZjcr2zZT4Rf+YXHrx4A+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd/UpBJR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd/UpBJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB049C2BCB4;
	Thu, 23 Apr 2026 04:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917065;
	bh=v1/YJzbW78of1CWH8JzZKZQJi1ocZAKbzDcRsWSyYUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bd/UpBJRcj60h8ndcdZ3gMivL5+djsGqFUhrx2KqjFAaR26m7RCUtBqRAnAYj+piQ
	 9c6p/EKw/dfEyYvq0IbT88w24h7ZRVt3Sm3pza8+1uTD8u09RM4jrKkhcAKnEmrUlD
	 KS2WTe+jRxN9RjAtIF8V8svK0xTQNqwy/6eN3q+5lWyWYuSm7kKTcuPQfpbeOiZCr0
	 3zK5CzoXPjMun1eSKB2OKHdgXm02lVyQfwz5FY6Ou7/3WTRlPSG0abqsnjZD9EK3c7
	 zmFxKiw5WbqFLQyuTTQ4yxtsdWPximFqrpV9hWq8O7vl/l2EIhKelzhXK71DBZv/Ur
	 K3ffavY3K/gPA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 03/48] objtool/klp: Don't correlate __ADDRESSABLE() symbols
Date: Wed, 22 Apr 2026 21:03:31 -0700
Message-ID: <ea9af1b6136e9aa11589e592d0fc59e4ef414579.1776916871.git.jpoimboe@kernel.org>
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

Symbols created by __ADDRESSABLE() are only used to convince the
toolchain not to optimize out the referenced symbol.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index cb26c1c92a74..36753eeba58c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -352,6 +352,15 @@ static bool is_special_section_aux(struct section *sec)
 	return false;
 }
 
+/*
+ * Symbols created by ___ADDRESSABLE() are only used to convince the toolchain
+ * not to optimize out the referenced symbol.
+ */
+static bool is_addressable_sym(struct symbol *sym)
+{
+	return !strcmp(sym->sec->name, ".discard.addressable");
+}
+
 /*
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
@@ -365,6 +374,7 @@ static bool dont_correlate(struct symbol *sym)
 	       is_uncorrelated_static_local(sym) ||
 	       is_clang_tmp_label(sym) ||
 	       is_string_sec(sym->sec) ||
+	       is_addressable_sym(sym) ||
 	       is_special_section(sym->sec) ||
 	       is_special_section_aux(sym->sec) ||
 	       strstarts(sym->name, "__initcall__");
-- 
2.53.0

