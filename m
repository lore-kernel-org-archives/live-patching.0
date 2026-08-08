Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49830385D6B;
	Sat,  8 Aug 2026 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231122; cv=none; b=Bni2neI4DDqUzGMp1R4ltabPTbdkfEu1WHMcbAGKGHd2VxgZWrvRaxsm+okahhdrWtnb77+w/3en/9MnKvpsr1C28hPs+YWHjhQJZKH7bnKKBFquk7az0+U3pgAdHIhCOZxDQ4nmd6nKsV80JT31Cd45mGU9AAiJZqQIRPu68ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231122; c=relaxed/simple;
	bh=zWIcILwnaJABpKZunmDvRsbIFq/DGE03mUS5xRz5OH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnymkKFi2u09H90B5E2byCSnaU6Cb17GkO7iGtJOkcXb/azfY9awvTrU/Ds/9MHTZplhHQQwnhajHLXXSOV5a3mGZM9UUtwCz9jX1okHbRY+rVwcXHT5O4bxFUPB1/zxNi8bw7f2A65G1jS66J9SwNufWSbTUb5uqkAjEnHqdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT1iFVvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT1iFVvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D731F00A3F;
	Sat,  8 Aug 2026 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231120;
	bh=hySmyd731HI49avcL3mGbdogr26/7EmNX03BPEob+mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RT1iFVvGtNC2gfYcDpnLWRYJLfm5w7eX6mO4qrzXUAdm86P6zRE8FFRXT19V3JtGR
	 +VfH3Nk5Q+Q1URgGUrDDZfbE6zKOqIQGpnQHY1f5is8ymGHtdZ97PBso9YxLHoEJwC
	 yXv8N/H//e1dwgQp4GV741X/jt2uWPjbPsxAGewR2i6BrQBCyoss2LjIfRql4dEfE5
	 PgAJZOxOHwvDzZyPfFQA4qMe58nUTDW67rsfZEhkXCNYCKda3VgQ6Sztu2Xm4hUNGD
	 eePgLajX4W1sqMfi/ZG3OkaaKeEMtG17p7caU4j8GyTh+UMRhM1jmeCY0Zgi2AfEwm
	 myIaTm+M+i2EA==
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
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 18/22] objtool/klp: Don't correlate arm64 mapping symbols
Date: Sat,  8 Aug 2026 16:17:22 -0700
Message-ID: <6f447024ac8b79a1a6f1b8eb1c5eb1b51017af79.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM64 ELF files contain mapping symbols ($d, $x, $a, etc.) which mark
transitions between code and data.  There are thousands of them per
object file, all sharing the same few names.

They aren't "real" symbols so there's no need to correlate them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 922de4c8e9e89..d76d2f5b5acbf 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -547,6 +547,7 @@ static bool dont_correlate(struct symbol *sym)
 	       is_prefix_func(sym) ||
 	       is_uncorrelated_static_local(sym) ||
 	       is_local_label(sym) ||
+	       is_mapping_sym(sym) ||
 	       is_string_sec(sym->sec) ||
 	       is_anonymous_rodata(sym) ||
 	       is_initcall_sym(sym) ||
-- 
2.54.0

