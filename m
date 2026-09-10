Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AD3D413C
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030374; cv=none; b=Rmmv/2m/LkQUATptfxwycsvYMxUya9NHhR77Mo7fPDkyKfFGN+JYqTux+Ckkj44C56RNAJLqMpdSTSa4TI/4Pkzgf5RLvo8188b3f8KAy9+hN1cgUalL/VHVymxw2vEjCMyJNCMDukQv939rFfKrO0BRQCMFjZ4we0SyqomVteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030374; c=relaxed/simple;
	bh=rrm13CJYZunrLWG7hU6QetzTbhxmTMu87q02Sg14ElU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKPUPcq/9hWqU3NFRvmXyVouvWZSvExOWIi5aA7iR9Ke+BRr6fjs46xGSx+4H8MHoTcwzMCMUmJ5UYhNux2CDWphqGVV3T7xS+kgOnIenOae9Tx8Q2yAVhYVgSITK5nj5xVR8P+wVZkClhlgmeFs/2XyRMoFEn1/1KHvhrzzpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pF8D03HL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF8D03HL"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so5378818a12.1
        for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789030368; x=1789635168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxcbzpXnDDxrcl2saQVe1hhAk6NoKOLwMsiYrhPEWo0=;
        b=pF8D03HLX9IlLL4+VI82Z1JC/05hD4XKteN1P4N4w9otMJB9jwbhFGOYSxvVl8F49T
         He0zXHAqkev2cXLGPVz0fai5XgC5apwUBEPJB7yLUflqyz9wgNfjXSSiAr2PS4rjr1F2
         y2RIgcWMcZWurKyDpYPs+UfFUAmV89tf6TsaQLBV20RwLuU5KfWCOOwp/p9y+FXakYJk
         IGMyi8nfNHrF78QdvUxi/EzE6PiCT4aMLb0R8hSjMHqvX7dc16uwJl/dXWj567c8L41C
         KRxjtzLP2vWKPkYHn3U5VrQS+PK3xEKPOloi73tR92jewgnRUr1SSLh8xlsHf0nj4CYO
         PPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030368; x=1789635168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxcbzpXnDDxrcl2saQVe1hhAk6NoKOLwMsiYrhPEWo0=;
        b=F1nQLutheMhznMPGvi3uX/HJT01u4aLDliwAuh2mzSYVOq3u61cP3ihyuIQ7Fw5TNz
         iJ86uHYNVFE56VzcH9f292AT/+BIJjRrgypWyYK/xXzlbPA/fswrzC2Z0QAcR0Ylcxpv
         S9TftmtwP2MGNmFYkMDa9KHXU0VdeV41jjKpBZo8VxD/eo8/hf+bUF0HwceqwsWaUjjM
         ISZH2CLIhxIU1vm8DU09v+R/w94r11FvQzptBTGZzlTawqncqRcc8Upk3uQoCdtAT2rU
         pvnT5b+eRFyoVPQl1uy811uymmj+LZe3C9mZZRx0J6olFFochX6/73BWqfXBT2SBJn9J
         iRbw==
X-Forwarded-Encrypted: i=1; AKwUvBxMYhqwU7Gg9AQcXkZ4pQr/gUED+FX/n+RKv9l/Ph952y5z2409Nt1aBLkJE22VzePL5Rpl+DlWGXY1KDG2@vger.kernel.org
X-Gm-Message-State: AFuF++kpnxlBU1Q+YGZYIBiIZxZ8iTbKiXMbbo/o5cgsyArWcUD4Y+zL
	xmQ6GIwFKUPHFH9TpdSlZknTDjLqqdbiNg5EVt+O0DBsS7rTPnDKaVtj
X-Gm-Gg: AYBFou0MRWg6pdcXjXtqHH/0LSjQexKN8uBMZrqk1RlH232kOR/xd3fQMPnRsEO3Sqz
	ea9PRWB3J2XLJcx5gj3MMvcwfNc/+lFXmfiNtYzuDtlmzenkIj5ARgWBDTudpg3VL9TqCRWRxN7
	uxC/8VY13DqMx2dxWv/9zTMulWx36lepCDuNRumBweK649obm7yBhQBMBatwMfFKdtovcnVGWFa
	rWj3n5wbYCOfDk1W6WsmqZzHYkegBYntVBOj8oPDlRG/8fKTJ0ge7BzLiEHgMTlIbw0qQUlBVyc
	nD0Usss+AY27dqnHbz/QZOTG6Gva5ZjZEaEpLUCjNxlaioypLvoCAwYSj22/NzK2+bT5AOsPo4a
	6WS67rZpJPpGz3QJY1wh+wbrOYHler6JudASRtQKz+5mspxDnimcQM4bW9qpwuFC/SfvF/155If
	H7hnBc29Q5WXkCtDBPQ/1NkbcZTVAVphDl2ahif6+/Pe6s6eonq641mX0ZfiEFeVT/V23DgCjli
	VAmj7j/OWEjQhN6rTNMjNs0C4xVChnoDON015GoepBSTdOYPg==
X-Received: by 2002:a17:90b:274c:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39b2629b27fmr62967751a91.23.1789030367765;
        Thu, 10 Sep 2026 01:52:47 -0700 (PDT)
