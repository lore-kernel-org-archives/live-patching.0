Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794890118;
	b=VQi4GjZXlHkzyUTdBkcWJRytLsaSL6qX4p8E6EXqa1qZUFJg6CfoVd3o8YZOiNqwfm+K
	 V6dZEyOkuJhFpbFZG4SZ0H1i0wgKmZcuKBupIv4DvLlAHUxB7x9lRI+EF3nqZMhkJgoYs
	 TeCWaRHxXS7uvSJ1kLSx+OIpdJ+B3hoWFMP76ECQRw5T8fo6200H86KsPm6bKyWRgUckN
	 gJj7U4/XOPsbOpxUGmG+tUxcmUBI/5sG9Eo5IkYJ2P7vHaDK0f+/eKfH4+dRoVMxCNSnt
	 JvPbU2sKu1IeWRSMgNHoCfT/I48qEy9OBvkigEobMcHWWv5pLqV613iP9LYzWL3ZA3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794890118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z05eBXZtj33QVuPoWyFJ9ACiczNoA+RtpuXMjmRS3N8=;
	b=mpSxxJtVwr2Auy3znSQPNueb/1Y9y8vjV8n9dbtYydAXJys1MP5fajb4J0FM2FDz4yJL
	 gBsSw7oqqzHs9w/X34Cf0zf3ypWhS7RTzFUBMcz6q1cj9rOlljI0s1sZ7Yj6cuOWYZLnQ
	 DC2r1nRlw7qH0FQrnhnKqJou6ZNqZY/5VRTh891mgm0ByFa6cQAtA+J0wW5HHsBE2EWmZ
	 HGFmdKaUpBStOdjOzRrCvvfErT/A66Nu/XE2nEskezuZQEvRc1PE28tnd3mB2hlvf9Efe
	 mjoURz9lBxcCIKj+qEviXBC7CXjFcFZa6u9GGkQxed/4r8WvcQUuyK5sEEAsqvfvDgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WCoq3akY;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16855606A88A
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 04:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16855606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WCoq3akY
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08904845so27012735ad.3
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 20:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794890117; x=1795494917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z05eBXZtj33QVuPoWyFJ9ACiczNoA+RtpuXMjmRS3N8=;
        b=WCoq3akYRAP6Ivzb65Waa9CTV82p4veXdLecmsebPNG1Z9SUIXFQ4923lbNJVbmFsg
         vm4R3SM2zQXTfvqfCGvPrTcvS5vgMXfUKTpfl1PJHcfHemVZgKPAE0ivzjxgllUeIHsZ
         oKgNO5jq269k8A7ow34lTnYbwgLhE+GmKfqUX+w1B1w67IlF7biIE4PoE4gEmFn/Bz5/
         LPsg7QJPDuwDGrZyC0n+qrBpvb4+BUiHTEsVe2jEZGKMFBl6NvlzH45xD1UTlIoBydPV
         RnCf+huVJoHO6xI5F4kFkI7N2mXBZuirzBxCvPifO3tkLM3+2/q1JWAEuGOzuKzSv2Lq
         LULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794890117; x=1795494917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z05eBXZtj33QVuPoWyFJ9ACiczNoA+RtpuXMjmRS3N8=;
        b=Ezuflu3KyvbKjmFrhrSrb7p//HDBT75auypaoPFy31ARMDY/dNtcDQ8IK8cs3hznxP
         P/AwEdpYbYKNGag1seoa6m7kNk80sO3vqxu2hrPUXPVMqYCC5wZulJqaXm1Wm7GSF1VI
         qWBNfvbtWH85YqZL3CGuX2mVXYRphAIwJICfPHz7ubioIhSeYtpBsZ2S6S+qZ9zAqzuU
         GOY0jS6lJo/IgJvT2XMl9EN7KsoMhh2+I/orFAdG/J4Z2glB/5FZDQNyD5SLZb6paIxX
         t4+J181fjLy6hpwc35jOtxoDclZq+5ky0/YC1eQfWlkUnndwqKeIK6pNU3Hssg52paeq
         7WTQ==
X-Forwarded-Encrypted: i=1; AL+hErEBcfO89oeC+b9iS9Udt7AoQYaBXI5k6JH8DssseYe9HJiLqg2/PM/RyLKPFvbYJwxqZs3L8qoakLVTtCW+@vger.kernel.org
X-Gm-Message-State: APuU4Z9u5iT1nv8mytqVMiu7OdVwmaa5VZ719adipsDQgzrvFBZH2e+f
	wFIsXSuLTxQt8u65A7h9MEkKxzJBQV30den+tafIFy6EdIfq/DHmGcAVdCCu9u+HCBXl4DFr6ZW
	c13oiaegqvMUQrGgzRe1IcB8bDQ==
