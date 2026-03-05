Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F7283FC3
	for <live-patching@vger.kernel.org>; Thu,  5 Mar 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752545; cv=none; b=fItnt4KLCKBIfg/IqQoz/IC/rei83pV8A6Gl+WN3vb/nNfNbChViYYTohyCsV0gH2pm2oOygFwqlLHKkHK5/nL8E4K1NgX583oFkcYlJn7e2d9dqR0Hcihctx8FzbWUj0HqYop8XJbJcFwIerIuDRfaniq0JeWNGQQyN8evJaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752545; c=relaxed/simple;
	bh=9c79cLwK/qnN0zUt8qcTTuwNUZADb8I7V398jhK5Hao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfJTAaZbc8Nb0olnfu3hJ0J+5jhFAkwJ3M05ss2ubdSDMuCh/mbKhQlShgpeVX24WHqa89Ps7Mzq0xxdCXIY/3KleI4WRMGM5VyNbm+7oICBAmZD5XwSi0VZMnTYjmb9B+vuRQXXjHX+JuMSwtwamVRnqy/HR2uHvmJg4Sq5nZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnRQdQrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnRQdQrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1155FC116C6;
	Thu,  5 Mar 2026 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752545;
	bh=9c79cLwK/qnN0zUt8qcTTuwNUZADb8I7V398jhK5Hao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnRQdQrfZ1AgH6IFjHec0Ptvm/uv7yb9ZfGlDd6p1mTPDr0D0fuYK9J2Qhef6el4V
	 8tNGRwhKZzz56UBeSUwrV4+8ypxHWByk0sM4Czb3nEXUYBAtm973m94RPttezxY0uq
	 YUvfKjDoAW4/7DViufBVyjrz0ABYFmcw3Q4ENwygR5sGlpgCDKTnfFh5fkOm4EHQfm
	 TT+Y3+xsYmc79fzt24p5Zj7RFFqWwehU9RQ2CmXRGy6cbP6EacZcSRNRE+LWGvMcA1
	 bzT+PmFclgHnrLMjboKQYqrDeu7l2xw2oZipdSFJt3elp+shHV06HVvI96wt6SaBx7
	 Oh7v8sZ/UUqqA==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 2/7] objtool/klp: Remove trailing '_' in demangle_name()
Date: Thu,  5 Mar 2026 15:15:26 -0800
Message-ID: <20260305231531.3847295-3-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305231531.3847295-1-song@kernel.org>
References: <20260305231531.3847295-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_LTO_CLANG_THIN, it is possible to have nested __UNIQUE_ID_,
such as:

  __UNIQUE_ID_addressable___UNIQUE_ID_pci_invalid_bar_694_695

To remove both trailing numbers, also remove trailing '_'.

Also add comments to demangle_name().

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/elf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2c02c7b49265..0d93e8496e8d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -441,6 +441,19 @@ static int read_sections(struct elf *elf)
 	return 0;
 }
 
+/*
+ * Remove number suffix of a symbol.
+ *
+ * Specifically, remove trailing numbers for "__UNIQUE_ID_" symbols and
+ * symbols with '.'.
+ *
+ * With CONFIG_LTO_CLANG_THIN, it is possible to have nested __UNIQUE_ID_,
+ * such as
+ *
+ *   __UNIQUE_ID_addressable___UNIQUE_ID_pci_invalid_bar_694_695
+ *
+ * to remove both trailing numbers, also remove trailing '_'.
+ */
 static const char *demangle_name(struct symbol *sym)
 {
 	char *str;
@@ -463,7 +476,7 @@ static const char *demangle_name(struct symbol *sym)
 	for (int i = strlen(str) - 1; i >= 0; i--) {
 		char c = str[i];
 
-		if (!isdigit(c) && c != '.') {
+		if (!isdigit(c) && c != '.' && c != '_') {
 			str[i + 1] = '\0';
 			break;
 		}
-- 
2.52.0

