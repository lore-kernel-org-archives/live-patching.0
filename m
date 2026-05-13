Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062A39E9D5;
	Wed, 13 May 2026 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643286; cv=none; b=oGtJk0eG3KQ7gD+vyyxkGtXtESx8KiFia1K+gmqVcP6rwkzqg3d4WF/xqvpj4AQ85aW5oJpgmLJ4zYFeqfuR9N3YPs1xjsqspJeQcUuYCpCHYjPNBT2HtmYBBEu3tv2SbE++uv1c5eKxPGCNU/IOIwfh/BVsL+iOq4Y201+tnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643286; c=relaxed/simple;
	bh=LhHK0lCryH3GfUbhtNycvw/+YpO/Fwf9dWZJEbuG8Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OY8vK6G6CUZPp0lbak7mhHH1Jvr4fqUZGEwMDLkoqGB295X2pcwqzHwpYGkfhqOU2hLxIXFnMa+dEry+3SkfEJp/Vb1myb/DcyKBOtoFw3Q7ixKIGFszr4Q6EEGzVojk8I5yUfIzMk4onvSA5CgjZ+un0ifMq8ZKMcDn/BEhVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/tFvFrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/tFvFrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C161CC2BCFD;
	Wed, 13 May 2026 03:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643286;
	bh=LhHK0lCryH3GfUbhtNycvw/+YpO/Fwf9dWZJEbuG8Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/tFvFrVE+31co7ylVIDjWOjNmaX8vCCQR0LCINPUs94sw2kTz+0254maUpshUOiT
	 CA/CSQQ6oueSY7HQM6mcKh/KNy8rQdZbJPed6mVRc1IAfbmTmO2RZm/xDr6IKIn9lX
	 pWc0sBZitrG/CGX7Ef+pHC/326riD58wC/iUhpmmpQiSkXD7L6lj6Z4AyPa38p9qS1
	 zPrGWzpH1DrmHMXu1iLaMHi2QxZCHpCl5VlZ6mR3PzTJLjI0MFZqT1PfSnSBZhHVWy
	 dr0GrxE7veL4PN6l5Cf8veHf+hecA1TR4kvEfMzgpcLpu7SyLslABQeq/MVyM5qB9m
	 /BQ4EyP76bCqg==
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
Subject: [PATCH v3 03/21] arm64: Fix EFI linking with -fdata-sections
Date: Tue, 12 May 2026 20:33:59 -0700
Message-ID: <1e5281cfb9a7daec8283e46e2879be8ec468713c.1778642120.git.jpoimboe@kernel.org>
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
Message-ID: <20260513033359.6RWTsX6oZ_7h6oMMlkq7hvXqrnoMqmJ53-Vz5SKgCqk@z>

When building with -fdata-sections, the .init.bss section gets split up
into a bunch of .init.bss.<var> sections.  Make sure they get linked
into .init.data.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3d..1ad7e3dba460a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -281,7 +281,7 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		INIT_RAM_FS
-		*(.init.altinstructions .init.bss)	/* from the EFI stub */
+		*(.init.altinstructions .init.bss .init.bss.*)	/* from the EFI stub */
 	}
 	.exit.data : {
 		EXIT_DATA
-- 
2.53.0

