Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799181;
	b=pVDlDpuuPmTVF4T+J652/u19ePYKFWWf19/3/IlJ3ou+/9tMFuvut5/32r8QqLGF/yHO
	 1PMaBPrjSgJ28Le0/tX3Kcs9JBY7U2MJ/t2OwU3wKvBLoMNA337foREPs1R1WxKKcrKlx
	 rEK4DisdP5sNwZkAS6rxuC4Q4JXIQs2gKQ3VqtmnJQH5eYBz5jCTrFApOe6A8OwMh6H63
	 Senyk4s0tN1G243sCGdqUdtPN9YYDNw5ntHg0Q4rBg+m25/4RYSCTaDA0QOcdIPCV2JpN
	 x0M4U98h57+K0fMrWTaeV1+vZNNfahrEefap5+w68n/5KpJsJWos6Xu59LpcU4/RYjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BtUDms6tpi+nE+r7gyE10bk7/san5lmoIg9n8+3rKQU=;
	b=TWsPdt6cy7iSftFsEcV7xazEkmrZYN/EH/nck0ai6J4+SFi34r3i00C85Tth43zZMUdJ
	 0luVtgYELJOdtM1X9Iuvzuy/Pc3LZNGQmEF2Jsm75FfvdG2SXi/94bO6Ku1gWIbbupSif
	 LBsuIWqdR9Oui62IDWflcD3an5G5B3jnzc4QbrYlz2VIVI6KSqm3dFiN8wm0K/wJSemvV
	 WzTdK4aJ6KGiuFDFAtSXdIroSOetvPtkL0bNCCumoyp9pCb9UQ13fwBYWLFNRCqmec9XZ
	 xjhbwzPjzMap71hz24PFXXZb/xMwjNkRtvkCmvYUkqPzKrpvwCd9fx2h0w/YIqlZ2jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GcN/LV/H";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B33606A33D
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B33606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GcN/LV/H
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a9f9473029so599852b3a.2
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799181; x=1794403981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BtUDms6tpi+nE+r7gyE10bk7/san5lmoIg9n8+3rKQU=;
        b=GcN/LV/HIH1Xmb868pqPOjrpb1ZToKd5e6dgYQ031twi3fONu777YkAzZj9Fat5e4t
         bGAIC5u3prxkI9e2MbELTA4EZBsMxdXI+bplwcrSn6J42i7/uFfAdmLRtq0AK8Jtnfuq
         1RZPvLJo96gV0jpEleSLW7x0yPsMaYOKXPnLfzek5P+eOlXXOLNGHqQ9fgyGMEJ80SN3
         lhr3nX3U1BhlPjA+e9wbpzemNeuDGkQpNmavbzSoAq9SaSI9T0QuK5bExkvhbTrXZ7K6
         S7HxwMCqdwHsymdE1Ea0o0O/JHP1A1xTs8G4hA3Q6+a7/RYk3BAik5XtZamN6K0DzOqY
         //JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799181; x=1794403981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtUDms6tpi+nE+r7gyE10bk7/san5lmoIg9n8+3rKQU=;
        b=iQLaDcvxrgrhiSlcnZ50kzgrugOebitxvMLHfwm5/at2sUccRgz83I2KZgB4KL9bRq
         Xs3ZThAMNICgXUX217lSS5aSCIrmyS+6aaMVWsjs7bf/qDeG6J4d3sY1LJJypmq6nVWR
         qXRdeqDN29ohoCmHtGcJmQsX9m+NtUUHr/OjjO2D9zyeutCkndIQldyrvp/lpgQcN3JT
         pCN/sQ7MpQmqeq1CYBTc3ssjs1+Dif8w3atmZaqNXKusqvk01q2W/TDJmYjbXSTyp1tG
         dUf7ZxYI+EStzMu+BINBKFpZ98oSrtKzJKCnW6L8YztXa3Tgv/Ay7gt2kl4XGftwdeC4
         BkAw==
X-Forwarded-Encrypted: i=1; AKwUvBxm/M4UPDAtPd8BSEmuBdZF6dMwrpfYAhtPdCZpz8TUGfswuUWXaIElYjN3Fn5Ab3b30fQuPW8xTrS+NzVY@vger.kernel.org
X-Gm-Message-State: APuU4Z+e2yhI6YyiSwd0b2Ig891TKhjbigCfJkQ9pY1b/4NswEhHRABs
	RHnOCY1hWnfdoyCzNbtZFUambEGks/aeastF1AARaCsEruI5fM6dQ2Xb
