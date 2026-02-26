Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329221F7569
	for <live-patching@vger.kernel.org>; Thu, 26 Feb 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067308; cv=none; b=U+5HmotnRZUflwF6Liab8Ja2zryR2DaLY5BrbWo1GeoXMZxdhyA6mv3qNWA6SmIGlI+aeN7wW+T2E+alP597xltG9qxu68E2HBwf+D8DNQmLD4AaEJdYT7mMVjC3XvjZDEDpKotE+RGzjAwNJL6PnB30AW8SJoYlNy0AYVVGKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067308; c=relaxed/simple;
	bh=eKr5J9budkSlw7R2Xgj4GlPzCqaaiSuLkblPDVyEOjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blT7YjeHtvRBdPQ4XJgYP57HxL/EBo/4wwTC6Kab+ZxbE2zO8ii8O4GLnZ+WWEzxFPpeEZDqcdkBPeUxrNXFHF71MPr38RSDu0cL0H8gXo4gmH4PpfU0tOpblF+LFtk26sTYEPFTKZSoiQU2fGAqibVngdYwnP9Irsve3agIGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZG0t4x8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZG0t4x8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25C1C116D0;
	Thu, 26 Feb 2026 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067307;
	bh=eKr5J9budkSlw7R2Xgj4GlPzCqaaiSuLkblPDVyEOjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZG0t4x8v4dEBnJrYMtFKrXCDVdYUFCq7ceW2CCGeA/Y8GgJUvBnmTSaNEzbuxA/w
	 siaTAKhnQsoZlTOCLXLiFRZR3713M6kRATJaPSHY+l4L6bC0cg3vuyYeYLGQKzymgL
	 cevsFMI26Q6iyH53rl7vLEA4Vl1V0VP9BA0kKUnJj7+pssWZjAmYo214k2Q2gcU6hv
	 YGNKcUaHmg+Sdl5Lz1yrne7yuscXRzPF8Kal7PqAQ04JU1ullNYnMdPCXZ/WkMBtP8
	 mfWlesWKEJL1Srl5vbWO4VN4JkCKD1VFTLzol04W08k99ps8UqibN+w401ZfvmCKp4
	 AF6gDDZsCA7Qw==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 5/8] objtool/klp: Remove .llvm suffix in demangle_name()
Date: Wed, 25 Feb 2026 16:54:33 -0800
Message-ID: <20260226005436.379303-6-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226005436.379303-1-song@kernel.org>
References: <20260226005436.379303-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .llvm suffix, so that we can correlate foo.llvm.<hash 1> and
foo.llvm.<hash 2>.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d66452d66fb4..efb13ec0a89d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -455,10 +455,15 @@ static int read_sections(struct elf *elf)
 static ssize_t demangled_name_len(const char *name)
 {
 	ssize_t len;
+	const char *p;
 
 	if (!strstarts(name, "__UNIQUE_ID_") && !strchr(name, '.'))
 		return strlen(name);
 
+	p = strstr(name, ".llvm.");
+	if (p)
+		return p - name;
+
 	for (len = strlen(name) - 1; len >= 0; len--) {
 		char c = name[len];
 
@@ -482,6 +487,9 @@ static ssize_t demangled_name_len(const char *name)
  *   __UNIQUE_ID_addressable___UNIQUE_ID_pci_invalid_bar_694_695
  *
  * to remove both trailing numbers, also remove trailing '_'.
+ *
+ * For symbols with llvm suffix, i.e., foo.llvm.<hash>, remove the
+ * .llvm.<hash> part.
  */
 static const char *demangle_name(struct symbol *sym)
 {
-- 
2.47.3

