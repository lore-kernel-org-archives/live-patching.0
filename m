Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E917B425;
	Thu,  5 Mar 2026 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681514; cv=none; b=RAl9bn/4m9Bh9/8oOMcu1vUxoZ+yZR3Lil4bzthzchU6QlT+vznEIWMU0bRc5NxIO2I2lNGPFKm2RL1utQ17dmk9Qki0GbbRyeuPBcxNuC7vJypRtIeZS6ZtmEc8Z5HpalSAtZ3mbdTUfK6iacY8OK/rfJlsYLh7Szvfb1QmxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681514; c=relaxed/simple;
	bh=ppmEZTT0et6+FTja7lnUY1XDuKPDfDpEbcW91C3ymXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnI6frl+o9HJwLVAdIAhsJJJF8/bdH/uZZnOkbZB+LoLlUejFBtOwkbIFEJNZG/qDQl5oHJAfF/WMkWGCUGUbX74nbWwkAUaJRUfEfUBMVUzRqyIz0wILrQVWZMBRyDlWjuHLzwMxDjzmI0N5TeoW1Tz5XRCvY7Vszgw3GDC084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0yu4NsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0yu4NsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F35C2BC9E;
	Thu,  5 Mar 2026 03:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681513;
	bh=ppmEZTT0et6+FTja7lnUY1XDuKPDfDpEbcW91C3ymXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0yu4NsHtO8DNzcJksWB0ZAN+1FdSe4gSfSPR5ulL8YBtTvWbljhqmjMuLJzmTyh5
	 cZQrn03f0xfFudcFWEDGDC3ndrzA2LIckPKZMUjpPYW4kyt7iTLOMaiA19x7/1WaHk
	 xygjvmxlgVfbq5DKVJcLvM1Z5byXzbrR/EAb5Jo2UZ/Gp0t0tA94rh1cwuU6ITjhiE
	 FG19ExNYAmUgnGwaF/259f9nizSKnULJSElgKQt9IsPmjkdcuS7j6cDLNb+E9vCWwc
	 vsruqPRbKQiIXZizSM17qC+Shc5vD8qmoQSN2I6wRtkKKt3z0VgIZpw/2LhlOXJHpv
	 qvE4EInUL7oNQ==
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
Subject: [PATCH 08/14] objtool: Allow setting --mnop without --mcount
Date: Wed,  4 Mar 2026 19:31:27 -0800
Message-ID: <696aeb326a797e97b87c7657b5b3d0ada958cc5f.1772681234.git.jpoimboe@kernel.org>
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

Instead of returning an error for --mnop without --mcount, just silently
ignore it.  This will help simplify kbuild's handling of objtool args.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index b780df513715..f528a58aca74 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -145,11 +145,6 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
-	if (opts.mnop && !opts.mcount) {
-		ERROR("--mnop requires --mcount");
-		return false;
-	}
-
 	if (opts.noinstr && !opts.link) {
 		ERROR("--noinstr requires --link");
 		return false;
-- 
2.53.0