X-Received: from plbju12.prod.google.com ([2002:a17:903:428c:b0:2e8:44b9:5c18])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b50:b0:2ee:1f51:32ea with SMTP id d9443c01a7336-2ee1f513339mr100649615ad.25.1794890117329;
 Mon, 16 Nov 2026 20:35:17 -0800 (PST)
Date: Tue, 17 Nov 2026 04:34:59 +0000
In-Reply-To: <20261117043504.1021063-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117043504.1021063-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117043504.1021063-8-dylanbhatch@google.com>
Subject: [RFC PATCH 07/12] scripts/sorttable: sort .lr_unwind_fde by start_offset
From: Dylan Hatch <dylanbhatch@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Weinan Liu <wnliu@google.com>, 
	Jens Remus <jremus@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-crypto@vger.kernel.org, llvm@lists.linux.dev, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Indu Bhagat <ibhagatgnu@gmail.com>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, live-patching@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

Normalize the PC-relative start_offset word of each 8-byte struct lr_fde
entry in .lr_unwind_fde, qsort by virtual address, and denormalize back
to PC-relative offsets without modifying range_desc.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 scripts/sorttable.c | 50 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 88e49a5c42512..38495c39e404b 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -600,6 +600,37 @@ static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
 static inline int parse_symbols(const char *fname) { return 0; }
 #endif
 
+static int compare_relative_table(const void *a, const void *b)
+{
+	int32_t av = (int32_t)elf_parser.r(a);
+	int32_t bv = (int32_t)elf_parser.r(b);
+
+	if (av < bv)
+		return -1;
+	if (av > bv)
+		return 1;
+	return 0;
+}
+
+static void sort_lr_unwind_fde(char *fde_image, int image_size)
+{
+	int i;
+
+	for (i = 0; i < image_size; i += 8) {
+		uint32_t *loc = (uint32_t *)(fde_image + i);
+
+		elf_parser.w(elf_parser.r(loc) + i, loc);
+	}
+
+	qsort(fde_image, image_size / 8, 8, compare_relative_table);
+
+	for (i = 0; i < image_size; i += 8) {
+		uint32_t *loc = (uint32_t *)(fde_image + i);
+
+		elf_parser.w(elf_parser.r(loc) - i, loc);
+	}
+}
+
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
 		   table_sort_t custom_sort)
@@ -609,6 +640,7 @@ static int do_sort(Elf_Ehdr *ehdr,
 	Elf_Shdr *strtab_sec = NULL;
 	Elf_Shdr *symtab_sec = NULL;
 	Elf_Shdr *extab_sec = NULL;
+	Elf_Shdr *lr_fde_sec = NULL;
 	Elf_Shdr *string_sec;
 	Elf_Sym *sym;
 	const Elf_Sym *symtab;
@@ -656,6 +688,8 @@ static int do_sort(Elf_Ehdr *ehdr,
 		idx = shdr_name(shdr);
 		if (!strcmp(secstrings + idx, "__ex_table"))
 			extab_sec = shdr;
+		if (!strcmp(secstrings + idx, ".lr_unwind_fde"))
+			lr_fde_sec = shdr;
 		if (!strcmp(secstrings + idx, ".symtab"))
 			symtab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".strtab"))
@@ -759,6 +793,10 @@ static int do_sort(Elf_Ehdr *ehdr,
 		      extable_ent_size, compare_extable);
 	}
 
+	if (lr_fde_sec)
+		sort_lr_unwind_fde((char *)ehdr + shdr_offset(lr_fde_sec),
+				   shdr_size(lr_fde_sec));
+
 	/* find the flag main_extable_sort_needed */
 	sym_start = (void *)ehdr + shdr_offset(symtab_sec);
 	sym_end = sym_start + shdr_size(symtab_sec);
@@ -833,18 +871,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 	return rc;
 }
 
-static int compare_relative_table(const void *a, const void *b)
-{
-	int32_t av = (int32_t)elf_parser.r(a);
-	int32_t bv = (int32_t)elf_parser.r(b);
-
-	if (av < bv)
-		return -1;
-	if (av > bv)
-		return 1;
-	return 0;
-}
-
 static void sort_relative_table(char *extab_image, int image_size)
 {
 	int i = 0;
-- 
2.56.0.679.gc527c65306-goog

