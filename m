Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049C397E64;
	Wed, 13 May 2026 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643273; cv=none; b=pZQ1/P9YOHKLjyspId5ErKPJrK5oTZcSjcNXbti487+xyBKLQeCHqMCFYFpL4gRSlgNMj4sgRI0TbkOweT30UIo0lmQ7YwpPHEVIHRCFUMu1Bad8DC1bj/WcSROxOlx5LjKDlPC3fzbd+4spJQNQDH9ft/K26ZNoYT4H95z04bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643273; c=relaxed/simple;
	bh=n0zIE5QeG6gMOvBsdlMrDubUOuT5GRIBXLzLQUDUXac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqQOYR/jictOk7nt36+K/xF6XpA/iJ9jZMmXwOd9bCbfMGE0FEbuVwlEZgDhKX7KmQHyub1jlur0wylYPa9wjLx/87FXPwzNyyr7SnPUESvkWAAIJucaBWnjizOC2GRUZwX67W8UNcPUilgznrhbswN+zm3724LoDquLkUJ6j64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chSi84cB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chSi84cB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78FAC2BCC9;
	Wed, 13 May 2026 03:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643273;
	bh=n0zIE5QeG6gMOvBsdlMrDubUOuT5GRIBXLzLQUDUXac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chSi84cBSWZQ3vzUL3u89G3N9UkMGoa2rbMgZTL5v+BTF/ePRxDq1c/2s30SEYtJ4
	 0jzWHcpTEs5Yxrc8YqDY7zEHdLB1cH1x671jbE1KI/2FuAqEs7CC/r/3TUMK0aPRXa
	 kI30DdQbO+kjLzdjIw+L4NSLEl5CyHgRaoQRialBRxHkEOZRoC38+emL1Cg95jAbUW
	 ailUe57izmbwMRjz/ilVClENE2MLHsRdCTq2f/IHOszs+Tjklf2cwdxU9IhDPofhDC
	 4TWJQCd4ESow0T88WmLujZ3DmnmaPbQ7KrxBMVwUsgeJTQEKxL7yOJ42uhZEAuABlL
	 SbMNTFZeb1byQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 05/21] arm64: vdso: Discard .discard.* sections
Date: Tue, 12 May 2026 20:33:39 -0700
Message-ID: <bff1bad8bbc43ddf123e91b844073229eeb56b56.1778642120.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for enabling objtool on arm64, add .discard.* to the
vDSO's /DISCARD/ section so objtool annotations don't cause orphan
section warnings or leak into the final vDSO binary.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/vdso/vdso.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 52314be291912..d5f96fa17e605 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -39,6 +39,7 @@ SECTIONS
 	/DISCARD/	: {
 		*(.note.GNU-stack .note.gnu.property)
 		*(.ARM.attributes)
+		*(.discard.*)
 	}
 	.note		: { *(.note.*) }		:text	:note
 
-- 
2.53.0

