Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD59283FC3
	for <live-patching@vger.kernel.org>; Thu,  5 Mar 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752555; cv=none; b=TpfrehZRW5fRbUPRc/SH3GxDaLax2lR9rhqrMlPpv7fhxVfmyAJ5eGPmi0uYA/ke2+xg7dFH4d4djorhdUk2Lv8fX5bcozWpf9qXYmclRhQNtnpV/Pw9VKqUym6fvPmD4X4rVOUbSyJL9GHrXcfXx2W3GT/1x9aAj/CMxk0gkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752555; c=relaxed/simple;
	bh=mtmHoRukU6cHqVWnwy02UJRMpnb4xWGhB+BmPtGM5Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmak9mkly8DsV10o1R6Yzv9o9WYp+H4XTCiSB50eF5QQYw5108X+0tAF/TZEBmmedXMvOOlWZfGXM38zhA6Eac38mJ78TBGRO0a5lsZmQiqAW/ezJ6Owo6CbjEotsv41BRoIfN3E5nd+hJbo/R5Lpm/DztzVU7taeQGaKH6z1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd1Giw+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd1Giw+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA06C19423;
	Thu,  5 Mar 2026 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752554;
	bh=mtmHoRukU6cHqVWnwy02UJRMpnb4xWGhB+BmPtGM5Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jd1Giw+W6td0j7voMDGxqSRptP3WjlPTrrmLo+KVwyJ/bJ5P7TuYKumyFMty3zqBC
	 AmovJX3x2iASczvmnO3MI2GJmY60adfyBqXiltv291kSvF+yV9ntMvxdbq3wCjPWEt
	 rNhWdVl6b6FT45ECWCOXfbuF/eWSin4lGA2i1yxar85Fj2q1fRuUsFxCVmI/EHMeoo
	 CVkpAjRu5jEleFq/IeavUz2sNahhO53cHy4OGKQkm0Sk+nmpLvD32qe5DTXCC7Pm6P
	 D/c3myIaJsmNYXX22I4OzCLFdsmRmKydZeOjKewYAF2cpjKhFS5SB28SEBPRB3De8h
	 RIcnaqd4Tdf6A==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 4/7] objtool/klp: Also demangle global objects
Date: Thu,  5 Mar 2026 15:15:28 -0800
Message-ID: <20260305231531.3847295-5-song@kernel.org>
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

With CONFIG_LTO_CLANG_THIN, it is possible to have global __UNIQUE_ID,
such as:

   FUNC    GLOBAL HIDDEN  19745 __UNIQUE_ID_quirk_amd_nb_node_458

Also demangle global objects.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/elf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d9f883f7cff8..78db51ebbed4 100644
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
2.52.0

