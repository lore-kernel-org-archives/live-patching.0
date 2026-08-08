Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DE274FDF;
	Sat,  8 Aug 2026 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231097; cv=none; b=aTo0ml2wN5iOIeyRs3rGWJHX+JZKVJ0hAX1IMLAqBCc1yp2aEnUKViu4RHjTTadXUlbmQb08lhCsq8F1npuOC1+cEWwdLFCecVU/8pJFxEvKBNI0948+PeikbILLr8RTCyuqRl/q2+sfJbxijCEONZ/4cHvY0JqkVP5VUC0JAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231097; c=relaxed/simple;
	bh=5TvAEjJ0vEgTad93AWEUV6JQbHkseHkHYTqDVQaJeJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM2S6a02vIgi570bQBQdr7PSRrQ/sx1F3sSeXZPKrBVcuy7vf3SsOs2KiumAHLTN7TuEC4EA8Aumhzq8rd5LXOX42MMrizYygRR7zo5i8fY4l7Qec5kI/69jgBG8AymtLGVkOCKaNQilSLsszu0Ady75+xgBhhvvqhHC2H2D0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA4CAKDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA4CAKDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76571F00ACF;
	Sat,  8 Aug 2026 23:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231096;
	bh=BARDdhFoahQ9F/MLiUXn4Su4t2tJaLiVM0v0FWkHGjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dA4CAKDWmEN732KykWiAq94Sk+BCn9L3T1KcjWyeqRnA0qDhLVaP5EUXE4h6pIGxF
	 Tih0eNcjb+FqL7zo5hGK6y+KrHueKdAACyKp+IV/Cjwlhpr28pIMx4371XdDqOltXN
	 JJnufDKpBGBqlTjtuvSWSKmjIpGkv0XCCGkGuR7DHi4fZEN6FKyfNB441dtewfZ5nP
	 1WntBAma9kt/sjLQ7cai/x6c7/Gl0W4XrEYhmSy0Jonsm6qnsxL9P/aT6ADIR43Cxx
	 CzaqsHFG64QDxOA7lajCxR5CUPJ3NDc5BO5/Xe3BGWmMfn6spQfYZaQAe54JTbn2Er
	 EtKrpPbUTHjkg==
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
Subject: [PATCH v4 01/22] objtool/klp: Fix .kcfi_traps special section extraction
Date: Sat,  8 Aug 2026 16:17:05 -0700
Message-ID: <8faaead205b219607b6fc2359ae743be824056eb.1786230311.git.jpoimboe@kernel.org>
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

create_fake_symbols() creates a symbol per entry for special sections.
It does so in two steps: first for the sections which have
ANNOTATE_DATA_SPECIAL annotations, then for the rest, using entsize or
the reloc count to infer the entry size.  The second step skips the
sections already handled by the first one by looking for a symbol at
offset 0.

That heuristic is too fuzzy: with Clang and CONFIG_CFI, it misfires on
.kcfi_traps because Clang emits a .Ltmp* assembler-local label at the
start of the section, so no symbols are created and
clone_special_sections() extracts nothing.  klp-build still reports
SUCCESS, but the livepatch module has no __kcfi_traps section and the
traps for the patched functions are lost.

Look for the actual fake symbols created by the first step instead.

Fixes: da4326573ae8d ("objtool/klp: Fix kCFI trap handling")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Closes: https://lore.kernel.org/r/akQNqlfFC0T5pcMa@redhat.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/elf.h |  1 +
 tools/objtool/klp-diff.c            | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d9c44df9cc76a..a82517a76a0f6 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -97,6 +97,7 @@ struct symbol {
 	u8 included	     : 1;
 	u8 klp		     : 1;
 	u8 dont_correlate    : 1;
+	u8 fake		     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b6b72ed71bf02..890de34d1fa27 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1629,6 +1629,7 @@ static int create_fake_symbol(struct elf *elf, struct section *sec,
 			      unsigned long offset, size_t size)
 {
 	char name[SYM_NAME_LEN];
+	struct symbol *sym;
 	unsigned int type;
 	static int ctr;
 	char *c;
@@ -1645,7 +1646,24 @@ static int create_fake_symbol(struct elf *elf, struct section *sec,
 	 *	       while still allowing objdump to disassemble it.
 	 */
 	type = is_text_sec(sec) ? STT_NOTYPE : STT_OBJECT;
-	return elf_create_symbol(elf, name, sec, STB_LOCAL, type, offset, size) ? 0 : -1;
+
+	sym = elf_create_symbol(elf, name, sec, STB_LOCAL, type, offset, size);
+	if (!sym)
+		return -1;
+
+	sym->fake = 1;
+	return 0;
+}
+
+static bool has_fake_symbols(struct section *sec)
+{
+	struct symbol *sym;
+
+	sec_for_each_sym(sec, sym)
+		if (sym->fake)
+			return true;
+
+	return false;
 }
 
 /*
@@ -1737,7 +1755,11 @@ static int create_fake_symbols(struct elf *elf)
 		unsigned int entry_size;
 		unsigned long offset;
 
-		if (!is_special_section(sec) || find_symbol_by_offset(sec, 0))
+		if (!is_special_section(sec))
+			continue;
+
+		/* Skip sections already handled by step 1 above */
+		if (has_fake_symbols(sec))
 			continue;
 
 		if (!sec->rsec) {
-- 
2.54.0