X-Gm-Gg: AYBFou1fXc2csksc9huG0N8XN7CxxO69Tk0pi2MnVHrLUiMoRB5iOTuLh1yoBd/DW4m
	ngwNRUYVPuGDjYhL6C4gnBHmWQDAtgTNPakqjky3MDWKQFwN5heMZBD5zQKxYxS14sjFgEdJCLh
	Yl6waUq3UFws/IxvqqL7BCmO/tT/JVW+k1i21925eJwINpPQoscPe6AtdqSUoARri926Uw6ckjp
	uW2ramgZGlu76agfIezMvD2y4c37g8ZnU1hI4LFbzWFxeuHXXftvdsn5i0HUAc9ZTdgiZtaAWJo
	K+rUAzToOoIE4uUV9ElfGVa400KD4Yv5NWDbz6T8jief8lAqUuE0Ibmst1y+0Qi7YXC8AkdtlVv
	xHFYc+DNiMDdMk2m9b4JUb/283tKIJTjZyo7947qJG9Y4wHMY0yDtrDu9HNj9Gh+H7NwlOBZHVv
	/o7OEs0v7R9Y4cX/7BsENQ6GilXnG23roTmgCIvcKcTuYuG2i8POqsLRTNpwav/ggIEYsi47ddB
	kw9pI8P5BxlbzKKyeRAltxk1mkGVWO7jjkDMfGPgTWM3BDWUljQxU9At7XHDxBc3tthcqApuXWX
	w5nV8hjZkAocK3gBcGa1dSr4JWRxLSO7BvRBTWI3GuGync4PVA==
X-Received: by 2002:a05:6a00:a229:b0:8a0:76ea:36e1 with SMTP id d2e1a72fcca58-8a9ba229da4mr14126529b3a.7.1793799180837;
        Wed, 04 Nov 2026 05:33:00 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:33:00 -0800 (PST)
From: Longjun Luo <luolongjuna@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org,
	puranjay@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Longjun Luo <luolongjuna@gmail.com>
Subject: [RFC PATCH v2 08/11] objtool/klp: Include symbol identities in reference checksums
Date: Wed,  4 Nov 2026 21:31:54 +0800
Message-ID: <20261104133158.3187525-9-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hashing only the target's suffix-stripped name can hide a reference change
between different objects with the same name.

Prepare DWARF identities for checksum calculation and hash the identity
path for named references. Keep the existing checksum section format and
use suffix-stripped ELF names when no DWARF identity is available.

The three tests rejected by policy in earlier patches remain rejected.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. Only local-to-global-flip, sympos and sympos-vmlinux fail,
reflecting the linkage and duplicate-identity policies.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/klp-checksum.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index 1a5f2fa89baa..44c0eb784e57 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -77,6 +77,12 @@ static bool is_const_reference(struct symbol *sym)
 static int checksum_object(struct objtool_file *file, struct symbol *sym,
 			   unsigned int depth);
 
+/* Use suffix-stripped ELF names for references without DWARF identities. */
+static const char *checksum_name(struct symbol *sym)
+{
+	return sym->identity.path ?: sym->identity.demangled_name;
+}
+
 static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				struct instruction *insn)
 {
@@ -110,8 +116,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 			__checksum_update_insn(func, insn, buf, len);
 
 			if (call_dest) {
-				__checksum_update_insn(func, insn, call_dest->identity.demangled_name,
-						       strlen(call_dest->identity.demangled_name));
+				__checksum_update_insn(func, insn, checksum_name(call_dest),
+						       strlen(checksum_name(call_dest)));
 
 			} else if (jump_dest) {
 				struct symbol *dest_sym;
@@ -127,8 +133,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				if (!dest_sym)
 					goto alts;
 
-				__checksum_update_insn(func, insn, dest_sym->identity.demangled_name,
-						       strlen(dest_sym->identity.demangled_name));
+				__checksum_update_insn(func, insn, checksum_name(dest_sym),
+						       strlen(checksum_name(dest_sym)));
 
 				offset = jump_dest->offset - dest_sym->offset;
 				__checksum_update_insn(func, insn, &offset, sizeof(offset));
@@ -170,8 +176,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		__checksum_update_insn(func, insn, &sym->csum.checksum,
 				       sizeof(sym->csum.checksum));
 	} else {
-		__checksum_update_insn(func, insn, sym->identity.demangled_name,
-				       strlen(sym->identity.demangled_name));
+		__checksum_update_insn(func, insn, checksum_name(sym),
+				       strlen(checksum_name(sym)));
 	}
 	__checksum_update_insn(func, insn, &offset, sizeof(offset));
 
@@ -265,9 +271,9 @@ static int checksum_update_object(struct objtool_file *file, struct symbol *sym,
 						 &target->csum.checksum,
 						 sizeof(target->csum.checksum));
 		} else {
-			__checksum_update_object(sym, sym_offset, "reloc name",
-						 target->identity.demangled_name,
-						 strlen(target->identity.demangled_name));
+			__checksum_update_object(sym, sym_offset, "reloc identity",
+						 checksum_name(target),
+						 strlen(checksum_name(target)));
 		}
 		__checksum_update_object(sym, sym_offset, "reloc addend",
 					 &offset, sizeof(offset));
@@ -387,6 +393,7 @@ static const char * const klp_checksum_usage[] = {
 int cmd_klp_checksum(int argc, const char **argv)
 {
 	struct objtool_file *file;
+	struct symbol *sym;
 	int ret;
 
 	const struct option options[] = {
@@ -411,6 +418,12 @@ int cmd_klp_checksum(int argc, const char **argv)
 	if (ret)
 		goto out;
 
+	for_each_sym(file->elf, sym)
+		sym->dont_correlate = dont_correlate(sym);
+	ret = prepare_identities(file->elf);
+	if (ret)
+		goto out;
+
 	ret = calculate_checksums(file);
 	if (ret)
 		goto out;
-- 
2.55.0