Received: from ANATASLUO-MC0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e3f603dsm3379015a91.2.2026.09.10.01.52.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 01:52:47 -0700 (PDT)
From: Longjun Luo <luolongjuna@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: song@kernel.org,
	jikos@kernel.org,
	pmladek@suse.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longjun Luo <luolongjuna@gmail.com>
Subject: [PATCH] objtool/klp: Fix missed changes to same-named symbol references
Date: Thu, 10 Sep 2026 16:52:18 +0800
Message-ID: <20260910085218.66565-1-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hashing symbol references by demangled_name alone can miss target
changes while the instruction or data bytes and normalized relocation
offsets remain unchanged. This occurs when:

  - A global function moves between files and calls a same-named static
    function with a different implementation.
  - A function's call target changes from a global function to a
    same-named static function, without moving the caller.
  - A data object, such as an ops structure, changes its function pointer
    from a global function to a same-named static function.

These false negatives can silently omit changed functions from a
livepatch or fail to reject changed data.

Hash referenced symbols as (filename, demangled_name) instead. Use an
empty filename when no FILE is associated, and include both terminating
NULs to delimit the fields.

Verified all three cases with klp-build on x86-64: the function cases
produce livepatch modules with the expected target relocations, and the
data case is rejected. Hand-built unchanged-input controls produce
identical checksums. Module loading was not tested.

Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/include/objtool/checksum.h | 27 ++++++++++++++++++++++++
 tools/objtool/klp-checksum.c             | 13 ++++--------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/include/objtool/checksum.h b/tools/objtool/include/objtool/checksum.h
index d46293f54716..1834d34dfd47 100644
--- a/tools/objtool/include/objtool/checksum.h
+++ b/tools/objtool/include/objtool/checksum.h
@@ -20,6 +20,16 @@ static inline void __checksum_update(struct symbol *sym, const void *data,
 	XXH3_64bits_update(sym->csum.state, data, size);
 }
 
+/* Include FILE identity to distinguish same-named local targets. */
+static inline void __checksum_update_symbol_identity(struct symbol *sym,
+						     struct symbol *target)
+{
+	const char *file_name = target->file ? target->file->name : "";
+
+	__checksum_update(sym, file_name, strlen(file_name) + 1);
+	__checksum_update(sym, target->demangled_name, strlen(target->demangled_name) + 1);
+}
+
 static inline void __checksum_update_insn(struct symbol *sym,
 					  struct instruction *insn,
 					  const void *data, size_t size)
@@ -28,6 +38,14 @@ static inline void __checksum_update_insn(struct symbol *sym,
 	dbg_checksum_insn(sym, insn, XXH3_64bits_digest(sym->csum.state));
 }
 
+static inline void __checksum_update_symbol(struct symbol *sym,
+					    struct instruction *insn,
+					    struct symbol *target)
+{
+	__checksum_update_symbol_identity(sym, target);
+	dbg_checksum_insn(sym, insn, XXH3_64bits_digest(sym->csum.state));
+}
+
 static inline void __checksum_update_object(struct symbol *sym,
 					    unsigned long offset,
 					    const char *what, const void *data,
@@ -38,6 +56,15 @@ static inline void __checksum_update_object(struct symbol *sym,
 	dbg_checksum_object(sym, offset, what, XXH3_64bits_digest(sym->csum.state));
 }
 
+static inline void __checksum_update_object_symbol(struct symbol *sym,
+						   unsigned long offset,
+						   struct symbol *target)
+{
+	__checksum_update(sym, &offset, sizeof(offset));
+	__checksum_update_symbol_identity(sym, target);
+	dbg_checksum_object(sym, offset, "reloc name", XXH3_64bits_digest(sym->csum.state));
+}
+
 static inline void checksum_finish(struct symbol *sym)
 {
 	if (sym && sym->csum.state) {
diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index b8e47f28997e..3da3fe11bf76 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -85,8 +85,7 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 			__checksum_update_insn(func, insn, buf, len);
 
 			if (call_dest) {
-				__checksum_update_insn(func, insn, call_dest->demangled_name,
-						       strlen(call_dest->demangled_name));
+				__checksum_update_symbol(func, insn, call_dest);
 
 			} else if (jump_dest) {
 				struct symbol *dest_sym;
@@ -102,8 +101,7 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				if (!dest_sym)
 					goto alts;
 
-				__checksum_update_insn(func, insn, dest_sym->demangled_name,
-						       strlen(dest_sym->demangled_name));
+				__checksum_update_symbol(func, insn, dest_sym);
 
 				offset = jump_dest->offset - dest_sym->offset;
 				__checksum_update_insn(func, insn, &offset, sizeof(offset));
@@ -137,8 +135,7 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		offset -= sym->offset;
 	}
 
-	__checksum_update_insn(func, insn, sym->demangled_name,
-			       strlen(sym->demangled_name));
+	__checksum_update_symbol(func, insn, sym);
 	__checksum_update_insn(func, insn, &offset, sizeof(offset));
 
 alts:
@@ -206,9 +203,7 @@ static void checksum_update_object(struct objtool_file *file, struct symbol *sym
 			offset -= target->offset;
 		}
 
-		__checksum_update_object(sym, sym_offset, "reloc name",
-					 target->demangled_name,
-					 strlen(target->demangled_name));
+		__checksum_update_object_symbol(sym, sym_offset, target);
 		__checksum_update_object(sym, sym_offset, "reloc addend",
 					 &offset, sizeof(offset));
 	}

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.43.7

