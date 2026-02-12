Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DB26E70E
	for <live-patching@vger.kernel.org>; Thu, 12 Feb 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924166; cv=none; b=uk5K8c4i9cWrAfKV4VfYZZoIfgEv+yODf2YevmX+6FTRC62wGb2uODE4fYuHRVZbp6tGs31ReN4VJuVXr+PRLHRZkKm1Rvry86T8/1JdlhYYFIt1oSH1R6LQmKTsNO5HxrhO3cF+hRdSgXhCPs33XnsTsd/bLVmSSLSK1uubgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924166; c=relaxed/simple;
	bh=eKr5J9budkSlw7R2Xgj4GlPzCqaaiSuLkblPDVyEOjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msb5qmsg/WVolMhFKCpW3rM1/d45Nomk7/zR6QwQniWlNn8xxvXuPRdjCISOAIDHsMSGWR6m5/QsarmPcehyh29tYkyfe7C+locJ9lR2z8kGG4JEmVIvS/kD9uHKrXT1g8Y/avijzbb4oE7k9HtZzMnsQ+qRmuO4EPcSNDid74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgSRCZ/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgSRCZ/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1F5C16AAE;
	Thu, 12 Feb 2026 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770924166;
	bh=eKr5J9budkSlw7R2Xgj4GlPzCqaaiSuLkblPDVyEOjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgSRCZ/lLWs4HyXeKl3jFFpYqu04Ih+GhP1KBHh8R2ZKCFF0fD9+HAIsaaCxi0jY7
	 iDNJxzN10cH1wEU9PZCvSpqoswK48sJgMauV3fwAIow5VyKTPDj+7pHX4gcn1IOyD/
	 xQKxlSxUMRbHeozB9RFTUTmcCvOpaaGXPH4DOdlvZMD6d6HlM/l75JoAqlP7RPJDhq
	 jEbDH7gVFh+wRdMF2808qHbJ1pLA9ZsgJ+AtE5uRylDk/3o9bg50u6KKMWUwvEIxcb
	 UeiX5/PelOZG7/uMFZUchIqHzPqBJOJQCWo5I3JG3D2lisFuRfyJDesWCpLy3SXdmd
	 50TLJpS4YHZng==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH 5/8] objtool/klp: Remove .llvm suffix in demangle_name()
Date: Thu, 12 Feb 2026 11:21:58 -0800
Message-ID: <20260212192201.3593879-6-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212192201.3593879-1-song@kernel.org>
References: <20260212192201.3593879-1-song@kernel.org>
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

