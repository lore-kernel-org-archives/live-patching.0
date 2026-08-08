Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501E37F329;
	Sat,  8 Aug 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231112; cv=none; b=RFq8ovRKuMi0zUsSnX0Z7hNAqDy3hxf7fhGQuNozTzN2HIVSWBdRGFtB7vMogr210/FjXEWm7p6RHWlOscakhrOpdkwkzN0FgS9Svw2ziW+dpa9JZKbImASTNBwxkMqECsjuGzngNcvxUeoN3t6nAwVnOSgsNmwab/PV0fBo9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231112; c=relaxed/simple;
	bh=V+eEErxQDnBBQrhyc53lBJ4dCK27mIn0A26yak3HX0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBgZ5tnByi0RDwmTgb0qWMdmzjAIHXpaPQklrZ/LJWymZeg10OLQmt9Zq1ukOI6c1t+1dugPA/qFi6mWRUSdNKVoJnFx9379NuIGMNffbiRufMEsMYBiee3wshT5S0dmVC11lmXJG5MncAkIyqdlGbAINZDWv45BxVWkKVvtgQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYrYrO3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYrYrO3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2EF1F00AC4;
	Sat,  8 Aug 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231111;
	bh=8IJm04E1Jx6VRBFU9vtFpV6hpK6h8wmtKkvHTJRXIIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYrYrO3GWE5Ne93ezf2fcT3d/FJ+AsiTHKLc9c/ZlMmJUgtqy81RxerzfxRjoJkh7
	 +lMr6kZw+rwvrRFHt4ICuAbaCRhn1ZRiM4oQI9TAWCvjWWCaAOJExhZ61yp5uQmjhF
	 EOsNiUBP2c2VTjuZjjk05cQmmuaMK5it/Apa1kuhaQoTga5+4YTTPLNEQ5hqbk0+YU
	 G+pomKERkMtM8cmI8gShXr4auy1zISphl11+6ztbeIPXyBFQS3Jg5jQjGfUsGRzmjJ
	 ShU0uS+MS6t/1GCzxLMagrkioywKMpNprvWoUAnwZhZk5Y2zX5zECyLICylXJgeT4F
	 7BDSBTd7OQV4A==
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
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 06/22] arm64: vdso: Discard .discard.* sections
Date: Sat,  8 Aug 2026 16:17:10 -0700
Message-ID: <e246f9ed3b06724147ca801af3deea5e2cb3b80e.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
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
2.54.0

