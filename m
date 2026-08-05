Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE41388E63;
	Wed,  5 Aug 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940208; cv=none; b=HwEEUqVqEXr0VcqbJi51BrqbQU0aQ2a7zNqgm1olq4HP10xqzu9ZSa/l86htEvnpRRr03OtSQxwu+PpBr+Q8H4XTfiko4b0KUrso6MQ7CRjbPhH6bsJXYpf3qD651/8QYSmyZgHRSc90XDFOleImvoyeDog3wBrSxvoYgkEX9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940208; c=relaxed/simple;
	bh=ILuwttoIVxWUv1qsFsJFrVVzm2dt29D07uz9xDZYCF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSFvIU1cDyYI0NIAxaT4Yc8WCaUfIdle+Q7FM9newwXQR3b22tPC5G8A16xpzc0LitTwRys+LaB+SSALeRr9LraV08bBPJjZs80zynbUQ7tgcvW9B68m2Dtr3BCKIGvsZP14sIcmvsdTf2OqIH4ezbD9kFE0fq9M7lDnXg4LQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCe+2cW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCe+2cW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7161F00A3A;
	Wed,  5 Aug 2026 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940199;
	bh=OfBVF3pFAvjh2J41PP9wPkXf5AOKvy9xNyclzTxwI4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCe+2cW4Mv2ldIx3cF7ht8nesVRp4jOD+ghwHSMbB/RA4DoYUuSNjN2Yzic4NXwBQ
	 n5YXewza9k7+dkJ68pOlWOy+vRhXAlQe1RMp13KT2wfcq36nzDKNIJI1NiPnc/frcN
	 sz+smoFPe/v7wgCXiOZKHi+pUnIXMhpGCqF9e10/V5PUth7ErvVJE8W3HK0Bx8HoZZ
	 MdCG5wGmiMTU6tscCXdQGJmISVEOAxAsc1hjfqCSileofr1fqfdZ0Zu6imsIpDvozU
	 RWXB/xaXH0yZrXFVRYnsEZPg0C4mjmAtR01oy4kElBSWuPwFVDhzyr/9E/xz8y9lF1
	 vw11RRJ30PBfQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 2/7] objtool/klp: Fix size of empty special section entries
Date: Wed,  5 Aug 2026 07:29:39 -0700
Message-ID: <d9debc941bd06c1a606ed7a366bff73d1680f0f8.1785939903.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785939903.git.jpoimboe@kernel.org>
References: <cover.1785939903.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_fake_symbols() sizes each ANNOTATE_DATA_SPECIAL entry from the
offset of the next annotation, falling back to the end of the section
for the last entry.  But the last entry is detected by a zero size,
which also happens for an *empty* entry: ALTERNATIVE(oldinstr, "", ft)
still annotates its zero-length replacement, at the same offset as the
next entry's annotation.

So every empty replacement gets a fake symbol spanning the entire rest
of .altinstr_replacement.  That's harmless today only because
find_symbol_containing() picks the smaller of two overlapping symbols.

Track whether a next annotation was found rather than inferring it from
the size.  A zero-length fake symbol is fine: find_symbol_containing()
skips those, so the properly sized symbol at the same offset still wins.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 492d7a012cffe..11e8f3ddbb0e6 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1627,6 +1627,7 @@ static int create_fake_symbols(struct elf *elf)
 	for_each_reloc(sec->rsec, reloc) {
 		unsigned long offset, size;
 		struct reloc *next_reloc;
+		bool last = true;
 
 		if (annotype(elf, sec, reloc) != ANNOTYPE_DATA_SPECIAL)
 			continue;
@@ -1641,10 +1642,11 @@ static int create_fake_symbols(struct elf *elf)
 				continue;
 
 			size = reloc_addend(next_reloc) - offset;
+			last = false;
 			break;
 		}
 
-		if (!size)
+		if (last)
 			size = sec_size(reloc->sym->sec) - offset;
 
 		if (create_fake_symbol(elf, reloc->sym->sec, offset, size))
-- 
2.54.0

