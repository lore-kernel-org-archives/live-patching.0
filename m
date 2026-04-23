Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397932ED24;
	Thu, 23 Apr 2026 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917064; cv=none; b=HPgAjMbvJc5twfOZA8nOdJa/AgixcwsKXurltL5Cw3Ri9ez/Om1g+bUNKtUnjwbZgRk7ZIe/MYeiPcUh/FwklLCzxEFCiYZ+VUD3JZvPFa1nxzI3VaRfpZqSqgZGUmmDB0GG8y3+Y83cwZc0ILYgczvDcG/nSHaZ/gXThNkhzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917064; c=relaxed/simple;
	bh=m63KetNM8hjihetR3hWKARSwXrlz8FMc6/yAkKODq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3iIBQZDgzMCNXGrgHMttWD2rkyvTeHg9dnr0jrbjDmYGdChnP24sov0khbTDv5kFRx9UQvj/C6iUI8Ayz2DwKTmrnFNxTEQyvuz/Mjk5ftpj/bmqaw7LESfSiLdoQXETlouvStyE+PKk/Pz36SE8aOxVIoQq10iiXOCNMWBAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cthaEmPR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cthaEmPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D2FC2BCB7;
	Thu, 23 Apr 2026 04:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917064;
	bh=m63KetNM8hjihetR3hWKARSwXrlz8FMc6/yAkKODq4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cthaEmPR59tv0x35YlMswmRUajeUCH/x2qQ9kOU63AJLsjCm5/7kA8rYVCWR8jZiI
	 3lh9+bEkSzNGAVRHo/ucOfg9Qb7JQY8Y0cn/7vV3fk/jUYm81brakJbHnTHIbP5o9s
	 DAx5mfIA6/3m48Bht9DS9WTIYtzmINDnomcvsZP8KfG8XHdhs0qq0OpFPSur+KnOJP
	 kf1dpZ4g8PKOIcOY07FRXA8BlprdZm7oHdfTTaQ0fcj4qbYzI2G06hFl3ZKtV3m9bH
	 NNp6pfQPYXP2I2v8X0zDELifwKP9pdbIhDgCnpSh03DrC/GwYjLuoZ1FnWSpujMmPM
	 n0DbyUOBxpwag==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 02/48] objtool/klp: Fix .data..once static local non-correlation
Date: Wed, 22 Apr 2026 21:03:30 -0700
Message-ID: <f34990d29dd7642ada7843613c96c563043c28a5.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While there was once a section named .data.once, it has since been
renamed to .data..once with commit dbefa1f31a91 ("Rename .data.once to
.data..once to fix resetting WARN*_ONCE").  Fix it.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b1b068e9b4c7..cb26c1c92a74 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -257,7 +257,8 @@ static bool is_uncorrelated_static_local(struct symbol *sym)
 	if (!is_object_sym(sym) || !is_local_sym(sym))
 		return false;
 
-	if (!strcmp(sym->sec->name, ".data.once"))
+	/* WARN_ONCE, etc */
+	if (!strcmp(sym->sec->name, ".data..once"))
 		return true;
 
 	dot = strchr(sym->name, '.');
-- 
2.53.0

