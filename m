Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966C1ACEDE;
	Thu,  5 Mar 2026 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681505; cv=none; b=M22H8Iu8LFJZyRLNfG9bOitMQsWbpagbgvjPvl4hCaKTzeCGfa4ZG5hED+Cb7gWM/iPWIl+4Y2rncajbxxbBKypTni91MzxbRaYw5AHrMqUXFo2Awqk1YtwwaXXEBhU7RMve+oRTdfLcBykRAwlWGyGmxOxNE3uwQHNowuhcLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681505; c=relaxed/simple;
	bh=F51eVpZxhFC3Gpzdnw33QNuA5g1SCpkt9olp+lxSzPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJcNKd/TaV516uAofl2N2KrB8FZUjwU5t0PlSe/wsz3lhzzaFLN1IOONkpvVlgjf1og1uyVGdQGMWVhoWbxa51dF/DaVy4cqPYmO2VLj9RJOLfo4X9cidm/plROx5QGejJT4ZfKPvDReJ/xOQ28jiGLxLsw+20NfjlbPixUZDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9fJWr+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9fJWr+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6078BC19422;
	Thu,  5 Mar 2026 03:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681505;
	bh=F51eVpZxhFC3Gpzdnw33QNuA5g1SCpkt9olp+lxSzPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9fJWr+8/EYPgIy+nETT92JCLwy6misPFQtAuPPQjaN/shMLhthGzvGUlIz26UhZB
	 vyvuAlAa3HyYSIzfTwQWX1WXdVVHZbCz9p+BviQ9rZprx84nf9qV/3FLv+igNKDtmT
	 jda1IQQ0zXeVxffPxZNNypJHra8zALLENpoVhNwgQuC1GWp5umsoNHHDQUzLaSIO99
	 eFgCOk2H39DWNa/WqdVdkvemh0mS1pSyOobj4mg4KFLV0njFJ6Lg9vEsJ0zpxey1uJ
	 5THwDsZo1sG6R2kBcy72RnHiuv/HwUCTCxctG71bsm8gbp7NWog37iHB9z9fWU5HHV
	 NsM5El/vPn9sw==
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
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 01/14] objtool: Fix data alignment in elf_add_data()
Date: Wed,  4 Mar 2026 19:31:20 -0800
Message-ID: <d962fc0ca24fa0825cca8dad71932dccdd9312a9.1772681234.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772681234.git.jpoimboe@kernel.org>
References: <cover.1772681234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any data added to a section needs to be aligned in accordance with the
section's sh_addralign value.  Particularly strings added to a .str1.8
section.  Otherwise you may get some funky strings.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2c02c7b49265..3da90686350d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1375,7 +1375,7 @@ void *elf_add_data(struct elf *elf, struct section *sec, const void *data, size_
 		memcpy(sec->data->d_buf, data, size);
 
 	sec->data->d_size = size;
-	sec->data->d_align = 1;
+	sec->data->d_align = sec->sh.sh_addralign;
 
 	offset = ALIGN(sec->sh.sh_size, sec->sh.sh_addralign);
 	sec->sh.sh_size = offset + size;
-- 
2.53.0

