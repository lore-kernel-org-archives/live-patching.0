Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75B26E70E
	for <live-patching@vger.kernel.org>; Thu, 12 Feb 2026 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924161; cv=none; b=sLuGGcl6yav7UhYE5mQT06W3/1aO8SWOiiH9okaluWzt13ax68T1ses0FRcrsn0TGl32UaZtJVafgVPf0Uson7Rs/RQorb9leMicax1q0bboAoV1tqOSg+lP+0AFMGJb0twVxTWD0SKZ830jAuvUKeHdBQLUJfOd/d9wB263fFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924161; c=relaxed/simple;
	bh=TLhRd3kSS4Cp7cPZphm+Lh5Lq6UmY3aYlOZ/EPRQil4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgpvYAE22UUeVlt6gs9uFVzY5R0YPywY3w8cpVq008E+sUFqBogWWZ29ZJNjgUaNEACNv9lboniJ58pux7ZpuVQLewREIn1AD62+qI4ja/BRXvzYt6nE42jMNY7b2sKnblHaU4EhY4qrexlui3V+m0Mi6DykYLFHJLgzjibfQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Py2tJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Py2tJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7835C19421;
	Thu, 12 Feb 2026 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770924161;
	bh=TLhRd3kSS4Cp7cPZphm+Lh5Lq6UmY3aYlOZ/EPRQil4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7Py2tJ28KzDVNJ0GOv+0fMq6OgSOV+V99nHZJnNE4Ej/9lzEgbM37UvvZJospJ7V
	 +tDY6xnoktsVC8y5ddPDdXyL96jmWO7SQ1dlTbdPfZfSJA7dTrrIXpP10wWY3bilct
	 GlomHQn/wRcOaU/PZXMdKfKqEv6kZdwpe195Tsfr6D6yx9hEaKyT9bukU74uDMpNsE
	 6KJGop1a/gpUsBZKlcjKgNdDBVgBVQd120//7vPhO7ibQIZlWXWUg+qmyPveGsDMN0
	 q9kCvejlsl8TMGi0iTaIiuXPe9l3Vdbv+3IOBmLq/Yk5KTOltBPU6+CrEOZDM+Td1d
	 E6rivDJMMyIiw==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH 4/8] objtool/klp: Also demangle global objects
Date: Thu, 12 Feb 2026 11:21:57 -0800
Message-ID: <20260212192201.3593879-5-song@kernel.org>
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

With CONFIG_LTO_CLANG_THIN, it is possible to have global __UNIQUE_ID,
such as:

   FUNC    GLOBAL HIDDEN  19745 __UNIQUE_ID_quirk_amd_nb_node_458

Also demangle global objects.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/elf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c784a0484270..d66452d66fb4 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -488,9 +488,6 @@ static const char *demangle_name(struct symbol *sym)
 	char *str;
 	ssize_t len;
 
-	if (!is_local_sym(sym))
-		return sym->name;
-
 	if (!is_func_sym(sym) && !is_object_sym(sym))
 		return sym->name;
 
-- 
2.47.3

