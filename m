Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57E35A3A4;
	Fri,  1 May 2026 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608546; cv=none; b=g9pSgg3ZiWZudf72bzMhqWcTaFyuYap9Ytx6OgLrglwdx9ShwacQfrjHcUIZrLlEEssjJHqb0ud16+MoWAbkVZ8BUK5eyhmHFAaqKNVPCDn2tol8V/Gsd1SLfvwYdVddySXROZZYE+mnlgrkCqcm++WCSUtqIdapzUo1inebfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608546; c=relaxed/simple;
	bh=C6mO2sC+0qw428snku2YR7T+dAtQsZg8AqyYSoy1FIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6IyU5qtfHANlZ7nqdqVb1uKDO8kXVibzGvpWLq+D7mV0gEtNm9gO/wpQ+keJ4WtCcHA/Snyp1hh0H5RO/io9kXw38lgeMz+7nKtdd+2ECVIq8W5e6zSgpnbogob0sW+UiqjNGFaBFdWDgAFa/AYF6gWH+gzeQKCf0DHQQg64Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWkI7Jek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWkI7Jek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED1EC2BCB7;
	Fri,  1 May 2026 04:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608546;
	bh=C6mO2sC+0qw428snku2YR7T+dAtQsZg8AqyYSoy1FIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWkI7JekK6w7HBId1kcBSSczIfSuBPiEIvZUGBdXzkUh3FoeAixrCb70EDsQulMxo
	 H/mJfxwh53xszMVPjDEze+wp4f+DD7PlHFHJ+biT/LIOTDWG+2FnNlUNV9T5Idk8N9
	 FWXqZN3Y2ZZ1AODfhZx+aNIPH4bWAm46tojLSjiDidsJt/liznKHM3MJhEqbdpPeZC
	 mcTu3ATxbAnuIkAXO/3V+IRsEMe+oKhrbLBZRKcitoB7nCJQCwJbkK7+afhhkqHCUq
	 bn0WoWeICnnHl79OSq6XuuJwNe3GjhJXhLDDx7wIpYR/4lMwENAYJolm0xr6XT5f34
	 TUk6QI3D/T9Bg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 34/53] objtool: Include libsubcmd headers directly from source tree
Date: Thu, 30 Apr 2026 21:08:22 -0700
Message-ID: <9582e7b77cb498a490bab6b93c1b330525f1a5c8.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of installing libsubcmd headers to a build output directory and
including from there, include directly from tools/lib/ where they
already exist.  This fixes clangd indexing which otherwise can't find
libsubcmd headers.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index b71d1886022e..a4484fd22a96 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -58,7 +58,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
-	    -I$(LIBSUBCMD_OUTPUT)/include
+	    -I$(srctree)/tools/lib
 
 OBJTOOL_CFLAGS  := -std=gnu11 -fomit-frame-pointer -O2 -g $(WARNINGS)	\
 		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS)
@@ -135,7 +135,7 @@ $(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT) FORCE
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
 		$(HOST_OVERRIDES) EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
-		$@ install_headers
+		$@
 
 $(LIBSUBCMD)-clean:
 	$(call QUIET_CLEAN, libsubcmd)
-- 
2.53.0

