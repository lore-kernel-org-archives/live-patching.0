Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8B31E839;
	Fri,  1 May 2026 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608536; cv=none; b=jEjeufUwjzQ+vq8O4oBNEWc53NuhGZ3ugqteL27nGOWcgTXeHg+OvErefLtjBWjra3hdhFH+d8GHnXn374Tmsi21VCWiCqy66RaYjp29zNcs+y3L9Oj52wlxC1pNcgJK2V7/0vES1k0Oocni31tnyaRTiBnUI5SA7qfkNmsFIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608536; c=relaxed/simple;
	bh=XZoB30TRiIWGU6vD7AMbd49ugbJOhYtr+PZg8o6TBlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9NCUk9dG7J9Cr18nao4kfIx7ldWfOFwsT5EVHRgmMvpOOghRWlnK2cnSkaTbqBSRjsDMiOUNpsEdEhrmB4rOqyxOkXXzLTRwNtEC4TRSvwAuE94rgOjH2FQjOYm5FYlYb7A9xpHimZAp+LPJnXDQYJOvS/LhHdLE3lBbwLp2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqNCz/lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqNCz/lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01BC2BCB9;
	Fri,  1 May 2026 04:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608536;
	bh=XZoB30TRiIWGU6vD7AMbd49ugbJOhYtr+PZg8o6TBlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqNCz/lmIEbp4naZtF1qIaDKYWKIU1qiYAUuK1HFz1mFbkQH5gL1i0voopbBOirhp
	 fWYF2wg8oBfVPDfkOXZL4EiiygdcA2YovaeNqnccTk56bWG26zP0IYOkTLUTpEAGt+
	 iSV2WtmwXtDE7F+suBNLym17L01r7i32I2YG3vnQ8NrmXekotCb+djQwoPF7xTsDPB
	 TAh5VFnPNYbFvjs33MWFdEMHIzOzyiJTSy5Ub9U7sIm7GaYFnrN6cfz+i8lrw3E4WO
	 NH2eOnj6Zd0+MiWlFlPVmEw9JYq3Z5YBXXCuJNhZGAg2gYlRoKqGIYigR1SLcqMEHK
	 f2pTfvovMz7rw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 13/53] objtool/klp: Fix XXH3 state memory leak
Date: Thu, 30 Apr 2026 21:08:01 -0700
Message-ID: <5467cb2bca420351d4cc0bde19c2a340d2640df8.1777575752.git.jpoimboe@kernel.org>
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

The XXH3 state allocated in checksum_init() is never freed.  Free it in
checksum_finish().

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/checksum.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/include/objtool/checksum.h b/tools/objtool/include/objtool/checksum.h
index 7fe21608722a..0bd16fe9168b 100644
--- a/tools/objtool/include/objtool/checksum.h
+++ b/tools/objtool/include/objtool/checksum.h
@@ -26,6 +26,7 @@ static inline void checksum_finish(struct symbol *func)
 {
 	if (func && func->csum.state) {
 		func->csum.checksum = XXH3_64bits_digest(func->csum.state);
+		XXH3_freeState(func->csum.state);
 		func->csum.state = NULL;
 	}
 }
-- 
2.53.0

